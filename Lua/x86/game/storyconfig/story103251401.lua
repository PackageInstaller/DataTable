return {
	Play325141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325141001
		arg_1_1.duration_ = 5.8

		local var_1_0 = {
			zh = 4.99966666666667,
			ja = 5.79966666666667
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
				arg_1_0:Play325141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J29g"

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
				local var_4_5 = arg_1_1.bgs_.J29g

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
					if iter_4_0 ~= "J29g" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 1.76666666666667
			local var_4_35 = 0.1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[1455].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(325141001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 4
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141001", "story_v_out_325141.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_325141", "325141001", "story_v_out_325141.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_325141", "325141001", "story_v_out_325141.awb")

						arg_1_1:RecordAudio("325141001", var_4_44)
						arg_1_1:RecordAudio("325141001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325141", "325141001", "story_v_out_325141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325141", "325141001", "story_v_out_325141.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325141002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325141002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325141003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.8
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_151", "se_story_151_break_drop", "")
			end

			local var_11_4 = 0
			local var_11_5 = 1.5

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:GetWordFromCfg(325141002)
				local var_11_7 = arg_8_1:FormatText(var_11_6.content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 60
				local var_11_9 = utf8.len(var_11_7)
				local var_11_10 = var_11_8 <= 0 and var_11_5 or var_11_5 * (var_11_9 / var_11_8)

				if var_11_10 > 0 and var_11_5 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_11 and arg_8_1.time_ < var_11_4 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325141003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325141003
		arg_12_1.duration_ = 4.6

		local var_12_0 = {
			zh = 2.333,
			ja = 4.6
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
				arg_12_0:Play325141004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.225

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[1455].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(325141003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141003", "story_v_out_325141.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_325141", "325141003", "story_v_out_325141.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_325141", "325141003", "story_v_out_325141.awb")

						arg_12_1:RecordAudio("325141003", var_15_9)
						arg_12_1:RecordAudio("325141003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325141", "325141003", "story_v_out_325141.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325141", "325141003", "story_v_out_325141.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325141004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325141004
		arg_16_1.duration_ = 11.4

		local var_16_0 = {
			zh = 5.7,
			ja = 11.4
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
				arg_16_0:Play325141005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "10180ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "10180ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["10180ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos10180ui_story = var_19_5.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(-0.03, -1.09, -6.14)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10180ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14

				local var_19_15 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_15 then
					var_19_15:EnableDynamicBone(true)
				end
			end

			local var_19_16 = arg_16_1.actors_["10180ui_story"]
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect10180ui_story == nil then
				arg_16_1.var_.characterEffect10180ui_story = var_19_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_18 = 0.200000002980232

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 and not isNil(var_19_16) then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18

				if arg_16_1.var_.characterEffect10180ui_story and not isNil(var_19_16) then
					arg_16_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect10180ui_story then
				arg_16_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_19_20 = "1059ui_story"

			if arg_16_1.actors_[var_19_20] == nil then
				local var_19_21 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_19_21) then
					local var_19_22 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_16_1.stage_.transform)

					var_19_22.name = var_19_20
					var_19_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_20] = var_19_22

					local var_19_23 = var_19_22:GetComponentInChildren(typeof(CharacterEffect))

					var_19_23.enabled = true

					local var_19_24 = GameObjectTools.GetOrAddComponent(var_19_22, typeof(DynamicBoneHelper))

					if var_19_24 then
						var_19_24:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_23.transform, false)

					arg_16_1.var_[var_19_20 .. "Animator"] = var_19_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_20 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_20 .. "LipSync"] = var_19_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_25 = arg_16_1.actors_["1059ui_story"]
			local var_19_26 = 0

			if var_19_26 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 and not isNil(var_19_25) and arg_16_1.var_.characterEffect1059ui_story == nil then
				arg_16_1.var_.characterEffect1059ui_story = var_19_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_27 = 0.200000002980232

			if var_19_26 <= arg_16_1.time_ and arg_16_1.time_ < var_19_26 + var_19_27 and not isNil(var_19_25) then
				local var_19_28 = (arg_16_1.time_ - var_19_26) / var_19_27

				if arg_16_1.var_.characterEffect1059ui_story and not isNil(var_19_25) then
					local var_19_29 = Mathf.Lerp(0, 0.5, var_19_28)

					arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1059ui_story.fillRatio = var_19_29
				end
			end

			if arg_16_1.time_ >= var_19_26 + var_19_27 and arg_16_1.time_ < var_19_26 + var_19_27 + arg_19_0 and not isNil(var_19_25) and arg_16_1.var_.characterEffect1059ui_story then
				local var_19_30 = 0.5

				arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1059ui_story.fillRatio = var_19_30
			end

			local var_19_31 = 0

			if var_19_31 < arg_16_1.time_ and arg_16_1.time_ <= var_19_31 + arg_19_0 then
				arg_16_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			local var_19_32 = 0

			if var_19_32 < arg_16_1.time_ and arg_16_1.time_ <= var_19_32 + arg_19_0 then
				arg_16_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_33 = 0
			local var_19_34 = 0.45

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_35 = arg_16_1:FormatText(StoryNameCfg[1503].name)

				arg_16_1.leftNameTxt_.text = var_19_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_36 = arg_16_1:GetWordFromCfg(325141004)
				local var_19_37 = arg_16_1:FormatText(var_19_36.content)

				arg_16_1.text_.text = var_19_37

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_38 = 18
				local var_19_39 = utf8.len(var_19_37)
				local var_19_40 = var_19_38 <= 0 and var_19_34 or var_19_34 * (var_19_39 / var_19_38)

				if var_19_40 > 0 and var_19_34 < var_19_40 then
					arg_16_1.talkMaxDuration = var_19_40

					if var_19_40 + var_19_33 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_40 + var_19_33
					end
				end

				arg_16_1.text_.text = var_19_37
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141004", "story_v_out_325141.awb") ~= 0 then
					local var_19_41 = manager.audio:GetVoiceLength("story_v_out_325141", "325141004", "story_v_out_325141.awb") / 1000

					if var_19_41 + var_19_33 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_41 + var_19_33
					end

					if var_19_36.prefab_name ~= "" and arg_16_1.actors_[var_19_36.prefab_name] ~= nil then
						local var_19_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_36.prefab_name].transform, "story_v_out_325141", "325141004", "story_v_out_325141.awb")

						arg_16_1:RecordAudio("325141004", var_19_42)
						arg_16_1:RecordAudio("325141004", var_19_42)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325141", "325141004", "story_v_out_325141.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325141", "325141004", "story_v_out_325141.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_43 = math.max(var_19_34, arg_16_1.talkMaxDuration)

			if var_19_33 <= arg_16_1.time_ and arg_16_1.time_ < var_19_33 + var_19_43 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_33) / var_19_43

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_33 + var_19_43 and arg_16_1.time_ < var_19_33 + var_19_43 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325141005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325141005
		arg_20_1.duration_ = 6.93

		local var_20_0 = {
			zh = 4.1,
			ja = 6.933
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
				arg_20_0:Play325141006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10180ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10180ui_story == nil then
				arg_20_1.var_.characterEffect10180ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect10180ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10180ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10180ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10180ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.5

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[1455].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(325141005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141005", "story_v_out_325141.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141005", "story_v_out_325141.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_325141", "325141005", "story_v_out_325141.awb")

						arg_20_1:RecordAudio("325141005", var_23_15)
						arg_20_1:RecordAudio("325141005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325141", "325141005", "story_v_out_325141.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325141", "325141005", "story_v_out_325141.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325141006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325141006
		arg_24_1.duration_ = 10.93

		local var_24_0 = {
			zh = 7.366,
			ja = 10.933
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
				arg_24_0:Play325141007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10180ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10180ui_story == nil then
				arg_24_1.var_.characterEffect10180ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10180ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10180ui_story then
				arg_24_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_27_4 = 0
			local var_27_5 = 0.675

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_6 = arg_24_1:FormatText(StoryNameCfg[1503].name)

				arg_24_1.leftNameTxt_.text = var_27_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:GetWordFromCfg(325141006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141006", "story_v_out_325141.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_325141", "325141006", "story_v_out_325141.awb") / 1000

					if var_27_12 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_4
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_out_325141", "325141006", "story_v_out_325141.awb")

						arg_24_1:RecordAudio("325141006", var_27_13)
						arg_24_1:RecordAudio("325141006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325141", "325141006", "story_v_out_325141.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325141", "325141006", "story_v_out_325141.awb")
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
	Play325141007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325141007
		arg_28_1.duration_ = 7.27

		local var_28_0 = {
			zh = 5,
			ja = 7.266
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
				arg_28_0:Play325141008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10180ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10180ui_story == nil then
				arg_28_1.var_.characterEffect10180ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10180ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10180ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10180ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10180ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.45

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[1455].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(325141007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141007", "story_v_out_325141.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141007", "story_v_out_325141.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_325141", "325141007", "story_v_out_325141.awb")

						arg_28_1:RecordAudio("325141007", var_31_15)
						arg_28_1:RecordAudio("325141007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325141", "325141007", "story_v_out_325141.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325141", "325141007", "story_v_out_325141.awb")
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
	Play325141008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325141008
		arg_32_1.duration_ = 6.2

		local var_32_0 = {
			zh = 3.466,
			ja = 6.2
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
				arg_32_0:Play325141009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10180ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10180ui_story == nil then
				arg_32_1.var_.characterEffect10180ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10180ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10180ui_story then
				arg_32_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1059ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1059ui_story == nil then
				arg_32_1.var_.characterEffect1059ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1059ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1059ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1059ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1059ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180actionlink/10180action4819")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 0.275

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[1503].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(325141008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141008", "story_v_out_325141.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_325141", "325141008", "story_v_out_325141.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_325141", "325141008", "story_v_out_325141.awb")

						arg_32_1:RecordAudio("325141008", var_35_21)
						arg_32_1:RecordAudio("325141008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325141", "325141008", "story_v_out_325141.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325141", "325141008", "story_v_out_325141.awb")
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
	Play325141009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325141009
		arg_36_1.duration_ = 10.1

		local var_36_0 = {
			zh = 5.133,
			ja = 10.1
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
				arg_36_0:Play325141010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.475

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[1503].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(325141009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141009", "story_v_out_325141.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_325141", "325141009", "story_v_out_325141.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_325141", "325141009", "story_v_out_325141.awb")

						arg_36_1:RecordAudio("325141009", var_39_9)
						arg_36_1:RecordAudio("325141009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325141", "325141009", "story_v_out_325141.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325141", "325141009", "story_v_out_325141.awb")
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
	Play325141010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325141010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325141011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10180ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos10180ui_story = var_43_0.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_3 then
				local var_43_4 = (arg_40_1.time_ - var_43_1) / var_43_3
				local var_43_5 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10180ui_story, var_43_5, var_43_4)

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

			local var_43_11 = arg_40_1.actors_["1059ui_story"].transform
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.var_.moveOldPos1059ui_story = var_43_11.localPosition
			end

			local var_43_13 = 0.001

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_13 then
				local var_43_14 = (arg_40_1.time_ - var_43_12) / var_43_13
				local var_43_15 = Vector3.New(0, 100, 0)

				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1059ui_story, var_43_15, var_43_14)

				local var_43_16 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_16.x, var_43_16.y, var_43_16.z)

				local var_43_17 = var_43_11.localEulerAngles

				var_43_17.z = 0
				var_43_17.x = 0
				var_43_11.localEulerAngles = var_43_17
			end

			if arg_40_1.time_ >= var_43_12 + var_43_13 and arg_40_1.time_ < var_43_12 + var_43_13 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(0, 100, 0)

				local var_43_18 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_18.x, var_43_18.y, var_43_18.z)

				local var_43_19 = var_43_11.localEulerAngles

				var_43_19.z = 0
				var_43_19.x = 0
				var_43_11.localEulerAngles = var_43_19
			end

			local var_43_20 = arg_40_1.actors_["10180ui_story"]
			local var_43_21 = 0

			if var_43_21 < arg_40_1.time_ and arg_40_1.time_ <= var_43_21 + arg_43_0 and not isNil(var_43_20) and arg_40_1.var_.characterEffect10180ui_story == nil then
				arg_40_1.var_.characterEffect10180ui_story = var_43_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_22 = 0.200000002980232

			if var_43_21 <= arg_40_1.time_ and arg_40_1.time_ < var_43_21 + var_43_22 and not isNil(var_43_20) then
				local var_43_23 = (arg_40_1.time_ - var_43_21) / var_43_22

				if arg_40_1.var_.characterEffect10180ui_story and not isNil(var_43_20) then
					local var_43_24 = Mathf.Lerp(0, 0.5, var_43_23)

					arg_40_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10180ui_story.fillRatio = var_43_24
				end
			end

			if arg_40_1.time_ >= var_43_21 + var_43_22 and arg_40_1.time_ < var_43_21 + var_43_22 + arg_43_0 and not isNil(var_43_20) and arg_40_1.var_.characterEffect10180ui_story then
				local var_43_25 = 0.5

				arg_40_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10180ui_story.fillRatio = var_43_25
			end

			local var_43_26 = 0
			local var_43_27 = 0.925

			if var_43_26 < arg_40_1.time_ and arg_40_1.time_ <= var_43_26 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_28 = arg_40_1:GetWordFromCfg(325141010)
				local var_43_29 = arg_40_1:FormatText(var_43_28.content)

				arg_40_1.text_.text = var_43_29

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_30 = 37
				local var_43_31 = utf8.len(var_43_29)
				local var_43_32 = var_43_30 <= 0 and var_43_27 or var_43_27 * (var_43_31 / var_43_30)

				if var_43_32 > 0 and var_43_27 < var_43_32 then
					arg_40_1.talkMaxDuration = var_43_32

					if var_43_32 + var_43_26 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_32 + var_43_26
					end
				end

				arg_40_1.text_.text = var_43_29
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_33 = math.max(var_43_27, arg_40_1.talkMaxDuration)

			if var_43_26 <= arg_40_1.time_ and arg_40_1.time_ < var_43_26 + var_43_33 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_26) / var_43_33

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_26 + var_43_33 and arg_40_1.time_ < var_43_26 + var_43_33 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play325141011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325141011
		arg_44_1.duration_ = 6.03

		local var_44_0 = {
			zh = 5.666,
			ja = 6.033
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
				arg_44_0:Play325141012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.3

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[1455].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(325141011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 12
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141011", "story_v_out_325141.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_325141", "325141011", "story_v_out_325141.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_325141", "325141011", "story_v_out_325141.awb")

						arg_44_1:RecordAudio("325141011", var_47_9)
						arg_44_1:RecordAudio("325141011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325141", "325141011", "story_v_out_325141.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325141", "325141011", "story_v_out_325141.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325141012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325141012
		arg_48_1.duration_ = 6.87

		local var_48_0 = {
			zh = 6.4,
			ja = 6.866
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
				arg_48_0:Play325141013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10180ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos10180ui_story = var_51_0.localPosition

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end
			end

			local var_51_3 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_3 then
				local var_51_4 = (arg_48_1.time_ - var_51_1) / var_51_3
				local var_51_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10180ui_story, var_51_5, var_51_4)

				local var_51_6 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_6.x, var_51_6.y, var_51_6.z)

				local var_51_7 = var_51_0.localEulerAngles

				var_51_7.z = 0
				var_51_7.x = 0
				var_51_0.localEulerAngles = var_51_7
			end

			if arg_48_1.time_ >= var_51_1 + var_51_3 and arg_48_1.time_ < var_51_1 + var_51_3 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_51_8 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_8.x, var_51_8.y, var_51_8.z)

				local var_51_9 = var_51_0.localEulerAngles

				var_51_9.z = 0
				var_51_9.x = 0
				var_51_0.localEulerAngles = var_51_9

				local var_51_10 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_10 then
					var_51_10:EnableDynamicBone(true)
				end
			end

			local var_51_11 = arg_48_1.actors_["10180ui_story"]
			local var_51_12 = 0

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 and not isNil(var_51_11) and arg_48_1.var_.characterEffect10180ui_story == nil then
				arg_48_1.var_.characterEffect10180ui_story = var_51_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_13 = 0.200000002980232

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_13 and not isNil(var_51_11) then
				local var_51_14 = (arg_48_1.time_ - var_51_12) / var_51_13

				if arg_48_1.var_.characterEffect10180ui_story and not isNil(var_51_11) then
					arg_48_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_12 + var_51_13 and arg_48_1.time_ < var_51_12 + var_51_13 + arg_51_0 and not isNil(var_51_11) and arg_48_1.var_.characterEffect10180ui_story then
				arg_48_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action19_2")
			end

			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_51_17 = 0
			local var_51_18 = 0.475

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_19 = arg_48_1:FormatText(StoryNameCfg[1503].name)

				arg_48_1.leftNameTxt_.text = var_51_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_20 = arg_48_1:GetWordFromCfg(325141012)
				local var_51_21 = arg_48_1:FormatText(var_51_20.content)

				arg_48_1.text_.text = var_51_21

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_22 = 19
				local var_51_23 = utf8.len(var_51_21)
				local var_51_24 = var_51_22 <= 0 and var_51_18 or var_51_18 * (var_51_23 / var_51_22)

				if var_51_24 > 0 and var_51_18 < var_51_24 then
					arg_48_1.talkMaxDuration = var_51_24

					if var_51_24 + var_51_17 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_24 + var_51_17
					end
				end

				arg_48_1.text_.text = var_51_21
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141012", "story_v_out_325141.awb") ~= 0 then
					local var_51_25 = manager.audio:GetVoiceLength("story_v_out_325141", "325141012", "story_v_out_325141.awb") / 1000

					if var_51_25 + var_51_17 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_25 + var_51_17
					end

					if var_51_20.prefab_name ~= "" and arg_48_1.actors_[var_51_20.prefab_name] ~= nil then
						local var_51_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_20.prefab_name].transform, "story_v_out_325141", "325141012", "story_v_out_325141.awb")

						arg_48_1:RecordAudio("325141012", var_51_26)
						arg_48_1:RecordAudio("325141012", var_51_26)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325141", "325141012", "story_v_out_325141.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325141", "325141012", "story_v_out_325141.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_27 = math.max(var_51_18, arg_48_1.talkMaxDuration)

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_27 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_17) / var_51_27

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_17 + var_51_27 and arg_48_1.time_ < var_51_17 + var_51_27 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325141013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325141013
		arg_52_1.duration_ = 18.9

		local var_52_0 = {
			zh = 9.1,
			ja = 18.9
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
				arg_52_0:Play325141014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[1503].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(325141013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 40
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141013", "story_v_out_325141.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_325141", "325141013", "story_v_out_325141.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_325141", "325141013", "story_v_out_325141.awb")

						arg_52_1:RecordAudio("325141013", var_55_9)
						arg_52_1:RecordAudio("325141013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325141", "325141013", "story_v_out_325141.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325141", "325141013", "story_v_out_325141.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325141014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325141014
		arg_56_1.duration_ = 7.53

		local var_56_0 = {
			zh = 3.433,
			ja = 7.533
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
				arg_56_0:Play325141015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10180ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10180ui_story == nil then
				arg_56_1.var_.characterEffect10180ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect10180ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10180ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10180ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10180ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.25

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[1455].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(325141014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 10
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141014", "story_v_out_325141.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141014", "story_v_out_325141.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_325141", "325141014", "story_v_out_325141.awb")

						arg_56_1:RecordAudio("325141014", var_59_15)
						arg_56_1:RecordAudio("325141014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325141", "325141014", "story_v_out_325141.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325141", "325141014", "story_v_out_325141.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325141015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325141015
		arg_60_1.duration_ = 23.03

		local var_60_0 = {
			zh = 13.033,
			ja = 23.033
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
				arg_60_0:Play325141016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10180ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10180ui_story == nil then
				arg_60_1.var_.characterEffect10180ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect10180ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10180ui_story then
				arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1059ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1059ui_story == nil then
				arg_60_1.var_.characterEffect1059ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1059ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1059ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1059ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1059ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0
			local var_63_11 = 1.15

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_12 = arg_60_1:FormatText(StoryNameCfg[1503].name)

				arg_60_1.leftNameTxt_.text = var_63_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_13 = arg_60_1:GetWordFromCfg(325141015)
				local var_63_14 = arg_60_1:FormatText(var_63_13.content)

				arg_60_1.text_.text = var_63_14

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 46
				local var_63_16 = utf8.len(var_63_14)
				local var_63_17 = var_63_15 <= 0 and var_63_11 or var_63_11 * (var_63_16 / var_63_15)

				if var_63_17 > 0 and var_63_11 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_14
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141015", "story_v_out_325141.awb") ~= 0 then
					local var_63_18 = manager.audio:GetVoiceLength("story_v_out_325141", "325141015", "story_v_out_325141.awb") / 1000

					if var_63_18 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_10
					end

					if var_63_13.prefab_name ~= "" and arg_60_1.actors_[var_63_13.prefab_name] ~= nil then
						local var_63_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_13.prefab_name].transform, "story_v_out_325141", "325141015", "story_v_out_325141.awb")

						arg_60_1:RecordAudio("325141015", var_63_19)
						arg_60_1:RecordAudio("325141015", var_63_19)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325141", "325141015", "story_v_out_325141.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325141", "325141015", "story_v_out_325141.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_20 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_20

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_20 and arg_60_1.time_ < var_63_10 + var_63_20 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325141016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325141016
		arg_64_1.duration_ = 7.6

		local var_64_0 = {
			zh = 2.7,
			ja = 7.6
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
				arg_64_0:Play325141017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10180ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10180ui_story == nil then
				arg_64_1.var_.characterEffect10180ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10180ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10180ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10180ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10180ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.275

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[1455].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(325141016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 11
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141016", "story_v_out_325141.awb") ~= 0 then
					local var_67_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141016", "story_v_out_325141.awb") / 1000

					if var_67_14 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_6
					end

					if var_67_9.prefab_name ~= "" and arg_64_1.actors_[var_67_9.prefab_name] ~= nil then
						local var_67_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_9.prefab_name].transform, "story_v_out_325141", "325141016", "story_v_out_325141.awb")

						arg_64_1:RecordAudio("325141016", var_67_15)
						arg_64_1:RecordAudio("325141016", var_67_15)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325141", "325141016", "story_v_out_325141.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325141", "325141016", "story_v_out_325141.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_16 and arg_64_1.time_ < var_67_6 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325141017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325141017
		arg_68_1.duration_ = 9.5

		local var_68_0 = {
			zh = 6.866,
			ja = 9.5
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
				arg_68_0:Play325141018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10180ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10180ui_story == nil then
				arg_68_1.var_.characterEffect10180ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10180ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10180ui_story then
				arg_68_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1059ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1059ui_story == nil then
				arg_68_1.var_.characterEffect1059ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.200000002980232

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1059ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1059ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1059ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1059ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0
			local var_71_11 = 0.625

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_12 = arg_68_1:FormatText(StoryNameCfg[1503].name)

				arg_68_1.leftNameTxt_.text = var_71_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_13 = arg_68_1:GetWordFromCfg(325141017)
				local var_71_14 = arg_68_1:FormatText(var_71_13.content)

				arg_68_1.text_.text = var_71_14

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141017", "story_v_out_325141.awb") ~= 0 then
					local var_71_18 = manager.audio:GetVoiceLength("story_v_out_325141", "325141017", "story_v_out_325141.awb") / 1000

					if var_71_18 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_10
					end

					if var_71_13.prefab_name ~= "" and arg_68_1.actors_[var_71_13.prefab_name] ~= nil then
						local var_71_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_13.prefab_name].transform, "story_v_out_325141", "325141017", "story_v_out_325141.awb")

						arg_68_1:RecordAudio("325141017", var_71_19)
						arg_68_1:RecordAudio("325141017", var_71_19)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325141", "325141017", "story_v_out_325141.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325141", "325141017", "story_v_out_325141.awb")
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
	Play325141018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325141018
		arg_72_1.duration_ = 24.4

		local var_72_0 = {
			zh = 11.666,
			ja = 24.4
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
				arg_72_0:Play325141019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action22_1")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 1.05

			if var_75_2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_4 = arg_72_1:FormatText(StoryNameCfg[1503].name)

				arg_72_1.leftNameTxt_.text = var_75_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:GetWordFromCfg(325141018)
				local var_75_6 = arg_72_1:FormatText(var_75_5.content)

				arg_72_1.text_.text = var_75_6

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 42
				local var_75_8 = utf8.len(var_75_6)
				local var_75_9 = var_75_7 <= 0 and var_75_3 or var_75_3 * (var_75_8 / var_75_7)

				if var_75_9 > 0 and var_75_3 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_6
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141018", "story_v_out_325141.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_325141", "325141018", "story_v_out_325141.awb") / 1000

					if var_75_10 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_2
					end

					if var_75_5.prefab_name ~= "" and arg_72_1.actors_[var_75_5.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_5.prefab_name].transform, "story_v_out_325141", "325141018", "story_v_out_325141.awb")

						arg_72_1:RecordAudio("325141018", var_75_11)
						arg_72_1:RecordAudio("325141018", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325141", "325141018", "story_v_out_325141.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325141", "325141018", "story_v_out_325141.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_12 and arg_72_1.time_ < var_75_2 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325141019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325141019
		arg_76_1.duration_ = 10.93

		local var_76_0 = {
			zh = 4.766,
			ja = 10.933
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
				arg_76_0:Play325141020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10180ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10180ui_story == nil then
				arg_76_1.var_.characterEffect10180ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect10180ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10180ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10180ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10180ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.475

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[1455].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(325141019)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 19
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141019", "story_v_out_325141.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141019", "story_v_out_325141.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_325141", "325141019", "story_v_out_325141.awb")

						arg_76_1:RecordAudio("325141019", var_79_15)
						arg_76_1:RecordAudio("325141019", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325141", "325141019", "story_v_out_325141.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325141", "325141019", "story_v_out_325141.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325141020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325141020
		arg_80_1.duration_ = 11.83

		local var_80_0 = {
			zh = 7.733,
			ja = 11.833
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
				arg_80_0:Play325141021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10180ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10180ui_story == nil then
				arg_80_1.var_.characterEffect10180ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10180ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10180ui_story then
				arg_80_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1059ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1059ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0
			local var_83_11 = 0.7

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_12 = arg_80_1:FormatText(StoryNameCfg[1503].name)

				arg_80_1.leftNameTxt_.text = var_83_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:GetWordFromCfg(325141020)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141020", "story_v_out_325141.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_325141", "325141020", "story_v_out_325141.awb") / 1000

					if var_83_18 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_10
					end

					if var_83_13.prefab_name ~= "" and arg_80_1.actors_[var_83_13.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_13.prefab_name].transform, "story_v_out_325141", "325141020", "story_v_out_325141.awb")

						arg_80_1:RecordAudio("325141020", var_83_19)
						arg_80_1:RecordAudio("325141020", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325141", "325141020", "story_v_out_325141.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325141", "325141020", "story_v_out_325141.awb")
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
	Play325141021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325141021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325141022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10180ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos10180ui_story = var_87_0.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_3 then
				local var_87_4 = (arg_84_1.time_ - var_87_1) / var_87_3
				local var_87_5 = Vector3.New(0, 100, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10180ui_story, var_87_5, var_87_4)

				local var_87_6 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_6.x, var_87_6.y, var_87_6.z)

				local var_87_7 = var_87_0.localEulerAngles

				var_87_7.z = 0
				var_87_7.x = 0
				var_87_0.localEulerAngles = var_87_7
			end

			if arg_84_1.time_ >= var_87_1 + var_87_3 and arg_84_1.time_ < var_87_1 + var_87_3 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, 100, 0)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_0.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_0.localEulerAngles = var_87_9

				local var_87_10 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_10 then
					var_87_10:EnableDynamicBone(true)
				end
			end

			local var_87_11 = arg_84_1.actors_["1059ui_story"].transform
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.var_.moveOldPos1059ui_story = var_87_11.localPosition
			end

			local var_87_13 = 0.001

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13
				local var_87_15 = Vector3.New(0, 100, 0)

				var_87_11.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1059ui_story, var_87_15, var_87_14)

				local var_87_16 = manager.ui.mainCamera.transform.position - var_87_11.position

				var_87_11.forward = Vector3.New(var_87_16.x, var_87_16.y, var_87_16.z)

				local var_87_17 = var_87_11.localEulerAngles

				var_87_17.z = 0
				var_87_17.x = 0
				var_87_11.localEulerAngles = var_87_17
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 then
				var_87_11.localPosition = Vector3.New(0, 100, 0)

				local var_87_18 = manager.ui.mainCamera.transform.position - var_87_11.position

				var_87_11.forward = Vector3.New(var_87_18.x, var_87_18.y, var_87_18.z)

				local var_87_19 = var_87_11.localEulerAngles

				var_87_19.z = 0
				var_87_19.x = 0
				var_87_11.localEulerAngles = var_87_19
			end

			local var_87_20 = arg_84_1.actors_["10180ui_story"]
			local var_87_21 = 0

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect10180ui_story == nil then
				arg_84_1.var_.characterEffect10180ui_story = var_87_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_22 = 0.200000002980232

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 and not isNil(var_87_20) then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / var_87_22

				if arg_84_1.var_.characterEffect10180ui_story and not isNil(var_87_20) then
					local var_87_24 = Mathf.Lerp(0, 0.5, var_87_23)

					arg_84_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10180ui_story.fillRatio = var_87_24
				end
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect10180ui_story then
				local var_87_25 = 0.5

				arg_84_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10180ui_story.fillRatio = var_87_25
			end

			local var_87_26 = 0
			local var_87_27 = 0.675

			if var_87_26 < arg_84_1.time_ and arg_84_1.time_ <= var_87_26 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_28 = arg_84_1:GetWordFromCfg(325141021)
				local var_87_29 = arg_84_1:FormatText(var_87_28.content)

				arg_84_1.text_.text = var_87_29

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_30 = 27
				local var_87_31 = utf8.len(var_87_29)
				local var_87_32 = var_87_30 <= 0 and var_87_27 or var_87_27 * (var_87_31 / var_87_30)

				if var_87_32 > 0 and var_87_27 < var_87_32 then
					arg_84_1.talkMaxDuration = var_87_32

					if var_87_32 + var_87_26 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_32 + var_87_26
					end
				end

				arg_84_1.text_.text = var_87_29
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_33 = math.max(var_87_27, arg_84_1.talkMaxDuration)

			if var_87_26 <= arg_84_1.time_ and arg_84_1.time_ < var_87_26 + var_87_33 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_26) / var_87_33

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_26 + var_87_33 and arg_84_1.time_ < var_87_26 + var_87_33 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play325141022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325141022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325141023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.95

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(325141022)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 38
				local var_91_5 = utf8.len(var_91_3)
				local var_91_6 = var_91_4 <= 0 and var_91_1 or var_91_1 * (var_91_5 / var_91_4)

				if var_91_6 > 0 and var_91_1 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_7 and arg_88_1.time_ < var_91_0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325141023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325141023
		arg_92_1.duration_ = 8.9

		local var_92_0 = {
			zh = 5.666,
			ja = 8.9
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
				arg_92_0:Play325141024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10180ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos10180ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10180ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["10180ui_story"]
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect10180ui_story == nil then
				arg_92_1.var_.characterEffect10180ui_story = var_95_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_13 = 0.200000002980232

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 and not isNil(var_95_11) then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13

				if arg_92_1.var_.characterEffect10180ui_story and not isNil(var_95_11) then
					arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect10180ui_story then
				arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_95_15 = 0

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action22_2")
			end

			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_17 = 0
			local var_95_18 = 0.425

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_19 = arg_92_1:FormatText(StoryNameCfg[1503].name)

				arg_92_1.leftNameTxt_.text = var_95_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_20 = arg_92_1:GetWordFromCfg(325141023)
				local var_95_21 = arg_92_1:FormatText(var_95_20.content)

				arg_92_1.text_.text = var_95_21

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_22 = 17
				local var_95_23 = utf8.len(var_95_21)
				local var_95_24 = var_95_22 <= 0 and var_95_18 or var_95_18 * (var_95_23 / var_95_22)

				if var_95_24 > 0 and var_95_18 < var_95_24 then
					arg_92_1.talkMaxDuration = var_95_24

					if var_95_24 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_24 + var_95_17
					end
				end

				arg_92_1.text_.text = var_95_21
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141023", "story_v_out_325141.awb") ~= 0 then
					local var_95_25 = manager.audio:GetVoiceLength("story_v_out_325141", "325141023", "story_v_out_325141.awb") / 1000

					if var_95_25 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_25 + var_95_17
					end

					if var_95_20.prefab_name ~= "" and arg_92_1.actors_[var_95_20.prefab_name] ~= nil then
						local var_95_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_20.prefab_name].transform, "story_v_out_325141", "325141023", "story_v_out_325141.awb")

						arg_92_1:RecordAudio("325141023", var_95_26)
						arg_92_1:RecordAudio("325141023", var_95_26)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325141", "325141023", "story_v_out_325141.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325141", "325141023", "story_v_out_325141.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_27 = math.max(var_95_18, arg_92_1.talkMaxDuration)

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_27 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_17) / var_95_27

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_17 + var_95_27 and arg_92_1.time_ < var_95_17 + var_95_27 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325141024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325141024
		arg_96_1.duration_ = 3.8

		local var_96_0 = {
			zh = 1.966,
			ja = 3.8
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
				arg_96_0:Play325141025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10180ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10180ui_story == nil then
				arg_96_1.var_.characterEffect10180ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10180ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10180ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10180ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10180ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.225

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[1455].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(325141024)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 9
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141024", "story_v_out_325141.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141024", "story_v_out_325141.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_325141", "325141024", "story_v_out_325141.awb")

						arg_96_1:RecordAudio("325141024", var_99_15)
						arg_96_1:RecordAudio("325141024", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325141", "325141024", "story_v_out_325141.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325141", "325141024", "story_v_out_325141.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325141025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325141025
		arg_100_1.duration_ = 12.7

		local var_100_0 = {
			zh = 5.333,
			ja = 12.7
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
				arg_100_0:Play325141026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10180ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10180ui_story == nil then
				arg_100_1.var_.characterEffect10180ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect10180ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10180ui_story then
				arg_100_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1059ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1059ui_story == nil then
				arg_100_1.var_.characterEffect1059ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.200000002980232

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect1059ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1059ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1059ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1059ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0
			local var_103_11 = 0.45

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_12 = arg_100_1:FormatText(StoryNameCfg[1503].name)

				arg_100_1.leftNameTxt_.text = var_103_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_13 = arg_100_1:GetWordFromCfg(325141025)
				local var_103_14 = arg_100_1:FormatText(var_103_13.content)

				arg_100_1.text_.text = var_103_14

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_15 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141025", "story_v_out_325141.awb") ~= 0 then
					local var_103_18 = manager.audio:GetVoiceLength("story_v_out_325141", "325141025", "story_v_out_325141.awb") / 1000

					if var_103_18 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_10
					end

					if var_103_13.prefab_name ~= "" and arg_100_1.actors_[var_103_13.prefab_name] ~= nil then
						local var_103_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_13.prefab_name].transform, "story_v_out_325141", "325141025", "story_v_out_325141.awb")

						arg_100_1:RecordAudio("325141025", var_103_19)
						arg_100_1:RecordAudio("325141025", var_103_19)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325141", "325141025", "story_v_out_325141.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325141", "325141025", "story_v_out_325141.awb")
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
	Play325141026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325141026
		arg_104_1.duration_ = 14.57

		local var_104_0 = {
			zh = 12.266,
			ja = 14.566
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
				arg_104_0:Play325141027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10180ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10180ui_story == nil then
				arg_104_1.var_.characterEffect10180ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect10180ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_104_1.var_.characterEffect10180ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10180ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_104_1.var_.characterEffect10180ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 0.95

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[1455].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_9 = arg_104_1:GetWordFromCfg(325141026)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141026", "story_v_out_325141.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141026", "story_v_out_325141.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_out_325141", "325141026", "story_v_out_325141.awb")

						arg_104_1:RecordAudio("325141026", var_107_15)
						arg_104_1:RecordAudio("325141026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325141", "325141026", "story_v_out_325141.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325141", "325141026", "story_v_out_325141.awb")
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
	Play325141027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325141027
		arg_108_1.duration_ = 2.27

		local var_108_0 = {
			zh = 2.166,
			ja = 2.266
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
				arg_108_0:Play325141028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10180ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10180ui_story == nil then
				arg_108_1.var_.characterEffect10180ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect10180ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10180ui_story then
				arg_108_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["1059ui_story"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1059ui_story == nil then
				arg_108_1.var_.characterEffect1059ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.200000002980232

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect1059ui_story and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1059ui_story.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1059ui_story then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1059ui_story.fillRatio = var_111_9
			end

			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action4_1")
			end

			local var_111_11 = 0

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_111_12 = 0
			local var_111_13 = 0.2

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_14 = arg_108_1:FormatText(StoryNameCfg[1503].name)

				arg_108_1.leftNameTxt_.text = var_111_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_15 = arg_108_1:GetWordFromCfg(325141027)
				local var_111_16 = arg_108_1:FormatText(var_111_15.content)

				arg_108_1.text_.text = var_111_16

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_17 = 8
				local var_111_18 = utf8.len(var_111_16)
				local var_111_19 = var_111_17 <= 0 and var_111_13 or var_111_13 * (var_111_18 / var_111_17)

				if var_111_19 > 0 and var_111_13 < var_111_19 then
					arg_108_1.talkMaxDuration = var_111_19

					if var_111_19 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_12
					end
				end

				arg_108_1.text_.text = var_111_16
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141027", "story_v_out_325141.awb") ~= 0 then
					local var_111_20 = manager.audio:GetVoiceLength("story_v_out_325141", "325141027", "story_v_out_325141.awb") / 1000

					if var_111_20 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_20 + var_111_12
					end

					if var_111_15.prefab_name ~= "" and arg_108_1.actors_[var_111_15.prefab_name] ~= nil then
						local var_111_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_15.prefab_name].transform, "story_v_out_325141", "325141027", "story_v_out_325141.awb")

						arg_108_1:RecordAudio("325141027", var_111_21)
						arg_108_1:RecordAudio("325141027", var_111_21)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_325141", "325141027", "story_v_out_325141.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_325141", "325141027", "story_v_out_325141.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_22 = math.max(var_111_13, arg_108_1.talkMaxDuration)

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_22 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_12) / var_111_22

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_12 + var_111_22 and arg_108_1.time_ < var_111_12 + var_111_22 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325141028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325141028
		arg_112_1.duration_ = 8.53

		local var_112_0 = {
			zh = 8.533,
			ja = 6.966
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
				arg_112_0:Play325141029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10180ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10180ui_story == nil then
				arg_112_1.var_.characterEffect10180ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect10180ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10180ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10180ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10180ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 0.4

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[1455].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_9 = arg_112_1:GetWordFromCfg(325141028)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 16
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141028", "story_v_out_325141.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141028", "story_v_out_325141.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_325141", "325141028", "story_v_out_325141.awb")

						arg_112_1:RecordAudio("325141028", var_115_15)
						arg_112_1:RecordAudio("325141028", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325141", "325141028", "story_v_out_325141.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325141", "325141028", "story_v_out_325141.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_16 and arg_112_1.time_ < var_115_6 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325141029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325141029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325141030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10180ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos10180ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10180ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_119_11 = arg_116_1.actors_["1059ui_story"].transform
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.var_.moveOldPos1059ui_story = var_119_11.localPosition
			end

			local var_119_13 = 0.001

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_13 then
				local var_119_14 = (arg_116_1.time_ - var_119_12) / var_119_13
				local var_119_15 = Vector3.New(0, 100, 0)

				var_119_11.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1059ui_story, var_119_15, var_119_14)

				local var_119_16 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_16.x, var_119_16.y, var_119_16.z)

				local var_119_17 = var_119_11.localEulerAngles

				var_119_17.z = 0
				var_119_17.x = 0
				var_119_11.localEulerAngles = var_119_17
			end

			if arg_116_1.time_ >= var_119_12 + var_119_13 and arg_116_1.time_ < var_119_12 + var_119_13 + arg_119_0 then
				var_119_11.localPosition = Vector3.New(0, 100, 0)

				local var_119_18 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_18.x, var_119_18.y, var_119_18.z)

				local var_119_19 = var_119_11.localEulerAngles

				var_119_19.z = 0
				var_119_19.x = 0
				var_119_11.localEulerAngles = var_119_19
			end

			local var_119_20 = arg_116_1.actors_["1059ui_story"]
			local var_119_21 = 0

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 and not isNil(var_119_20) and arg_116_1.var_.characterEffect1059ui_story == nil then
				arg_116_1.var_.characterEffect1059ui_story = var_119_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_22 = 0.200000002980232

			if var_119_21 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_22 and not isNil(var_119_20) then
				local var_119_23 = (arg_116_1.time_ - var_119_21) / var_119_22

				if arg_116_1.var_.characterEffect1059ui_story and not isNil(var_119_20) then
					local var_119_24 = Mathf.Lerp(0, 0.5, var_119_23)

					arg_116_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1059ui_story.fillRatio = var_119_24
				end
			end

			if arg_116_1.time_ >= var_119_21 + var_119_22 and arg_116_1.time_ < var_119_21 + var_119_22 + arg_119_0 and not isNil(var_119_20) and arg_116_1.var_.characterEffect1059ui_story then
				local var_119_25 = 0.5

				arg_116_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1059ui_story.fillRatio = var_119_25
			end

			local var_119_26 = 0.3
			local var_119_27 = 1

			if var_119_26 < arg_116_1.time_ and arg_116_1.time_ <= var_119_26 + arg_119_0 then
				local var_119_28 = "play"
				local var_119_29 = "effect"

				arg_116_1:AudioAction(var_119_28, var_119_29, "se_story_150", "se_story_150_stab", "")
			end

			local var_119_30 = 0
			local var_119_31 = 1.175

			if var_119_30 < arg_116_1.time_ and arg_116_1.time_ <= var_119_30 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_32 = arg_116_1:GetWordFromCfg(325141029)
				local var_119_33 = arg_116_1:FormatText(var_119_32.content)

				arg_116_1.text_.text = var_119_33

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_34 = 47
				local var_119_35 = utf8.len(var_119_33)
				local var_119_36 = var_119_34 <= 0 and var_119_31 or var_119_31 * (var_119_35 / var_119_34)

				if var_119_36 > 0 and var_119_31 < var_119_36 then
					arg_116_1.talkMaxDuration = var_119_36

					if var_119_36 + var_119_30 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_36 + var_119_30
					end
				end

				arg_116_1.text_.text = var_119_33
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_37 = math.max(var_119_31, arg_116_1.talkMaxDuration)

			if var_119_30 <= arg_116_1.time_ and arg_116_1.time_ < var_119_30 + var_119_37 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_30) / var_119_37

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_30 + var_119_37 and arg_116_1.time_ < var_119_30 + var_119_37 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play325141030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325141030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325141031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.1

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(325141030)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 44
				local var_123_5 = utf8.len(var_123_3)
				local var_123_6 = var_123_4 <= 0 and var_123_1 or var_123_1 * (var_123_5 / var_123_4)

				if var_123_6 > 0 and var_123_1 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_7 and arg_120_1.time_ < var_123_0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play325141031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325141031
		arg_124_1.duration_ = 10.93

		local var_124_0 = {
			zh = 4.6,
			ja = 10.933
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
				arg_124_0:Play325141032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10180ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos10180ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10180ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

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

			local var_127_11 = arg_124_1.actors_["10180ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect10180ui_story == nil then
				arg_124_1.var_.characterEffect10180ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.200000002980232

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect10180ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect10180ui_story then
				arg_124_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_127_15 = 0

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180actionlink/10180action449")
			end

			local var_127_16 = 0
			local var_127_17 = 0.45

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_18 = arg_124_1:FormatText(StoryNameCfg[1503].name)

				arg_124_1.leftNameTxt_.text = var_127_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_19 = arg_124_1:GetWordFromCfg(325141031)
				local var_127_20 = arg_124_1:FormatText(var_127_19.content)

				arg_124_1.text_.text = var_127_20

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_21 = 18
				local var_127_22 = utf8.len(var_127_20)
				local var_127_23 = var_127_21 <= 0 and var_127_17 or var_127_17 * (var_127_22 / var_127_21)

				if var_127_23 > 0 and var_127_17 < var_127_23 then
					arg_124_1.talkMaxDuration = var_127_23

					if var_127_23 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_16
					end
				end

				arg_124_1.text_.text = var_127_20
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141031", "story_v_out_325141.awb") ~= 0 then
					local var_127_24 = manager.audio:GetVoiceLength("story_v_out_325141", "325141031", "story_v_out_325141.awb") / 1000

					if var_127_24 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_24 + var_127_16
					end

					if var_127_19.prefab_name ~= "" and arg_124_1.actors_[var_127_19.prefab_name] ~= nil then
						local var_127_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_19.prefab_name].transform, "story_v_out_325141", "325141031", "story_v_out_325141.awb")

						arg_124_1:RecordAudio("325141031", var_127_25)
						arg_124_1:RecordAudio("325141031", var_127_25)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325141", "325141031", "story_v_out_325141.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325141", "325141031", "story_v_out_325141.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_26 = math.max(var_127_17, arg_124_1.talkMaxDuration)

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_26 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_16) / var_127_26

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_16 + var_127_26 and arg_124_1.time_ < var_127_16 + var_127_26 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325141032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325141032
		arg_128_1.duration_ = 6.8

		local var_128_0 = {
			zh = 6.8,
			ja = 6.1
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
				arg_128_0:Play325141033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10180ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10180ui_story == nil then
				arg_128_1.var_.characterEffect10180ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect10180ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10180ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10180ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10180ui_story.fillRatio = var_131_5
			end

			local var_131_6 = 0
			local var_131_7 = 0.275

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[1455].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_9 = arg_128_1:GetWordFromCfg(325141032)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 11
				local var_131_12 = utf8.len(var_131_10)
				local var_131_13 = var_131_11 <= 0 and var_131_7 or var_131_7 * (var_131_12 / var_131_11)

				if var_131_13 > 0 and var_131_7 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_10
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141032", "story_v_out_325141.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_325141", "325141032", "story_v_out_325141.awb") / 1000

					if var_131_14 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_6
					end

					if var_131_9.prefab_name ~= "" and arg_128_1.actors_[var_131_9.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_9.prefab_name].transform, "story_v_out_325141", "325141032", "story_v_out_325141.awb")

						arg_128_1:RecordAudio("325141032", var_131_15)
						arg_128_1:RecordAudio("325141032", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325141", "325141032", "story_v_out_325141.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325141", "325141032", "story_v_out_325141.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_16 and arg_128_1.time_ < var_131_6 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325141033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325141033
		arg_132_1.duration_ = 5.23

		local var_132_0 = {
			zh = 3.7,
			ja = 5.233
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
				arg_132_0:Play325141034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10180ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10180ui_story == nil then
				arg_132_1.var_.characterEffect10180ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect10180ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10180ui_story then
				arg_132_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["1059ui_story"]
			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1059ui_story == nil then
				arg_132_1.var_.characterEffect1059ui_story = var_135_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_6 = 0.200000002980232

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 and not isNil(var_135_4) then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6

				if arg_132_1.var_.characterEffect1059ui_story and not isNil(var_135_4) then
					local var_135_8 = Mathf.Lerp(0, 0.5, var_135_7)

					arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1059ui_story.fillRatio = var_135_8
				end
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1059ui_story then
				local var_135_9 = 0.5

				arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1059ui_story.fillRatio = var_135_9
			end

			local var_135_10 = 0
			local var_135_11 = 0.25

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_12 = arg_132_1:FormatText(StoryNameCfg[1503].name)

				arg_132_1.leftNameTxt_.text = var_135_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_13 = arg_132_1:GetWordFromCfg(325141033)
				local var_135_14 = arg_132_1:FormatText(var_135_13.content)

				arg_132_1.text_.text = var_135_14

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141033", "story_v_out_325141.awb") ~= 0 then
					local var_135_18 = manager.audio:GetVoiceLength("story_v_out_325141", "325141033", "story_v_out_325141.awb") / 1000

					if var_135_18 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_10
					end

					if var_135_13.prefab_name ~= "" and arg_132_1.actors_[var_135_13.prefab_name] ~= nil then
						local var_135_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_13.prefab_name].transform, "story_v_out_325141", "325141033", "story_v_out_325141.awb")

						arg_132_1:RecordAudio("325141033", var_135_19)
						arg_132_1:RecordAudio("325141033", var_135_19)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325141", "325141033", "story_v_out_325141.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325141", "325141033", "story_v_out_325141.awb")
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
	Play325141034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325141034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325141035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10180ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos10180ui_story = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10180ui_story, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = arg_136_1.actors_["1059ui_story"].transform
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_11.localPosition
			end

			local var_139_13 = 0.001

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_13 then
				local var_139_14 = (arg_136_1.time_ - var_139_12) / var_139_13
				local var_139_15 = Vector3.New(0, 100, 0)

				var_139_11.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, var_139_15, var_139_14)

				local var_139_16 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_16.x, var_139_16.y, var_139_16.z)

				local var_139_17 = var_139_11.localEulerAngles

				var_139_17.z = 0
				var_139_17.x = 0
				var_139_11.localEulerAngles = var_139_17
			end

			if arg_136_1.time_ >= var_139_12 + var_139_13 and arg_136_1.time_ < var_139_12 + var_139_13 + arg_139_0 then
				var_139_11.localPosition = Vector3.New(0, 100, 0)

				local var_139_18 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_18.x, var_139_18.y, var_139_18.z)

				local var_139_19 = var_139_11.localEulerAngles

				var_139_19.z = 0
				var_139_19.x = 0
				var_139_11.localEulerAngles = var_139_19
			end

			local var_139_20 = arg_136_1.actors_["10180ui_story"]
			local var_139_21 = 0

			if var_139_21 < arg_136_1.time_ and arg_136_1.time_ <= var_139_21 + arg_139_0 and not isNil(var_139_20) and arg_136_1.var_.characterEffect10180ui_story == nil then
				arg_136_1.var_.characterEffect10180ui_story = var_139_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_22 = 0.200000002980232

			if var_139_21 <= arg_136_1.time_ and arg_136_1.time_ < var_139_21 + var_139_22 and not isNil(var_139_20) then
				local var_139_23 = (arg_136_1.time_ - var_139_21) / var_139_22

				if arg_136_1.var_.characterEffect10180ui_story and not isNil(var_139_20) then
					local var_139_24 = Mathf.Lerp(0, 0.5, var_139_23)

					arg_136_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10180ui_story.fillRatio = var_139_24
				end
			end

			if arg_136_1.time_ >= var_139_21 + var_139_22 and arg_136_1.time_ < var_139_21 + var_139_22 + arg_139_0 and not isNil(var_139_20) and arg_136_1.var_.characterEffect10180ui_story then
				local var_139_25 = 0.5

				arg_136_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10180ui_story.fillRatio = var_139_25
			end

			local var_139_26 = 0.4
			local var_139_27 = 1

			if var_139_26 < arg_136_1.time_ and arg_136_1.time_ <= var_139_26 + arg_139_0 then
				local var_139_28 = "play"
				local var_139_29 = "effect"

				arg_136_1:AudioAction(var_139_28, var_139_29, "se_story_151", "se_story_151_stab", "")
			end

			local var_139_30 = 0
			local var_139_31 = 1.475

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_32 = arg_136_1:GetWordFromCfg(325141034)
				local var_139_33 = arg_136_1:FormatText(var_139_32.content)

				arg_136_1.text_.text = var_139_33

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_34 = 59
				local var_139_35 = utf8.len(var_139_33)
				local var_139_36 = var_139_34 <= 0 and var_139_31 or var_139_31 * (var_139_35 / var_139_34)

				if var_139_36 > 0 and var_139_31 < var_139_36 then
					arg_136_1.talkMaxDuration = var_139_36

					if var_139_36 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_36 + var_139_30
					end
				end

				arg_136_1.text_.text = var_139_33
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_37 = math.max(var_139_31, arg_136_1.talkMaxDuration)

			if var_139_30 <= arg_136_1.time_ and arg_136_1.time_ < var_139_30 + var_139_37 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_30) / var_139_37

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_30 + var_139_37 and arg_136_1.time_ < var_139_30 + var_139_37 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	Play325141035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325141035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325141036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1.15

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_2 = arg_140_1:GetWordFromCfg(325141035)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 46
				local var_143_5 = utf8.len(var_143_3)
				local var_143_6 = var_143_4 <= 0 and var_143_1 or var_143_1 * (var_143_5 / var_143_4)

				if var_143_6 > 0 and var_143_1 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_7 and arg_140_1.time_ < var_143_0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325141036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325141036
		arg_144_1.duration_ = 6.5

		local var_144_0 = {
			zh = 5.3,
			ja = 6.5
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
				arg_144_0:Play325141037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10180ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos10180ui_story = var_147_0.localPosition

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end
			end

			local var_147_3 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_3 then
				local var_147_4 = (arg_144_1.time_ - var_147_1) / var_147_3
				local var_147_5 = Vector3.New(-0.03, -1.09, -6.14)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10180ui_story, var_147_5, var_147_4)

				local var_147_6 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_6.x, var_147_6.y, var_147_6.z)

				local var_147_7 = var_147_0.localEulerAngles

				var_147_7.z = 0
				var_147_7.x = 0
				var_147_0.localEulerAngles = var_147_7
			end

			if arg_144_1.time_ >= var_147_1 + var_147_3 and arg_144_1.time_ < var_147_1 + var_147_3 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(-0.03, -1.09, -6.14)

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

			local var_147_11 = arg_144_1.actors_["10180ui_story"]
			local var_147_12 = 0

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect10180ui_story == nil then
				arg_144_1.var_.characterEffect10180ui_story = var_147_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_13 = 0.200000002980232

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_13 and not isNil(var_147_11) then
				local var_147_14 = (arg_144_1.time_ - var_147_12) / var_147_13

				if arg_144_1.var_.characterEffect10180ui_story and not isNil(var_147_11) then
					arg_144_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_12 + var_147_13 and arg_144_1.time_ < var_147_12 + var_147_13 + arg_147_0 and not isNil(var_147_11) and arg_144_1.var_.characterEffect10180ui_story then
				arg_144_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_147_15 = 0

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action9_2")
			end

			local var_147_16 = 0
			local var_147_17 = 0.4

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_18 = arg_144_1:FormatText(StoryNameCfg[1503].name)

				arg_144_1.leftNameTxt_.text = var_147_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_19 = arg_144_1:GetWordFromCfg(325141036)
				local var_147_20 = arg_144_1:FormatText(var_147_19.content)

				arg_144_1.text_.text = var_147_20

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_21 = 16
				local var_147_22 = utf8.len(var_147_20)
				local var_147_23 = var_147_21 <= 0 and var_147_17 or var_147_17 * (var_147_22 / var_147_21)

				if var_147_23 > 0 and var_147_17 < var_147_23 then
					arg_144_1.talkMaxDuration = var_147_23

					if var_147_23 + var_147_16 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_16
					end
				end

				arg_144_1.text_.text = var_147_20
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325141", "325141036", "story_v_out_325141.awb") ~= 0 then
					local var_147_24 = manager.audio:GetVoiceLength("story_v_out_325141", "325141036", "story_v_out_325141.awb") / 1000

					if var_147_24 + var_147_16 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_24 + var_147_16
					end

					if var_147_19.prefab_name ~= "" and arg_144_1.actors_[var_147_19.prefab_name] ~= nil then
						local var_147_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_19.prefab_name].transform, "story_v_out_325141", "325141036", "story_v_out_325141.awb")

						arg_144_1:RecordAudio("325141036", var_147_25)
						arg_144_1:RecordAudio("325141036", var_147_25)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325141", "325141036", "story_v_out_325141.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325141", "325141036", "story_v_out_325141.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_26 = math.max(var_147_17, arg_144_1.talkMaxDuration)

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_26 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_16) / var_147_26

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_16 + var_147_26 and arg_144_1.time_ < var_147_16 + var_147_26 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325141037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325141037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325141038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10180ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos10180ui_story = var_151_0.localPosition

				local var_151_2 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(false)
				end
			end

			local var_151_3 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_3 then
				local var_151_4 = (arg_148_1.time_ - var_151_1) / var_151_3
				local var_151_5 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10180ui_story, var_151_5, var_151_4)

				local var_151_6 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_6.x, var_151_6.y, var_151_6.z)

				local var_151_7 = var_151_0.localEulerAngles

				var_151_7.z = 0
				var_151_7.x = 0
				var_151_0.localEulerAngles = var_151_7
			end

			if arg_148_1.time_ >= var_151_1 + var_151_3 and arg_148_1.time_ < var_151_1 + var_151_3 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_8 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_8.x, var_151_8.y, var_151_8.z)

				local var_151_9 = var_151_0.localEulerAngles

				var_151_9.z = 0
				var_151_9.x = 0
				var_151_0.localEulerAngles = var_151_9

				local var_151_10 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_10 then
					var_151_10:EnableDynamicBone(true)
				end
			end

			local var_151_11 = arg_148_1.actors_["10180ui_story"]
			local var_151_12 = 0

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 and not isNil(var_151_11) and arg_148_1.var_.characterEffect10180ui_story == nil then
				arg_148_1.var_.characterEffect10180ui_story = var_151_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_13 = 0.200000002980232

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_13 and not isNil(var_151_11) then
				local var_151_14 = (arg_148_1.time_ - var_151_12) / var_151_13

				if arg_148_1.var_.characterEffect10180ui_story and not isNil(var_151_11) then
					local var_151_15 = Mathf.Lerp(0, 0.5, var_151_14)

					arg_148_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10180ui_story.fillRatio = var_151_15
				end
			end

			if arg_148_1.time_ >= var_151_12 + var_151_13 and arg_148_1.time_ < var_151_12 + var_151_13 + arg_151_0 and not isNil(var_151_11) and arg_148_1.var_.characterEffect10180ui_story then
				local var_151_16 = 0.5

				arg_148_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10180ui_story.fillRatio = var_151_16
			end

			local var_151_17 = 0
			local var_151_18 = 1.175

			if var_151_17 < arg_148_1.time_ and arg_148_1.time_ <= var_151_17 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_19 = arg_148_1:GetWordFromCfg(325141037)
				local var_151_20 = arg_148_1:FormatText(var_151_19.content)

				arg_148_1.text_.text = var_151_20

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_21 = 47
				local var_151_22 = utf8.len(var_151_20)
				local var_151_23 = var_151_21 <= 0 and var_151_18 or var_151_18 * (var_151_22 / var_151_21)

				if var_151_23 > 0 and var_151_18 < var_151_23 then
					arg_148_1.talkMaxDuration = var_151_23

					if var_151_23 + var_151_17 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_17
					end
				end

				arg_148_1.text_.text = var_151_20
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_24 = math.max(var_151_18, arg_148_1.talkMaxDuration)

			if var_151_17 <= arg_148_1.time_ and arg_148_1.time_ < var_151_17 + var_151_24 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_17) / var_151_24

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_17 + var_151_24 and arg_148_1.time_ < var_151_17 + var_151_24 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325141038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325141038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325141039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.675

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_2 = arg_152_1:GetWordFromCfg(325141038)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 27
				local var_155_5 = utf8.len(var_155_3)
				local var_155_6 = var_155_4 <= 0 and var_155_1 or var_155_1 * (var_155_5 / var_155_4)

				if var_155_6 > 0 and var_155_1 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_7 and arg_152_1.time_ < var_155_0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325141039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325141039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
			arg_156_1.auto_ = false
		end

		function arg_156_1.playNext_(arg_158_0)
			arg_156_1.onStoryFinished_()
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				local var_159_2 = "play"
				local var_159_3 = "effect"

				arg_156_1:AudioAction(var_159_2, var_159_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_159_4 = 0
			local var_159_5 = 0.75

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(325141039)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_8 = 30
				local var_159_9 = utf8.len(var_159_7)
				local var_159_10 = var_159_8 <= 0 and var_159_5 or var_159_5 * (var_159_9 / var_159_8)

				if var_159_10 > 0 and var_159_5 < var_159_10 then
					arg_156_1.talkMaxDuration = var_159_10

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_11 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_11 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_11

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_11 and arg_156_1.time_ < var_159_4 + var_159_11 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J29g"
	},
	voices = {
		"story_v_out_325141.awb"
	}
}
