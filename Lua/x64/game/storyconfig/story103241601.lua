return {
	Play324161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324161001
		arg_1_1.duration_ = 3.2

		local var_1_0 = {
			zh = 2.96666666666667,
			ja = 3.19966666666667
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
				arg_1_0:Play324161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2008"

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
				local var_4_5 = arg_1_1.bgs_.ST2008

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
					if iter_4_0 ~= "ST2008" then
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

			local var_4_24 = "1036ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1036ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1036ui_story == nil then
				arg_1_1.var_.characterEffect1036ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1036ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1036ui_story then
				arg_1_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_4_33 = 0.1
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
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

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_activity_5_0_story_dilao", "bgm_activity_5_0_story_dilao")

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

			local var_4_47 = 1.36666666666667
			local var_4_48 = 0.175

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

				local var_4_50 = arg_1_1:FormatText(StoryNameCfg[1487].name)

				arg_1_1.leftNameTxt_.text = var_4_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_51 = arg_1_1:GetWordFromCfg(324161001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161001", "story_v_out_324161.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_324161", "324161001", "story_v_out_324161.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_324161", "324161001", "story_v_out_324161.awb")

						arg_1_1:RecordAudio("324161001", var_4_57)
						arg_1_1:RecordAudio("324161001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324161", "324161001", "story_v_out_324161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324161", "324161001", "story_v_out_324161.awb")
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
	Play324161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324161002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1036ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1036ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1036ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1036ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1036ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 1.375

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

				local var_11_8 = arg_8_1:GetWordFromCfg(324161002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 55
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
	Play324161003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324161003
		arg_12_1.duration_ = 7.6

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324161004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "J27i"

			if arg_12_1.bgs_[var_15_0] == nil then
				local var_15_1 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_0)
				var_15_1.name = var_15_0
				var_15_1.transform.parent = arg_12_1.stage_.transform
				var_15_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_0] = var_15_1
			end

			local var_15_2 = 0.9

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				local var_15_3 = manager.ui.mainCamera.transform.localPosition
				local var_15_4 = Vector3.New(0, 0, 10) + Vector3.New(var_15_3.x, var_15_3.y, 0)
				local var_15_5 = arg_12_1.bgs_.J27i

				var_15_5.transform.localPosition = var_15_4
				var_15_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_6 = var_15_5:GetComponent("SpriteRenderer")

				if var_15_6 and var_15_6.sprite then
					local var_15_7 = (var_15_5.transform.localPosition - var_15_3).z
					local var_15_8 = manager.ui.mainCameraCom_
					local var_15_9 = 2 * var_15_7 * Mathf.Tan(var_15_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_10 = var_15_9 * var_15_8.aspect
					local var_15_11 = var_15_6.sprite.bounds.size.x
					local var_15_12 = var_15_6.sprite.bounds.size.y
					local var_15_13 = var_15_10 / var_15_11
					local var_15_14 = var_15_9 / var_15_12
					local var_15_15 = var_15_14 < var_15_13 and var_15_13 or var_15_14

					var_15_5.transform.localScale = Vector3.New(var_15_15, var_15_15, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "J27i" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_16 = 0.9

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_17 = 0.3

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_18 = manager.ui.mainCamera.transform
			local var_15_19 = 1.2

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				local var_15_20 = arg_12_1.var_.effect4343
				local var_15_21
				local var_15_22 = var_15_18

				if not var_15_20 then
					var_15_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), var_15_22)
					var_15_20.name = "4343"
					arg_12_1.var_.effect4343 = var_15_20
				else
					var_15_20.transform:SetParent(var_15_22)
				end

				var_15_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_15_23 = 1.7777777777777777
				local var_15_24 = Screen.width / Screen.height
				local var_15_25 = var_15_24 / var_15_23
				local var_15_26 = Mathf.Max(var_15_23 / var_15_24, 1)

				var_15_20.transform.localScale = Vector3.New(var_15_20.transform.localScale.x * var_15_25, var_15_20.transform.localScale.y * var_15_26, var_15_20.transform.localScale.z)
			end

			local var_15_27 = manager.ui.mainCamera.transform
			local var_15_28 = 1.2

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				local var_15_29 = arg_12_1.var_.effect434
				local var_15_30
				local var_15_31 = var_15_27

				if not var_15_29 then
					var_15_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_15_31)
					var_15_29.name = "434"
					arg_12_1.var_.effect434 = var_15_29
				else
					var_15_29.transform:SetParent(var_15_31)
				end

				var_15_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_29.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_15_32 = 1.7777777777777777
				local var_15_33 = Screen.width / Screen.height
				local var_15_34 = var_15_33 / var_15_32
				local var_15_35 = Mathf.Max(var_15_32 / var_15_33, 1)

				var_15_29.transform.localScale = Vector3.New(var_15_29.transform.localScale.x * var_15_34, var_15_29.transform.localScale.y * var_15_35, var_15_29.transform.localScale.z)
			end

			local var_15_36 = manager.ui.mainCamera.transform
			local var_15_37 = 0

			if var_15_37 < arg_12_1.time_ and arg_12_1.time_ <= var_15_37 + arg_15_0 then
				local var_15_38 = arg_12_1.var_.effect41122
				local var_15_39
				local var_15_40 = var_15_36

				if not var_15_38 then
					var_15_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_15_40)
					var_15_38.name = "41122"
					arg_12_1.var_.effect41122 = var_15_38
				else
					var_15_38.transform:SetParent(var_15_40)
				end

				var_15_38.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_38.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_15_41 = 1.7777777777777777
				local var_15_42 = Screen.width / Screen.height
				local var_15_43 = var_15_42 / var_15_41
				local var_15_44 = Mathf.Max(var_15_41 / var_15_42, 1)

				var_15_38.transform.localScale = Vector3.New(var_15_38.transform.localScale.x * var_15_43, var_15_38.transform.localScale.y * var_15_44, var_15_38.transform.localScale.z)
			end

			local var_15_45 = 1

			if var_15_45 < arg_12_1.time_ and arg_12_1.time_ <= var_15_45 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_46 = 2.2

			if arg_12_1.time_ >= var_15_45 + var_15_46 and arg_12_1.time_ < var_15_45 + var_15_46 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_47 = 1.2
			local var_15_48 = 1

			if var_15_47 < arg_12_1.time_ and arg_12_1.time_ <= var_15_47 + arg_15_0 then
				local var_15_49 = "play"
				local var_15_50 = "effect"

				arg_12_1:AudioAction(var_15_49, var_15_50, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_15_51 = 0.1
			local var_15_52 = 1

			if var_15_51 < arg_12_1.time_ and arg_12_1.time_ <= var_15_51 + arg_15_0 then
				local var_15_53 = "stop"
				local var_15_54 = "effect"

				arg_12_1:AudioAction(var_15_53, var_15_54, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_55 = 2.59610799723305
			local var_15_56 = 1.375

			if var_15_55 < arg_12_1.time_ and arg_12_1.time_ <= var_15_55 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_57 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_57:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_58 = arg_12_1:GetWordFromCfg(324161003)
				local var_15_59 = arg_12_1:FormatText(var_15_58.content)

				arg_12_1.text_.text = var_15_59

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_60 = 55
				local var_15_61 = utf8.len(var_15_59)
				local var_15_62 = var_15_60 <= 0 and var_15_56 or var_15_56 * (var_15_61 / var_15_60)

				if var_15_62 > 0 and var_15_56 < var_15_62 then
					arg_12_1.talkMaxDuration = var_15_62
					var_15_55 = var_15_55 + 0.3

					if var_15_62 + var_15_55 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_62 + var_15_55
					end
				end

				arg_12_1.text_.text = var_15_59
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_63 = var_15_55 + 0.3
			local var_15_64 = math.max(var_15_56, arg_12_1.talkMaxDuration)

			if var_15_63 <= arg_12_1.time_ and arg_12_1.time_ < var_15_63 + var_15_64 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_63) / var_15_64

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_63 + var_15_64 and arg_12_1.time_ < var_15_63 + var_15_64 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324161004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 324161004
		arg_18_1.duration_ = 7.73

		local var_18_0 = {
			zh = 5.6666666696469,
			ja = 7.7326666696469
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play324161005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1.4

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				local var_21_1 = manager.ui.mainCamera.transform.localPosition
				local var_21_2 = Vector3.New(0, 0, 10) + Vector3.New(var_21_1.x, var_21_1.y, 0)
				local var_21_3 = arg_18_1.bgs_.ST2008

				var_21_3.transform.localPosition = var_21_2
				var_21_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_4 = var_21_3:GetComponent("SpriteRenderer")

				if var_21_4 and var_21_4.sprite then
					local var_21_5 = (var_21_3.transform.localPosition - var_21_1).z
					local var_21_6 = manager.ui.mainCameraCom_
					local var_21_7 = 2 * var_21_5 * Mathf.Tan(var_21_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_21_8 = var_21_7 * var_21_6.aspect
					local var_21_9 = var_21_4.sprite.bounds.size.x
					local var_21_10 = var_21_4.sprite.bounds.size.y
					local var_21_11 = var_21_8 / var_21_9
					local var_21_12 = var_21_7 / var_21_10
					local var_21_13 = var_21_12 < var_21_11 and var_21_11 or var_21_12

					var_21_3.transform.localScale = Vector3.New(var_21_13, var_21_13, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "ST2008" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_14 = 1.4

			if var_21_14 < arg_18_1.time_ and arg_18_1.time_ <= var_21_14 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_15 = 0.3

			if arg_18_1.time_ >= var_21_14 + var_21_15 and arg_18_1.time_ < var_21_14 + var_21_15 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_16 = 0

			if var_21_16 < arg_18_1.time_ and arg_18_1.time_ <= var_21_16 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_17 = 1.4

			if var_21_16 <= arg_18_1.time_ and arg_18_1.time_ < var_21_16 + var_21_17 then
				local var_21_18 = (arg_18_1.time_ - var_21_16) / var_21_17
				local var_21_19 = Color.New(0, 0, 0)

				var_21_19.a = Mathf.Lerp(0, 1, var_21_18)
				arg_18_1.mask_.color = var_21_19
			end

			if arg_18_1.time_ >= var_21_16 + var_21_17 and arg_18_1.time_ < var_21_16 + var_21_17 + arg_21_0 then
				local var_21_20 = Color.New(0, 0, 0)

				var_21_20.a = 1
				arg_18_1.mask_.color = var_21_20
			end

			local var_21_21 = 1.4

			if var_21_21 < arg_18_1.time_ and arg_18_1.time_ <= var_21_21 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_22 = 2

			if var_21_21 <= arg_18_1.time_ and arg_18_1.time_ < var_21_21 + var_21_22 then
				local var_21_23 = (arg_18_1.time_ - var_21_21) / var_21_22
				local var_21_24 = Color.New(0, 0, 0)

				var_21_24.a = Mathf.Lerp(1, 0, var_21_23)
				arg_18_1.mask_.color = var_21_24
			end

			if arg_18_1.time_ >= var_21_21 + var_21_22 and arg_18_1.time_ < var_21_21 + var_21_22 + arg_21_0 then
				local var_21_25 = Color.New(0, 0, 0)
				local var_21_26 = 0

				arg_18_1.mask_.enabled = false
				var_21_25.a = var_21_26
				arg_18_1.mask_.color = var_21_25
			end

			local var_21_27 = "1054ui_story"

			if arg_18_1.actors_[var_21_27] == nil then
				local var_21_28 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_21_28) then
					local var_21_29 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_18_1.stage_.transform)

					var_21_29.name = var_21_27
					var_21_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_18_1.actors_[var_21_27] = var_21_29

					local var_21_30 = var_21_29:GetComponentInChildren(typeof(CharacterEffect))

					var_21_30.enabled = true

					local var_21_31 = GameObjectTools.GetOrAddComponent(var_21_29, typeof(DynamicBoneHelper))

					if var_21_31 then
						var_21_31:EnableDynamicBone(false)
					end

					arg_18_1:ShowWeapon(var_21_30.transform, false)

					arg_18_1.var_[var_21_27 .. "Animator"] = var_21_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_18_1.var_[var_21_27 .. "Animator"].applyRootMotion = true
					arg_18_1.var_[var_21_27 .. "LipSync"] = var_21_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_21_32 = arg_18_1.actors_["1054ui_story"].transform
			local var_21_33 = 2.96666666666667

			if var_21_33 < arg_18_1.time_ and arg_18_1.time_ <= var_21_33 + arg_21_0 then
				arg_18_1.var_.moveOldPos1054ui_story = var_21_32.localPosition

				local var_21_34 = GameObjectTools.GetOrAddComponent(var_21_32.gameObject, typeof(DynamicBoneHelper))

				if var_21_34 then
					var_21_34:EnableDynamicBone(false)
				end
			end

			local var_21_35 = 0.001

			if var_21_33 <= arg_18_1.time_ and arg_18_1.time_ < var_21_33 + var_21_35 then
				local var_21_36 = (arg_18_1.time_ - var_21_33) / var_21_35
				local var_21_37 = Vector3.New(0, -0.985, -6)

				var_21_32.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1054ui_story, var_21_37, var_21_36)

				local var_21_38 = manager.ui.mainCamera.transform.position - var_21_32.position

				var_21_32.forward = Vector3.New(var_21_38.x, var_21_38.y, var_21_38.z)

				local var_21_39 = var_21_32.localEulerAngles

				var_21_39.z = 0
				var_21_39.x = 0
				var_21_32.localEulerAngles = var_21_39
			end

			if arg_18_1.time_ >= var_21_33 + var_21_35 and arg_18_1.time_ < var_21_33 + var_21_35 + arg_21_0 then
				var_21_32.localPosition = Vector3.New(0, -0.985, -6)

				local var_21_40 = manager.ui.mainCamera.transform.position - var_21_32.position

				var_21_32.forward = Vector3.New(var_21_40.x, var_21_40.y, var_21_40.z)

				local var_21_41 = var_21_32.localEulerAngles

				var_21_41.z = 0
				var_21_41.x = 0
				var_21_32.localEulerAngles = var_21_41

				local var_21_42 = GameObjectTools.GetOrAddComponent(var_21_32.gameObject, typeof(DynamicBoneHelper))

				if var_21_42 then
					var_21_42:EnableDynamicBone(true)
				end
			end

			local var_21_43 = arg_18_1.actors_["1054ui_story"]
			local var_21_44 = 2.96666666666667

			if var_21_44 < arg_18_1.time_ and arg_18_1.time_ <= var_21_44 + arg_21_0 and not isNil(var_21_43) and arg_18_1.var_.characterEffect1054ui_story == nil then
				arg_18_1.var_.characterEffect1054ui_story = var_21_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_45 = 0.200000002980232

			if var_21_44 <= arg_18_1.time_ and arg_18_1.time_ < var_21_44 + var_21_45 and not isNil(var_21_43) then
				local var_21_46 = (arg_18_1.time_ - var_21_44) / var_21_45

				if arg_18_1.var_.characterEffect1054ui_story and not isNil(var_21_43) then
					arg_18_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_44 + var_21_45 and arg_18_1.time_ < var_21_44 + var_21_45 + arg_21_0 and not isNil(var_21_43) and arg_18_1.var_.characterEffect1054ui_story then
				arg_18_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_21_47 = 2.96666666666667

			if var_21_47 < arg_18_1.time_ and arg_18_1.time_ <= var_21_47 + arg_21_0 then
				arg_18_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_21_48 = 2.96666666666667

			if var_21_48 < arg_18_1.time_ and arg_18_1.time_ <= var_21_48 + arg_21_0 then
				arg_18_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_21_49 = manager.ui.mainCamera.transform
			local var_21_50 = 1.4

			if var_21_50 < arg_18_1.time_ and arg_18_1.time_ <= var_21_50 + arg_21_0 then
				local var_21_51 = arg_18_1.var_.effect4343

				if var_21_51 then
					Object.Destroy(var_21_51)

					arg_18_1.var_.effect4343 = nil
				end
			end

			local var_21_52 = manager.ui.mainCamera.transform
			local var_21_53 = 1.4

			if var_21_53 < arg_18_1.time_ and arg_18_1.time_ <= var_21_53 + arg_21_0 then
				local var_21_54 = arg_18_1.var_.effect434

				if var_21_54 then
					Object.Destroy(var_21_54)

					arg_18_1.var_.effect434 = nil
				end
			end

			local var_21_55 = manager.ui.mainCamera.transform
			local var_21_56 = 1.43333333333333

			if var_21_56 < arg_18_1.time_ and arg_18_1.time_ <= var_21_56 + arg_21_0 then
				local var_21_57 = arg_18_1.var_.effect41122

				if var_21_57 then
					Object.Destroy(var_21_57)

					arg_18_1.var_.effect41122 = nil
				end
			end

			local var_21_58 = 1.2
			local var_21_59 = 1

			if var_21_58 < arg_18_1.time_ and arg_18_1.time_ <= var_21_58 + arg_21_0 then
				local var_21_60 = "play"
				local var_21_61 = "effect"

				arg_18_1:AudioAction(var_21_60, var_21_61, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_21_62 = 0.1
			local var_21_63 = 1

			if var_21_62 < arg_18_1.time_ and arg_18_1.time_ <= var_21_62 + arg_21_0 then
				local var_21_64 = "stop"
				local var_21_65 = "effect"

				arg_18_1:AudioAction(var_21_64, var_21_65, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_66 = 3.1666666696469
			local var_21_67 = 0.3

			if var_21_66 < arg_18_1.time_ and arg_18_1.time_ <= var_21_66 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_68 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_68:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_69 = arg_18_1:FormatText(StoryNameCfg[1487].name)

				arg_18_1.leftNameTxt_.text = var_21_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_70 = arg_18_1:GetWordFromCfg(324161004)
				local var_21_71 = arg_18_1:FormatText(var_21_70.content)

				arg_18_1.text_.text = var_21_71

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_72 = 12
				local var_21_73 = utf8.len(var_21_71)
				local var_21_74 = var_21_72 <= 0 and var_21_67 or var_21_67 * (var_21_73 / var_21_72)

				if var_21_74 > 0 and var_21_67 < var_21_74 then
					arg_18_1.talkMaxDuration = var_21_74
					var_21_66 = var_21_66 + 0.3

					if var_21_74 + var_21_66 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_74 + var_21_66
					end
				end

				arg_18_1.text_.text = var_21_71
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161004", "story_v_out_324161.awb") ~= 0 then
					local var_21_75 = manager.audio:GetVoiceLength("story_v_out_324161", "324161004", "story_v_out_324161.awb") / 1000

					if var_21_75 + var_21_66 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_75 + var_21_66
					end

					if var_21_70.prefab_name ~= "" and arg_18_1.actors_[var_21_70.prefab_name] ~= nil then
						local var_21_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_70.prefab_name].transform, "story_v_out_324161", "324161004", "story_v_out_324161.awb")

						arg_18_1:RecordAudio("324161004", var_21_76)
						arg_18_1:RecordAudio("324161004", var_21_76)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_324161", "324161004", "story_v_out_324161.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_324161", "324161004", "story_v_out_324161.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_77 = var_21_66 + 0.3
			local var_21_78 = math.max(var_21_67, arg_18_1.talkMaxDuration)

			if var_21_77 <= arg_18_1.time_ and arg_18_1.time_ < var_21_77 + var_21_78 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_77) / var_21_78

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_77 + var_21_78 and arg_18_1.time_ < var_21_77 + var_21_78 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play324161005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324161005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324161006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1054ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1054ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1054ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_8 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_8.x, var_27_8.y, var_27_8.z)

				local var_27_9 = var_27_0.localEulerAngles

				var_27_9.z = 0
				var_27_9.x = 0
				var_27_0.localEulerAngles = var_27_9

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["1054ui_story"]
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_13 = 0.200000002980232

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_13 and not isNil(var_27_11) then
				local var_27_14 = (arg_24_1.time_ - var_27_12) / var_27_13

				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_11) then
					local var_27_15 = Mathf.Lerp(0, 0.5, var_27_14)

					arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1054ui_story.fillRatio = var_27_15
				end
			end

			if arg_24_1.time_ >= var_27_12 + var_27_13 and arg_24_1.time_ < var_27_12 + var_27_13 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect1054ui_story then
				local var_27_16 = 0.5

				arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1054ui_story.fillRatio = var_27_16
			end

			local var_27_17 = 0
			local var_27_18 = 0.725

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_19 = arg_24_1:GetWordFromCfg(324161005)
				local var_27_20 = arg_24_1:FormatText(var_27_19.content)

				arg_24_1.text_.text = var_27_20

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_21 = 29
				local var_27_22 = utf8.len(var_27_20)
				local var_27_23 = var_27_21 <= 0 and var_27_18 or var_27_18 * (var_27_22 / var_27_21)

				if var_27_23 > 0 and var_27_18 < var_27_23 then
					arg_24_1.talkMaxDuration = var_27_23

					if var_27_23 + var_27_17 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_23 + var_27_17
					end
				end

				arg_24_1.text_.text = var_27_20
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_24 = math.max(var_27_18, arg_24_1.talkMaxDuration)

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_24 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_17) / var_27_24

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_17 + var_27_24 and arg_24_1.time_ < var_27_17 + var_27_24 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play324161006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324161006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324161007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.1
			local var_31_1 = 1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				local var_31_2 = "play"
				local var_31_3 = "effect"

				arg_28_1:AudioAction(var_31_2, var_31_3, "se_story_side_1028", "se_story_1028_warning", "")
			end

			local var_31_4 = 0
			local var_31_5 = 1.175

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(324161006)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_8 = 47
				local var_31_9 = utf8.len(var_31_7)
				local var_31_10 = var_31_8 <= 0 and var_31_5 or var_31_5 * (var_31_9 / var_31_8)

				if var_31_10 > 0 and var_31_5 < var_31_10 then
					arg_28_1.talkMaxDuration = var_31_10

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_11 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_11 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_11

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_11 and arg_28_1.time_ < var_31_4 + var_31_11 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324161007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324161007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324161008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.825

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(324161007)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 33
				local var_35_5 = utf8.len(var_35_3)
				local var_35_6 = var_35_4 <= 0 and var_35_1 or var_35_1 * (var_35_5 / var_35_4)

				if var_35_6 > 0 and var_35_1 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_7 and arg_32_1.time_ < var_35_0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324161008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324161008
		arg_36_1.duration_ = 6.27

		local var_36_0 = {
			zh = 5.166,
			ja = 6.266
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
				arg_36_0:Play324161009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1054ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, -0.985, -6)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["1054ui_story"]
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_13 = 0.200000002980232

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 and not isNil(var_39_11) then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13

				if arg_36_1.var_.characterEffect1054ui_story and not isNil(var_39_11) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_39_15 = 0

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_39_16 = 0

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_17 = 0
			local var_39_18 = 0.475

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_19 = arg_36_1:FormatText(StoryNameCfg[1487].name)

				arg_36_1.leftNameTxt_.text = var_39_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_20 = arg_36_1:GetWordFromCfg(324161008)
				local var_39_21 = arg_36_1:FormatText(var_39_20.content)

				arg_36_1.text_.text = var_39_21

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_22 = 19
				local var_39_23 = utf8.len(var_39_21)
				local var_39_24 = var_39_22 <= 0 and var_39_18 or var_39_18 * (var_39_23 / var_39_22)

				if var_39_24 > 0 and var_39_18 < var_39_24 then
					arg_36_1.talkMaxDuration = var_39_24

					if var_39_24 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_17
					end
				end

				arg_36_1.text_.text = var_39_21
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161008", "story_v_out_324161.awb") ~= 0 then
					local var_39_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161008", "story_v_out_324161.awb") / 1000

					if var_39_25 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_25 + var_39_17
					end

					if var_39_20.prefab_name ~= "" and arg_36_1.actors_[var_39_20.prefab_name] ~= nil then
						local var_39_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_20.prefab_name].transform, "story_v_out_324161", "324161008", "story_v_out_324161.awb")

						arg_36_1:RecordAudio("324161008", var_39_26)
						arg_36_1:RecordAudio("324161008", var_39_26)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324161", "324161008", "story_v_out_324161.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324161", "324161008", "story_v_out_324161.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_27 = math.max(var_39_18, arg_36_1.talkMaxDuration)

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_27 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_27

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_27 and arg_36_1.time_ < var_39_17 + var_39_27 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play324161009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324161009
		arg_40_1.duration_ = 5.5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324161010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1054ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = var_43_0.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_3 then
				local var_43_4 = (arg_40_1.time_ - var_43_1) / var_43_3
				local var_43_5 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, var_43_5, var_43_4)

				local var_43_6 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_6.x, var_43_6.y, var_43_6.z)

				local var_43_7 = var_43_0.localEulerAngles

				var_43_7.z = 0
				var_43_7.x = 0
				var_43_0.localEulerAngles = var_43_7
			end

			if arg_40_1.time_ >= var_43_1 + var_43_3 and arg_40_1.time_ < var_43_1 + var_43_3 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_8 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_8.x, var_43_8.y, var_43_8.z)

				local var_43_9 = var_43_0.localEulerAngles

				var_43_9.z = 0
				var_43_9.x = 0
				var_43_0.localEulerAngles = var_43_9

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = arg_40_1.actors_["1054ui_story"]
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_13 = 0.200000002980232

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_13 and not isNil(var_43_11) then
				local var_43_14 = (arg_40_1.time_ - var_43_12) / var_43_13

				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_11) then
					local var_43_15 = Mathf.Lerp(0, 0.5, var_43_14)

					arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1054ui_story.fillRatio = var_43_15
				end
			end

			if arg_40_1.time_ >= var_43_12 + var_43_13 and arg_40_1.time_ < var_43_12 + var_43_13 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect1054ui_story then
				local var_43_16 = 0.5

				arg_40_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1054ui_story.fillRatio = var_43_16
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_17 = 0.5
			local var_43_18 = 1.025

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_19 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_19:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_20 = arg_40_1:GetWordFromCfg(324161009)
				local var_43_21 = arg_40_1:FormatText(var_43_20.content)

				arg_40_1.text_.text = var_43_21

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_22 = 41
				local var_43_23 = utf8.len(var_43_21)
				local var_43_24 = var_43_22 <= 0 and var_43_18 or var_43_18 * (var_43_23 / var_43_22)

				if var_43_24 > 0 and var_43_18 < var_43_24 then
					arg_40_1.talkMaxDuration = var_43_24
					var_43_17 = var_43_17 + 0.3

					if var_43_24 + var_43_17 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_24 + var_43_17
					end
				end

				arg_40_1.text_.text = var_43_21
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = var_43_17 + 0.3
			local var_43_26 = math.max(var_43_18, arg_40_1.talkMaxDuration)

			if var_43_25 <= arg_40_1.time_ and arg_40_1.time_ < var_43_25 + var_43_26 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_25) / var_43_26

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_25 + var_43_26 and arg_40_1.time_ < var_43_25 + var_43_26 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.7,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play324161010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324161010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play324161011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.75

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_2 = arg_46_1:GetWordFromCfg(324161010)
				local var_49_3 = arg_46_1:FormatText(var_49_2.content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 30
				local var_49_5 = utf8.len(var_49_3)
				local var_49_6 = var_49_4 <= 0 and var_49_1 or var_49_1 * (var_49_5 / var_49_4)

				if var_49_6 > 0 and var_49_1 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_7 and arg_46_1.time_ < var_49_0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play324161011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324161011
		arg_50_1.duration_ = 7.27

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play324161012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.733333333333333

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				local var_53_1 = manager.ui.mainCamera.transform.localPosition
				local var_53_2 = Vector3.New(0, 0, 10) + Vector3.New(var_53_1.x, var_53_1.y, 0)
				local var_53_3 = arg_50_1.bgs_.J27i

				var_53_3.transform.localPosition = var_53_2
				var_53_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_4 = var_53_3:GetComponent("SpriteRenderer")

				if var_53_4 and var_53_4.sprite then
					local var_53_5 = (var_53_3.transform.localPosition - var_53_1).z
					local var_53_6 = manager.ui.mainCameraCom_
					local var_53_7 = 2 * var_53_5 * Mathf.Tan(var_53_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_53_8 = var_53_7 * var_53_6.aspect
					local var_53_9 = var_53_4.sprite.bounds.size.x
					local var_53_10 = var_53_4.sprite.bounds.size.y
					local var_53_11 = var_53_8 / var_53_9
					local var_53_12 = var_53_7 / var_53_10
					local var_53_13 = var_53_12 < var_53_11 and var_53_11 or var_53_12

					var_53_3.transform.localScale = Vector3.New(var_53_13, var_53_13, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "J27i" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_14 = 0

			if var_53_14 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			local var_53_15 = 0.3

			if arg_50_1.time_ >= var_53_14 + var_53_15 and arg_50_1.time_ < var_53_14 + var_53_15 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			local var_53_16 = manager.ui.mainCamera.transform
			local var_53_17 = 1.2

			if var_53_17 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				local var_53_18 = arg_50_1.var_.effect43439
				local var_53_19
				local var_53_20 = var_53_16

				if not var_53_18 then
					var_53_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), var_53_20)
					var_53_18.name = "43439"
					arg_50_1.var_.effect43439 = var_53_18
				else
					var_53_18.transform:SetParent(var_53_20)
				end

				var_53_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_53_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_53_21 = manager.ui.mainCamera.transform
			local var_53_22 = 1.2

			if var_53_22 < arg_50_1.time_ and arg_50_1.time_ <= var_53_22 + arg_53_0 then
				local var_53_23 = arg_50_1.var_.effect4349
				local var_53_24
				local var_53_25 = var_53_21

				if not var_53_23 then
					var_53_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_53_25)
					var_53_23.name = "4349"
					arg_50_1.var_.effect4349 = var_53_23
				else
					var_53_23.transform:SetParent(var_53_25)
				end

				var_53_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_53_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_53_26 = manager.ui.mainCamera.transform
			local var_53_27 = 0

			if var_53_27 < arg_50_1.time_ and arg_50_1.time_ <= var_53_27 + arg_53_0 then
				local var_53_28 = arg_50_1.var_.effect411229
				local var_53_29
				local var_53_30 = var_53_26

				if not var_53_28 then
					var_53_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_53_30)
					var_53_28.name = "411229"
					arg_50_1.var_.effect411229 = var_53_28
				else
					var_53_28.transform:SetParent(var_53_30)
				end

				var_53_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_53_28.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_53_31 = 1.7777777777777777
				local var_53_32 = Screen.width / Screen.height
				local var_53_33 = var_53_32 / var_53_31
				local var_53_34 = Mathf.Max(var_53_31 / var_53_32, 1)

				var_53_28.transform.localScale = Vector3.New(var_53_28.transform.localScale.x * var_53_33, var_53_28.transform.localScale.y * var_53_34, var_53_28.transform.localScale.z)
			end

			local var_53_35 = manager.ui.mainCamera.transform
			local var_53_36 = 1.53333333333333

			if var_53_36 < arg_50_1.time_ and arg_50_1.time_ <= var_53_36 + arg_53_0 then
				local var_53_37 = arg_50_1.var_.effect411229

				if var_53_37 then
					Object.Destroy(var_53_37)

					arg_50_1.var_.effect411229 = nil
				end
			end

			local var_53_38 = 1

			if var_53_38 < arg_50_1.time_ and arg_50_1.time_ <= var_53_38 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			local var_53_39 = 1.26666666666667

			if arg_50_1.time_ >= var_53_38 + var_53_39 and arg_50_1.time_ < var_53_38 + var_53_39 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			local var_53_40 = 1.2
			local var_53_41 = 1

			if var_53_40 < arg_50_1.time_ and arg_50_1.time_ <= var_53_40 + arg_53_0 then
				local var_53_42 = "play"
				local var_53_43 = "effect"

				arg_50_1:AudioAction(var_53_42, var_53_43, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_53_44 = 0.1
			local var_53_45 = 1

			if var_53_44 < arg_50_1.time_ and arg_50_1.time_ <= var_53_44 + arg_53_0 then
				local var_53_46 = "stop"
				local var_53_47 = "effect"

				arg_50_1:AudioAction(var_53_46, var_53_47, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_48 = 2.26666666666667
			local var_53_49 = 1.25

			if var_53_48 < arg_50_1.time_ and arg_50_1.time_ <= var_53_48 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_50 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_50:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_50_1.dialogCg_.alpha = arg_54_0
				end))
				var_53_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_51 = arg_50_1:GetWordFromCfg(324161011)
				local var_53_52 = arg_50_1:FormatText(var_53_51.content)

				arg_50_1.text_.text = var_53_52

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_53 = 50
				local var_53_54 = utf8.len(var_53_52)
				local var_53_55 = var_53_53 <= 0 and var_53_49 or var_53_49 * (var_53_54 / var_53_53)

				if var_53_55 > 0 and var_53_49 < var_53_55 then
					arg_50_1.talkMaxDuration = var_53_55
					var_53_48 = var_53_48 + 0.3

					if var_53_55 + var_53_48 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_55 + var_53_48
					end
				end

				arg_50_1.text_.text = var_53_52
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_56 = var_53_48 + 0.3
			local var_53_57 = math.max(var_53_49, arg_50_1.talkMaxDuration)

			if var_53_56 <= arg_50_1.time_ and arg_50_1.time_ < var_53_56 + var_53_57 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_56) / var_53_57

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_56 + var_53_57 and arg_50_1.time_ < var_53_56 + var_53_57 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play324161012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324161012
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324161013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1.35

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(324161012)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 54
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324161013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324161013
		arg_60_1.duration_ = 2.7

		local var_60_0 = {
			zh = 1.966,
			ja = 2.7
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
				arg_60_0:Play324161014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1054ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_63_4 = 0
			local var_63_5 = 0.225

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_6 = arg_60_1:FormatText(StoryNameCfg[1487].name)

				arg_60_1.leftNameTxt_.text = var_63_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_7 = arg_60_1:GetWordFromCfg(324161013)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 9
				local var_63_10 = utf8.len(var_63_8)
				local var_63_11 = var_63_9 <= 0 and var_63_5 or var_63_5 * (var_63_10 / var_63_9)

				if var_63_11 > 0 and var_63_5 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161013", "story_v_out_324161.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161013", "story_v_out_324161.awb") / 1000

					if var_63_12 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_4
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_324161", "324161013", "story_v_out_324161.awb")

						arg_60_1:RecordAudio("324161013", var_63_13)
						arg_60_1:RecordAudio("324161013", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324161", "324161013", "story_v_out_324161.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324161", "324161013", "story_v_out_324161.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_14 and arg_60_1.time_ < var_63_4 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324161014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324161014
		arg_64_1.duration_ = 5.87

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324161015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1054ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1054ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1054ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1054ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0.1
			local var_67_7 = 1

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				local var_67_8 = "play"
				local var_67_9 = "effect"

				arg_64_1:AudioAction(var_67_8, var_67_9, "se_story_140", "se_story_140_explosion01", "")
			end

			local var_67_10 = manager.ui.mainCamera.transform
			local var_67_11 = 0.1

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				local var_67_12 = arg_64_1.var_.effect43243
				local var_67_13
				local var_67_14 = var_67_10

				if not var_67_12 then
					var_67_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_67_14)
					var_67_12.name = "43243"
					arg_64_1.var_.effect43243 = var_67_12
				else
					var_67_12.transform:SetParent(var_67_14)
				end

				var_67_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_67_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_67_15 = manager.ui.mainCamera.transform
			local var_67_16 = 1.26666666666667

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				local var_67_17 = arg_64_1.var_.effect43243

				if var_67_17 then
					Object.Destroy(var_67_17)

					arg_64_1.var_.effect43243 = nil
				end
			end

			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_19 = 1.36666666666667

			if arg_64_1.time_ >= var_67_18 + var_67_19 and arg_64_1.time_ < var_67_18 + var_67_19 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_20 = 0.866666666666667
			local var_67_21 = 1.575

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_22 = arg_64_1:GetWordFromCfg(324161014)
				local var_67_23 = arg_64_1:FormatText(var_67_22.content)

				arg_64_1.text_.text = var_67_23

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_24 = 63
				local var_67_25 = utf8.len(var_67_23)
				local var_67_26 = var_67_24 <= 0 and var_67_21 or var_67_21 * (var_67_25 / var_67_24)

				if var_67_26 > 0 and var_67_21 < var_67_26 then
					arg_64_1.talkMaxDuration = var_67_26

					if var_67_26 + var_67_20 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_26 + var_67_20
					end
				end

				arg_64_1.text_.text = var_67_23
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_27 = math.max(var_67_21, arg_64_1.talkMaxDuration)

			if var_67_20 <= arg_64_1.time_ and arg_64_1.time_ < var_67_20 + var_67_27 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_20) / var_67_27

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_20 + var_67_27 and arg_64_1.time_ < var_67_20 + var_67_27 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play324161015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324161015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324161016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.05

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(324161015)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 42
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play324161016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324161016
		arg_72_1.duration_ = 5.23

		local var_72_0 = {
			zh = 4.59933333333333,
			ja = 5.23333333333333
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
				arg_72_0:Play324161017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.1

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				local var_75_1 = manager.ui.mainCamera.transform.localPosition
				local var_75_2 = Vector3.New(0, 0, 10) + Vector3.New(var_75_1.x, var_75_1.y, 0)
				local var_75_3 = arg_72_1.bgs_.ST2008

				var_75_3.transform.localPosition = var_75_2
				var_75_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_4 = var_75_3:GetComponent("SpriteRenderer")

				if var_75_4 and var_75_4.sprite then
					local var_75_5 = (var_75_3.transform.localPosition - var_75_1).z
					local var_75_6 = manager.ui.mainCameraCom_
					local var_75_7 = 2 * var_75_5 * Mathf.Tan(var_75_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_75_8 = var_75_7 * var_75_6.aspect
					local var_75_9 = var_75_4.sprite.bounds.size.x
					local var_75_10 = var_75_4.sprite.bounds.size.y
					local var_75_11 = var_75_8 / var_75_9
					local var_75_12 = var_75_7 / var_75_10
					local var_75_13 = var_75_12 < var_75_11 and var_75_11 or var_75_12

					var_75_3.transform.localScale = Vector3.New(var_75_13, var_75_13, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "ST2008" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_14 = arg_72_1.actors_["1054ui_story"].transform
			local var_75_15 = 2.66666666666667

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.var_.moveOldPos1054ui_story = var_75_14.localPosition

				local var_75_16 = GameObjectTools.GetOrAddComponent(var_75_14.gameObject, typeof(DynamicBoneHelper))

				if var_75_16 then
					var_75_16:EnableDynamicBone(false)
				end
			end

			local var_75_17 = 0.001

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_17 then
				local var_75_18 = (arg_72_1.time_ - var_75_15) / var_75_17
				local var_75_19 = Vector3.New(0, -0.985, -6)

				var_75_14.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1054ui_story, var_75_19, var_75_18)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_14.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_14.localEulerAngles = var_75_21
			end

			if arg_72_1.time_ >= var_75_15 + var_75_17 and arg_72_1.time_ < var_75_15 + var_75_17 + arg_75_0 then
				var_75_14.localPosition = Vector3.New(0, -0.985, -6)

				local var_75_22 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_22.x, var_75_22.y, var_75_22.z)

				local var_75_23 = var_75_14.localEulerAngles

				var_75_23.z = 0
				var_75_23.x = 0
				var_75_14.localEulerAngles = var_75_23

				local var_75_24 = GameObjectTools.GetOrAddComponent(var_75_14.gameObject, typeof(DynamicBoneHelper))

				if var_75_24 then
					var_75_24:EnableDynamicBone(true)
				end
			end

			local var_75_25 = arg_72_1.actors_["1054ui_story"]
			local var_75_26 = 2.56666666666667

			if var_75_26 < arg_72_1.time_ and arg_72_1.time_ <= var_75_26 + arg_75_0 and not isNil(var_75_25) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = var_75_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_27 = 0.200000002980232

			if var_75_26 <= arg_72_1.time_ and arg_72_1.time_ < var_75_26 + var_75_27 and not isNil(var_75_25) then
				local var_75_28 = (arg_72_1.time_ - var_75_26) / var_75_27

				if arg_72_1.var_.characterEffect1054ui_story and not isNil(var_75_25) then
					arg_72_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_26 + var_75_27 and arg_72_1.time_ < var_75_26 + var_75_27 + arg_75_0 and not isNil(var_75_25) and arg_72_1.var_.characterEffect1054ui_story then
				arg_72_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_75_29 = 2.566666666666

			if var_75_29 < arg_72_1.time_ and arg_72_1.time_ <= var_75_29 + arg_75_0 then
				arg_72_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_75_30 = 2.56666666666667

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_75_31 = manager.ui.mainCamera.transform
			local var_75_32 = 1.1

			if var_75_32 < arg_72_1.time_ and arg_72_1.time_ <= var_75_32 + arg_75_0 then
				local var_75_33 = arg_72_1.var_.effect43439

				if var_75_33 then
					Object.Destroy(var_75_33)

					arg_72_1.var_.effect43439 = nil
				end
			end

			local var_75_34 = manager.ui.mainCamera.transform
			local var_75_35 = 1.1

			if var_75_35 < arg_72_1.time_ and arg_72_1.time_ <= var_75_35 + arg_75_0 then
				local var_75_36 = arg_72_1.var_.effect4349

				if var_75_36 then
					Object.Destroy(var_75_36)

					arg_72_1.var_.effect4349 = nil
				end
			end

			local var_75_37 = manager.ui.mainCamera.transform
			local var_75_38 = 0.6

			if var_75_38 < arg_72_1.time_ and arg_72_1.time_ <= var_75_38 + arg_75_0 then
				local var_75_39 = arg_72_1.var_.effect411229

				if var_75_39 then
					Object.Destroy(var_75_39)

					arg_72_1.var_.effect411229 = nil
				end
			end

			local var_75_40 = manager.ui.mainCamera.transform
			local var_75_41 = 2.83333333333333

			if var_75_41 < arg_72_1.time_ and arg_72_1.time_ <= var_75_41 + arg_75_0 then
				local var_75_42 = arg_72_1.var_.effect411229

				if var_75_42 then
					Object.Destroy(var_75_42)

					arg_72_1.var_.effect411229 = nil
				end
			end

			local var_75_43 = 1.3

			if var_75_43 < arg_72_1.time_ and arg_72_1.time_ <= var_75_43 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_44 = 1.26666666666667

			if arg_72_1.time_ >= var_75_43 + var_75_44 and arg_72_1.time_ < var_75_43 + var_75_44 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_45 = 0

			if var_75_45 < arg_72_1.time_ and arg_72_1.time_ <= var_75_45 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_46 = 1.1

			if var_75_45 <= arg_72_1.time_ and arg_72_1.time_ < var_75_45 + var_75_46 then
				local var_75_47 = (arg_72_1.time_ - var_75_45) / var_75_46
				local var_75_48 = Color.New(0, 0, 0)

				var_75_48.a = Mathf.Lerp(0, 1, var_75_47)
				arg_72_1.mask_.color = var_75_48
			end

			if arg_72_1.time_ >= var_75_45 + var_75_46 and arg_72_1.time_ < var_75_45 + var_75_46 + arg_75_0 then
				local var_75_49 = Color.New(0, 0, 0)

				var_75_49.a = 1
				arg_72_1.mask_.color = var_75_49
			end

			local var_75_50 = 1.1

			if var_75_50 < arg_72_1.time_ and arg_72_1.time_ <= var_75_50 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_51 = 1.1

			if var_75_50 <= arg_72_1.time_ and arg_72_1.time_ < var_75_50 + var_75_51 then
				local var_75_52 = (arg_72_1.time_ - var_75_50) / var_75_51
				local var_75_53 = Color.New(0, 0, 0)

				var_75_53.a = Mathf.Lerp(1, 0, var_75_52)
				arg_72_1.mask_.color = var_75_53
			end

			if arg_72_1.time_ >= var_75_50 + var_75_51 and arg_72_1.time_ < var_75_50 + var_75_51 + arg_75_0 then
				local var_75_54 = Color.New(0, 0, 0)
				local var_75_55 = 0

				arg_72_1.mask_.enabled = false
				var_75_54.a = var_75_55
				arg_72_1.mask_.color = var_75_54
			end

			local var_75_56 = 1.2
			local var_75_57 = 1

			if var_75_56 < arg_72_1.time_ and arg_72_1.time_ <= var_75_56 + arg_75_0 then
				local var_75_58 = "play"
				local var_75_59 = "effect"

				arg_72_1:AudioAction(var_75_58, var_75_59, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_75_60 = 0.1
			local var_75_61 = 1

			if var_75_60 < arg_72_1.time_ and arg_72_1.time_ <= var_75_60 + arg_75_0 then
				local var_75_62 = "stop"
				local var_75_63 = "effect"

				arg_72_1:AudioAction(var_75_62, var_75_63, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_64 = 2.83333333333333
			local var_75_65 = 0.175

			if var_75_64 < arg_72_1.time_ and arg_72_1.time_ <= var_75_64 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_66 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_66:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_67 = arg_72_1:FormatText(StoryNameCfg[1487].name)

				arg_72_1.leftNameTxt_.text = var_75_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_68 = arg_72_1:GetWordFromCfg(324161016)
				local var_75_69 = arg_72_1:FormatText(var_75_68.content)

				arg_72_1.text_.text = var_75_69

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_70 = 7
				local var_75_71 = utf8.len(var_75_69)
				local var_75_72 = var_75_70 <= 0 and var_75_65 or var_75_65 * (var_75_71 / var_75_70)

				if var_75_72 > 0 and var_75_65 < var_75_72 then
					arg_72_1.talkMaxDuration = var_75_72
					var_75_64 = var_75_64 + 0.3

					if var_75_72 + var_75_64 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_72 + var_75_64
					end
				end

				arg_72_1.text_.text = var_75_69
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161016", "story_v_out_324161.awb") ~= 0 then
					local var_75_73 = manager.audio:GetVoiceLength("story_v_out_324161", "324161016", "story_v_out_324161.awb") / 1000

					if var_75_73 + var_75_64 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_73 + var_75_64
					end

					if var_75_68.prefab_name ~= "" and arg_72_1.actors_[var_75_68.prefab_name] ~= nil then
						local var_75_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_68.prefab_name].transform, "story_v_out_324161", "324161016", "story_v_out_324161.awb")

						arg_72_1:RecordAudio("324161016", var_75_74)
						arg_72_1:RecordAudio("324161016", var_75_74)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324161", "324161016", "story_v_out_324161.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324161", "324161016", "story_v_out_324161.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_75 = var_75_64 + 0.3
			local var_75_76 = math.max(var_75_65, arg_72_1.talkMaxDuration)

			if var_75_75 <= arg_72_1.time_ and arg_72_1.time_ < var_75_75 + var_75_76 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_75) / var_75_76

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_75 + var_75_76 and arg_72_1.time_ < var_75_75 + var_75_76 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play324161017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324161017
		arg_78_1.duration_ = 3.4

		local var_78_0 = {
			zh = 1.966,
			ja = 3.4
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
				arg_78_0:Play324161018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.2

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[1487].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(324161017)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161017", "story_v_out_324161.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161017", "story_v_out_324161.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_324161", "324161017", "story_v_out_324161.awb")

						arg_78_1:RecordAudio("324161017", var_81_9)
						arg_78_1:RecordAudio("324161017", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324161", "324161017", "story_v_out_324161.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324161", "324161017", "story_v_out_324161.awb")
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
	Play324161018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324161018
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324161019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1054ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1054ui_story = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(0, 100, 0)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1054ui_story, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, 100, 0)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = arg_82_1.actors_["1054ui_story"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1054ui_story == nil then
				arg_82_1.var_.characterEffect1054ui_story = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.200000002980232

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect1054ui_story and not isNil(var_85_11) then
					local var_85_15 = Mathf.Lerp(0, 0.5, var_85_14)

					arg_82_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1054ui_story.fillRatio = var_85_15
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1054ui_story then
				local var_85_16 = 0.5

				arg_82_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1054ui_story.fillRatio = var_85_16
			end

			local var_85_17 = 0
			local var_85_18 = 1.125

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_19 = arg_82_1:GetWordFromCfg(324161018)
				local var_85_20 = arg_82_1:FormatText(var_85_19.content)

				arg_82_1.text_.text = var_85_20

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_21 = 45
				local var_85_22 = utf8.len(var_85_20)
				local var_85_23 = var_85_21 <= 0 and var_85_18 or var_85_18 * (var_85_22 / var_85_21)

				if var_85_23 > 0 and var_85_18 < var_85_23 then
					arg_82_1.talkMaxDuration = var_85_23

					if var_85_23 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_17
					end
				end

				arg_82_1.text_.text = var_85_20
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_24 = math.max(var_85_18, arg_82_1.talkMaxDuration)

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_24 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_17) / var_85_24

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_17 + var_85_24 and arg_82_1.time_ < var_85_17 + var_85_24 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play324161019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324161019
		arg_86_1.duration_ = 4.27

		local var_86_0 = {
			zh = 4.266,
			ja = 3.966
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
				arg_86_0:Play324161020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1054ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = var_89_0.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_3 then
				local var_89_4 = (arg_86_1.time_ - var_89_1) / var_89_3
				local var_89_5 = Vector3.New(0, -0.985, -6)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, var_89_5, var_89_4)

				local var_89_6 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_6.x, var_89_6.y, var_89_6.z)

				local var_89_7 = var_89_0.localEulerAngles

				var_89_7.z = 0
				var_89_7.x = 0
				var_89_0.localEulerAngles = var_89_7
			end

			if arg_86_1.time_ >= var_89_1 + var_89_3 and arg_86_1.time_ < var_89_1 + var_89_3 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_89_8 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_8.x, var_89_8.y, var_89_8.z)

				local var_89_9 = var_89_0.localEulerAngles

				var_89_9.z = 0
				var_89_9.x = 0
				var_89_0.localEulerAngles = var_89_9

				local var_89_10 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_10 then
					var_89_10:EnableDynamicBone(true)
				end
			end

			local var_89_11 = arg_86_1.actors_["1054ui_story"]
			local var_89_12 = 0

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect1054ui_story == nil then
				arg_86_1.var_.characterEffect1054ui_story = var_89_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_13 = 0.200000002980232

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_13 and not isNil(var_89_11) then
				local var_89_14 = (arg_86_1.time_ - var_89_12) / var_89_13

				if arg_86_1.var_.characterEffect1054ui_story and not isNil(var_89_11) then
					arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_12 + var_89_13 and arg_86_1.time_ < var_89_12 + var_89_13 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect1054ui_story then
				arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_89_15 = 0

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_89_16 = 0

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_89_17 = 0
			local var_89_18 = 0.45

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_19 = arg_86_1:FormatText(StoryNameCfg[1487].name)

				arg_86_1.leftNameTxt_.text = var_89_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_20 = arg_86_1:GetWordFromCfg(324161019)
				local var_89_21 = arg_86_1:FormatText(var_89_20.content)

				arg_86_1.text_.text = var_89_21

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_22 = 18
				local var_89_23 = utf8.len(var_89_21)
				local var_89_24 = var_89_22 <= 0 and var_89_18 or var_89_18 * (var_89_23 / var_89_22)

				if var_89_24 > 0 and var_89_18 < var_89_24 then
					arg_86_1.talkMaxDuration = var_89_24

					if var_89_24 + var_89_17 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_24 + var_89_17
					end
				end

				arg_86_1.text_.text = var_89_21
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161019", "story_v_out_324161.awb") ~= 0 then
					local var_89_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161019", "story_v_out_324161.awb") / 1000

					if var_89_25 + var_89_17 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_25 + var_89_17
					end

					if var_89_20.prefab_name ~= "" and arg_86_1.actors_[var_89_20.prefab_name] ~= nil then
						local var_89_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_20.prefab_name].transform, "story_v_out_324161", "324161019", "story_v_out_324161.awb")

						arg_86_1:RecordAudio("324161019", var_89_26)
						arg_86_1:RecordAudio("324161019", var_89_26)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_324161", "324161019", "story_v_out_324161.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_324161", "324161019", "story_v_out_324161.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_27 = math.max(var_89_18, arg_86_1.talkMaxDuration)

			if var_89_17 <= arg_86_1.time_ and arg_86_1.time_ < var_89_17 + var_89_27 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_17) / var_89_27

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_17 + var_89_27 and arg_86_1.time_ < var_89_17 + var_89_27 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play324161020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324161020
		arg_90_1.duration_ = 5.63

		local var_90_0 = {
			zh = 5.633,
			ja = 3.833
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
				arg_90_0:Play324161021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.625

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[1487].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(324161020)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161020", "story_v_out_324161.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161020", "story_v_out_324161.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_324161", "324161020", "story_v_out_324161.awb")

						arg_90_1:RecordAudio("324161020", var_93_9)
						arg_90_1:RecordAudio("324161020", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_324161", "324161020", "story_v_out_324161.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_324161", "324161020", "story_v_out_324161.awb")
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
	Play324161021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324161021
		arg_94_1.duration_ = 7.37

		local var_94_0 = {
			zh = 5.766,
			ja = 7.366
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
				arg_94_0:Play324161022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.7

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[1487].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(324161021)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161021", "story_v_out_324161.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161021", "story_v_out_324161.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_324161", "324161021", "story_v_out_324161.awb")

						arg_94_1:RecordAudio("324161021", var_97_9)
						arg_94_1:RecordAudio("324161021", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324161", "324161021", "story_v_out_324161.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324161", "324161021", "story_v_out_324161.awb")
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
	Play324161022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324161022
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324161023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_101_1 = 0
			local var_101_2 = 0.05

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_3 = arg_98_1:FormatText(StoryNameCfg[1487].name)

				arg_98_1.leftNameTxt_.text = var_101_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_4 = arg_98_1:GetWordFromCfg(324161022)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 2
				local var_101_7 = utf8.len(var_101_5)
				local var_101_8 = var_101_6 <= 0 and var_101_2 or var_101_2 * (var_101_7 / var_101_6)

				if var_101_8 > 0 and var_101_2 < var_101_8 then
					arg_98_1.talkMaxDuration = var_101_8

					if var_101_8 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161022", "story_v_out_324161.awb") ~= 0 then
					local var_101_9 = manager.audio:GetVoiceLength("story_v_out_324161", "324161022", "story_v_out_324161.awb") / 1000

					if var_101_9 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_1
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_out_324161", "324161022", "story_v_out_324161.awb")

						arg_98_1:RecordAudio("324161022", var_101_10)
						arg_98_1:RecordAudio("324161022", var_101_10)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324161", "324161022", "story_v_out_324161.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324161", "324161022", "story_v_out_324161.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_11 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_11 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_11

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_11 and arg_98_1.time_ < var_101_1 + var_101_11 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324161023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324161023
		arg_102_1.duration_ = 2.5

		local var_102_0 = {
			zh = 2.233,
			ja = 2.5
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
				arg_102_0:Play324161024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1054ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1054ui_story = var_105_0.localPosition

				local var_105_2 = GameObjectTools.GetOrAddComponent(var_105_0.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(false)
				end
			end

			local var_105_3 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_3 then
				local var_105_4 = (arg_102_1.time_ - var_105_1) / var_105_3
				local var_105_5 = Vector3.New(0, -0.985, -6)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1054ui_story, var_105_5, var_105_4)

				local var_105_6 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_6.x, var_105_6.y, var_105_6.z)

				local var_105_7 = var_105_0.localEulerAngles

				var_105_7.z = 0
				var_105_7.x = 0
				var_105_0.localEulerAngles = var_105_7
			end

			if arg_102_1.time_ >= var_105_1 + var_105_3 and arg_102_1.time_ < var_105_1 + var_105_3 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_105_8 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_8.x, var_105_8.y, var_105_8.z)

				local var_105_9 = var_105_0.localEulerAngles

				var_105_9.z = 0
				var_105_9.x = 0
				var_105_0.localEulerAngles = var_105_9

				local var_105_10 = GameObjectTools.GetOrAddComponent(var_105_0.gameObject, typeof(DynamicBoneHelper))

				if var_105_10 then
					var_105_10:EnableDynamicBone(true)
				end
			end

			local var_105_11 = "1037ui_story"

			if arg_102_1.actors_[var_105_11] == nil then
				local var_105_12 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_105_12) then
					local var_105_13 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_102_1.stage_.transform)

					var_105_13.name = var_105_11
					var_105_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_102_1.actors_[var_105_11] = var_105_13

					local var_105_14 = var_105_13:GetComponentInChildren(typeof(CharacterEffect))

					var_105_14.enabled = true

					local var_105_15 = GameObjectTools.GetOrAddComponent(var_105_13, typeof(DynamicBoneHelper))

					if var_105_15 then
						var_105_15:EnableDynamicBone(false)
					end

					arg_102_1:ShowWeapon(var_105_14.transform, false)

					arg_102_1.var_[var_105_11 .. "Animator"] = var_105_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_102_1.var_[var_105_11 .. "Animator"].applyRootMotion = true
					arg_102_1.var_[var_105_11 .. "LipSync"] = var_105_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_105_16 = arg_102_1.actors_["1037ui_story"].transform
			local var_105_17 = 0

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.var_.moveOldPos1037ui_story = var_105_16.localPosition
			end

			local var_105_18 = 0.001

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_18 then
				local var_105_19 = (arg_102_1.time_ - var_105_17) / var_105_18
				local var_105_20 = Vector3.New(0, 100, 0)

				var_105_16.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1037ui_story, var_105_20, var_105_19)

				local var_105_21 = manager.ui.mainCamera.transform.position - var_105_16.position

				var_105_16.forward = Vector3.New(var_105_21.x, var_105_21.y, var_105_21.z)

				local var_105_22 = var_105_16.localEulerAngles

				var_105_22.z = 0
				var_105_22.x = 0
				var_105_16.localEulerAngles = var_105_22
			end

			if arg_102_1.time_ >= var_105_17 + var_105_18 and arg_102_1.time_ < var_105_17 + var_105_18 + arg_105_0 then
				var_105_16.localPosition = Vector3.New(0, 100, 0)

				local var_105_23 = manager.ui.mainCamera.transform.position - var_105_16.position

				var_105_16.forward = Vector3.New(var_105_23.x, var_105_23.y, var_105_23.z)

				local var_105_24 = var_105_16.localEulerAngles

				var_105_24.z = 0
				var_105_24.x = 0
				var_105_16.localEulerAngles = var_105_24
			end

			local var_105_25 = arg_102_1.actors_["1037ui_story"]
			local var_105_26 = 0

			if var_105_26 < arg_102_1.time_ and arg_102_1.time_ <= var_105_26 + arg_105_0 and not isNil(var_105_25) and arg_102_1.var_.characterEffect1037ui_story == nil then
				arg_102_1.var_.characterEffect1037ui_story = var_105_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_27 = 0.200000002980232

			if var_105_26 <= arg_102_1.time_ and arg_102_1.time_ < var_105_26 + var_105_27 and not isNil(var_105_25) then
				local var_105_28 = (arg_102_1.time_ - var_105_26) / var_105_27

				if arg_102_1.var_.characterEffect1037ui_story and not isNil(var_105_25) then
					arg_102_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_26 + var_105_27 and arg_102_1.time_ < var_105_26 + var_105_27 + arg_105_0 and not isNil(var_105_25) and arg_102_1.var_.characterEffect1037ui_story then
				arg_102_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_105_29 = arg_102_1.actors_["1054ui_story"]
			local var_105_30 = 0

			if var_105_30 < arg_102_1.time_ and arg_102_1.time_ <= var_105_30 + arg_105_0 and not isNil(var_105_29) and arg_102_1.var_.characterEffect1054ui_story == nil then
				arg_102_1.var_.characterEffect1054ui_story = var_105_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_31 = 0.200000002980232

			if var_105_30 <= arg_102_1.time_ and arg_102_1.time_ < var_105_30 + var_105_31 and not isNil(var_105_29) then
				local var_105_32 = (arg_102_1.time_ - var_105_30) / var_105_31

				if arg_102_1.var_.characterEffect1054ui_story and not isNil(var_105_29) then
					local var_105_33 = Mathf.Lerp(0, 0.5, var_105_32)

					arg_102_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1054ui_story.fillRatio = var_105_33
				end
			end

			if arg_102_1.time_ >= var_105_30 + var_105_31 and arg_102_1.time_ < var_105_30 + var_105_31 + arg_105_0 and not isNil(var_105_29) and arg_102_1.var_.characterEffect1054ui_story then
				local var_105_34 = 0.5

				arg_102_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1054ui_story.fillRatio = var_105_34
			end

			local var_105_35 = "6148ui_story"

			if arg_102_1.actors_[var_105_35] == nil then
				local var_105_36 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_105_36) then
					local var_105_37 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_102_1.stage_.transform)

					var_105_37.name = var_105_35
					var_105_37.transform.localPosition = Vector3.New(0, 100, 0)
					arg_102_1.actors_[var_105_35] = var_105_37

					local var_105_38 = var_105_37:GetComponentInChildren(typeof(CharacterEffect))

					var_105_38.enabled = true

					local var_105_39 = GameObjectTools.GetOrAddComponent(var_105_37, typeof(DynamicBoneHelper))

					if var_105_39 then
						var_105_39:EnableDynamicBone(false)
					end

					arg_102_1:ShowWeapon(var_105_38.transform, false)

					arg_102_1.var_[var_105_35 .. "Animator"] = var_105_38.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_102_1.var_[var_105_35 .. "Animator"].applyRootMotion = true
					arg_102_1.var_[var_105_35 .. "LipSync"] = var_105_38.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_105_40 = 0

			if var_105_40 < arg_102_1.time_ and arg_102_1.time_ <= var_105_40 + arg_105_0 then
				arg_102_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_105_41 = 0

			if var_105_41 < arg_102_1.time_ and arg_102_1.time_ <= var_105_41 + arg_105_0 then
				arg_102_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_105_42 = 0
			local var_105_43 = 0.25

			if var_105_42 < arg_102_1.time_ and arg_102_1.time_ <= var_105_42 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_44 = arg_102_1:FormatText(StoryNameCfg[1488].name)

				arg_102_1.leftNameTxt_.text = var_105_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_102_1.callingController_:SetSelectedState("calling")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_45 = arg_102_1:GetWordFromCfg(324161023)
				local var_105_46 = arg_102_1:FormatText(var_105_45.content)

				arg_102_1.text_.text = var_105_46

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_47 = 10
				local var_105_48 = utf8.len(var_105_46)
				local var_105_49 = var_105_47 <= 0 and var_105_43 or var_105_43 * (var_105_48 / var_105_47)

				if var_105_49 > 0 and var_105_43 < var_105_49 then
					arg_102_1.talkMaxDuration = var_105_49

					if var_105_49 + var_105_42 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_49 + var_105_42
					end
				end

				arg_102_1.text_.text = var_105_46
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161023", "story_v_out_324161.awb") ~= 0 then
					local var_105_50 = manager.audio:GetVoiceLength("story_v_out_324161", "324161023", "story_v_out_324161.awb") / 1000

					if var_105_50 + var_105_42 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_50 + var_105_42
					end

					if var_105_45.prefab_name ~= "" and arg_102_1.actors_[var_105_45.prefab_name] ~= nil then
						local var_105_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_45.prefab_name].transform, "story_v_out_324161", "324161023", "story_v_out_324161.awb")

						arg_102_1:RecordAudio("324161023", var_105_51)
						arg_102_1:RecordAudio("324161023", var_105_51)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324161", "324161023", "story_v_out_324161.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324161", "324161023", "story_v_out_324161.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_52 = math.max(var_105_43, arg_102_1.talkMaxDuration)

			if var_105_42 <= arg_102_1.time_ and arg_102_1.time_ < var_105_42 + var_105_52 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_42) / var_105_52

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_42 + var_105_52 and arg_102_1.time_ < var_105_42 + var_105_52 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play324161024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324161024
		arg_106_1.duration_ = 1.8

		local var_106_0 = {
			zh = 1,
			ja = 1.8
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
				arg_106_0:Play324161025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1054ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1054ui_story == nil then
				arg_106_1.var_.characterEffect1054ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1054ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1054ui_story then
				arg_106_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["1037ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1037ui_story == nil then
				arg_106_1.var_.characterEffect1037ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.200000002980232

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect1037ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1037ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1037ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1037ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0
			local var_109_11 = 0.05

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_12 = arg_106_1:FormatText(StoryNameCfg[1487].name)

				arg_106_1.leftNameTxt_.text = var_109_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_13 = arg_106_1:GetWordFromCfg(324161024)
				local var_109_14 = arg_106_1:FormatText(var_109_13.content)

				arg_106_1.text_.text = var_109_14

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_15 = 2
				local var_109_16 = utf8.len(var_109_14)
				local var_109_17 = var_109_15 <= 0 and var_109_11 or var_109_11 * (var_109_16 / var_109_15)

				if var_109_17 > 0 and var_109_11 < var_109_17 then
					arg_106_1.talkMaxDuration = var_109_17

					if var_109_17 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_17 + var_109_10
					end
				end

				arg_106_1.text_.text = var_109_14
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161024", "story_v_out_324161.awb") ~= 0 then
					local var_109_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161024", "story_v_out_324161.awb") / 1000

					if var_109_18 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_18 + var_109_10
					end

					if var_109_13.prefab_name ~= "" and arg_106_1.actors_[var_109_13.prefab_name] ~= nil then
						local var_109_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_13.prefab_name].transform, "story_v_out_324161", "324161024", "story_v_out_324161.awb")

						arg_106_1:RecordAudio("324161024", var_109_19)
						arg_106_1:RecordAudio("324161024", var_109_19)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_324161", "324161024", "story_v_out_324161.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_324161", "324161024", "story_v_out_324161.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_20 = math.max(var_109_11, arg_106_1.talkMaxDuration)

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_20 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_10) / var_109_20

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_10 + var_109_20 and arg_106_1.time_ < var_109_10 + var_109_20 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324161025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324161025
		arg_110_1.duration_ = 4.33

		local var_110_0 = {
			zh = 4.333,
			ja = 3.766
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
				arg_110_0:Play324161026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1037ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1037ui_story == nil then
				arg_110_1.var_.characterEffect1037ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1037ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1037ui_story then
				arg_110_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1054ui_story"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1054ui_story == nil then
				arg_110_1.var_.characterEffect1054ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.200000002980232

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.characterEffect1054ui_story and not isNil(var_113_4) then
					local var_113_8 = Mathf.Lerp(0, 0.5, var_113_7)

					arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1054ui_story.fillRatio = var_113_8
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1054ui_story then
				local var_113_9 = 0.5

				arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1054ui_story.fillRatio = var_113_9
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_113_11 = 0

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_113_12 = 0
			local var_113_13 = 0.6

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_14 = arg_110_1:FormatText(StoryNameCfg[1488].name)

				arg_110_1.leftNameTxt_.text = var_113_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_110_1.callingController_:SetSelectedState("calling")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_15 = arg_110_1:GetWordFromCfg(324161025)
				local var_113_16 = arg_110_1:FormatText(var_113_15.content)

				arg_110_1.text_.text = var_113_16

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 24
				local var_113_18 = utf8.len(var_113_16)
				local var_113_19 = var_113_17 <= 0 and var_113_13 or var_113_13 * (var_113_18 / var_113_17)

				if var_113_19 > 0 and var_113_13 < var_113_19 then
					arg_110_1.talkMaxDuration = var_113_19

					if var_113_19 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_12
					end
				end

				arg_110_1.text_.text = var_113_16
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161025", "story_v_out_324161.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_324161", "324161025", "story_v_out_324161.awb") / 1000

					if var_113_20 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_12
					end

					if var_113_15.prefab_name ~= "" and arg_110_1.actors_[var_113_15.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_15.prefab_name].transform, "story_v_out_324161", "324161025", "story_v_out_324161.awb")

						arg_110_1:RecordAudio("324161025", var_113_21)
						arg_110_1:RecordAudio("324161025", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324161", "324161025", "story_v_out_324161.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324161", "324161025", "story_v_out_324161.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = math.max(var_113_13, arg_110_1.talkMaxDuration)

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_22 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_12) / var_113_22

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_12 + var_113_22 and arg_110_1.time_ < var_113_12 + var_113_22 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324161026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324161026
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324161027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1054ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1054ui_story = var_117_0.localPosition

				local var_117_2 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(false)
				end
			end

			local var_117_3 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_3 then
				local var_117_4 = (arg_114_1.time_ - var_117_1) / var_117_3
				local var_117_5 = Vector3.New(0, 100, 0)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1054ui_story, var_117_5, var_117_4)

				local var_117_6 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_6.x, var_117_6.y, var_117_6.z)

				local var_117_7 = var_117_0.localEulerAngles

				var_117_7.z = 0
				var_117_7.x = 0
				var_117_0.localEulerAngles = var_117_7
			end

			if arg_114_1.time_ >= var_117_1 + var_117_3 and arg_114_1.time_ < var_117_1 + var_117_3 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, 100, 0)

				local var_117_8 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_8.x, var_117_8.y, var_117_8.z)

				local var_117_9 = var_117_0.localEulerAngles

				var_117_9.z = 0
				var_117_9.x = 0
				var_117_0.localEulerAngles = var_117_9

				local var_117_10 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_10 then
					var_117_10:EnableDynamicBone(true)
				end
			end

			local var_117_11 = arg_114_1.actors_["1037ui_story"].transform
			local var_117_12 = 0

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.var_.moveOldPos1037ui_story = var_117_11.localPosition
			end

			local var_117_13 = 0.001

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_13 then
				local var_117_14 = (arg_114_1.time_ - var_117_12) / var_117_13
				local var_117_15 = Vector3.New(0, 100, 0)

				var_117_11.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1037ui_story, var_117_15, var_117_14)

				local var_117_16 = manager.ui.mainCamera.transform.position - var_117_11.position

				var_117_11.forward = Vector3.New(var_117_16.x, var_117_16.y, var_117_16.z)

				local var_117_17 = var_117_11.localEulerAngles

				var_117_17.z = 0
				var_117_17.x = 0
				var_117_11.localEulerAngles = var_117_17
			end

			if arg_114_1.time_ >= var_117_12 + var_117_13 and arg_114_1.time_ < var_117_12 + var_117_13 + arg_117_0 then
				var_117_11.localPosition = Vector3.New(0, 100, 0)

				local var_117_18 = manager.ui.mainCamera.transform.position - var_117_11.position

				var_117_11.forward = Vector3.New(var_117_18.x, var_117_18.y, var_117_18.z)

				local var_117_19 = var_117_11.localEulerAngles

				var_117_19.z = 0
				var_117_19.x = 0
				var_117_11.localEulerAngles = var_117_19
			end

			local var_117_20 = arg_114_1.actors_["1037ui_story"]
			local var_117_21 = 0

			if var_117_21 < arg_114_1.time_ and arg_114_1.time_ <= var_117_21 + arg_117_0 and not isNil(var_117_20) and arg_114_1.var_.characterEffect1037ui_story == nil then
				arg_114_1.var_.characterEffect1037ui_story = var_117_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_22 = 0.200000002980232

			if var_117_21 <= arg_114_1.time_ and arg_114_1.time_ < var_117_21 + var_117_22 and not isNil(var_117_20) then
				local var_117_23 = (arg_114_1.time_ - var_117_21) / var_117_22

				if arg_114_1.var_.characterEffect1037ui_story and not isNil(var_117_20) then
					local var_117_24 = Mathf.Lerp(0, 0.5, var_117_23)

					arg_114_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1037ui_story.fillRatio = var_117_24
				end
			end

			if arg_114_1.time_ >= var_117_21 + var_117_22 and arg_114_1.time_ < var_117_21 + var_117_22 + arg_117_0 and not isNil(var_117_20) and arg_114_1.var_.characterEffect1037ui_story then
				local var_117_25 = 0.5

				arg_114_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1037ui_story.fillRatio = var_117_25
			end

			local var_117_26 = 0
			local var_117_27 = 0.775

			if var_117_26 < arg_114_1.time_ and arg_114_1.time_ <= var_117_26 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_28 = arg_114_1:GetWordFromCfg(324161026)
				local var_117_29 = arg_114_1:FormatText(var_117_28.content)

				arg_114_1.text_.text = var_117_29

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_30 = 31
				local var_117_31 = utf8.len(var_117_29)
				local var_117_32 = var_117_30 <= 0 and var_117_27 or var_117_27 * (var_117_31 / var_117_30)

				if var_117_32 > 0 and var_117_27 < var_117_32 then
					arg_114_1.talkMaxDuration = var_117_32

					if var_117_32 + var_117_26 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_32 + var_117_26
					end
				end

				arg_114_1.text_.text = var_117_29
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_33 = math.max(var_117_27, arg_114_1.talkMaxDuration)

			if var_117_26 <= arg_114_1.time_ and arg_114_1.time_ < var_117_26 + var_117_33 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_26) / var_117_33

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_26 + var_117_33 and arg_114_1.time_ < var_117_26 + var_117_33 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play324161027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324161027
		arg_118_1.duration_ = 7.37

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324161028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 1.36666666666667

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				local var_121_1 = manager.ui.mainCamera.transform.localPosition
				local var_121_2 = Vector3.New(0, 0, 10) + Vector3.New(var_121_1.x, var_121_1.y, 0)
				local var_121_3 = arg_118_1.bgs_.J27i

				var_121_3.transform.localPosition = var_121_2
				var_121_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_4 = var_121_3:GetComponent("SpriteRenderer")

				if var_121_4 and var_121_4.sprite then
					local var_121_5 = (var_121_3.transform.localPosition - var_121_1).z
					local var_121_6 = manager.ui.mainCameraCom_
					local var_121_7 = 2 * var_121_5 * Mathf.Tan(var_121_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_121_8 = var_121_7 * var_121_6.aspect
					local var_121_9 = var_121_4.sprite.bounds.size.x
					local var_121_10 = var_121_4.sprite.bounds.size.y
					local var_121_11 = var_121_8 / var_121_9
					local var_121_12 = var_121_7 / var_121_10
					local var_121_13 = var_121_12 < var_121_11 and var_121_11 or var_121_12

					var_121_3.transform.localScale = Vector3.New(var_121_13, var_121_13, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "J27i" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			local var_121_15 = 0.3

			if arg_118_1.time_ >= var_121_14 + var_121_15 and arg_118_1.time_ < var_121_14 + var_121_15 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_16 = 0

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_17 = 1.36666666666667

			if var_121_16 <= arg_118_1.time_ and arg_118_1.time_ < var_121_16 + var_121_17 then
				local var_121_18 = (arg_118_1.time_ - var_121_16) / var_121_17
				local var_121_19 = Color.New(0, 0, 0)

				var_121_19.a = Mathf.Lerp(0, 1, var_121_18)
				arg_118_1.mask_.color = var_121_19
			end

			if arg_118_1.time_ >= var_121_16 + var_121_17 and arg_118_1.time_ < var_121_16 + var_121_17 + arg_121_0 then
				local var_121_20 = Color.New(0, 0, 0)

				var_121_20.a = 1
				arg_118_1.mask_.color = var_121_20
			end

			local var_121_21 = 1.36666666666667

			if var_121_21 < arg_118_1.time_ and arg_118_1.time_ <= var_121_21 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_22 = 1.26666666666567

			if var_121_21 <= arg_118_1.time_ and arg_118_1.time_ < var_121_21 + var_121_22 then
				local var_121_23 = (arg_118_1.time_ - var_121_21) / var_121_22
				local var_121_24 = Color.New(0, 0, 0)

				var_121_24.a = Mathf.Lerp(1, 0, var_121_23)
				arg_118_1.mask_.color = var_121_24
			end

			if arg_118_1.time_ >= var_121_21 + var_121_22 and arg_118_1.time_ < var_121_21 + var_121_22 + arg_121_0 then
				local var_121_25 = Color.New(0, 0, 0)
				local var_121_26 = 0

				arg_118_1.mask_.enabled = false
				var_121_25.a = var_121_26
				arg_118_1.mask_.color = var_121_25
			end

			local var_121_27 = 1.2
			local var_121_28 = 1

			if var_121_27 < arg_118_1.time_ and arg_118_1.time_ <= var_121_27 + arg_121_0 then
				local var_121_29 = "play"
				local var_121_30 = "effect"

				arg_118_1:AudioAction(var_121_29, var_121_30, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_121_31 = 0.1
			local var_121_32 = 1

			if var_121_31 < arg_118_1.time_ and arg_118_1.time_ <= var_121_31 + arg_121_0 then
				local var_121_33 = "stop"
				local var_121_34 = "effect"

				arg_118_1:AudioAction(var_121_33, var_121_34, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_35 = 2.36666666666667
			local var_121_36 = 1.5

			if var_121_35 < arg_118_1.time_ and arg_118_1.time_ <= var_121_35 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_37 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_37:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_38 = arg_118_1:GetWordFromCfg(324161027)
				local var_121_39 = arg_118_1:FormatText(var_121_38.content)

				arg_118_1.text_.text = var_121_39

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_40 = 60
				local var_121_41 = utf8.len(var_121_39)
				local var_121_42 = var_121_40 <= 0 and var_121_36 or var_121_36 * (var_121_41 / var_121_40)

				if var_121_42 > 0 and var_121_36 < var_121_42 then
					arg_118_1.talkMaxDuration = var_121_42
					var_121_35 = var_121_35 + 0.3

					if var_121_42 + var_121_35 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_42 + var_121_35
					end
				end

				arg_118_1.text_.text = var_121_39
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_43 = var_121_35 + 0.3
			local var_121_44 = math.max(var_121_36, arg_118_1.talkMaxDuration)

			if var_121_43 <= arg_118_1.time_ and arg_118_1.time_ < var_121_43 + var_121_44 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_43) / var_121_44

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_43 + var_121_44 and arg_118_1.time_ < var_121_43 + var_121_44 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324161028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324161028
		arg_124_1.duration_ = 2.97

		local var_124_0 = {
			zh = 2.966,
			ja = 2.4
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
				arg_124_0:Play324161029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1054ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1054ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(0, -0.985, -6)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1054ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, -0.985, -6)

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

			local var_127_11 = arg_124_1.actors_["1054ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1054ui_story == nil then
				arg_124_1.var_.characterEffect1054ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.200000002980232

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect1054ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1054ui_story then
				arg_124_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_127_15 = 0

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action8_1")
			end

			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_127_17 = 0
			local var_127_18 = 0.15

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_19 = arg_124_1:FormatText(StoryNameCfg[1487].name)

				arg_124_1.leftNameTxt_.text = var_127_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_20 = arg_124_1:GetWordFromCfg(324161028)
				local var_127_21 = arg_124_1:FormatText(var_127_20.content)

				arg_124_1.text_.text = var_127_21

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_22 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161028", "story_v_out_324161.awb") ~= 0 then
					local var_127_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161028", "story_v_out_324161.awb") / 1000

					if var_127_25 + var_127_17 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_25 + var_127_17
					end

					if var_127_20.prefab_name ~= "" and arg_124_1.actors_[var_127_20.prefab_name] ~= nil then
						local var_127_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_20.prefab_name].transform, "story_v_out_324161", "324161028", "story_v_out_324161.awb")

						arg_124_1:RecordAudio("324161028", var_127_26)
						arg_124_1:RecordAudio("324161028", var_127_26)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324161", "324161028", "story_v_out_324161.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324161", "324161028", "story_v_out_324161.awb")
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
				actorName = "1054ui_story",
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
	Play324161029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324161029
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324161030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1054ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1054ui_story = var_131_0.localPosition

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end
			end

			local var_131_3 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_3 then
				local var_131_4 = (arg_128_1.time_ - var_131_1) / var_131_3
				local var_131_5 = Vector3.New(0, 100, 0)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1054ui_story, var_131_5, var_131_4)

				local var_131_6 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_6.x, var_131_6.y, var_131_6.z)

				local var_131_7 = var_131_0.localEulerAngles

				var_131_7.z = 0
				var_131_7.x = 0
				var_131_0.localEulerAngles = var_131_7
			end

			if arg_128_1.time_ >= var_131_1 + var_131_3 and arg_128_1.time_ < var_131_1 + var_131_3 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, 100, 0)

				local var_131_8 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_8.x, var_131_8.y, var_131_8.z)

				local var_131_9 = var_131_0.localEulerAngles

				var_131_9.z = 0
				var_131_9.x = 0
				var_131_0.localEulerAngles = var_131_9

				local var_131_10 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_10 then
					var_131_10:EnableDynamicBone(true)
				end
			end

			local var_131_11 = arg_128_1.actors_["1054ui_story"]
			local var_131_12 = 0

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect1054ui_story == nil then
				arg_128_1.var_.characterEffect1054ui_story = var_131_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_13 = 0.200000002980232

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_13 and not isNil(var_131_11) then
				local var_131_14 = (arg_128_1.time_ - var_131_12) / var_131_13

				if arg_128_1.var_.characterEffect1054ui_story and not isNil(var_131_11) then
					local var_131_15 = Mathf.Lerp(0, 0.5, var_131_14)

					arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1054ui_story.fillRatio = var_131_15
				end
			end

			if arg_128_1.time_ >= var_131_12 + var_131_13 and arg_128_1.time_ < var_131_12 + var_131_13 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect1054ui_story then
				local var_131_16 = 0.5

				arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1054ui_story.fillRatio = var_131_16
			end

			local var_131_17 = 0
			local var_131_18 = 0.8

			if var_131_17 < arg_128_1.time_ and arg_128_1.time_ <= var_131_17 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_19 = arg_128_1:GetWordFromCfg(324161029)
				local var_131_20 = arg_128_1:FormatText(var_131_19.content)

				arg_128_1.text_.text = var_131_20

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_21 = 32
				local var_131_22 = utf8.len(var_131_20)
				local var_131_23 = var_131_21 <= 0 and var_131_18 or var_131_18 * (var_131_22 / var_131_21)

				if var_131_23 > 0 and var_131_18 < var_131_23 then
					arg_128_1.talkMaxDuration = var_131_23

					if var_131_23 + var_131_17 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_17
					end
				end

				arg_128_1.text_.text = var_131_20
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_24 = math.max(var_131_18, arg_128_1.talkMaxDuration)

			if var_131_17 <= arg_128_1.time_ and arg_128_1.time_ < var_131_17 + var_131_24 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_17) / var_131_24

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_17 + var_131_24 and arg_128_1.time_ < var_131_17 + var_131_24 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play324161030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324161030
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324161031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 1.35

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(324161030)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 54
				local var_135_5 = utf8.len(var_135_3)
				local var_135_6 = var_135_4 <= 0 and var_135_1 or var_135_1 * (var_135_5 / var_135_4)

				if var_135_6 > 0 and var_135_1 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_7 and arg_132_1.time_ < var_135_0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324161031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324161031
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324161032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 1.6

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

				local var_139_2 = arg_136_1:GetWordFromCfg(324161031)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 64
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
	Play324161032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324161032
		arg_140_1.duration_ = 2.5

		local var_140_0 = {
			zh = 2.4,
			ja = 2.5
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
				arg_140_0:Play324161033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["6148ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos6148ui_story = var_143_0.localPosition

				local var_143_2 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(false)
				end
			end

			local var_143_3 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_3 then
				local var_143_4 = (arg_140_1.time_ - var_143_1) / var_143_3
				local var_143_5 = Vector3.New(-0.7, -0.985, -6)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos6148ui_story, var_143_5, var_143_4)

				local var_143_6 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_6.x, var_143_6.y, var_143_6.z)

				local var_143_7 = var_143_0.localEulerAngles

				var_143_7.z = 0
				var_143_7.x = 0
				var_143_0.localEulerAngles = var_143_7
			end

			if arg_140_1.time_ >= var_143_1 + var_143_3 and arg_140_1.time_ < var_143_1 + var_143_3 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_143_8 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_8.x, var_143_8.y, var_143_8.z)

				local var_143_9 = var_143_0.localEulerAngles

				var_143_9.z = 0
				var_143_9.x = 0
				var_143_0.localEulerAngles = var_143_9

				local var_143_10 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_10 then
					var_143_10:EnableDynamicBone(true)
				end
			end

			local var_143_11 = arg_140_1.actors_["6148ui_story"]
			local var_143_12 = 0

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect6148ui_story == nil then
				arg_140_1.var_.characterEffect6148ui_story = var_143_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_13 = 0.200000002980232

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_13 and not isNil(var_143_11) then
				local var_143_14 = (arg_140_1.time_ - var_143_12) / var_143_13

				if arg_140_1.var_.characterEffect6148ui_story and not isNil(var_143_11) then
					arg_140_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_12 + var_143_13 and arg_140_1.time_ < var_143_12 + var_143_13 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect6148ui_story then
				arg_140_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_143_15 = 0

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_143_17 = 0
			local var_143_18 = 0.2

			if var_143_17 < arg_140_1.time_ and arg_140_1.time_ <= var_143_17 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_19 = arg_140_1:FormatText(StoryNameCfg[1488].name)

				arg_140_1.leftNameTxt_.text = var_143_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_20 = arg_140_1:GetWordFromCfg(324161032)
				local var_143_21 = arg_140_1:FormatText(var_143_20.content)

				arg_140_1.text_.text = var_143_21

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_22 = 8
				local var_143_23 = utf8.len(var_143_21)
				local var_143_24 = var_143_22 <= 0 and var_143_18 or var_143_18 * (var_143_23 / var_143_22)

				if var_143_24 > 0 and var_143_18 < var_143_24 then
					arg_140_1.talkMaxDuration = var_143_24

					if var_143_24 + var_143_17 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_24 + var_143_17
					end
				end

				arg_140_1.text_.text = var_143_21
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161032", "story_v_out_324161.awb") ~= 0 then
					local var_143_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161032", "story_v_out_324161.awb") / 1000

					if var_143_25 + var_143_17 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_25 + var_143_17
					end

					if var_143_20.prefab_name ~= "" and arg_140_1.actors_[var_143_20.prefab_name] ~= nil then
						local var_143_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_20.prefab_name].transform, "story_v_out_324161", "324161032", "story_v_out_324161.awb")

						arg_140_1:RecordAudio("324161032", var_143_26)
						arg_140_1:RecordAudio("324161032", var_143_26)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324161", "324161032", "story_v_out_324161.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324161", "324161032", "story_v_out_324161.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_27 = math.max(var_143_18, arg_140_1.talkMaxDuration)

			if var_143_17 <= arg_140_1.time_ and arg_140_1.time_ < var_143_17 + var_143_27 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_17) / var_143_27

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_17 + var_143_27 and arg_140_1.time_ < var_143_17 + var_143_27 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	Play324161033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324161033
		arg_144_1.duration_ = 3.3

		local var_144_0 = {
			zh = 2.166,
			ja = 3.3
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
				arg_144_0:Play324161034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1054ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1054ui_story = var_147_0.localPosition

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end
			end

			local var_147_3 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_3 then
				local var_147_4 = (arg_144_1.time_ - var_147_1) / var_147_3
				local var_147_5 = Vector3.New(0.7, -0.985, -6)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1054ui_story, var_147_5, var_147_4)

				local var_147_6 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_6.x, var_147_6.y, var_147_6.z)

				local var_147_7 = var_147_0.localEulerAngles

				var_147_7.z = 0
				var_147_7.x = 0
				var_147_0.localEulerAngles = var_147_7
			end

			if arg_144_1.time_ >= var_147_1 + var_147_3 and arg_144_1.time_ < var_147_1 + var_147_3 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_147_8 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_8.x, var_147_8.y, var_147_8.z)

				local var_147_9 = var_147_0.localEulerAngles

				var_147_9.z = 0
				var_147_9.x = 0
				var_147_0.localEulerAngles = var_147_9

				local var_147_10 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_10 then
					var_147_10:EnableDynamicBone(true)
				end
			end

			local var_147_11 = arg_144_1.actors_["1054ui_story"]
			local var_147_12 = 0

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect1054ui_story == nil then
				arg_144_1.var_.characterEffect1054ui_story = var_147_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_13 = 0.200000002980232

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_13 and not isNil(var_147_11) then
				local var_147_14 = (arg_144_1.time_ - var_147_12) / var_147_13

				if arg_144_1.var_.characterEffect1054ui_story and not isNil(var_147_11) then
					arg_144_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_12 + var_147_13 and arg_144_1.time_ < var_147_12 + var_147_13 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect1054ui_story then
				arg_144_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_147_15 = arg_144_1.actors_["6148ui_story"]
			local var_147_16 = 0

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 and not isNil(var_147_15) and arg_144_1.var_.characterEffect6148ui_story == nil then
				arg_144_1.var_.characterEffect6148ui_story = var_147_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_17 = 0.200000002980232

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_17 and not isNil(var_147_15) then
				local var_147_18 = (arg_144_1.time_ - var_147_16) / var_147_17

				if arg_144_1.var_.characterEffect6148ui_story and not isNil(var_147_15) then
					local var_147_19 = Mathf.Lerp(0, 0.5, var_147_18)

					arg_144_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_144_1.var_.characterEffect6148ui_story.fillRatio = var_147_19
				end
			end

			if arg_144_1.time_ >= var_147_16 + var_147_17 and arg_144_1.time_ < var_147_16 + var_147_17 + arg_147_0 and not isNil(var_147_15) and arg_144_1.var_.characterEffect6148ui_story then
				local var_147_20 = 0.5

				arg_144_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_144_1.var_.characterEffect6148ui_story.fillRatio = var_147_20
			end

			local var_147_21 = 0

			if var_147_21 < arg_144_1.time_ and arg_144_1.time_ <= var_147_21 + arg_147_0 then
				arg_144_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action8_2")
			end

			local var_147_22 = 0

			if var_147_22 < arg_144_1.time_ and arg_144_1.time_ <= var_147_22 + arg_147_0 then
				arg_144_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_147_23 = 0
			local var_147_24 = 0.25

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_25 = arg_144_1:FormatText(StoryNameCfg[1487].name)

				arg_144_1.leftNameTxt_.text = var_147_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_26 = arg_144_1:GetWordFromCfg(324161033)
				local var_147_27 = arg_144_1:FormatText(var_147_26.content)

				arg_144_1.text_.text = var_147_27

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_28 = 10
				local var_147_29 = utf8.len(var_147_27)
				local var_147_30 = var_147_28 <= 0 and var_147_24 or var_147_24 * (var_147_29 / var_147_28)

				if var_147_30 > 0 and var_147_24 < var_147_30 then
					arg_144_1.talkMaxDuration = var_147_30

					if var_147_30 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_30 + var_147_23
					end
				end

				arg_144_1.text_.text = var_147_27
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161033", "story_v_out_324161.awb") ~= 0 then
					local var_147_31 = manager.audio:GetVoiceLength("story_v_out_324161", "324161033", "story_v_out_324161.awb") / 1000

					if var_147_31 + var_147_23 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_31 + var_147_23
					end

					if var_147_26.prefab_name ~= "" and arg_144_1.actors_[var_147_26.prefab_name] ~= nil then
						local var_147_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_26.prefab_name].transform, "story_v_out_324161", "324161033", "story_v_out_324161.awb")

						arg_144_1:RecordAudio("324161033", var_147_32)
						arg_144_1:RecordAudio("324161033", var_147_32)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324161", "324161033", "story_v_out_324161.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324161", "324161033", "story_v_out_324161.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_33 = math.max(var_147_24, arg_144_1.talkMaxDuration)

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_33 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_23) / var_147_33

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_23 + var_147_33 and arg_144_1.time_ < var_147_23 + var_147_33 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play324161034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324161034
		arg_148_1.duration_ = 1.97

		local var_148_0 = {
			zh = 1.1,
			ja = 1.966
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324161035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["6148ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect6148ui_story == nil then
				arg_148_1.var_.characterEffect6148ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect6148ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect6148ui_story then
				arg_148_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["1054ui_story"]
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1054ui_story == nil then
				arg_148_1.var_.characterEffect1054ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.200000002980232

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 and not isNil(var_151_4) then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6

				if arg_148_1.var_.characterEffect1054ui_story and not isNil(var_151_4) then
					local var_151_8 = Mathf.Lerp(0, 0.5, var_151_7)

					arg_148_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1054ui_story.fillRatio = var_151_8
				end
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1054ui_story then
				local var_151_9 = 0.5

				arg_148_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1054ui_story.fillRatio = var_151_9
			end

			local var_151_10 = 0
			local var_151_11 = 0.075

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_12 = arg_148_1:FormatText(StoryNameCfg[1488].name)

				arg_148_1.leftNameTxt_.text = var_151_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_13 = arg_148_1:GetWordFromCfg(324161034)
				local var_151_14 = arg_148_1:FormatText(var_151_13.content)

				arg_148_1.text_.text = var_151_14

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_15 = 3
				local var_151_16 = utf8.len(var_151_14)
				local var_151_17 = var_151_15 <= 0 and var_151_11 or var_151_11 * (var_151_16 / var_151_15)

				if var_151_17 > 0 and var_151_11 < var_151_17 then
					arg_148_1.talkMaxDuration = var_151_17

					if var_151_17 + var_151_10 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_17 + var_151_10
					end
				end

				arg_148_1.text_.text = var_151_14
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161034", "story_v_out_324161.awb") ~= 0 then
					local var_151_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161034", "story_v_out_324161.awb") / 1000

					if var_151_18 + var_151_10 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_18 + var_151_10
					end

					if var_151_13.prefab_name ~= "" and arg_148_1.actors_[var_151_13.prefab_name] ~= nil then
						local var_151_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_13.prefab_name].transform, "story_v_out_324161", "324161034", "story_v_out_324161.awb")

						arg_148_1:RecordAudio("324161034", var_151_19)
						arg_148_1:RecordAudio("324161034", var_151_19)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_324161", "324161034", "story_v_out_324161.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_324161", "324161034", "story_v_out_324161.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_20 = math.max(var_151_11, arg_148_1.talkMaxDuration)

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_20 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_10) / var_151_20

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_10 + var_151_20 and arg_148_1.time_ < var_151_10 + var_151_20 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play324161035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324161035
		arg_152_1.duration_ = 4.7

		local var_152_0 = {
			zh = 2.133,
			ja = 4.7
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
				arg_152_0:Play324161036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1054ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1054ui_story == nil then
				arg_152_1.var_.characterEffect1054ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1054ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1054ui_story then
				arg_152_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["6148ui_story"]
			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect6148ui_story == nil then
				arg_152_1.var_.characterEffect6148ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_6 = 0.200000002980232

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 and not isNil(var_155_4) then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6

				if arg_152_1.var_.characterEffect6148ui_story and not isNil(var_155_4) then
					local var_155_8 = Mathf.Lerp(0, 0.5, var_155_7)

					arg_152_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_152_1.var_.characterEffect6148ui_story.fillRatio = var_155_8
				end
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect6148ui_story then
				local var_155_9 = 0.5

				arg_152_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_152_1.var_.characterEffect6148ui_story.fillRatio = var_155_9
			end

			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_155_11 = 0

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_155_12 = 0
			local var_155_13 = 0.2

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_14 = arg_152_1:FormatText(StoryNameCfg[1487].name)

				arg_152_1.leftNameTxt_.text = var_155_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_15 = arg_152_1:GetWordFromCfg(324161035)
				local var_155_16 = arg_152_1:FormatText(var_155_15.content)

				arg_152_1.text_.text = var_155_16

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_17 = 8
				local var_155_18 = utf8.len(var_155_16)
				local var_155_19 = var_155_17 <= 0 and var_155_13 or var_155_13 * (var_155_18 / var_155_17)

				if var_155_19 > 0 and var_155_13 < var_155_19 then
					arg_152_1.talkMaxDuration = var_155_19

					if var_155_19 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_19 + var_155_12
					end
				end

				arg_152_1.text_.text = var_155_16
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161035", "story_v_out_324161.awb") ~= 0 then
					local var_155_20 = manager.audio:GetVoiceLength("story_v_out_324161", "324161035", "story_v_out_324161.awb") / 1000

					if var_155_20 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_20 + var_155_12
					end

					if var_155_15.prefab_name ~= "" and arg_152_1.actors_[var_155_15.prefab_name] ~= nil then
						local var_155_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_15.prefab_name].transform, "story_v_out_324161", "324161035", "story_v_out_324161.awb")

						arg_152_1:RecordAudio("324161035", var_155_21)
						arg_152_1:RecordAudio("324161035", var_155_21)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324161", "324161035", "story_v_out_324161.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324161", "324161035", "story_v_out_324161.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_22 = math.max(var_155_13, arg_152_1.talkMaxDuration)

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_22 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_12) / var_155_22

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_12 + var_155_22 and arg_152_1.time_ < var_155_12 + var_155_22 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play324161036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324161036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324161037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1054ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1054ui_story = var_159_0.localPosition

				local var_159_2 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(false)
				end
			end

			local var_159_3 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_3 then
				local var_159_4 = (arg_156_1.time_ - var_159_1) / var_159_3
				local var_159_5 = Vector3.New(0, 100, 0)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1054ui_story, var_159_5, var_159_4)

				local var_159_6 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_6.x, var_159_6.y, var_159_6.z)

				local var_159_7 = var_159_0.localEulerAngles

				var_159_7.z = 0
				var_159_7.x = 0
				var_159_0.localEulerAngles = var_159_7
			end

			if arg_156_1.time_ >= var_159_1 + var_159_3 and arg_156_1.time_ < var_159_1 + var_159_3 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, 100, 0)

				local var_159_8 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_8.x, var_159_8.y, var_159_8.z)

				local var_159_9 = var_159_0.localEulerAngles

				var_159_9.z = 0
				var_159_9.x = 0
				var_159_0.localEulerAngles = var_159_9

				local var_159_10 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_10 then
					var_159_10:EnableDynamicBone(true)
				end
			end

			local var_159_11 = arg_156_1.actors_["6148ui_story"].transform
			local var_159_12 = 0

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 then
				arg_156_1.var_.moveOldPos6148ui_story = var_159_11.localPosition

				local var_159_13 = GameObjectTools.GetOrAddComponent(var_159_11.gameObject, typeof(DynamicBoneHelper))

				if var_159_13 then
					var_159_13:EnableDynamicBone(false)
				end
			end

			local var_159_14 = 0.001

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_14 then
				local var_159_15 = (arg_156_1.time_ - var_159_12) / var_159_14
				local var_159_16 = Vector3.New(0, 100, 0)

				var_159_11.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos6148ui_story, var_159_16, var_159_15)

				local var_159_17 = manager.ui.mainCamera.transform.position - var_159_11.position

				var_159_11.forward = Vector3.New(var_159_17.x, var_159_17.y, var_159_17.z)

				local var_159_18 = var_159_11.localEulerAngles

				var_159_18.z = 0
				var_159_18.x = 0
				var_159_11.localEulerAngles = var_159_18
			end

			if arg_156_1.time_ >= var_159_12 + var_159_14 and arg_156_1.time_ < var_159_12 + var_159_14 + arg_159_0 then
				var_159_11.localPosition = Vector3.New(0, 100, 0)

				local var_159_19 = manager.ui.mainCamera.transform.position - var_159_11.position

				var_159_11.forward = Vector3.New(var_159_19.x, var_159_19.y, var_159_19.z)

				local var_159_20 = var_159_11.localEulerAngles

				var_159_20.z = 0
				var_159_20.x = 0
				var_159_11.localEulerAngles = var_159_20

				local var_159_21 = GameObjectTools.GetOrAddComponent(var_159_11.gameObject, typeof(DynamicBoneHelper))

				if var_159_21 then
					var_159_21:EnableDynamicBone(true)
				end
			end

			local var_159_22 = arg_156_1.actors_["1054ui_story"]
			local var_159_23 = 0

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 and not isNil(var_159_22) and arg_156_1.var_.characterEffect1054ui_story == nil then
				arg_156_1.var_.characterEffect1054ui_story = var_159_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_24 = 0.200000002980232

			if var_159_23 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 and not isNil(var_159_22) then
				local var_159_25 = (arg_156_1.time_ - var_159_23) / var_159_24

				if arg_156_1.var_.characterEffect1054ui_story and not isNil(var_159_22) then
					local var_159_26 = Mathf.Lerp(0, 0.5, var_159_25)

					arg_156_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1054ui_story.fillRatio = var_159_26
				end
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 and not isNil(var_159_22) and arg_156_1.var_.characterEffect1054ui_story then
				local var_159_27 = 0.5

				arg_156_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1054ui_story.fillRatio = var_159_27
			end

			local var_159_28 = 0.3
			local var_159_29 = 1

			if var_159_28 < arg_156_1.time_ and arg_156_1.time_ <= var_159_28 + arg_159_0 then
				local var_159_30 = "play"
				local var_159_31 = "effect"

				arg_156_1:AudioAction(var_159_30, var_159_31, "se_story_150", "se_story_150_monster_growl", "")
			end

			local var_159_32 = 0
			local var_159_33 = 0.975

			if var_159_32 < arg_156_1.time_ and arg_156_1.time_ <= var_159_32 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_34 = arg_156_1:GetWordFromCfg(324161036)
				local var_159_35 = arg_156_1:FormatText(var_159_34.content)

				arg_156_1.text_.text = var_159_35

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_36 = 39
				local var_159_37 = utf8.len(var_159_35)
				local var_159_38 = var_159_36 <= 0 and var_159_33 or var_159_33 * (var_159_37 / var_159_36)

				if var_159_38 > 0 and var_159_33 < var_159_38 then
					arg_156_1.talkMaxDuration = var_159_38

					if var_159_38 + var_159_32 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_38 + var_159_32
					end
				end

				arg_156_1.text_.text = var_159_35
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_39 = math.max(var_159_33, arg_156_1.talkMaxDuration)

			if var_159_32 <= arg_156_1.time_ and arg_156_1.time_ < var_159_32 + var_159_39 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_32) / var_159_39

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_32 + var_159_39 and arg_156_1.time_ < var_159_32 + var_159_39 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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

		arg_156_1:InitPlayNodeList()
	end,
	Play324161037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324161037
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324161038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.825

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_2 = arg_160_1:GetWordFromCfg(324161037)
				local var_163_3 = arg_160_1:FormatText(var_163_2.content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 33
				local var_163_5 = utf8.len(var_163_3)
				local var_163_6 = var_163_4 <= 0 and var_163_1 or var_163_1 * (var_163_5 / var_163_4)

				if var_163_6 > 0 and var_163_1 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_7 and arg_160_1.time_ < var_163_0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324161038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324161038
		arg_164_1.duration_ = 2.03

		local var_164_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_164_0:Play324161039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["6148ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos6148ui_story = var_167_0.localPosition

				local var_167_2 = GameObjectTools.GetOrAddComponent(var_167_0.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(false)
				end
			end

			local var_167_3 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_3 then
				local var_167_4 = (arg_164_1.time_ - var_167_1) / var_167_3
				local var_167_5 = Vector3.New(-0.7, -0.985, -6)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos6148ui_story, var_167_5, var_167_4)

				local var_167_6 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_6.x, var_167_6.y, var_167_6.z)

				local var_167_7 = var_167_0.localEulerAngles

				var_167_7.z = 0
				var_167_7.x = 0
				var_167_0.localEulerAngles = var_167_7
			end

			if arg_164_1.time_ >= var_167_1 + var_167_3 and arg_164_1.time_ < var_167_1 + var_167_3 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_167_8 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_8.x, var_167_8.y, var_167_8.z)

				local var_167_9 = var_167_0.localEulerAngles

				var_167_9.z = 0
				var_167_9.x = 0
				var_167_0.localEulerAngles = var_167_9

				local var_167_10 = GameObjectTools.GetOrAddComponent(var_167_0.gameObject, typeof(DynamicBoneHelper))

				if var_167_10 then
					var_167_10:EnableDynamicBone(true)
				end
			end

			local var_167_11 = arg_164_1.actors_["6148ui_story"]
			local var_167_12 = 0

			if var_167_12 < arg_164_1.time_ and arg_164_1.time_ <= var_167_12 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect6148ui_story == nil then
				arg_164_1.var_.characterEffect6148ui_story = var_167_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_13 = 0.200000002980232

			if var_167_12 <= arg_164_1.time_ and arg_164_1.time_ < var_167_12 + var_167_13 and not isNil(var_167_11) then
				local var_167_14 = (arg_164_1.time_ - var_167_12) / var_167_13

				if arg_164_1.var_.characterEffect6148ui_story and not isNil(var_167_11) then
					arg_164_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_12 + var_167_13 and arg_164_1.time_ < var_167_12 + var_167_13 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect6148ui_story then
				arg_164_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_167_15 = 0

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_1")
			end

			local var_167_16 = 0

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_167_17 = 0
			local var_167_18 = 0.15

			if var_167_17 < arg_164_1.time_ and arg_164_1.time_ <= var_167_17 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_19 = arg_164_1:FormatText(StoryNameCfg[1488].name)

				arg_164_1.leftNameTxt_.text = var_167_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_20 = arg_164_1:GetWordFromCfg(324161038)
				local var_167_21 = arg_164_1:FormatText(var_167_20.content)

				arg_164_1.text_.text = var_167_21

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_22 = 6
				local var_167_23 = utf8.len(var_167_21)
				local var_167_24 = var_167_22 <= 0 and var_167_18 or var_167_18 * (var_167_23 / var_167_22)

				if var_167_24 > 0 and var_167_18 < var_167_24 then
					arg_164_1.talkMaxDuration = var_167_24

					if var_167_24 + var_167_17 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_24 + var_167_17
					end
				end

				arg_164_1.text_.text = var_167_21
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161038", "story_v_out_324161.awb") ~= 0 then
					local var_167_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161038", "story_v_out_324161.awb") / 1000

					if var_167_25 + var_167_17 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_25 + var_167_17
					end

					if var_167_20.prefab_name ~= "" and arg_164_1.actors_[var_167_20.prefab_name] ~= nil then
						local var_167_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_20.prefab_name].transform, "story_v_out_324161", "324161038", "story_v_out_324161.awb")

						arg_164_1:RecordAudio("324161038", var_167_26)
						arg_164_1:RecordAudio("324161038", var_167_26)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324161", "324161038", "story_v_out_324161.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324161", "324161038", "story_v_out_324161.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_27 = math.max(var_167_18, arg_164_1.talkMaxDuration)

			if var_167_17 <= arg_164_1.time_ and arg_164_1.time_ < var_167_17 + var_167_27 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_17) / var_167_27

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_17 + var_167_27 and arg_164_1.time_ < var_167_17 + var_167_27 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play324161039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324161039
		arg_168_1.duration_ = 2.6

		local var_168_0 = {
			zh = 2.5,
			ja = 2.6
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
				arg_168_0:Play324161040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1054ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1054ui_story = var_171_0.localPosition

				local var_171_2 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(false)
				end
			end

			local var_171_3 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_3 then
				local var_171_4 = (arg_168_1.time_ - var_171_1) / var_171_3
				local var_171_5 = Vector3.New(0.7, -0.985, -6)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1054ui_story, var_171_5, var_171_4)

				local var_171_6 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_6.x, var_171_6.y, var_171_6.z)

				local var_171_7 = var_171_0.localEulerAngles

				var_171_7.z = 0
				var_171_7.x = 0
				var_171_0.localEulerAngles = var_171_7
			end

			if arg_168_1.time_ >= var_171_1 + var_171_3 and arg_168_1.time_ < var_171_1 + var_171_3 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_171_8 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_8.x, var_171_8.y, var_171_8.z)

				local var_171_9 = var_171_0.localEulerAngles

				var_171_9.z = 0
				var_171_9.x = 0
				var_171_0.localEulerAngles = var_171_9

				local var_171_10 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_10 then
					var_171_10:EnableDynamicBone(true)
				end
			end

			local var_171_11 = arg_168_1.actors_["1054ui_story"]
			local var_171_12 = 0

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 and not isNil(var_171_11) and arg_168_1.var_.characterEffect1054ui_story == nil then
				arg_168_1.var_.characterEffect1054ui_story = var_171_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_13 = 0.200000002980232

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_13 and not isNil(var_171_11) then
				local var_171_14 = (arg_168_1.time_ - var_171_12) / var_171_13

				if arg_168_1.var_.characterEffect1054ui_story and not isNil(var_171_11) then
					arg_168_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_12 + var_171_13 and arg_168_1.time_ < var_171_12 + var_171_13 + arg_171_0 and not isNil(var_171_11) and arg_168_1.var_.characterEffect1054ui_story then
				arg_168_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_171_15 = arg_168_1.actors_["6148ui_story"]
			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 and not isNil(var_171_15) and arg_168_1.var_.characterEffect6148ui_story == nil then
				arg_168_1.var_.characterEffect6148ui_story = var_171_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_17 = 0.200000002980232

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_17 and not isNil(var_171_15) then
				local var_171_18 = (arg_168_1.time_ - var_171_16) / var_171_17

				if arg_168_1.var_.characterEffect6148ui_story and not isNil(var_171_15) then
					local var_171_19 = Mathf.Lerp(0, 0.5, var_171_18)

					arg_168_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_168_1.var_.characterEffect6148ui_story.fillRatio = var_171_19
				end
			end

			if arg_168_1.time_ >= var_171_16 + var_171_17 and arg_168_1.time_ < var_171_16 + var_171_17 + arg_171_0 and not isNil(var_171_15) and arg_168_1.var_.characterEffect6148ui_story then
				local var_171_20 = 0.5

				arg_168_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_168_1.var_.characterEffect6148ui_story.fillRatio = var_171_20
			end

			local var_171_21 = 0
			local var_171_22 = 0.225

			if var_171_21 < arg_168_1.time_ and arg_168_1.time_ <= var_171_21 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_23 = arg_168_1:FormatText(StoryNameCfg[1487].name)

				arg_168_1.leftNameTxt_.text = var_171_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_24 = arg_168_1:GetWordFromCfg(324161039)
				local var_171_25 = arg_168_1:FormatText(var_171_24.content)

				arg_168_1.text_.text = var_171_25

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_26 = 9
				local var_171_27 = utf8.len(var_171_25)
				local var_171_28 = var_171_26 <= 0 and var_171_22 or var_171_22 * (var_171_27 / var_171_26)

				if var_171_28 > 0 and var_171_22 < var_171_28 then
					arg_168_1.talkMaxDuration = var_171_28

					if var_171_28 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_28 + var_171_21
					end
				end

				arg_168_1.text_.text = var_171_25
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161039", "story_v_out_324161.awb") ~= 0 then
					local var_171_29 = manager.audio:GetVoiceLength("story_v_out_324161", "324161039", "story_v_out_324161.awb") / 1000

					if var_171_29 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_29 + var_171_21
					end

					if var_171_24.prefab_name ~= "" and arg_168_1.actors_[var_171_24.prefab_name] ~= nil then
						local var_171_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_24.prefab_name].transform, "story_v_out_324161", "324161039", "story_v_out_324161.awb")

						arg_168_1:RecordAudio("324161039", var_171_30)
						arg_168_1:RecordAudio("324161039", var_171_30)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324161", "324161039", "story_v_out_324161.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324161", "324161039", "story_v_out_324161.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_31 = math.max(var_171_22, arg_168_1.talkMaxDuration)

			if var_171_21 <= arg_168_1.time_ and arg_168_1.time_ < var_171_21 + var_171_31 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_21) / var_171_31

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_21 + var_171_31 and arg_168_1.time_ < var_171_21 + var_171_31 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play324161040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324161040
		arg_172_1.duration_ = 7.17

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324161041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1054ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1054ui_story = var_175_0.localPosition

				local var_175_2 = GameObjectTools.GetOrAddComponent(var_175_0.gameObject, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(false)
				end
			end

			local var_175_3 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_3 then
				local var_175_4 = (arg_172_1.time_ - var_175_1) / var_175_3
				local var_175_5 = Vector3.New(0, 100, 0)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1054ui_story, var_175_5, var_175_4)

				local var_175_6 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_6.x, var_175_6.y, var_175_6.z)

				local var_175_7 = var_175_0.localEulerAngles

				var_175_7.z = 0
				var_175_7.x = 0
				var_175_0.localEulerAngles = var_175_7
			end

			if arg_172_1.time_ >= var_175_1 + var_175_3 and arg_172_1.time_ < var_175_1 + var_175_3 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, 100, 0)

				local var_175_8 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_8.x, var_175_8.y, var_175_8.z)

				local var_175_9 = var_175_0.localEulerAngles

				var_175_9.z = 0
				var_175_9.x = 0
				var_175_0.localEulerAngles = var_175_9

				local var_175_10 = GameObjectTools.GetOrAddComponent(var_175_0.gameObject, typeof(DynamicBoneHelper))

				if var_175_10 then
					var_175_10:EnableDynamicBone(true)
				end
			end

			local var_175_11 = arg_172_1.actors_["6148ui_story"].transform
			local var_175_12 = 0

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.var_.moveOldPos6148ui_story = var_175_11.localPosition

				local var_175_13 = GameObjectTools.GetOrAddComponent(var_175_11.gameObject, typeof(DynamicBoneHelper))

				if var_175_13 then
					var_175_13:EnableDynamicBone(false)
				end
			end

			local var_175_14 = 0.001

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_14 then
				local var_175_15 = (arg_172_1.time_ - var_175_12) / var_175_14
				local var_175_16 = Vector3.New(0, 100, 0)

				var_175_11.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos6148ui_story, var_175_16, var_175_15)

				local var_175_17 = manager.ui.mainCamera.transform.position - var_175_11.position

				var_175_11.forward = Vector3.New(var_175_17.x, var_175_17.y, var_175_17.z)

				local var_175_18 = var_175_11.localEulerAngles

				var_175_18.z = 0
				var_175_18.x = 0
				var_175_11.localEulerAngles = var_175_18
			end

			if arg_172_1.time_ >= var_175_12 + var_175_14 and arg_172_1.time_ < var_175_12 + var_175_14 + arg_175_0 then
				var_175_11.localPosition = Vector3.New(0, 100, 0)

				local var_175_19 = manager.ui.mainCamera.transform.position - var_175_11.position

				var_175_11.forward = Vector3.New(var_175_19.x, var_175_19.y, var_175_19.z)

				local var_175_20 = var_175_11.localEulerAngles

				var_175_20.z = 0
				var_175_20.x = 0
				var_175_11.localEulerAngles = var_175_20

				local var_175_21 = GameObjectTools.GetOrAddComponent(var_175_11.gameObject, typeof(DynamicBoneHelper))

				if var_175_21 then
					var_175_21:EnableDynamicBone(true)
				end
			end

			local var_175_22 = arg_172_1.actors_["1054ui_story"]
			local var_175_23 = 0

			if var_175_23 < arg_172_1.time_ and arg_172_1.time_ <= var_175_23 + arg_175_0 and not isNil(var_175_22) and arg_172_1.var_.characterEffect1054ui_story == nil then
				arg_172_1.var_.characterEffect1054ui_story = var_175_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_24 = 0.200000002980232

			if var_175_23 <= arg_172_1.time_ and arg_172_1.time_ < var_175_23 + var_175_24 and not isNil(var_175_22) then
				local var_175_25 = (arg_172_1.time_ - var_175_23) / var_175_24

				if arg_172_1.var_.characterEffect1054ui_story and not isNil(var_175_22) then
					local var_175_26 = Mathf.Lerp(0, 0.5, var_175_25)

					arg_172_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1054ui_story.fillRatio = var_175_26
				end
			end

			if arg_172_1.time_ >= var_175_23 + var_175_24 and arg_172_1.time_ < var_175_23 + var_175_24 + arg_175_0 and not isNil(var_175_22) and arg_172_1.var_.characterEffect1054ui_story then
				local var_175_27 = 0.5

				arg_172_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1054ui_story.fillRatio = var_175_27
			end

			local var_175_28 = manager.ui.mainCamera.transform
			local var_175_29 = 0

			if var_175_29 < arg_172_1.time_ and arg_172_1.time_ <= var_175_29 + arg_175_0 then
				local var_175_30 = arg_172_1.var_.effect213
				local var_175_31
				local var_175_32 = var_175_28

				if not var_175_30 then
					var_175_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataglow"), var_175_32)
					var_175_30.name = "213"
					arg_172_1.var_.effect213 = var_175_30
				else
					var_175_30.transform:SetParent(var_175_32)
				end

				var_175_30.transform.localPosition = Vector3.New(0, 1.19, -5.07)
				var_175_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_175_33 = 1.7777777777777777
				local var_175_34 = Screen.width / Screen.height
				local var_175_35 = var_175_34 / var_175_33
				local var_175_36 = Mathf.Max(var_175_33 / var_175_34, 1)
				local var_175_37 = Mathf.Max(var_175_35, var_175_36)

				var_175_30.transform.localScale = Vector3.New(var_175_30.transform.localScale.x * var_175_37, var_175_30.transform.localScale.y * var_175_37, var_175_30.transform.localScale.z * var_175_37)
			end

			local var_175_38 = manager.ui.mainCamera.transform
			local var_175_39 = 1.5

			if var_175_39 < arg_172_1.time_ and arg_172_1.time_ <= var_175_39 + arg_175_0 then
				local var_175_40 = arg_172_1.var_.effect213

				if var_175_40 then
					Object.Destroy(var_175_40)

					arg_172_1.var_.effect213 = nil
				end
			end

			local var_175_41 = 1.26666666666667

			if var_175_41 < arg_172_1.time_ and arg_172_1.time_ <= var_175_41 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = false

				arg_172_1:SetGaussion(false)
			end

			local var_175_42 = 0.9

			if var_175_41 <= arg_172_1.time_ and arg_172_1.time_ < var_175_41 + var_175_42 then
				local var_175_43 = (arg_172_1.time_ - var_175_41) / var_175_42
				local var_175_44 = Color.New(1, 1, 1)

				var_175_44.a = Mathf.Lerp(1, 0, var_175_43)
				arg_172_1.mask_.color = var_175_44
			end

			if arg_172_1.time_ >= var_175_41 + var_175_42 and arg_172_1.time_ < var_175_41 + var_175_42 + arg_175_0 then
				local var_175_45 = Color.New(1, 1, 1)
				local var_175_46 = 0

				arg_172_1.mask_.enabled = false
				var_175_45.a = var_175_46
				arg_172_1.mask_.color = var_175_45
			end

			local var_175_47 = 0

			if var_175_47 < arg_172_1.time_ and arg_172_1.time_ <= var_175_47 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			local var_175_48 = 2.36666666666667

			if arg_172_1.time_ >= var_175_47 + var_175_48 and arg_172_1.time_ < var_175_47 + var_175_48 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_49 = 1.26666666666667
			local var_175_50 = 1

			if var_175_49 < arg_172_1.time_ and arg_172_1.time_ <= var_175_49 + arg_175_0 then
				local var_175_51 = "play"
				local var_175_52 = "effect"

				arg_172_1:AudioAction(var_175_51, var_175_52, "se_story_126_01", "se_story_126_01_Portal", "")
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_53 = 2.16666666666667
			local var_175_54 = 1.325

			if var_175_53 < arg_172_1.time_ and arg_172_1.time_ <= var_175_53 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_55 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_55:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_172_1.dialogCg_.alpha = arg_176_0
				end))
				var_175_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_56 = arg_172_1:GetWordFromCfg(324161040)
				local var_175_57 = arg_172_1:FormatText(var_175_56.content)

				arg_172_1.text_.text = var_175_57

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_58 = 53
				local var_175_59 = utf8.len(var_175_57)
				local var_175_60 = var_175_58 <= 0 and var_175_54 or var_175_54 * (var_175_59 / var_175_58)

				if var_175_60 > 0 and var_175_54 < var_175_60 then
					arg_172_1.talkMaxDuration = var_175_60
					var_175_53 = var_175_53 + 0.3

					if var_175_60 + var_175_53 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_60 + var_175_53
					end
				end

				arg_172_1.text_.text = var_175_57
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_61 = var_175_53 + 0.3
			local var_175_62 = math.max(var_175_54, arg_172_1.talkMaxDuration)

			if var_175_61 <= arg_172_1.time_ and arg_172_1.time_ < var_175_61 + var_175_62 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_61) / var_175_62

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_61 + var_175_62 and arg_172_1.time_ < var_175_61 + var_175_62 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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

		arg_172_1:InitPlayNodeList()
	end,
	Play324161041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 324161041
		arg_178_1.duration_ = 4.87

		local var_178_0 = {
			zh = 3.90833333333333,
			ja = 4.87433333333333
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play324161042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = "J27g"

			if arg_178_1.bgs_[var_181_0] == nil then
				local var_181_1 = Object.Instantiate(arg_178_1.paintGo_)

				var_181_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_181_0)
				var_181_1.name = var_181_0
				var_181_1.transform.parent = arg_178_1.stage_.transform
				var_181_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.bgs_[var_181_0] = var_181_1
			end

			local var_181_2 = 0.833333333333333

			if var_181_2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				local var_181_3 = manager.ui.mainCamera.transform.localPosition
				local var_181_4 = Vector3.New(0, 0, 10) + Vector3.New(var_181_3.x, var_181_3.y, 0)
				local var_181_5 = arg_178_1.bgs_.J27g

				var_181_5.transform.localPosition = var_181_4
				var_181_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_6 = var_181_5:GetComponent("SpriteRenderer")

				if var_181_6 and var_181_6.sprite then
					local var_181_7 = (var_181_5.transform.localPosition - var_181_3).z
					local var_181_8 = manager.ui.mainCameraCom_
					local var_181_9 = 2 * var_181_7 * Mathf.Tan(var_181_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_181_10 = var_181_9 * var_181_8.aspect
					local var_181_11 = var_181_6.sprite.bounds.size.x
					local var_181_12 = var_181_6.sprite.bounds.size.y
					local var_181_13 = var_181_10 / var_181_11
					local var_181_14 = var_181_9 / var_181_12
					local var_181_15 = var_181_14 < var_181_13 and var_181_13 or var_181_14

					var_181_5.transform.localScale = Vector3.New(var_181_15, var_181_15, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "J27g" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.allBtn_.enabled = false
			end

			local var_181_17 = 0.3

			if arg_178_1.time_ >= var_181_16 + var_181_17 and arg_178_1.time_ < var_181_16 + var_181_17 + arg_181_0 then
				arg_178_1.allBtn_.enabled = true
			end

			local var_181_18 = 0

			if var_181_18 < arg_178_1.time_ and arg_178_1.time_ <= var_181_18 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_19 = 0.833333333333333

			if var_181_18 <= arg_178_1.time_ and arg_178_1.time_ < var_181_18 + var_181_19 then
				local var_181_20 = (arg_178_1.time_ - var_181_18) / var_181_19
				local var_181_21 = Color.New(0, 0, 0)

				var_181_21.a = Mathf.Lerp(0, 1, var_181_20)
				arg_178_1.mask_.color = var_181_21
			end

			if arg_178_1.time_ >= var_181_18 + var_181_19 and arg_178_1.time_ < var_181_18 + var_181_19 + arg_181_0 then
				local var_181_22 = Color.New(0, 0, 0)

				var_181_22.a = 1
				arg_178_1.mask_.color = var_181_22
			end

			local var_181_23 = 0.833333333333333

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_24 = 1.6

			if var_181_23 <= arg_178_1.time_ and arg_178_1.time_ < var_181_23 + var_181_24 then
				local var_181_25 = (arg_178_1.time_ - var_181_23) / var_181_24
				local var_181_26 = Color.New(0, 0, 0)

				var_181_26.a = Mathf.Lerp(1, 0, var_181_25)
				arg_178_1.mask_.color = var_181_26
			end

			if arg_178_1.time_ >= var_181_23 + var_181_24 and arg_178_1.time_ < var_181_23 + var_181_24 + arg_181_0 then
				local var_181_27 = Color.New(0, 0, 0)
				local var_181_28 = 0

				arg_178_1.mask_.enabled = false
				var_181_27.a = var_181_28
				arg_178_1.mask_.color = var_181_27
			end

			local var_181_29 = arg_178_1.actors_["1054ui_story"]
			local var_181_30 = 0

			if var_181_30 < arg_178_1.time_ and arg_178_1.time_ <= var_181_30 + arg_181_0 and not isNil(var_181_29) and arg_178_1.var_.characterEffect1054ui_story == nil then
				arg_178_1.var_.characterEffect1054ui_story = var_181_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_31 = 0.200000002980232

			if var_181_30 <= arg_178_1.time_ and arg_178_1.time_ < var_181_30 + var_181_31 and not isNil(var_181_29) then
				local var_181_32 = (arg_178_1.time_ - var_181_30) / var_181_31

				if arg_178_1.var_.characterEffect1054ui_story and not isNil(var_181_29) then
					arg_178_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_30 + var_181_31 and arg_178_1.time_ < var_181_30 + var_181_31 + arg_181_0 and not isNil(var_181_29) and arg_178_1.var_.characterEffect1054ui_story then
				arg_178_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_181_33 = 1.2
			local var_181_34 = 1

			if var_181_33 < arg_178_1.time_ and arg_178_1.time_ <= var_181_33 + arg_181_0 then
				local var_181_35 = "play"
				local var_181_36 = "effect"

				arg_178_1:AudioAction(var_181_35, var_181_36, "se_story_150", "se_story_150_huatian", "")
			end

			local var_181_37 = 0.1
			local var_181_38 = 1

			if var_181_37 < arg_178_1.time_ and arg_178_1.time_ <= var_181_37 + arg_181_0 then
				local var_181_39 = "stop"
				local var_181_40 = "effect"

				arg_178_1:AudioAction(var_181_39, var_181_40, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_41 = 2.70833333333333
			local var_181_42 = 0.125

			if var_181_41 < arg_178_1.time_ and arg_178_1.time_ <= var_181_41 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_43 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_43:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_44 = arg_178_1:FormatText(StoryNameCfg[1487].name)

				arg_178_1.leftNameTxt_.text = var_181_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_45 = arg_178_1:GetWordFromCfg(324161041)
				local var_181_46 = arg_178_1:FormatText(var_181_45.content)

				arg_178_1.text_.text = var_181_46

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_47 = 5
				local var_181_48 = utf8.len(var_181_46)
				local var_181_49 = var_181_47 <= 0 and var_181_42 or var_181_42 * (var_181_48 / var_181_47)

				if var_181_49 > 0 and var_181_42 < var_181_49 then
					arg_178_1.talkMaxDuration = var_181_49
					var_181_41 = var_181_41 + 0.3

					if var_181_49 + var_181_41 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_49 + var_181_41
					end
				end

				arg_178_1.text_.text = var_181_46
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161041", "story_v_out_324161.awb") ~= 0 then
					local var_181_50 = manager.audio:GetVoiceLength("story_v_out_324161", "324161041", "story_v_out_324161.awb") / 1000

					if var_181_50 + var_181_41 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_50 + var_181_41
					end

					if var_181_45.prefab_name ~= "" and arg_178_1.actors_[var_181_45.prefab_name] ~= nil then
						local var_181_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_45.prefab_name].transform, "story_v_out_324161", "324161041", "story_v_out_324161.awb")

						arg_178_1:RecordAudio("324161041", var_181_51)
						arg_178_1:RecordAudio("324161041", var_181_51)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_324161", "324161041", "story_v_out_324161.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_324161", "324161041", "story_v_out_324161.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_52 = var_181_41 + 0.3
			local var_181_53 = math.max(var_181_42, arg_178_1.talkMaxDuration)

			if var_181_52 <= arg_178_1.time_ and arg_178_1.time_ < var_181_52 + var_181_53 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_52) / var_181_53

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_52 + var_181_53 and arg_178_1.time_ < var_181_52 + var_181_53 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play324161042 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324161042
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324161043(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1054ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1054ui_story == nil then
				arg_184_1.var_.characterEffect1054ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1054ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1054ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1054ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1054ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0.1
			local var_187_7 = 1

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				local var_187_8 = "play"
				local var_187_9 = "effect"

				arg_184_1:AudioAction(var_187_8, var_187_9, "se_story_150", "se_story_150_portal_fall", "")
			end

			local var_187_10 = 0
			local var_187_11 = 1.425

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_12 = arg_184_1:GetWordFromCfg(324161042)
				local var_187_13 = arg_184_1:FormatText(var_187_12.content)

				arg_184_1.text_.text = var_187_13

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_14 = 57
				local var_187_15 = utf8.len(var_187_13)
				local var_187_16 = var_187_14 <= 0 and var_187_11 or var_187_11 * (var_187_15 / var_187_14)

				if var_187_16 > 0 and var_187_11 < var_187_16 then
					arg_184_1.talkMaxDuration = var_187_16

					if var_187_16 + var_187_10 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_16 + var_187_10
					end
				end

				arg_184_1.text_.text = var_187_13
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_17 = math.max(var_187_11, arg_184_1.talkMaxDuration)

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_17 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_10) / var_187_17

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_10 + var_187_17 and arg_184_1.time_ < var_187_10 + var_187_17 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play324161043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324161043
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324161044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 1.225

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(324161043)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 49
				local var_191_5 = utf8.len(var_191_3)
				local var_191_6 = var_191_4 <= 0 and var_191_1 or var_191_1 * (var_191_5 / var_191_4)

				if var_191_6 > 0 and var_191_1 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_7 and arg_188_1.time_ < var_191_0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324161044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324161044
		arg_192_1.duration_ = 3.1

		local var_192_0 = {
			zh = 1.5,
			ja = 3.1
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
				arg_192_0:Play324161045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["6148ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos6148ui_story = var_195_0.localPosition

				local var_195_2 = GameObjectTools.GetOrAddComponent(var_195_0.gameObject, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(false)
				end
			end

			local var_195_3 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_3 then
				local var_195_4 = (arg_192_1.time_ - var_195_1) / var_195_3
				local var_195_5 = Vector3.New(0, -0.985, -6)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos6148ui_story, var_195_5, var_195_4)

				local var_195_6 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_6.x, var_195_6.y, var_195_6.z)

				local var_195_7 = var_195_0.localEulerAngles

				var_195_7.z = 0
				var_195_7.x = 0
				var_195_0.localEulerAngles = var_195_7
			end

			if arg_192_1.time_ >= var_195_1 + var_195_3 and arg_192_1.time_ < var_195_1 + var_195_3 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_195_8 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_8.x, var_195_8.y, var_195_8.z)

				local var_195_9 = var_195_0.localEulerAngles

				var_195_9.z = 0
				var_195_9.x = 0
				var_195_0.localEulerAngles = var_195_9

				local var_195_10 = GameObjectTools.GetOrAddComponent(var_195_0.gameObject, typeof(DynamicBoneHelper))

				if var_195_10 then
					var_195_10:EnableDynamicBone(true)
				end
			end

			local var_195_11 = arg_192_1.actors_["6148ui_story"]
			local var_195_12 = 0

			if var_195_12 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 and not isNil(var_195_11) and arg_192_1.var_.characterEffect6148ui_story == nil then
				arg_192_1.var_.characterEffect6148ui_story = var_195_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_13 = 0.200000002980232

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_13 and not isNil(var_195_11) then
				local var_195_14 = (arg_192_1.time_ - var_195_12) / var_195_13

				if arg_192_1.var_.characterEffect6148ui_story and not isNil(var_195_11) then
					arg_192_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_12 + var_195_13 and arg_192_1.time_ < var_195_12 + var_195_13 + arg_195_0 and not isNil(var_195_11) and arg_192_1.var_.characterEffect6148ui_story then
				arg_192_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_195_15 = 0

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_195_17 = 0
			local var_195_18 = 0.175

			if var_195_17 < arg_192_1.time_ and arg_192_1.time_ <= var_195_17 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_19 = arg_192_1:FormatText(StoryNameCfg[1488].name)

				arg_192_1.leftNameTxt_.text = var_195_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_20 = arg_192_1:GetWordFromCfg(324161044)
				local var_195_21 = arg_192_1:FormatText(var_195_20.content)

				arg_192_1.text_.text = var_195_21

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_22 = 7
				local var_195_23 = utf8.len(var_195_21)
				local var_195_24 = var_195_22 <= 0 and var_195_18 or var_195_18 * (var_195_23 / var_195_22)

				if var_195_24 > 0 and var_195_18 < var_195_24 then
					arg_192_1.talkMaxDuration = var_195_24

					if var_195_24 + var_195_17 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_24 + var_195_17
					end
				end

				arg_192_1.text_.text = var_195_21
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161044", "story_v_out_324161.awb") ~= 0 then
					local var_195_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161044", "story_v_out_324161.awb") / 1000

					if var_195_25 + var_195_17 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_25 + var_195_17
					end

					if var_195_20.prefab_name ~= "" and arg_192_1.actors_[var_195_20.prefab_name] ~= nil then
						local var_195_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_20.prefab_name].transform, "story_v_out_324161", "324161044", "story_v_out_324161.awb")

						arg_192_1:RecordAudio("324161044", var_195_26)
						arg_192_1:RecordAudio("324161044", var_195_26)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_324161", "324161044", "story_v_out_324161.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_324161", "324161044", "story_v_out_324161.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_27 = math.max(var_195_18, arg_192_1.talkMaxDuration)

			if var_195_17 <= arg_192_1.time_ and arg_192_1.time_ < var_195_17 + var_195_27 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_17) / var_195_27

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_17 + var_195_27 and arg_192_1.time_ < var_195_17 + var_195_27 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play324161045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324161045
		arg_196_1.duration_ = 2

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324161046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1054ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1054ui_story = var_199_0.localPosition

				local var_199_2 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(false)
				end
			end

			local var_199_3 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_3 then
				local var_199_4 = (arg_196_1.time_ - var_199_1) / var_199_3
				local var_199_5 = Vector3.New(-0.7, -0.985, -6)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1054ui_story, var_199_5, var_199_4)

				local var_199_6 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_6.x, var_199_6.y, var_199_6.z)

				local var_199_7 = var_199_0.localEulerAngles

				var_199_7.z = 0
				var_199_7.x = 0
				var_199_0.localEulerAngles = var_199_7
			end

			if arg_196_1.time_ >= var_199_1 + var_199_3 and arg_196_1.time_ < var_199_1 + var_199_3 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_199_8 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_8.x, var_199_8.y, var_199_8.z)

				local var_199_9 = var_199_0.localEulerAngles

				var_199_9.z = 0
				var_199_9.x = 0
				var_199_0.localEulerAngles = var_199_9

				local var_199_10 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_10 then
					var_199_10:EnableDynamicBone(true)
				end
			end

			local var_199_11 = arg_196_1.actors_["6148ui_story"].transform
			local var_199_12 = 0

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.var_.moveOldPos6148ui_story = var_199_11.localPosition

				local var_199_13 = GameObjectTools.GetOrAddComponent(var_199_11.gameObject, typeof(DynamicBoneHelper))

				if var_199_13 then
					var_199_13:EnableDynamicBone(false)
				end
			end

			local var_199_14 = 0.001

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_14 then
				local var_199_15 = (arg_196_1.time_ - var_199_12) / var_199_14
				local var_199_16 = Vector3.New(0.7, -0.985, -6)

				var_199_11.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos6148ui_story, var_199_16, var_199_15)

				local var_199_17 = manager.ui.mainCamera.transform.position - var_199_11.position

				var_199_11.forward = Vector3.New(var_199_17.x, var_199_17.y, var_199_17.z)

				local var_199_18 = var_199_11.localEulerAngles

				var_199_18.z = 0
				var_199_18.x = 0
				var_199_11.localEulerAngles = var_199_18
			end

			if arg_196_1.time_ >= var_199_12 + var_199_14 and arg_196_1.time_ < var_199_12 + var_199_14 + arg_199_0 then
				var_199_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_199_19 = manager.ui.mainCamera.transform.position - var_199_11.position

				var_199_11.forward = Vector3.New(var_199_19.x, var_199_19.y, var_199_19.z)

				local var_199_20 = var_199_11.localEulerAngles

				var_199_20.z = 0
				var_199_20.x = 0
				var_199_11.localEulerAngles = var_199_20

				local var_199_21 = GameObjectTools.GetOrAddComponent(var_199_11.gameObject, typeof(DynamicBoneHelper))

				if var_199_21 then
					var_199_21:EnableDynamicBone(true)
				end
			end

			local var_199_22 = arg_196_1.actors_["1054ui_story"]
			local var_199_23 = 0

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 and not isNil(var_199_22) and arg_196_1.var_.characterEffect1054ui_story == nil then
				arg_196_1.var_.characterEffect1054ui_story = var_199_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_24 = 0.200000002980232

			if var_199_23 <= arg_196_1.time_ and arg_196_1.time_ < var_199_23 + var_199_24 and not isNil(var_199_22) then
				local var_199_25 = (arg_196_1.time_ - var_199_23) / var_199_24

				if arg_196_1.var_.characterEffect1054ui_story and not isNil(var_199_22) then
					arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_23 + var_199_24 and arg_196_1.time_ < var_199_23 + var_199_24 + arg_199_0 and not isNil(var_199_22) and arg_196_1.var_.characterEffect1054ui_story then
				arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_199_26 = arg_196_1.actors_["6148ui_story"]
			local var_199_27 = 0

			if var_199_27 < arg_196_1.time_ and arg_196_1.time_ <= var_199_27 + arg_199_0 and not isNil(var_199_26) and arg_196_1.var_.characterEffect6148ui_story == nil then
				arg_196_1.var_.characterEffect6148ui_story = var_199_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_28 = 0.200000002980232

			if var_199_27 <= arg_196_1.time_ and arg_196_1.time_ < var_199_27 + var_199_28 and not isNil(var_199_26) then
				local var_199_29 = (arg_196_1.time_ - var_199_27) / var_199_28

				if arg_196_1.var_.characterEffect6148ui_story and not isNil(var_199_26) then
					local var_199_30 = Mathf.Lerp(0, 0.5, var_199_29)

					arg_196_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_196_1.var_.characterEffect6148ui_story.fillRatio = var_199_30
				end
			end

			if arg_196_1.time_ >= var_199_27 + var_199_28 and arg_196_1.time_ < var_199_27 + var_199_28 + arg_199_0 and not isNil(var_199_26) and arg_196_1.var_.characterEffect6148ui_story then
				local var_199_31 = 0.5

				arg_196_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_196_1.var_.characterEffect6148ui_story.fillRatio = var_199_31
			end

			local var_199_32 = 0

			if var_199_32 < arg_196_1.time_ and arg_196_1.time_ <= var_199_32 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_199_33 = 0

			if var_199_33 < arg_196_1.time_ and arg_196_1.time_ <= var_199_33 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_199_34 = 0
			local var_199_35 = 0.125

			if var_199_34 < arg_196_1.time_ and arg_196_1.time_ <= var_199_34 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_36 = arg_196_1:FormatText(StoryNameCfg[1487].name)

				arg_196_1.leftNameTxt_.text = var_199_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_37 = arg_196_1:GetWordFromCfg(324161045)
				local var_199_38 = arg_196_1:FormatText(var_199_37.content)

				arg_196_1.text_.text = var_199_38

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_39 = 5
				local var_199_40 = utf8.len(var_199_38)
				local var_199_41 = var_199_39 <= 0 and var_199_35 or var_199_35 * (var_199_40 / var_199_39)

				if var_199_41 > 0 and var_199_35 < var_199_41 then
					arg_196_1.talkMaxDuration = var_199_41

					if var_199_41 + var_199_34 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_41 + var_199_34
					end
				end

				arg_196_1.text_.text = var_199_38
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161045", "story_v_out_324161.awb") ~= 0 then
					local var_199_42 = manager.audio:GetVoiceLength("story_v_out_324161", "324161045", "story_v_out_324161.awb") / 1000

					if var_199_42 + var_199_34 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_42 + var_199_34
					end

					if var_199_37.prefab_name ~= "" and arg_196_1.actors_[var_199_37.prefab_name] ~= nil then
						local var_199_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_37.prefab_name].transform, "story_v_out_324161", "324161045", "story_v_out_324161.awb")

						arg_196_1:RecordAudio("324161045", var_199_43)
						arg_196_1:RecordAudio("324161045", var_199_43)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_324161", "324161045", "story_v_out_324161.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_324161", "324161045", "story_v_out_324161.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_44 = math.max(var_199_35, arg_196_1.talkMaxDuration)

			if var_199_34 <= arg_196_1.time_ and arg_196_1.time_ < var_199_34 + var_199_44 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_34) / var_199_44

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_34 + var_199_44 and arg_196_1.time_ < var_199_34 + var_199_44 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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

		arg_196_1:InitPlayNodeList()
	end,
	Play324161046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324161046
		arg_200_1.duration_ = 5.27

		local var_200_0 = {
			zh = 3.9,
			ja = 5.266
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
				arg_200_0:Play324161047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["6148ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos6148ui_story = var_203_0.localPosition

				local var_203_2 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(false)
				end
			end

			local var_203_3 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_3 then
				local var_203_4 = (arg_200_1.time_ - var_203_1) / var_203_3
				local var_203_5 = Vector3.New(0.7, -0.985, -6)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos6148ui_story, var_203_5, var_203_4)

				local var_203_6 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_6.x, var_203_6.y, var_203_6.z)

				local var_203_7 = var_203_0.localEulerAngles

				var_203_7.z = 0
				var_203_7.x = 0
				var_203_0.localEulerAngles = var_203_7
			end

			if arg_200_1.time_ >= var_203_1 + var_203_3 and arg_200_1.time_ < var_203_1 + var_203_3 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_203_8 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_8.x, var_203_8.y, var_203_8.z)

				local var_203_9 = var_203_0.localEulerAngles

				var_203_9.z = 0
				var_203_9.x = 0
				var_203_0.localEulerAngles = var_203_9

				local var_203_10 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_10 then
					var_203_10:EnableDynamicBone(true)
				end
			end

			local var_203_11 = arg_200_1.actors_["6148ui_story"]
			local var_203_12 = 0

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 and not isNil(var_203_11) and arg_200_1.var_.characterEffect6148ui_story == nil then
				arg_200_1.var_.characterEffect6148ui_story = var_203_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_13 = 0.200000002980232

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_13 and not isNil(var_203_11) then
				local var_203_14 = (arg_200_1.time_ - var_203_12) / var_203_13

				if arg_200_1.var_.characterEffect6148ui_story and not isNil(var_203_11) then
					arg_200_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_12 + var_203_13 and arg_200_1.time_ < var_203_12 + var_203_13 + arg_203_0 and not isNil(var_203_11) and arg_200_1.var_.characterEffect6148ui_story then
				arg_200_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_203_15 = arg_200_1.actors_["1054ui_story"]
			local var_203_16 = 0

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 and not isNil(var_203_15) and arg_200_1.var_.characterEffect1054ui_story == nil then
				arg_200_1.var_.characterEffect1054ui_story = var_203_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_17 = 0.200000002980232

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_17 and not isNil(var_203_15) then
				local var_203_18 = (arg_200_1.time_ - var_203_16) / var_203_17

				if arg_200_1.var_.characterEffect1054ui_story and not isNil(var_203_15) then
					local var_203_19 = Mathf.Lerp(0, 0.5, var_203_18)

					arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1054ui_story.fillRatio = var_203_19
				end
			end

			if arg_200_1.time_ >= var_203_16 + var_203_17 and arg_200_1.time_ < var_203_16 + var_203_17 + arg_203_0 and not isNil(var_203_15) and arg_200_1.var_.characterEffect1054ui_story then
				local var_203_20 = 0.5

				arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1054ui_story.fillRatio = var_203_20
			end

			local var_203_21 = 0
			local var_203_22 = 0.525

			if var_203_21 < arg_200_1.time_ and arg_200_1.time_ <= var_203_21 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_23 = arg_200_1:FormatText(StoryNameCfg[1488].name)

				arg_200_1.leftNameTxt_.text = var_203_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_24 = arg_200_1:GetWordFromCfg(324161046)
				local var_203_25 = arg_200_1:FormatText(var_203_24.content)

				arg_200_1.text_.text = var_203_25

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_26 = 21
				local var_203_27 = utf8.len(var_203_25)
				local var_203_28 = var_203_26 <= 0 and var_203_22 or var_203_22 * (var_203_27 / var_203_26)

				if var_203_28 > 0 and var_203_22 < var_203_28 then
					arg_200_1.talkMaxDuration = var_203_28

					if var_203_28 + var_203_21 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_28 + var_203_21
					end
				end

				arg_200_1.text_.text = var_203_25
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161046", "story_v_out_324161.awb") ~= 0 then
					local var_203_29 = manager.audio:GetVoiceLength("story_v_out_324161", "324161046", "story_v_out_324161.awb") / 1000

					if var_203_29 + var_203_21 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_29 + var_203_21
					end

					if var_203_24.prefab_name ~= "" and arg_200_1.actors_[var_203_24.prefab_name] ~= nil then
						local var_203_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_24.prefab_name].transform, "story_v_out_324161", "324161046", "story_v_out_324161.awb")

						arg_200_1:RecordAudio("324161046", var_203_30)
						arg_200_1:RecordAudio("324161046", var_203_30)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_324161", "324161046", "story_v_out_324161.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_324161", "324161046", "story_v_out_324161.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_31 = math.max(var_203_22, arg_200_1.talkMaxDuration)

			if var_203_21 <= arg_200_1.time_ and arg_200_1.time_ < var_203_21 + var_203_31 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_21) / var_203_31

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_21 + var_203_31 and arg_200_1.time_ < var_203_21 + var_203_31 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play324161047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324161047
		arg_204_1.duration_ = 4.47

		local var_204_0 = {
			zh = 2.4,
			ja = 4.466
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
				arg_204_0:Play324161048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1054ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1054ui_story == nil then
				arg_204_1.var_.characterEffect1054ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1054ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1054ui_story then
				arg_204_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_207_4 = arg_204_1.actors_["6148ui_story"]
			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect6148ui_story == nil then
				arg_204_1.var_.characterEffect6148ui_story = var_207_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_6 = 0.200000002980232

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_6 and not isNil(var_207_4) then
				local var_207_7 = (arg_204_1.time_ - var_207_5) / var_207_6

				if arg_204_1.var_.characterEffect6148ui_story and not isNil(var_207_4) then
					local var_207_8 = Mathf.Lerp(0, 0.5, var_207_7)

					arg_204_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_204_1.var_.characterEffect6148ui_story.fillRatio = var_207_8
				end
			end

			if arg_204_1.time_ >= var_207_5 + var_207_6 and arg_204_1.time_ < var_207_5 + var_207_6 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect6148ui_story then
				local var_207_9 = 0.5

				arg_204_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_204_1.var_.characterEffect6148ui_story.fillRatio = var_207_9
			end

			local var_207_10 = 0
			local var_207_11 = 0.3

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_12 = arg_204_1:FormatText(StoryNameCfg[1487].name)

				arg_204_1.leftNameTxt_.text = var_207_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_13 = arg_204_1:GetWordFromCfg(324161047)
				local var_207_14 = arg_204_1:FormatText(var_207_13.content)

				arg_204_1.text_.text = var_207_14

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_15 = 12
				local var_207_16 = utf8.len(var_207_14)
				local var_207_17 = var_207_15 <= 0 and var_207_11 or var_207_11 * (var_207_16 / var_207_15)

				if var_207_17 > 0 and var_207_11 < var_207_17 then
					arg_204_1.talkMaxDuration = var_207_17

					if var_207_17 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_17 + var_207_10
					end
				end

				arg_204_1.text_.text = var_207_14
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161047", "story_v_out_324161.awb") ~= 0 then
					local var_207_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161047", "story_v_out_324161.awb") / 1000

					if var_207_18 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_18 + var_207_10
					end

					if var_207_13.prefab_name ~= "" and arg_204_1.actors_[var_207_13.prefab_name] ~= nil then
						local var_207_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_13.prefab_name].transform, "story_v_out_324161", "324161047", "story_v_out_324161.awb")

						arg_204_1:RecordAudio("324161047", var_207_19)
						arg_204_1:RecordAudio("324161047", var_207_19)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324161", "324161047", "story_v_out_324161.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324161", "324161047", "story_v_out_324161.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_20 = math.max(var_207_11, arg_204_1.talkMaxDuration)

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_20 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_10) / var_207_20

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_10 + var_207_20 and arg_204_1.time_ < var_207_10 + var_207_20 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play324161048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324161048
		arg_208_1.duration_ = 6.67

		local var_208_0 = {
			zh = 2.5,
			ja = 6.666
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
				arg_208_0:Play324161049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["6148ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect6148ui_story == nil then
				arg_208_1.var_.characterEffect6148ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect6148ui_story and not isNil(var_211_0) then
					arg_208_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect6148ui_story then
				arg_208_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_211_4 = arg_208_1.actors_["1054ui_story"]
			local var_211_5 = 0

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect1054ui_story == nil then
				arg_208_1.var_.characterEffect1054ui_story = var_211_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_6 = 0.200000002980232

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 and not isNil(var_211_4) then
				local var_211_7 = (arg_208_1.time_ - var_211_5) / var_211_6

				if arg_208_1.var_.characterEffect1054ui_story and not isNil(var_211_4) then
					local var_211_8 = Mathf.Lerp(0, 0.5, var_211_7)

					arg_208_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1054ui_story.fillRatio = var_211_8
				end
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect1054ui_story then
				local var_211_9 = 0.5

				arg_208_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1054ui_story.fillRatio = var_211_9
			end

			local var_211_10 = 0

			if var_211_10 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 then
				arg_208_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_211_11 = 0

			if var_211_11 < arg_208_1.time_ and arg_208_1.time_ <= var_211_11 + arg_211_0 then
				arg_208_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_211_12 = 0
			local var_211_13 = 0.325

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_14 = arg_208_1:FormatText(StoryNameCfg[1488].name)

				arg_208_1.leftNameTxt_.text = var_211_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_15 = arg_208_1:GetWordFromCfg(324161048)
				local var_211_16 = arg_208_1:FormatText(var_211_15.content)

				arg_208_1.text_.text = var_211_16

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_17 = 13
				local var_211_18 = utf8.len(var_211_16)
				local var_211_19 = var_211_17 <= 0 and var_211_13 or var_211_13 * (var_211_18 / var_211_17)

				if var_211_19 > 0 and var_211_13 < var_211_19 then
					arg_208_1.talkMaxDuration = var_211_19

					if var_211_19 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_19 + var_211_12
					end
				end

				arg_208_1.text_.text = var_211_16
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161048", "story_v_out_324161.awb") ~= 0 then
					local var_211_20 = manager.audio:GetVoiceLength("story_v_out_324161", "324161048", "story_v_out_324161.awb") / 1000

					if var_211_20 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_20 + var_211_12
					end

					if var_211_15.prefab_name ~= "" and arg_208_1.actors_[var_211_15.prefab_name] ~= nil then
						local var_211_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_15.prefab_name].transform, "story_v_out_324161", "324161048", "story_v_out_324161.awb")

						arg_208_1:RecordAudio("324161048", var_211_21)
						arg_208_1:RecordAudio("324161048", var_211_21)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324161", "324161048", "story_v_out_324161.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324161", "324161048", "story_v_out_324161.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_22 = math.max(var_211_13, arg_208_1.talkMaxDuration)

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_22 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_12) / var_211_22

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_12 + var_211_22 and arg_208_1.time_ < var_211_12 + var_211_22 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324161049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324161049
		arg_212_1.duration_ = 7.6

		local var_212_0 = {
			zh = 5.1,
			ja = 7.6
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
				arg_212_0:Play324161050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1054ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1054ui_story == nil then
				arg_212_1.var_.characterEffect1054ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1054ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1054ui_story then
				arg_212_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_215_4 = arg_212_1.actors_["6148ui_story"]
			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect6148ui_story == nil then
				arg_212_1.var_.characterEffect6148ui_story = var_215_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_6 = 0.200000002980232

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_6 and not isNil(var_215_4) then
				local var_215_7 = (arg_212_1.time_ - var_215_5) / var_215_6

				if arg_212_1.var_.characterEffect6148ui_story and not isNil(var_215_4) then
					local var_215_8 = Mathf.Lerp(0, 0.5, var_215_7)

					arg_212_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_212_1.var_.characterEffect6148ui_story.fillRatio = var_215_8
				end
			end

			if arg_212_1.time_ >= var_215_5 + var_215_6 and arg_212_1.time_ < var_215_5 + var_215_6 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect6148ui_story then
				local var_215_9 = 0.5

				arg_212_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_212_1.var_.characterEffect6148ui_story.fillRatio = var_215_9
			end

			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 then
				arg_212_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_215_11 = 0
			local var_215_12 = 0.45

			if var_215_11 < arg_212_1.time_ and arg_212_1.time_ <= var_215_11 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_13 = arg_212_1:FormatText(StoryNameCfg[1487].name)

				arg_212_1.leftNameTxt_.text = var_215_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_14 = arg_212_1:GetWordFromCfg(324161049)
				local var_215_15 = arg_212_1:FormatText(var_215_14.content)

				arg_212_1.text_.text = var_215_15

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_16 = 18
				local var_215_17 = utf8.len(var_215_15)
				local var_215_18 = var_215_16 <= 0 and var_215_12 or var_215_12 * (var_215_17 / var_215_16)

				if var_215_18 > 0 and var_215_12 < var_215_18 then
					arg_212_1.talkMaxDuration = var_215_18

					if var_215_18 + var_215_11 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_18 + var_215_11
					end
				end

				arg_212_1.text_.text = var_215_15
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161049", "story_v_out_324161.awb") ~= 0 then
					local var_215_19 = manager.audio:GetVoiceLength("story_v_out_324161", "324161049", "story_v_out_324161.awb") / 1000

					if var_215_19 + var_215_11 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_19 + var_215_11
					end

					if var_215_14.prefab_name ~= "" and arg_212_1.actors_[var_215_14.prefab_name] ~= nil then
						local var_215_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_14.prefab_name].transform, "story_v_out_324161", "324161049", "story_v_out_324161.awb")

						arg_212_1:RecordAudio("324161049", var_215_20)
						arg_212_1:RecordAudio("324161049", var_215_20)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324161", "324161049", "story_v_out_324161.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324161", "324161049", "story_v_out_324161.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_21 = math.max(var_215_12, arg_212_1.talkMaxDuration)

			if var_215_11 <= arg_212_1.time_ and arg_212_1.time_ < var_215_11 + var_215_21 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_11) / var_215_21

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_11 + var_215_21 and arg_212_1.time_ < var_215_11 + var_215_21 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324161050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324161050
		arg_216_1.duration_ = 1.87

		local var_216_0 = {
			zh = 1,
			ja = 1.866
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
				arg_216_0:Play324161051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["6148ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect6148ui_story == nil then
				arg_216_1.var_.characterEffect6148ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect6148ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect6148ui_story then
				arg_216_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_219_4 = arg_216_1.actors_["1054ui_story"]
			local var_219_5 = 0

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect1054ui_story == nil then
				arg_216_1.var_.characterEffect1054ui_story = var_219_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_6 = 0.200000002980232

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_6 and not isNil(var_219_4) then
				local var_219_7 = (arg_216_1.time_ - var_219_5) / var_219_6

				if arg_216_1.var_.characterEffect1054ui_story and not isNil(var_219_4) then
					local var_219_8 = Mathf.Lerp(0, 0.5, var_219_7)

					arg_216_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1054ui_story.fillRatio = var_219_8
				end
			end

			if arg_216_1.time_ >= var_219_5 + var_219_6 and arg_216_1.time_ < var_219_5 + var_219_6 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect1054ui_story then
				local var_219_9 = 0.5

				arg_216_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1054ui_story.fillRatio = var_219_9
			end

			local var_219_10 = 0
			local var_219_11 = 0.05

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_12 = arg_216_1:FormatText(StoryNameCfg[1488].name)

				arg_216_1.leftNameTxt_.text = var_219_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_13 = arg_216_1:GetWordFromCfg(324161050)
				local var_219_14 = arg_216_1:FormatText(var_219_13.content)

				arg_216_1.text_.text = var_219_14

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_15 = 2
				local var_219_16 = utf8.len(var_219_14)
				local var_219_17 = var_219_15 <= 0 and var_219_11 or var_219_11 * (var_219_16 / var_219_15)

				if var_219_17 > 0 and var_219_11 < var_219_17 then
					arg_216_1.talkMaxDuration = var_219_17

					if var_219_17 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_17 + var_219_10
					end
				end

				arg_216_1.text_.text = var_219_14
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161050", "story_v_out_324161.awb") ~= 0 then
					local var_219_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161050", "story_v_out_324161.awb") / 1000

					if var_219_18 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_18 + var_219_10
					end

					if var_219_13.prefab_name ~= "" and arg_216_1.actors_[var_219_13.prefab_name] ~= nil then
						local var_219_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_13.prefab_name].transform, "story_v_out_324161", "324161050", "story_v_out_324161.awb")

						arg_216_1:RecordAudio("324161050", var_219_19)
						arg_216_1:RecordAudio("324161050", var_219_19)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_324161", "324161050", "story_v_out_324161.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_324161", "324161050", "story_v_out_324161.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_20 = math.max(var_219_11, arg_216_1.talkMaxDuration)

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_20 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_10) / var_219_20

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_10 + var_219_20 and arg_216_1.time_ < var_219_10 + var_219_20 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play324161051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324161051
		arg_220_1.duration_ = 6.67

		local var_220_0 = {
			zh = 6.166,
			ja = 6.666
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
				arg_220_0:Play324161052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1054ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1054ui_story == nil then
				arg_220_1.var_.characterEffect1054ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1054ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1054ui_story then
				arg_220_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_223_4 = arg_220_1.actors_["6148ui_story"]
			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 and not isNil(var_223_4) and arg_220_1.var_.characterEffect6148ui_story == nil then
				arg_220_1.var_.characterEffect6148ui_story = var_223_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_6 = 0.200000002980232

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_6 and not isNil(var_223_4) then
				local var_223_7 = (arg_220_1.time_ - var_223_5) / var_223_6

				if arg_220_1.var_.characterEffect6148ui_story and not isNil(var_223_4) then
					local var_223_8 = Mathf.Lerp(0, 0.5, var_223_7)

					arg_220_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_220_1.var_.characterEffect6148ui_story.fillRatio = var_223_8
				end
			end

			if arg_220_1.time_ >= var_223_5 + var_223_6 and arg_220_1.time_ < var_223_5 + var_223_6 + arg_223_0 and not isNil(var_223_4) and arg_220_1.var_.characterEffect6148ui_story then
				local var_223_9 = 0.5

				arg_220_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_220_1.var_.characterEffect6148ui_story.fillRatio = var_223_9
			end

			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 then
				arg_220_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_2")
			end

			local var_223_11 = 0

			if var_223_11 < arg_220_1.time_ and arg_220_1.time_ <= var_223_11 + arg_223_0 then
				arg_220_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_223_12 = 0
			local var_223_13 = 0.7

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_14 = arg_220_1:FormatText(StoryNameCfg[1487].name)

				arg_220_1.leftNameTxt_.text = var_223_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_15 = arg_220_1:GetWordFromCfg(324161051)
				local var_223_16 = arg_220_1:FormatText(var_223_15.content)

				arg_220_1.text_.text = var_223_16

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_17 = 28
				local var_223_18 = utf8.len(var_223_16)
				local var_223_19 = var_223_17 <= 0 and var_223_13 or var_223_13 * (var_223_18 / var_223_17)

				if var_223_19 > 0 and var_223_13 < var_223_19 then
					arg_220_1.talkMaxDuration = var_223_19

					if var_223_19 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_19 + var_223_12
					end
				end

				arg_220_1.text_.text = var_223_16
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161051", "story_v_out_324161.awb") ~= 0 then
					local var_223_20 = manager.audio:GetVoiceLength("story_v_out_324161", "324161051", "story_v_out_324161.awb") / 1000

					if var_223_20 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_20 + var_223_12
					end

					if var_223_15.prefab_name ~= "" and arg_220_1.actors_[var_223_15.prefab_name] ~= nil then
						local var_223_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_15.prefab_name].transform, "story_v_out_324161", "324161051", "story_v_out_324161.awb")

						arg_220_1:RecordAudio("324161051", var_223_21)
						arg_220_1:RecordAudio("324161051", var_223_21)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324161", "324161051", "story_v_out_324161.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324161", "324161051", "story_v_out_324161.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_22 = math.max(var_223_13, arg_220_1.talkMaxDuration)

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_22 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_12) / var_223_22

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_12 + var_223_22 and arg_220_1.time_ < var_223_12 + var_223_22 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play324161052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324161052
		arg_224_1.duration_ = 3.33

		local var_224_0 = {
			zh = 3.333,
			ja = 3.3
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
				arg_224_0:Play324161053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["6148ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect6148ui_story == nil then
				arg_224_1.var_.characterEffect6148ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect6148ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect6148ui_story then
				arg_224_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_227_4 = arg_224_1.actors_["1054ui_story"]
			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1054ui_story == nil then
				arg_224_1.var_.characterEffect1054ui_story = var_227_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.200000002980232

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_6 and not isNil(var_227_4) then
				local var_227_7 = (arg_224_1.time_ - var_227_5) / var_227_6

				if arg_224_1.var_.characterEffect1054ui_story and not isNil(var_227_4) then
					local var_227_8 = Mathf.Lerp(0, 0.5, var_227_7)

					arg_224_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1054ui_story.fillRatio = var_227_8
				end
			end

			if arg_224_1.time_ >= var_227_5 + var_227_6 and arg_224_1.time_ < var_227_5 + var_227_6 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1054ui_story then
				local var_227_9 = 0.5

				arg_224_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1054ui_story.fillRatio = var_227_9
			end

			local var_227_10 = 0
			local var_227_11 = 0.275

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_12 = arg_224_1:FormatText(StoryNameCfg[1488].name)

				arg_224_1.leftNameTxt_.text = var_227_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_13 = arg_224_1:GetWordFromCfg(324161052)
				local var_227_14 = arg_224_1:FormatText(var_227_13.content)

				arg_224_1.text_.text = var_227_14

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_15 = 11
				local var_227_16 = utf8.len(var_227_14)
				local var_227_17 = var_227_15 <= 0 and var_227_11 or var_227_11 * (var_227_16 / var_227_15)

				if var_227_17 > 0 and var_227_11 < var_227_17 then
					arg_224_1.talkMaxDuration = var_227_17

					if var_227_17 + var_227_10 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_17 + var_227_10
					end
				end

				arg_224_1.text_.text = var_227_14
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161052", "story_v_out_324161.awb") ~= 0 then
					local var_227_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161052", "story_v_out_324161.awb") / 1000

					if var_227_18 + var_227_10 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_18 + var_227_10
					end

					if var_227_13.prefab_name ~= "" and arg_224_1.actors_[var_227_13.prefab_name] ~= nil then
						local var_227_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_13.prefab_name].transform, "story_v_out_324161", "324161052", "story_v_out_324161.awb")

						arg_224_1:RecordAudio("324161052", var_227_19)
						arg_224_1:RecordAudio("324161052", var_227_19)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324161", "324161052", "story_v_out_324161.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324161", "324161052", "story_v_out_324161.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_20 = math.max(var_227_11, arg_224_1.talkMaxDuration)

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_20 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_10) / var_227_20

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_10 + var_227_20 and arg_224_1.time_ < var_227_10 + var_227_20 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324161053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324161053
		arg_228_1.duration_ = 5.33

		local var_228_0 = {
			zh = 5.333,
			ja = 4.633
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
				arg_228_0:Play324161054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1054ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1054ui_story == nil then
				arg_228_1.var_.characterEffect1054ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1054ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1054ui_story then
				arg_228_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_231_4 = arg_228_1.actors_["6148ui_story"]
			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect6148ui_story == nil then
				arg_228_1.var_.characterEffect6148ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_6 = 0.200000002980232

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 and not isNil(var_231_4) then
				local var_231_7 = (arg_228_1.time_ - var_231_5) / var_231_6

				if arg_228_1.var_.characterEffect6148ui_story and not isNil(var_231_4) then
					local var_231_8 = Mathf.Lerp(0, 0.5, var_231_7)

					arg_228_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_228_1.var_.characterEffect6148ui_story.fillRatio = var_231_8
				end
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect6148ui_story then
				local var_231_9 = 0.5

				arg_228_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_228_1.var_.characterEffect6148ui_story.fillRatio = var_231_9
			end

			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 then
				arg_228_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_231_11 = 0

			if var_231_11 < arg_228_1.time_ and arg_228_1.time_ <= var_231_11 + arg_231_0 then
				arg_228_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_231_12 = 0
			local var_231_13 = 0.475

			if var_231_12 < arg_228_1.time_ and arg_228_1.time_ <= var_231_12 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_14 = arg_228_1:FormatText(StoryNameCfg[1487].name)

				arg_228_1.leftNameTxt_.text = var_231_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_15 = arg_228_1:GetWordFromCfg(324161053)
				local var_231_16 = arg_228_1:FormatText(var_231_15.content)

				arg_228_1.text_.text = var_231_16

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_17 = 19
				local var_231_18 = utf8.len(var_231_16)
				local var_231_19 = var_231_17 <= 0 and var_231_13 or var_231_13 * (var_231_18 / var_231_17)

				if var_231_19 > 0 and var_231_13 < var_231_19 then
					arg_228_1.talkMaxDuration = var_231_19

					if var_231_19 + var_231_12 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_19 + var_231_12
					end
				end

				arg_228_1.text_.text = var_231_16
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161053", "story_v_out_324161.awb") ~= 0 then
					local var_231_20 = manager.audio:GetVoiceLength("story_v_out_324161", "324161053", "story_v_out_324161.awb") / 1000

					if var_231_20 + var_231_12 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_20 + var_231_12
					end

					if var_231_15.prefab_name ~= "" and arg_228_1.actors_[var_231_15.prefab_name] ~= nil then
						local var_231_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_15.prefab_name].transform, "story_v_out_324161", "324161053", "story_v_out_324161.awb")

						arg_228_1:RecordAudio("324161053", var_231_21)
						arg_228_1:RecordAudio("324161053", var_231_21)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324161", "324161053", "story_v_out_324161.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324161", "324161053", "story_v_out_324161.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_22 = math.max(var_231_13, arg_228_1.talkMaxDuration)

			if var_231_12 <= arg_228_1.time_ and arg_228_1.time_ < var_231_12 + var_231_22 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_12) / var_231_22

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_12 + var_231_22 and arg_228_1.time_ < var_231_12 + var_231_22 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324161054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324161054
		arg_232_1.duration_ = 4.2

		local var_232_0 = {
			zh = 3.6,
			ja = 4.2
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
				arg_232_0:Play324161055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["6148ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect6148ui_story == nil then
				arg_232_1.var_.characterEffect6148ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect6148ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect6148ui_story then
				arg_232_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_235_4 = arg_232_1.actors_["1054ui_story"]
			local var_235_5 = 0

			if var_235_5 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 and not isNil(var_235_4) and arg_232_1.var_.characterEffect1054ui_story == nil then
				arg_232_1.var_.characterEffect1054ui_story = var_235_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_6 = 0.200000002980232

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_6 and not isNil(var_235_4) then
				local var_235_7 = (arg_232_1.time_ - var_235_5) / var_235_6

				if arg_232_1.var_.characterEffect1054ui_story and not isNil(var_235_4) then
					local var_235_8 = Mathf.Lerp(0, 0.5, var_235_7)

					arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1054ui_story.fillRatio = var_235_8
				end
			end

			if arg_232_1.time_ >= var_235_5 + var_235_6 and arg_232_1.time_ < var_235_5 + var_235_6 + arg_235_0 and not isNil(var_235_4) and arg_232_1.var_.characterEffect1054ui_story then
				local var_235_9 = 0.5

				arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1054ui_story.fillRatio = var_235_9
			end

			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				arg_232_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_235_11 = 0

			if var_235_11 < arg_232_1.time_ and arg_232_1.time_ <= var_235_11 + arg_235_0 then
				arg_232_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_235_12 = 0
			local var_235_13 = 0.275

			if var_235_12 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_14 = arg_232_1:FormatText(StoryNameCfg[1488].name)

				arg_232_1.leftNameTxt_.text = var_235_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_15 = arg_232_1:GetWordFromCfg(324161054)
				local var_235_16 = arg_232_1:FormatText(var_235_15.content)

				arg_232_1.text_.text = var_235_16

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_17 = 11
				local var_235_18 = utf8.len(var_235_16)
				local var_235_19 = var_235_17 <= 0 and var_235_13 or var_235_13 * (var_235_18 / var_235_17)

				if var_235_19 > 0 and var_235_13 < var_235_19 then
					arg_232_1.talkMaxDuration = var_235_19

					if var_235_19 + var_235_12 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_19 + var_235_12
					end
				end

				arg_232_1.text_.text = var_235_16
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161054", "story_v_out_324161.awb") ~= 0 then
					local var_235_20 = manager.audio:GetVoiceLength("story_v_out_324161", "324161054", "story_v_out_324161.awb") / 1000

					if var_235_20 + var_235_12 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_20 + var_235_12
					end

					if var_235_15.prefab_name ~= "" and arg_232_1.actors_[var_235_15.prefab_name] ~= nil then
						local var_235_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_15.prefab_name].transform, "story_v_out_324161", "324161054", "story_v_out_324161.awb")

						arg_232_1:RecordAudio("324161054", var_235_21)
						arg_232_1:RecordAudio("324161054", var_235_21)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_324161", "324161054", "story_v_out_324161.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_324161", "324161054", "story_v_out_324161.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_22 = math.max(var_235_13, arg_232_1.talkMaxDuration)

			if var_235_12 <= arg_232_1.time_ and arg_232_1.time_ < var_235_12 + var_235_22 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_12) / var_235_22

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_12 + var_235_22 and arg_232_1.time_ < var_235_12 + var_235_22 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324161055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324161055
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324161056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1054ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos1054ui_story = var_239_0.localPosition

				local var_239_2 = GameObjectTools.GetOrAddComponent(var_239_0.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(false)
				end
			end

			local var_239_3 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_3 then
				local var_239_4 = (arg_236_1.time_ - var_239_1) / var_239_3
				local var_239_5 = Vector3.New(0, 100, 0)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1054ui_story, var_239_5, var_239_4)

				local var_239_6 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_6.x, var_239_6.y, var_239_6.z)

				local var_239_7 = var_239_0.localEulerAngles

				var_239_7.z = 0
				var_239_7.x = 0
				var_239_0.localEulerAngles = var_239_7
			end

			if arg_236_1.time_ >= var_239_1 + var_239_3 and arg_236_1.time_ < var_239_1 + var_239_3 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_239_11 = arg_236_1.actors_["6148ui_story"].transform
			local var_239_12 = 0

			if var_239_12 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 then
				arg_236_1.var_.moveOldPos6148ui_story = var_239_11.localPosition

				local var_239_13 = GameObjectTools.GetOrAddComponent(var_239_11.gameObject, typeof(DynamicBoneHelper))

				if var_239_13 then
					var_239_13:EnableDynamicBone(false)
				end
			end

			local var_239_14 = 0.001

			if var_239_12 <= arg_236_1.time_ and arg_236_1.time_ < var_239_12 + var_239_14 then
				local var_239_15 = (arg_236_1.time_ - var_239_12) / var_239_14
				local var_239_16 = Vector3.New(0, 100, 0)

				var_239_11.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos6148ui_story, var_239_16, var_239_15)

				local var_239_17 = manager.ui.mainCamera.transform.position - var_239_11.position

				var_239_11.forward = Vector3.New(var_239_17.x, var_239_17.y, var_239_17.z)

				local var_239_18 = var_239_11.localEulerAngles

				var_239_18.z = 0
				var_239_18.x = 0
				var_239_11.localEulerAngles = var_239_18
			end

			if arg_236_1.time_ >= var_239_12 + var_239_14 and arg_236_1.time_ < var_239_12 + var_239_14 + arg_239_0 then
				var_239_11.localPosition = Vector3.New(0, 100, 0)

				local var_239_19 = manager.ui.mainCamera.transform.position - var_239_11.position

				var_239_11.forward = Vector3.New(var_239_19.x, var_239_19.y, var_239_19.z)

				local var_239_20 = var_239_11.localEulerAngles

				var_239_20.z = 0
				var_239_20.x = 0
				var_239_11.localEulerAngles = var_239_20

				local var_239_21 = GameObjectTools.GetOrAddComponent(var_239_11.gameObject, typeof(DynamicBoneHelper))

				if var_239_21 then
					var_239_21:EnableDynamicBone(true)
				end
			end

			local var_239_22 = arg_236_1.actors_["6148ui_story"]
			local var_239_23 = 0

			if var_239_23 < arg_236_1.time_ and arg_236_1.time_ <= var_239_23 + arg_239_0 and not isNil(var_239_22) and arg_236_1.var_.characterEffect6148ui_story == nil then
				arg_236_1.var_.characterEffect6148ui_story = var_239_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_24 = 0.200000002980232

			if var_239_23 <= arg_236_1.time_ and arg_236_1.time_ < var_239_23 + var_239_24 and not isNil(var_239_22) then
				local var_239_25 = (arg_236_1.time_ - var_239_23) / var_239_24

				if arg_236_1.var_.characterEffect6148ui_story and not isNil(var_239_22) then
					local var_239_26 = Mathf.Lerp(0, 0.5, var_239_25)

					arg_236_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_236_1.var_.characterEffect6148ui_story.fillRatio = var_239_26
				end
			end

			if arg_236_1.time_ >= var_239_23 + var_239_24 and arg_236_1.time_ < var_239_23 + var_239_24 + arg_239_0 and not isNil(var_239_22) and arg_236_1.var_.characterEffect6148ui_story then
				local var_239_27 = 0.5

				arg_236_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_236_1.var_.characterEffect6148ui_story.fillRatio = var_239_27
			end

			local var_239_28 = 0
			local var_239_29 = 1.025

			if var_239_28 < arg_236_1.time_ and arg_236_1.time_ <= var_239_28 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_30 = arg_236_1:GetWordFromCfg(324161055)
				local var_239_31 = arg_236_1:FormatText(var_239_30.content)

				arg_236_1.text_.text = var_239_31

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_32 = 41
				local var_239_33 = utf8.len(var_239_31)
				local var_239_34 = var_239_32 <= 0 and var_239_29 or var_239_29 * (var_239_33 / var_239_32)

				if var_239_34 > 0 and var_239_29 < var_239_34 then
					arg_236_1.talkMaxDuration = var_239_34

					if var_239_34 + var_239_28 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_34 + var_239_28
					end
				end

				arg_236_1.text_.text = var_239_31
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_35 = math.max(var_239_29, arg_236_1.talkMaxDuration)

			if var_239_28 <= arg_236_1.time_ and arg_236_1.time_ < var_239_28 + var_239_35 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_28) / var_239_35

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_28 + var_239_35 and arg_236_1.time_ < var_239_28 + var_239_35 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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

		arg_236_1:InitPlayNodeList()
	end,
	Play324161056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324161056
		arg_240_1.duration_ = 6.33

		local var_240_0 = {
			zh = 6.333,
			ja = 5.966
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
				arg_240_0:Play324161057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["6148ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos6148ui_story = var_243_0.localPosition

				local var_243_2 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(false)
				end
			end

			local var_243_3 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_3 then
				local var_243_4 = (arg_240_1.time_ - var_243_1) / var_243_3
				local var_243_5 = Vector3.New(0.7, -0.985, -6)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos6148ui_story, var_243_5, var_243_4)

				local var_243_6 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_6.x, var_243_6.y, var_243_6.z)

				local var_243_7 = var_243_0.localEulerAngles

				var_243_7.z = 0
				var_243_7.x = 0
				var_243_0.localEulerAngles = var_243_7
			end

			if arg_240_1.time_ >= var_243_1 + var_243_3 and arg_240_1.time_ < var_243_1 + var_243_3 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_243_8 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_8.x, var_243_8.y, var_243_8.z)

				local var_243_9 = var_243_0.localEulerAngles

				var_243_9.z = 0
				var_243_9.x = 0
				var_243_0.localEulerAngles = var_243_9

				local var_243_10 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_10 then
					var_243_10:EnableDynamicBone(true)
				end
			end

			local var_243_11 = arg_240_1.actors_["1054ui_story"]
			local var_243_12 = 0

			if var_243_12 < arg_240_1.time_ and arg_240_1.time_ <= var_243_12 + arg_243_0 and not isNil(var_243_11) and arg_240_1.var_.characterEffect1054ui_story == nil then
				arg_240_1.var_.characterEffect1054ui_story = var_243_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_13 = 0.200000002980232

			if var_243_12 <= arg_240_1.time_ and arg_240_1.time_ < var_243_12 + var_243_13 and not isNil(var_243_11) then
				local var_243_14 = (arg_240_1.time_ - var_243_12) / var_243_13

				if arg_240_1.var_.characterEffect1054ui_story and not isNil(var_243_11) then
					local var_243_15 = Mathf.Lerp(0, 0.5, var_243_14)

					arg_240_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1054ui_story.fillRatio = var_243_15
				end
			end

			if arg_240_1.time_ >= var_243_12 + var_243_13 and arg_240_1.time_ < var_243_12 + var_243_13 + arg_243_0 and not isNil(var_243_11) and arg_240_1.var_.characterEffect1054ui_story then
				local var_243_16 = 0.5

				arg_240_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1054ui_story.fillRatio = var_243_16
			end

			local var_243_17 = arg_240_1.actors_["6148ui_story"]
			local var_243_18 = 0

			if var_243_18 < arg_240_1.time_ and arg_240_1.time_ <= var_243_18 + arg_243_0 and not isNil(var_243_17) and arg_240_1.var_.characterEffect6148ui_story == nil then
				arg_240_1.var_.characterEffect6148ui_story = var_243_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_19 = 0.200000002980232

			if var_243_18 <= arg_240_1.time_ and arg_240_1.time_ < var_243_18 + var_243_19 and not isNil(var_243_17) then
				local var_243_20 = (arg_240_1.time_ - var_243_18) / var_243_19

				if arg_240_1.var_.characterEffect6148ui_story and not isNil(var_243_17) then
					arg_240_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_18 + var_243_19 and arg_240_1.time_ < var_243_18 + var_243_19 + arg_243_0 and not isNil(var_243_17) and arg_240_1.var_.characterEffect6148ui_story then
				arg_240_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_243_21 = 0

			if var_243_21 < arg_240_1.time_ and arg_240_1.time_ <= var_243_21 + arg_243_0 then
				arg_240_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_243_22 = 0

			if var_243_22 < arg_240_1.time_ and arg_240_1.time_ <= var_243_22 + arg_243_0 then
				arg_240_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_243_23 = 0
			local var_243_24 = 0.6

			if var_243_23 < arg_240_1.time_ and arg_240_1.time_ <= var_243_23 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_25 = arg_240_1:FormatText(StoryNameCfg[1488].name)

				arg_240_1.leftNameTxt_.text = var_243_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_26 = arg_240_1:GetWordFromCfg(324161056)
				local var_243_27 = arg_240_1:FormatText(var_243_26.content)

				arg_240_1.text_.text = var_243_27

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_28 = 24
				local var_243_29 = utf8.len(var_243_27)
				local var_243_30 = var_243_28 <= 0 and var_243_24 or var_243_24 * (var_243_29 / var_243_28)

				if var_243_30 > 0 and var_243_24 < var_243_30 then
					arg_240_1.talkMaxDuration = var_243_30

					if var_243_30 + var_243_23 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_30 + var_243_23
					end
				end

				arg_240_1.text_.text = var_243_27
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161056", "story_v_out_324161.awb") ~= 0 then
					local var_243_31 = manager.audio:GetVoiceLength("story_v_out_324161", "324161056", "story_v_out_324161.awb") / 1000

					if var_243_31 + var_243_23 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_31 + var_243_23
					end

					if var_243_26.prefab_name ~= "" and arg_240_1.actors_[var_243_26.prefab_name] ~= nil then
						local var_243_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_26.prefab_name].transform, "story_v_out_324161", "324161056", "story_v_out_324161.awb")

						arg_240_1:RecordAudio("324161056", var_243_32)
						arg_240_1:RecordAudio("324161056", var_243_32)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324161", "324161056", "story_v_out_324161.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324161", "324161056", "story_v_out_324161.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_33 = math.max(var_243_24, arg_240_1.talkMaxDuration)

			if var_243_23 <= arg_240_1.time_ and arg_240_1.time_ < var_243_23 + var_243_33 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_23) / var_243_33

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_23 + var_243_33 and arg_240_1.time_ < var_243_23 + var_243_33 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
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

		arg_240_1:InitPlayNodeList()
	end,
	Play324161057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324161057
		arg_244_1.duration_ = 3.87

		local var_244_0 = {
			zh = 3.033,
			ja = 3.866
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
				arg_244_0:Play324161058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1054ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1054ui_story == nil then
				arg_244_1.var_.characterEffect1054ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1054ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1054ui_story then
				arg_244_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_247_4 = arg_244_1.actors_["1054ui_story"].transform
			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.var_.moveOldPos1054ui_story = var_247_4.localPosition

				local var_247_6 = GameObjectTools.GetOrAddComponent(var_247_4.gameObject, typeof(DynamicBoneHelper))

				if var_247_6 then
					var_247_6:EnableDynamicBone(false)
				end
			end

			local var_247_7 = 0.001

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_7 then
				local var_247_8 = (arg_244_1.time_ - var_247_5) / var_247_7
				local var_247_9 = Vector3.New(-0.7, -0.985, -6)

				var_247_4.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1054ui_story, var_247_9, var_247_8)

				local var_247_10 = manager.ui.mainCamera.transform.position - var_247_4.position

				var_247_4.forward = Vector3.New(var_247_10.x, var_247_10.y, var_247_10.z)

				local var_247_11 = var_247_4.localEulerAngles

				var_247_11.z = 0
				var_247_11.x = 0
				var_247_4.localEulerAngles = var_247_11
			end

			if arg_244_1.time_ >= var_247_5 + var_247_7 and arg_244_1.time_ < var_247_5 + var_247_7 + arg_247_0 then
				var_247_4.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_247_12 = manager.ui.mainCamera.transform.position - var_247_4.position

				var_247_4.forward = Vector3.New(var_247_12.x, var_247_12.y, var_247_12.z)

				local var_247_13 = var_247_4.localEulerAngles

				var_247_13.z = 0
				var_247_13.x = 0
				var_247_4.localEulerAngles = var_247_13

				local var_247_14 = GameObjectTools.GetOrAddComponent(var_247_4.gameObject, typeof(DynamicBoneHelper))

				if var_247_14 then
					var_247_14:EnableDynamicBone(true)
				end
			end

			local var_247_15 = arg_244_1.actors_["6148ui_story"]
			local var_247_16 = 0

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 and not isNil(var_247_15) and arg_244_1.var_.characterEffect6148ui_story == nil then
				arg_244_1.var_.characterEffect6148ui_story = var_247_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_17 = 0.200000002980232

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_17 and not isNil(var_247_15) then
				local var_247_18 = (arg_244_1.time_ - var_247_16) / var_247_17

				if arg_244_1.var_.characterEffect6148ui_story and not isNil(var_247_15) then
					local var_247_19 = Mathf.Lerp(0, 0.5, var_247_18)

					arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_244_1.var_.characterEffect6148ui_story.fillRatio = var_247_19
				end
			end

			if arg_244_1.time_ >= var_247_16 + var_247_17 and arg_244_1.time_ < var_247_16 + var_247_17 + arg_247_0 and not isNil(var_247_15) and arg_244_1.var_.characterEffect6148ui_story then
				local var_247_20 = 0.5

				arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_244_1.var_.characterEffect6148ui_story.fillRatio = var_247_20
			end

			local var_247_21 = 0

			if var_247_21 < arg_244_1.time_ and arg_244_1.time_ <= var_247_21 + arg_247_0 then
				arg_244_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_247_22 = 0

			if var_247_22 < arg_244_1.time_ and arg_244_1.time_ <= var_247_22 + arg_247_0 then
				arg_244_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_247_23 = 0
			local var_247_24 = 0.35

			if var_247_23 < arg_244_1.time_ and arg_244_1.time_ <= var_247_23 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_25 = arg_244_1:FormatText(StoryNameCfg[1487].name)

				arg_244_1.leftNameTxt_.text = var_247_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_26 = arg_244_1:GetWordFromCfg(324161057)
				local var_247_27 = arg_244_1:FormatText(var_247_26.content)

				arg_244_1.text_.text = var_247_27

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_28 = 14
				local var_247_29 = utf8.len(var_247_27)
				local var_247_30 = var_247_28 <= 0 and var_247_24 or var_247_24 * (var_247_29 / var_247_28)

				if var_247_30 > 0 and var_247_24 < var_247_30 then
					arg_244_1.talkMaxDuration = var_247_30

					if var_247_30 + var_247_23 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_30 + var_247_23
					end
				end

				arg_244_1.text_.text = var_247_27
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161057", "story_v_out_324161.awb") ~= 0 then
					local var_247_31 = manager.audio:GetVoiceLength("story_v_out_324161", "324161057", "story_v_out_324161.awb") / 1000

					if var_247_31 + var_247_23 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_31 + var_247_23
					end

					if var_247_26.prefab_name ~= "" and arg_244_1.actors_[var_247_26.prefab_name] ~= nil then
						local var_247_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_26.prefab_name].transform, "story_v_out_324161", "324161057", "story_v_out_324161.awb")

						arg_244_1:RecordAudio("324161057", var_247_32)
						arg_244_1:RecordAudio("324161057", var_247_32)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324161", "324161057", "story_v_out_324161.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324161", "324161057", "story_v_out_324161.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_33 = math.max(var_247_24, arg_244_1.talkMaxDuration)

			if var_247_23 <= arg_244_1.time_ and arg_244_1.time_ < var_247_23 + var_247_33 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_23) / var_247_33

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_23 + var_247_33 and arg_244_1.time_ < var_247_23 + var_247_33 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play324161058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324161058
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324161059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1054ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos1054ui_story = var_251_0.localPosition

				local var_251_2 = GameObjectTools.GetOrAddComponent(var_251_0.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(false)
				end
			end

			local var_251_3 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_3 then
				local var_251_4 = (arg_248_1.time_ - var_251_1) / var_251_3
				local var_251_5 = Vector3.New(0, 100, 0)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1054ui_story, var_251_5, var_251_4)

				local var_251_6 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_6.x, var_251_6.y, var_251_6.z)

				local var_251_7 = var_251_0.localEulerAngles

				var_251_7.z = 0
				var_251_7.x = 0
				var_251_0.localEulerAngles = var_251_7
			end

			if arg_248_1.time_ >= var_251_1 + var_251_3 and arg_248_1.time_ < var_251_1 + var_251_3 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, 100, 0)

				local var_251_8 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_8.x, var_251_8.y, var_251_8.z)

				local var_251_9 = var_251_0.localEulerAngles

				var_251_9.z = 0
				var_251_9.x = 0
				var_251_0.localEulerAngles = var_251_9

				local var_251_10 = GameObjectTools.GetOrAddComponent(var_251_0.gameObject, typeof(DynamicBoneHelper))

				if var_251_10 then
					var_251_10:EnableDynamicBone(true)
				end
			end

			local var_251_11 = arg_248_1.actors_["6148ui_story"].transform
			local var_251_12 = 0

			if var_251_12 < arg_248_1.time_ and arg_248_1.time_ <= var_251_12 + arg_251_0 then
				arg_248_1.var_.moveOldPos6148ui_story = var_251_11.localPosition

				local var_251_13 = GameObjectTools.GetOrAddComponent(var_251_11.gameObject, typeof(DynamicBoneHelper))

				if var_251_13 then
					var_251_13:EnableDynamicBone(false)
				end
			end

			local var_251_14 = 0.001

			if var_251_12 <= arg_248_1.time_ and arg_248_1.time_ < var_251_12 + var_251_14 then
				local var_251_15 = (arg_248_1.time_ - var_251_12) / var_251_14
				local var_251_16 = Vector3.New(0, 100, 0)

				var_251_11.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos6148ui_story, var_251_16, var_251_15)

				local var_251_17 = manager.ui.mainCamera.transform.position - var_251_11.position

				var_251_11.forward = Vector3.New(var_251_17.x, var_251_17.y, var_251_17.z)

				local var_251_18 = var_251_11.localEulerAngles

				var_251_18.z = 0
				var_251_18.x = 0
				var_251_11.localEulerAngles = var_251_18
			end

			if arg_248_1.time_ >= var_251_12 + var_251_14 and arg_248_1.time_ < var_251_12 + var_251_14 + arg_251_0 then
				var_251_11.localPosition = Vector3.New(0, 100, 0)

				local var_251_19 = manager.ui.mainCamera.transform.position - var_251_11.position

				var_251_11.forward = Vector3.New(var_251_19.x, var_251_19.y, var_251_19.z)

				local var_251_20 = var_251_11.localEulerAngles

				var_251_20.z = 0
				var_251_20.x = 0
				var_251_11.localEulerAngles = var_251_20

				local var_251_21 = GameObjectTools.GetOrAddComponent(var_251_11.gameObject, typeof(DynamicBoneHelper))

				if var_251_21 then
					var_251_21:EnableDynamicBone(true)
				end
			end

			local var_251_22 = arg_248_1.actors_["1054ui_story"]
			local var_251_23 = 0

			if var_251_23 < arg_248_1.time_ and arg_248_1.time_ <= var_251_23 + arg_251_0 and not isNil(var_251_22) and arg_248_1.var_.characterEffect1054ui_story == nil then
				arg_248_1.var_.characterEffect1054ui_story = var_251_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_24 = 0.200000002980232

			if var_251_23 <= arg_248_1.time_ and arg_248_1.time_ < var_251_23 + var_251_24 and not isNil(var_251_22) then
				local var_251_25 = (arg_248_1.time_ - var_251_23) / var_251_24

				if arg_248_1.var_.characterEffect1054ui_story and not isNil(var_251_22) then
					local var_251_26 = Mathf.Lerp(0, 0.5, var_251_25)

					arg_248_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1054ui_story.fillRatio = var_251_26
				end
			end

			if arg_248_1.time_ >= var_251_23 + var_251_24 and arg_248_1.time_ < var_251_23 + var_251_24 + arg_251_0 and not isNil(var_251_22) and arg_248_1.var_.characterEffect1054ui_story then
				local var_251_27 = 0.5

				arg_248_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1054ui_story.fillRatio = var_251_27
			end

			local var_251_28 = 0
			local var_251_29 = 1.075

			if var_251_28 < arg_248_1.time_ and arg_248_1.time_ <= var_251_28 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_30 = arg_248_1:GetWordFromCfg(324161058)
				local var_251_31 = arg_248_1:FormatText(var_251_30.content)

				arg_248_1.text_.text = var_251_31

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_32 = 43
				local var_251_33 = utf8.len(var_251_31)
				local var_251_34 = var_251_32 <= 0 and var_251_29 or var_251_29 * (var_251_33 / var_251_32)

				if var_251_34 > 0 and var_251_29 < var_251_34 then
					arg_248_1.talkMaxDuration = var_251_34

					if var_251_34 + var_251_28 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_34 + var_251_28
					end
				end

				arg_248_1.text_.text = var_251_31
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_35 = math.max(var_251_29, arg_248_1.talkMaxDuration)

			if var_251_28 <= arg_248_1.time_ and arg_248_1.time_ < var_251_28 + var_251_35 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_28) / var_251_35

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_28 + var_251_35 and arg_248_1.time_ < var_251_28 + var_251_35 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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

		arg_248_1:InitPlayNodeList()
	end,
	Play324161059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324161059
		arg_252_1.duration_ = 7.57

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324161060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = "MS2404"

			if arg_252_1.bgs_[var_255_0] == nil then
				local var_255_1 = Object.Instantiate(arg_252_1.paintGo_)

				var_255_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_255_0)
				var_255_1.name = var_255_0
				var_255_1.transform.parent = arg_252_1.stage_.transform
				var_255_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.bgs_[var_255_0] = var_255_1
			end

			local var_255_2 = 0.983333333333333

			if var_255_2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_2 + arg_255_0 then
				local var_255_3 = manager.ui.mainCamera.transform.localPosition
				local var_255_4 = Vector3.New(0, 0, 10) + Vector3.New(var_255_3.x, var_255_3.y, 0)
				local var_255_5 = arg_252_1.bgs_.MS2404

				var_255_5.transform.localPosition = var_255_4
				var_255_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_6 = var_255_5:GetComponent("SpriteRenderer")

				if var_255_6 and var_255_6.sprite then
					local var_255_7 = (var_255_5.transform.localPosition - var_255_3).z
					local var_255_8 = manager.ui.mainCameraCom_
					local var_255_9 = 2 * var_255_7 * Mathf.Tan(var_255_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_255_10 = var_255_9 * var_255_8.aspect
					local var_255_11 = var_255_6.sprite.bounds.size.x
					local var_255_12 = var_255_6.sprite.bounds.size.y
					local var_255_13 = var_255_10 / var_255_11
					local var_255_14 = var_255_9 / var_255_12
					local var_255_15 = var_255_14 < var_255_13 and var_255_13 or var_255_14

					var_255_5.transform.localScale = Vector3.New(var_255_15, var_255_15, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "MS2404" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_16 = 0

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			local var_255_17 = 0.3

			if arg_252_1.time_ >= var_255_16 + var_255_17 and arg_252_1.time_ < var_255_16 + var_255_17 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_18 = 0

			if var_255_18 < arg_252_1.time_ and arg_252_1.time_ <= var_255_18 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_19 = 1

			if var_255_18 <= arg_252_1.time_ and arg_252_1.time_ < var_255_18 + var_255_19 then
				local var_255_20 = (arg_252_1.time_ - var_255_18) / var_255_19
				local var_255_21 = Color.New(0, 0, 0)

				var_255_21.a = Mathf.Lerp(0, 1, var_255_20)
				arg_252_1.mask_.color = var_255_21
			end

			if arg_252_1.time_ >= var_255_18 + var_255_19 and arg_252_1.time_ < var_255_18 + var_255_19 + arg_255_0 then
				local var_255_22 = Color.New(0, 0, 0)

				var_255_22.a = 1
				arg_252_1.mask_.color = var_255_22
			end

			local var_255_23 = 1

			if var_255_23 < arg_252_1.time_ and arg_252_1.time_ <= var_255_23 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_24 = 1

			if var_255_23 <= arg_252_1.time_ and arg_252_1.time_ < var_255_23 + var_255_24 then
				local var_255_25 = (arg_252_1.time_ - var_255_23) / var_255_24
				local var_255_26 = Color.New(0, 0, 0)

				var_255_26.a = Mathf.Lerp(1, 0, var_255_25)
				arg_252_1.mask_.color = var_255_26
			end

			if arg_252_1.time_ >= var_255_23 + var_255_24 and arg_252_1.time_ < var_255_23 + var_255_24 + arg_255_0 then
				local var_255_27 = Color.New(0, 0, 0)
				local var_255_28 = 0

				arg_252_1.mask_.enabled = false
				var_255_27.a = var_255_28
				arg_252_1.mask_.color = var_255_27
			end

			local var_255_29 = arg_252_1.bgs_.MS2404.transform
			local var_255_30 = 1

			if var_255_30 < arg_252_1.time_ and arg_252_1.time_ <= var_255_30 + arg_255_0 then
				arg_252_1.var_.moveOldPosMS2404 = var_255_29.localPosition
			end

			local var_255_31 = 1.7

			if var_255_30 <= arg_252_1.time_ and arg_252_1.time_ < var_255_30 + var_255_31 then
				local var_255_32 = (arg_252_1.time_ - var_255_30) / var_255_31
				local var_255_33 = Vector3.New(0, 0.03, 5)

				var_255_29.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPosMS2404, var_255_33, var_255_32)
			end

			if arg_252_1.time_ >= var_255_30 + var_255_31 and arg_252_1.time_ < var_255_30 + var_255_31 + arg_255_0 then
				var_255_29.localPosition = Vector3.New(0, 0.03, 5)
			end

			local var_255_34 = 1

			if var_255_34 < arg_252_1.time_ and arg_252_1.time_ <= var_255_34 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			local var_255_35 = 1.7

			if arg_252_1.time_ >= var_255_34 + var_255_35 and arg_252_1.time_ < var_255_34 + var_255_35 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_36 = 1.2
			local var_255_37 = 1

			if var_255_36 < arg_252_1.time_ and arg_252_1.time_ <= var_255_36 + arg_255_0 then
				local var_255_38 = "play"
				local var_255_39 = "effect"

				arg_252_1:AudioAction(var_255_38, var_255_39, "se_story_148", "se_story_148_sword11", "")
			end

			local var_255_40 = 0.1
			local var_255_41 = 1

			if var_255_40 < arg_252_1.time_ and arg_252_1.time_ <= var_255_40 + arg_255_0 then
				local var_255_42 = "stop"
				local var_255_43 = "effect"

				arg_252_1:AudioAction(var_255_42, var_255_43, "se_story_150", "se_story_150_huatian", "")
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_44 = 2.56666666666667
			local var_255_45 = 0.7

			if var_255_44 < arg_252_1.time_ and arg_252_1.time_ <= var_255_44 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_46 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_46:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_47 = arg_252_1:GetWordFromCfg(324161059)
				local var_255_48 = arg_252_1:FormatText(var_255_47.content)

				arg_252_1.text_.text = var_255_48

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_49 = 28
				local var_255_50 = utf8.len(var_255_48)
				local var_255_51 = var_255_49 <= 0 and var_255_45 or var_255_45 * (var_255_50 / var_255_49)

				if var_255_51 > 0 and var_255_45 < var_255_51 then
					arg_252_1.talkMaxDuration = var_255_51
					var_255_44 = var_255_44 + 0.3

					if var_255_51 + var_255_44 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_51 + var_255_44
					end
				end

				arg_252_1.text_.text = var_255_48
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_52 = var_255_44 + 0.3
			local var_255_53 = math.max(var_255_45, arg_252_1.talkMaxDuration)

			if var_255_52 <= arg_252_1.time_ and arg_252_1.time_ < var_255_52 + var_255_53 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_52) / var_255_53

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_52 + var_255_53 and arg_252_1.time_ < var_255_52 + var_255_53 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 0.03, 5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play324161060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 324161060
		arg_258_1.duration_ = 2.37

		local var_258_0 = {
			zh = 2.066,
			ja = 2.366
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play324161061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["6148ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect6148ui_story == nil then
				arg_258_1.var_.characterEffect6148ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect6148ui_story and not isNil(var_261_0) then
					arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect6148ui_story then
				arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_261_4 = 0
			local var_261_5 = 0.2

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_6 = arg_258_1:FormatText(StoryNameCfg[1488].name)

				arg_258_1.leftNameTxt_.text = var_261_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_7 = arg_258_1:GetWordFromCfg(324161060)
				local var_261_8 = arg_258_1:FormatText(var_261_7.content)

				arg_258_1.text_.text = var_261_8

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 8
				local var_261_10 = utf8.len(var_261_8)
				local var_261_11 = var_261_9 <= 0 and var_261_5 or var_261_5 * (var_261_10 / var_261_9)

				if var_261_11 > 0 and var_261_5 < var_261_11 then
					arg_258_1.talkMaxDuration = var_261_11

					if var_261_11 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_11 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_8
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161060", "story_v_out_324161.awb") ~= 0 then
					local var_261_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161060", "story_v_out_324161.awb") / 1000

					if var_261_12 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_4
					end

					if var_261_7.prefab_name ~= "" and arg_258_1.actors_[var_261_7.prefab_name] ~= nil then
						local var_261_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_7.prefab_name].transform, "story_v_out_324161", "324161060", "story_v_out_324161.awb")

						arg_258_1:RecordAudio("324161060", var_261_13)
						arg_258_1:RecordAudio("324161060", var_261_13)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_324161", "324161060", "story_v_out_324161.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_324161", "324161060", "story_v_out_324161.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_14 and arg_258_1.time_ < var_261_4 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play324161061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 324161061
		arg_262_1.duration_ = 7.47

		local var_262_0 = {
			zh = 4.9,
			ja = 7.466
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
				arg_262_0:Play324161062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1054ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1054ui_story == nil then
				arg_262_1.var_.characterEffect1054ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1054ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1054ui_story then
				arg_262_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_265_4 = arg_262_1.actors_["6148ui_story"]
			local var_265_5 = 0

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect6148ui_story == nil then
				arg_262_1.var_.characterEffect6148ui_story = var_265_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_6 = 0.200000002980232

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_6 and not isNil(var_265_4) then
				local var_265_7 = (arg_262_1.time_ - var_265_5) / var_265_6

				if arg_262_1.var_.characterEffect6148ui_story and not isNil(var_265_4) then
					local var_265_8 = Mathf.Lerp(0, 0.5, var_265_7)

					arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_262_1.var_.characterEffect6148ui_story.fillRatio = var_265_8
				end
			end

			if arg_262_1.time_ >= var_265_5 + var_265_6 and arg_262_1.time_ < var_265_5 + var_265_6 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect6148ui_story then
				local var_265_9 = 0.5

				arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_262_1.var_.characterEffect6148ui_story.fillRatio = var_265_9
			end

			local var_265_10 = 0
			local var_265_11 = 0.5

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_12 = arg_262_1:FormatText(StoryNameCfg[1487].name)

				arg_262_1.leftNameTxt_.text = var_265_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_13 = arg_262_1:GetWordFromCfg(324161061)
				local var_265_14 = arg_262_1:FormatText(var_265_13.content)

				arg_262_1.text_.text = var_265_14

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_15 = 20
				local var_265_16 = utf8.len(var_265_14)
				local var_265_17 = var_265_15 <= 0 and var_265_11 or var_265_11 * (var_265_16 / var_265_15)

				if var_265_17 > 0 and var_265_11 < var_265_17 then
					arg_262_1.talkMaxDuration = var_265_17

					if var_265_17 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_17 + var_265_10
					end
				end

				arg_262_1.text_.text = var_265_14
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161061", "story_v_out_324161.awb") ~= 0 then
					local var_265_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161061", "story_v_out_324161.awb") / 1000

					if var_265_18 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_18 + var_265_10
					end

					if var_265_13.prefab_name ~= "" and arg_262_1.actors_[var_265_13.prefab_name] ~= nil then
						local var_265_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_13.prefab_name].transform, "story_v_out_324161", "324161061", "story_v_out_324161.awb")

						arg_262_1:RecordAudio("324161061", var_265_19)
						arg_262_1:RecordAudio("324161061", var_265_19)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_324161", "324161061", "story_v_out_324161.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_324161", "324161061", "story_v_out_324161.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_20 = math.max(var_265_11, arg_262_1.talkMaxDuration)

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_20 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_10) / var_265_20

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_10 + var_265_20 and arg_262_1.time_ < var_265_10 + var_265_20 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play324161062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 324161062
		arg_266_1.duration_ = 2.3

		local var_266_0 = {
			zh = 2.3,
			ja = 2.266
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play324161063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["6148ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect6148ui_story == nil then
				arg_266_1.var_.characterEffect6148ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect6148ui_story and not isNil(var_269_0) then
					arg_266_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect6148ui_story then
				arg_266_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_269_4 = arg_266_1.actors_["1054ui_story"]
			local var_269_5 = 0

			if var_269_5 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 and not isNil(var_269_4) and arg_266_1.var_.characterEffect1054ui_story == nil then
				arg_266_1.var_.characterEffect1054ui_story = var_269_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_6 = 0.200000002980232

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_6 and not isNil(var_269_4) then
				local var_269_7 = (arg_266_1.time_ - var_269_5) / var_269_6

				if arg_266_1.var_.characterEffect1054ui_story and not isNil(var_269_4) then
					local var_269_8 = Mathf.Lerp(0, 0.5, var_269_7)

					arg_266_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1054ui_story.fillRatio = var_269_8
				end
			end

			if arg_266_1.time_ >= var_269_5 + var_269_6 and arg_266_1.time_ < var_269_5 + var_269_6 + arg_269_0 and not isNil(var_269_4) and arg_266_1.var_.characterEffect1054ui_story then
				local var_269_9 = 0.5

				arg_266_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1054ui_story.fillRatio = var_269_9
			end

			local var_269_10 = 0
			local var_269_11 = 0.25

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_12 = arg_266_1:FormatText(StoryNameCfg[1488].name)

				arg_266_1.leftNameTxt_.text = var_269_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_13 = arg_266_1:GetWordFromCfg(324161062)
				local var_269_14 = arg_266_1:FormatText(var_269_13.content)

				arg_266_1.text_.text = var_269_14

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_15 = 10
				local var_269_16 = utf8.len(var_269_14)
				local var_269_17 = var_269_15 <= 0 and var_269_11 or var_269_11 * (var_269_16 / var_269_15)

				if var_269_17 > 0 and var_269_11 < var_269_17 then
					arg_266_1.talkMaxDuration = var_269_17

					if var_269_17 + var_269_10 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_17 + var_269_10
					end
				end

				arg_266_1.text_.text = var_269_14
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161062", "story_v_out_324161.awb") ~= 0 then
					local var_269_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161062", "story_v_out_324161.awb") / 1000

					if var_269_18 + var_269_10 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_18 + var_269_10
					end

					if var_269_13.prefab_name ~= "" and arg_266_1.actors_[var_269_13.prefab_name] ~= nil then
						local var_269_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_13.prefab_name].transform, "story_v_out_324161", "324161062", "story_v_out_324161.awb")

						arg_266_1:RecordAudio("324161062", var_269_19)
						arg_266_1:RecordAudio("324161062", var_269_19)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_324161", "324161062", "story_v_out_324161.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_324161", "324161062", "story_v_out_324161.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_20 = math.max(var_269_11, arg_266_1.talkMaxDuration)

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_20 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_10) / var_269_20

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_10 + var_269_20 and arg_266_1.time_ < var_269_10 + var_269_20 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play324161063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 324161063
		arg_270_1.duration_ = 5.57

		local var_270_0 = {
			zh = 5.166,
			ja = 5.566
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
				arg_270_0:Play324161064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1054ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1054ui_story == nil then
				arg_270_1.var_.characterEffect1054ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1054ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1054ui_story then
				arg_270_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_273_4 = arg_270_1.actors_["6148ui_story"]
			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.characterEffect6148ui_story == nil then
				arg_270_1.var_.characterEffect6148ui_story = var_273_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.200000002980232

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 and not isNil(var_273_4) then
				local var_273_7 = (arg_270_1.time_ - var_273_5) / var_273_6

				if arg_270_1.var_.characterEffect6148ui_story and not isNil(var_273_4) then
					local var_273_8 = Mathf.Lerp(0, 0.5, var_273_7)

					arg_270_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_270_1.var_.characterEffect6148ui_story.fillRatio = var_273_8
				end
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.characterEffect6148ui_story then
				local var_273_9 = 0.5

				arg_270_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_270_1.var_.characterEffect6148ui_story.fillRatio = var_273_9
			end

			local var_273_10 = 0
			local var_273_11 = 0.45

			if var_273_10 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_12 = arg_270_1:FormatText(StoryNameCfg[1487].name)

				arg_270_1.leftNameTxt_.text = var_273_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_13 = arg_270_1:GetWordFromCfg(324161063)
				local var_273_14 = arg_270_1:FormatText(var_273_13.content)

				arg_270_1.text_.text = var_273_14

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_15 = 18
				local var_273_16 = utf8.len(var_273_14)
				local var_273_17 = var_273_15 <= 0 and var_273_11 or var_273_11 * (var_273_16 / var_273_15)

				if var_273_17 > 0 and var_273_11 < var_273_17 then
					arg_270_1.talkMaxDuration = var_273_17

					if var_273_17 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_17 + var_273_10
					end
				end

				arg_270_1.text_.text = var_273_14
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161063", "story_v_out_324161.awb") ~= 0 then
					local var_273_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161063", "story_v_out_324161.awb") / 1000

					if var_273_18 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_18 + var_273_10
					end

					if var_273_13.prefab_name ~= "" and arg_270_1.actors_[var_273_13.prefab_name] ~= nil then
						local var_273_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_13.prefab_name].transform, "story_v_out_324161", "324161063", "story_v_out_324161.awb")

						arg_270_1:RecordAudio("324161063", var_273_19)
						arg_270_1:RecordAudio("324161063", var_273_19)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_324161", "324161063", "story_v_out_324161.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_324161", "324161063", "story_v_out_324161.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_20 = math.max(var_273_11, arg_270_1.talkMaxDuration)

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_20 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_10) / var_273_20

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_10 + var_273_20 and arg_270_1.time_ < var_273_10 + var_273_20 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play324161064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 324161064
		arg_274_1.duration_ = 12.43

		local var_274_0 = {
			zh = 10.3333333333333,
			ja = 12.4333333333333
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
				arg_274_0:Play324161065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = "ST2007"

			if arg_274_1.bgs_[var_277_0] == nil then
				local var_277_1 = Object.Instantiate(arg_274_1.paintGo_)

				var_277_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_277_0)
				var_277_1.name = var_277_0
				var_277_1.transform.parent = arg_274_1.stage_.transform
				var_277_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.bgs_[var_277_0] = var_277_1
			end

			local var_277_2 = 0.833333333333333

			if var_277_2 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				local var_277_3 = manager.ui.mainCamera.transform.localPosition
				local var_277_4 = Vector3.New(0, 0, 10) + Vector3.New(var_277_3.x, var_277_3.y, 0)
				local var_277_5 = arg_274_1.bgs_.ST2007

				var_277_5.transform.localPosition = var_277_4
				var_277_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_277_6 = var_277_5:GetComponent("SpriteRenderer")

				if var_277_6 and var_277_6.sprite then
					local var_277_7 = (var_277_5.transform.localPosition - var_277_3).z
					local var_277_8 = manager.ui.mainCameraCom_
					local var_277_9 = 2 * var_277_7 * Mathf.Tan(var_277_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_277_10 = var_277_9 * var_277_8.aspect
					local var_277_11 = var_277_6.sprite.bounds.size.x
					local var_277_12 = var_277_6.sprite.bounds.size.y
					local var_277_13 = var_277_10 / var_277_11
					local var_277_14 = var_277_9 / var_277_12
					local var_277_15 = var_277_14 < var_277_13 and var_277_13 or var_277_14

					var_277_5.transform.localScale = Vector3.New(var_277_15, var_277_15, 0)
				end

				for iter_277_0, iter_277_1 in pairs(arg_274_1.bgs_) do
					if iter_277_0 ~= "ST2007" then
						iter_277_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_277_16 = 0

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_17 = 0.833333333333333

			if var_277_16 <= arg_274_1.time_ and arg_274_1.time_ < var_277_16 + var_277_17 then
				local var_277_18 = (arg_274_1.time_ - var_277_16) / var_277_17
				local var_277_19 = Color.New(0, 0, 0)

				var_277_19.a = Mathf.Lerp(0, 1, var_277_18)
				arg_274_1.mask_.color = var_277_19
			end

			if arg_274_1.time_ >= var_277_16 + var_277_17 and arg_274_1.time_ < var_277_16 + var_277_17 + arg_277_0 then
				local var_277_20 = Color.New(0, 0, 0)

				var_277_20.a = 1
				arg_274_1.mask_.color = var_277_20
			end

			local var_277_21 = 0.833333333333333

			if var_277_21 < arg_274_1.time_ and arg_274_1.time_ <= var_277_21 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_22 = 1.76666666666667

			if var_277_21 <= arg_274_1.time_ and arg_274_1.time_ < var_277_21 + var_277_22 then
				local var_277_23 = (arg_274_1.time_ - var_277_21) / var_277_22
				local var_277_24 = Color.New(0, 0, 0)

				var_277_24.a = Mathf.Lerp(1, 0, var_277_23)
				arg_274_1.mask_.color = var_277_24
			end

			if arg_274_1.time_ >= var_277_21 + var_277_22 and arg_274_1.time_ < var_277_21 + var_277_22 + arg_277_0 then
				local var_277_25 = Color.New(0, 0, 0)
				local var_277_26 = 0

				arg_274_1.mask_.enabled = false
				var_277_25.a = var_277_26
				arg_274_1.mask_.color = var_277_25
			end

			local var_277_27 = arg_274_1.actors_["6148ui_story"]
			local var_277_28 = 0

			if var_277_28 < arg_274_1.time_ and arg_274_1.time_ <= var_277_28 + arg_277_0 and not isNil(var_277_27) and arg_274_1.var_.characterEffect6148ui_story == nil then
				arg_274_1.var_.characterEffect6148ui_story = var_277_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_29 = 0.200000002980232

			if var_277_28 <= arg_274_1.time_ and arg_274_1.time_ < var_277_28 + var_277_29 and not isNil(var_277_27) then
				local var_277_30 = (arg_274_1.time_ - var_277_28) / var_277_29

				if arg_274_1.var_.characterEffect6148ui_story and not isNil(var_277_27) then
					arg_274_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_28 + var_277_29 and arg_274_1.time_ < var_277_28 + var_277_29 + arg_277_0 and not isNil(var_277_27) and arg_274_1.var_.characterEffect6148ui_story then
				arg_274_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_277_31 = arg_274_1.actors_["1054ui_story"]
			local var_277_32 = 0

			if var_277_32 < arg_274_1.time_ and arg_274_1.time_ <= var_277_32 + arg_277_0 and not isNil(var_277_31) and arg_274_1.var_.characterEffect1054ui_story == nil then
				arg_274_1.var_.characterEffect1054ui_story = var_277_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_33 = 0.200000002980232

			if var_277_32 <= arg_274_1.time_ and arg_274_1.time_ < var_277_32 + var_277_33 and not isNil(var_277_31) then
				local var_277_34 = (arg_274_1.time_ - var_277_32) / var_277_33

				if arg_274_1.var_.characterEffect1054ui_story and not isNil(var_277_31) then
					local var_277_35 = Mathf.Lerp(0, 0.5, var_277_34)

					arg_274_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1054ui_story.fillRatio = var_277_35
				end
			end

			if arg_274_1.time_ >= var_277_32 + var_277_33 and arg_274_1.time_ < var_277_32 + var_277_33 + arg_277_0 and not isNil(var_277_31) and arg_274_1.var_.characterEffect1054ui_story then
				local var_277_36 = 0.5

				arg_274_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1054ui_story.fillRatio = var_277_36
			end

			local var_277_37 = arg_274_1.actors_["1054ui_story"].transform
			local var_277_38 = 0.833333333333333

			if var_277_38 < arg_274_1.time_ and arg_274_1.time_ <= var_277_38 + arg_277_0 then
				arg_274_1.var_.moveOldPos1054ui_story = var_277_37.localPosition

				local var_277_39 = GameObjectTools.GetOrAddComponent(var_277_37.gameObject, typeof(DynamicBoneHelper))

				if var_277_39 then
					var_277_39:EnableDynamicBone(false)
				end
			end

			local var_277_40 = 0.001

			if var_277_38 <= arg_274_1.time_ and arg_274_1.time_ < var_277_38 + var_277_40 then
				local var_277_41 = (arg_274_1.time_ - var_277_38) / var_277_40
				local var_277_42 = Vector3.New(0, 100, 0)

				var_277_37.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1054ui_story, var_277_42, var_277_41)

				local var_277_43 = manager.ui.mainCamera.transform.position - var_277_37.position

				var_277_37.forward = Vector3.New(var_277_43.x, var_277_43.y, var_277_43.z)

				local var_277_44 = var_277_37.localEulerAngles

				var_277_44.z = 0
				var_277_44.x = 0
				var_277_37.localEulerAngles = var_277_44
			end

			if arg_274_1.time_ >= var_277_38 + var_277_40 and arg_274_1.time_ < var_277_38 + var_277_40 + arg_277_0 then
				var_277_37.localPosition = Vector3.New(0, 100, 0)

				local var_277_45 = manager.ui.mainCamera.transform.position - var_277_37.position

				var_277_37.forward = Vector3.New(var_277_45.x, var_277_45.y, var_277_45.z)

				local var_277_46 = var_277_37.localEulerAngles

				var_277_46.z = 0
				var_277_46.x = 0
				var_277_37.localEulerAngles = var_277_46

				local var_277_47 = GameObjectTools.GetOrAddComponent(var_277_37.gameObject, typeof(DynamicBoneHelper))

				if var_277_47 then
					var_277_47:EnableDynamicBone(true)
				end
			end

			local var_277_48 = arg_274_1.actors_["6148ui_story"].transform
			local var_277_49 = 0.833333333333333

			if var_277_49 < arg_274_1.time_ and arg_274_1.time_ <= var_277_49 + arg_277_0 then
				arg_274_1.var_.moveOldPos6148ui_story = var_277_48.localPosition

				local var_277_50 = GameObjectTools.GetOrAddComponent(var_277_48.gameObject, typeof(DynamicBoneHelper))

				if var_277_50 then
					var_277_50:EnableDynamicBone(false)
				end
			end

			local var_277_51 = 0.001

			if var_277_49 <= arg_274_1.time_ and arg_274_1.time_ < var_277_49 + var_277_51 then
				local var_277_52 = (arg_274_1.time_ - var_277_49) / var_277_51
				local var_277_53 = Vector3.New(0, 100, 0)

				var_277_48.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos6148ui_story, var_277_53, var_277_52)

				local var_277_54 = manager.ui.mainCamera.transform.position - var_277_48.position

				var_277_48.forward = Vector3.New(var_277_54.x, var_277_54.y, var_277_54.z)

				local var_277_55 = var_277_48.localEulerAngles

				var_277_55.z = 0
				var_277_55.x = 0
				var_277_48.localEulerAngles = var_277_55
			end

			if arg_274_1.time_ >= var_277_49 + var_277_51 and arg_274_1.time_ < var_277_49 + var_277_51 + arg_277_0 then
				var_277_48.localPosition = Vector3.New(0, 100, 0)

				local var_277_56 = manager.ui.mainCamera.transform.position - var_277_48.position

				var_277_48.forward = Vector3.New(var_277_56.x, var_277_56.y, var_277_56.z)

				local var_277_57 = var_277_48.localEulerAngles

				var_277_57.z = 0
				var_277_57.x = 0
				var_277_48.localEulerAngles = var_277_57

				local var_277_58 = GameObjectTools.GetOrAddComponent(var_277_48.gameObject, typeof(DynamicBoneHelper))

				if var_277_58 then
					var_277_58:EnableDynamicBone(true)
				end
			end

			local var_277_59 = 0.833333333333333

			arg_274_1.isInRecall_ = false

			if var_277_59 < arg_274_1.time_ and arg_274_1.time_ <= var_277_59 + arg_277_0 then
				arg_274_1.screenFilterGo_:SetActive(true)

				arg_274_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_277_2, iter_277_3 in pairs(arg_274_1.actors_) do
					local var_277_60 = iter_277_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_277_4, iter_277_5 in ipairs(var_277_60) do
						if iter_277_5.color.r > 0.51 then
							iter_277_5.color = Color.New(1, 1, 1)
						else
							iter_277_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_277_61 = 0.034000001847744

			if var_277_59 <= arg_274_1.time_ and arg_274_1.time_ < var_277_59 + var_277_61 then
				local var_277_62 = (arg_274_1.time_ - var_277_59) / var_277_61

				arg_274_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_277_62)
			end

			if arg_274_1.time_ >= var_277_59 + var_277_61 and arg_274_1.time_ < var_277_59 + var_277_61 + arg_277_0 then
				arg_274_1.screenFilterEffect_.weight = 1
			end

			local var_277_63 = 1.2
			local var_277_64 = 1

			if var_277_63 < arg_274_1.time_ and arg_274_1.time_ <= var_277_63 + arg_277_0 then
				local var_277_65 = "play"
				local var_277_66 = "effect"

				arg_274_1:AudioAction(var_277_65, var_277_66, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_277_67 = 0.1
			local var_277_68 = 1

			if var_277_67 < arg_274_1.time_ and arg_274_1.time_ <= var_277_67 + arg_277_0 then
				local var_277_69 = "stop"
				local var_277_70 = "effect"

				arg_274_1:AudioAction(var_277_69, var_277_70, "se_story_148", "se_story_148_sword11", "")
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_71 = 2.23333333333333
			local var_277_72 = 1.075

			if var_277_71 < arg_274_1.time_ and arg_274_1.time_ <= var_277_71 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_73 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_73:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_74 = arg_274_1:FormatText(StoryNameCfg[1488].name)

				arg_274_1.leftNameTxt_.text = var_277_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_274_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_277_75 = arg_274_1:GetWordFromCfg(324161064)
				local var_277_76 = arg_274_1:FormatText(var_277_75.content)

				arg_274_1.text_.text = var_277_76

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_77 = 43
				local var_277_78 = utf8.len(var_277_76)
				local var_277_79 = var_277_77 <= 0 and var_277_72 or var_277_72 * (var_277_78 / var_277_77)

				if var_277_79 > 0 and var_277_72 < var_277_79 then
					arg_274_1.talkMaxDuration = var_277_79
					var_277_71 = var_277_71 + 0.3

					if var_277_79 + var_277_71 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_79 + var_277_71
					end
				end

				arg_274_1.text_.text = var_277_76
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161064", "story_v_out_324161.awb") ~= 0 then
					local var_277_80 = manager.audio:GetVoiceLength("story_v_out_324161", "324161064", "story_v_out_324161.awb") / 1000

					if var_277_80 + var_277_71 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_80 + var_277_71
					end

					if var_277_75.prefab_name ~= "" and arg_274_1.actors_[var_277_75.prefab_name] ~= nil then
						local var_277_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_75.prefab_name].transform, "story_v_out_324161", "324161064", "story_v_out_324161.awb")

						arg_274_1:RecordAudio("324161064", var_277_81)
						arg_274_1:RecordAudio("324161064", var_277_81)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_324161", "324161064", "story_v_out_324161.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_324161", "324161064", "story_v_out_324161.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_82 = var_277_71 + 0.3
			local var_277_83 = math.max(var_277_72, arg_274_1.talkMaxDuration)

			if var_277_82 <= arg_274_1.time_ and arg_274_1.time_ < var_277_82 + var_277_83 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_82) / var_277_83

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_82 + var_277_83 and arg_274_1.time_ < var_277_82 + var_277_83 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play324161065 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324161065
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324161066(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["6148ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect6148ui_story == nil then
				arg_280_1.var_.characterEffect6148ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect6148ui_story and not isNil(var_283_0) then
					local var_283_4 = Mathf.Lerp(0, 0.5, var_283_3)

					arg_280_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_280_1.var_.characterEffect6148ui_story.fillRatio = var_283_4
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect6148ui_story then
				local var_283_5 = 0.5

				arg_280_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_280_1.var_.characterEffect6148ui_story.fillRatio = var_283_5
			end

			local var_283_6 = 0
			local var_283_7 = 0.25

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[7].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_280_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_283_9 = arg_280_1:GetWordFromCfg(324161065)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 10
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_14 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_14 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_14

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_14 and arg_280_1.time_ < var_283_6 + var_283_14 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play324161066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324161066
		arg_284_1.duration_ = 3.93

		local var_284_0 = {
			zh = 2.633,
			ja = 3.933
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play324161067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1054ui_story"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos1054ui_story = var_287_0.localPosition

				local var_287_2 = GameObjectTools.GetOrAddComponent(var_287_0.gameObject, typeof(DynamicBoneHelper))

				if var_287_2 then
					var_287_2:EnableDynamicBone(false)
				end
			end

			local var_287_3 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_3 then
				local var_287_4 = (arg_284_1.time_ - var_287_1) / var_287_3
				local var_287_5 = Vector3.New(0, -0.985, -6)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1054ui_story, var_287_5, var_287_4)

				local var_287_6 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_6.x, var_287_6.y, var_287_6.z)

				local var_287_7 = var_287_0.localEulerAngles

				var_287_7.z = 0
				var_287_7.x = 0
				var_287_0.localEulerAngles = var_287_7
			end

			if arg_284_1.time_ >= var_287_1 + var_287_3 and arg_284_1.time_ < var_287_1 + var_287_3 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_287_8 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_8.x, var_287_8.y, var_287_8.z)

				local var_287_9 = var_287_0.localEulerAngles

				var_287_9.z = 0
				var_287_9.x = 0
				var_287_0.localEulerAngles = var_287_9

				local var_287_10 = GameObjectTools.GetOrAddComponent(var_287_0.gameObject, typeof(DynamicBoneHelper))

				if var_287_10 then
					var_287_10:EnableDynamicBone(true)
				end
			end

			local var_287_11 = arg_284_1.actors_["1054ui_story"]
			local var_287_12 = 0

			if var_287_12 < arg_284_1.time_ and arg_284_1.time_ <= var_287_12 + arg_287_0 and not isNil(var_287_11) and arg_284_1.var_.characterEffect1054ui_story == nil then
				arg_284_1.var_.characterEffect1054ui_story = var_287_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_13 = 0.200000002980232

			if var_287_12 <= arg_284_1.time_ and arg_284_1.time_ < var_287_12 + var_287_13 and not isNil(var_287_11) then
				local var_287_14 = (arg_284_1.time_ - var_287_12) / var_287_13

				if arg_284_1.var_.characterEffect1054ui_story and not isNil(var_287_11) then
					arg_284_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_12 + var_287_13 and arg_284_1.time_ < var_287_12 + var_287_13 + arg_287_0 and not isNil(var_287_11) and arg_284_1.var_.characterEffect1054ui_story then
				arg_284_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_287_15 = 0

			if var_287_15 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_287_16 = 0

			if var_287_16 < arg_284_1.time_ and arg_284_1.time_ <= var_287_16 + arg_287_0 then
				arg_284_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_287_17 = 0
			local var_287_18 = 0.3

			if var_287_17 < arg_284_1.time_ and arg_284_1.time_ <= var_287_17 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_19 = arg_284_1:FormatText(StoryNameCfg[1487].name)

				arg_284_1.leftNameTxt_.text = var_287_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_20 = arg_284_1:GetWordFromCfg(324161066)
				local var_287_21 = arg_284_1:FormatText(var_287_20.content)

				arg_284_1.text_.text = var_287_21

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_22 = 12
				local var_287_23 = utf8.len(var_287_21)
				local var_287_24 = var_287_22 <= 0 and var_287_18 or var_287_18 * (var_287_23 / var_287_22)

				if var_287_24 > 0 and var_287_18 < var_287_24 then
					arg_284_1.talkMaxDuration = var_287_24

					if var_287_24 + var_287_17 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_24 + var_287_17
					end
				end

				arg_284_1.text_.text = var_287_21
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161066", "story_v_out_324161.awb") ~= 0 then
					local var_287_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161066", "story_v_out_324161.awb") / 1000

					if var_287_25 + var_287_17 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_25 + var_287_17
					end

					if var_287_20.prefab_name ~= "" and arg_284_1.actors_[var_287_20.prefab_name] ~= nil then
						local var_287_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_20.prefab_name].transform, "story_v_out_324161", "324161066", "story_v_out_324161.awb")

						arg_284_1:RecordAudio("324161066", var_287_26)
						arg_284_1:RecordAudio("324161066", var_287_26)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324161", "324161066", "story_v_out_324161.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324161", "324161066", "story_v_out_324161.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_27 = math.max(var_287_18, arg_284_1.talkMaxDuration)

			if var_287_17 <= arg_284_1.time_ and arg_284_1.time_ < var_287_17 + var_287_27 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_17) / var_287_27

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_17 + var_287_27 and arg_284_1.time_ < var_287_17 + var_287_27 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
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

		arg_284_1:InitPlayNodeList()
	end,
	Play324161067 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324161067
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play324161068(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1054ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1054ui_story == nil then
				arg_288_1.var_.characterEffect1054ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1054ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1054ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1054ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1054ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 1.05

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_288_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_291_9 = arg_288_1:GetWordFromCfg(324161067)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 42
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_14 and arg_288_1.time_ < var_291_6 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play324161068 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324161068
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324161069(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 1.175

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_292_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_295_3 = arg_292_1:GetWordFromCfg(324161068)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 47
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_8 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_8 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_8

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_8 and arg_292_1.time_ < var_295_0 + var_295_8 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324161069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324161069
		arg_296_1.duration_ = 7

		local var_296_0 = {
			zh = 3.9,
			ja = 7
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
				arg_296_0:Play324161070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["6148ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos6148ui_story = var_299_0.localPosition

				local var_299_2 = GameObjectTools.GetOrAddComponent(var_299_0.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(false)
				end
			end

			local var_299_3 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_3 then
				local var_299_4 = (arg_296_1.time_ - var_299_1) / var_299_3
				local var_299_5 = Vector3.New(0, -0.985, -6)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos6148ui_story, var_299_5, var_299_4)

				local var_299_6 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_6.x, var_299_6.y, var_299_6.z)

				local var_299_7 = var_299_0.localEulerAngles

				var_299_7.z = 0
				var_299_7.x = 0
				var_299_0.localEulerAngles = var_299_7
			end

			if arg_296_1.time_ >= var_299_1 + var_299_3 and arg_296_1.time_ < var_299_1 + var_299_3 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, -0.985, -6)

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

			local var_299_11 = arg_296_1.actors_["1054ui_story"].transform
			local var_299_12 = 0

			if var_299_12 < arg_296_1.time_ and arg_296_1.time_ <= var_299_12 + arg_299_0 then
				arg_296_1.var_.moveOldPos1054ui_story = var_299_11.localPosition

				local var_299_13 = GameObjectTools.GetOrAddComponent(var_299_11.gameObject, typeof(DynamicBoneHelper))

				if var_299_13 then
					var_299_13:EnableDynamicBone(false)
				end
			end

			local var_299_14 = 0.001

			if var_299_12 <= arg_296_1.time_ and arg_296_1.time_ < var_299_12 + var_299_14 then
				local var_299_15 = (arg_296_1.time_ - var_299_12) / var_299_14
				local var_299_16 = Vector3.New(0, 100, 0)

				var_299_11.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1054ui_story, var_299_16, var_299_15)

				local var_299_17 = manager.ui.mainCamera.transform.position - var_299_11.position

				var_299_11.forward = Vector3.New(var_299_17.x, var_299_17.y, var_299_17.z)

				local var_299_18 = var_299_11.localEulerAngles

				var_299_18.z = 0
				var_299_18.x = 0
				var_299_11.localEulerAngles = var_299_18
			end

			if arg_296_1.time_ >= var_299_12 + var_299_14 and arg_296_1.time_ < var_299_12 + var_299_14 + arg_299_0 then
				var_299_11.localPosition = Vector3.New(0, 100, 0)

				local var_299_19 = manager.ui.mainCamera.transform.position - var_299_11.position

				var_299_11.forward = Vector3.New(var_299_19.x, var_299_19.y, var_299_19.z)

				local var_299_20 = var_299_11.localEulerAngles

				var_299_20.z = 0
				var_299_20.x = 0
				var_299_11.localEulerAngles = var_299_20

				local var_299_21 = GameObjectTools.GetOrAddComponent(var_299_11.gameObject, typeof(DynamicBoneHelper))

				if var_299_21 then
					var_299_21:EnableDynamicBone(true)
				end
			end

			local var_299_22 = arg_296_1.actors_["6148ui_story"]
			local var_299_23 = 0

			if var_299_23 < arg_296_1.time_ and arg_296_1.time_ <= var_299_23 + arg_299_0 and not isNil(var_299_22) and arg_296_1.var_.characterEffect6148ui_story == nil then
				arg_296_1.var_.characterEffect6148ui_story = var_299_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_24 = 0.200000002980232

			if var_299_23 <= arg_296_1.time_ and arg_296_1.time_ < var_299_23 + var_299_24 and not isNil(var_299_22) then
				local var_299_25 = (arg_296_1.time_ - var_299_23) / var_299_24

				if arg_296_1.var_.characterEffect6148ui_story and not isNil(var_299_22) then
					arg_296_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_23 + var_299_24 and arg_296_1.time_ < var_299_23 + var_299_24 + arg_299_0 and not isNil(var_299_22) and arg_296_1.var_.characterEffect6148ui_story then
				arg_296_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_299_26 = 0

			if var_299_26 < arg_296_1.time_ and arg_296_1.time_ <= var_299_26 + arg_299_0 then
				arg_296_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_299_27 = 0

			if var_299_27 < arg_296_1.time_ and arg_296_1.time_ <= var_299_27 + arg_299_0 then
				arg_296_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_299_28 = 0
			local var_299_29 = 0.35

			if var_299_28 < arg_296_1.time_ and arg_296_1.time_ <= var_299_28 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_30 = arg_296_1:FormatText(StoryNameCfg[1488].name)

				arg_296_1.leftNameTxt_.text = var_299_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_31 = arg_296_1:GetWordFromCfg(324161069)
				local var_299_32 = arg_296_1:FormatText(var_299_31.content)

				arg_296_1.text_.text = var_299_32

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_33 = 14
				local var_299_34 = utf8.len(var_299_32)
				local var_299_35 = var_299_33 <= 0 and var_299_29 or var_299_29 * (var_299_34 / var_299_33)

				if var_299_35 > 0 and var_299_29 < var_299_35 then
					arg_296_1.talkMaxDuration = var_299_35

					if var_299_35 + var_299_28 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_35 + var_299_28
					end
				end

				arg_296_1.text_.text = var_299_32
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161069", "story_v_out_324161.awb") ~= 0 then
					local var_299_36 = manager.audio:GetVoiceLength("story_v_out_324161", "324161069", "story_v_out_324161.awb") / 1000

					if var_299_36 + var_299_28 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_36 + var_299_28
					end

					if var_299_31.prefab_name ~= "" and arg_296_1.actors_[var_299_31.prefab_name] ~= nil then
						local var_299_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_31.prefab_name].transform, "story_v_out_324161", "324161069", "story_v_out_324161.awb")

						arg_296_1:RecordAudio("324161069", var_299_37)
						arg_296_1:RecordAudio("324161069", var_299_37)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324161", "324161069", "story_v_out_324161.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324161", "324161069", "story_v_out_324161.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_38 = math.max(var_299_29, arg_296_1.talkMaxDuration)

			if var_299_28 <= arg_296_1.time_ and arg_296_1.time_ < var_299_28 + var_299_38 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_28) / var_299_38

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_28 + var_299_38 and arg_296_1.time_ < var_299_28 + var_299_38 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play324161070 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324161070
		arg_300_1.duration_ = 9.73

		local var_300_0 = {
			zh = 9.73333333333333,
			ja = 9.53333333333333
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
				arg_300_0:Play324161071(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.867333335181077

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				local var_303_1 = manager.ui.mainCamera.transform.localPosition
				local var_303_2 = Vector3.New(0, 0, 10) + Vector3.New(var_303_1.x, var_303_1.y, 0)
				local var_303_3 = arg_300_1.bgs_.MS2404

				var_303_3.transform.localPosition = var_303_2
				var_303_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_4 = var_303_3:GetComponent("SpriteRenderer")

				if var_303_4 and var_303_4.sprite then
					local var_303_5 = (var_303_3.transform.localPosition - var_303_1).z
					local var_303_6 = manager.ui.mainCameraCom_
					local var_303_7 = 2 * var_303_5 * Mathf.Tan(var_303_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_303_8 = var_303_7 * var_303_6.aspect
					local var_303_9 = var_303_4.sprite.bounds.size.x
					local var_303_10 = var_303_4.sprite.bounds.size.y
					local var_303_11 = var_303_8 / var_303_9
					local var_303_12 = var_303_7 / var_303_10
					local var_303_13 = var_303_12 < var_303_11 and var_303_11 or var_303_12

					var_303_3.transform.localScale = Vector3.New(var_303_13, var_303_13, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "MS2404" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_14 = 0

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			local var_303_15 = 0.3

			if arg_300_1.time_ >= var_303_14 + var_303_15 and arg_300_1.time_ < var_303_14 + var_303_15 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end

			local var_303_16 = 0

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_17 = 0.867333335181077

			if var_303_16 <= arg_300_1.time_ and arg_300_1.time_ < var_303_16 + var_303_17 then
				local var_303_18 = (arg_300_1.time_ - var_303_16) / var_303_17
				local var_303_19 = Color.New(0, 0, 0)

				var_303_19.a = Mathf.Lerp(0, 1, var_303_18)
				arg_300_1.mask_.color = var_303_19
			end

			if arg_300_1.time_ >= var_303_16 + var_303_17 and arg_300_1.time_ < var_303_16 + var_303_17 + arg_303_0 then
				local var_303_20 = Color.New(0, 0, 0)

				var_303_20.a = 1
				arg_300_1.mask_.color = var_303_20
			end

			local var_303_21 = 0.833333333333333

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_22 = 2

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_22 then
				local var_303_23 = (arg_300_1.time_ - var_303_21) / var_303_22
				local var_303_24 = Color.New(0, 0, 0)

				var_303_24.a = Mathf.Lerp(1, 0, var_303_23)
				arg_300_1.mask_.color = var_303_24
			end

			if arg_300_1.time_ >= var_303_21 + var_303_22 and arg_300_1.time_ < var_303_21 + var_303_22 + arg_303_0 then
				local var_303_25 = Color.New(0, 0, 0)
				local var_303_26 = 0

				arg_300_1.mask_.enabled = false
				var_303_25.a = var_303_26
				arg_300_1.mask_.color = var_303_25
			end

			local var_303_27 = arg_300_1.actors_["6148ui_story"].transform
			local var_303_28 = 0

			if var_303_28 < arg_300_1.time_ and arg_300_1.time_ <= var_303_28 + arg_303_0 then
				arg_300_1.var_.moveOldPos6148ui_story = var_303_27.localPosition

				local var_303_29 = GameObjectTools.GetOrAddComponent(var_303_27.gameObject, typeof(DynamicBoneHelper))

				if var_303_29 then
					var_303_29:EnableDynamicBone(false)
				end
			end

			local var_303_30 = 0.001

			if var_303_28 <= arg_300_1.time_ and arg_300_1.time_ < var_303_28 + var_303_30 then
				local var_303_31 = (arg_300_1.time_ - var_303_28) / var_303_30
				local var_303_32 = Vector3.New(0, 100, 0)

				var_303_27.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos6148ui_story, var_303_32, var_303_31)

				local var_303_33 = manager.ui.mainCamera.transform.position - var_303_27.position

				var_303_27.forward = Vector3.New(var_303_33.x, var_303_33.y, var_303_33.z)

				local var_303_34 = var_303_27.localEulerAngles

				var_303_34.z = 0
				var_303_34.x = 0
				var_303_27.localEulerAngles = var_303_34
			end

			if arg_300_1.time_ >= var_303_28 + var_303_30 and arg_300_1.time_ < var_303_28 + var_303_30 + arg_303_0 then
				var_303_27.localPosition = Vector3.New(0, 100, 0)

				local var_303_35 = manager.ui.mainCamera.transform.position - var_303_27.position

				var_303_27.forward = Vector3.New(var_303_35.x, var_303_35.y, var_303_35.z)

				local var_303_36 = var_303_27.localEulerAngles

				var_303_36.z = 0
				var_303_36.x = 0
				var_303_27.localEulerAngles = var_303_36

				local var_303_37 = GameObjectTools.GetOrAddComponent(var_303_27.gameObject, typeof(DynamicBoneHelper))

				if var_303_37 then
					var_303_37:EnableDynamicBone(true)
				end
			end

			local var_303_38 = arg_300_1.actors_["1054ui_story"]
			local var_303_39 = 0

			if var_303_39 < arg_300_1.time_ and arg_300_1.time_ <= var_303_39 + arg_303_0 and not isNil(var_303_38) and arg_300_1.var_.characterEffect1054ui_story == nil then
				arg_300_1.var_.characterEffect1054ui_story = var_303_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_40 = 0.200000002980232

			if var_303_39 <= arg_300_1.time_ and arg_300_1.time_ < var_303_39 + var_303_40 and not isNil(var_303_38) then
				local var_303_41 = (arg_300_1.time_ - var_303_39) / var_303_40

				if arg_300_1.var_.characterEffect1054ui_story and not isNil(var_303_38) then
					arg_300_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_39 + var_303_40 and arg_300_1.time_ < var_303_39 + var_303_40 + arg_303_0 and not isNil(var_303_38) and arg_300_1.var_.characterEffect1054ui_story then
				arg_300_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_303_42 = arg_300_1.actors_["6148ui_story"]
			local var_303_43 = 0

			if var_303_43 < arg_300_1.time_ and arg_300_1.time_ <= var_303_43 + arg_303_0 and not isNil(var_303_42) and arg_300_1.var_.characterEffect6148ui_story == nil then
				arg_300_1.var_.characterEffect6148ui_story = var_303_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_44 = 0.200000002980232

			if var_303_43 <= arg_300_1.time_ and arg_300_1.time_ < var_303_43 + var_303_44 and not isNil(var_303_42) then
				local var_303_45 = (arg_300_1.time_ - var_303_43) / var_303_44

				if arg_300_1.var_.characterEffect6148ui_story and not isNil(var_303_42) then
					local var_303_46 = Mathf.Lerp(0, 0.5, var_303_45)

					arg_300_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_300_1.var_.characterEffect6148ui_story.fillRatio = var_303_46
				end
			end

			if arg_300_1.time_ >= var_303_43 + var_303_44 and arg_300_1.time_ < var_303_43 + var_303_44 + arg_303_0 and not isNil(var_303_42) and arg_300_1.var_.characterEffect6148ui_story then
				local var_303_47 = 0.5

				arg_300_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_300_1.var_.characterEffect6148ui_story.fillRatio = var_303_47
			end

			local var_303_48 = 0.833333333333333

			arg_300_1.isInRecall_ = false

			if var_303_48 < arg_300_1.time_ and arg_300_1.time_ <= var_303_48 + arg_303_0 then
				arg_300_1.screenFilterGo_:SetActive(false)

				for iter_303_2, iter_303_3 in pairs(arg_300_1.actors_) do
					local var_303_49 = iter_303_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_303_4, iter_303_5 in ipairs(var_303_49) do
						if iter_303_5.color.r > 0.51 then
							iter_303_5.color = Color.New(1, 1, 1)
						else
							iter_303_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_303_50 = 0.034000001847744

			if var_303_48 <= arg_300_1.time_ and arg_300_1.time_ < var_303_48 + var_303_50 then
				local var_303_51 = (arg_300_1.time_ - var_303_48) / var_303_50

				arg_300_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_303_51)
			end

			if arg_300_1.time_ >= var_303_48 + var_303_50 and arg_300_1.time_ < var_303_48 + var_303_50 + arg_303_0 then
				arg_300_1.screenFilterEffect_.weight = 0
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_52 = 2.53333333333333
			local var_303_53 = 0.75

			if var_303_52 < arg_300_1.time_ and arg_300_1.time_ <= var_303_52 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_54 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_54:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_55 = arg_300_1:FormatText(StoryNameCfg[1487].name)

				arg_300_1.leftNameTxt_.text = var_303_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_56 = arg_300_1:GetWordFromCfg(324161070)
				local var_303_57 = arg_300_1:FormatText(var_303_56.content)

				arg_300_1.text_.text = var_303_57

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_58 = 30
				local var_303_59 = utf8.len(var_303_57)
				local var_303_60 = var_303_58 <= 0 and var_303_53 or var_303_53 * (var_303_59 / var_303_58)

				if var_303_60 > 0 and var_303_53 < var_303_60 then
					arg_300_1.talkMaxDuration = var_303_60
					var_303_52 = var_303_52 + 0.3

					if var_303_60 + var_303_52 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_60 + var_303_52
					end
				end

				arg_300_1.text_.text = var_303_57
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161070", "story_v_out_324161.awb") ~= 0 then
					local var_303_61 = manager.audio:GetVoiceLength("story_v_out_324161", "324161070", "story_v_out_324161.awb") / 1000

					if var_303_61 + var_303_52 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_61 + var_303_52
					end

					if var_303_56.prefab_name ~= "" and arg_300_1.actors_[var_303_56.prefab_name] ~= nil then
						local var_303_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_56.prefab_name].transform, "story_v_out_324161", "324161070", "story_v_out_324161.awb")

						arg_300_1:RecordAudio("324161070", var_303_62)
						arg_300_1:RecordAudio("324161070", var_303_62)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324161", "324161070", "story_v_out_324161.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324161", "324161070", "story_v_out_324161.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_63 = var_303_52 + 0.3
			local var_303_64 = math.max(var_303_53, arg_300_1.talkMaxDuration)

			if var_303_63 <= arg_300_1.time_ and arg_300_1.time_ < var_303_63 + var_303_64 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_63) / var_303_64

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_63 + var_303_64 and arg_300_1.time_ < var_303_63 + var_303_64 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play324161071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 324161071
		arg_306_1.duration_ = 12

		local var_306_0 = {
			zh = 12,
			ja = 9.966
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
				arg_306_0:Play324161072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 1.175

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[1487].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:GetWordFromCfg(324161071)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161071", "story_v_out_324161.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161071", "story_v_out_324161.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_out_324161", "324161071", "story_v_out_324161.awb")

						arg_306_1:RecordAudio("324161071", var_309_9)
						arg_306_1:RecordAudio("324161071", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_324161", "324161071", "story_v_out_324161.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_324161", "324161071", "story_v_out_324161.awb")
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
	Play324161072 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 324161072
		arg_310_1.duration_ = 7.93

		local var_310_0 = {
			zh = 4.866,
			ja = 7.933
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play324161073(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["6148ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect6148ui_story == nil then
				arg_310_1.var_.characterEffect6148ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect6148ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect6148ui_story then
				arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_313_4 = arg_310_1.actors_["1054ui_story"]
			local var_313_5 = 0

			if var_313_5 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 and not isNil(var_313_4) and arg_310_1.var_.characterEffect1054ui_story == nil then
				arg_310_1.var_.characterEffect1054ui_story = var_313_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_6 = 0.200000002980232

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_6 and not isNil(var_313_4) then
				local var_313_7 = (arg_310_1.time_ - var_313_5) / var_313_6

				if arg_310_1.var_.characterEffect1054ui_story and not isNil(var_313_4) then
					local var_313_8 = Mathf.Lerp(0, 0.5, var_313_7)

					arg_310_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1054ui_story.fillRatio = var_313_8
				end
			end

			if arg_310_1.time_ >= var_313_5 + var_313_6 and arg_310_1.time_ < var_313_5 + var_313_6 + arg_313_0 and not isNil(var_313_4) and arg_310_1.var_.characterEffect1054ui_story then
				local var_313_9 = 0.5

				arg_310_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1054ui_story.fillRatio = var_313_9
			end

			local var_313_10 = 0
			local var_313_11 = 0.575

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_12 = arg_310_1:FormatText(StoryNameCfg[1488].name)

				arg_310_1.leftNameTxt_.text = var_313_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_13 = arg_310_1:GetWordFromCfg(324161072)
				local var_313_14 = arg_310_1:FormatText(var_313_13.content)

				arg_310_1.text_.text = var_313_14

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_15 = 23
				local var_313_16 = utf8.len(var_313_14)
				local var_313_17 = var_313_15 <= 0 and var_313_11 or var_313_11 * (var_313_16 / var_313_15)

				if var_313_17 > 0 and var_313_11 < var_313_17 then
					arg_310_1.talkMaxDuration = var_313_17

					if var_313_17 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_17 + var_313_10
					end
				end

				arg_310_1.text_.text = var_313_14
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161072", "story_v_out_324161.awb") ~= 0 then
					local var_313_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161072", "story_v_out_324161.awb") / 1000

					if var_313_18 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_18 + var_313_10
					end

					if var_313_13.prefab_name ~= "" and arg_310_1.actors_[var_313_13.prefab_name] ~= nil then
						local var_313_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_13.prefab_name].transform, "story_v_out_324161", "324161072", "story_v_out_324161.awb")

						arg_310_1:RecordAudio("324161072", var_313_19)
						arg_310_1:RecordAudio("324161072", var_313_19)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_324161", "324161072", "story_v_out_324161.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_324161", "324161072", "story_v_out_324161.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_20 = math.max(var_313_11, arg_310_1.talkMaxDuration)

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_20 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_10) / var_313_20

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_10 + var_313_20 and arg_310_1.time_ < var_313_10 + var_313_20 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play324161073 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 324161073
		arg_314_1.duration_ = 6.77

		local var_314_0 = {
			zh = 6.766,
			ja = 6.133
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play324161074(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1054ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1054ui_story == nil then
				arg_314_1.var_.characterEffect1054ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1054ui_story and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1054ui_story then
				arg_314_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_317_4 = arg_314_1.actors_["6148ui_story"]
			local var_317_5 = 0

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect6148ui_story == nil then
				arg_314_1.var_.characterEffect6148ui_story = var_317_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_6 = 0.200000002980232

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_6 and not isNil(var_317_4) then
				local var_317_7 = (arg_314_1.time_ - var_317_5) / var_317_6

				if arg_314_1.var_.characterEffect6148ui_story and not isNil(var_317_4) then
					local var_317_8 = Mathf.Lerp(0, 0.5, var_317_7)

					arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_314_1.var_.characterEffect6148ui_story.fillRatio = var_317_8
				end
			end

			if arg_314_1.time_ >= var_317_5 + var_317_6 and arg_314_1.time_ < var_317_5 + var_317_6 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect6148ui_story then
				local var_317_9 = 0.5

				arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_314_1.var_.characterEffect6148ui_story.fillRatio = var_317_9
			end

			local var_317_10 = 0
			local var_317_11 = 0.775

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_12 = arg_314_1:FormatText(StoryNameCfg[1487].name)

				arg_314_1.leftNameTxt_.text = var_317_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_13 = arg_314_1:GetWordFromCfg(324161073)
				local var_317_14 = arg_314_1:FormatText(var_317_13.content)

				arg_314_1.text_.text = var_317_14

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_15 = 31
				local var_317_16 = utf8.len(var_317_14)
				local var_317_17 = var_317_15 <= 0 and var_317_11 or var_317_11 * (var_317_16 / var_317_15)

				if var_317_17 > 0 and var_317_11 < var_317_17 then
					arg_314_1.talkMaxDuration = var_317_17

					if var_317_17 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_17 + var_317_10
					end
				end

				arg_314_1.text_.text = var_317_14
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161073", "story_v_out_324161.awb") ~= 0 then
					local var_317_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161073", "story_v_out_324161.awb") / 1000

					if var_317_18 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_18 + var_317_10
					end

					if var_317_13.prefab_name ~= "" and arg_314_1.actors_[var_317_13.prefab_name] ~= nil then
						local var_317_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_13.prefab_name].transform, "story_v_out_324161", "324161073", "story_v_out_324161.awb")

						arg_314_1:RecordAudio("324161073", var_317_19)
						arg_314_1:RecordAudio("324161073", var_317_19)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_324161", "324161073", "story_v_out_324161.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_324161", "324161073", "story_v_out_324161.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_20 = math.max(var_317_11, arg_314_1.talkMaxDuration)

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_20 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_10) / var_317_20

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_10 + var_317_20 and arg_314_1.time_ < var_317_10 + var_317_20 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play324161074 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 324161074
		arg_318_1.duration_ = 4.87

		local var_318_0 = {
			zh = 4,
			ja = 4.866
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
				arg_318_0:Play324161075(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["6148ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect6148ui_story == nil then
				arg_318_1.var_.characterEffect6148ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect6148ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect6148ui_story then
				arg_318_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_321_4 = arg_318_1.actors_["1054ui_story"]
			local var_321_5 = 0

			if var_321_5 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1054ui_story == nil then
				arg_318_1.var_.characterEffect1054ui_story = var_321_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_6 = 0.200000002980232

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_6 and not isNil(var_321_4) then
				local var_321_7 = (arg_318_1.time_ - var_321_5) / var_321_6

				if arg_318_1.var_.characterEffect1054ui_story and not isNil(var_321_4) then
					local var_321_8 = Mathf.Lerp(0, 0.5, var_321_7)

					arg_318_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1054ui_story.fillRatio = var_321_8
				end
			end

			if arg_318_1.time_ >= var_321_5 + var_321_6 and arg_318_1.time_ < var_321_5 + var_321_6 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1054ui_story then
				local var_321_9 = 0.5

				arg_318_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1054ui_story.fillRatio = var_321_9
			end

			local var_321_10 = 0
			local var_321_11 = 0.575

			if var_321_10 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_12 = arg_318_1:FormatText(StoryNameCfg[1488].name)

				arg_318_1.leftNameTxt_.text = var_321_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_13 = arg_318_1:GetWordFromCfg(324161074)
				local var_321_14 = arg_318_1:FormatText(var_321_13.content)

				arg_318_1.text_.text = var_321_14

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_15 = 23
				local var_321_16 = utf8.len(var_321_14)
				local var_321_17 = var_321_15 <= 0 and var_321_11 or var_321_11 * (var_321_16 / var_321_15)

				if var_321_17 > 0 and var_321_11 < var_321_17 then
					arg_318_1.talkMaxDuration = var_321_17

					if var_321_17 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_17 + var_321_10
					end
				end

				arg_318_1.text_.text = var_321_14
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161074", "story_v_out_324161.awb") ~= 0 then
					local var_321_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161074", "story_v_out_324161.awb") / 1000

					if var_321_18 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_18 + var_321_10
					end

					if var_321_13.prefab_name ~= "" and arg_318_1.actors_[var_321_13.prefab_name] ~= nil then
						local var_321_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_13.prefab_name].transform, "story_v_out_324161", "324161074", "story_v_out_324161.awb")

						arg_318_1:RecordAudio("324161074", var_321_19)
						arg_318_1:RecordAudio("324161074", var_321_19)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_324161", "324161074", "story_v_out_324161.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_324161", "324161074", "story_v_out_324161.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_20 = math.max(var_321_11, arg_318_1.talkMaxDuration)

			if var_321_10 <= arg_318_1.time_ and arg_318_1.time_ < var_321_10 + var_321_20 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_10) / var_321_20

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_10 + var_321_20 and arg_318_1.time_ < var_321_10 + var_321_20 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play324161075 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 324161075
		arg_322_1.duration_ = 15.97

		local var_322_0 = {
			zh = 6.033,
			ja = 15.966
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
				arg_322_0:Play324161076(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.775

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[1488].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:GetWordFromCfg(324161075)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161075", "story_v_out_324161.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161075", "story_v_out_324161.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_324161", "324161075", "story_v_out_324161.awb")

						arg_322_1:RecordAudio("324161075", var_325_9)
						arg_322_1:RecordAudio("324161075", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_324161", "324161075", "story_v_out_324161.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_324161", "324161075", "story_v_out_324161.awb")
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
	Play324161076 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 324161076
		arg_326_1.duration_ = 3.63

		local var_326_0 = {
			zh = 2.9,
			ja = 3.633
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
				arg_326_0:Play324161077(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1054ui_story"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1054ui_story == nil then
				arg_326_1.var_.characterEffect1054ui_story = var_329_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.characterEffect1054ui_story and not isNil(var_329_0) then
					arg_326_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1054ui_story then
				arg_326_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_329_4 = arg_326_1.actors_["6148ui_story"]
			local var_329_5 = 0

			if var_329_5 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 and not isNil(var_329_4) and arg_326_1.var_.characterEffect6148ui_story == nil then
				arg_326_1.var_.characterEffect6148ui_story = var_329_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_6 = 0.200000002980232

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_6 and not isNil(var_329_4) then
				local var_329_7 = (arg_326_1.time_ - var_329_5) / var_329_6

				if arg_326_1.var_.characterEffect6148ui_story and not isNil(var_329_4) then
					local var_329_8 = Mathf.Lerp(0, 0.5, var_329_7)

					arg_326_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_326_1.var_.characterEffect6148ui_story.fillRatio = var_329_8
				end
			end

			if arg_326_1.time_ >= var_329_5 + var_329_6 and arg_326_1.time_ < var_329_5 + var_329_6 + arg_329_0 and not isNil(var_329_4) and arg_326_1.var_.characterEffect6148ui_story then
				local var_329_9 = 0.5

				arg_326_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_326_1.var_.characterEffect6148ui_story.fillRatio = var_329_9
			end

			local var_329_10 = 0
			local var_329_11 = 0.2

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_12 = arg_326_1:FormatText(StoryNameCfg[1487].name)

				arg_326_1.leftNameTxt_.text = var_329_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_13 = arg_326_1:GetWordFromCfg(324161076)
				local var_329_14 = arg_326_1:FormatText(var_329_13.content)

				arg_326_1.text_.text = var_329_14

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_15 = 8
				local var_329_16 = utf8.len(var_329_14)
				local var_329_17 = var_329_15 <= 0 and var_329_11 or var_329_11 * (var_329_16 / var_329_15)

				if var_329_17 > 0 and var_329_11 < var_329_17 then
					arg_326_1.talkMaxDuration = var_329_17

					if var_329_17 + var_329_10 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_17 + var_329_10
					end
				end

				arg_326_1.text_.text = var_329_14
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161076", "story_v_out_324161.awb") ~= 0 then
					local var_329_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161076", "story_v_out_324161.awb") / 1000

					if var_329_18 + var_329_10 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_18 + var_329_10
					end

					if var_329_13.prefab_name ~= "" and arg_326_1.actors_[var_329_13.prefab_name] ~= nil then
						local var_329_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_13.prefab_name].transform, "story_v_out_324161", "324161076", "story_v_out_324161.awb")

						arg_326_1:RecordAudio("324161076", var_329_19)
						arg_326_1:RecordAudio("324161076", var_329_19)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_324161", "324161076", "story_v_out_324161.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_324161", "324161076", "story_v_out_324161.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_20 = math.max(var_329_11, arg_326_1.talkMaxDuration)

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_20 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_10) / var_329_20

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_10 + var_329_20 and arg_326_1.time_ < var_329_10 + var_329_20 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play324161077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 324161077
		arg_330_1.duration_ = 6.47

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play324161078(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1054ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1054ui_story == nil then
				arg_330_1.var_.characterEffect1054ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect1054ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1054ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1054ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1054ui_story.fillRatio = var_333_5
			end

			local var_333_6 = arg_330_1.bgs_.MS2404.transform
			local var_333_7 = 0

			if var_333_7 < arg_330_1.time_ and arg_330_1.time_ <= var_333_7 + arg_333_0 then
				arg_330_1.var_.moveOldPosMS2404 = var_333_6.localPosition
			end

			local var_333_8 = 1.26666666666667

			if var_333_7 <= arg_330_1.time_ and arg_330_1.time_ < var_333_7 + var_333_8 then
				local var_333_9 = (arg_330_1.time_ - var_333_7) / var_333_8
				local var_333_10 = Vector3.New(0, 0.42, 6.64)

				var_333_6.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPosMS2404, var_333_10, var_333_9)
			end

			if arg_330_1.time_ >= var_333_7 + var_333_8 and arg_330_1.time_ < var_333_7 + var_333_8 + arg_333_0 then
				var_333_6.localPosition = Vector3.New(0, 0.42, 6.64)
			end

			local var_333_11 = 0

			if var_333_11 < arg_330_1.time_ and arg_330_1.time_ <= var_333_11 + arg_333_0 then
				arg_330_1.allBtn_.enabled = false
			end

			local var_333_12 = 1.83333333333333

			if arg_330_1.time_ >= var_333_11 + var_333_12 and arg_330_1.time_ < var_333_11 + var_333_12 + arg_333_0 then
				arg_330_1.allBtn_.enabled = true
			end

			if arg_330_1.frameCnt_ <= 1 then
				arg_330_1.dialog_:SetActive(false)
			end

			local var_333_13 = 1.46666666666667
			local var_333_14 = 0.825

			if var_333_13 < arg_330_1.time_ and arg_330_1.time_ <= var_333_13 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				arg_330_1.dialog_:SetActive(true)

				arg_330_1.dialogCg_.alpha = 0

				local var_333_15 = LeanTween.value(arg_330_1.dialog_, 0, 1, 0.3)

				var_333_15:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_330_1.dialogCg_.alpha = arg_334_0
				end))
				var_333_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_330_1.dialog_)
					var_333_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_330_1.duration_ = arg_330_1.duration_ + 0.3

				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_16 = arg_330_1:GetWordFromCfg(324161077)
				local var_333_17 = arg_330_1:FormatText(var_333_16.content)

				arg_330_1.text_.text = var_333_17

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_18 = 33
				local var_333_19 = utf8.len(var_333_17)
				local var_333_20 = var_333_18 <= 0 and var_333_14 or var_333_14 * (var_333_19 / var_333_18)

				if var_333_20 > 0 and var_333_14 < var_333_20 then
					arg_330_1.talkMaxDuration = var_333_20
					var_333_13 = var_333_13 + 0.3

					if var_333_20 + var_333_13 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_20 + var_333_13
					end
				end

				arg_330_1.text_.text = var_333_17
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_21 = var_333_13 + 0.3
			local var_333_22 = math.max(var_333_14, arg_330_1.talkMaxDuration)

			if var_333_21 <= arg_330_1.time_ and arg_330_1.time_ < var_333_21 + var_333_22 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_21) / var_333_22

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_21 + var_333_22 and arg_330_1.time_ < var_333_21 + var_333_22 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.26666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 0.42, 6.64),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play324161078 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 324161078
		arg_336_1.duration_ = 7.93

		local var_336_0 = {
			zh = 7.5,
			ja = 7.933
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play324161079(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1054ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1054ui_story == nil then
				arg_336_1.var_.characterEffect1054ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect1054ui_story and not isNil(var_339_0) then
					arg_336_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1054ui_story then
				arg_336_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_339_4 = 0
			local var_339_5 = 0.8

			if var_339_4 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_6 = arg_336_1:FormatText(StoryNameCfg[1487].name)

				arg_336_1.leftNameTxt_.text = var_339_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_7 = arg_336_1:GetWordFromCfg(324161078)
				local var_339_8 = arg_336_1:FormatText(var_339_7.content)

				arg_336_1.text_.text = var_339_8

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_9 = 32
				local var_339_10 = utf8.len(var_339_8)
				local var_339_11 = var_339_9 <= 0 and var_339_5 or var_339_5 * (var_339_10 / var_339_9)

				if var_339_11 > 0 and var_339_5 < var_339_11 then
					arg_336_1.talkMaxDuration = var_339_11

					if var_339_11 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_11 + var_339_4
					end
				end

				arg_336_1.text_.text = var_339_8
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161078", "story_v_out_324161.awb") ~= 0 then
					local var_339_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161078", "story_v_out_324161.awb") / 1000

					if var_339_12 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_12 + var_339_4
					end

					if var_339_7.prefab_name ~= "" and arg_336_1.actors_[var_339_7.prefab_name] ~= nil then
						local var_339_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_7.prefab_name].transform, "story_v_out_324161", "324161078", "story_v_out_324161.awb")

						arg_336_1:RecordAudio("324161078", var_339_13)
						arg_336_1:RecordAudio("324161078", var_339_13)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_324161", "324161078", "story_v_out_324161.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_324161", "324161078", "story_v_out_324161.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_14 = math.max(var_339_5, arg_336_1.talkMaxDuration)

			if var_339_4 <= arg_336_1.time_ and arg_336_1.time_ < var_339_4 + var_339_14 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_4) / var_339_14

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_4 + var_339_14 and arg_336_1.time_ < var_339_4 + var_339_14 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play324161079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 324161079
		arg_340_1.duration_ = 9.37

		local var_340_0 = {
			zh = 6.966,
			ja = 9.366
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play324161080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.85

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[1487].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:GetWordFromCfg(324161079)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 34
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161079", "story_v_out_324161.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161079", "story_v_out_324161.awb") / 1000

					if var_343_8 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_0
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_out_324161", "324161079", "story_v_out_324161.awb")

						arg_340_1:RecordAudio("324161079", var_343_9)
						arg_340_1:RecordAudio("324161079", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_324161", "324161079", "story_v_out_324161.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_324161", "324161079", "story_v_out_324161.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_10 and arg_340_1.time_ < var_343_0 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play324161080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 324161080
		arg_344_1.duration_ = 2.2

		local var_344_0 = {
			zh = 1.8,
			ja = 2.2
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
				arg_344_0:Play324161081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["6148ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect6148ui_story == nil then
				arg_344_1.var_.characterEffect6148ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect6148ui_story and not isNil(var_347_0) then
					arg_344_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect6148ui_story then
				arg_344_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_347_4 = arg_344_1.actors_["1054ui_story"]
			local var_347_5 = 0

			if var_347_5 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1054ui_story == nil then
				arg_344_1.var_.characterEffect1054ui_story = var_347_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_6 = 0.200000002980232

			if var_347_5 <= arg_344_1.time_ and arg_344_1.time_ < var_347_5 + var_347_6 and not isNil(var_347_4) then
				local var_347_7 = (arg_344_1.time_ - var_347_5) / var_347_6

				if arg_344_1.var_.characterEffect1054ui_story and not isNil(var_347_4) then
					local var_347_8 = Mathf.Lerp(0, 0.5, var_347_7)

					arg_344_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1054ui_story.fillRatio = var_347_8
				end
			end

			if arg_344_1.time_ >= var_347_5 + var_347_6 and arg_344_1.time_ < var_347_5 + var_347_6 + arg_347_0 and not isNil(var_347_4) and arg_344_1.var_.characterEffect1054ui_story then
				local var_347_9 = 0.5

				arg_344_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1054ui_story.fillRatio = var_347_9
			end

			local var_347_10 = 0
			local var_347_11 = 0.075

			if var_347_10 < arg_344_1.time_ and arg_344_1.time_ <= var_347_10 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_12 = arg_344_1:FormatText(StoryNameCfg[1488].name)

				arg_344_1.leftNameTxt_.text = var_347_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_13 = arg_344_1:GetWordFromCfg(324161080)
				local var_347_14 = arg_344_1:FormatText(var_347_13.content)

				arg_344_1.text_.text = var_347_14

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_15 = 3
				local var_347_16 = utf8.len(var_347_14)
				local var_347_17 = var_347_15 <= 0 and var_347_11 or var_347_11 * (var_347_16 / var_347_15)

				if var_347_17 > 0 and var_347_11 < var_347_17 then
					arg_344_1.talkMaxDuration = var_347_17

					if var_347_17 + var_347_10 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_17 + var_347_10
					end
				end

				arg_344_1.text_.text = var_347_14
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161080", "story_v_out_324161.awb") ~= 0 then
					local var_347_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161080", "story_v_out_324161.awb") / 1000

					if var_347_18 + var_347_10 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_18 + var_347_10
					end

					if var_347_13.prefab_name ~= "" and arg_344_1.actors_[var_347_13.prefab_name] ~= nil then
						local var_347_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_13.prefab_name].transform, "story_v_out_324161", "324161080", "story_v_out_324161.awb")

						arg_344_1:RecordAudio("324161080", var_347_19)
						arg_344_1:RecordAudio("324161080", var_347_19)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_324161", "324161080", "story_v_out_324161.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_324161", "324161080", "story_v_out_324161.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_20 = math.max(var_347_11, arg_344_1.talkMaxDuration)

			if var_347_10 <= arg_344_1.time_ and arg_344_1.time_ < var_347_10 + var_347_20 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_10) / var_347_20

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_10 + var_347_20 and arg_344_1.time_ < var_347_10 + var_347_20 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play324161081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 324161081
		arg_348_1.duration_ = 5.73

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play324161082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["6148ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect6148ui_story == nil then
				arg_348_1.var_.characterEffect6148ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect6148ui_story and not isNil(var_351_0) then
					local var_351_4 = Mathf.Lerp(0, 0.5, var_351_3)

					arg_348_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_348_1.var_.characterEffect6148ui_story.fillRatio = var_351_4
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect6148ui_story then
				local var_351_5 = 0.5

				arg_348_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_348_1.var_.characterEffect6148ui_story.fillRatio = var_351_5
			end

			local var_351_6 = 0

			if var_351_6 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			local var_351_7 = 1.33333333333333

			if arg_348_1.time_ >= var_351_6 + var_351_7 and arg_348_1.time_ < var_351_6 + var_351_7 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_8 = manager.ui.mainCamera.transform
			local var_351_9 = 0

			if var_351_9 < arg_348_1.time_ and arg_348_1.time_ <= var_351_9 + arg_351_0 then
				arg_348_1.var_.shakeOldPos = var_351_8.localPosition
			end

			local var_351_10 = 1.13333333333333

			if var_351_9 <= arg_348_1.time_ and arg_348_1.time_ < var_351_9 + var_351_10 then
				local var_351_11 = (arg_348_1.time_ - var_351_9) / 0.066
				local var_351_12, var_351_13 = math.modf(var_351_11)

				var_351_8.localPosition = Vector3.New(var_351_13 * 0.13, var_351_13 * 0.13, var_351_13 * 0.13) + arg_348_1.var_.shakeOldPos
			end

			if arg_348_1.time_ >= var_351_9 + var_351_10 and arg_348_1.time_ < var_351_9 + var_351_10 + arg_351_0 then
				var_351_8.localPosition = arg_348_1.var_.shakeOldPos
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_14 = 0.733333333333333
			local var_351_15 = 1.4

			if var_351_14 < arg_348_1.time_ and arg_348_1.time_ <= var_351_14 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_16 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_16:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_348_1.dialogCg_.alpha = arg_352_0
				end))
				var_351_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_17 = arg_348_1:GetWordFromCfg(324161081)
				local var_351_18 = arg_348_1:FormatText(var_351_17.content)

				arg_348_1.text_.text = var_351_18

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_19 = 56
				local var_351_20 = utf8.len(var_351_18)
				local var_351_21 = var_351_19 <= 0 and var_351_15 or var_351_15 * (var_351_20 / var_351_19)

				if var_351_21 > 0 and var_351_15 < var_351_21 then
					arg_348_1.talkMaxDuration = var_351_21
					var_351_14 = var_351_14 + 0.3

					if var_351_21 + var_351_14 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_21 + var_351_14
					end
				end

				arg_348_1.text_.text = var_351_18
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_22 = var_351_14 + 0.3
			local var_351_23 = math.max(var_351_15, arg_348_1.talkMaxDuration)

			if var_351_22 <= arg_348_1.time_ and arg_348_1.time_ < var_351_22 + var_351_23 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_22) / var_351_23

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_22 + var_351_23 and arg_348_1.time_ < var_351_22 + var_351_23 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play324161082 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 324161082
		arg_354_1.duration_ = 18.23

		local var_354_0 = {
			zh = 11.266,
			ja = 18.233
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
				arg_354_0:Play324161083(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["6148ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect6148ui_story == nil then
				arg_354_1.var_.characterEffect6148ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect6148ui_story and not isNil(var_357_0) then
					arg_354_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect6148ui_story then
				arg_354_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_357_4 = 0
			local var_357_5 = 1.2

			if var_357_4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_6 = arg_354_1:FormatText(StoryNameCfg[1488].name)

				arg_354_1.leftNameTxt_.text = var_357_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_7 = arg_354_1:GetWordFromCfg(324161082)
				local var_357_8 = arg_354_1:FormatText(var_357_7.content)

				arg_354_1.text_.text = var_357_8

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_9 = 48
				local var_357_10 = utf8.len(var_357_8)
				local var_357_11 = var_357_9 <= 0 and var_357_5 or var_357_5 * (var_357_10 / var_357_9)

				if var_357_11 > 0 and var_357_5 < var_357_11 then
					arg_354_1.talkMaxDuration = var_357_11

					if var_357_11 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_11 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_8
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161082", "story_v_out_324161.awb") ~= 0 then
					local var_357_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161082", "story_v_out_324161.awb") / 1000

					if var_357_12 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_12 + var_357_4
					end

					if var_357_7.prefab_name ~= "" and arg_354_1.actors_[var_357_7.prefab_name] ~= nil then
						local var_357_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_7.prefab_name].transform, "story_v_out_324161", "324161082", "story_v_out_324161.awb")

						arg_354_1:RecordAudio("324161082", var_357_13)
						arg_354_1:RecordAudio("324161082", var_357_13)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_324161", "324161082", "story_v_out_324161.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_324161", "324161082", "story_v_out_324161.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_14 = math.max(var_357_5, arg_354_1.talkMaxDuration)

			if var_357_4 <= arg_354_1.time_ and arg_354_1.time_ < var_357_4 + var_357_14 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_4) / var_357_14

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_4 + var_357_14 and arg_354_1.time_ < var_357_4 + var_357_14 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play324161083 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 324161083
		arg_358_1.duration_ = 8.7

		local var_358_0 = {
			zh = 8.7,
			ja = 8.233
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
				arg_358_0:Play324161084(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 1.175

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[1488].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_3 = arg_358_1:GetWordFromCfg(324161083)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161083", "story_v_out_324161.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161083", "story_v_out_324161.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_out_324161", "324161083", "story_v_out_324161.awb")

						arg_358_1:RecordAudio("324161083", var_361_9)
						arg_358_1:RecordAudio("324161083", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_324161", "324161083", "story_v_out_324161.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_324161", "324161083", "story_v_out_324161.awb")
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
	Play324161084 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 324161084
		arg_362_1.duration_ = 12.73

		local var_362_0 = {
			zh = 7.833,
			ja = 12.733
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play324161085(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 0.825

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[1488].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_3 = arg_362_1:GetWordFromCfg(324161084)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 33
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161084", "story_v_out_324161.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161084", "story_v_out_324161.awb") / 1000

					if var_365_8 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_0
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_out_324161", "324161084", "story_v_out_324161.awb")

						arg_362_1:RecordAudio("324161084", var_365_9)
						arg_362_1:RecordAudio("324161084", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_324161", "324161084", "story_v_out_324161.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_324161", "324161084", "story_v_out_324161.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_10 and arg_362_1.time_ < var_365_0 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play324161085 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 324161085
		arg_366_1.duration_ = 3.37

		local var_366_0 = {
			zh = 2.666,
			ja = 3.366
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
				arg_366_0:Play324161086(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1054ui_story"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1054ui_story == nil then
				arg_366_1.var_.characterEffect1054ui_story = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect1054ui_story and not isNil(var_369_0) then
					arg_366_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1054ui_story then
				arg_366_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_369_4 = arg_366_1.actors_["6148ui_story"]
			local var_369_5 = 0

			if var_369_5 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 and not isNil(var_369_4) and arg_366_1.var_.characterEffect6148ui_story == nil then
				arg_366_1.var_.characterEffect6148ui_story = var_369_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_6 = 0.200000002980232

			if var_369_5 <= arg_366_1.time_ and arg_366_1.time_ < var_369_5 + var_369_6 and not isNil(var_369_4) then
				local var_369_7 = (arg_366_1.time_ - var_369_5) / var_369_6

				if arg_366_1.var_.characterEffect6148ui_story and not isNil(var_369_4) then
					local var_369_8 = Mathf.Lerp(0, 0.5, var_369_7)

					arg_366_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_366_1.var_.characterEffect6148ui_story.fillRatio = var_369_8
				end
			end

			if arg_366_1.time_ >= var_369_5 + var_369_6 and arg_366_1.time_ < var_369_5 + var_369_6 + arg_369_0 and not isNil(var_369_4) and arg_366_1.var_.characterEffect6148ui_story then
				local var_369_9 = 0.5

				arg_366_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_366_1.var_.characterEffect6148ui_story.fillRatio = var_369_9
			end

			local var_369_10 = 0
			local var_369_11 = 0.275

			if var_369_10 < arg_366_1.time_ and arg_366_1.time_ <= var_369_10 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_12 = arg_366_1:FormatText(StoryNameCfg[1487].name)

				arg_366_1.leftNameTxt_.text = var_369_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_13 = arg_366_1:GetWordFromCfg(324161085)
				local var_369_14 = arg_366_1:FormatText(var_369_13.content)

				arg_366_1.text_.text = var_369_14

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_15 = 11
				local var_369_16 = utf8.len(var_369_14)
				local var_369_17 = var_369_15 <= 0 and var_369_11 or var_369_11 * (var_369_16 / var_369_15)

				if var_369_17 > 0 and var_369_11 < var_369_17 then
					arg_366_1.talkMaxDuration = var_369_17

					if var_369_17 + var_369_10 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_17 + var_369_10
					end
				end

				arg_366_1.text_.text = var_369_14
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161085", "story_v_out_324161.awb") ~= 0 then
					local var_369_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161085", "story_v_out_324161.awb") / 1000

					if var_369_18 + var_369_10 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_18 + var_369_10
					end

					if var_369_13.prefab_name ~= "" and arg_366_1.actors_[var_369_13.prefab_name] ~= nil then
						local var_369_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_13.prefab_name].transform, "story_v_out_324161", "324161085", "story_v_out_324161.awb")

						arg_366_1:RecordAudio("324161085", var_369_19)
						arg_366_1:RecordAudio("324161085", var_369_19)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_324161", "324161085", "story_v_out_324161.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_324161", "324161085", "story_v_out_324161.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_20 = math.max(var_369_11, arg_366_1.talkMaxDuration)

			if var_369_10 <= arg_366_1.time_ and arg_366_1.time_ < var_369_10 + var_369_20 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_10) / var_369_20

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_10 + var_369_20 and arg_366_1.time_ < var_369_10 + var_369_20 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play324161086 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 324161086
		arg_370_1.duration_ = 5.57

		local var_370_0 = {
			zh = 5.566,
			ja = 4.433
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
				arg_370_0:Play324161087(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["6148ui_story"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect6148ui_story == nil then
				arg_370_1.var_.characterEffect6148ui_story = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect6148ui_story and not isNil(var_373_0) then
					arg_370_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect6148ui_story then
				arg_370_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_373_4 = arg_370_1.actors_["1054ui_story"]
			local var_373_5 = 0

			if var_373_5 < arg_370_1.time_ and arg_370_1.time_ <= var_373_5 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect1054ui_story == nil then
				arg_370_1.var_.characterEffect1054ui_story = var_373_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_6 = 0.200000002980232

			if var_373_5 <= arg_370_1.time_ and arg_370_1.time_ < var_373_5 + var_373_6 and not isNil(var_373_4) then
				local var_373_7 = (arg_370_1.time_ - var_373_5) / var_373_6

				if arg_370_1.var_.characterEffect1054ui_story and not isNil(var_373_4) then
					local var_373_8 = Mathf.Lerp(0, 0.5, var_373_7)

					arg_370_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1054ui_story.fillRatio = var_373_8
				end
			end

			if arg_370_1.time_ >= var_373_5 + var_373_6 and arg_370_1.time_ < var_373_5 + var_373_6 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect1054ui_story then
				local var_373_9 = 0.5

				arg_370_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1054ui_story.fillRatio = var_373_9
			end

			local var_373_10 = 0
			local var_373_11 = 0.55

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_12 = arg_370_1:FormatText(StoryNameCfg[1488].name)

				arg_370_1.leftNameTxt_.text = var_373_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_13 = arg_370_1:GetWordFromCfg(324161086)
				local var_373_14 = arg_370_1:FormatText(var_373_13.content)

				arg_370_1.text_.text = var_373_14

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_15 = 22
				local var_373_16 = utf8.len(var_373_14)
				local var_373_17 = var_373_15 <= 0 and var_373_11 or var_373_11 * (var_373_16 / var_373_15)

				if var_373_17 > 0 and var_373_11 < var_373_17 then
					arg_370_1.talkMaxDuration = var_373_17

					if var_373_17 + var_373_10 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_17 + var_373_10
					end
				end

				arg_370_1.text_.text = var_373_14
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161086", "story_v_out_324161.awb") ~= 0 then
					local var_373_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161086", "story_v_out_324161.awb") / 1000

					if var_373_18 + var_373_10 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_18 + var_373_10
					end

					if var_373_13.prefab_name ~= "" and arg_370_1.actors_[var_373_13.prefab_name] ~= nil then
						local var_373_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_13.prefab_name].transform, "story_v_out_324161", "324161086", "story_v_out_324161.awb")

						arg_370_1:RecordAudio("324161086", var_373_19)
						arg_370_1:RecordAudio("324161086", var_373_19)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_324161", "324161086", "story_v_out_324161.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_324161", "324161086", "story_v_out_324161.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_20 = math.max(var_373_11, arg_370_1.talkMaxDuration)

			if var_373_10 <= arg_370_1.time_ and arg_370_1.time_ < var_373_10 + var_373_20 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_10) / var_373_20

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_10 + var_373_20 and arg_370_1.time_ < var_373_10 + var_373_20 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play324161087 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 324161087
		arg_374_1.duration_ = 4.7

		local var_374_0 = {
			zh = 4.7,
			ja = 3.266
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
				arg_374_0:Play324161088(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1054ui_story"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1054ui_story == nil then
				arg_374_1.var_.characterEffect1054ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect1054ui_story and not isNil(var_377_0) then
					arg_374_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1054ui_story then
				arg_374_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_377_4 = arg_374_1.actors_["6148ui_story"]
			local var_377_5 = 0

			if var_377_5 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 and not isNil(var_377_4) and arg_374_1.var_.characterEffect6148ui_story == nil then
				arg_374_1.var_.characterEffect6148ui_story = var_377_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_6 = 0.200000002980232

			if var_377_5 <= arg_374_1.time_ and arg_374_1.time_ < var_377_5 + var_377_6 and not isNil(var_377_4) then
				local var_377_7 = (arg_374_1.time_ - var_377_5) / var_377_6

				if arg_374_1.var_.characterEffect6148ui_story and not isNil(var_377_4) then
					local var_377_8 = Mathf.Lerp(0, 0.5, var_377_7)

					arg_374_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_374_1.var_.characterEffect6148ui_story.fillRatio = var_377_8
				end
			end

			if arg_374_1.time_ >= var_377_5 + var_377_6 and arg_374_1.time_ < var_377_5 + var_377_6 + arg_377_0 and not isNil(var_377_4) and arg_374_1.var_.characterEffect6148ui_story then
				local var_377_9 = 0.5

				arg_374_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_374_1.var_.characterEffect6148ui_story.fillRatio = var_377_9
			end

			local var_377_10 = 0
			local var_377_11 = 0.45

			if var_377_10 < arg_374_1.time_ and arg_374_1.time_ <= var_377_10 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_12 = arg_374_1:FormatText(StoryNameCfg[1487].name)

				arg_374_1.leftNameTxt_.text = var_377_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_13 = arg_374_1:GetWordFromCfg(324161087)
				local var_377_14 = arg_374_1:FormatText(var_377_13.content)

				arg_374_1.text_.text = var_377_14

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_15 = 18
				local var_377_16 = utf8.len(var_377_14)
				local var_377_17 = var_377_15 <= 0 and var_377_11 or var_377_11 * (var_377_16 / var_377_15)

				if var_377_17 > 0 and var_377_11 < var_377_17 then
					arg_374_1.talkMaxDuration = var_377_17

					if var_377_17 + var_377_10 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_17 + var_377_10
					end
				end

				arg_374_1.text_.text = var_377_14
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161087", "story_v_out_324161.awb") ~= 0 then
					local var_377_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161087", "story_v_out_324161.awb") / 1000

					if var_377_18 + var_377_10 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_18 + var_377_10
					end

					if var_377_13.prefab_name ~= "" and arg_374_1.actors_[var_377_13.prefab_name] ~= nil then
						local var_377_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_13.prefab_name].transform, "story_v_out_324161", "324161087", "story_v_out_324161.awb")

						arg_374_1:RecordAudio("324161087", var_377_19)
						arg_374_1:RecordAudio("324161087", var_377_19)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_324161", "324161087", "story_v_out_324161.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_324161", "324161087", "story_v_out_324161.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_20 = math.max(var_377_11, arg_374_1.talkMaxDuration)

			if var_377_10 <= arg_374_1.time_ and arg_374_1.time_ < var_377_10 + var_377_20 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_10) / var_377_20

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_10 + var_377_20 and arg_374_1.time_ < var_377_10 + var_377_20 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play324161088 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 324161088
		arg_378_1.duration_ = 6.07

		local var_378_0 = {
			zh = 6.066,
			ja = 5.433
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
				arg_378_0:Play324161089(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.525

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[1487].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:GetWordFromCfg(324161088)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161088", "story_v_out_324161.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_out_324161", "324161088", "story_v_out_324161.awb") / 1000

					if var_381_8 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_0
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_out_324161", "324161088", "story_v_out_324161.awb")

						arg_378_1:RecordAudio("324161088", var_381_9)
						arg_378_1:RecordAudio("324161088", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_324161", "324161088", "story_v_out_324161.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_324161", "324161088", "story_v_out_324161.awb")
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
	Play324161089 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 324161089
		arg_382_1.duration_ = 6.53

		local var_382_0 = {
			zh = 6.133,
			ja = 6.533
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
				arg_382_0:Play324161090(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["6148ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect6148ui_story == nil then
				arg_382_1.var_.characterEffect6148ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect6148ui_story and not isNil(var_385_0) then
					arg_382_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect6148ui_story then
				arg_382_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_385_4 = arg_382_1.actors_["1054ui_story"]
			local var_385_5 = 0

			if var_385_5 < arg_382_1.time_ and arg_382_1.time_ <= var_385_5 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect1054ui_story == nil then
				arg_382_1.var_.characterEffect1054ui_story = var_385_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_6 = 0.200000002980232

			if var_385_5 <= arg_382_1.time_ and arg_382_1.time_ < var_385_5 + var_385_6 and not isNil(var_385_4) then
				local var_385_7 = (arg_382_1.time_ - var_385_5) / var_385_6

				if arg_382_1.var_.characterEffect1054ui_story and not isNil(var_385_4) then
					local var_385_8 = Mathf.Lerp(0, 0.5, var_385_7)

					arg_382_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1054ui_story.fillRatio = var_385_8
				end
			end

			if arg_382_1.time_ >= var_385_5 + var_385_6 and arg_382_1.time_ < var_385_5 + var_385_6 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect1054ui_story then
				local var_385_9 = 0.5

				arg_382_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1054ui_story.fillRatio = var_385_9
			end

			local var_385_10 = 0
			local var_385_11 = 0.7

			if var_385_10 < arg_382_1.time_ and arg_382_1.time_ <= var_385_10 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_12 = arg_382_1:FormatText(StoryNameCfg[1488].name)

				arg_382_1.leftNameTxt_.text = var_385_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_13 = arg_382_1:GetWordFromCfg(324161089)
				local var_385_14 = arg_382_1:FormatText(var_385_13.content)

				arg_382_1.text_.text = var_385_14

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_15 = 28
				local var_385_16 = utf8.len(var_385_14)
				local var_385_17 = var_385_15 <= 0 and var_385_11 or var_385_11 * (var_385_16 / var_385_15)

				if var_385_17 > 0 and var_385_11 < var_385_17 then
					arg_382_1.talkMaxDuration = var_385_17

					if var_385_17 + var_385_10 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_17 + var_385_10
					end
				end

				arg_382_1.text_.text = var_385_14
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161089", "story_v_out_324161.awb") ~= 0 then
					local var_385_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161089", "story_v_out_324161.awb") / 1000

					if var_385_18 + var_385_10 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_18 + var_385_10
					end

					if var_385_13.prefab_name ~= "" and arg_382_1.actors_[var_385_13.prefab_name] ~= nil then
						local var_385_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_13.prefab_name].transform, "story_v_out_324161", "324161089", "story_v_out_324161.awb")

						arg_382_1:RecordAudio("324161089", var_385_19)
						arg_382_1:RecordAudio("324161089", var_385_19)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_324161", "324161089", "story_v_out_324161.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_324161", "324161089", "story_v_out_324161.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_20 = math.max(var_385_11, arg_382_1.talkMaxDuration)

			if var_385_10 <= arg_382_1.time_ and arg_382_1.time_ < var_385_10 + var_385_20 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_10) / var_385_20

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_10 + var_385_20 and arg_382_1.time_ < var_385_10 + var_385_20 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play324161090 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 324161090
		arg_386_1.duration_ = 5.6

		local var_386_0 = {
			zh = 5.4,
			ja = 5.6
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play324161091(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1054ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1054ui_story == nil then
				arg_386_1.var_.characterEffect1054ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect1054ui_story and not isNil(var_389_0) then
					arg_386_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1054ui_story then
				arg_386_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_389_4 = arg_386_1.actors_["6148ui_story"]
			local var_389_5 = 0

			if var_389_5 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 and not isNil(var_389_4) and arg_386_1.var_.characterEffect6148ui_story == nil then
				arg_386_1.var_.characterEffect6148ui_story = var_389_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_6 = 0.200000002980232

			if var_389_5 <= arg_386_1.time_ and arg_386_1.time_ < var_389_5 + var_389_6 and not isNil(var_389_4) then
				local var_389_7 = (arg_386_1.time_ - var_389_5) / var_389_6

				if arg_386_1.var_.characterEffect6148ui_story and not isNil(var_389_4) then
					local var_389_8 = Mathf.Lerp(0, 0.5, var_389_7)

					arg_386_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_386_1.var_.characterEffect6148ui_story.fillRatio = var_389_8
				end
			end

			if arg_386_1.time_ >= var_389_5 + var_389_6 and arg_386_1.time_ < var_389_5 + var_389_6 + arg_389_0 and not isNil(var_389_4) and arg_386_1.var_.characterEffect6148ui_story then
				local var_389_9 = 0.5

				arg_386_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_386_1.var_.characterEffect6148ui_story.fillRatio = var_389_9
			end

			local var_389_10 = 0
			local var_389_11 = 0.425

			if var_389_10 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_12 = arg_386_1:FormatText(StoryNameCfg[1487].name)

				arg_386_1.leftNameTxt_.text = var_389_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_13 = arg_386_1:GetWordFromCfg(324161090)
				local var_389_14 = arg_386_1:FormatText(var_389_13.content)

				arg_386_1.text_.text = var_389_14

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_15 = 17
				local var_389_16 = utf8.len(var_389_14)
				local var_389_17 = var_389_15 <= 0 and var_389_11 or var_389_11 * (var_389_16 / var_389_15)

				if var_389_17 > 0 and var_389_11 < var_389_17 then
					arg_386_1.talkMaxDuration = var_389_17

					if var_389_17 + var_389_10 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_17 + var_389_10
					end
				end

				arg_386_1.text_.text = var_389_14
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161090", "story_v_out_324161.awb") ~= 0 then
					local var_389_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161090", "story_v_out_324161.awb") / 1000

					if var_389_18 + var_389_10 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_18 + var_389_10
					end

					if var_389_13.prefab_name ~= "" and arg_386_1.actors_[var_389_13.prefab_name] ~= nil then
						local var_389_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_13.prefab_name].transform, "story_v_out_324161", "324161090", "story_v_out_324161.awb")

						arg_386_1:RecordAudio("324161090", var_389_19)
						arg_386_1:RecordAudio("324161090", var_389_19)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_324161", "324161090", "story_v_out_324161.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_324161", "324161090", "story_v_out_324161.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_20 = math.max(var_389_11, arg_386_1.talkMaxDuration)

			if var_389_10 <= arg_386_1.time_ and arg_386_1.time_ < var_389_10 + var_389_20 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_10) / var_389_20

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_10 + var_389_20 and arg_386_1.time_ < var_389_10 + var_389_20 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play324161091 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 324161091
		arg_390_1.duration_ = 3.77

		local var_390_0 = {
			zh = 3.766,
			ja = 3.3
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play324161092(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["6148ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect6148ui_story == nil then
				arg_390_1.var_.characterEffect6148ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect6148ui_story and not isNil(var_393_0) then
					arg_390_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect6148ui_story then
				arg_390_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_393_4 = arg_390_1.actors_["1054ui_story"]
			local var_393_5 = 0

			if var_393_5 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 and not isNil(var_393_4) and arg_390_1.var_.characterEffect1054ui_story == nil then
				arg_390_1.var_.characterEffect1054ui_story = var_393_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_6 = 0.200000002980232

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_6 and not isNil(var_393_4) then
				local var_393_7 = (arg_390_1.time_ - var_393_5) / var_393_6

				if arg_390_1.var_.characterEffect1054ui_story and not isNil(var_393_4) then
					local var_393_8 = Mathf.Lerp(0, 0.5, var_393_7)

					arg_390_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1054ui_story.fillRatio = var_393_8
				end
			end

			if arg_390_1.time_ >= var_393_5 + var_393_6 and arg_390_1.time_ < var_393_5 + var_393_6 + arg_393_0 and not isNil(var_393_4) and arg_390_1.var_.characterEffect1054ui_story then
				local var_393_9 = 0.5

				arg_390_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1054ui_story.fillRatio = var_393_9
			end

			local var_393_10 = 0
			local var_393_11 = 0.35

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_12 = arg_390_1:FormatText(StoryNameCfg[1488].name)

				arg_390_1.leftNameTxt_.text = var_393_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_13 = arg_390_1:GetWordFromCfg(324161091)
				local var_393_14 = arg_390_1:FormatText(var_393_13.content)

				arg_390_1.text_.text = var_393_14

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_15 = 14
				local var_393_16 = utf8.len(var_393_14)
				local var_393_17 = var_393_15 <= 0 and var_393_11 or var_393_11 * (var_393_16 / var_393_15)

				if var_393_17 > 0 and var_393_11 < var_393_17 then
					arg_390_1.talkMaxDuration = var_393_17

					if var_393_17 + var_393_10 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_17 + var_393_10
					end
				end

				arg_390_1.text_.text = var_393_14
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161091", "story_v_out_324161.awb") ~= 0 then
					local var_393_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161091", "story_v_out_324161.awb") / 1000

					if var_393_18 + var_393_10 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_18 + var_393_10
					end

					if var_393_13.prefab_name ~= "" and arg_390_1.actors_[var_393_13.prefab_name] ~= nil then
						local var_393_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_13.prefab_name].transform, "story_v_out_324161", "324161091", "story_v_out_324161.awb")

						arg_390_1:RecordAudio("324161091", var_393_19)
						arg_390_1:RecordAudio("324161091", var_393_19)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_324161", "324161091", "story_v_out_324161.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_324161", "324161091", "story_v_out_324161.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_20 = math.max(var_393_11, arg_390_1.talkMaxDuration)

			if var_393_10 <= arg_390_1.time_ and arg_390_1.time_ < var_393_10 + var_393_20 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_10) / var_393_20

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_10 + var_393_20 and arg_390_1.time_ < var_393_10 + var_393_20 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play324161092 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 324161092
		arg_394_1.duration_ = 6.3

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play324161093(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["6148ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect6148ui_story == nil then
				arg_394_1.var_.characterEffect6148ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect6148ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_394_1.var_.characterEffect6148ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect6148ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_394_1.var_.characterEffect6148ui_story.fillRatio = var_397_5
			end

			local var_397_6 = arg_394_1.bgs_.MS2404.transform
			local var_397_7 = 0

			if var_397_7 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.var_.moveOldPosMS2404 = var_397_6.localPosition
			end

			local var_397_8 = 2.13333333333333

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_8 then
				local var_397_9 = (arg_394_1.time_ - var_397_7) / var_397_8
				local var_397_10 = Vector3.New(0, -0.48, 4.03)

				var_397_6.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosMS2404, var_397_10, var_397_9)
			end

			if arg_394_1.time_ >= var_397_7 + var_397_8 and arg_394_1.time_ < var_397_7 + var_397_8 + arg_397_0 then
				var_397_6.localPosition = Vector3.New(0, -0.48, 4.03)
			end

			local var_397_11 = 0

			if var_397_11 < arg_394_1.time_ and arg_394_1.time_ <= var_397_11 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			local var_397_12 = 1.7

			if arg_394_1.time_ >= var_397_11 + var_397_12 and arg_394_1.time_ < var_397_11 + var_397_12 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_13 = 1.3
			local var_397_14 = 0.675

			if var_397_13 < arg_394_1.time_ and arg_394_1.time_ <= var_397_13 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_15 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_15:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_16 = arg_394_1:GetWordFromCfg(324161092)
				local var_397_17 = arg_394_1:FormatText(var_397_16.content)

				arg_394_1.text_.text = var_397_17

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_18 = 27
				local var_397_19 = utf8.len(var_397_17)
				local var_397_20 = var_397_18 <= 0 and var_397_14 or var_397_14 * (var_397_19 / var_397_18)

				if var_397_20 > 0 and var_397_14 < var_397_20 then
					arg_394_1.talkMaxDuration = var_397_20
					var_397_13 = var_397_13 + 0.3

					if var_397_20 + var_397_13 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_20 + var_397_13
					end
				end

				arg_394_1.text_.text = var_397_17
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_21 = var_397_13 + 0.3
			local var_397_22 = math.max(var_397_14, arg_394_1.talkMaxDuration)

			if var_397_21 <= arg_394_1.time_ and arg_394_1.time_ < var_397_21 + var_397_22 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_21) / var_397_22

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_21 + var_397_22 and arg_394_1.time_ < var_397_21 + var_397_22 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.42, 6.64),
					endPos = Vector3.New(0, -0.48, 4.03),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play324161093 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 324161093
		arg_400_1.duration_ = 3.4

		local var_400_0 = {
			zh = 2.466,
			ja = 3.4
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play324161094(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["6148ui_story"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect6148ui_story == nil then
				arg_400_1.var_.characterEffect6148ui_story = var_403_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.characterEffect6148ui_story and not isNil(var_403_0) then
					arg_400_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect6148ui_story then
				arg_400_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_403_4 = 0
			local var_403_5 = 0.25

			if var_403_4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_6 = arg_400_1:FormatText(StoryNameCfg[1488].name)

				arg_400_1.leftNameTxt_.text = var_403_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_7 = arg_400_1:GetWordFromCfg(324161093)
				local var_403_8 = arg_400_1:FormatText(var_403_7.content)

				arg_400_1.text_.text = var_403_8

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_9 = 10
				local var_403_10 = utf8.len(var_403_8)
				local var_403_11 = var_403_9 <= 0 and var_403_5 or var_403_5 * (var_403_10 / var_403_9)

				if var_403_11 > 0 and var_403_5 < var_403_11 then
					arg_400_1.talkMaxDuration = var_403_11

					if var_403_11 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_8
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161093", "story_v_out_324161.awb") ~= 0 then
					local var_403_12 = manager.audio:GetVoiceLength("story_v_out_324161", "324161093", "story_v_out_324161.awb") / 1000

					if var_403_12 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_12 + var_403_4
					end

					if var_403_7.prefab_name ~= "" and arg_400_1.actors_[var_403_7.prefab_name] ~= nil then
						local var_403_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_7.prefab_name].transform, "story_v_out_324161", "324161093", "story_v_out_324161.awb")

						arg_400_1:RecordAudio("324161093", var_403_13)
						arg_400_1:RecordAudio("324161093", var_403_13)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_324161", "324161093", "story_v_out_324161.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_324161", "324161093", "story_v_out_324161.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_14 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_14 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_14

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_14 and arg_400_1.time_ < var_403_4 + var_403_14 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play324161094 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 324161094
		arg_404_1.duration_ = 4.4

		local var_404_0 = {
			zh = 4.4,
			ja = 4
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play324161095(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1054ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1054ui_story == nil then
				arg_404_1.var_.characterEffect1054ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect1054ui_story and not isNil(var_407_0) then
					arg_404_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1054ui_story then
				arg_404_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_407_4 = arg_404_1.actors_["6148ui_story"]
			local var_407_5 = 0

			if var_407_5 < arg_404_1.time_ and arg_404_1.time_ <= var_407_5 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect6148ui_story == nil then
				arg_404_1.var_.characterEffect6148ui_story = var_407_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_6 = 0.200000002980232

			if var_407_5 <= arg_404_1.time_ and arg_404_1.time_ < var_407_5 + var_407_6 and not isNil(var_407_4) then
				local var_407_7 = (arg_404_1.time_ - var_407_5) / var_407_6

				if arg_404_1.var_.characterEffect6148ui_story and not isNil(var_407_4) then
					local var_407_8 = Mathf.Lerp(0, 0.5, var_407_7)

					arg_404_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_404_1.var_.characterEffect6148ui_story.fillRatio = var_407_8
				end
			end

			if arg_404_1.time_ >= var_407_5 + var_407_6 and arg_404_1.time_ < var_407_5 + var_407_6 + arg_407_0 and not isNil(var_407_4) and arg_404_1.var_.characterEffect6148ui_story then
				local var_407_9 = 0.5

				arg_404_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_404_1.var_.characterEffect6148ui_story.fillRatio = var_407_9
			end

			local var_407_10 = 0
			local var_407_11 = 0.4

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_12 = arg_404_1:FormatText(StoryNameCfg[1487].name)

				arg_404_1.leftNameTxt_.text = var_407_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_13 = arg_404_1:GetWordFromCfg(324161094)
				local var_407_14 = arg_404_1:FormatText(var_407_13.content)

				arg_404_1.text_.text = var_407_14

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_15 = 16
				local var_407_16 = utf8.len(var_407_14)
				local var_407_17 = var_407_15 <= 0 and var_407_11 or var_407_11 * (var_407_16 / var_407_15)

				if var_407_17 > 0 and var_407_11 < var_407_17 then
					arg_404_1.talkMaxDuration = var_407_17

					if var_407_17 + var_407_10 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_17 + var_407_10
					end
				end

				arg_404_1.text_.text = var_407_14
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161094", "story_v_out_324161.awb") ~= 0 then
					local var_407_18 = manager.audio:GetVoiceLength("story_v_out_324161", "324161094", "story_v_out_324161.awb") / 1000

					if var_407_18 + var_407_10 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_18 + var_407_10
					end

					if var_407_13.prefab_name ~= "" and arg_404_1.actors_[var_407_13.prefab_name] ~= nil then
						local var_407_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_13.prefab_name].transform, "story_v_out_324161", "324161094", "story_v_out_324161.awb")

						arg_404_1:RecordAudio("324161094", var_407_19)
						arg_404_1:RecordAudio("324161094", var_407_19)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_324161", "324161094", "story_v_out_324161.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_324161", "324161094", "story_v_out_324161.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_20 = math.max(var_407_11, arg_404_1.talkMaxDuration)

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_20 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_10) / var_407_20

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_10 + var_407_20 and arg_404_1.time_ < var_407_10 + var_407_20 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play324161095 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 324161095
		arg_408_1.duration_ = 7.6

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play324161096(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 1.3

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				local var_411_1 = manager.ui.mainCamera.transform.localPosition
				local var_411_2 = Vector3.New(0, 0, 10) + Vector3.New(var_411_1.x, var_411_1.y, 0)
				local var_411_3 = arg_408_1.bgs_.J27g

				var_411_3.transform.localPosition = var_411_2
				var_411_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_411_4 = var_411_3:GetComponent("SpriteRenderer")

				if var_411_4 and var_411_4.sprite then
					local var_411_5 = (var_411_3.transform.localPosition - var_411_1).z
					local var_411_6 = manager.ui.mainCameraCom_
					local var_411_7 = 2 * var_411_5 * Mathf.Tan(var_411_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_411_8 = var_411_7 * var_411_6.aspect
					local var_411_9 = var_411_4.sprite.bounds.size.x
					local var_411_10 = var_411_4.sprite.bounds.size.y
					local var_411_11 = var_411_8 / var_411_9
					local var_411_12 = var_411_7 / var_411_10
					local var_411_13 = var_411_12 < var_411_11 and var_411_11 or var_411_12

					var_411_3.transform.localScale = Vector3.New(var_411_13, var_411_13, 0)
				end

				for iter_411_0, iter_411_1 in pairs(arg_408_1.bgs_) do
					if iter_411_0 ~= "J27g" then
						iter_411_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_411_14 = 0

			if var_411_14 < arg_408_1.time_ and arg_408_1.time_ <= var_411_14 + arg_411_0 then
				arg_408_1.allBtn_.enabled = false
			end

			local var_411_15 = 0.3

			if arg_408_1.time_ >= var_411_14 + var_411_15 and arg_408_1.time_ < var_411_14 + var_411_15 + arg_411_0 then
				arg_408_1.allBtn_.enabled = true
			end

			local var_411_16 = 0

			if var_411_16 < arg_408_1.time_ and arg_408_1.time_ <= var_411_16 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_17 = 1.3

			if var_411_16 <= arg_408_1.time_ and arg_408_1.time_ < var_411_16 + var_411_17 then
				local var_411_18 = (arg_408_1.time_ - var_411_16) / var_411_17
				local var_411_19 = Color.New(0, 0, 0)

				var_411_19.a = Mathf.Lerp(0, 1, var_411_18)
				arg_408_1.mask_.color = var_411_19
			end

			if arg_408_1.time_ >= var_411_16 + var_411_17 and arg_408_1.time_ < var_411_16 + var_411_17 + arg_411_0 then
				local var_411_20 = Color.New(0, 0, 0)

				var_411_20.a = 1
				arg_408_1.mask_.color = var_411_20
			end

			local var_411_21 = 1.3

			if var_411_21 < arg_408_1.time_ and arg_408_1.time_ <= var_411_21 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_22 = 1.3

			if var_411_21 <= arg_408_1.time_ and arg_408_1.time_ < var_411_21 + var_411_22 then
				local var_411_23 = (arg_408_1.time_ - var_411_21) / var_411_22
				local var_411_24 = Color.New(0, 0, 0)

				var_411_24.a = Mathf.Lerp(1, 0, var_411_23)
				arg_408_1.mask_.color = var_411_24
			end

			if arg_408_1.time_ >= var_411_21 + var_411_22 and arg_408_1.time_ < var_411_21 + var_411_22 + arg_411_0 then
				local var_411_25 = Color.New(0, 0, 0)
				local var_411_26 = 0

				arg_408_1.mask_.enabled = false
				var_411_25.a = var_411_26
				arg_408_1.mask_.color = var_411_25
			end

			local var_411_27 = arg_408_1.actors_["1054ui_story"]
			local var_411_28 = 0

			if var_411_28 < arg_408_1.time_ and arg_408_1.time_ <= var_411_28 + arg_411_0 and not isNil(var_411_27) and arg_408_1.var_.characterEffect1054ui_story == nil then
				arg_408_1.var_.characterEffect1054ui_story = var_411_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_29 = 0.200000002980232

			if var_411_28 <= arg_408_1.time_ and arg_408_1.time_ < var_411_28 + var_411_29 and not isNil(var_411_27) then
				local var_411_30 = (arg_408_1.time_ - var_411_28) / var_411_29

				if arg_408_1.var_.characterEffect1054ui_story and not isNil(var_411_27) then
					local var_411_31 = Mathf.Lerp(0, 0.5, var_411_30)

					arg_408_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1054ui_story.fillRatio = var_411_31
				end
			end

			if arg_408_1.time_ >= var_411_28 + var_411_29 and arg_408_1.time_ < var_411_28 + var_411_29 + arg_411_0 and not isNil(var_411_27) and arg_408_1.var_.characterEffect1054ui_story then
				local var_411_32 = 0.5

				arg_408_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1054ui_story.fillRatio = var_411_32
			end

			local var_411_33 = 1.2
			local var_411_34 = 1

			if var_411_33 < arg_408_1.time_ and arg_408_1.time_ <= var_411_33 + arg_411_0 then
				local var_411_35 = "play"
				local var_411_36 = "effect"

				arg_408_1:AudioAction(var_411_35, var_411_36, "se_story_150", "se_story_150_huatian", "")
			end

			local var_411_37 = 0.1
			local var_411_38 = 1

			if var_411_37 < arg_408_1.time_ and arg_408_1.time_ <= var_411_37 + arg_411_0 then
				local var_411_39 = "stop"
				local var_411_40 = "effect"

				arg_408_1:AudioAction(var_411_39, var_411_40, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_411_41 = 1.7
			local var_411_42 = 1

			if var_411_41 < arg_408_1.time_ and arg_408_1.time_ <= var_411_41 + arg_411_0 then
				local var_411_43 = "play"
				local var_411_44 = "effect"

				arg_408_1:AudioAction(var_411_43, var_411_44, "se_story_121_04", "se_story_121_04_magic", "")
			end

			if arg_408_1.frameCnt_ <= 1 then
				arg_408_1.dialog_:SetActive(false)
			end

			local var_411_45 = 2.6
			local var_411_46 = 1.725

			if var_411_45 < arg_408_1.time_ and arg_408_1.time_ <= var_411_45 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0

				arg_408_1.dialog_:SetActive(true)

				arg_408_1.dialogCg_.alpha = 0

				local var_411_47 = LeanTween.value(arg_408_1.dialog_, 0, 1, 0.3)

				var_411_47:setOnUpdate(LuaHelper.FloatAction(function(arg_412_0)
					arg_408_1.dialogCg_.alpha = arg_412_0
				end))
				var_411_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_408_1.dialog_)
					var_411_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_408_1.duration_ = arg_408_1.duration_ + 0.3

				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_48 = arg_408_1:GetWordFromCfg(324161095)
				local var_411_49 = arg_408_1:FormatText(var_411_48.content)

				arg_408_1.text_.text = var_411_49

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_50 = 69
				local var_411_51 = utf8.len(var_411_49)
				local var_411_52 = var_411_50 <= 0 and var_411_46 or var_411_46 * (var_411_51 / var_411_50)

				if var_411_52 > 0 and var_411_46 < var_411_52 then
					arg_408_1.talkMaxDuration = var_411_52
					var_411_45 = var_411_45 + 0.3

					if var_411_52 + var_411_45 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_52 + var_411_45
					end
				end

				arg_408_1.text_.text = var_411_49
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_53 = var_411_45 + 0.3
			local var_411_54 = math.max(var_411_46, arg_408_1.talkMaxDuration)

			if var_411_53 <= arg_408_1.time_ and arg_408_1.time_ < var_411_53 + var_411_54 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_53) / var_411_54

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_53 + var_411_54 and arg_408_1.time_ < var_411_53 + var_411_54 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play324161096 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 324161096
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play324161097(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.7

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_2 = arg_414_1:GetWordFromCfg(324161096)
				local var_417_3 = arg_414_1:FormatText(var_417_2.content)

				arg_414_1.text_.text = var_417_3

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 28
				local var_417_5 = utf8.len(var_417_3)
				local var_417_6 = var_417_4 <= 0 and var_417_1 or var_417_1 * (var_417_5 / var_417_4)

				if var_417_6 > 0 and var_417_1 < var_417_6 then
					arg_414_1.talkMaxDuration = var_417_6

					if var_417_6 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_3
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_7 and arg_414_1.time_ < var_417_0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play324161097 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 324161097
		arg_418_1.duration_ = 4.27

		local var_418_0 = {
			zh = 3.1,
			ja = 4.266
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play324161098(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["6148ui_story"].transform
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.var_.moveOldPos6148ui_story = var_421_0.localPosition

				local var_421_2 = GameObjectTools.GetOrAddComponent(var_421_0.gameObject, typeof(DynamicBoneHelper))

				if var_421_2 then
					var_421_2:EnableDynamicBone(false)
				end
			end

			local var_421_3 = 0.001

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_3 then
				local var_421_4 = (arg_418_1.time_ - var_421_1) / var_421_3
				local var_421_5 = Vector3.New(-0.7, -0.985, -6)

				var_421_0.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos6148ui_story, var_421_5, var_421_4)

				local var_421_6 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_6.x, var_421_6.y, var_421_6.z)

				local var_421_7 = var_421_0.localEulerAngles

				var_421_7.z = 0
				var_421_7.x = 0
				var_421_0.localEulerAngles = var_421_7
			end

			if arg_418_1.time_ >= var_421_1 + var_421_3 and arg_418_1.time_ < var_421_1 + var_421_3 + arg_421_0 then
				var_421_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_421_8 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_8.x, var_421_8.y, var_421_8.z)

				local var_421_9 = var_421_0.localEulerAngles

				var_421_9.z = 0
				var_421_9.x = 0
				var_421_0.localEulerAngles = var_421_9

				local var_421_10 = GameObjectTools.GetOrAddComponent(var_421_0.gameObject, typeof(DynamicBoneHelper))

				if var_421_10 then
					var_421_10:EnableDynamicBone(true)
				end
			end

			local var_421_11 = arg_418_1.actors_["6148ui_story"]
			local var_421_12 = 0

			if var_421_12 < arg_418_1.time_ and arg_418_1.time_ <= var_421_12 + arg_421_0 and not isNil(var_421_11) and arg_418_1.var_.characterEffect6148ui_story == nil then
				arg_418_1.var_.characterEffect6148ui_story = var_421_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_13 = 0.200000002980232

			if var_421_12 <= arg_418_1.time_ and arg_418_1.time_ < var_421_12 + var_421_13 and not isNil(var_421_11) then
				local var_421_14 = (arg_418_1.time_ - var_421_12) / var_421_13

				if arg_418_1.var_.characterEffect6148ui_story and not isNil(var_421_11) then
					arg_418_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_12 + var_421_13 and arg_418_1.time_ < var_421_12 + var_421_13 + arg_421_0 and not isNil(var_421_11) and arg_418_1.var_.characterEffect6148ui_story then
				arg_418_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_421_15 = 0

			if var_421_15 < arg_418_1.time_ and arg_418_1.time_ <= var_421_15 + arg_421_0 then
				arg_418_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_421_16 = 0

			if var_421_16 < arg_418_1.time_ and arg_418_1.time_ <= var_421_16 + arg_421_0 then
				arg_418_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_421_17 = 0
			local var_421_18 = 0.3

			if var_421_17 < arg_418_1.time_ and arg_418_1.time_ <= var_421_17 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_19 = arg_418_1:FormatText(StoryNameCfg[1488].name)

				arg_418_1.leftNameTxt_.text = var_421_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_20 = arg_418_1:GetWordFromCfg(324161097)
				local var_421_21 = arg_418_1:FormatText(var_421_20.content)

				arg_418_1.text_.text = var_421_21

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_22 = 12
				local var_421_23 = utf8.len(var_421_21)
				local var_421_24 = var_421_22 <= 0 and var_421_18 or var_421_18 * (var_421_23 / var_421_22)

				if var_421_24 > 0 and var_421_18 < var_421_24 then
					arg_418_1.talkMaxDuration = var_421_24

					if var_421_24 + var_421_17 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_24 + var_421_17
					end
				end

				arg_418_1.text_.text = var_421_21
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161097", "story_v_out_324161.awb") ~= 0 then
					local var_421_25 = manager.audio:GetVoiceLength("story_v_out_324161", "324161097", "story_v_out_324161.awb") / 1000

					if var_421_25 + var_421_17 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_25 + var_421_17
					end

					if var_421_20.prefab_name ~= "" and arg_418_1.actors_[var_421_20.prefab_name] ~= nil then
						local var_421_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_20.prefab_name].transform, "story_v_out_324161", "324161097", "story_v_out_324161.awb")

						arg_418_1:RecordAudio("324161097", var_421_26)
						arg_418_1:RecordAudio("324161097", var_421_26)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_324161", "324161097", "story_v_out_324161.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_324161", "324161097", "story_v_out_324161.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_27 = math.max(var_421_18, arg_418_1.talkMaxDuration)

			if var_421_17 <= arg_418_1.time_ and arg_418_1.time_ < var_421_17 + var_421_27 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_17) / var_421_27

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_17 + var_421_27 and arg_418_1.time_ < var_421_17 + var_421_27 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
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

		arg_418_1:InitPlayNodeList()
	end,
	Play324161098 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 324161098
		arg_422_1.duration_ = 4.47

		local var_422_0 = {
			zh = 4.466,
			ja = 3.933
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
			arg_422_1.auto_ = false
		end

		function arg_422_1.playNext_(arg_424_0)
			arg_422_1.onStoryFinished_()
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1054ui_story"].transform
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.var_.moveOldPos1054ui_story = var_425_0.localPosition

				local var_425_2 = GameObjectTools.GetOrAddComponent(var_425_0.gameObject, typeof(DynamicBoneHelper))

				if var_425_2 then
					var_425_2:EnableDynamicBone(false)
				end
			end

			local var_425_3 = 0.001

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_3 then
				local var_425_4 = (arg_422_1.time_ - var_425_1) / var_425_3
				local var_425_5 = Vector3.New(0.7, -0.985, -6)

				var_425_0.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1054ui_story, var_425_5, var_425_4)

				local var_425_6 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_6.x, var_425_6.y, var_425_6.z)

				local var_425_7 = var_425_0.localEulerAngles

				var_425_7.z = 0
				var_425_7.x = 0
				var_425_0.localEulerAngles = var_425_7
			end

			if arg_422_1.time_ >= var_425_1 + var_425_3 and arg_422_1.time_ < var_425_1 + var_425_3 + arg_425_0 then
				var_425_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_425_8 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_8.x, var_425_8.y, var_425_8.z)

				local var_425_9 = var_425_0.localEulerAngles

				var_425_9.z = 0
				var_425_9.x = 0
				var_425_0.localEulerAngles = var_425_9

				local var_425_10 = GameObjectTools.GetOrAddComponent(var_425_0.gameObject, typeof(DynamicBoneHelper))

				if var_425_10 then
					var_425_10:EnableDynamicBone(true)
				end
			end

			local var_425_11 = arg_422_1.actors_["1054ui_story"]
			local var_425_12 = 0

			if var_425_12 < arg_422_1.time_ and arg_422_1.time_ <= var_425_12 + arg_425_0 and not isNil(var_425_11) and arg_422_1.var_.characterEffect1054ui_story == nil then
				arg_422_1.var_.characterEffect1054ui_story = var_425_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_13 = 0.200000002980232

			if var_425_12 <= arg_422_1.time_ and arg_422_1.time_ < var_425_12 + var_425_13 and not isNil(var_425_11) then
				local var_425_14 = (arg_422_1.time_ - var_425_12) / var_425_13

				if arg_422_1.var_.characterEffect1054ui_story and not isNil(var_425_11) then
					arg_422_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= var_425_12 + var_425_13 and arg_422_1.time_ < var_425_12 + var_425_13 + arg_425_0 and not isNil(var_425_11) and arg_422_1.var_.characterEffect1054ui_story then
				arg_422_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_425_15 = arg_422_1.actors_["6148ui_story"]
			local var_425_16 = 0

			if var_425_16 < arg_422_1.time_ and arg_422_1.time_ <= var_425_16 + arg_425_0 and not isNil(var_425_15) and arg_422_1.var_.characterEffect6148ui_story == nil then
				arg_422_1.var_.characterEffect6148ui_story = var_425_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_17 = 0.200000002980232

			if var_425_16 <= arg_422_1.time_ and arg_422_1.time_ < var_425_16 + var_425_17 and not isNil(var_425_15) then
				local var_425_18 = (arg_422_1.time_ - var_425_16) / var_425_17

				if arg_422_1.var_.characterEffect6148ui_story and not isNil(var_425_15) then
					local var_425_19 = Mathf.Lerp(0, 0.5, var_425_18)

					arg_422_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_422_1.var_.characterEffect6148ui_story.fillRatio = var_425_19
				end
			end

			if arg_422_1.time_ >= var_425_16 + var_425_17 and arg_422_1.time_ < var_425_16 + var_425_17 + arg_425_0 and not isNil(var_425_15) and arg_422_1.var_.characterEffect6148ui_story then
				local var_425_20 = 0.5

				arg_422_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_422_1.var_.characterEffect6148ui_story.fillRatio = var_425_20
			end

			local var_425_21 = 0

			if var_425_21 < arg_422_1.time_ and arg_422_1.time_ <= var_425_21 + arg_425_0 then
				arg_422_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_425_22 = 0

			if var_425_22 < arg_422_1.time_ and arg_422_1.time_ <= var_425_22 + arg_425_0 then
				arg_422_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_425_23 = 0
			local var_425_24 = 0.275

			if var_425_23 < arg_422_1.time_ and arg_422_1.time_ <= var_425_23 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_25 = arg_422_1:FormatText(StoryNameCfg[1487].name)

				arg_422_1.leftNameTxt_.text = var_425_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_26 = arg_422_1:GetWordFromCfg(324161098)
				local var_425_27 = arg_422_1:FormatText(var_425_26.content)

				arg_422_1.text_.text = var_425_27

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_28 = 11
				local var_425_29 = utf8.len(var_425_27)
				local var_425_30 = var_425_28 <= 0 and var_425_24 or var_425_24 * (var_425_29 / var_425_28)

				if var_425_30 > 0 and var_425_24 < var_425_30 then
					arg_422_1.talkMaxDuration = var_425_30

					if var_425_30 + var_425_23 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_30 + var_425_23
					end
				end

				arg_422_1.text_.text = var_425_27
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324161", "324161098", "story_v_out_324161.awb") ~= 0 then
					local var_425_31 = manager.audio:GetVoiceLength("story_v_out_324161", "324161098", "story_v_out_324161.awb") / 1000

					if var_425_31 + var_425_23 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_31 + var_425_23
					end

					if var_425_26.prefab_name ~= "" and arg_422_1.actors_[var_425_26.prefab_name] ~= nil then
						local var_425_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_26.prefab_name].transform, "story_v_out_324161", "324161098", "story_v_out_324161.awb")

						arg_422_1:RecordAudio("324161098", var_425_32)
						arg_422_1:RecordAudio("324161098", var_425_32)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_324161", "324161098", "story_v_out_324161.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_324161", "324161098", "story_v_out_324161.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_33 = math.max(var_425_24, arg_422_1.talkMaxDuration)

			if var_425_23 <= arg_422_1.time_ and arg_422_1.time_ < var_425_23 + var_425_33 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_23) / var_425_33

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_23 + var_425_33 and arg_422_1.time_ < var_425_23 + var_425_33 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
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

		arg_422_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2008",
		"TextureConfig/Background/J27i",
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/MS2404",
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324161.awb"
	}
}
