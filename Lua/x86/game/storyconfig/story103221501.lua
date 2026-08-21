return {
	Play322151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322151001
		arg_1_1.duration_ = 6.73

		local var_1_0 = {
			zh = 5.733,
			ja = 6.733
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
				arg_1_0:Play322151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L14f"

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
				local var_4_5 = arg_1_1.bgs_.L14f

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
					if iter_4_0 ~= "L14f" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_34 = 2
			local var_4_35 = 0.325

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[672].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(322151001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151001", "story_v_out_322151.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_322151", "322151001", "story_v_out_322151.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_322151", "322151001", "story_v_out_322151.awb")

						arg_1_1:RecordAudio("322151001", var_4_44)
						arg_1_1:RecordAudio("322151001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322151", "322151001", "story_v_out_322151.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322151", "322151001", "story_v_out_322151.awb")
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
	Play322151002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 322151002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play322151003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.175

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(322151002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 47
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play322151003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 322151003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play322151004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.275

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

				local var_15_3 = arg_12_1:GetWordFromCfg(322151003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 11
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
	Play322151004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 322151004
		arg_16_1.duration_ = 5.13

		local var_16_0 = {
			zh = 2.966,
			ja = 5.133
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
				arg_16_0:Play322151005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "10104ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["10104ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos10104ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0.02, -1.12, -5.99)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10104ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["10104ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect10104ui_story == nil then
				arg_16_1.var_.characterEffect10104ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect10104ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect10104ui_story then
				arg_16_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_20 = 0
			local var_19_21 = 0.325

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[1030].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(322151004)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151004", "story_v_out_322151.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_322151", "322151004", "story_v_out_322151.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_out_322151", "322151004", "story_v_out_322151.awb")

						arg_16_1:RecordAudio("322151004", var_19_29)
						arg_16_1:RecordAudio("322151004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_322151", "322151004", "story_v_out_322151.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_322151", "322151004", "story_v_out_322151.awb")
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
				actorName = "10104ui_story",
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
	Play322151005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 322151005
		arg_20_1.duration_ = 7.03

		local var_20_0 = {
			zh = 6.033,
			ja = 7.033
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
				arg_20_0:Play322151006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_23_1 = 0
			local var_23_2 = 0.7

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_3 = arg_20_1:FormatText(StoryNameCfg[1030].name)

				arg_20_1.leftNameTxt_.text = var_23_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(322151005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 28
				local var_23_7 = utf8.len(var_23_5)
				local var_23_8 = var_23_6 <= 0 and var_23_2 or var_23_2 * (var_23_7 / var_23_6)

				if var_23_8 > 0 and var_23_2 < var_23_8 then
					arg_20_1.talkMaxDuration = var_23_8

					if var_23_8 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151005", "story_v_out_322151.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_out_322151", "322151005", "story_v_out_322151.awb") / 1000

					if var_23_9 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_1
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_322151", "322151005", "story_v_out_322151.awb")

						arg_20_1:RecordAudio("322151005", var_23_10)
						arg_20_1:RecordAudio("322151005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_322151", "322151005", "story_v_out_322151.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_322151", "322151005", "story_v_out_322151.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_11 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_11 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_11

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_11 and arg_20_1.time_ < var_23_1 + var_23_11 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play322151006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 322151006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play322151007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10104ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos10104ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10104ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["10104ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect10104ui_story == nil then
				arg_24_1.var_.characterEffect10104ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.200000002980232

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect10104ui_story and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10104ui_story.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect10104ui_story then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10104ui_story.fillRatio = var_27_14
			end

			local var_27_15 = 0
			local var_27_16 = 1.5

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_17 = arg_24_1:GetWordFromCfg(322151006)
				local var_27_18 = arg_24_1:FormatText(var_27_17.content)

				arg_24_1.text_.text = var_27_18

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 60
				local var_27_20 = utf8.len(var_27_18)
				local var_27_21 = var_27_19 <= 0 and var_27_16 or var_27_16 * (var_27_20 / var_27_19)

				if var_27_21 > 0 and var_27_16 < var_27_21 then
					arg_24_1.talkMaxDuration = var_27_21

					if var_27_21 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_21 + var_27_15
					end
				end

				arg_24_1.text_.text = var_27_18
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_16, arg_24_1.talkMaxDuration)

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_15) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_15 + var_27_22 and arg_24_1.time_ < var_27_15 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322151007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 322151007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play322151008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.85

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(322151007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 34
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play322151008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 322151008
		arg_32_1.duration_ = 3.5

		local var_32_0 = {
			zh = 2.1,
			ja = 3.5
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
				arg_32_0:Play322151009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10104ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos10104ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0.02, -1.12, -5.99)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10104ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["10104ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect10104ui_story == nil then
				arg_32_1.var_.characterEffect10104ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect10104ui_story and not isNil(var_35_9) then
					arg_32_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect10104ui_story then
				arg_32_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_35_13 = 0

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_15 = 0
			local var_35_16 = 0.275

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[1030].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(322151008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 11
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151008", "story_v_out_322151.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_out_322151", "322151008", "story_v_out_322151.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_322151", "322151008", "story_v_out_322151.awb")

						arg_32_1:RecordAudio("322151008", var_35_24)
						arg_32_1:RecordAudio("322151008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_322151", "322151008", "story_v_out_322151.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_322151", "322151008", "story_v_out_322151.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_25 and arg_32_1.time_ < var_35_15 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322151009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 322151009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play322151010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10104ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10104ui_story == nil then
				arg_36_1.var_.characterEffect10104ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10104ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10104ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10104ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10104ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.425

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(322151009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 17
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play322151010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 322151010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play322151011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.875

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

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

				local var_43_3 = arg_40_1:GetWordFromCfg(322151010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 35
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play322151011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 322151011
		arg_44_1.duration_ = 7.23

		local var_44_0 = {
			zh = 6.6,
			ja = 7.233
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
				arg_44_0:Play322151012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10104ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos10104ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0.02, -1.12, -5.99)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10104ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["10104ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect10104ui_story == nil then
				arg_44_1.var_.characterEffect10104ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect10104ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect10104ui_story then
				arg_44_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_47_15 = 0
			local var_47_16 = 0.575

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[1030].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(322151011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 23
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151011", "story_v_out_322151.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_322151", "322151011", "story_v_out_322151.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_322151", "322151011", "story_v_out_322151.awb")

						arg_44_1:RecordAudio("322151011", var_47_24)
						arg_44_1:RecordAudio("322151011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_322151", "322151011", "story_v_out_322151.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_322151", "322151011", "story_v_out_322151.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play322151012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 322151012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play322151013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10104ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10104ui_story == nil then
				arg_48_1.var_.characterEffect10104ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10104ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10104ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10104ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10104ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.6

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

				local var_51_9 = arg_48_1:GetWordFromCfg(322151012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 24
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
	Play322151013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 322151013
		arg_52_1.duration_ = 5.93

		local var_52_0 = {
			zh = 5.932999999999,
			ja = 5.799999999999
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
				arg_52_0:Play322151014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "L10g"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 2.00000000298023

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.L10g

				var_55_5.transform.localPosition = var_55_4
				var_55_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_6 = var_55_5:GetComponent("SpriteRenderer")

				if var_55_6 and var_55_6.sprite then
					local var_55_7 = (var_55_5.transform.localPosition - var_55_3).z
					local var_55_8 = manager.ui.mainCameraCom_
					local var_55_9 = 2 * var_55_7 * Mathf.Tan(var_55_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_10 = var_55_9 * var_55_8.aspect
					local var_55_11 = var_55_6.sprite.bounds.size.x
					local var_55_12 = var_55_6.sprite.bounds.size.y
					local var_55_13 = var_55_10 / var_55_11
					local var_55_14 = var_55_9 / var_55_12
					local var_55_15 = var_55_14 < var_55_13 and var_55_13 or var_55_14

					var_55_5.transform.localScale = Vector3.New(var_55_15, var_55_15, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "L10g" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = 3.999999999999

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_17 = 0.3

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_19 = 2

			if var_55_18 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_19 then
				local var_55_20 = (arg_52_1.time_ - var_55_18) / var_55_19
				local var_55_21 = Color.New(0, 0, 0)

				var_55_21.a = Mathf.Lerp(0, 1, var_55_20)
				arg_52_1.mask_.color = var_55_21
			end

			if arg_52_1.time_ >= var_55_18 + var_55_19 and arg_52_1.time_ < var_55_18 + var_55_19 + arg_55_0 then
				local var_55_22 = Color.New(0, 0, 0)

				var_55_22.a = 1
				arg_52_1.mask_.color = var_55_22
			end

			local var_55_23 = 2

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_24 = 2

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24
				local var_55_26 = Color.New(0, 0, 0)

				var_55_26.a = Mathf.Lerp(1, 0, var_55_25)
				arg_52_1.mask_.color = var_55_26
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 then
				local var_55_27 = Color.New(0, 0, 0)
				local var_55_28 = 0

				arg_52_1.mask_.enabled = false
				var_55_27.a = var_55_28
				arg_52_1.mask_.color = var_55_27
			end

			local var_55_29 = arg_52_1.actors_["10104ui_story"].transform
			local var_55_30 = 1.96599999815226

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1.var_.moveOldPos10104ui_story = var_55_29.localPosition
			end

			local var_55_31 = 0.001

			if var_55_30 <= arg_52_1.time_ and arg_52_1.time_ < var_55_30 + var_55_31 then
				local var_55_32 = (arg_52_1.time_ - var_55_30) / var_55_31
				local var_55_33 = Vector3.New(0, 100, 0)

				var_55_29.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10104ui_story, var_55_33, var_55_32)

				local var_55_34 = manager.ui.mainCamera.transform.position - var_55_29.position

				var_55_29.forward = Vector3.New(var_55_34.x, var_55_34.y, var_55_34.z)

				local var_55_35 = var_55_29.localEulerAngles

				var_55_35.z = 0
				var_55_35.x = 0
				var_55_29.localEulerAngles = var_55_35
			end

			if arg_52_1.time_ >= var_55_30 + var_55_31 and arg_52_1.time_ < var_55_30 + var_55_31 + arg_55_0 then
				var_55_29.localPosition = Vector3.New(0, 100, 0)

				local var_55_36 = manager.ui.mainCamera.transform.position - var_55_29.position

				var_55_29.forward = Vector3.New(var_55_36.x, var_55_36.y, var_55_36.z)

				local var_55_37 = var_55_29.localEulerAngles

				var_55_37.z = 0
				var_55_37.x = 0
				var_55_29.localEulerAngles = var_55_37
			end

			local var_55_38 = "1284ui_story"

			if arg_52_1.actors_[var_55_38] == nil then
				local var_55_39 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_55_39) then
					local var_55_40 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_52_1.stage_.transform)

					var_55_40.name = var_55_38
					var_55_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_38] = var_55_40

					local var_55_41 = var_55_40:GetComponentInChildren(typeof(CharacterEffect))

					var_55_41.enabled = true

					local var_55_42 = GameObjectTools.GetOrAddComponent(var_55_40, typeof(DynamicBoneHelper))

					if var_55_42 then
						var_55_42:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_41.transform, false)

					arg_52_1.var_[var_55_38 .. "Animator"] = var_55_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_38 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_38 .. "LipSync"] = var_55_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_43 = arg_52_1.actors_["1284ui_story"].transform
			local var_55_44 = 3.8

			if var_55_44 < arg_52_1.time_ and arg_52_1.time_ <= var_55_44 + arg_55_0 then
				arg_52_1.var_.moveOldPos1284ui_story = var_55_43.localPosition

				local var_55_45 = "1284ui_story"

				arg_52_1:ShowWeapon(arg_52_1.var_[var_55_45 .. "Animator"].transform, false)
			end

			local var_55_46 = 0.001

			if var_55_44 <= arg_52_1.time_ and arg_52_1.time_ < var_55_44 + var_55_46 then
				local var_55_47 = (arg_52_1.time_ - var_55_44) / var_55_46
				local var_55_48 = Vector3.New(-0.7, -0.985, -6.22)

				var_55_43.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1284ui_story, var_55_48, var_55_47)

				local var_55_49 = manager.ui.mainCamera.transform.position - var_55_43.position

				var_55_43.forward = Vector3.New(var_55_49.x, var_55_49.y, var_55_49.z)

				local var_55_50 = var_55_43.localEulerAngles

				var_55_50.z = 0
				var_55_50.x = 0
				var_55_43.localEulerAngles = var_55_50
			end

			if arg_52_1.time_ >= var_55_44 + var_55_46 and arg_52_1.time_ < var_55_44 + var_55_46 + arg_55_0 then
				var_55_43.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_55_51 = manager.ui.mainCamera.transform.position - var_55_43.position

				var_55_43.forward = Vector3.New(var_55_51.x, var_55_51.y, var_55_51.z)

				local var_55_52 = var_55_43.localEulerAngles

				var_55_52.z = 0
				var_55_52.x = 0
				var_55_43.localEulerAngles = var_55_52
			end

			local var_55_53 = arg_52_1.actors_["1284ui_story"]
			local var_55_54 = 3.8

			if var_55_54 < arg_52_1.time_ and arg_52_1.time_ <= var_55_54 + arg_55_0 and not isNil(var_55_53) and arg_52_1.var_.characterEffect1284ui_story == nil then
				arg_52_1.var_.characterEffect1284ui_story = var_55_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_55 = 0.200000002980232

			if var_55_54 <= arg_52_1.time_ and arg_52_1.time_ < var_55_54 + var_55_55 and not isNil(var_55_53) then
				local var_55_56 = (arg_52_1.time_ - var_55_54) / var_55_55

				if arg_52_1.var_.characterEffect1284ui_story and not isNil(var_55_53) then
					arg_52_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_54 + var_55_55 and arg_52_1.time_ < var_55_54 + var_55_55 + arg_55_0 and not isNil(var_55_53) and arg_52_1.var_.characterEffect1284ui_story then
				arg_52_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_55_57 = 3.8

			if var_55_57 < arg_52_1.time_ and arg_52_1.time_ <= var_55_57 + arg_55_0 then
				arg_52_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_55_58 = 3.8

			if var_55_58 < arg_52_1.time_ and arg_52_1.time_ <= var_55_58 + arg_55_0 then
				arg_52_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_55_59 = 0
			local var_55_60 = 0.3

			if var_55_59 < arg_52_1.time_ and arg_52_1.time_ <= var_55_59 + arg_55_0 then
				local var_55_61 = "play"
				local var_55_62 = "music"

				arg_52_1:AudioAction(var_55_61, var_55_62, "ui_battle", "ui_battle_stopbgm", "")

				local var_55_63 = ""
				local var_55_64 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_55_64 ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_64 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_64

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_64
						arg_52_1.bgmTxt2_.text = var_55_64
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_55_65 = 0.965999998152256
			local var_55_66 = 1

			if var_55_65 < arg_52_1.time_ and arg_52_1.time_ <= var_55_65 + arg_55_0 then
				local var_55_67 = "play"
				local var_55_68 = "music"

				arg_52_1:AudioAction(var_55_67, var_55_68, "bgm_story_sad_1", "bgm_story_sad_1", "bgm_story_sad_1.awb")

				local var_55_69 = ""
				local var_55_70 = manager.audio:GetAudioName("bgm_story_sad_1", "bgm_story_sad_1")

				if var_55_70 ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_70 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_70

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_70
						arg_52_1.bgmTxt2_.text = var_55_70
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_71 = 3.999999999999
			local var_55_72 = 0.175

			if var_55_71 < arg_52_1.time_ and arg_52_1.time_ <= var_55_71 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_73 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_73:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_52_1.dialogCg_.alpha = arg_58_0
				end))
				var_55_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_74 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_75 = arg_52_1:GetWordFromCfg(322151013)
				local var_55_76 = arg_52_1:FormatText(var_55_75.content)

				arg_52_1.text_.text = var_55_76

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_77 = 7
				local var_55_78 = utf8.len(var_55_76)
				local var_55_79 = var_55_77 <= 0 and var_55_72 or var_55_72 * (var_55_78 / var_55_77)

				if var_55_79 > 0 and var_55_72 < var_55_79 then
					arg_52_1.talkMaxDuration = var_55_79
					var_55_71 = var_55_71 + 0.3

					if var_55_79 + var_55_71 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_79 + var_55_71
					end
				end

				arg_52_1.text_.text = var_55_76
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151013", "story_v_out_322151.awb") ~= 0 then
					local var_55_80 = manager.audio:GetVoiceLength("story_v_out_322151", "322151013", "story_v_out_322151.awb") / 1000

					if var_55_80 + var_55_71 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_80 + var_55_71
					end

					if var_55_75.prefab_name ~= "" and arg_52_1.actors_[var_55_75.prefab_name] ~= nil then
						local var_55_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_75.prefab_name].transform, "story_v_out_322151", "322151013", "story_v_out_322151.awb")

						arg_52_1:RecordAudio("322151013", var_55_81)
						arg_52_1:RecordAudio("322151013", var_55_81)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_322151", "322151013", "story_v_out_322151.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_322151", "322151013", "story_v_out_322151.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_82 = var_55_71 + 0.3
			local var_55_83 = math.max(var_55_72, arg_52_1.talkMaxDuration)

			if var_55_82 <= arg_52_1.time_ and arg_52_1.time_ < var_55_82 + var_55_83 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_82) / var_55_83

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_82 + var_55_83 and arg_52_1.time_ < var_55_82 + var_55_83 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play322151014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 322151014
		arg_60_1.duration_ = 3.3

		local var_60_0 = {
			zh = 1.999999999999,
			ja = 3.3
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
				arg_60_0:Play322151015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "1211ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_60_1.stage_.transform)

					var_63_2.name = var_63_0
					var_63_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_0] = var_63_2

					local var_63_3 = var_63_2:GetComponentInChildren(typeof(CharacterEffect))

					var_63_3.enabled = true

					local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_2, typeof(DynamicBoneHelper))

					if var_63_4 then
						var_63_4:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_3.transform, false)

					arg_60_1.var_[var_63_0 .. "Animator"] = var_63_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_0 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_0 .. "LipSync"] = var_63_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_5 = arg_60_1.actors_["1211ui_story"].transform
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.var_.moveOldPos1211ui_story = var_63_5.localPosition

				local var_63_7 = "1211ui_story"

				arg_60_1:ShowWeapon(arg_60_1.var_[var_63_7 .. "Animator"].transform, false)
			end

			local var_63_8 = 0.001

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_8 then
				local var_63_9 = (arg_60_1.time_ - var_63_6) / var_63_8
				local var_63_10 = Vector3.New(0.7, -0.67, -6.07)

				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1211ui_story, var_63_10, var_63_9)

				local var_63_11 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_11.x, var_63_11.y, var_63_11.z)

				local var_63_12 = var_63_5.localEulerAngles

				var_63_12.z = 0
				var_63_12.x = 0
				var_63_5.localEulerAngles = var_63_12
			end

			if arg_60_1.time_ >= var_63_6 + var_63_8 and arg_60_1.time_ < var_63_6 + var_63_8 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_63_13 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_13.x, var_63_13.y, var_63_13.z)

				local var_63_14 = var_63_5.localEulerAngles

				var_63_14.z = 0
				var_63_14.x = 0
				var_63_5.localEulerAngles = var_63_14
			end

			local var_63_15 = arg_60_1.actors_["1211ui_story"]
			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 and not isNil(var_63_15) and arg_60_1.var_.characterEffect1211ui_story == nil then
				arg_60_1.var_.characterEffect1211ui_story = var_63_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_17 = 0.200000002980232

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 and not isNil(var_63_15) then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17

				if arg_60_1.var_.characterEffect1211ui_story and not isNil(var_63_15) then
					arg_60_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 and not isNil(var_63_15) and arg_60_1.var_.characterEffect1211ui_story then
				arg_60_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_63_19 = arg_60_1.actors_["1284ui_story"]
			local var_63_20 = 0

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 and not isNil(var_63_19) and arg_60_1.var_.characterEffect1284ui_story == nil then
				arg_60_1.var_.characterEffect1284ui_story = var_63_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_21 = 0.200000002980232

			if var_63_20 <= arg_60_1.time_ and arg_60_1.time_ < var_63_20 + var_63_21 and not isNil(var_63_19) then
				local var_63_22 = (arg_60_1.time_ - var_63_20) / var_63_21

				if arg_60_1.var_.characterEffect1284ui_story and not isNil(var_63_19) then
					local var_63_23 = Mathf.Lerp(0, 0.5, var_63_22)

					arg_60_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1284ui_story.fillRatio = var_63_23
				end
			end

			if arg_60_1.time_ >= var_63_20 + var_63_21 and arg_60_1.time_ < var_63_20 + var_63_21 + arg_63_0 and not isNil(var_63_19) and arg_60_1.var_.characterEffect1284ui_story then
				local var_63_24 = 0.5

				arg_60_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1284ui_story.fillRatio = var_63_24
			end

			local var_63_25 = 0

			if var_63_25 < arg_60_1.time_ and arg_60_1.time_ <= var_63_25 + arg_63_0 then
				arg_60_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_63_26 = 0

			if var_63_26 < arg_60_1.time_ and arg_60_1.time_ <= var_63_26 + arg_63_0 then
				arg_60_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_63_27 = 0
			local var_63_28 = 0.175

			if var_63_27 < arg_60_1.time_ and arg_60_1.time_ <= var_63_27 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_29 = arg_60_1:FormatText(StoryNameCfg[37].name)

				arg_60_1.leftNameTxt_.text = var_63_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_30 = arg_60_1:GetWordFromCfg(322151014)
				local var_63_31 = arg_60_1:FormatText(var_63_30.content)

				arg_60_1.text_.text = var_63_31

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_32 = 7
				local var_63_33 = utf8.len(var_63_31)
				local var_63_34 = var_63_32 <= 0 and var_63_28 or var_63_28 * (var_63_33 / var_63_32)

				if var_63_34 > 0 and var_63_28 < var_63_34 then
					arg_60_1.talkMaxDuration = var_63_34

					if var_63_34 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_34 + var_63_27
					end
				end

				arg_60_1.text_.text = var_63_31
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151014", "story_v_out_322151.awb") ~= 0 then
					local var_63_35 = manager.audio:GetVoiceLength("story_v_out_322151", "322151014", "story_v_out_322151.awb") / 1000

					if var_63_35 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_35 + var_63_27
					end

					if var_63_30.prefab_name ~= "" and arg_60_1.actors_[var_63_30.prefab_name] ~= nil then
						local var_63_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_30.prefab_name].transform, "story_v_out_322151", "322151014", "story_v_out_322151.awb")

						arg_60_1:RecordAudio("322151014", var_63_36)
						arg_60_1:RecordAudio("322151014", var_63_36)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_322151", "322151014", "story_v_out_322151.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_322151", "322151014", "story_v_out_322151.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_37 = math.max(var_63_28, arg_60_1.talkMaxDuration)

			if var_63_27 <= arg_60_1.time_ and arg_60_1.time_ < var_63_27 + var_63_37 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_27) / var_63_37

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_27 + var_63_37 and arg_60_1.time_ < var_63_27 + var_63_37 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322151015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 322151015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play322151016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1211ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1211ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1211ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1284ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos1284ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1284ui_story, var_67_13, var_67_12)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_9.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_9.localEulerAngles = var_67_15
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_9.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_9.localEulerAngles = var_67_17
			end

			local var_67_18 = 0
			local var_67_19 = 1.375

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_20 = arg_64_1:GetWordFromCfg(322151015)
				local var_67_21 = arg_64_1:FormatText(var_67_20.content)

				arg_64_1.text_.text = var_67_21

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_22 = 55
				local var_67_23 = utf8.len(var_67_21)
				local var_67_24 = var_67_22 <= 0 and var_67_19 or var_67_19 * (var_67_23 / var_67_22)

				if var_67_24 > 0 and var_67_19 < var_67_24 then
					arg_64_1.talkMaxDuration = var_67_24

					if var_67_24 + var_67_18 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_18
					end
				end

				arg_64_1.text_.text = var_67_21
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_19, arg_64_1.talkMaxDuration)

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_18) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_18 + var_67_25 and arg_64_1.time_ < var_67_18 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 322151016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play322151017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.275

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

				local var_71_2 = arg_68_1:GetWordFromCfg(322151016)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 51
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
	Play322151017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 322151017
		arg_72_1.duration_ = 3.93

		local var_72_0 = {
			zh = 3.133,
			ja = 3.933
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
				arg_72_0:Play322151018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1284ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1284ui_story = var_75_0.localPosition

				local var_75_2 = "1284ui_story"

				arg_72_1:ShowWeapon(arg_72_1.var_[var_75_2 .. "Animator"].transform, false)
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(-0.7, -0.985, -6.22)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1284ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9
			end

			local var_75_10 = arg_72_1.actors_["1284ui_story"]
			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 and not isNil(var_75_10) and arg_72_1.var_.characterEffect1284ui_story == nil then
				arg_72_1.var_.characterEffect1284ui_story = var_75_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_12 = 0.200000002980232

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_12 and not isNil(var_75_10) then
				local var_75_13 = (arg_72_1.time_ - var_75_11) / var_75_12

				if arg_72_1.var_.characterEffect1284ui_story and not isNil(var_75_10) then
					arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_11 + var_75_12 and arg_72_1.time_ < var_75_11 + var_75_12 + arg_75_0 and not isNil(var_75_10) and arg_72_1.var_.characterEffect1284ui_story then
				arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_75_15 = 0

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_75_16 = 0
			local var_75_17 = 0.325

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_18 = arg_72_1:FormatText(StoryNameCfg[6].name)

				arg_72_1.leftNameTxt_.text = var_75_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_19 = arg_72_1:GetWordFromCfg(322151017)
				local var_75_20 = arg_72_1:FormatText(var_75_19.content)

				arg_72_1.text_.text = var_75_20

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_21 = 13
				local var_75_22 = utf8.len(var_75_20)
				local var_75_23 = var_75_21 <= 0 and var_75_17 or var_75_17 * (var_75_22 / var_75_21)

				if var_75_23 > 0 and var_75_17 < var_75_23 then
					arg_72_1.talkMaxDuration = var_75_23

					if var_75_23 + var_75_16 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_16
					end
				end

				arg_72_1.text_.text = var_75_20
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151017", "story_v_out_322151.awb") ~= 0 then
					local var_75_24 = manager.audio:GetVoiceLength("story_v_out_322151", "322151017", "story_v_out_322151.awb") / 1000

					if var_75_24 + var_75_16 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_24 + var_75_16
					end

					if var_75_19.prefab_name ~= "" and arg_72_1.actors_[var_75_19.prefab_name] ~= nil then
						local var_75_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_19.prefab_name].transform, "story_v_out_322151", "322151017", "story_v_out_322151.awb")

						arg_72_1:RecordAudio("322151017", var_75_25)
						arg_72_1:RecordAudio("322151017", var_75_25)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_322151", "322151017", "story_v_out_322151.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_322151", "322151017", "story_v_out_322151.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_26 = math.max(var_75_17, arg_72_1.talkMaxDuration)

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_26 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_16) / var_75_26

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_16 + var_75_26 and arg_72_1.time_ < var_75_16 + var_75_26 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 322151018
		arg_76_1.duration_ = 2.97

		local var_76_0 = {
			zh = 2.966,
			ja = 2.8
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
				arg_76_0:Play322151019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1211ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1211ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0.7, -0.67, -6.07)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1211ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = arg_76_1.actors_["1211ui_story"]
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1211ui_story == nil then
				arg_76_1.var_.characterEffect1211ui_story = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_11 = 0.200000002980232

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 and not isNil(var_79_9) then
				local var_79_12 = (arg_76_1.time_ - var_79_10) / var_79_11

				if arg_76_1.var_.characterEffect1211ui_story and not isNil(var_79_9) then
					arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1211ui_story then
				arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_79_13 = arg_76_1.actors_["1284ui_story"]
			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 and not isNil(var_79_13) and arg_76_1.var_.characterEffect1284ui_story == nil then
				arg_76_1.var_.characterEffect1284ui_story = var_79_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_15 = 0.200000002980232

			if var_79_14 <= arg_76_1.time_ and arg_76_1.time_ < var_79_14 + var_79_15 and not isNil(var_79_13) then
				local var_79_16 = (arg_76_1.time_ - var_79_14) / var_79_15

				if arg_76_1.var_.characterEffect1284ui_story and not isNil(var_79_13) then
					local var_79_17 = Mathf.Lerp(0, 0.5, var_79_16)

					arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1284ui_story.fillRatio = var_79_17
				end
			end

			if arg_76_1.time_ >= var_79_14 + var_79_15 and arg_76_1.time_ < var_79_14 + var_79_15 + arg_79_0 and not isNil(var_79_13) and arg_76_1.var_.characterEffect1284ui_story then
				local var_79_18 = 0.5

				arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1284ui_story.fillRatio = var_79_18
			end

			local var_79_19 = 0

			if var_79_19 < arg_76_1.time_ and arg_76_1.time_ <= var_79_19 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action454")
			end

			local var_79_20 = 0

			if var_79_20 < arg_76_1.time_ and arg_76_1.time_ <= var_79_20 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_79_21 = 0
			local var_79_22 = 0.3

			if var_79_21 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_23 = arg_76_1:FormatText(StoryNameCfg[37].name)

				arg_76_1.leftNameTxt_.text = var_79_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_24 = arg_76_1:GetWordFromCfg(322151018)
				local var_79_25 = arg_76_1:FormatText(var_79_24.content)

				arg_76_1.text_.text = var_79_25

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_26 = 12
				local var_79_27 = utf8.len(var_79_25)
				local var_79_28 = var_79_26 <= 0 and var_79_22 or var_79_22 * (var_79_27 / var_79_26)

				if var_79_28 > 0 and var_79_22 < var_79_28 then
					arg_76_1.talkMaxDuration = var_79_28

					if var_79_28 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_28 + var_79_21
					end
				end

				arg_76_1.text_.text = var_79_25
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151018", "story_v_out_322151.awb") ~= 0 then
					local var_79_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151018", "story_v_out_322151.awb") / 1000

					if var_79_29 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_29 + var_79_21
					end

					if var_79_24.prefab_name ~= "" and arg_76_1.actors_[var_79_24.prefab_name] ~= nil then
						local var_79_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_24.prefab_name].transform, "story_v_out_322151", "322151018", "story_v_out_322151.awb")

						arg_76_1:RecordAudio("322151018", var_79_30)
						arg_76_1:RecordAudio("322151018", var_79_30)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_322151", "322151018", "story_v_out_322151.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_322151", "322151018", "story_v_out_322151.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_31 = math.max(var_79_22, arg_76_1.talkMaxDuration)

			if var_79_21 <= arg_76_1.time_ and arg_76_1.time_ < var_79_21 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_21) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_21 + var_79_31 and arg_76_1.time_ < var_79_21 + var_79_31 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322151019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322151019
		arg_80_1.duration_ = 8.93

		local var_80_0 = {
			zh = 7.666,
			ja = 8.933
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
				arg_80_0:Play322151020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.775

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[37].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(322151019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151019", "story_v_out_322151.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151019", "story_v_out_322151.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_322151", "322151019", "story_v_out_322151.awb")

						arg_80_1:RecordAudio("322151019", var_83_9)
						arg_80_1:RecordAudio("322151019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_322151", "322151019", "story_v_out_322151.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_322151", "322151019", "story_v_out_322151.awb")
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

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play322151020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 322151020
		arg_84_1.duration_ = 8.27

		local var_84_0 = {
			zh = 7.266,
			ja = 8.266
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
				arg_84_0:Play322151021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_2")
			end

			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_87_2 = 0
			local var_87_3 = 0.775

			if var_87_2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_4 = arg_84_1:FormatText(StoryNameCfg[37].name)

				arg_84_1.leftNameTxt_.text = var_87_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:GetWordFromCfg(322151020)
				local var_87_6 = arg_84_1:FormatText(var_87_5.content)

				arg_84_1.text_.text = var_87_6

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 31
				local var_87_8 = utf8.len(var_87_6)
				local var_87_9 = var_87_7 <= 0 and var_87_3 or var_87_3 * (var_87_8 / var_87_7)

				if var_87_9 > 0 and var_87_3 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_6
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151020", "story_v_out_322151.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151020", "story_v_out_322151.awb") / 1000

					if var_87_10 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_2
					end

					if var_87_5.prefab_name ~= "" and arg_84_1.actors_[var_87_5.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_5.prefab_name].transform, "story_v_out_322151", "322151020", "story_v_out_322151.awb")

						arg_84_1:RecordAudio("322151020", var_87_11)
						arg_84_1:RecordAudio("322151020", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_322151", "322151020", "story_v_out_322151.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_322151", "322151020", "story_v_out_322151.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_12 and arg_84_1.time_ < var_87_2 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play322151021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 322151021
		arg_88_1.duration_ = 24.03

		local var_88_0 = {
			zh = 16.266,
			ja = 24.033
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
				arg_88_0:Play322151022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.525

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[37].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(322151021)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 61
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

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151021", "story_v_out_322151.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151021", "story_v_out_322151.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_322151", "322151021", "story_v_out_322151.awb")

						arg_88_1:RecordAudio("322151021", var_91_9)
						arg_88_1:RecordAudio("322151021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_322151", "322151021", "story_v_out_322151.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_322151", "322151021", "story_v_out_322151.awb")
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
	Play322151022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322151022
		arg_92_1.duration_ = 3.5

		local var_92_0 = {
			zh = 2.566,
			ja = 3.5
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
				arg_92_0:Play322151023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_95_2 = 0
			local var_95_3 = 0.25

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_4 = arg_92_1:FormatText(StoryNameCfg[37].name)

				arg_92_1.leftNameTxt_.text = var_95_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_5 = arg_92_1:GetWordFromCfg(322151022)
				local var_95_6 = arg_92_1:FormatText(var_95_5.content)

				arg_92_1.text_.text = var_95_6

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 10
				local var_95_8 = utf8.len(var_95_6)
				local var_95_9 = var_95_7 <= 0 and var_95_3 or var_95_3 * (var_95_8 / var_95_7)

				if var_95_9 > 0 and var_95_3 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_6
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151022", "story_v_out_322151.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151022", "story_v_out_322151.awb") / 1000

					if var_95_10 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_2
					end

					if var_95_5.prefab_name ~= "" and arg_92_1.actors_[var_95_5.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_5.prefab_name].transform, "story_v_out_322151", "322151022", "story_v_out_322151.awb")

						arg_92_1:RecordAudio("322151022", var_95_11)
						arg_92_1:RecordAudio("322151022", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_322151", "322151022", "story_v_out_322151.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_322151", "322151022", "story_v_out_322151.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_12 and arg_92_1.time_ < var_95_2 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play322151023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322151023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play322151024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1211ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1211ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, 100, 0)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1211ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, 100, 0)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1284ui_story"].transform
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.var_.moveOldPos1284ui_story = var_99_9.localPosition
			end

			local var_99_11 = 0.001

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11
				local var_99_13 = Vector3.New(0, 100, 0)

				var_99_9.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1284ui_story, var_99_13, var_99_12)

				local var_99_14 = manager.ui.mainCamera.transform.position - var_99_9.position

				var_99_9.forward = Vector3.New(var_99_14.x, var_99_14.y, var_99_14.z)

				local var_99_15 = var_99_9.localEulerAngles

				var_99_15.z = 0
				var_99_15.x = 0
				var_99_9.localEulerAngles = var_99_15
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 then
				var_99_9.localPosition = Vector3.New(0, 100, 0)

				local var_99_16 = manager.ui.mainCamera.transform.position - var_99_9.position

				var_99_9.forward = Vector3.New(var_99_16.x, var_99_16.y, var_99_16.z)

				local var_99_17 = var_99_9.localEulerAngles

				var_99_17.z = 0
				var_99_17.x = 0
				var_99_9.localEulerAngles = var_99_17
			end

			local var_99_18 = 0
			local var_99_19 = 0.95

			if var_99_18 < arg_96_1.time_ and arg_96_1.time_ <= var_99_18 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_20 = arg_96_1:GetWordFromCfg(322151023)
				local var_99_21 = arg_96_1:FormatText(var_99_20.content)

				arg_96_1.text_.text = var_99_21

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_22 = 38
				local var_99_23 = utf8.len(var_99_21)
				local var_99_24 = var_99_22 <= 0 and var_99_19 or var_99_19 * (var_99_23 / var_99_22)

				if var_99_24 > 0 and var_99_19 < var_99_24 then
					arg_96_1.talkMaxDuration = var_99_24

					if var_99_24 + var_99_18 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_18
					end
				end

				arg_96_1.text_.text = var_99_21
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_19, arg_96_1.talkMaxDuration)

			if var_99_18 <= arg_96_1.time_ and arg_96_1.time_ < var_99_18 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_18) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_18 + var_99_25 and arg_96_1.time_ < var_99_18 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322151024
		arg_100_1.duration_ = 11.9

		local var_100_0 = {
			zh = 10.6,
			ja = 11.9
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
				arg_100_0:Play322151025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1211ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1211ui_story = var_103_0.localPosition
			end

			local var_103_2 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2
				local var_103_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1211ui_story, var_103_4, var_103_3)

				local var_103_5 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_5.x, var_103_5.y, var_103_5.z)

				local var_103_6 = var_103_0.localEulerAngles

				var_103_6.z = 0
				var_103_6.x = 0
				var_103_0.localEulerAngles = var_103_6
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_103_7 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_7.x, var_103_7.y, var_103_7.z)

				local var_103_8 = var_103_0.localEulerAngles

				var_103_8.z = 0
				var_103_8.x = 0
				var_103_0.localEulerAngles = var_103_8
			end

			local var_103_9 = arg_100_1.actors_["1211ui_story"]
			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1211ui_story == nil then
				arg_100_1.var_.characterEffect1211ui_story = var_103_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_11 = 0.200000002980232

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_11 and not isNil(var_103_9) then
				local var_103_12 = (arg_100_1.time_ - var_103_10) / var_103_11

				if arg_100_1.var_.characterEffect1211ui_story and not isNil(var_103_9) then
					arg_100_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_10 + var_103_11 and arg_100_1.time_ < var_103_10 + var_103_11 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1211ui_story then
				arg_100_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_103_13 = 0

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				arg_100_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_103_14 = 0

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_103_15 = 0
			local var_103_16 = 0.925

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_17 = arg_100_1:FormatText(StoryNameCfg[37].name)

				arg_100_1.leftNameTxt_.text = var_103_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(322151024)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 37
				local var_103_21 = utf8.len(var_103_19)
				local var_103_22 = var_103_20 <= 0 and var_103_16 or var_103_16 * (var_103_21 / var_103_20)

				if var_103_22 > 0 and var_103_16 < var_103_22 then
					arg_100_1.talkMaxDuration = var_103_22

					if var_103_22 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_22 + var_103_15
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151024", "story_v_out_322151.awb") ~= 0 then
					local var_103_23 = manager.audio:GetVoiceLength("story_v_out_322151", "322151024", "story_v_out_322151.awb") / 1000

					if var_103_23 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_15
					end

					if var_103_18.prefab_name ~= "" and arg_100_1.actors_[var_103_18.prefab_name] ~= nil then
						local var_103_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_18.prefab_name].transform, "story_v_out_322151", "322151024", "story_v_out_322151.awb")

						arg_100_1:RecordAudio("322151024", var_103_24)
						arg_100_1:RecordAudio("322151024", var_103_24)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_322151", "322151024", "story_v_out_322151.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_322151", "322151024", "story_v_out_322151.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_25 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_25 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_25

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_25 and arg_100_1.time_ < var_103_15 + var_103_25 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322151025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322151025
		arg_104_1.duration_ = 8.8

		local var_104_0 = {
			zh = 5.466,
			ja = 8.8
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
				arg_104_0:Play322151026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1284ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1284ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0.7, -0.985, -6.22)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1284ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["1284ui_story"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1284ui_story == nil then
				arg_104_1.var_.characterEffect1284ui_story = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect1284ui_story and not isNil(var_107_9) then
					arg_104_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1284ui_story then
				arg_104_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_107_13 = arg_104_1.actors_["1211ui_story"]
			local var_107_14 = 0

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 and not isNil(var_107_13) and arg_104_1.var_.characterEffect1211ui_story == nil then
				arg_104_1.var_.characterEffect1211ui_story = var_107_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_15 = 0.200000002980232

			if var_107_14 <= arg_104_1.time_ and arg_104_1.time_ < var_107_14 + var_107_15 and not isNil(var_107_13) then
				local var_107_16 = (arg_104_1.time_ - var_107_14) / var_107_15

				if arg_104_1.var_.characterEffect1211ui_story and not isNil(var_107_13) then
					local var_107_17 = Mathf.Lerp(0, 0.5, var_107_16)

					arg_104_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1211ui_story.fillRatio = var_107_17
				end
			end

			if arg_104_1.time_ >= var_107_14 + var_107_15 and arg_104_1.time_ < var_107_14 + var_107_15 + arg_107_0 and not isNil(var_107_13) and arg_104_1.var_.characterEffect1211ui_story then
				local var_107_18 = 0.5

				arg_104_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1211ui_story.fillRatio = var_107_18
			end

			local var_107_19 = 0

			if var_107_19 < arg_104_1.time_ and arg_104_1.time_ <= var_107_19 + arg_107_0 then
				arg_104_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_107_20 = 0

			if var_107_20 < arg_104_1.time_ and arg_104_1.time_ <= var_107_20 + arg_107_0 then
				arg_104_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_21 = 0
			local var_107_22 = 0.625

			if var_107_21 < arg_104_1.time_ and arg_104_1.time_ <= var_107_21 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_23 = arg_104_1:FormatText(StoryNameCfg[6].name)

				arg_104_1.leftNameTxt_.text = var_107_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_24 = arg_104_1:GetWordFromCfg(322151025)
				local var_107_25 = arg_104_1:FormatText(var_107_24.content)

				arg_104_1.text_.text = var_107_25

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_26 = 25
				local var_107_27 = utf8.len(var_107_25)
				local var_107_28 = var_107_26 <= 0 and var_107_22 or var_107_22 * (var_107_27 / var_107_26)

				if var_107_28 > 0 and var_107_22 < var_107_28 then
					arg_104_1.talkMaxDuration = var_107_28

					if var_107_28 + var_107_21 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_28 + var_107_21
					end
				end

				arg_104_1.text_.text = var_107_25
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151025", "story_v_out_322151.awb") ~= 0 then
					local var_107_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151025", "story_v_out_322151.awb") / 1000

					if var_107_29 + var_107_21 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_29 + var_107_21
					end

					if var_107_24.prefab_name ~= "" and arg_104_1.actors_[var_107_24.prefab_name] ~= nil then
						local var_107_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_24.prefab_name].transform, "story_v_out_322151", "322151025", "story_v_out_322151.awb")

						arg_104_1:RecordAudio("322151025", var_107_30)
						arg_104_1:RecordAudio("322151025", var_107_30)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_322151", "322151025", "story_v_out_322151.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_322151", "322151025", "story_v_out_322151.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_31 = math.max(var_107_22, arg_104_1.talkMaxDuration)

			if var_107_21 <= arg_104_1.time_ and arg_104_1.time_ < var_107_21 + var_107_31 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_21) / var_107_31

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_21 + var_107_31 and arg_104_1.time_ < var_107_21 + var_107_31 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322151026
		arg_108_1.duration_ = 7.3

		local var_108_0 = {
			zh = 6.1,
			ja = 7.3
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
				arg_108_0:Play322151027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1211ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1211ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1211ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1211ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1211ui_story == nil then
				arg_108_1.var_.characterEffect1211ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect1211ui_story and not isNil(var_111_9) then
					arg_108_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1211ui_story then
				arg_108_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_111_13 = arg_108_1.actors_["1284ui_story"]
			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 and not isNil(var_111_13) and arg_108_1.var_.characterEffect1284ui_story == nil then
				arg_108_1.var_.characterEffect1284ui_story = var_111_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_15 = 0.200000002980232

			if var_111_14 <= arg_108_1.time_ and arg_108_1.time_ < var_111_14 + var_111_15 and not isNil(var_111_13) then
				local var_111_16 = (arg_108_1.time_ - var_111_14) / var_111_15

				if arg_108_1.var_.characterEffect1284ui_story and not isNil(var_111_13) then
					local var_111_17 = Mathf.Lerp(0, 0.5, var_111_16)

					arg_108_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1284ui_story.fillRatio = var_111_17
				end
			end

			if arg_108_1.time_ >= var_111_14 + var_111_15 and arg_108_1.time_ < var_111_14 + var_111_15 + arg_111_0 and not isNil(var_111_13) and arg_108_1.var_.characterEffect1284ui_story then
				local var_111_18 = 0.5

				arg_108_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1284ui_story.fillRatio = var_111_18
			end

			local var_111_19 = 0

			if var_111_19 < arg_108_1.time_ and arg_108_1.time_ <= var_111_19 + arg_111_0 then
				arg_108_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			local var_111_20 = 0

			if var_111_20 < arg_108_1.time_ and arg_108_1.time_ <= var_111_20 + arg_111_0 then
				arg_108_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_111_21 = 0
			local var_111_22 = 0.6

			if var_111_21 < arg_108_1.time_ and arg_108_1.time_ <= var_111_21 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_23 = arg_108_1:FormatText(StoryNameCfg[37].name)

				arg_108_1.leftNameTxt_.text = var_111_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_24 = arg_108_1:GetWordFromCfg(322151026)
				local var_111_25 = arg_108_1:FormatText(var_111_24.content)

				arg_108_1.text_.text = var_111_25

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_26 = 24
				local var_111_27 = utf8.len(var_111_25)
				local var_111_28 = var_111_26 <= 0 and var_111_22 or var_111_22 * (var_111_27 / var_111_26)

				if var_111_28 > 0 and var_111_22 < var_111_28 then
					arg_108_1.talkMaxDuration = var_111_28

					if var_111_28 + var_111_21 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_28 + var_111_21
					end
				end

				arg_108_1.text_.text = var_111_25
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151026", "story_v_out_322151.awb") ~= 0 then
					local var_111_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151026", "story_v_out_322151.awb") / 1000

					if var_111_29 + var_111_21 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_29 + var_111_21
					end

					if var_111_24.prefab_name ~= "" and arg_108_1.actors_[var_111_24.prefab_name] ~= nil then
						local var_111_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_24.prefab_name].transform, "story_v_out_322151", "322151026", "story_v_out_322151.awb")

						arg_108_1:RecordAudio("322151026", var_111_30)
						arg_108_1:RecordAudio("322151026", var_111_30)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_322151", "322151026", "story_v_out_322151.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_322151", "322151026", "story_v_out_322151.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_31 = math.max(var_111_22, arg_108_1.talkMaxDuration)

			if var_111_21 <= arg_108_1.time_ and arg_108_1.time_ < var_111_21 + var_111_31 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_21) / var_111_31

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_21 + var_111_31 and arg_108_1.time_ < var_111_21 + var_111_31 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play322151027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322151027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play322151028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1211ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1211ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0, 100, 0)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1211ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, 100, 0)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1284ui_story"].transform
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1.var_.moveOldPos1284ui_story = var_115_9.localPosition
			end

			local var_115_11 = 0.001

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11
				local var_115_13 = Vector3.New(0, 100, 0)

				var_115_9.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1284ui_story, var_115_13, var_115_12)

				local var_115_14 = manager.ui.mainCamera.transform.position - var_115_9.position

				var_115_9.forward = Vector3.New(var_115_14.x, var_115_14.y, var_115_14.z)

				local var_115_15 = var_115_9.localEulerAngles

				var_115_15.z = 0
				var_115_15.x = 0
				var_115_9.localEulerAngles = var_115_15
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 then
				var_115_9.localPosition = Vector3.New(0, 100, 0)

				local var_115_16 = manager.ui.mainCamera.transform.position - var_115_9.position

				var_115_9.forward = Vector3.New(var_115_16.x, var_115_16.y, var_115_16.z)

				local var_115_17 = var_115_9.localEulerAngles

				var_115_17.z = 0
				var_115_17.x = 0
				var_115_9.localEulerAngles = var_115_17
			end

			local var_115_18 = 0
			local var_115_19 = 1.3

			if var_115_18 < arg_112_1.time_ and arg_112_1.time_ <= var_115_18 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_20 = arg_112_1:GetWordFromCfg(322151027)
				local var_115_21 = arg_112_1:FormatText(var_115_20.content)

				arg_112_1.text_.text = var_115_21

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_22 = 52
				local var_115_23 = utf8.len(var_115_21)
				local var_115_24 = var_115_22 <= 0 and var_115_19 or var_115_19 * (var_115_23 / var_115_22)

				if var_115_24 > 0 and var_115_19 < var_115_24 then
					arg_112_1.talkMaxDuration = var_115_24

					if var_115_24 + var_115_18 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_24 + var_115_18
					end
				end

				arg_112_1.text_.text = var_115_21
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_25 = math.max(var_115_19, arg_112_1.talkMaxDuration)

			if var_115_18 <= arg_112_1.time_ and arg_112_1.time_ < var_115_18 + var_115_25 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_18) / var_115_25

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_18 + var_115_25 and arg_112_1.time_ < var_115_18 + var_115_25 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play322151028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322151028
		arg_116_1.duration_ = 5.03

		local var_116_0 = {
			zh = 2.766,
			ja = 5.033
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
				arg_116_0:Play322151029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1211ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1211ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1211ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1211ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1211ui_story == nil then
				arg_116_1.var_.characterEffect1211ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1211ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1211ui_story then
				arg_116_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_2")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_119_15 = 0
			local var_119_16 = 0.15

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[37].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(322151028)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 6
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151028", "story_v_out_322151.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_out_322151", "322151028", "story_v_out_322151.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_out_322151", "322151028", "story_v_out_322151.awb")

						arg_116_1:RecordAudio("322151028", var_119_24)
						arg_116_1:RecordAudio("322151028", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_322151", "322151028", "story_v_out_322151.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_322151", "322151028", "story_v_out_322151.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322151029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322151029
		arg_120_1.duration_ = 2.6

		local var_120_0 = {
			zh = 2.6,
			ja = 2.2
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
				arg_120_0:Play322151030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1284ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1284ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0.7, -0.985, -6.22)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1284ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1284ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1284ui_story == nil then
				arg_120_1.var_.characterEffect1284ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect1284ui_story and not isNil(var_123_9) then
					arg_120_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1284ui_story then
				arg_120_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_123_13 = arg_120_1.actors_["1211ui_story"]
			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 and not isNil(var_123_13) and arg_120_1.var_.characterEffect1211ui_story == nil then
				arg_120_1.var_.characterEffect1211ui_story = var_123_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_15 = 0.200000002980232

			if var_123_14 <= arg_120_1.time_ and arg_120_1.time_ < var_123_14 + var_123_15 and not isNil(var_123_13) then
				local var_123_16 = (arg_120_1.time_ - var_123_14) / var_123_15

				if arg_120_1.var_.characterEffect1211ui_story and not isNil(var_123_13) then
					local var_123_17 = Mathf.Lerp(0, 0.5, var_123_16)

					arg_120_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1211ui_story.fillRatio = var_123_17
				end
			end

			if arg_120_1.time_ >= var_123_14 + var_123_15 and arg_120_1.time_ < var_123_14 + var_123_15 + arg_123_0 and not isNil(var_123_13) and arg_120_1.var_.characterEffect1211ui_story then
				local var_123_18 = 0.5

				arg_120_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1211ui_story.fillRatio = var_123_18
			end

			local var_123_19 = 0

			if var_123_19 < arg_120_1.time_ and arg_120_1.time_ <= var_123_19 + arg_123_0 then
				arg_120_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_123_20 = 0

			if var_123_20 < arg_120_1.time_ and arg_120_1.time_ <= var_123_20 + arg_123_0 then
				arg_120_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_21 = 0
			local var_123_22 = 0.2

			if var_123_21 < arg_120_1.time_ and arg_120_1.time_ <= var_123_21 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_23 = arg_120_1:FormatText(StoryNameCfg[6].name)

				arg_120_1.leftNameTxt_.text = var_123_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_24 = arg_120_1:GetWordFromCfg(322151029)
				local var_123_25 = arg_120_1:FormatText(var_123_24.content)

				arg_120_1.text_.text = var_123_25

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_26 = 8
				local var_123_27 = utf8.len(var_123_25)
				local var_123_28 = var_123_26 <= 0 and var_123_22 or var_123_22 * (var_123_27 / var_123_26)

				if var_123_28 > 0 and var_123_22 < var_123_28 then
					arg_120_1.talkMaxDuration = var_123_28

					if var_123_28 + var_123_21 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_28 + var_123_21
					end
				end

				arg_120_1.text_.text = var_123_25
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151029", "story_v_out_322151.awb") ~= 0 then
					local var_123_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151029", "story_v_out_322151.awb") / 1000

					if var_123_29 + var_123_21 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_29 + var_123_21
					end

					if var_123_24.prefab_name ~= "" and arg_120_1.actors_[var_123_24.prefab_name] ~= nil then
						local var_123_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_24.prefab_name].transform, "story_v_out_322151", "322151029", "story_v_out_322151.awb")

						arg_120_1:RecordAudio("322151029", var_123_30)
						arg_120_1:RecordAudio("322151029", var_123_30)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322151", "322151029", "story_v_out_322151.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322151", "322151029", "story_v_out_322151.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_31 = math.max(var_123_22, arg_120_1.talkMaxDuration)

			if var_123_21 <= arg_120_1.time_ and arg_120_1.time_ < var_123_21 + var_123_31 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_21) / var_123_31

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_21 + var_123_31 and arg_120_1.time_ < var_123_21 + var_123_31 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322151030
		arg_124_1.duration_ = 5.33

		local var_124_0 = {
			zh = 4.666,
			ja = 5.333
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
				arg_124_0:Play322151031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1211ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1211ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1211ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["1211ui_story"]
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1211ui_story == nil then
				arg_124_1.var_.characterEffect1211ui_story = var_127_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_11 = 0.200000002980232

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 and not isNil(var_127_9) then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11

				if arg_124_1.var_.characterEffect1211ui_story and not isNil(var_127_9) then
					arg_124_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1211ui_story then
				arg_124_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_127_13 = arg_124_1.actors_["1284ui_story"]
			local var_127_14 = 0

			if var_127_14 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 and not isNil(var_127_13) and arg_124_1.var_.characterEffect1284ui_story == nil then
				arg_124_1.var_.characterEffect1284ui_story = var_127_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_15 = 0.200000002980232

			if var_127_14 <= arg_124_1.time_ and arg_124_1.time_ < var_127_14 + var_127_15 and not isNil(var_127_13) then
				local var_127_16 = (arg_124_1.time_ - var_127_14) / var_127_15

				if arg_124_1.var_.characterEffect1284ui_story and not isNil(var_127_13) then
					local var_127_17 = Mathf.Lerp(0, 0.5, var_127_16)

					arg_124_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1284ui_story.fillRatio = var_127_17
				end
			end

			if arg_124_1.time_ >= var_127_14 + var_127_15 and arg_124_1.time_ < var_127_14 + var_127_15 + arg_127_0 and not isNil(var_127_13) and arg_124_1.var_.characterEffect1284ui_story then
				local var_127_18 = 0.5

				arg_124_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1284ui_story.fillRatio = var_127_18
			end

			local var_127_19 = 0

			if var_127_19 < arg_124_1.time_ and arg_124_1.time_ <= var_127_19 + arg_127_0 then
				arg_124_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_127_20 = 0

			if var_127_20 < arg_124_1.time_ and arg_124_1.time_ <= var_127_20 + arg_127_0 then
				arg_124_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_127_21 = 0
			local var_127_22 = 0.325

			if var_127_21 < arg_124_1.time_ and arg_124_1.time_ <= var_127_21 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_23 = arg_124_1:FormatText(StoryNameCfg[37].name)

				arg_124_1.leftNameTxt_.text = var_127_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_24 = arg_124_1:GetWordFromCfg(322151030)
				local var_127_25 = arg_124_1:FormatText(var_127_24.content)

				arg_124_1.text_.text = var_127_25

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_26 = 13
				local var_127_27 = utf8.len(var_127_25)
				local var_127_28 = var_127_26 <= 0 and var_127_22 or var_127_22 * (var_127_27 / var_127_26)

				if var_127_28 > 0 and var_127_22 < var_127_28 then
					arg_124_1.talkMaxDuration = var_127_28

					if var_127_28 + var_127_21 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_28 + var_127_21
					end
				end

				arg_124_1.text_.text = var_127_25
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151030", "story_v_out_322151.awb") ~= 0 then
					local var_127_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151030", "story_v_out_322151.awb") / 1000

					if var_127_29 + var_127_21 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_29 + var_127_21
					end

					if var_127_24.prefab_name ~= "" and arg_124_1.actors_[var_127_24.prefab_name] ~= nil then
						local var_127_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_24.prefab_name].transform, "story_v_out_322151", "322151030", "story_v_out_322151.awb")

						arg_124_1:RecordAudio("322151030", var_127_30)
						arg_124_1:RecordAudio("322151030", var_127_30)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_322151", "322151030", "story_v_out_322151.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_322151", "322151030", "story_v_out_322151.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_31 = math.max(var_127_22, arg_124_1.talkMaxDuration)

			if var_127_21 <= arg_124_1.time_ and arg_124_1.time_ < var_127_21 + var_127_31 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_21) / var_127_31

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_21 + var_127_31 and arg_124_1.time_ < var_127_21 + var_127_31 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322151031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322151031
		arg_128_1.duration_ = 2.4

		local var_128_0 = {
			zh = 2.4,
			ja = 1.999999999999
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
				arg_128_0:Play322151032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1284ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1284ui_story == nil then
				arg_128_1.var_.characterEffect1284ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1284ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1284ui_story then
				arg_128_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1211ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1211ui_story == nil then
				arg_128_1.var_.characterEffect1211ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.200000002980232

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect1211ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1211ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1211ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1211ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action9_1")
			end

			local var_131_12 = 0
			local var_131_13 = 0.175

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_14 = arg_128_1:FormatText(StoryNameCfg[6].name)

				arg_128_1.leftNameTxt_.text = var_131_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_15 = arg_128_1:GetWordFromCfg(322151031)
				local var_131_16 = arg_128_1:FormatText(var_131_15.content)

				arg_128_1.text_.text = var_131_16

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_17 = 7
				local var_131_18 = utf8.len(var_131_16)
				local var_131_19 = var_131_17 <= 0 and var_131_13 or var_131_13 * (var_131_18 / var_131_17)

				if var_131_19 > 0 and var_131_13 < var_131_19 then
					arg_128_1.talkMaxDuration = var_131_19

					if var_131_19 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_12
					end
				end

				arg_128_1.text_.text = var_131_16
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151031", "story_v_out_322151.awb") ~= 0 then
					local var_131_20 = manager.audio:GetVoiceLength("story_v_out_322151", "322151031", "story_v_out_322151.awb") / 1000

					if var_131_20 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_20 + var_131_12
					end

					if var_131_15.prefab_name ~= "" and arg_128_1.actors_[var_131_15.prefab_name] ~= nil then
						local var_131_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_15.prefab_name].transform, "story_v_out_322151", "322151031", "story_v_out_322151.awb")

						arg_128_1:RecordAudio("322151031", var_131_21)
						arg_128_1:RecordAudio("322151031", var_131_21)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322151", "322151031", "story_v_out_322151.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322151", "322151031", "story_v_out_322151.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_13, arg_128_1.talkMaxDuration)

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_12) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_12 + var_131_22 and arg_128_1.time_ < var_131_12 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play322151032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322151032
		arg_132_1.duration_ = 17.43

		local var_132_0 = {
			zh = 12.366,
			ja = 17.433
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
				arg_132_0:Play322151033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1211ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1211ui_story == nil then
				arg_132_1.var_.characterEffect1211ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1211ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1211ui_story then
				arg_132_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["1284ui_story"]
			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1284ui_story == nil then
				arg_132_1.var_.characterEffect1284ui_story = var_135_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_6 = 0.200000002980232

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 and not isNil(var_135_4) then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6

				if arg_132_1.var_.characterEffect1284ui_story and not isNil(var_135_4) then
					local var_135_8 = Mathf.Lerp(0, 0.5, var_135_7)

					arg_132_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1284ui_story.fillRatio = var_135_8
				end
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1284ui_story then
				local var_135_9 = 0.5

				arg_132_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1284ui_story.fillRatio = var_135_9
			end

			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_135_11 = 0

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_135_12 = 0
			local var_135_13 = 1.15

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_14 = arg_132_1:FormatText(StoryNameCfg[37].name)

				arg_132_1.leftNameTxt_.text = var_135_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_15 = arg_132_1:GetWordFromCfg(322151032)
				local var_135_16 = arg_132_1:FormatText(var_135_15.content)

				arg_132_1.text_.text = var_135_16

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 46
				local var_135_18 = utf8.len(var_135_16)
				local var_135_19 = var_135_17 <= 0 and var_135_13 or var_135_13 * (var_135_18 / var_135_17)

				if var_135_19 > 0 and var_135_13 < var_135_19 then
					arg_132_1.talkMaxDuration = var_135_19

					if var_135_19 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_19 + var_135_12
					end
				end

				arg_132_1.text_.text = var_135_16
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151032", "story_v_out_322151.awb") ~= 0 then
					local var_135_20 = manager.audio:GetVoiceLength("story_v_out_322151", "322151032", "story_v_out_322151.awb") / 1000

					if var_135_20 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_20 + var_135_12
					end

					if var_135_15.prefab_name ~= "" and arg_132_1.actors_[var_135_15.prefab_name] ~= nil then
						local var_135_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_15.prefab_name].transform, "story_v_out_322151", "322151032", "story_v_out_322151.awb")

						arg_132_1:RecordAudio("322151032", var_135_21)
						arg_132_1:RecordAudio("322151032", var_135_21)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322151", "322151032", "story_v_out_322151.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322151", "322151032", "story_v_out_322151.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_22 = math.max(var_135_13, arg_132_1.talkMaxDuration)

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_22 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_12) / var_135_22

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_12 + var_135_22 and arg_132_1.time_ < var_135_12 + var_135_22 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play322151033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322151033
		arg_136_1.duration_ = 10.67

		local var_136_0 = {
			zh = 7.133,
			ja = 10.666
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
				arg_136_0:Play322151034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.7

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[37].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(322151033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 28
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151033", "story_v_out_322151.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151033", "story_v_out_322151.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_322151", "322151033", "story_v_out_322151.awb")

						arg_136_1:RecordAudio("322151033", var_139_9)
						arg_136_1:RecordAudio("322151033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322151", "322151033", "story_v_out_322151.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322151", "322151033", "story_v_out_322151.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play322151034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322151034
		arg_140_1.duration_ = 10.87

		local var_140_0 = {
			zh = 9.833,
			ja = 10.866
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
				arg_140_0:Play322151035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_2")
			end

			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_143_2 = 0
			local var_143_3 = 0.775

			if var_143_2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_4 = arg_140_1:FormatText(StoryNameCfg[37].name)

				arg_140_1.leftNameTxt_.text = var_143_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_5 = arg_140_1:GetWordFromCfg(322151034)
				local var_143_6 = arg_140_1:FormatText(var_143_5.content)

				arg_140_1.text_.text = var_143_6

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 31
				local var_143_8 = utf8.len(var_143_6)
				local var_143_9 = var_143_7 <= 0 and var_143_3 or var_143_3 * (var_143_8 / var_143_7)

				if var_143_9 > 0 and var_143_3 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_6
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151034", "story_v_out_322151.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151034", "story_v_out_322151.awb") / 1000

					if var_143_10 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_2
					end

					if var_143_5.prefab_name ~= "" and arg_140_1.actors_[var_143_5.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_5.prefab_name].transform, "story_v_out_322151", "322151034", "story_v_out_322151.awb")

						arg_140_1:RecordAudio("322151034", var_143_11)
						arg_140_1:RecordAudio("322151034", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322151", "322151034", "story_v_out_322151.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322151", "322151034", "story_v_out_322151.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_12 and arg_140_1.time_ < var_143_2 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322151035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322151035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play322151036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1211ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1211ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1211ui_story, var_147_4, var_147_3)

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

			local var_147_9 = arg_144_1.actors_["1284ui_story"].transform
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.var_.moveOldPos1284ui_story = var_147_9.localPosition
			end

			local var_147_11 = 0.001

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / var_147_11
				local var_147_13 = Vector3.New(0, 100, 0)

				var_147_9.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1284ui_story, var_147_13, var_147_12)

				local var_147_14 = manager.ui.mainCamera.transform.position - var_147_9.position

				var_147_9.forward = Vector3.New(var_147_14.x, var_147_14.y, var_147_14.z)

				local var_147_15 = var_147_9.localEulerAngles

				var_147_15.z = 0
				var_147_15.x = 0
				var_147_9.localEulerAngles = var_147_15
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 then
				var_147_9.localPosition = Vector3.New(0, 100, 0)

				local var_147_16 = manager.ui.mainCamera.transform.position - var_147_9.position

				var_147_9.forward = Vector3.New(var_147_16.x, var_147_16.y, var_147_16.z)

				local var_147_17 = var_147_9.localEulerAngles

				var_147_17.z = 0
				var_147_17.x = 0
				var_147_9.localEulerAngles = var_147_17
			end

			local var_147_18 = 0
			local var_147_19 = 1.25

			if var_147_18 < arg_144_1.time_ and arg_144_1.time_ <= var_147_18 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_20 = arg_144_1:GetWordFromCfg(322151035)
				local var_147_21 = arg_144_1:FormatText(var_147_20.content)

				arg_144_1.text_.text = var_147_21

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_22 = 50
				local var_147_23 = utf8.len(var_147_21)
				local var_147_24 = var_147_22 <= 0 and var_147_19 or var_147_19 * (var_147_23 / var_147_22)

				if var_147_24 > 0 and var_147_19 < var_147_24 then
					arg_144_1.talkMaxDuration = var_147_24

					if var_147_24 + var_147_18 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_24 + var_147_18
					end
				end

				arg_144_1.text_.text = var_147_21
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_25 = math.max(var_147_19, arg_144_1.talkMaxDuration)

			if var_147_18 <= arg_144_1.time_ and arg_144_1.time_ < var_147_18 + var_147_25 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_18) / var_147_25

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_18 + var_147_25 and arg_144_1.time_ < var_147_18 + var_147_25 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322151036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322151037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.625

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

				local var_151_2 = arg_148_1:GetWordFromCfg(322151036)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 25
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
	Play322151037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322151037
		arg_152_1.duration_ = 2

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play322151038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = "1043ui_story"

			if arg_152_1.actors_[var_155_0] == nil then
				local var_155_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_155_1) then
					local var_155_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_152_1.stage_.transform)

					var_155_2.name = var_155_0
					var_155_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_152_1.actors_[var_155_0] = var_155_2

					local var_155_3 = var_155_2:GetComponentInChildren(typeof(CharacterEffect))

					var_155_3.enabled = true

					local var_155_4 = GameObjectTools.GetOrAddComponent(var_155_2, typeof(DynamicBoneHelper))

					if var_155_4 then
						var_155_4:EnableDynamicBone(false)
					end

					arg_152_1:ShowWeapon(var_155_3.transform, false)

					arg_152_1.var_[var_155_0 .. "Animator"] = var_155_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_152_1.var_[var_155_0 .. "Animator"].applyRootMotion = true
					arg_152_1.var_[var_155_0 .. "LipSync"] = var_155_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_155_5 = arg_152_1.actors_["1043ui_story"].transform
			local var_155_6 = 0

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.var_.moveOldPos1043ui_story = var_155_5.localPosition
			end

			local var_155_7 = 0.001

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_7 then
				local var_155_8 = (arg_152_1.time_ - var_155_6) / var_155_7
				local var_155_9 = Vector3.New(0.01, -1.01, -5.73)

				var_155_5.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1043ui_story, var_155_9, var_155_8)

				local var_155_10 = manager.ui.mainCamera.transform.position - var_155_5.position

				var_155_5.forward = Vector3.New(var_155_10.x, var_155_10.y, var_155_10.z)

				local var_155_11 = var_155_5.localEulerAngles

				var_155_11.z = 0
				var_155_11.x = 0
				var_155_5.localEulerAngles = var_155_11
			end

			if arg_152_1.time_ >= var_155_6 + var_155_7 and arg_152_1.time_ < var_155_6 + var_155_7 + arg_155_0 then
				var_155_5.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_155_12 = manager.ui.mainCamera.transform.position - var_155_5.position

				var_155_5.forward = Vector3.New(var_155_12.x, var_155_12.y, var_155_12.z)

				local var_155_13 = var_155_5.localEulerAngles

				var_155_13.z = 0
				var_155_13.x = 0
				var_155_5.localEulerAngles = var_155_13
			end

			local var_155_14 = arg_152_1.actors_["1043ui_story"]
			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.characterEffect1043ui_story == nil then
				arg_152_1.var_.characterEffect1043ui_story = var_155_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_16 = 0.200000002980232

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 and not isNil(var_155_14) then
				local var_155_17 = (arg_152_1.time_ - var_155_15) / var_155_16

				if arg_152_1.var_.characterEffect1043ui_story and not isNil(var_155_14) then
					arg_152_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.characterEffect1043ui_story then
				arg_152_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_155_18 = 0

			if var_155_18 < arg_152_1.time_ and arg_152_1.time_ <= var_155_18 + arg_155_0 then
				arg_152_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_155_19 = 0

			if var_155_19 < arg_152_1.time_ and arg_152_1.time_ <= var_155_19 + arg_155_0 then
				arg_152_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_155_20 = 0
			local var_155_21 = 0.05

			if var_155_20 < arg_152_1.time_ and arg_152_1.time_ <= var_155_20 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_22 = arg_152_1:FormatText(StoryNameCfg[1156].name)

				arg_152_1.leftNameTxt_.text = var_155_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_23 = arg_152_1:GetWordFromCfg(322151037)
				local var_155_24 = arg_152_1:FormatText(var_155_23.content)

				arg_152_1.text_.text = var_155_24

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_25 = 2
				local var_155_26 = utf8.len(var_155_24)
				local var_155_27 = var_155_25 <= 0 and var_155_21 or var_155_21 * (var_155_26 / var_155_25)

				if var_155_27 > 0 and var_155_21 < var_155_27 then
					arg_152_1.talkMaxDuration = var_155_27

					if var_155_27 + var_155_20 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_27 + var_155_20
					end
				end

				arg_152_1.text_.text = var_155_24
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151037", "story_v_out_322151.awb") ~= 0 then
					local var_155_28 = manager.audio:GetVoiceLength("story_v_out_322151", "322151037", "story_v_out_322151.awb") / 1000

					if var_155_28 + var_155_20 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_28 + var_155_20
					end

					if var_155_23.prefab_name ~= "" and arg_152_1.actors_[var_155_23.prefab_name] ~= nil then
						local var_155_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_23.prefab_name].transform, "story_v_out_322151", "322151037", "story_v_out_322151.awb")

						arg_152_1:RecordAudio("322151037", var_155_29)
						arg_152_1:RecordAudio("322151037", var_155_29)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322151", "322151037", "story_v_out_322151.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322151", "322151037", "story_v_out_322151.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_30 = math.max(var_155_21, arg_152_1.talkMaxDuration)

			if var_155_20 <= arg_152_1.time_ and arg_152_1.time_ < var_155_20 + var_155_30 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_20) / var_155_30

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_20 + var_155_30 and arg_152_1.time_ < var_155_20 + var_155_30 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322151038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322151038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322151039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1043ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1043ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0, 100, 0)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1043ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, 100, 0)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1043ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1043ui_story == nil then
				arg_156_1.var_.characterEffect1043ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1043ui_story and not isNil(var_159_9) then
					local var_159_13 = Mathf.Lerp(0, 0.5, var_159_12)

					arg_156_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1043ui_story.fillRatio = var_159_13
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1043ui_story then
				local var_159_14 = 0.5

				arg_156_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1043ui_story.fillRatio = var_159_14
			end

			local var_159_15 = 0
			local var_159_16 = 0.75

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_17 = arg_156_1:GetWordFromCfg(322151038)
				local var_159_18 = arg_156_1:FormatText(var_159_17.content)

				arg_156_1.text_.text = var_159_18

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_19 = 30
				local var_159_20 = utf8.len(var_159_18)
				local var_159_21 = var_159_19 <= 0 and var_159_16 or var_159_16 * (var_159_20 / var_159_19)

				if var_159_21 > 0 and var_159_16 < var_159_21 then
					arg_156_1.talkMaxDuration = var_159_21

					if var_159_21 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_21 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_18
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_22 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_22 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_22

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_22 and arg_156_1.time_ < var_159_15 + var_159_22 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322151039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322151039
		arg_160_1.duration_ = 9

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322151040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "ST0502"

			if arg_160_1.bgs_[var_163_0] == nil then
				local var_163_1 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_163_0)
				var_163_1.name = var_163_0
				var_163_1.transform.parent = arg_160_1.stage_.transform
				var_163_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_[var_163_0] = var_163_1
			end

			local var_163_2 = 2

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				local var_163_3 = manager.ui.mainCamera.transform.localPosition
				local var_163_4 = Vector3.New(0, 0, 10) + Vector3.New(var_163_3.x, var_163_3.y, 0)
				local var_163_5 = arg_160_1.bgs_.ST0502

				var_163_5.transform.localPosition = var_163_4
				var_163_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_6 = var_163_5:GetComponent("SpriteRenderer")

				if var_163_6 and var_163_6.sprite then
					local var_163_7 = (var_163_5.transform.localPosition - var_163_3).z
					local var_163_8 = manager.ui.mainCameraCom_
					local var_163_9 = 2 * var_163_7 * Mathf.Tan(var_163_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_10 = var_163_9 * var_163_8.aspect
					local var_163_11 = var_163_6.sprite.bounds.size.x
					local var_163_12 = var_163_6.sprite.bounds.size.y
					local var_163_13 = var_163_10 / var_163_11
					local var_163_14 = var_163_9 / var_163_12
					local var_163_15 = var_163_14 < var_163_13 and var_163_13 or var_163_14

					var_163_5.transform.localScale = Vector3.New(var_163_15, var_163_15, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "ST0502" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_16 = 4

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_17 = 0.3

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_18 = 0

			if var_163_18 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_19 = 2

			if var_163_18 <= arg_160_1.time_ and arg_160_1.time_ < var_163_18 + var_163_19 then
				local var_163_20 = (arg_160_1.time_ - var_163_18) / var_163_19
				local var_163_21 = Color.New(0, 0, 0)

				var_163_21.a = Mathf.Lerp(0, 1, var_163_20)
				arg_160_1.mask_.color = var_163_21
			end

			if arg_160_1.time_ >= var_163_18 + var_163_19 and arg_160_1.time_ < var_163_18 + var_163_19 + arg_163_0 then
				local var_163_22 = Color.New(0, 0, 0)

				var_163_22.a = 1
				arg_160_1.mask_.color = var_163_22
			end

			local var_163_23 = 2

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_24 = 2

			if var_163_23 <= arg_160_1.time_ and arg_160_1.time_ < var_163_23 + var_163_24 then
				local var_163_25 = (arg_160_1.time_ - var_163_23) / var_163_24
				local var_163_26 = Color.New(0, 0, 0)

				var_163_26.a = Mathf.Lerp(1, 0, var_163_25)
				arg_160_1.mask_.color = var_163_26
			end

			if arg_160_1.time_ >= var_163_23 + var_163_24 and arg_160_1.time_ < var_163_23 + var_163_24 + arg_163_0 then
				local var_163_27 = Color.New(0, 0, 0)
				local var_163_28 = 0

				arg_160_1.mask_.enabled = false
				var_163_27.a = var_163_28
				arg_160_1.mask_.color = var_163_27
			end

			local var_163_29 = 0.1
			local var_163_30 = 1

			if var_163_29 < arg_160_1.time_ and arg_160_1.time_ <= var_163_29 + arg_163_0 then
				local var_163_31 = "stop"
				local var_163_32 = "effect"

				arg_160_1:AudioAction(var_163_31, var_163_32, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_163_33 = 1.53333333333333
			local var_163_34 = 1

			if var_163_33 < arg_160_1.time_ and arg_160_1.time_ <= var_163_33 + arg_163_0 then
				local var_163_35 = "play"
				local var_163_36 = "effect"

				arg_160_1:AudioAction(var_163_35, var_163_36, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_163_37 = 0.1
			local var_163_38 = 0.3

			if var_163_37 < arg_160_1.time_ and arg_160_1.time_ <= var_163_37 + arg_163_0 then
				local var_163_39 = "play"
				local var_163_40 = "music"

				arg_160_1:AudioAction(var_163_39, var_163_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_163_41 = ""
				local var_163_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_163_42 ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_42 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_42

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_42
						arg_160_1.bgmTxt2_.text = var_163_42
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_43 = 4
			local var_163_44 = 0.575

			if var_163_43 < arg_160_1.time_ and arg_160_1.time_ <= var_163_43 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_45 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_45:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_160_1.dialogCg_.alpha = arg_165_0
				end))
				var_163_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_46 = arg_160_1:GetWordFromCfg(322151039)
				local var_163_47 = arg_160_1:FormatText(var_163_46.content)

				arg_160_1.text_.text = var_163_47

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_48 = 23
				local var_163_49 = utf8.len(var_163_47)
				local var_163_50 = var_163_48 <= 0 and var_163_44 or var_163_44 * (var_163_49 / var_163_48)

				if var_163_50 > 0 and var_163_44 < var_163_50 then
					arg_160_1.talkMaxDuration = var_163_50
					var_163_43 = var_163_43 + 0.3

					if var_163_50 + var_163_43 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_50 + var_163_43
					end
				end

				arg_160_1.text_.text = var_163_47
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_51 = var_163_43 + 0.3
			local var_163_52 = math.max(var_163_44, arg_160_1.talkMaxDuration)

			if var_163_51 <= arg_160_1.time_ and arg_160_1.time_ < var_163_51 + var_163_52 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_51) / var_163_52

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_51 + var_163_52 and arg_160_1.time_ < var_163_51 + var_163_52 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322151040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322151040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322151041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.45

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(322151040)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 58
				local var_170_5 = utf8.len(var_170_3)
				local var_170_6 = var_170_4 <= 0 and var_170_1 or var_170_1 * (var_170_5 / var_170_4)

				if var_170_6 > 0 and var_170_1 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_7 and arg_167_1.time_ < var_170_0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play322151041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322151041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322151042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1.625

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(322151041)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 65
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play322151042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322151042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322151043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1.575

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(322151042)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 63
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play322151043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322151043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322151044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.2

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(322151043)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 8
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play322151044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322151044
		arg_183_1.duration_ = 3.5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322151045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = "1020ui_story"

			if arg_183_1.actors_[var_186_0] == nil then
				local var_186_1 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_186_1) then
					local var_186_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_183_1.stage_.transform)

					var_186_2.name = var_186_0
					var_186_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_183_1.actors_[var_186_0] = var_186_2

					local var_186_3 = var_186_2:GetComponentInChildren(typeof(CharacterEffect))

					var_186_3.enabled = true

					local var_186_4 = GameObjectTools.GetOrAddComponent(var_186_2, typeof(DynamicBoneHelper))

					if var_186_4 then
						var_186_4:EnableDynamicBone(false)
					end

					arg_183_1:ShowWeapon(var_186_3.transform, false)

					arg_183_1.var_[var_186_0 .. "Animator"] = var_186_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_183_1.var_[var_186_0 .. "Animator"].applyRootMotion = true
					arg_183_1.var_[var_186_0 .. "LipSync"] = var_186_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_186_5 = arg_183_1.actors_["1020ui_story"].transform
			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.var_.moveOldPos1020ui_story = var_186_5.localPosition
			end

			local var_186_7 = 0.001

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_7 then
				local var_186_8 = (arg_183_1.time_ - var_186_6) / var_186_7
				local var_186_9 = Vector3.New(0, -0.85, -6.25)

				var_186_5.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1020ui_story, var_186_9, var_186_8)

				local var_186_10 = manager.ui.mainCamera.transform.position - var_186_5.position

				var_186_5.forward = Vector3.New(var_186_10.x, var_186_10.y, var_186_10.z)

				local var_186_11 = var_186_5.localEulerAngles

				var_186_11.z = 0
				var_186_11.x = 0
				var_186_5.localEulerAngles = var_186_11
			end

			if arg_183_1.time_ >= var_186_6 + var_186_7 and arg_183_1.time_ < var_186_6 + var_186_7 + arg_186_0 then
				var_186_5.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_186_12 = manager.ui.mainCamera.transform.position - var_186_5.position

				var_186_5.forward = Vector3.New(var_186_12.x, var_186_12.y, var_186_12.z)

				local var_186_13 = var_186_5.localEulerAngles

				var_186_13.z = 0
				var_186_13.x = 0
				var_186_5.localEulerAngles = var_186_13
			end

			local var_186_14 = arg_183_1.actors_["1020ui_story"]
			local var_186_15 = 0

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 and not isNil(var_186_14) and arg_183_1.var_.characterEffect1020ui_story == nil then
				arg_183_1.var_.characterEffect1020ui_story = var_186_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_16 = 0.200000002980232

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_16 and not isNil(var_186_14) then
				local var_186_17 = (arg_183_1.time_ - var_186_15) / var_186_16

				if arg_183_1.var_.characterEffect1020ui_story and not isNil(var_186_14) then
					arg_183_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_15 + var_186_16 and arg_183_1.time_ < var_186_15 + var_186_16 + arg_186_0 and not isNil(var_186_14) and arg_183_1.var_.characterEffect1020ui_story then
				arg_183_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_186_18 = 0

			if var_186_18 < arg_183_1.time_ and arg_183_1.time_ <= var_186_18 + arg_186_0 then
				arg_183_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_186_19 = 0

			if var_186_19 < arg_183_1.time_ and arg_183_1.time_ <= var_186_19 + arg_186_0 then
				arg_183_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_20 = arg_183_1.actors_["1020ui_story"]
			local var_186_21 = 0

			if var_186_21 < arg_183_1.time_ and arg_183_1.time_ <= var_186_21 + arg_186_0 then
				if arg_183_1.var_.characterEffect1020ui_story == nil then
					arg_183_1.var_.characterEffect1020ui_story = var_186_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_186_22 = arg_183_1.var_.characterEffect1020ui_story

				var_186_22.imageEffect:turnOff()

				var_186_22.interferenceEffect.enabled = true
				var_186_22.interferenceEffect.noise = 0
				var_186_22.interferenceEffect.simTimeScale = 1
				var_186_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_186_23 = arg_183_1.actors_["1020ui_story"]
			local var_186_24 = 0
			local var_186_25 = 3.5

			if var_186_24 < arg_183_1.time_ and arg_183_1.time_ <= var_186_24 + arg_186_0 then
				if arg_183_1.var_.characterEffect1020ui_story == nil then
					arg_183_1.var_.characterEffect1020ui_story = var_186_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_183_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_186_26 = 0
			local var_186_27 = 0.2

			if var_186_26 < arg_183_1.time_ and arg_183_1.time_ <= var_186_26 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_28 = arg_183_1:FormatText(StoryNameCfg[613].name)

				arg_183_1.leftNameTxt_.text = var_186_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_29 = arg_183_1:GetWordFromCfg(322151044)
				local var_186_30 = arg_183_1:FormatText(var_186_29.content)

				arg_183_1.text_.text = var_186_30

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_31 = 8
				local var_186_32 = utf8.len(var_186_30)
				local var_186_33 = var_186_31 <= 0 and var_186_27 or var_186_27 * (var_186_32 / var_186_31)

				if var_186_33 > 0 and var_186_27 < var_186_33 then
					arg_183_1.talkMaxDuration = var_186_33

					if var_186_33 + var_186_26 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_33 + var_186_26
					end
				end

				arg_183_1.text_.text = var_186_30
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151044", "story_v_out_322151.awb") ~= 0 then
					local var_186_34 = manager.audio:GetVoiceLength("story_v_out_322151", "322151044", "story_v_out_322151.awb") / 1000

					if var_186_34 + var_186_26 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_34 + var_186_26
					end

					if var_186_29.prefab_name ~= "" and arg_183_1.actors_[var_186_29.prefab_name] ~= nil then
						local var_186_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_29.prefab_name].transform, "story_v_out_322151", "322151044", "story_v_out_322151.awb")

						arg_183_1:RecordAudio("322151044", var_186_35)
						arg_183_1:RecordAudio("322151044", var_186_35)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_322151", "322151044", "story_v_out_322151.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_322151", "322151044", "story_v_out_322151.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_36 = math.max(var_186_27, arg_183_1.talkMaxDuration)

			if var_186_26 <= arg_183_1.time_ and arg_183_1.time_ < var_186_26 + var_186_36 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_26) / var_186_36

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_26 + var_186_36 and arg_183_1.time_ < var_186_26 + var_186_36 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play322151045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322151045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322151046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1020ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1020ui_story == nil then
				arg_187_1.var_.characterEffect1020ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1020ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1020ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1020ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1020ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.55

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(322151045)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 22
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play322151046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322151046
		arg_191_1.duration_ = 8.7

		local var_191_0 = {
			zh = 8,
			ja = 8.7
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322151047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1020ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1020ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, -0.85, -6.25)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1020ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1020ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1020ui_story == nil then
				arg_191_1.var_.characterEffect1020ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect1020ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1020ui_story then
				arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_15 = arg_191_1.actors_["1020ui_story"]
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				if arg_191_1.var_.characterEffect1020ui_story == nil then
					arg_191_1.var_.characterEffect1020ui_story = var_194_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_194_17 = arg_191_1.var_.characterEffect1020ui_story

				var_194_17.imageEffect:turnOff()

				var_194_17.interferenceEffect.enabled = true
				var_194_17.interferenceEffect.noise = 0
				var_194_17.interferenceEffect.simTimeScale = 1
				var_194_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_194_18 = arg_191_1.actors_["1020ui_story"]
			local var_194_19 = 0
			local var_194_20 = 3.5

			if var_194_19 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 then
				if arg_191_1.var_.characterEffect1020ui_story == nil then
					arg_191_1.var_.characterEffect1020ui_story = var_194_18:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_191_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_194_21 = 0
			local var_194_22 = 0.975

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_23 = arg_191_1:FormatText(StoryNameCfg[613].name)

				arg_191_1.leftNameTxt_.text = var_194_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_24 = arg_191_1:GetWordFromCfg(322151046)
				local var_194_25 = arg_191_1:FormatText(var_194_24.content)

				arg_191_1.text_.text = var_194_25

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_26 = 39
				local var_194_27 = utf8.len(var_194_25)
				local var_194_28 = var_194_26 <= 0 and var_194_22 or var_194_22 * (var_194_27 / var_194_26)

				if var_194_28 > 0 and var_194_22 < var_194_28 then
					arg_191_1.talkMaxDuration = var_194_28

					if var_194_28 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_28 + var_194_21
					end
				end

				arg_191_1.text_.text = var_194_25
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151046", "story_v_out_322151.awb") ~= 0 then
					local var_194_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151046", "story_v_out_322151.awb") / 1000

					if var_194_29 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_29 + var_194_21
					end

					if var_194_24.prefab_name ~= "" and arg_191_1.actors_[var_194_24.prefab_name] ~= nil then
						local var_194_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_24.prefab_name].transform, "story_v_out_322151", "322151046", "story_v_out_322151.awb")

						arg_191_1:RecordAudio("322151046", var_194_30)
						arg_191_1:RecordAudio("322151046", var_194_30)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322151", "322151046", "story_v_out_322151.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322151", "322151046", "story_v_out_322151.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_31 = math.max(var_194_22, arg_191_1.talkMaxDuration)

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_31 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_21) / var_194_31

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_21 + var_194_31 and arg_191_1.time_ < var_194_21 + var_194_31 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play322151047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322151047
		arg_195_1.duration_ = 5.3

		local var_195_0 = {
			zh = 3.9,
			ja = 5.3
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322151048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_198_2 = arg_195_1.actors_["1020ui_story"]
			local var_198_3 = 0

			if var_198_3 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				if arg_195_1.var_.characterEffect1020ui_story == nil then
					arg_195_1.var_.characterEffect1020ui_story = var_198_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_198_4 = arg_195_1.var_.characterEffect1020ui_story

				var_198_4.imageEffect:turnOff()

				var_198_4.interferenceEffect.enabled = true
				var_198_4.interferenceEffect.noise = 0
				var_198_4.interferenceEffect.simTimeScale = 1
				var_198_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_198_5 = arg_195_1.actors_["1020ui_story"]
			local var_198_6 = 0
			local var_198_7 = 3.5

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				if arg_195_1.var_.characterEffect1020ui_story == nil then
					arg_195_1.var_.characterEffect1020ui_story = var_198_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_195_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_198_8 = arg_195_1.actors_["1020ui_story"].transform
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.var_.moveOldPos1020ui_story = var_198_8.localPosition
			end

			local var_198_10 = 0.001

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_10 then
				local var_198_11 = (arg_195_1.time_ - var_198_9) / var_198_10
				local var_198_12 = Vector3.New(0, -0.85, -6.25)

				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1020ui_story, var_198_12, var_198_11)

				local var_198_13 = manager.ui.mainCamera.transform.position - var_198_8.position

				var_198_8.forward = Vector3.New(var_198_13.x, var_198_13.y, var_198_13.z)

				local var_198_14 = var_198_8.localEulerAngles

				var_198_14.z = 0
				var_198_14.x = 0
				var_198_8.localEulerAngles = var_198_14
			end

			if arg_195_1.time_ >= var_198_9 + var_198_10 and arg_195_1.time_ < var_198_9 + var_198_10 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_198_15 = manager.ui.mainCamera.transform.position - var_198_8.position

				var_198_8.forward = Vector3.New(var_198_15.x, var_198_15.y, var_198_15.z)

				local var_198_16 = var_198_8.localEulerAngles

				var_198_16.z = 0
				var_198_16.x = 0
				var_198_8.localEulerAngles = var_198_16
			end

			local var_198_17 = arg_195_1.actors_["1020ui_story"]
			local var_198_18 = 0

			if var_198_18 < arg_195_1.time_ and arg_195_1.time_ <= var_198_18 + arg_198_0 and not isNil(var_198_17) and arg_195_1.var_.characterEffect1020ui_story == nil then
				arg_195_1.var_.characterEffect1020ui_story = var_198_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_19 = 0.200000002980232

			if var_198_18 <= arg_195_1.time_ and arg_195_1.time_ < var_198_18 + var_198_19 and not isNil(var_198_17) then
				local var_198_20 = (arg_195_1.time_ - var_198_18) / var_198_19

				if arg_195_1.var_.characterEffect1020ui_story and not isNil(var_198_17) then
					arg_195_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_18 + var_198_19 and arg_195_1.time_ < var_198_18 + var_198_19 + arg_198_0 and not isNil(var_198_17) and arg_195_1.var_.characterEffect1020ui_story then
				arg_195_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_198_21 = 0
			local var_198_22 = 0.45

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_23 = arg_195_1:FormatText(StoryNameCfg[613].name)

				arg_195_1.leftNameTxt_.text = var_198_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_24 = arg_195_1:GetWordFromCfg(322151047)
				local var_198_25 = arg_195_1:FormatText(var_198_24.content)

				arg_195_1.text_.text = var_198_25

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_26 = 18
				local var_198_27 = utf8.len(var_198_25)
				local var_198_28 = var_198_26 <= 0 and var_198_22 or var_198_22 * (var_198_27 / var_198_26)

				if var_198_28 > 0 and var_198_22 < var_198_28 then
					arg_195_1.talkMaxDuration = var_198_28

					if var_198_28 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_28 + var_198_21
					end
				end

				arg_195_1.text_.text = var_198_25
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151047", "story_v_out_322151.awb") ~= 0 then
					local var_198_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151047", "story_v_out_322151.awb") / 1000

					if var_198_29 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_29 + var_198_21
					end

					if var_198_24.prefab_name ~= "" and arg_195_1.actors_[var_198_24.prefab_name] ~= nil then
						local var_198_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_24.prefab_name].transform, "story_v_out_322151", "322151047", "story_v_out_322151.awb")

						arg_195_1:RecordAudio("322151047", var_198_30)
						arg_195_1:RecordAudio("322151047", var_198_30)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_322151", "322151047", "story_v_out_322151.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_322151", "322151047", "story_v_out_322151.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_31 = math.max(var_198_22, arg_195_1.talkMaxDuration)

			if var_198_21 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_31 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_21) / var_198_31

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_21 + var_198_31 and arg_195_1.time_ < var_198_21 + var_198_31 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play322151048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322151048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322151049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1020ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1020ui_story == nil then
				arg_199_1.var_.characterEffect1020ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1020ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1020ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1020ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1020ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.975

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_8 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_9 = arg_199_1:GetWordFromCfg(322151048)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 39
				local var_202_12 = utf8.len(var_202_10)
				local var_202_13 = var_202_11 <= 0 and var_202_7 or var_202_7 * (var_202_12 / var_202_11)

				if var_202_13 > 0 and var_202_7 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_14 and arg_199_1.time_ < var_202_6 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play322151049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322151049
		arg_203_1.duration_ = 9

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322151050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = "ST0510"

			if arg_203_1.bgs_[var_206_0] == nil then
				local var_206_1 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_0)
				var_206_1.name = var_206_0
				var_206_1.transform.parent = arg_203_1.stage_.transform
				var_206_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_0] = var_206_1
			end

			local var_206_2 = 2

			if var_206_2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				local var_206_3 = manager.ui.mainCamera.transform.localPosition
				local var_206_4 = Vector3.New(0, 0, 10) + Vector3.New(var_206_3.x, var_206_3.y, 0)
				local var_206_5 = arg_203_1.bgs_.ST0510

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
					if iter_206_0 ~= "ST0510" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_16 = 4

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

			local var_206_19 = 2

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

			local var_206_23 = 2

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

			local var_206_29 = arg_203_1.actors_["1020ui_story"].transform
			local var_206_30 = 1.96599999815226

			if var_206_30 < arg_203_1.time_ and arg_203_1.time_ <= var_206_30 + arg_206_0 then
				arg_203_1.var_.moveOldPos1020ui_story = var_206_29.localPosition
			end

			local var_206_31 = 0.001

			if var_206_30 <= arg_203_1.time_ and arg_203_1.time_ < var_206_30 + var_206_31 then
				local var_206_32 = (arg_203_1.time_ - var_206_30) / var_206_31
				local var_206_33 = Vector3.New(0, 100, 0)

				var_206_29.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1020ui_story, var_206_33, var_206_32)

				local var_206_34 = manager.ui.mainCamera.transform.position - var_206_29.position

				var_206_29.forward = Vector3.New(var_206_34.x, var_206_34.y, var_206_34.z)

				local var_206_35 = var_206_29.localEulerAngles

				var_206_35.z = 0
				var_206_35.x = 0
				var_206_29.localEulerAngles = var_206_35
			end

			if arg_203_1.time_ >= var_206_30 + var_206_31 and arg_203_1.time_ < var_206_30 + var_206_31 + arg_206_0 then
				var_206_29.localPosition = Vector3.New(0, 100, 0)

				local var_206_36 = manager.ui.mainCamera.transform.position - var_206_29.position

				var_206_29.forward = Vector3.New(var_206_36.x, var_206_36.y, var_206_36.z)

				local var_206_37 = var_206_29.localEulerAngles

				var_206_37.z = 0
				var_206_37.x = 0
				var_206_29.localEulerAngles = var_206_37
			end

			local var_206_38 = 2

			arg_203_1.isInRecall_ = false

			if var_206_38 < arg_203_1.time_ and arg_203_1.time_ <= var_206_38 + arg_206_0 then
				arg_203_1.screenFilterGo_:SetActive(true)

				arg_203_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_206_2, iter_206_3 in pairs(arg_203_1.actors_) do
					local var_206_39 = iter_206_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_206_4, iter_206_5 in ipairs(var_206_39) do
						if iter_206_5.color.r > 0.51 then
							iter_206_5.color = Color.New(1, 1, 1)
						else
							iter_206_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_206_40 = 0.034000001847744

			if var_206_38 <= arg_203_1.time_ and arg_203_1.time_ < var_206_38 + var_206_40 then
				local var_206_41 = (arg_203_1.time_ - var_206_38) / var_206_40

				arg_203_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_206_41)
			end

			if arg_203_1.time_ >= var_206_38 + var_206_40 and arg_203_1.time_ < var_206_38 + var_206_40 + arg_206_0 then
				arg_203_1.screenFilterEffect_.weight = 1
			end

			local var_206_42 = 0.166666666666667
			local var_206_43 = 1

			if var_206_42 < arg_203_1.time_ and arg_203_1.time_ <= var_206_42 + arg_206_0 then
				local var_206_44 = "stop"
				local var_206_45 = "effect"

				arg_203_1:AudioAction(var_206_44, var_206_45, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_206_46 = 1.56666666666667
			local var_206_47 = 1

			if var_206_46 < arg_203_1.time_ and arg_203_1.time_ <= var_206_46 + arg_206_0 then
				local var_206_48 = "play"
				local var_206_49 = "effect"

				arg_203_1:AudioAction(var_206_48, var_206_49, "se_story_145", "se_story_145_amb_data", "")
			end

			local var_206_50 = arg_203_1.actors_["1020ui_story"]
			local var_206_51 = 2

			if var_206_51 < arg_203_1.time_ and arg_203_1.time_ <= var_206_51 + arg_206_0 then
				if arg_203_1.var_.characterEffect1020ui_story == nil then
					arg_203_1.var_.characterEffect1020ui_story = var_206_50:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_206_52 = arg_203_1.var_.characterEffect1020ui_story

				var_206_52.imageEffect:turnOff()

				var_206_52.interferenceEffect.enabled = false
				var_206_52.interferenceEffect.noise = 0
				var_206_52.interferenceEffect.simTimeScale = 1
				var_206_52.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_206_53 = arg_203_1.actors_["1020ui_story"]
			local var_206_54 = 2
			local var_206_55 = 3.5

			if var_206_54 < arg_203_1.time_ and arg_203_1.time_ <= var_206_54 + arg_206_0 then
				if arg_203_1.var_.characterEffect1020ui_story == nil then
					arg_203_1.var_.characterEffect1020ui_story = var_206_53:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_203_1.var_.characterEffect1020ui_story.imageEffect:turnOff()
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_56 = 4
			local var_206_57 = 0.175

			if var_206_56 < arg_203_1.time_ and arg_203_1.time_ <= var_206_56 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_58 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_58:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_59 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_59

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

				local var_206_60 = arg_203_1:GetWordFromCfg(322151049)
				local var_206_61 = arg_203_1:FormatText(var_206_60.content)

				arg_203_1.text_.text = var_206_61

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_62 = 7
				local var_206_63 = utf8.len(var_206_61)
				local var_206_64 = var_206_62 <= 0 and var_206_57 or var_206_57 * (var_206_63 / var_206_62)

				if var_206_64 > 0 and var_206_57 < var_206_64 then
					arg_203_1.talkMaxDuration = var_206_64
					var_206_56 = var_206_56 + 0.3

					if var_206_64 + var_206_56 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_64 + var_206_56
					end
				end

				arg_203_1.text_.text = var_206_61
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_65 = var_206_56 + 0.3
			local var_206_66 = math.max(var_206_57, arg_203_1.talkMaxDuration)

			if var_206_65 <= arg_203_1.time_ and arg_203_1.time_ < var_206_65 + var_206_66 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_65) / var_206_66

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_65 + var_206_66 and arg_203_1.time_ < var_206_65 + var_206_66 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play322151050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322151050
		arg_209_1.duration_ = 11.87

		local var_209_0 = {
			zh = 8,
			ja = 11.866
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322151051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "1089ui_story"

			if arg_209_1.actors_[var_212_0] == nil then
				local var_212_1 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_212_1) then
					local var_212_2 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_209_1.stage_.transform)

					var_212_2.name = var_212_0
					var_212_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_209_1.actors_[var_212_0] = var_212_2

					local var_212_3 = var_212_2:GetComponentInChildren(typeof(CharacterEffect))

					var_212_3.enabled = true

					local var_212_4 = GameObjectTools.GetOrAddComponent(var_212_2, typeof(DynamicBoneHelper))

					if var_212_4 then
						var_212_4:EnableDynamicBone(false)
					end

					arg_209_1:ShowWeapon(var_212_3.transform, false)

					arg_209_1.var_[var_212_0 .. "Animator"] = var_212_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_209_1.var_[var_212_0 .. "Animator"].applyRootMotion = true
					arg_209_1.var_[var_212_0 .. "LipSync"] = var_212_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_212_5 = arg_209_1.actors_["1089ui_story"].transform
			local var_212_6 = 0

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.var_.moveOldPos1089ui_story = var_212_5.localPosition
			end

			local var_212_7 = 0.001

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_7 then
				local var_212_8 = (arg_209_1.time_ - var_212_6) / var_212_7
				local var_212_9 = Vector3.New(0, -1.1, -6.17)

				var_212_5.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1089ui_story, var_212_9, var_212_8)

				local var_212_10 = manager.ui.mainCamera.transform.position - var_212_5.position

				var_212_5.forward = Vector3.New(var_212_10.x, var_212_10.y, var_212_10.z)

				local var_212_11 = var_212_5.localEulerAngles

				var_212_11.z = 0
				var_212_11.x = 0
				var_212_5.localEulerAngles = var_212_11
			end

			if arg_209_1.time_ >= var_212_6 + var_212_7 and arg_209_1.time_ < var_212_6 + var_212_7 + arg_212_0 then
				var_212_5.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_212_12 = manager.ui.mainCamera.transform.position - var_212_5.position

				var_212_5.forward = Vector3.New(var_212_12.x, var_212_12.y, var_212_12.z)

				local var_212_13 = var_212_5.localEulerAngles

				var_212_13.z = 0
				var_212_13.x = 0
				var_212_5.localEulerAngles = var_212_13
			end

			local var_212_14 = arg_209_1.actors_["1089ui_story"]
			local var_212_15 = 0

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.characterEffect1089ui_story == nil then
				arg_209_1.var_.characterEffect1089ui_story = var_212_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_16 = 0.200000002980232

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_16 and not isNil(var_212_14) then
				local var_212_17 = (arg_209_1.time_ - var_212_15) / var_212_16

				if arg_209_1.var_.characterEffect1089ui_story and not isNil(var_212_14) then
					arg_209_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_15 + var_212_16 and arg_209_1.time_ < var_212_15 + var_212_16 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.characterEffect1089ui_story then
				arg_209_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_212_18 = 0

			if var_212_18 < arg_209_1.time_ and arg_209_1.time_ <= var_212_18 + arg_212_0 then
				arg_209_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_212_19 = 0

			if var_212_19 < arg_209_1.time_ and arg_209_1.time_ <= var_212_19 + arg_212_0 then
				arg_209_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_20 = 0
			local var_212_21 = 0.925

			if var_212_20 < arg_209_1.time_ and arg_209_1.time_ <= var_212_20 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_22 = arg_209_1:FormatText(StoryNameCfg[1031].name)

				arg_209_1.leftNameTxt_.text = var_212_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_23 = arg_209_1:GetWordFromCfg(322151050)
				local var_212_24 = arg_209_1:FormatText(var_212_23.content)

				arg_209_1.text_.text = var_212_24

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_25 = 37
				local var_212_26 = utf8.len(var_212_24)
				local var_212_27 = var_212_25 <= 0 and var_212_21 or var_212_21 * (var_212_26 / var_212_25)

				if var_212_27 > 0 and var_212_21 < var_212_27 then
					arg_209_1.talkMaxDuration = var_212_27

					if var_212_27 + var_212_20 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_27 + var_212_20
					end
				end

				arg_209_1.text_.text = var_212_24
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151050", "story_v_out_322151.awb") ~= 0 then
					local var_212_28 = manager.audio:GetVoiceLength("story_v_out_322151", "322151050", "story_v_out_322151.awb") / 1000

					if var_212_28 + var_212_20 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_28 + var_212_20
					end

					if var_212_23.prefab_name ~= "" and arg_209_1.actors_[var_212_23.prefab_name] ~= nil then
						local var_212_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_23.prefab_name].transform, "story_v_out_322151", "322151050", "story_v_out_322151.awb")

						arg_209_1:RecordAudio("322151050", var_212_29)
						arg_209_1:RecordAudio("322151050", var_212_29)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_322151", "322151050", "story_v_out_322151.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_322151", "322151050", "story_v_out_322151.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_30 = math.max(var_212_21, arg_209_1.talkMaxDuration)

			if var_212_20 <= arg_209_1.time_ and arg_209_1.time_ < var_212_20 + var_212_30 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_20) / var_212_30

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_20 + var_212_30 and arg_209_1.time_ < var_212_20 + var_212_30 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322151051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322151051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322151052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1089ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1089ui_story == nil then
				arg_213_1.var_.characterEffect1089ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1089ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1089ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1089ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1089ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.4

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(322151051)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 16
				local var_216_12 = utf8.len(var_216_10)
				local var_216_13 = var_216_11 <= 0 and var_216_7 or var_216_7 * (var_216_12 / var_216_11)

				if var_216_13 > 0 and var_216_7 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322151052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322151052
		arg_217_1.duration_ = 9.63

		local var_217_0 = {
			zh = 7.933,
			ja = 9.633
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322151053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1089ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1089ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, -1.1, -6.17)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1089ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1089ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1089ui_story == nil then
				arg_217_1.var_.characterEffect1089ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect1089ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1089ui_story then
				arg_217_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_15 = 0
			local var_220_16 = 0.65

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[1031].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(322151052)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 26
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151052", "story_v_out_322151.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_322151", "322151052", "story_v_out_322151.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_322151", "322151052", "story_v_out_322151.awb")

						arg_217_1:RecordAudio("322151052", var_220_24)
						arg_217_1:RecordAudio("322151052", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322151", "322151052", "story_v_out_322151.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322151", "322151052", "story_v_out_322151.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play322151053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322151053
		arg_221_1.duration_ = 5.93

		local var_221_0 = {
			zh = 5.799999999999,
			ja = 5.933
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322151054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 2.00000000298023

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				local var_224_1 = manager.ui.mainCamera.transform.localPosition
				local var_224_2 = Vector3.New(0, 0, 10) + Vector3.New(var_224_1.x, var_224_1.y, 0)
				local var_224_3 = arg_221_1.bgs_.ST0510

				var_224_3.transform.localPosition = var_224_2
				var_224_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_4 = var_224_3:GetComponent("SpriteRenderer")

				if var_224_4 and var_224_4.sprite then
					local var_224_5 = (var_224_3.transform.localPosition - var_224_1).z
					local var_224_6 = manager.ui.mainCameraCom_
					local var_224_7 = 2 * var_224_5 * Mathf.Tan(var_224_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_224_8 = var_224_7 * var_224_6.aspect
					local var_224_9 = var_224_4.sprite.bounds.size.x
					local var_224_10 = var_224_4.sprite.bounds.size.y
					local var_224_11 = var_224_8 / var_224_9
					local var_224_12 = var_224_7 / var_224_10
					local var_224_13 = var_224_12 < var_224_11 and var_224_11 or var_224_12

					var_224_3.transform.localScale = Vector3.New(var_224_13, var_224_13, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "ST0510" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_14 = 4.00000000298023

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			local var_224_15 = 0.3

			if arg_221_1.time_ >= var_224_14 + var_224_15 and arg_221_1.time_ < var_224_14 + var_224_15 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_17 = 2

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17
				local var_224_19 = Color.New(0, 0, 0)

				var_224_19.a = Mathf.Lerp(0, 1, var_224_18)
				arg_221_1.mask_.color = var_224_19
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 then
				local var_224_20 = Color.New(0, 0, 0)

				var_224_20.a = 1
				arg_221_1.mask_.color = var_224_20
			end

			local var_224_21 = 2

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_22 = 2

			if var_224_21 <= arg_221_1.time_ and arg_221_1.time_ < var_224_21 + var_224_22 then
				local var_224_23 = (arg_221_1.time_ - var_224_21) / var_224_22
				local var_224_24 = Color.New(0, 0, 0)

				var_224_24.a = Mathf.Lerp(1, 0, var_224_23)
				arg_221_1.mask_.color = var_224_24
			end

			if arg_221_1.time_ >= var_224_21 + var_224_22 and arg_221_1.time_ < var_224_21 + var_224_22 + arg_224_0 then
				local var_224_25 = Color.New(0, 0, 0)
				local var_224_26 = 0

				arg_221_1.mask_.enabled = false
				var_224_25.a = var_224_26
				arg_221_1.mask_.color = var_224_25
			end

			local var_224_27 = arg_221_1.actors_["1089ui_story"].transform
			local var_224_28 = 1.96599999815226

			if var_224_28 < arg_221_1.time_ and arg_221_1.time_ <= var_224_28 + arg_224_0 then
				arg_221_1.var_.moveOldPos1089ui_story = var_224_27.localPosition
			end

			local var_224_29 = 0.001

			if var_224_28 <= arg_221_1.time_ and arg_221_1.time_ < var_224_28 + var_224_29 then
				local var_224_30 = (arg_221_1.time_ - var_224_28) / var_224_29
				local var_224_31 = Vector3.New(0, 100, 0)

				var_224_27.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1089ui_story, var_224_31, var_224_30)

				local var_224_32 = manager.ui.mainCamera.transform.position - var_224_27.position

				var_224_27.forward = Vector3.New(var_224_32.x, var_224_32.y, var_224_32.z)

				local var_224_33 = var_224_27.localEulerAngles

				var_224_33.z = 0
				var_224_33.x = 0
				var_224_27.localEulerAngles = var_224_33
			end

			if arg_221_1.time_ >= var_224_28 + var_224_29 and arg_221_1.time_ < var_224_28 + var_224_29 + arg_224_0 then
				var_224_27.localPosition = Vector3.New(0, 100, 0)

				local var_224_34 = manager.ui.mainCamera.transform.position - var_224_27.position

				var_224_27.forward = Vector3.New(var_224_34.x, var_224_34.y, var_224_34.z)

				local var_224_35 = var_224_27.localEulerAngles

				var_224_35.z = 0
				var_224_35.x = 0
				var_224_27.localEulerAngles = var_224_35
			end

			local var_224_36 = "10103ui_story"

			if arg_221_1.actors_[var_224_36] == nil then
				local var_224_37 = Asset.Load("Char/" .. "10103ui_story")

				if not isNil(var_224_37) then
					local var_224_38 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_221_1.stage_.transform)

					var_224_38.name = var_224_36
					var_224_38.transform.localPosition = Vector3.New(0, 100, 0)
					arg_221_1.actors_[var_224_36] = var_224_38

					local var_224_39 = var_224_38:GetComponentInChildren(typeof(CharacterEffect))

					var_224_39.enabled = true

					local var_224_40 = GameObjectTools.GetOrAddComponent(var_224_38, typeof(DynamicBoneHelper))

					if var_224_40 then
						var_224_40:EnableDynamicBone(false)
					end

					arg_221_1:ShowWeapon(var_224_39.transform, false)

					arg_221_1.var_[var_224_36 .. "Animator"] = var_224_39.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_221_1.var_[var_224_36 .. "Animator"].applyRootMotion = true
					arg_221_1.var_[var_224_36 .. "LipSync"] = var_224_39.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_224_41 = arg_221_1.actors_["10103ui_story"].transform
			local var_224_42 = 3.8

			if var_224_42 < arg_221_1.time_ and arg_221_1.time_ <= var_224_42 + arg_224_0 then
				arg_221_1.var_.moveOldPos10103ui_story = var_224_41.localPosition

				local var_224_43 = GameObjectTools.GetOrAddComponent(var_224_41.gameObject, typeof(DynamicBoneHelper))

				if var_224_43 then
					var_224_43:EnableDynamicBone(false)
				end
			end

			local var_224_44 = 0.001

			if var_224_42 <= arg_221_1.time_ and arg_221_1.time_ < var_224_42 + var_224_44 then
				local var_224_45 = (arg_221_1.time_ - var_224_42) / var_224_44
				local var_224_46 = Vector3.New(-0.7, -0.95, -6.2)

				var_224_41.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10103ui_story, var_224_46, var_224_45)

				local var_224_47 = manager.ui.mainCamera.transform.position - var_224_41.position

				var_224_41.forward = Vector3.New(var_224_47.x, var_224_47.y, var_224_47.z)

				local var_224_48 = var_224_41.localEulerAngles

				var_224_48.z = 0
				var_224_48.x = 0
				var_224_41.localEulerAngles = var_224_48
			end

			if arg_221_1.time_ >= var_224_42 + var_224_44 and arg_221_1.time_ < var_224_42 + var_224_44 + arg_224_0 then
				var_224_41.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_224_49 = manager.ui.mainCamera.transform.position - var_224_41.position

				var_224_41.forward = Vector3.New(var_224_49.x, var_224_49.y, var_224_49.z)

				local var_224_50 = var_224_41.localEulerAngles

				var_224_50.z = 0
				var_224_50.x = 0
				var_224_41.localEulerAngles = var_224_50

				local var_224_51 = GameObjectTools.GetOrAddComponent(var_224_41.gameObject, typeof(DynamicBoneHelper))

				if var_224_51 then
					var_224_51:EnableDynamicBone(true)
				end
			end

			local var_224_52 = arg_221_1.actors_["10103ui_story"]
			local var_224_53 = 3.8

			if var_224_53 < arg_221_1.time_ and arg_221_1.time_ <= var_224_53 + arg_224_0 and not isNil(var_224_52) and arg_221_1.var_.characterEffect10103ui_story == nil then
				arg_221_1.var_.characterEffect10103ui_story = var_224_52:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_54 = 0.200000002980232

			if var_224_53 <= arg_221_1.time_ and arg_221_1.time_ < var_224_53 + var_224_54 and not isNil(var_224_52) then
				local var_224_55 = (arg_221_1.time_ - var_224_53) / var_224_54

				if arg_221_1.var_.characterEffect10103ui_story and not isNil(var_224_52) then
					arg_221_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_53 + var_224_54 and arg_221_1.time_ < var_224_53 + var_224_54 + arg_224_0 and not isNil(var_224_52) and arg_221_1.var_.characterEffect10103ui_story then
				arg_221_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_224_56 = arg_221_1.actors_["1089ui_story"]
			local var_224_57 = 1.98333333333333

			if var_224_57 < arg_221_1.time_ and arg_221_1.time_ <= var_224_57 + arg_224_0 and not isNil(var_224_56) and arg_221_1.var_.characterEffect1089ui_story == nil then
				arg_221_1.var_.characterEffect1089ui_story = var_224_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_58 = 0.0166666666666666

			if var_224_57 <= arg_221_1.time_ and arg_221_1.time_ < var_224_57 + var_224_58 and not isNil(var_224_56) then
				local var_224_59 = (arg_221_1.time_ - var_224_57) / var_224_58

				if arg_221_1.var_.characterEffect1089ui_story and not isNil(var_224_56) then
					local var_224_60 = Mathf.Lerp(0, 0.5, var_224_59)

					arg_221_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1089ui_story.fillRatio = var_224_60
				end
			end

			if arg_221_1.time_ >= var_224_57 + var_224_58 and arg_221_1.time_ < var_224_57 + var_224_58 + arg_224_0 and not isNil(var_224_56) and arg_221_1.var_.characterEffect1089ui_story then
				local var_224_61 = 0.5

				arg_221_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1089ui_story.fillRatio = var_224_61
			end

			local var_224_62 = 3.8

			if var_224_62 < arg_221_1.time_ and arg_221_1.time_ <= var_224_62 + arg_224_0 then
				arg_221_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_224_63 = 3.8

			if var_224_63 < arg_221_1.time_ and arg_221_1.time_ <= var_224_63 + arg_224_0 then
				arg_221_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_224_64 = 3.8

			if var_224_64 < arg_221_1.time_ and arg_221_1.time_ <= var_224_64 + arg_224_0 then
				local var_224_65 = arg_221_1.actors_["10103ui_story"]

				if not isNil(var_224_65) then
					local var_224_66 = GameObjectTools.GetOrAddComponent(var_224_65, typeof(DynamicBoneHelper))

					if var_224_66 then
						var_224_66:EnableDynamicBone(true)
					end
				end
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_67 = 3.8
			local var_224_68 = 0.125

			if var_224_67 < arg_221_1.time_ and arg_221_1.time_ <= var_224_67 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_69 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_69:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_70 = arg_221_1:FormatText(StoryNameCfg[1214].name)

				arg_221_1.leftNameTxt_.text = var_224_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_71 = arg_221_1:GetWordFromCfg(322151053)
				local var_224_72 = arg_221_1:FormatText(var_224_71.content)

				arg_221_1.text_.text = var_224_72

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_73 = 5
				local var_224_74 = utf8.len(var_224_72)
				local var_224_75 = var_224_73 <= 0 and var_224_68 or var_224_68 * (var_224_74 / var_224_73)

				if var_224_75 > 0 and var_224_68 < var_224_75 then
					arg_221_1.talkMaxDuration = var_224_75
					var_224_67 = var_224_67 + 0.3

					if var_224_75 + var_224_67 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_75 + var_224_67
					end
				end

				arg_221_1.text_.text = var_224_72
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151053", "story_v_out_322151.awb") ~= 0 then
					local var_224_76 = manager.audio:GetVoiceLength("story_v_out_322151", "322151053", "story_v_out_322151.awb") / 1000

					if var_224_76 + var_224_67 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_76 + var_224_67
					end

					if var_224_71.prefab_name ~= "" and arg_221_1.actors_[var_224_71.prefab_name] ~= nil then
						local var_224_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_71.prefab_name].transform, "story_v_out_322151", "322151053", "story_v_out_322151.awb")

						arg_221_1:RecordAudio("322151053", var_224_77)
						arg_221_1:RecordAudio("322151053", var_224_77)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322151", "322151053", "story_v_out_322151.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322151", "322151053", "story_v_out_322151.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_78 = var_224_67 + 0.3
			local var_224_79 = math.max(var_224_68, arg_221_1.talkMaxDuration)

			if var_224_78 <= arg_221_1.time_ and arg_221_1.time_ < var_224_78 + var_224_79 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_78) / var_224_79

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_78 + var_224_79 and arg_221_1.time_ < var_224_78 + var_224_79 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play322151054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322151054
		arg_227_1.duration_ = 17.87

		local var_227_0 = {
			zh = 9.633,
			ja = 17.866
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play322151055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1089ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1089ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0.7, -1.1, -6.17)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1089ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1089ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1089ui_story == nil then
				arg_227_1.var_.characterEffect1089ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect1089ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1089ui_story then
				arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_230_13 = arg_227_1.actors_["10103ui_story"]
			local var_230_14 = 0

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 and not isNil(var_230_13) and arg_227_1.var_.characterEffect10103ui_story == nil then
				arg_227_1.var_.characterEffect10103ui_story = var_230_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_15 = 0.200000002980232

			if var_230_14 <= arg_227_1.time_ and arg_227_1.time_ < var_230_14 + var_230_15 and not isNil(var_230_13) then
				local var_230_16 = (arg_227_1.time_ - var_230_14) / var_230_15

				if arg_227_1.var_.characterEffect10103ui_story and not isNil(var_230_13) then
					local var_230_17 = Mathf.Lerp(0, 0.5, var_230_16)

					arg_227_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10103ui_story.fillRatio = var_230_17
				end
			end

			if arg_227_1.time_ >= var_230_14 + var_230_15 and arg_227_1.time_ < var_230_14 + var_230_15 + arg_230_0 and not isNil(var_230_13) and arg_227_1.var_.characterEffect10103ui_story then
				local var_230_18 = 0.5

				arg_227_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10103ui_story.fillRatio = var_230_18
			end

			local var_230_19 = 0

			if var_230_19 < arg_227_1.time_ and arg_227_1.time_ <= var_230_19 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_230_20 = 0

			if var_230_20 < arg_227_1.time_ and arg_227_1.time_ <= var_230_20 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_230_21 = 0
			local var_230_22 = 1.125

			if var_230_21 < arg_227_1.time_ and arg_227_1.time_ <= var_230_21 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_23 = arg_227_1:FormatText(StoryNameCfg[1031].name)

				arg_227_1.leftNameTxt_.text = var_230_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_24 = arg_227_1:GetWordFromCfg(322151054)
				local var_230_25 = arg_227_1:FormatText(var_230_24.content)

				arg_227_1.text_.text = var_230_25

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_26 = 45
				local var_230_27 = utf8.len(var_230_25)
				local var_230_28 = var_230_26 <= 0 and var_230_22 or var_230_22 * (var_230_27 / var_230_26)

				if var_230_28 > 0 and var_230_22 < var_230_28 then
					arg_227_1.talkMaxDuration = var_230_28

					if var_230_28 + var_230_21 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_28 + var_230_21
					end
				end

				arg_227_1.text_.text = var_230_25
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151054", "story_v_out_322151.awb") ~= 0 then
					local var_230_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151054", "story_v_out_322151.awb") / 1000

					if var_230_29 + var_230_21 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_29 + var_230_21
					end

					if var_230_24.prefab_name ~= "" and arg_227_1.actors_[var_230_24.prefab_name] ~= nil then
						local var_230_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_24.prefab_name].transform, "story_v_out_322151", "322151054", "story_v_out_322151.awb")

						arg_227_1:RecordAudio("322151054", var_230_30)
						arg_227_1:RecordAudio("322151054", var_230_30)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_322151", "322151054", "story_v_out_322151.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_322151", "322151054", "story_v_out_322151.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_31 = math.max(var_230_22, arg_227_1.talkMaxDuration)

			if var_230_21 <= arg_227_1.time_ and arg_227_1.time_ < var_230_21 + var_230_31 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_21) / var_230_31

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_21 + var_230_31 and arg_227_1.time_ < var_230_21 + var_230_31 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play322151055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322151055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322151056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1089ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1089ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, 100, 0)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1089ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, 100, 0)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["10103ui_story"].transform
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.var_.moveOldPos10103ui_story = var_234_9.localPosition

				local var_234_11 = GameObjectTools.GetOrAddComponent(var_234_9.gameObject, typeof(DynamicBoneHelper))

				if var_234_11 then
					var_234_11:EnableDynamicBone(false)
				end
			end

			local var_234_12 = 0.001

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_12 then
				local var_234_13 = (arg_231_1.time_ - var_234_10) / var_234_12
				local var_234_14 = Vector3.New(0, 100, 0)

				var_234_9.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10103ui_story, var_234_14, var_234_13)

				local var_234_15 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_15.x, var_234_15.y, var_234_15.z)

				local var_234_16 = var_234_9.localEulerAngles

				var_234_16.z = 0
				var_234_16.x = 0
				var_234_9.localEulerAngles = var_234_16
			end

			if arg_231_1.time_ >= var_234_10 + var_234_12 and arg_231_1.time_ < var_234_10 + var_234_12 + arg_234_0 then
				var_234_9.localPosition = Vector3.New(0, 100, 0)

				local var_234_17 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_17.x, var_234_17.y, var_234_17.z)

				local var_234_18 = var_234_9.localEulerAngles

				var_234_18.z = 0
				var_234_18.x = 0
				var_234_9.localEulerAngles = var_234_18

				local var_234_19 = GameObjectTools.GetOrAddComponent(var_234_9.gameObject, typeof(DynamicBoneHelper))

				if var_234_19 then
					var_234_19:EnableDynamicBone(true)
				end
			end

			local var_234_20 = arg_231_1.actors_["1089ui_story"]
			local var_234_21 = 0

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 and not isNil(var_234_20) and arg_231_1.var_.characterEffect1089ui_story == nil then
				arg_231_1.var_.characterEffect1089ui_story = var_234_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_22 = 0.200000002980232

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_22 and not isNil(var_234_20) then
				local var_234_23 = (arg_231_1.time_ - var_234_21) / var_234_22

				if arg_231_1.var_.characterEffect1089ui_story and not isNil(var_234_20) then
					local var_234_24 = Mathf.Lerp(0, 0.5, var_234_23)

					arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1089ui_story.fillRatio = var_234_24
				end
			end

			if arg_231_1.time_ >= var_234_21 + var_234_22 and arg_231_1.time_ < var_234_21 + var_234_22 + arg_234_0 and not isNil(var_234_20) and arg_231_1.var_.characterEffect1089ui_story then
				local var_234_25 = 0.5

				arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1089ui_story.fillRatio = var_234_25
			end

			local var_234_26 = 0.1
			local var_234_27 = 1

			if var_234_26 < arg_231_1.time_ and arg_231_1.time_ <= var_234_26 + arg_234_0 then
				local var_234_28 = "play"
				local var_234_29 = "effect"

				arg_231_1:AudioAction(var_234_28, var_234_29, "se_story_17", "se_story_17_ui", "")
			end

			local var_234_30 = manager.ui.mainCamera.transform
			local var_234_31 = 0.1

			if var_234_31 < arg_231_1.time_ and arg_231_1.time_ <= var_234_31 + arg_234_0 then
				local var_234_32 = arg_231_1.var_.effect1055
				local var_234_33
				local var_234_34 = var_234_30

				if not var_234_32 then
					var_234_32 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_234_34)
					var_234_32.name = "1055"
					arg_231_1.var_.effect1055 = var_234_32
				else
					var_234_32.transform:SetParent(var_234_34)
				end

				var_234_32.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_32.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_234_35 = manager.ui.mainCameraCom_
				local var_234_36 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_234_35.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_234_37 = var_234_32.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_234_38 = 15
				local var_234_39 = 2 * var_234_38 * Mathf.Tan(var_234_35.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_234_35.aspect
				local var_234_40 = 1
				local var_234_41 = 1.7777777777777777

				if var_234_41 < var_234_35.aspect then
					var_234_40 = var_234_39 / (2 * var_234_38 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_234_41)
				end

				for iter_234_0, iter_234_1 in ipairs(var_234_37) do
					local var_234_42 = iter_234_1.transform.localScale

					iter_234_1.transform.localScale = Vector3.New(var_234_42.x / var_234_36 * var_234_40, var_234_42.y / var_234_36, var_234_42.z)
				end
			end

			local var_234_43 = 0
			local var_234_44 = 0.875

			if var_234_43 < arg_231_1.time_ and arg_231_1.time_ <= var_234_43 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_45 = arg_231_1:GetWordFromCfg(322151055)
				local var_234_46 = arg_231_1:FormatText(var_234_45.content)

				arg_231_1.text_.text = var_234_46

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_47 = 35
				local var_234_48 = utf8.len(var_234_46)
				local var_234_49 = var_234_47 <= 0 and var_234_44 or var_234_44 * (var_234_48 / var_234_47)

				if var_234_49 > 0 and var_234_44 < var_234_49 then
					arg_231_1.talkMaxDuration = var_234_49

					if var_234_49 + var_234_43 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_49 + var_234_43
					end
				end

				arg_231_1.text_.text = var_234_46
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_50 = math.max(var_234_44, arg_231_1.talkMaxDuration)

			if var_234_43 <= arg_231_1.time_ and arg_231_1.time_ < var_234_43 + var_234_50 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_43) / var_234_50

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_43 + var_234_50 and arg_231_1.time_ < var_234_43 + var_234_50 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play322151056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322151056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322151057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = manager.ui.mainCamera.transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				local var_238_2 = arg_235_1.var_.effect1055

				if var_238_2 then
					Object.Destroy(var_238_2)

					arg_235_1.var_.effect1055 = nil
				end
			end

			local var_238_3 = 0
			local var_238_4 = 0.925

			if var_238_3 < arg_235_1.time_ and arg_235_1.time_ <= var_238_3 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_5 = arg_235_1:GetWordFromCfg(322151056)
				local var_238_6 = arg_235_1:FormatText(var_238_5.content)

				arg_235_1.text_.text = var_238_6

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 37
				local var_238_8 = utf8.len(var_238_6)
				local var_238_9 = var_238_7 <= 0 and var_238_4 or var_238_4 * (var_238_8 / var_238_7)

				if var_238_9 > 0 and var_238_4 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_3 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_3
					end
				end

				arg_235_1.text_.text = var_238_6
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_4, arg_235_1.talkMaxDuration)

			if var_238_3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_3 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_3) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_3 + var_238_10 and arg_235_1.time_ < var_238_3 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play322151057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322151057
		arg_239_1.duration_ = 10.7

		local var_239_0 = {
			zh = 5.466,
			ja = 10.7
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play322151058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1089ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1089ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -1.1, -6.17)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1089ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1089ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1089ui_story == nil then
				arg_239_1.var_.characterEffect1089ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1089ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1089ui_story then
				arg_239_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_242_15 = 0
			local var_242_16 = 0.625

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[1031].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(322151057)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 25
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151057", "story_v_out_322151.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_322151", "322151057", "story_v_out_322151.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_322151", "322151057", "story_v_out_322151.awb")

						arg_239_1:RecordAudio("322151057", var_242_24)
						arg_239_1:RecordAudio("322151057", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_322151", "322151057", "story_v_out_322151.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_322151", "322151057", "story_v_out_322151.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play322151058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322151058
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play322151059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 2

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				local var_246_1 = manager.ui.mainCamera.transform.localPosition
				local var_246_2 = Vector3.New(0, 0, 10) + Vector3.New(var_246_1.x, var_246_1.y, 0)
				local var_246_3 = arg_243_1.bgs_.ST0502

				var_246_3.transform.localPosition = var_246_2
				var_246_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_4 = var_246_3:GetComponent("SpriteRenderer")

				if var_246_4 and var_246_4.sprite then
					local var_246_5 = (var_246_3.transform.localPosition - var_246_1).z
					local var_246_6 = manager.ui.mainCameraCom_
					local var_246_7 = 2 * var_246_5 * Mathf.Tan(var_246_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_8 = var_246_7 * var_246_6.aspect
					local var_246_9 = var_246_4.sprite.bounds.size.x
					local var_246_10 = var_246_4.sprite.bounds.size.y
					local var_246_11 = var_246_8 / var_246_9
					local var_246_12 = var_246_7 / var_246_10
					local var_246_13 = var_246_12 < var_246_11 and var_246_11 or var_246_12

					var_246_3.transform.localScale = Vector3.New(var_246_13, var_246_13, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "ST0502" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_14 = 3.8

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			local var_246_15 = 0.3

			if arg_243_1.time_ >= var_246_14 + var_246_15 and arg_243_1.time_ < var_246_14 + var_246_15 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_16 = 0

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_17 = 2

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_17 then
				local var_246_18 = (arg_243_1.time_ - var_246_16) / var_246_17
				local var_246_19 = Color.New(0, 0, 0)

				var_246_19.a = Mathf.Lerp(0, 1, var_246_18)
				arg_243_1.mask_.color = var_246_19
			end

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 then
				local var_246_20 = Color.New(0, 0, 0)

				var_246_20.a = 1
				arg_243_1.mask_.color = var_246_20
			end

			local var_246_21 = 2

			if var_246_21 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_22 = 2

			if var_246_21 <= arg_243_1.time_ and arg_243_1.time_ < var_246_21 + var_246_22 then
				local var_246_23 = (arg_243_1.time_ - var_246_21) / var_246_22
				local var_246_24 = Color.New(0, 0, 0)

				var_246_24.a = Mathf.Lerp(1, 0, var_246_23)
				arg_243_1.mask_.color = var_246_24
			end

			if arg_243_1.time_ >= var_246_21 + var_246_22 and arg_243_1.time_ < var_246_21 + var_246_22 + arg_246_0 then
				local var_246_25 = Color.New(0, 0, 0)
				local var_246_26 = 0

				arg_243_1.mask_.enabled = false
				var_246_25.a = var_246_26
				arg_243_1.mask_.color = var_246_25
			end

			local var_246_27 = arg_243_1.actors_["1089ui_story"].transform
			local var_246_28 = 1.96599999815226

			if var_246_28 < arg_243_1.time_ and arg_243_1.time_ <= var_246_28 + arg_246_0 then
				arg_243_1.var_.moveOldPos1089ui_story = var_246_27.localPosition
			end

			local var_246_29 = 0.001

			if var_246_28 <= arg_243_1.time_ and arg_243_1.time_ < var_246_28 + var_246_29 then
				local var_246_30 = (arg_243_1.time_ - var_246_28) / var_246_29
				local var_246_31 = Vector3.New(0, 100, 0)

				var_246_27.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1089ui_story, var_246_31, var_246_30)

				local var_246_32 = manager.ui.mainCamera.transform.position - var_246_27.position

				var_246_27.forward = Vector3.New(var_246_32.x, var_246_32.y, var_246_32.z)

				local var_246_33 = var_246_27.localEulerAngles

				var_246_33.z = 0
				var_246_33.x = 0
				var_246_27.localEulerAngles = var_246_33
			end

			if arg_243_1.time_ >= var_246_28 + var_246_29 and arg_243_1.time_ < var_246_28 + var_246_29 + arg_246_0 then
				var_246_27.localPosition = Vector3.New(0, 100, 0)

				local var_246_34 = manager.ui.mainCamera.transform.position - var_246_27.position

				var_246_27.forward = Vector3.New(var_246_34.x, var_246_34.y, var_246_34.z)

				local var_246_35 = var_246_27.localEulerAngles

				var_246_35.z = 0
				var_246_35.x = 0
				var_246_27.localEulerAngles = var_246_35
			end

			local var_246_36 = arg_243_1.actors_["1089ui_story"]
			local var_246_37 = 1.96599999815226

			if var_246_37 < arg_243_1.time_ and arg_243_1.time_ <= var_246_37 + arg_246_0 and not isNil(var_246_36) and arg_243_1.var_.characterEffect1089ui_story == nil then
				arg_243_1.var_.characterEffect1089ui_story = var_246_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_38 = 0.034000001847744

			if var_246_37 <= arg_243_1.time_ and arg_243_1.time_ < var_246_37 + var_246_38 and not isNil(var_246_36) then
				local var_246_39 = (arg_243_1.time_ - var_246_37) / var_246_38

				if arg_243_1.var_.characterEffect1089ui_story and not isNil(var_246_36) then
					local var_246_40 = Mathf.Lerp(0, 0.5, var_246_39)

					arg_243_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1089ui_story.fillRatio = var_246_40
				end
			end

			if arg_243_1.time_ >= var_246_37 + var_246_38 and arg_243_1.time_ < var_246_37 + var_246_38 + arg_246_0 and not isNil(var_246_36) and arg_243_1.var_.characterEffect1089ui_story then
				local var_246_41 = 0.5

				arg_243_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1089ui_story.fillRatio = var_246_41
			end

			local var_246_42 = 2

			arg_243_1.isInRecall_ = false

			if var_246_42 < arg_243_1.time_ and arg_243_1.time_ <= var_246_42 + arg_246_0 then
				arg_243_1.screenFilterGo_:SetActive(false)

				for iter_246_2, iter_246_3 in pairs(arg_243_1.actors_) do
					local var_246_43 = iter_246_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_246_4, iter_246_5 in ipairs(var_246_43) do
						if iter_246_5.color.r > 0.51 then
							iter_246_5.color = Color.New(1, 1, 1)
						else
							iter_246_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_246_44 = 0.034000001847744

			if var_246_42 <= arg_243_1.time_ and arg_243_1.time_ < var_246_42 + var_246_44 then
				local var_246_45 = (arg_243_1.time_ - var_246_42) / var_246_44

				arg_243_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_246_45)
			end

			if arg_243_1.time_ >= var_246_42 + var_246_44 and arg_243_1.time_ < var_246_42 + var_246_44 + arg_246_0 then
				arg_243_1.screenFilterEffect_.weight = 0
			end

			local var_246_46 = 0.2
			local var_246_47 = 1

			if var_246_46 < arg_243_1.time_ and arg_243_1.time_ <= var_246_46 + arg_246_0 then
				local var_246_48 = "stop"
				local var_246_49 = "effect"

				arg_243_1:AudioAction(var_246_48, var_246_49, "se_story_145", "se_story_145_amb_data", "")
			end

			local var_246_50 = 1.46666666666667
			local var_246_51 = 1

			if var_246_50 < arg_243_1.time_ and arg_243_1.time_ <= var_246_50 + arg_246_0 then
				local var_246_52 = "play"
				local var_246_53 = "effect"

				arg_243_1:AudioAction(var_246_52, var_246_53, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_246_54 = 1.83333333333333

			if var_246_54 < arg_243_1.time_ and arg_243_1.time_ <= var_246_54 + arg_246_0 then
				local var_246_55 = arg_243_1.actors_["10103ui_story"]

				if not isNil(var_246_55) then
					local var_246_56 = GameObjectTools.GetOrAddComponent(var_246_55, typeof(DynamicBoneHelper))

					if var_246_56 then
						var_246_56:EnableDynamicBone(false)
					end
				end
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_57 = 4
			local var_246_58 = 0.775

			if var_246_57 < arg_243_1.time_ and arg_243_1.time_ <= var_246_57 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_59 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_59:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_60 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_61 = arg_243_1:GetWordFromCfg(322151058)
				local var_246_62 = arg_243_1:FormatText(var_246_61.content)

				arg_243_1.text_.text = var_246_62

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_63 = 31
				local var_246_64 = utf8.len(var_246_62)
				local var_246_65 = var_246_63 <= 0 and var_246_58 or var_246_58 * (var_246_64 / var_246_63)

				if var_246_65 > 0 and var_246_58 < var_246_65 then
					arg_243_1.talkMaxDuration = var_246_65
					var_246_57 = var_246_57 + 0.3

					if var_246_65 + var_246_57 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_65 + var_246_57
					end
				end

				arg_243_1.text_.text = var_246_62
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_66 = var_246_57 + 0.3
			local var_246_67 = math.max(var_246_58, arg_243_1.talkMaxDuration)

			if var_246_66 <= arg_243_1.time_ and arg_243_1.time_ < var_246_66 + var_246_67 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_66) / var_246_67

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_66 + var_246_67 and arg_243_1.time_ < var_246_66 + var_246_67 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play322151059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322151059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322151060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.55

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(322151059)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 22
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play322151060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322151060
		arg_253_1.duration_ = 8.33

		local var_253_0 = {
			zh = 5.733,
			ja = 8.333
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322151061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1020ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1020ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0, -0.85, -6.25)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1020ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1020ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1020ui_story == nil then
				arg_253_1.var_.characterEffect1020ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1020ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1020ui_story then
				arg_253_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_256_13 = 0

			if var_256_13 < arg_253_1.time_ and arg_253_1.time_ <= var_256_13 + arg_256_0 then
				arg_253_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 then
				arg_253_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_256_15 = arg_253_1.actors_["1020ui_story"]
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				if arg_253_1.var_.characterEffect1020ui_story == nil then
					arg_253_1.var_.characterEffect1020ui_story = var_256_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_256_17 = arg_253_1.var_.characterEffect1020ui_story

				var_256_17.imageEffect:turnOff()

				var_256_17.interferenceEffect.enabled = true
				var_256_17.interferenceEffect.noise = 0
				var_256_17.interferenceEffect.simTimeScale = 1
				var_256_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_256_18 = arg_253_1.actors_["1020ui_story"]
			local var_256_19 = 0
			local var_256_20 = 3.5

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 then
				if arg_253_1.var_.characterEffect1020ui_story == nil then
					arg_253_1.var_.characterEffect1020ui_story = var_256_18:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_253_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_256_21 = 0
			local var_256_22 = 0.625

			if var_256_21 < arg_253_1.time_ and arg_253_1.time_ <= var_256_21 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_23 = arg_253_1:FormatText(StoryNameCfg[613].name)

				arg_253_1.leftNameTxt_.text = var_256_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_24 = arg_253_1:GetWordFromCfg(322151060)
				local var_256_25 = arg_253_1:FormatText(var_256_24.content)

				arg_253_1.text_.text = var_256_25

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_26 = 25
				local var_256_27 = utf8.len(var_256_25)
				local var_256_28 = var_256_26 <= 0 and var_256_22 or var_256_22 * (var_256_27 / var_256_26)

				if var_256_28 > 0 and var_256_22 < var_256_28 then
					arg_253_1.talkMaxDuration = var_256_28

					if var_256_28 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_28 + var_256_21
					end
				end

				arg_253_1.text_.text = var_256_25
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151060", "story_v_out_322151.awb") ~= 0 then
					local var_256_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151060", "story_v_out_322151.awb") / 1000

					if var_256_29 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_29 + var_256_21
					end

					if var_256_24.prefab_name ~= "" and arg_253_1.actors_[var_256_24.prefab_name] ~= nil then
						local var_256_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_24.prefab_name].transform, "story_v_out_322151", "322151060", "story_v_out_322151.awb")

						arg_253_1:RecordAudio("322151060", var_256_30)
						arg_253_1:RecordAudio("322151060", var_256_30)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322151", "322151060", "story_v_out_322151.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322151", "322151060", "story_v_out_322151.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_31 = math.max(var_256_22, arg_253_1.talkMaxDuration)

			if var_256_21 <= arg_253_1.time_ and arg_253_1.time_ < var_256_21 + var_256_31 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_21) / var_256_31

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_21 + var_256_31 and arg_253_1.time_ < var_256_21 + var_256_31 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play322151061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322151061
		arg_257_1.duration_ = 8.03

		local var_257_0 = {
			zh = 6,
			ja = 8.033
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322151062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1020ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1020ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, -0.85, -6.25)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1020ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_11 = 0
			local var_260_12 = 0.725

			if var_260_11 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_13 = arg_257_1:FormatText(StoryNameCfg[613].name)

				arg_257_1.leftNameTxt_.text = var_260_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_14 = arg_257_1:GetWordFromCfg(322151061)
				local var_260_15 = arg_257_1:FormatText(var_260_14.content)

				arg_257_1.text_.text = var_260_15

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_16 = 29
				local var_260_17 = utf8.len(var_260_15)
				local var_260_18 = var_260_16 <= 0 and var_260_12 or var_260_12 * (var_260_17 / var_260_16)

				if var_260_18 > 0 and var_260_12 < var_260_18 then
					arg_257_1.talkMaxDuration = var_260_18

					if var_260_18 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_18 + var_260_11
					end
				end

				arg_257_1.text_.text = var_260_15
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151061", "story_v_out_322151.awb") ~= 0 then
					local var_260_19 = manager.audio:GetVoiceLength("story_v_out_322151", "322151061", "story_v_out_322151.awb") / 1000

					if var_260_19 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_19 + var_260_11
					end

					if var_260_14.prefab_name ~= "" and arg_257_1.actors_[var_260_14.prefab_name] ~= nil then
						local var_260_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_14.prefab_name].transform, "story_v_out_322151", "322151061", "story_v_out_322151.awb")

						arg_257_1:RecordAudio("322151061", var_260_20)
						arg_257_1:RecordAudio("322151061", var_260_20)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322151", "322151061", "story_v_out_322151.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322151", "322151061", "story_v_out_322151.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_21 = math.max(var_260_12, arg_257_1.talkMaxDuration)

			if var_260_11 <= arg_257_1.time_ and arg_257_1.time_ < var_260_11 + var_260_21 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_11) / var_260_21

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_11 + var_260_21 and arg_257_1.time_ < var_260_11 + var_260_21 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322151062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322151062
		arg_261_1.duration_ = 9

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322151063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = "MS2209"

			if arg_261_1.bgs_[var_264_0] == nil then
				local var_264_1 = Object.Instantiate(arg_261_1.paintGo_)

				var_264_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_264_0)
				var_264_1.name = var_264_0
				var_264_1.transform.parent = arg_261_1.stage_.transform
				var_264_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.bgs_[var_264_0] = var_264_1
			end

			local var_264_2 = 2

			if var_264_2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				local var_264_3 = manager.ui.mainCamera.transform.localPosition
				local var_264_4 = Vector3.New(0, 0, 10) + Vector3.New(var_264_3.x, var_264_3.y, 0)
				local var_264_5 = arg_261_1.bgs_.MS2209

				var_264_5.transform.localPosition = var_264_4
				var_264_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_6 = var_264_5:GetComponent("SpriteRenderer")

				if var_264_6 and var_264_6.sprite then
					local var_264_7 = (var_264_5.transform.localPosition - var_264_3).z
					local var_264_8 = manager.ui.mainCameraCom_
					local var_264_9 = 2 * var_264_7 * Mathf.Tan(var_264_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_264_10 = var_264_9 * var_264_8.aspect
					local var_264_11 = var_264_6.sprite.bounds.size.x
					local var_264_12 = var_264_6.sprite.bounds.size.y
					local var_264_13 = var_264_10 / var_264_11
					local var_264_14 = var_264_9 / var_264_12
					local var_264_15 = var_264_14 < var_264_13 and var_264_13 or var_264_14

					var_264_5.transform.localScale = Vector3.New(var_264_15, var_264_15, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "MS2209" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_16 = 3.999999999999

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			local var_264_17 = 0.3

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_18 = 0

			if var_264_18 < arg_261_1.time_ and arg_261_1.time_ <= var_264_18 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_19 = 2

			if var_264_18 <= arg_261_1.time_ and arg_261_1.time_ < var_264_18 + var_264_19 then
				local var_264_20 = (arg_261_1.time_ - var_264_18) / var_264_19
				local var_264_21 = Color.New(0, 0, 0)

				var_264_21.a = Mathf.Lerp(0, 1, var_264_20)
				arg_261_1.mask_.color = var_264_21
			end

			if arg_261_1.time_ >= var_264_18 + var_264_19 and arg_261_1.time_ < var_264_18 + var_264_19 + arg_264_0 then
				local var_264_22 = Color.New(0, 0, 0)

				var_264_22.a = 1
				arg_261_1.mask_.color = var_264_22
			end

			local var_264_23 = 2

			if var_264_23 < arg_261_1.time_ and arg_261_1.time_ <= var_264_23 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_24 = 2

			if var_264_23 <= arg_261_1.time_ and arg_261_1.time_ < var_264_23 + var_264_24 then
				local var_264_25 = (arg_261_1.time_ - var_264_23) / var_264_24
				local var_264_26 = Color.New(0, 0, 0)

				var_264_26.a = Mathf.Lerp(1, 0, var_264_25)
				arg_261_1.mask_.color = var_264_26
			end

			if arg_261_1.time_ >= var_264_23 + var_264_24 and arg_261_1.time_ < var_264_23 + var_264_24 + arg_264_0 then
				local var_264_27 = Color.New(0, 0, 0)
				local var_264_28 = 0

				arg_261_1.mask_.enabled = false
				var_264_27.a = var_264_28
				arg_261_1.mask_.color = var_264_27
			end

			local var_264_29 = arg_261_1.actors_["1020ui_story"].transform
			local var_264_30 = 1.96599999815226

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				arg_261_1.var_.moveOldPos1020ui_story = var_264_29.localPosition
			end

			local var_264_31 = 0.001

			if var_264_30 <= arg_261_1.time_ and arg_261_1.time_ < var_264_30 + var_264_31 then
				local var_264_32 = (arg_261_1.time_ - var_264_30) / var_264_31
				local var_264_33 = Vector3.New(0, 100, 0)

				var_264_29.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1020ui_story, var_264_33, var_264_32)

				local var_264_34 = manager.ui.mainCamera.transform.position - var_264_29.position

				var_264_29.forward = Vector3.New(var_264_34.x, var_264_34.y, var_264_34.z)

				local var_264_35 = var_264_29.localEulerAngles

				var_264_35.z = 0
				var_264_35.x = 0
				var_264_29.localEulerAngles = var_264_35
			end

			if arg_261_1.time_ >= var_264_30 + var_264_31 and arg_261_1.time_ < var_264_30 + var_264_31 + arg_264_0 then
				var_264_29.localPosition = Vector3.New(0, 100, 0)

				local var_264_36 = manager.ui.mainCamera.transform.position - var_264_29.position

				var_264_29.forward = Vector3.New(var_264_36.x, var_264_36.y, var_264_36.z)

				local var_264_37 = var_264_29.localEulerAngles

				var_264_37.z = 0
				var_264_37.x = 0
				var_264_29.localEulerAngles = var_264_37
			end

			local var_264_38 = 0.233333333333333
			local var_264_39 = 1

			if var_264_38 < arg_261_1.time_ and arg_261_1.time_ <= var_264_38 + arg_264_0 then
				local var_264_40 = "stop"
				local var_264_41 = "effect"

				arg_261_1:AudioAction(var_264_40, var_264_41, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_264_42 = 1.56666666666667
			local var_264_43 = 1

			if var_264_42 < arg_261_1.time_ and arg_261_1.time_ <= var_264_42 + arg_264_0 then
				local var_264_44 = "play"
				local var_264_45 = "effect"

				arg_261_1:AudioAction(var_264_44, var_264_45, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_264_46 = 4.4
			local var_264_47 = 1

			if var_264_46 < arg_261_1.time_ and arg_261_1.time_ <= var_264_46 + arg_264_0 then
				local var_264_48 = "play"
				local var_264_49 = "effect"

				arg_261_1:AudioAction(var_264_48, var_264_49, "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			local var_264_50 = arg_261_1.bgs_.MS2209.transform
			local var_264_51 = 2

			if var_264_51 < arg_261_1.time_ and arg_261_1.time_ <= var_264_51 + arg_264_0 then
				arg_261_1.var_.moveOldPosMS2209 = var_264_50.localPosition
			end

			local var_264_52 = 0.001

			if var_264_51 <= arg_261_1.time_ and arg_261_1.time_ < var_264_51 + var_264_52 then
				local var_264_53 = (arg_261_1.time_ - var_264_51) / var_264_52
				local var_264_54 = Vector3.New(0, 1, 10)

				var_264_50.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosMS2209, var_264_54, var_264_53)
			end

			if arg_261_1.time_ >= var_264_51 + var_264_52 and arg_261_1.time_ < var_264_51 + var_264_52 + arg_264_0 then
				var_264_50.localPosition = Vector3.New(0, 1, 10)
			end

			local var_264_55 = arg_261_1.bgs_.MS2209.transform
			local var_264_56 = 2.034

			if var_264_56 < arg_261_1.time_ and arg_261_1.time_ <= var_264_56 + arg_264_0 then
				arg_261_1.var_.moveOldPosMS2209 = var_264_55.localPosition
			end

			local var_264_57 = 1.966

			if var_264_56 <= arg_261_1.time_ and arg_261_1.time_ < var_264_56 + var_264_57 then
				local var_264_58 = (arg_261_1.time_ - var_264_56) / var_264_57
				local var_264_59 = Vector3.New(0.4, 1.5, 5)

				var_264_55.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosMS2209, var_264_59, var_264_58)
			end

			if arg_261_1.time_ >= var_264_56 + var_264_57 and arg_261_1.time_ < var_264_56 + var_264_57 + arg_264_0 then
				var_264_55.localPosition = Vector3.New(0.4, 1.5, 5)
			end

			local var_264_60 = arg_261_1.actors_["1020ui_story"]
			local var_264_61 = 2

			if var_264_61 < arg_261_1.time_ and arg_261_1.time_ <= var_264_61 + arg_264_0 then
				if arg_261_1.var_.characterEffect1020ui_story == nil then
					arg_261_1.var_.characterEffect1020ui_story = var_264_60:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_264_62 = arg_261_1.var_.characterEffect1020ui_story

				var_264_62.imageEffect:turnOff()

				var_264_62.interferenceEffect.enabled = false
				var_264_62.interferenceEffect.noise = 0
				var_264_62.interferenceEffect.simTimeScale = 1
				var_264_62.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_264_63 = arg_261_1.actors_["1020ui_story"]
			local var_264_64 = 2
			local var_264_65 = 0.0166666666666667

			if var_264_64 < arg_261_1.time_ and arg_261_1.time_ <= var_264_64 + arg_264_0 then
				if arg_261_1.var_.characterEffect1020ui_story == nil then
					arg_261_1.var_.characterEffect1020ui_story = var_264_63:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_261_1.var_.characterEffect1020ui_story.imageEffect:turnOff()
			end

			local var_264_66 = 0
			local var_264_67 = 0.3

			if var_264_66 < arg_261_1.time_ and arg_261_1.time_ <= var_264_66 + arg_264_0 then
				local var_264_68 = "play"
				local var_264_69 = "music"

				arg_261_1:AudioAction(var_264_68, var_264_69, "ui_battle", "ui_battle_stopbgm", "")

				local var_264_70 = ""
				local var_264_71 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_264_71 ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_71 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_71

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_71
						arg_261_1.bgmTxt2_.text = var_264_71
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_264_72 = 0.566666666666667
			local var_264_73 = 1

			if var_264_72 < arg_261_1.time_ and arg_261_1.time_ <= var_264_72 + arg_264_0 then
				local var_264_74 = "play"
				local var_264_75 = "music"

				arg_261_1:AudioAction(var_264_74, var_264_75, "bgm_activity_4_5_story_MS2209", "bgm_activity_4_5_story_MS2209", "bgm_activity_4_5_story_MS2209.awb")

				local var_264_76 = ""
				local var_264_77 = manager.audio:GetAudioName("bgm_activity_4_5_story_MS2209", "bgm_activity_4_5_story_MS2209")

				if var_264_77 ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_77 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_77

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_77
						arg_261_1.bgmTxt2_.text = var_264_77
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_78 = 3.999999999999
			local var_264_79 = 1.025

			if var_264_78 < arg_261_1.time_ and arg_261_1.time_ <= var_264_78 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_80 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_80:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_261_1.dialogCg_.alpha = arg_267_0
				end))
				var_264_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_81 = arg_261_1:GetWordFromCfg(322151062)
				local var_264_82 = arg_261_1:FormatText(var_264_81.content)

				arg_261_1.text_.text = var_264_82

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_83 = 41
				local var_264_84 = utf8.len(var_264_82)
				local var_264_85 = var_264_83 <= 0 and var_264_79 or var_264_79 * (var_264_84 / var_264_83)

				if var_264_85 > 0 and var_264_79 < var_264_85 then
					arg_261_1.talkMaxDuration = var_264_85
					var_264_78 = var_264_78 + 0.3

					if var_264_85 + var_264_78 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_85 + var_264_78
					end
				end

				arg_261_1.text_.text = var_264_82
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_86 = var_264_78 + 0.3
			local var_264_87 = math.max(var_264_79, arg_261_1.talkMaxDuration)

			if var_264_86 <= arg_261_1.time_ and arg_261_1.time_ < var_264_86 + var_264_87 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_86) / var_264_87

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_86 + var_264_87 and arg_261_1.time_ < var_264_86 + var_264_87 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "MS2209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.966,
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.4, 1, 6),
					endPos = Vector3.New(0.4, 1.5, 5),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play322151063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322151063
		arg_269_1.duration_ = 3.57

		local var_269_0 = {
			zh = 1.866,
			ja = 3.566
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322151064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.2

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[613].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(322151063)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 8
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151063", "story_v_out_322151.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151063", "story_v_out_322151.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_322151", "322151063", "story_v_out_322151.awb")

						arg_269_1:RecordAudio("322151063", var_272_9)
						arg_269_1:RecordAudio("322151063", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322151", "322151063", "story_v_out_322151.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322151", "322151063", "story_v_out_322151.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322151064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322151064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322151065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.7

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(322151064)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 28
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_8 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_8 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_8

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_8 and arg_273_1.time_ < var_276_0 + var_276_8 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322151065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322151065
		arg_277_1.duration_ = 8.97

		local var_277_0 = {
			zh = 7.533,
			ja = 8.966
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322151066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.7

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[613].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:GetWordFromCfg(322151065)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 28
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151065", "story_v_out_322151.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151065", "story_v_out_322151.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_322151", "322151065", "story_v_out_322151.awb")

						arg_277_1:RecordAudio("322151065", var_280_9)
						arg_277_1:RecordAudio("322151065", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322151", "322151065", "story_v_out_322151.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322151", "322151065", "story_v_out_322151.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322151066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322151066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322151067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.4

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(322151066)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 16
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322151067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322151067
		arg_285_1.duration_ = 8

		local var_285_0 = {
			zh = 7.633,
			ja = 8
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322151068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 1.025

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[613].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:GetWordFromCfg(322151067)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 41
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151067", "story_v_out_322151.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151067", "story_v_out_322151.awb") / 1000

					if var_288_8 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_0
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_322151", "322151067", "story_v_out_322151.awb")

						arg_285_1:RecordAudio("322151067", var_288_9)
						arg_285_1:RecordAudio("322151067", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322151", "322151067", "story_v_out_322151.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322151", "322151067", "story_v_out_322151.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_10 and arg_285_1.time_ < var_288_0 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322151068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322151068
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322151069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.275

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:GetWordFromCfg(322151068)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 11
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322151069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322151069
		arg_293_1.duration_ = 6.1

		local var_293_0 = {
			zh = 6.1,
			ja = 5.7
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322151070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.7

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[613].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:GetWordFromCfg(322151069)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 28
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151069", "story_v_out_322151.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151069", "story_v_out_322151.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_322151", "322151069", "story_v_out_322151.awb")

						arg_293_1:RecordAudio("322151069", var_296_9)
						arg_293_1:RecordAudio("322151069", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322151", "322151069", "story_v_out_322151.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322151", "322151069", "story_v_out_322151.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_10 and arg_293_1.time_ < var_296_0 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322151070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322151070
		arg_297_1.duration_ = 11.7

		local var_297_0 = {
			zh = 8.4,
			ja = 11.7
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322151071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.025

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[613].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:GetWordFromCfg(322151070)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 41
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151070", "story_v_out_322151.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151070", "story_v_out_322151.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_322151", "322151070", "story_v_out_322151.awb")

						arg_297_1:RecordAudio("322151070", var_300_9)
						arg_297_1:RecordAudio("322151070", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322151", "322151070", "story_v_out_322151.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322151", "322151070", "story_v_out_322151.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play322151071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322151071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322151072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.275

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(322151071)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 11
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play322151072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322151072
		arg_305_1.duration_ = 6.43

		local var_305_0 = {
			zh = 5.866,
			ja = 6.433
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play322151073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.55

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[613].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(322151072)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 22
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151072", "story_v_out_322151.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151072", "story_v_out_322151.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_322151", "322151072", "story_v_out_322151.awb")

						arg_305_1:RecordAudio("322151072", var_308_9)
						arg_305_1:RecordAudio("322151072", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322151", "322151072", "story_v_out_322151.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322151", "322151072", "story_v_out_322151.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play322151073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322151073
		arg_309_1.duration_ = 8.23

		local var_309_0 = {
			zh = 7.466,
			ja = 8.233
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322151074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.775

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[613].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:GetWordFromCfg(322151073)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 31
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151073", "story_v_out_322151.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151073", "story_v_out_322151.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_322151", "322151073", "story_v_out_322151.awb")

						arg_309_1:RecordAudio("322151073", var_312_9)
						arg_309_1:RecordAudio("322151073", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_322151", "322151073", "story_v_out_322151.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_322151", "322151073", "story_v_out_322151.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322151074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322151074
		arg_313_1.duration_ = 15.5

		local var_313_0 = {
			zh = 6.966,
			ja = 15.5
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322151075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.775

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[613].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:GetWordFromCfg(322151074)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 31
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151074", "story_v_out_322151.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151074", "story_v_out_322151.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_322151", "322151074", "story_v_out_322151.awb")

						arg_313_1:RecordAudio("322151074", var_316_9)
						arg_313_1:RecordAudio("322151074", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322151", "322151074", "story_v_out_322151.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322151", "322151074", "story_v_out_322151.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play322151075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322151075
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322151076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.65

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:GetWordFromCfg(322151075)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 26
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_8 and arg_317_1.time_ < var_320_0 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play322151076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322151076
		arg_321_1.duration_ = 5.17

		local var_321_0 = {
			zh = 3.833,
			ja = 5.166
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322151077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.4

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[613].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(322151076)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 16
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151076", "story_v_out_322151.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151076", "story_v_out_322151.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_322151", "322151076", "story_v_out_322151.awb")

						arg_321_1:RecordAudio("322151076", var_324_9)
						arg_321_1:RecordAudio("322151076", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322151", "322151076", "story_v_out_322151.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322151", "322151076", "story_v_out_322151.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play322151077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322151077
		arg_325_1.duration_ = 6

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322151078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.bgs_.MS2209.transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPosMS2209 = var_328_0.localPosition
			end

			local var_328_2 = 1

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, 1, 10)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPosMS2209, var_328_4, var_328_3)
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			local var_328_6 = 2.85833333333333

			if arg_325_1.time_ >= var_328_5 + var_328_6 and arg_325_1.time_ < var_328_5 + var_328_6 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_7 = 1
			local var_328_8 = 1.175

			if var_328_7 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_9 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_9:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_10 = arg_325_1:GetWordFromCfg(322151077)
				local var_328_11 = arg_325_1:FormatText(var_328_10.content)

				arg_325_1.text_.text = var_328_11

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_12 = 47
				local var_328_13 = utf8.len(var_328_11)
				local var_328_14 = var_328_12 <= 0 and var_328_8 or var_328_8 * (var_328_13 / var_328_12)

				if var_328_14 > 0 and var_328_8 < var_328_14 then
					arg_325_1.talkMaxDuration = var_328_14
					var_328_7 = var_328_7 + 0.3

					if var_328_14 + var_328_7 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_7
					end
				end

				arg_325_1.text_.text = var_328_11
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_15 = var_328_7 + 0.3
			local var_328_16 = math.max(var_328_8, arg_325_1.talkMaxDuration)

			if var_328_15 <= arg_325_1.time_ and arg_325_1.time_ < var_328_15 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_15) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_15 + var_328_16 and arg_325_1.time_ < var_328_15 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play322151078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 322151078
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play322151079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.775

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[7].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:GetWordFromCfg(322151078)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 31
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_1 or var_334_1 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_1 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_8 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_8 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_8

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_8 and arg_331_1.time_ < var_334_0 + var_334_8 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play322151079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 322151079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play322151080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 1

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[7].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_3 = arg_335_1:GetWordFromCfg(322151079)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 40
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_8 and arg_335_1.time_ < var_338_0 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play322151080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 322151080
		arg_339_1.duration_ = 7

		local var_339_0 = {
			zh = 5.466,
			ja = 7
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play322151081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.55

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[613].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_3 = arg_339_1:GetWordFromCfg(322151080)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 22
				local var_342_6 = utf8.len(var_342_4)
				local var_342_7 = var_342_5 <= 0 and var_342_1 or var_342_1 * (var_342_6 / var_342_5)

				if var_342_7 > 0 and var_342_1 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151080", "story_v_out_322151.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151080", "story_v_out_322151.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_322151", "322151080", "story_v_out_322151.awb")

						arg_339_1:RecordAudio("322151080", var_342_9)
						arg_339_1:RecordAudio("322151080", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_322151", "322151080", "story_v_out_322151.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_322151", "322151080", "story_v_out_322151.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_10 and arg_339_1.time_ < var_342_0 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play322151081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 322151081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play322151082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.3

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[7].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(322151081)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 12
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_8 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_8 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_8

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_8 and arg_343_1.time_ < var_346_0 + var_346_8 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play322151082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 322151082
		arg_347_1.duration_ = 3.53

		local var_347_0 = {
			zh = 1.5,
			ja = 3.533
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play322151083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.175

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[613].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:GetWordFromCfg(322151082)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 7
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151082", "story_v_out_322151.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151082", "story_v_out_322151.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_322151", "322151082", "story_v_out_322151.awb")

						arg_347_1:RecordAudio("322151082", var_350_9)
						arg_347_1:RecordAudio("322151082", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_322151", "322151082", "story_v_out_322151.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_322151", "322151082", "story_v_out_322151.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play322151083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 322151083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play322151084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.675

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[7].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_3 = arg_351_1:GetWordFromCfg(322151083)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 27
				local var_354_6 = utf8.len(var_354_4)
				local var_354_7 = var_354_5 <= 0 and var_354_1 or var_354_1 * (var_354_6 / var_354_5)

				if var_354_7 > 0 and var_354_1 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_8 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_8 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_8

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_8 and arg_351_1.time_ < var_354_0 + var_354_8 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play322151084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 322151084
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play322151085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 0.975

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_2 = arg_355_1:FormatText(StoryNameCfg[7].name)

				arg_355_1.leftNameTxt_.text = var_358_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:GetWordFromCfg(322151084)
				local var_358_4 = arg_355_1:FormatText(var_358_3.content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 39
				local var_358_6 = utf8.len(var_358_4)
				local var_358_7 = var_358_5 <= 0 and var_358_1 or var_358_1 * (var_358_6 / var_358_5)

				if var_358_7 > 0 and var_358_1 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_8 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_8 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_8

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_8 and arg_355_1.time_ < var_358_0 + var_358_8 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play322151085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 322151085
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play322151086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.85

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[7].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:GetWordFromCfg(322151085)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 34
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_8 and arg_359_1.time_ < var_362_0 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play322151086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 322151086
		arg_363_1.duration_ = 6.43

		local var_363_0 = {
			zh = 4.166,
			ja = 6.433
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play322151087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.625

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[613].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_3 = arg_363_1:GetWordFromCfg(322151086)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 25
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151086", "story_v_out_322151.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151086", "story_v_out_322151.awb") / 1000

					if var_366_8 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_0
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_322151", "322151086", "story_v_out_322151.awb")

						arg_363_1:RecordAudio("322151086", var_366_9)
						arg_363_1:RecordAudio("322151086", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_322151", "322151086", "story_v_out_322151.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_322151", "322151086", "story_v_out_322151.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_10 and arg_363_1.time_ < var_366_0 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play322151087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 322151087
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play322151088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.225

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_3 = arg_367_1:GetWordFromCfg(322151087)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 9
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play322151088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 322151088
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play322151089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 1.275

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[7].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_3 = arg_371_1:GetWordFromCfg(322151088)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 51
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_1 or var_374_1 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_1 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_8 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_8 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_8

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_8 and arg_371_1.time_ < var_374_0 + var_374_8 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play322151089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 322151089
		arg_375_1.duration_ = 10.2

		local var_375_0 = {
			zh = 7.366,
			ja = 10.2
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play322151090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 0.725

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[613].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_3 = arg_375_1:GetWordFromCfg(322151089)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 29
				local var_378_6 = utf8.len(var_378_4)
				local var_378_7 = var_378_5 <= 0 and var_378_1 or var_378_1 * (var_378_6 / var_378_5)

				if var_378_7 > 0 and var_378_1 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151089", "story_v_out_322151.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151089", "story_v_out_322151.awb") / 1000

					if var_378_8 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_0
					end

					if var_378_3.prefab_name ~= "" and arg_375_1.actors_[var_378_3.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_3.prefab_name].transform, "story_v_out_322151", "322151089", "story_v_out_322151.awb")

						arg_375_1:RecordAudio("322151089", var_378_9)
						arg_375_1:RecordAudio("322151089", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_322151", "322151089", "story_v_out_322151.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_322151", "322151089", "story_v_out_322151.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_10 and arg_375_1.time_ < var_378_0 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play322151090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 322151090
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play322151091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.35

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_3 = arg_379_1:GetWordFromCfg(322151090)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 14
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play322151091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 322151091
		arg_383_1.duration_ = 4.43

		local var_383_0 = {
			zh = 1.966,
			ja = 4.433
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play322151092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 0.275

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[613].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:GetWordFromCfg(322151091)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 11
				local var_386_6 = utf8.len(var_386_4)
				local var_386_7 = var_386_5 <= 0 and var_386_1 or var_386_1 * (var_386_6 / var_386_5)

				if var_386_7 > 0 and var_386_1 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151091", "story_v_out_322151.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151091", "story_v_out_322151.awb") / 1000

					if var_386_8 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_0
					end

					if var_386_3.prefab_name ~= "" and arg_383_1.actors_[var_386_3.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_3.prefab_name].transform, "story_v_out_322151", "322151091", "story_v_out_322151.awb")

						arg_383_1:RecordAudio("322151091", var_386_9)
						arg_383_1:RecordAudio("322151091", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_322151", "322151091", "story_v_out_322151.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_322151", "322151091", "story_v_out_322151.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_10 and arg_383_1.time_ < var_386_0 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play322151092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 322151092
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play322151093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 1.1

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_3 = arg_387_1:GetWordFromCfg(322151092)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 44
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play322151093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 322151093
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play322151094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 1.65

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[7].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:GetWordFromCfg(322151093)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 66
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_8 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_8 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_8

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_8 and arg_391_1.time_ < var_394_0 + var_394_8 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play322151094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 322151094
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play322151095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 1.15

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[7].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_3 = arg_395_1:GetWordFromCfg(322151094)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 46
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_8 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_8 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_8

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_8 and arg_395_1.time_ < var_398_0 + var_398_8 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play322151095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 322151095
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play322151096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.925

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[7].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:GetWordFromCfg(322151095)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 37
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_8 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_8 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_8

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_8 and arg_399_1.time_ < var_402_0 + var_402_8 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play322151096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 322151096
		arg_403_1.duration_ = 10.7

		local var_403_0 = {
			zh = 8.366,
			ja = 10.7
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play322151097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = "ST0504"

			if arg_403_1.bgs_[var_406_0] == nil then
				local var_406_1 = Object.Instantiate(arg_403_1.paintGo_)

				var_406_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_406_0)
				var_406_1.name = var_406_0
				var_406_1.transform.parent = arg_403_1.stage_.transform
				var_406_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.bgs_[var_406_0] = var_406_1
			end

			local var_406_2 = 2.00000000298023

			if var_406_2 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				local var_406_3 = manager.ui.mainCamera.transform.localPosition
				local var_406_4 = Vector3.New(0, 0, 10) + Vector3.New(var_406_3.x, var_406_3.y, 0)
				local var_406_5 = arg_403_1.bgs_.ST0504

				var_406_5.transform.localPosition = var_406_4
				var_406_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_406_6 = var_406_5:GetComponent("SpriteRenderer")

				if var_406_6 and var_406_6.sprite then
					local var_406_7 = (var_406_5.transform.localPosition - var_406_3).z
					local var_406_8 = manager.ui.mainCameraCom_
					local var_406_9 = 2 * var_406_7 * Mathf.Tan(var_406_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_406_10 = var_406_9 * var_406_8.aspect
					local var_406_11 = var_406_6.sprite.bounds.size.x
					local var_406_12 = var_406_6.sprite.bounds.size.y
					local var_406_13 = var_406_10 / var_406_11
					local var_406_14 = var_406_9 / var_406_12
					local var_406_15 = var_406_14 < var_406_13 and var_406_13 or var_406_14

					var_406_5.transform.localScale = Vector3.New(var_406_15, var_406_15, 0)
				end

				for iter_406_0, iter_406_1 in pairs(arg_403_1.bgs_) do
					if iter_406_0 ~= "ST0504" then
						iter_406_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_406_16 = 0

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_17 = 2

			if var_406_16 <= arg_403_1.time_ and arg_403_1.time_ < var_406_16 + var_406_17 then
				local var_406_18 = (arg_403_1.time_ - var_406_16) / var_406_17
				local var_406_19 = Color.New(0, 0, 0)

				var_406_19.a = Mathf.Lerp(0, 1, var_406_18)
				arg_403_1.mask_.color = var_406_19
			end

			if arg_403_1.time_ >= var_406_16 + var_406_17 and arg_403_1.time_ < var_406_16 + var_406_17 + arg_406_0 then
				local var_406_20 = Color.New(0, 0, 0)

				var_406_20.a = 1
				arg_403_1.mask_.color = var_406_20
			end

			local var_406_21 = 2

			if var_406_21 < arg_403_1.time_ and arg_403_1.time_ <= var_406_21 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_22 = 2

			if var_406_21 <= arg_403_1.time_ and arg_403_1.time_ < var_406_21 + var_406_22 then
				local var_406_23 = (arg_403_1.time_ - var_406_21) / var_406_22
				local var_406_24 = Color.New(0, 0, 0)

				var_406_24.a = Mathf.Lerp(1, 0, var_406_23)
				arg_403_1.mask_.color = var_406_24
			end

			if arg_403_1.time_ >= var_406_21 + var_406_22 and arg_403_1.time_ < var_406_21 + var_406_22 + arg_406_0 then
				local var_406_25 = Color.New(0, 0, 0)
				local var_406_26 = 0

				arg_403_1.mask_.enabled = false
				var_406_25.a = var_406_26
				arg_403_1.mask_.color = var_406_25
			end

			local var_406_27 = arg_403_1.actors_["1020ui_story"].transform
			local var_406_28 = 1.96599999815226

			if var_406_28 < arg_403_1.time_ and arg_403_1.time_ <= var_406_28 + arg_406_0 then
				arg_403_1.var_.moveOldPos1020ui_story = var_406_27.localPosition
			end

			local var_406_29 = 0.001

			if var_406_28 <= arg_403_1.time_ and arg_403_1.time_ < var_406_28 + var_406_29 then
				local var_406_30 = (arg_403_1.time_ - var_406_28) / var_406_29
				local var_406_31 = Vector3.New(0, 100, 0)

				var_406_27.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1020ui_story, var_406_31, var_406_30)

				local var_406_32 = manager.ui.mainCamera.transform.position - var_406_27.position

				var_406_27.forward = Vector3.New(var_406_32.x, var_406_32.y, var_406_32.z)

				local var_406_33 = var_406_27.localEulerAngles

				var_406_33.z = 0
				var_406_33.x = 0
				var_406_27.localEulerAngles = var_406_33
			end

			if arg_403_1.time_ >= var_406_28 + var_406_29 and arg_403_1.time_ < var_406_28 + var_406_29 + arg_406_0 then
				var_406_27.localPosition = Vector3.New(0, 100, 0)

				local var_406_34 = manager.ui.mainCamera.transform.position - var_406_27.position

				var_406_27.forward = Vector3.New(var_406_34.x, var_406_34.y, var_406_34.z)

				local var_406_35 = var_406_27.localEulerAngles

				var_406_35.z = 0
				var_406_35.x = 0
				var_406_27.localEulerAngles = var_406_35
			end

			local var_406_36 = "1029ui_story"

			if arg_403_1.actors_[var_406_36] == nil then
				local var_406_37 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_406_37) then
					local var_406_38 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_403_1.stage_.transform)

					var_406_38.name = var_406_36
					var_406_38.transform.localPosition = Vector3.New(0, 100, 0)
					arg_403_1.actors_[var_406_36] = var_406_38

					local var_406_39 = var_406_38:GetComponentInChildren(typeof(CharacterEffect))

					var_406_39.enabled = true

					local var_406_40 = GameObjectTools.GetOrAddComponent(var_406_38, typeof(DynamicBoneHelper))

					if var_406_40 then
						var_406_40:EnableDynamicBone(false)
					end

					arg_403_1:ShowWeapon(var_406_39.transform, false)

					arg_403_1.var_[var_406_36 .. "Animator"] = var_406_39.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_403_1.var_[var_406_36 .. "Animator"].applyRootMotion = true
					arg_403_1.var_[var_406_36 .. "LipSync"] = var_406_39.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_406_41 = arg_403_1.actors_["1029ui_story"].transform
			local var_406_42 = 3.8

			if var_406_42 < arg_403_1.time_ and arg_403_1.time_ <= var_406_42 + arg_406_0 then
				arg_403_1.var_.moveOldPos1029ui_story = var_406_41.localPosition
			end

			local var_406_43 = 0.001

			if var_406_42 <= arg_403_1.time_ and arg_403_1.time_ < var_406_42 + var_406_43 then
				local var_406_44 = (arg_403_1.time_ - var_406_42) / var_406_43
				local var_406_45 = Vector3.New(0, -1.09, -6.2)

				var_406_41.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1029ui_story, var_406_45, var_406_44)

				local var_406_46 = manager.ui.mainCamera.transform.position - var_406_41.position

				var_406_41.forward = Vector3.New(var_406_46.x, var_406_46.y, var_406_46.z)

				local var_406_47 = var_406_41.localEulerAngles

				var_406_47.z = 0
				var_406_47.x = 0
				var_406_41.localEulerAngles = var_406_47
			end

			if arg_403_1.time_ >= var_406_42 + var_406_43 and arg_403_1.time_ < var_406_42 + var_406_43 + arg_406_0 then
				var_406_41.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_406_48 = manager.ui.mainCamera.transform.position - var_406_41.position

				var_406_41.forward = Vector3.New(var_406_48.x, var_406_48.y, var_406_48.z)

				local var_406_49 = var_406_41.localEulerAngles

				var_406_49.z = 0
				var_406_49.x = 0
				var_406_41.localEulerAngles = var_406_49
			end

			local var_406_50 = arg_403_1.actors_["1029ui_story"]
			local var_406_51 = 3.8

			if var_406_51 < arg_403_1.time_ and arg_403_1.time_ <= var_406_51 + arg_406_0 and not isNil(var_406_50) and arg_403_1.var_.characterEffect1029ui_story == nil then
				arg_403_1.var_.characterEffect1029ui_story = var_406_50:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_52 = 0.200000002980232

			if var_406_51 <= arg_403_1.time_ and arg_403_1.time_ < var_406_51 + var_406_52 and not isNil(var_406_50) then
				local var_406_53 = (arg_403_1.time_ - var_406_51) / var_406_52

				if arg_403_1.var_.characterEffect1029ui_story and not isNil(var_406_50) then
					arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_51 + var_406_52 and arg_403_1.time_ < var_406_51 + var_406_52 + arg_406_0 and not isNil(var_406_50) and arg_403_1.var_.characterEffect1029ui_story then
				arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_406_54 = 3.8

			if var_406_54 < arg_403_1.time_ and arg_403_1.time_ <= var_406_54 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_406_55 = 3.8

			if var_406_55 < arg_403_1.time_ and arg_403_1.time_ <= var_406_55 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_406_56 = 2.00000000298023

			arg_403_1.isInRecall_ = false

			if var_406_56 < arg_403_1.time_ and arg_403_1.time_ <= var_406_56 + arg_406_0 then
				arg_403_1.screenFilterGo_:SetActive(true)

				arg_403_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_406_2, iter_406_3 in pairs(arg_403_1.actors_) do
					local var_406_57 = iter_406_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_406_4, iter_406_5 in ipairs(var_406_57) do
						if iter_406_5.color.r > 0.51 then
							iter_406_5.color = Color.New(1, 1, 1)
						else
							iter_406_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_406_58 = 0.0166666666666667

			if var_406_56 <= arg_403_1.time_ and arg_403_1.time_ < var_406_56 + var_406_58 then
				local var_406_59 = (arg_403_1.time_ - var_406_56) / var_406_58

				arg_403_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_406_59)
			end

			if arg_403_1.time_ >= var_406_56 + var_406_58 and arg_403_1.time_ < var_406_56 + var_406_58 + arg_406_0 then
				arg_403_1.screenFilterEffect_.weight = 1
			end

			local var_406_60 = 0.3
			local var_406_61 = 1

			if var_406_60 < arg_403_1.time_ and arg_403_1.time_ <= var_406_60 + arg_406_0 then
				local var_406_62 = "stop"
				local var_406_63 = "effect"

				arg_403_1:AudioAction(var_406_62, var_406_63, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_406_64 = 1.56666666666667
			local var_406_65 = 1

			if var_406_64 < arg_403_1.time_ and arg_403_1.time_ <= var_406_64 + arg_406_0 then
				local var_406_66 = "play"
				local var_406_67 = "effect"

				arg_403_1:AudioAction(var_406_66, var_406_67, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_403_1.frameCnt_ <= 1 then
				arg_403_1.dialog_:SetActive(false)
			end

			local var_406_68 = 4
			local var_406_69 = 0.375

			if var_406_68 < arg_403_1.time_ and arg_403_1.time_ <= var_406_68 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				arg_403_1.dialog_:SetActive(true)

				arg_403_1.dialogCg_.alpha = 0

				local var_406_70 = LeanTween.value(arg_403_1.dialog_, 0, 1, 0.3)

				var_406_70:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_403_1.dialogCg_.alpha = arg_407_0
				end))
				var_406_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_403_1.dialog_)
					var_406_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_403_1.duration_ = arg_403_1.duration_ + 0.3

				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_71 = arg_403_1:FormatText(StoryNameCfg[319].name)

				arg_403_1.leftNameTxt_.text = var_406_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_72 = arg_403_1:GetWordFromCfg(322151096)
				local var_406_73 = arg_403_1:FormatText(var_406_72.content)

				arg_403_1.text_.text = var_406_73

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_74 = 15
				local var_406_75 = utf8.len(var_406_73)
				local var_406_76 = var_406_74 <= 0 and var_406_69 or var_406_69 * (var_406_75 / var_406_74)

				if var_406_76 > 0 and var_406_69 < var_406_76 then
					arg_403_1.talkMaxDuration = var_406_76
					var_406_68 = var_406_68 + 0.3

					if var_406_76 + var_406_68 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_76 + var_406_68
					end
				end

				arg_403_1.text_.text = var_406_73
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151096", "story_v_out_322151.awb") ~= 0 then
					local var_406_77 = manager.audio:GetVoiceLength("story_v_out_322151", "322151096", "story_v_out_322151.awb") / 1000

					if var_406_77 + var_406_68 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_77 + var_406_68
					end

					if var_406_72.prefab_name ~= "" and arg_403_1.actors_[var_406_72.prefab_name] ~= nil then
						local var_406_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_72.prefab_name].transform, "story_v_out_322151", "322151096", "story_v_out_322151.awb")

						arg_403_1:RecordAudio("322151096", var_406_78)
						arg_403_1:RecordAudio("322151096", var_406_78)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_322151", "322151096", "story_v_out_322151.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_322151", "322151096", "story_v_out_322151.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_79 = var_406_68 + 0.3
			local var_406_80 = math.max(var_406_69, arg_403_1.talkMaxDuration)

			if var_406_79 <= arg_403_1.time_ and arg_403_1.time_ < var_406_79 + var_406_80 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_79) / var_406_80

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_79 + var_406_80 and arg_403_1.time_ < var_406_79 + var_406_80 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play322151097 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 322151097
		arg_409_1.duration_ = 5

		local var_409_0 = {
			zh = 3.8,
			ja = 5
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play322151098(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1029ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1029ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, -1.09, -6.2)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1029ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = 0

			if var_412_9 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_412_10 = 0
			local var_412_11 = 0.475

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_12 = arg_409_1:FormatText(StoryNameCfg[319].name)

				arg_409_1.leftNameTxt_.text = var_412_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_13 = arg_409_1:GetWordFromCfg(322151097)
				local var_412_14 = arg_409_1:FormatText(var_412_13.content)

				arg_409_1.text_.text = var_412_14

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_15 = 19
				local var_412_16 = utf8.len(var_412_14)
				local var_412_17 = var_412_15 <= 0 and var_412_11 or var_412_11 * (var_412_16 / var_412_15)

				if var_412_17 > 0 and var_412_11 < var_412_17 then
					arg_409_1.talkMaxDuration = var_412_17

					if var_412_17 + var_412_10 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_17 + var_412_10
					end
				end

				arg_409_1.text_.text = var_412_14
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151097", "story_v_out_322151.awb") ~= 0 then
					local var_412_18 = manager.audio:GetVoiceLength("story_v_out_322151", "322151097", "story_v_out_322151.awb") / 1000

					if var_412_18 + var_412_10 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_18 + var_412_10
					end

					if var_412_13.prefab_name ~= "" and arg_409_1.actors_[var_412_13.prefab_name] ~= nil then
						local var_412_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_13.prefab_name].transform, "story_v_out_322151", "322151097", "story_v_out_322151.awb")

						arg_409_1:RecordAudio("322151097", var_412_19)
						arg_409_1:RecordAudio("322151097", var_412_19)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_322151", "322151097", "story_v_out_322151.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_322151", "322151097", "story_v_out_322151.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_20 = math.max(var_412_11, arg_409_1.talkMaxDuration)

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_20 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_10) / var_412_20

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_10 + var_412_20 and arg_409_1.time_ < var_412_10 + var_412_20 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play322151098 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 322151098
		arg_413_1.duration_ = 7.2

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play322151099(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 2.00000000298023

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				local var_416_1 = manager.ui.mainCamera.transform.localPosition
				local var_416_2 = Vector3.New(0, 0, 10) + Vector3.New(var_416_1.x, var_416_1.y, 0)
				local var_416_3 = arg_413_1.bgs_.MS2209

				var_416_3.transform.localPosition = var_416_2
				var_416_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_416_4 = var_416_3:GetComponent("SpriteRenderer")

				if var_416_4 and var_416_4.sprite then
					local var_416_5 = (var_416_3.transform.localPosition - var_416_1).z
					local var_416_6 = manager.ui.mainCameraCom_
					local var_416_7 = 2 * var_416_5 * Mathf.Tan(var_416_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_416_8 = var_416_7 * var_416_6.aspect
					local var_416_9 = var_416_4.sprite.bounds.size.x
					local var_416_10 = var_416_4.sprite.bounds.size.y
					local var_416_11 = var_416_8 / var_416_9
					local var_416_12 = var_416_7 / var_416_10
					local var_416_13 = var_416_12 < var_416_11 and var_416_11 or var_416_12

					var_416_3.transform.localScale = Vector3.New(var_416_13, var_416_13, 0)
				end

				for iter_416_0, iter_416_1 in pairs(arg_413_1.bgs_) do
					if iter_416_0 ~= "MS2209" then
						iter_416_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_416_14 = 4.00000000298023

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			local var_416_15 = 0.3

			if arg_413_1.time_ >= var_416_14 + var_416_15 and arg_413_1.time_ < var_416_14 + var_416_15 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end

			local var_416_16 = 0

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_17 = 2

			if var_416_16 <= arg_413_1.time_ and arg_413_1.time_ < var_416_16 + var_416_17 then
				local var_416_18 = (arg_413_1.time_ - var_416_16) / var_416_17
				local var_416_19 = Color.New(0, 0, 0)

				var_416_19.a = Mathf.Lerp(0, 1, var_416_18)
				arg_413_1.mask_.color = var_416_19
			end

			if arg_413_1.time_ >= var_416_16 + var_416_17 and arg_413_1.time_ < var_416_16 + var_416_17 + arg_416_0 then
				local var_416_20 = Color.New(0, 0, 0)

				var_416_20.a = 1
				arg_413_1.mask_.color = var_416_20
			end

			local var_416_21 = 2.00000000298023

			if var_416_21 < arg_413_1.time_ and arg_413_1.time_ <= var_416_21 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_22 = 2

			if var_416_21 <= arg_413_1.time_ and arg_413_1.time_ < var_416_21 + var_416_22 then
				local var_416_23 = (arg_413_1.time_ - var_416_21) / var_416_22
				local var_416_24 = Color.New(0, 0, 0)

				var_416_24.a = Mathf.Lerp(1, 0, var_416_23)
				arg_413_1.mask_.color = var_416_24
			end

			if arg_413_1.time_ >= var_416_21 + var_416_22 and arg_413_1.time_ < var_416_21 + var_416_22 + arg_416_0 then
				local var_416_25 = Color.New(0, 0, 0)
				local var_416_26 = 0

				arg_413_1.mask_.enabled = false
				var_416_25.a = var_416_26
				arg_413_1.mask_.color = var_416_25
			end

			local var_416_27 = arg_413_1.actors_["1029ui_story"].transform
			local var_416_28 = 1.96599999815226

			if var_416_28 < arg_413_1.time_ and arg_413_1.time_ <= var_416_28 + arg_416_0 then
				arg_413_1.var_.moveOldPos1029ui_story = var_416_27.localPosition
			end

			local var_416_29 = 0.001

			if var_416_28 <= arg_413_1.time_ and arg_413_1.time_ < var_416_28 + var_416_29 then
				local var_416_30 = (arg_413_1.time_ - var_416_28) / var_416_29
				local var_416_31 = Vector3.New(0, 100, 0)

				var_416_27.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1029ui_story, var_416_31, var_416_30)

				local var_416_32 = manager.ui.mainCamera.transform.position - var_416_27.position

				var_416_27.forward = Vector3.New(var_416_32.x, var_416_32.y, var_416_32.z)

				local var_416_33 = var_416_27.localEulerAngles

				var_416_33.z = 0
				var_416_33.x = 0
				var_416_27.localEulerAngles = var_416_33
			end

			if arg_413_1.time_ >= var_416_28 + var_416_29 and arg_413_1.time_ < var_416_28 + var_416_29 + arg_416_0 then
				var_416_27.localPosition = Vector3.New(0, 100, 0)

				local var_416_34 = manager.ui.mainCamera.transform.position - var_416_27.position

				var_416_27.forward = Vector3.New(var_416_34.x, var_416_34.y, var_416_34.z)

				local var_416_35 = var_416_27.localEulerAngles

				var_416_35.z = 0
				var_416_35.x = 0
				var_416_27.localEulerAngles = var_416_35
			end

			local var_416_36 = arg_413_1.actors_["1029ui_story"]
			local var_416_37 = 1.98333333333333

			if var_416_37 < arg_413_1.time_ and arg_413_1.time_ <= var_416_37 + arg_416_0 and not isNil(var_416_36) and arg_413_1.var_.characterEffect1029ui_story == nil then
				arg_413_1.var_.characterEffect1029ui_story = var_416_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_38 = 0.0166666666666666

			if var_416_37 <= arg_413_1.time_ and arg_413_1.time_ < var_416_37 + var_416_38 and not isNil(var_416_36) then
				local var_416_39 = (arg_413_1.time_ - var_416_37) / var_416_38

				if arg_413_1.var_.characterEffect1029ui_story and not isNil(var_416_36) then
					local var_416_40 = Mathf.Lerp(0, 0.5, var_416_39)

					arg_413_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1029ui_story.fillRatio = var_416_40
				end
			end

			if arg_413_1.time_ >= var_416_37 + var_416_38 and arg_413_1.time_ < var_416_37 + var_416_38 + arg_416_0 and not isNil(var_416_36) and arg_413_1.var_.characterEffect1029ui_story then
				local var_416_41 = 0.5

				arg_413_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1029ui_story.fillRatio = var_416_41
			end

			local var_416_42 = 1.9

			arg_413_1.isInRecall_ = false

			if var_416_42 < arg_413_1.time_ and arg_413_1.time_ <= var_416_42 + arg_416_0 then
				arg_413_1.screenFilterGo_:SetActive(false)

				for iter_416_2, iter_416_3 in pairs(arg_413_1.actors_) do
					local var_416_43 = iter_416_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_416_4, iter_416_5 in ipairs(var_416_43) do
						if iter_416_5.color.r > 0.51 then
							iter_416_5.color = Color.New(1, 1, 1)
						else
							iter_416_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_416_44 = 0.1

			if var_416_42 <= arg_413_1.time_ and arg_413_1.time_ < var_416_42 + var_416_44 then
				local var_416_45 = (arg_413_1.time_ - var_416_42) / var_416_44

				arg_413_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_416_45)
			end

			if arg_413_1.time_ >= var_416_42 + var_416_44 and arg_413_1.time_ < var_416_42 + var_416_44 + arg_416_0 then
				arg_413_1.screenFilterEffect_.weight = 0
			end

			local var_416_46 = 2

			arg_413_1.isInRecall_ = false

			if var_416_46 < arg_413_1.time_ and arg_413_1.time_ <= var_416_46 + arg_416_0 then
				arg_413_1.screenFilterGo_:SetActive(false)

				for iter_416_6, iter_416_7 in pairs(arg_413_1.actors_) do
					local var_416_47 = iter_416_7:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_416_8, iter_416_9 in ipairs(var_416_47) do
						if iter_416_9.color.r > 0.51 then
							iter_416_9.color = Color.New(1, 1, 1)
						else
							iter_416_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_416_48 = 0.034000001847744

			if var_416_46 <= arg_413_1.time_ and arg_413_1.time_ < var_416_46 + var_416_48 then
				local var_416_49 = (arg_413_1.time_ - var_416_46) / var_416_48

				arg_413_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_416_49)
			end

			if arg_413_1.time_ >= var_416_46 + var_416_48 and arg_413_1.time_ < var_416_46 + var_416_48 + arg_416_0 then
				arg_413_1.screenFilterEffect_.weight = 0
			end

			local var_416_50 = 0.2
			local var_416_51 = 1

			if var_416_50 < arg_413_1.time_ and arg_413_1.time_ <= var_416_50 + arg_416_0 then
				local var_416_52 = "stop"
				local var_416_53 = "effect"

				arg_413_1:AudioAction(var_416_52, var_416_53, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_416_54 = 1.56666666666667
			local var_416_55 = 1

			if var_416_54 < arg_413_1.time_ and arg_413_1.time_ <= var_416_54 + arg_416_0 then
				local var_416_56 = "play"
				local var_416_57 = "effect"

				arg_413_1:AudioAction(var_416_56, var_416_57, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_416_58 = arg_413_1.bgs_.MS2209.transform
			local var_416_59 = 2.00000000298023

			if var_416_59 < arg_413_1.time_ and arg_413_1.time_ <= var_416_59 + arg_416_0 then
				arg_413_1.var_.moveOldPosMS2209 = var_416_58.localPosition
			end

			local var_416_60 = 1.73333333333333

			if var_416_59 <= arg_413_1.time_ and arg_413_1.time_ < var_416_59 + var_416_60 then
				local var_416_61 = (arg_413_1.time_ - var_416_59) / var_416_60
				local var_416_62 = Vector3.New(0, 1.2, 9)

				var_416_58.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPosMS2209, var_416_62, var_416_61)
			end

			if arg_413_1.time_ >= var_416_59 + var_416_60 and arg_413_1.time_ < var_416_59 + var_416_60 + arg_416_0 then
				var_416_58.localPosition = Vector3.New(0, 1.2, 9)
			end

			if arg_413_1.frameCnt_ <= 1 then
				arg_413_1.dialog_:SetActive(false)
			end

			local var_416_63 = 3.8
			local var_416_64 = 0.05

			if var_416_63 < arg_413_1.time_ and arg_413_1.time_ <= var_416_63 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_65 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_65:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_66 = arg_413_1:FormatText(StoryNameCfg[613].name)

				arg_413_1.leftNameTxt_.text = var_416_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_67 = arg_413_1:GetWordFromCfg(322151098)
				local var_416_68 = arg_413_1:FormatText(var_416_67.content)

				arg_413_1.text_.text = var_416_68

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_69 = 2
				local var_416_70 = utf8.len(var_416_68)
				local var_416_71 = var_416_69 <= 0 and var_416_64 or var_416_64 * (var_416_70 / var_416_69)

				if var_416_71 > 0 and var_416_64 < var_416_71 then
					arg_413_1.talkMaxDuration = var_416_71
					var_416_63 = var_416_63 + 0.3

					if var_416_71 + var_416_63 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_71 + var_416_63
					end
				end

				arg_413_1.text_.text = var_416_68
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151098", "story_v_out_322151.awb") ~= 0 then
					local var_416_72 = manager.audio:GetVoiceLength("story_v_out_322151", "322151098", "story_v_out_322151.awb") / 1000

					if var_416_72 + var_416_63 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_72 + var_416_63
					end

					if var_416_67.prefab_name ~= "" and arg_413_1.actors_[var_416_67.prefab_name] ~= nil then
						local var_416_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_67.prefab_name].transform, "story_v_out_322151", "322151098", "story_v_out_322151.awb")

						arg_413_1:RecordAudio("322151098", var_416_73)
						arg_413_1:RecordAudio("322151098", var_416_73)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_322151", "322151098", "story_v_out_322151.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_322151", "322151098", "story_v_out_322151.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_74 = var_416_63 + 0.3
			local var_416_75 = math.max(var_416_64, arg_413_1.talkMaxDuration)

			if var_416_74 <= arg_413_1.time_ and arg_413_1.time_ < var_416_74 + var_416_75 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_74) / var_416_75

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_74 + var_416_75 and arg_413_1.time_ < var_416_74 + var_416_75 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.73333333333333,
				startTime = 2.00000000298023,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1.2, 9),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play322151099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 322151099
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play322151100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 1.275

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[7].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_3 = arg_419_1:GetWordFromCfg(322151099)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 51
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_8 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_8 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_8

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_8 and arg_419_1.time_ < var_422_0 + var_422_8 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play322151100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 322151100
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play322151101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 1.1

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_3 = arg_423_1:GetWordFromCfg(322151100)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 44
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_8 and arg_423_1.time_ < var_426_0 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play322151101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 322151101
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play322151102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.925

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[7].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_3 = arg_427_1:GetWordFromCfg(322151101)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 37
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_8 and arg_427_1.time_ < var_430_0 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play322151102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 322151102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play322151103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 1.075

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_2 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_3 = arg_431_1:GetWordFromCfg(322151102)
				local var_434_4 = arg_431_1:FormatText(var_434_3.content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 43
				local var_434_6 = utf8.len(var_434_4)
				local var_434_7 = var_434_5 <= 0 and var_434_1 or var_434_1 * (var_434_6 / var_434_5)

				if var_434_7 > 0 and var_434_1 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_8 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_8 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_8

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_8 and arg_431_1.time_ < var_434_0 + var_434_8 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play322151103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 322151103
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play322151104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.775

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_3 = arg_435_1:GetWordFromCfg(322151103)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 31
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_8 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_8 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_8

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_8 and arg_435_1.time_ < var_438_0 + var_438_8 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play322151104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 322151104
		arg_439_1.duration_ = 5.77

		local var_439_0 = {
			zh = 3.166,
			ja = 5.766
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play322151105(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.325

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[613].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:GetWordFromCfg(322151104)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 13
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151104", "story_v_out_322151.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151104", "story_v_out_322151.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_322151", "322151104", "story_v_out_322151.awb")

						arg_439_1:RecordAudio("322151104", var_442_9)
						arg_439_1:RecordAudio("322151104", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_322151", "322151104", "story_v_out_322151.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_322151", "322151104", "story_v_out_322151.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play322151105 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 322151105
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play322151106(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.55

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:GetWordFromCfg(322151105)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 22
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_8 and arg_443_1.time_ < var_446_0 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play322151106 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 322151106
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play322151107(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.9

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[7].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:GetWordFromCfg(322151106)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 36
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_8 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_8 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_8

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_8 and arg_447_1.time_ < var_450_0 + var_450_8 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play322151107 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 322151107
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play322151108(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 1.025

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_2 = arg_451_1:FormatText(StoryNameCfg[7].name)

				arg_451_1.leftNameTxt_.text = var_454_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_3 = arg_451_1:GetWordFromCfg(322151107)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 41
				local var_454_6 = utf8.len(var_454_4)
				local var_454_7 = var_454_5 <= 0 and var_454_1 or var_454_1 * (var_454_6 / var_454_5)

				if var_454_7 > 0 and var_454_1 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_8 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_8 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_8

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_8 and arg_451_1.time_ < var_454_0 + var_454_8 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play322151108 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 322151108
		arg_455_1.duration_ = 7.93

		local var_455_0 = {
			zh = 6.86666666666667,
			ja = 7.93266666666667
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play322151109(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.bgs_.MS2209.transform
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.var_.moveOldPosMS2209 = var_458_0.localPosition
			end

			local var_458_2 = 0.7

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2
				local var_458_4 = Vector3.New(0.2, 1.2, 9)

				var_458_0.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosMS2209, var_458_4, var_458_3)
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 then
				var_458_0.localPosition = Vector3.New(0.2, 1.2, 9)
			end

			local var_458_5 = 0

			if var_458_5 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1.allBtn_.enabled = false
			end

			local var_458_6 = 1

			if arg_455_1.time_ >= var_458_5 + var_458_6 and arg_455_1.time_ < var_458_5 + var_458_6 + arg_458_0 then
				arg_455_1.allBtn_.enabled = true
			end

			if arg_455_1.frameCnt_ <= 1 then
				arg_455_1.dialog_:SetActive(false)
			end

			local var_458_7 = 0.366666666666667
			local var_458_8 = 0.775

			if var_458_7 < arg_455_1.time_ and arg_455_1.time_ <= var_458_7 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_9 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_9:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_10 = arg_455_1:FormatText(StoryNameCfg[613].name)

				arg_455_1.leftNameTxt_.text = var_458_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_11 = arg_455_1:GetWordFromCfg(322151108)
				local var_458_12 = arg_455_1:FormatText(var_458_11.content)

				arg_455_1.text_.text = var_458_12

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_13 = 31
				local var_458_14 = utf8.len(var_458_12)
				local var_458_15 = var_458_13 <= 0 and var_458_8 or var_458_8 * (var_458_14 / var_458_13)

				if var_458_15 > 0 and var_458_8 < var_458_15 then
					arg_455_1.talkMaxDuration = var_458_15
					var_458_7 = var_458_7 + 0.3

					if var_458_15 + var_458_7 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_15 + var_458_7
					end
				end

				arg_455_1.text_.text = var_458_12
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151108", "story_v_out_322151.awb") ~= 0 then
					local var_458_16 = manager.audio:GetVoiceLength("story_v_out_322151", "322151108", "story_v_out_322151.awb") / 1000

					if var_458_16 + var_458_7 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_16 + var_458_7
					end

					if var_458_11.prefab_name ~= "" and arg_455_1.actors_[var_458_11.prefab_name] ~= nil then
						local var_458_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_11.prefab_name].transform, "story_v_out_322151", "322151108", "story_v_out_322151.awb")

						arg_455_1:RecordAudio("322151108", var_458_17)
						arg_455_1:RecordAudio("322151108", var_458_17)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_322151", "322151108", "story_v_out_322151.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_322151", "322151108", "story_v_out_322151.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_18 = var_458_7 + 0.3
			local var_458_19 = math.max(var_458_8, arg_455_1.talkMaxDuration)

			if var_458_18 <= arg_455_1.time_ and arg_455_1.time_ < var_458_18 + var_458_19 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_18) / var_458_19

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_18 + var_458_19 and arg_455_1.time_ < var_458_18 + var_458_19 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.7,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.2, 9),
					endPos = Vector3.New(0.2, 1.2, 9),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play322151109 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 322151109
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play322151110(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.325

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[7].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_3 = arg_461_1:GetWordFromCfg(322151109)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 13
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_8 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_8 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_8

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_8 and arg_461_1.time_ < var_464_0 + var_464_8 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play322151110 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 322151110
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play322151111(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 1.125

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_2 = arg_465_1:GetWordFromCfg(322151110)
				local var_468_3 = arg_465_1:FormatText(var_468_2.content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 45
				local var_468_5 = utf8.len(var_468_3)
				local var_468_6 = var_468_4 <= 0 and var_468_1 or var_468_1 * (var_468_5 / var_468_4)

				if var_468_6 > 0 and var_468_1 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_7 and arg_465_1.time_ < var_468_0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play322151111 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 322151111
		arg_469_1.duration_ = 4.23

		local var_469_0 = {
			zh = 3.3,
			ja = 4.233
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play322151112(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.275

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[613].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_3 = arg_469_1:GetWordFromCfg(322151111)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 11
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151111", "story_v_out_322151.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151111", "story_v_out_322151.awb") / 1000

					if var_472_8 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_0
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_out_322151", "322151111", "story_v_out_322151.awb")

						arg_469_1:RecordAudio("322151111", var_472_9)
						arg_469_1:RecordAudio("322151111", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_322151", "322151111", "story_v_out_322151.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_322151", "322151111", "story_v_out_322151.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_10 and arg_469_1.time_ < var_472_0 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play322151112 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 322151112
		arg_473_1.duration_ = 10.43

		local var_473_0 = {
			zh = 6,
			ja = 10.433
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play322151113(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.7

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[613].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_3 = arg_473_1:GetWordFromCfg(322151112)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 28
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151112", "story_v_out_322151.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151112", "story_v_out_322151.awb") / 1000

					if var_476_8 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_0
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_out_322151", "322151112", "story_v_out_322151.awb")

						arg_473_1:RecordAudio("322151112", var_476_9)
						arg_473_1:RecordAudio("322151112", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_322151", "322151112", "story_v_out_322151.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_322151", "322151112", "story_v_out_322151.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_10 and arg_473_1.time_ < var_476_0 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play322151113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 322151113
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play322151114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.45

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_3 = arg_477_1:GetWordFromCfg(322151113)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 18
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play322151114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 322151114
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play322151115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 1.825

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_2 = arg_481_1:GetWordFromCfg(322151114)
				local var_484_3 = arg_481_1:FormatText(var_484_2.content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 73
				local var_484_5 = utf8.len(var_484_3)
				local var_484_6 = var_484_4 <= 0 and var_484_1 or var_484_1 * (var_484_5 / var_484_4)

				if var_484_6 > 0 and var_484_1 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_7 and arg_481_1.time_ < var_484_0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play322151115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 322151115
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play322151116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 0.625

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_2 = arg_485_1:GetWordFromCfg(322151115)
				local var_488_3 = arg_485_1:FormatText(var_488_2.content)

				arg_485_1.text_.text = var_488_3

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 25
				local var_488_5 = utf8.len(var_488_3)
				local var_488_6 = var_488_4 <= 0 and var_488_1 or var_488_1 * (var_488_5 / var_488_4)

				if var_488_6 > 0 and var_488_1 < var_488_6 then
					arg_485_1.talkMaxDuration = var_488_6

					if var_488_6 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_3
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_7 and arg_485_1.time_ < var_488_0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play322151116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 322151116
		arg_489_1.duration_ = 9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play322151117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = "MS2209a"

			if arg_489_1.bgs_[var_492_0] == nil then
				local var_492_1 = Object.Instantiate(arg_489_1.paintGo_)

				var_492_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_492_0)
				var_492_1.name = var_492_0
				var_492_1.transform.parent = arg_489_1.stage_.transform
				var_492_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.bgs_[var_492_0] = var_492_1
			end

			local var_492_2 = 2

			if var_492_2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_2 + arg_492_0 then
				local var_492_3 = manager.ui.mainCamera.transform.localPosition
				local var_492_4 = Vector3.New(0, 0, 10) + Vector3.New(var_492_3.x, var_492_3.y, 0)
				local var_492_5 = arg_489_1.bgs_.MS2209a

				var_492_5.transform.localPosition = var_492_4
				var_492_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_6 = var_492_5:GetComponent("SpriteRenderer")

				if var_492_6 and var_492_6.sprite then
					local var_492_7 = (var_492_5.transform.localPosition - var_492_3).z
					local var_492_8 = manager.ui.mainCameraCom_
					local var_492_9 = 2 * var_492_7 * Mathf.Tan(var_492_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_492_10 = var_492_9 * var_492_8.aspect
					local var_492_11 = var_492_6.sprite.bounds.size.x
					local var_492_12 = var_492_6.sprite.bounds.size.y
					local var_492_13 = var_492_10 / var_492_11
					local var_492_14 = var_492_9 / var_492_12
					local var_492_15 = var_492_14 < var_492_13 and var_492_13 or var_492_14

					var_492_5.transform.localScale = Vector3.New(var_492_15, var_492_15, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "MS2209a" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_16 = 4

			if var_492_16 < arg_489_1.time_ and arg_489_1.time_ <= var_492_16 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			local var_492_17 = 1.53333333333333

			if arg_489_1.time_ >= var_492_16 + var_492_17 and arg_489_1.time_ < var_492_16 + var_492_17 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end

			local var_492_18 = 0

			if var_492_18 < arg_489_1.time_ and arg_489_1.time_ <= var_492_18 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_19 = 2

			if var_492_18 <= arg_489_1.time_ and arg_489_1.time_ < var_492_18 + var_492_19 then
				local var_492_20 = (arg_489_1.time_ - var_492_18) / var_492_19
				local var_492_21 = Color.New(0, 0, 0)

				var_492_21.a = Mathf.Lerp(0, 1, var_492_20)
				arg_489_1.mask_.color = var_492_21
			end

			if arg_489_1.time_ >= var_492_18 + var_492_19 and arg_489_1.time_ < var_492_18 + var_492_19 + arg_492_0 then
				local var_492_22 = Color.New(0, 0, 0)

				var_492_22.a = 1
				arg_489_1.mask_.color = var_492_22
			end

			local var_492_23 = 2

			if var_492_23 < arg_489_1.time_ and arg_489_1.time_ <= var_492_23 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_24 = 2

			if var_492_23 <= arg_489_1.time_ and arg_489_1.time_ < var_492_23 + var_492_24 then
				local var_492_25 = (arg_489_1.time_ - var_492_23) / var_492_24
				local var_492_26 = Color.New(0, 0, 0)

				var_492_26.a = Mathf.Lerp(1, 0, var_492_25)
				arg_489_1.mask_.color = var_492_26
			end

			if arg_489_1.time_ >= var_492_23 + var_492_24 and arg_489_1.time_ < var_492_23 + var_492_24 + arg_492_0 then
				local var_492_27 = Color.New(0, 0, 0)
				local var_492_28 = 0

				arg_489_1.mask_.enabled = false
				var_492_27.a = var_492_28
				arg_489_1.mask_.color = var_492_27
			end

			local var_492_29 = 0.3
			local var_492_30 = 1

			if var_492_29 < arg_489_1.time_ and arg_489_1.time_ <= var_492_29 + arg_492_0 then
				local var_492_31 = "stop"
				local var_492_32 = "effect"

				arg_489_1:AudioAction(var_492_31, var_492_32, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_492_33 = 1.56666666666667
			local var_492_34 = 1

			if var_492_33 < arg_489_1.time_ and arg_489_1.time_ <= var_492_33 + arg_492_0 then
				local var_492_35 = "play"
				local var_492_36 = "effect"

				arg_489_1:AudioAction(var_492_35, var_492_36, "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			local var_492_37 = manager.ui.mainCamera.transform
			local var_492_38 = 2

			if var_492_38 < arg_489_1.time_ and arg_489_1.time_ <= var_492_38 + arg_492_0 then
				local var_492_39 = arg_489_1.var_.effect1116
				local var_492_40
				local var_492_41 = var_492_37

				if not var_492_39 then
					var_492_39 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), var_492_41)
					var_492_39.name = "1116"
					arg_489_1.var_.effect1116 = var_492_39
				else
					var_492_39.transform:SetParent(var_492_41)
				end

				var_492_39.transform.localPosition = Vector3.New(0, 0, 0)
				var_492_39.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_492_42 = arg_489_1.bgs_.MS2209a.transform
			local var_492_43 = 2

			if var_492_43 < arg_489_1.time_ and arg_489_1.time_ <= var_492_43 + arg_492_0 then
				arg_489_1.var_.moveOldPosMS2209a = var_492_42.localPosition
			end

			local var_492_44 = 1.73333333333333

			if var_492_43 <= arg_489_1.time_ and arg_489_1.time_ < var_492_43 + var_492_44 then
				local var_492_45 = (arg_489_1.time_ - var_492_43) / var_492_44
				local var_492_46 = Vector3.New(0, 0.8, 8.5)

				var_492_42.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPosMS2209a, var_492_46, var_492_45)
			end

			if arg_489_1.time_ >= var_492_43 + var_492_44 and arg_489_1.time_ < var_492_43 + var_492_44 + arg_492_0 then
				var_492_42.localPosition = Vector3.New(0, 0.8, 8.5)
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_47 = 4
			local var_492_48 = 1.625

			if var_492_47 < arg_489_1.time_ and arg_489_1.time_ <= var_492_47 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_49 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_49:setOnUpdate(LuaHelper.FloatAction(function(arg_493_0)
					arg_489_1.dialogCg_.alpha = arg_493_0
				end))
				var_492_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_50 = arg_489_1:GetWordFromCfg(322151116)
				local var_492_51 = arg_489_1:FormatText(var_492_50.content)

				arg_489_1.text_.text = var_492_51

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_52 = 65
				local var_492_53 = utf8.len(var_492_51)
				local var_492_54 = var_492_52 <= 0 and var_492_48 or var_492_48 * (var_492_53 / var_492_52)

				if var_492_54 > 0 and var_492_48 < var_492_54 then
					arg_489_1.talkMaxDuration = var_492_54
					var_492_47 = var_492_47 + 0.3

					if var_492_54 + var_492_47 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_54 + var_492_47
					end
				end

				arg_489_1.text_.text = var_492_51
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_55 = var_492_47 + 0.3
			local var_492_56 = math.max(var_492_48, arg_489_1.talkMaxDuration)

			if var_492_55 <= arg_489_1.time_ and arg_489_1.time_ < var_492_55 + var_492_56 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_55) / var_492_56

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_55 + var_492_56 and arg_489_1.time_ < var_492_55 + var_492_56 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.73333333333333,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 0.8, 8.5),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play322151117 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 322151117
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play322151118(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.125

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[7].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_3 = arg_495_1:GetWordFromCfg(322151117)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 5
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_8 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_8 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_8

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_8 and arg_495_1.time_ < var_498_0 + var_498_8 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play322151118 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 322151118
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play322151119(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 1.075

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_2 = arg_499_1:GetWordFromCfg(322151118)
				local var_502_3 = arg_499_1:FormatText(var_502_2.content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 43
				local var_502_5 = utf8.len(var_502_3)
				local var_502_6 = var_502_4 <= 0 and var_502_1 or var_502_1 * (var_502_5 / var_502_4)

				if var_502_6 > 0 and var_502_1 < var_502_6 then
					arg_499_1.talkMaxDuration = var_502_6

					if var_502_6 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_6 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_7 and arg_499_1.time_ < var_502_0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play322151119 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 322151119
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play322151120(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 1.15

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(322151119)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 46
				local var_506_5 = utf8.len(var_506_3)
				local var_506_6 = var_506_4 <= 0 and var_506_1 or var_506_1 * (var_506_5 / var_506_4)

				if var_506_6 > 0 and var_506_1 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_7 and arg_503_1.time_ < var_506_0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play322151120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 322151120
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play322151121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.333333333333333
			local var_510_1 = 1

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				local var_510_2 = "play"
				local var_510_3 = "effect"

				arg_507_1:AudioAction(var_510_2, var_510_3, "se_story_145", "se_story_145_caoza", "")
			end

			local var_510_4 = 0
			local var_510_5 = 1.675

			if var_510_4 < arg_507_1.time_ and arg_507_1.time_ <= var_510_4 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_6 = arg_507_1:GetWordFromCfg(322151120)
				local var_510_7 = arg_507_1:FormatText(var_510_6.content)

				arg_507_1.text_.text = var_510_7

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_8 = 67
				local var_510_9 = utf8.len(var_510_7)
				local var_510_10 = var_510_8 <= 0 and var_510_5 or var_510_5 * (var_510_9 / var_510_8)

				if var_510_10 > 0 and var_510_5 < var_510_10 then
					arg_507_1.talkMaxDuration = var_510_10

					if var_510_10 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_4
					end
				end

				arg_507_1.text_.text = var_510_7
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_11 = math.max(var_510_5, arg_507_1.talkMaxDuration)

			if var_510_4 <= arg_507_1.time_ and arg_507_1.time_ < var_510_4 + var_510_11 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_4) / var_510_11

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_4 + var_510_11 and arg_507_1.time_ < var_510_4 + var_510_11 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play322151121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 322151121
		arg_511_1.duration_ = 5.18

		local var_511_0 = {
			zh = 4.21633333333333,
			ja = 5.18333333333333
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play322151122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = manager.ui.mainCamera.transform
			local var_514_1 = 0.166666666666667

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				local var_514_2 = arg_511_1.var_.effect1116
				local var_514_3
				local var_514_4 = var_514_0

				if not var_514_2 then
					var_514_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), var_514_4)
					var_514_2.name = "1116"
					arg_511_1.var_.effect1116 = var_514_2
				else
					var_514_2.transform:SetParent(var_514_4)
				end

				var_514_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_514_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_514_5 = 0

			if var_514_5 < arg_511_1.time_ and arg_511_1.time_ <= var_514_5 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = true

				arg_511_1:SetGaussion(false)
			end

			local var_514_6 = 0.183333333333333

			if var_514_5 <= arg_511_1.time_ and arg_511_1.time_ < var_514_5 + var_514_6 then
				local var_514_7 = (arg_511_1.time_ - var_514_5) / var_514_6
				local var_514_8 = Color.New(0, 0, 0)

				var_514_8.a = Mathf.Lerp(0, 1, var_514_7)
				arg_511_1.mask_.color = var_514_8
			end

			if arg_511_1.time_ >= var_514_5 + var_514_6 and arg_511_1.time_ < var_514_5 + var_514_6 + arg_514_0 then
				local var_514_9 = Color.New(0, 0, 0)

				var_514_9.a = 1
				arg_511_1.mask_.color = var_514_9
			end

			local var_514_10 = 0.183333333333333

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = true

				arg_511_1:SetGaussion(false)
			end

			local var_514_11 = 0.183333333333333

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11
				local var_514_13 = Color.New(0, 0, 0)

				var_514_13.a = Mathf.Lerp(1, 0, var_514_12)
				arg_511_1.mask_.color = var_514_13
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 then
				local var_514_14 = Color.New(0, 0, 0)
				local var_514_15 = 0

				arg_511_1.mask_.enabled = false
				var_514_14.a = var_514_15
				arg_511_1.mask_.color = var_514_14
			end

			if arg_511_1.frameCnt_ <= 1 then
				arg_511_1.dialog_:SetActive(false)
			end

			local var_514_16 = 0.183333333333333
			local var_514_17 = 0.475

			if var_514_16 < arg_511_1.time_ and arg_511_1.time_ <= var_514_16 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0

				arg_511_1.dialog_:SetActive(true)

				arg_511_1.dialogCg_.alpha = 0

				local var_514_18 = LeanTween.value(arg_511_1.dialog_, 0, 1, 0.3)

				var_514_18:setOnUpdate(LuaHelper.FloatAction(function(arg_515_0)
					arg_511_1.dialogCg_.alpha = arg_515_0
				end))
				var_514_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_511_1.dialog_)
					var_514_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_511_1.duration_ = arg_511_1.duration_ + 0.3

				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_19 = arg_511_1:FormatText(StoryNameCfg[613].name)

				arg_511_1.leftNameTxt_.text = var_514_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_20 = arg_511_1:GetWordFromCfg(322151121)
				local var_514_21 = arg_511_1:FormatText(var_514_20.content)

				arg_511_1.text_.text = var_514_21

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_22 = 19
				local var_514_23 = utf8.len(var_514_21)
				local var_514_24 = var_514_22 <= 0 and var_514_17 or var_514_17 * (var_514_23 / var_514_22)

				if var_514_24 > 0 and var_514_17 < var_514_24 then
					arg_511_1.talkMaxDuration = var_514_24
					var_514_16 = var_514_16 + 0.3

					if var_514_24 + var_514_16 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_24 + var_514_16
					end
				end

				arg_511_1.text_.text = var_514_21
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151121", "story_v_out_322151.awb") ~= 0 then
					local var_514_25 = manager.audio:GetVoiceLength("story_v_out_322151", "322151121", "story_v_out_322151.awb") / 1000

					if var_514_25 + var_514_16 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_25 + var_514_16
					end

					if var_514_20.prefab_name ~= "" and arg_511_1.actors_[var_514_20.prefab_name] ~= nil then
						local var_514_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_20.prefab_name].transform, "story_v_out_322151", "322151121", "story_v_out_322151.awb")

						arg_511_1:RecordAudio("322151121", var_514_26)
						arg_511_1:RecordAudio("322151121", var_514_26)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_322151", "322151121", "story_v_out_322151.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_322151", "322151121", "story_v_out_322151.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_27 = var_514_16 + 0.3
			local var_514_28 = math.max(var_514_17, arg_511_1.talkMaxDuration)

			if var_514_27 <= arg_511_1.time_ and arg_511_1.time_ < var_514_27 + var_514_28 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_27) / var_514_28

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_27 + var_514_28 and arg_511_1.time_ < var_514_27 + var_514_28 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play322151122 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 322151122
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play322151123(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.425

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[7].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_3 = arg_517_1:GetWordFromCfg(322151122)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 17
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_8 and arg_517_1.time_ < var_520_0 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play322151123 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 322151123
		arg_521_1.duration_ = 8.23

		local var_521_0 = {
			zh = 6.266,
			ja = 8.233
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play322151124(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.575

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_2 = arg_521_1:FormatText(StoryNameCfg[613].name)

				arg_521_1.leftNameTxt_.text = var_524_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_3 = arg_521_1:GetWordFromCfg(322151123)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 23
				local var_524_6 = utf8.len(var_524_4)
				local var_524_7 = var_524_5 <= 0 and var_524_1 or var_524_1 * (var_524_6 / var_524_5)

				if var_524_7 > 0 and var_524_1 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151123", "story_v_out_322151.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151123", "story_v_out_322151.awb") / 1000

					if var_524_8 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_0
					end

					if var_524_3.prefab_name ~= "" and arg_521_1.actors_[var_524_3.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_3.prefab_name].transform, "story_v_out_322151", "322151123", "story_v_out_322151.awb")

						arg_521_1:RecordAudio("322151123", var_524_9)
						arg_521_1:RecordAudio("322151123", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_322151", "322151123", "story_v_out_322151.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_322151", "322151123", "story_v_out_322151.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_10 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_10 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_10

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_10 and arg_521_1.time_ < var_524_0 + var_524_10 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play322151124 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 322151124
		arg_525_1.duration_ = 9.3

		local var_525_0 = {
			zh = 9.3,
			ja = 6.2
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play322151125(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = "ST61a"

			if arg_525_1.bgs_[var_528_0] == nil then
				local var_528_1 = Object.Instantiate(arg_525_1.paintGo_)

				var_528_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_528_0)
				var_528_1.name = var_528_0
				var_528_1.transform.parent = arg_525_1.stage_.transform
				var_528_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.bgs_[var_528_0] = var_528_1
			end

			local var_528_2 = 2

			if var_528_2 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 then
				local var_528_3 = manager.ui.mainCamera.transform.localPosition
				local var_528_4 = Vector3.New(0, 0, 10) + Vector3.New(var_528_3.x, var_528_3.y, 0)
				local var_528_5 = arg_525_1.bgs_.ST61a

				var_528_5.transform.localPosition = var_528_4
				var_528_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_6 = var_528_5:GetComponent("SpriteRenderer")

				if var_528_6 and var_528_6.sprite then
					local var_528_7 = (var_528_5.transform.localPosition - var_528_3).z
					local var_528_8 = manager.ui.mainCameraCom_
					local var_528_9 = 2 * var_528_7 * Mathf.Tan(var_528_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_528_10 = var_528_9 * var_528_8.aspect
					local var_528_11 = var_528_6.sprite.bounds.size.x
					local var_528_12 = var_528_6.sprite.bounds.size.y
					local var_528_13 = var_528_10 / var_528_11
					local var_528_14 = var_528_9 / var_528_12
					local var_528_15 = var_528_14 < var_528_13 and var_528_13 or var_528_14

					var_528_5.transform.localScale = Vector3.New(var_528_15, var_528_15, 0)
				end

				for iter_528_0, iter_528_1 in pairs(arg_525_1.bgs_) do
					if iter_528_0 ~= "ST61a" then
						iter_528_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_528_16 = 4

			if var_528_16 < arg_525_1.time_ and arg_525_1.time_ <= var_528_16 + arg_528_0 then
				arg_525_1.allBtn_.enabled = false
			end

			local var_528_17 = 0.3

			if arg_525_1.time_ >= var_528_16 + var_528_17 and arg_525_1.time_ < var_528_16 + var_528_17 + arg_528_0 then
				arg_525_1.allBtn_.enabled = true
			end

			local var_528_18 = 0

			if var_528_18 < arg_525_1.time_ and arg_525_1.time_ <= var_528_18 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_19 = 2

			if var_528_18 <= arg_525_1.time_ and arg_525_1.time_ < var_528_18 + var_528_19 then
				local var_528_20 = (arg_525_1.time_ - var_528_18) / var_528_19
				local var_528_21 = Color.New(0, 0, 0)

				var_528_21.a = Mathf.Lerp(0, 1, var_528_20)
				arg_525_1.mask_.color = var_528_21
			end

			if arg_525_1.time_ >= var_528_18 + var_528_19 and arg_525_1.time_ < var_528_18 + var_528_19 + arg_528_0 then
				local var_528_22 = Color.New(0, 0, 0)

				var_528_22.a = 1
				arg_525_1.mask_.color = var_528_22
			end

			local var_528_23 = 2

			if var_528_23 < arg_525_1.time_ and arg_525_1.time_ <= var_528_23 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_24 = 2

			if var_528_23 <= arg_525_1.time_ and arg_525_1.time_ < var_528_23 + var_528_24 then
				local var_528_25 = (arg_525_1.time_ - var_528_23) / var_528_24
				local var_528_26 = Color.New(0, 0, 0)

				var_528_26.a = Mathf.Lerp(1, 0, var_528_25)
				arg_525_1.mask_.color = var_528_26
			end

			if arg_525_1.time_ >= var_528_23 + var_528_24 and arg_525_1.time_ < var_528_23 + var_528_24 + arg_528_0 then
				local var_528_27 = Color.New(0, 0, 0)
				local var_528_28 = 0

				arg_525_1.mask_.enabled = false
				var_528_27.a = var_528_28
				arg_525_1.mask_.color = var_528_27
			end

			local var_528_29 = arg_525_1.actors_["1020ui_story"].transform
			local var_528_30 = 1.96599999815226

			if var_528_30 < arg_525_1.time_ and arg_525_1.time_ <= var_528_30 + arg_528_0 then
				arg_525_1.var_.moveOldPos1020ui_story = var_528_29.localPosition
			end

			local var_528_31 = 0.001

			if var_528_30 <= arg_525_1.time_ and arg_525_1.time_ < var_528_30 + var_528_31 then
				local var_528_32 = (arg_525_1.time_ - var_528_30) / var_528_31
				local var_528_33 = Vector3.New(0, 100, 0)

				var_528_29.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1020ui_story, var_528_33, var_528_32)

				local var_528_34 = manager.ui.mainCamera.transform.position - var_528_29.position

				var_528_29.forward = Vector3.New(var_528_34.x, var_528_34.y, var_528_34.z)

				local var_528_35 = var_528_29.localEulerAngles

				var_528_35.z = 0
				var_528_35.x = 0
				var_528_29.localEulerAngles = var_528_35
			end

			if arg_525_1.time_ >= var_528_30 + var_528_31 and arg_525_1.time_ < var_528_30 + var_528_31 + arg_528_0 then
				var_528_29.localPosition = Vector3.New(0, 100, 0)

				local var_528_36 = manager.ui.mainCamera.transform.position - var_528_29.position

				var_528_29.forward = Vector3.New(var_528_36.x, var_528_36.y, var_528_36.z)

				local var_528_37 = var_528_29.localEulerAngles

				var_528_37.z = 0
				var_528_37.x = 0
				var_528_29.localEulerAngles = var_528_37
			end

			local var_528_38 = "10100ui_story"

			if arg_525_1.actors_[var_528_38] == nil then
				local var_528_39 = Asset.Load("Char/" .. "10100ui_story")

				if not isNil(var_528_39) then
					local var_528_40 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_525_1.stage_.transform)

					var_528_40.name = var_528_38
					var_528_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_525_1.actors_[var_528_38] = var_528_40

					local var_528_41 = var_528_40:GetComponentInChildren(typeof(CharacterEffect))

					var_528_41.enabled = true

					local var_528_42 = GameObjectTools.GetOrAddComponent(var_528_40, typeof(DynamicBoneHelper))

					if var_528_42 then
						var_528_42:EnableDynamicBone(false)
					end

					arg_525_1:ShowWeapon(var_528_41.transform, false)

					arg_525_1.var_[var_528_38 .. "Animator"] = var_528_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_525_1.var_[var_528_38 .. "Animator"].applyRootMotion = true
					arg_525_1.var_[var_528_38 .. "LipSync"] = var_528_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_528_43 = arg_525_1.actors_["10100ui_story"].transform
			local var_528_44 = 3.8

			if var_528_44 < arg_525_1.time_ and arg_525_1.time_ <= var_528_44 + arg_528_0 then
				arg_525_1.var_.moveOldPos10100ui_story = var_528_43.localPosition
			end

			local var_528_45 = 0.001

			if var_528_44 <= arg_525_1.time_ and arg_525_1.time_ < var_528_44 + var_528_45 then
				local var_528_46 = (arg_525_1.time_ - var_528_44) / var_528_45
				local var_528_47 = Vector3.New(0, -1.16, -6.25)

				var_528_43.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10100ui_story, var_528_47, var_528_46)

				local var_528_48 = manager.ui.mainCamera.transform.position - var_528_43.position

				var_528_43.forward = Vector3.New(var_528_48.x, var_528_48.y, var_528_48.z)

				local var_528_49 = var_528_43.localEulerAngles

				var_528_49.z = 0
				var_528_49.x = 0
				var_528_43.localEulerAngles = var_528_49
			end

			if arg_525_1.time_ >= var_528_44 + var_528_45 and arg_525_1.time_ < var_528_44 + var_528_45 + arg_528_0 then
				var_528_43.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_528_50 = manager.ui.mainCamera.transform.position - var_528_43.position

				var_528_43.forward = Vector3.New(var_528_50.x, var_528_50.y, var_528_50.z)

				local var_528_51 = var_528_43.localEulerAngles

				var_528_51.z = 0
				var_528_51.x = 0
				var_528_43.localEulerAngles = var_528_51
			end

			local var_528_52 = arg_525_1.actors_["10100ui_story"]
			local var_528_53 = 3.8

			if var_528_53 < arg_525_1.time_ and arg_525_1.time_ <= var_528_53 + arg_528_0 and not isNil(var_528_52) and arg_525_1.var_.characterEffect10100ui_story == nil then
				arg_525_1.var_.characterEffect10100ui_story = var_528_52:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_54 = 0.200000002980232

			if var_528_53 <= arg_525_1.time_ and arg_525_1.time_ < var_528_53 + var_528_54 and not isNil(var_528_52) then
				local var_528_55 = (arg_525_1.time_ - var_528_53) / var_528_54

				if arg_525_1.var_.characterEffect10100ui_story and not isNil(var_528_52) then
					arg_525_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= var_528_53 + var_528_54 and arg_525_1.time_ < var_528_53 + var_528_54 + arg_528_0 and not isNil(var_528_52) and arg_525_1.var_.characterEffect10100ui_story then
				arg_525_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_528_56 = 3.8

			if var_528_56 < arg_525_1.time_ and arg_525_1.time_ <= var_528_56 + arg_528_0 then
				arg_525_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action24_1")
			end

			local var_528_57 = 3.8

			if var_528_57 < arg_525_1.time_ and arg_525_1.time_ <= var_528_57 + arg_528_0 then
				arg_525_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_528_58 = 0.3
			local var_528_59 = 1

			if var_528_58 < arg_525_1.time_ and arg_525_1.time_ <= var_528_58 + arg_528_0 then
				local var_528_60 = "stop"
				local var_528_61 = "effect"

				arg_525_1:AudioAction(var_528_60, var_528_61, "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			local var_528_62 = 1.53333333333333
			local var_528_63 = 1

			if var_528_62 < arg_525_1.time_ and arg_525_1.time_ <= var_528_62 + arg_528_0 then
				local var_528_64 = "play"
				local var_528_65 = "effect"

				arg_525_1:AudioAction(var_528_64, var_528_65, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_528_66 = manager.ui.mainCamera.transform
			local var_528_67 = 2

			if var_528_67 < arg_525_1.time_ and arg_525_1.time_ <= var_528_67 + arg_528_0 then
				local var_528_68 = arg_525_1.var_.effect1116

				if var_528_68 then
					Object.Destroy(var_528_68)

					arg_525_1.var_.effect1116 = nil
				end
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_69 = 3.8
			local var_528_70 = 0.1

			if var_528_69 < arg_525_1.time_ and arg_525_1.time_ <= var_528_69 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_71 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_71:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_72 = arg_525_1:FormatText(StoryNameCfg[1021].name)

				arg_525_1.leftNameTxt_.text = var_528_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_73 = arg_525_1:GetWordFromCfg(322151124)
				local var_528_74 = arg_525_1:FormatText(var_528_73.content)

				arg_525_1.text_.text = var_528_74

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_75 = 4
				local var_528_76 = utf8.len(var_528_74)
				local var_528_77 = var_528_75 <= 0 and var_528_70 or var_528_70 * (var_528_76 / var_528_75)

				if var_528_77 > 0 and var_528_70 < var_528_77 then
					arg_525_1.talkMaxDuration = var_528_77
					var_528_69 = var_528_69 + 0.3

					if var_528_77 + var_528_69 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_77 + var_528_69
					end
				end

				arg_525_1.text_.text = var_528_74
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151124", "story_v_out_322151.awb") ~= 0 then
					local var_528_78 = manager.audio:GetVoiceLength("story_v_out_322151", "322151124", "story_v_out_322151.awb") / 1000

					if var_528_78 + var_528_69 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_78 + var_528_69
					end

					if var_528_73.prefab_name ~= "" and arg_525_1.actors_[var_528_73.prefab_name] ~= nil then
						local var_528_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_73.prefab_name].transform, "story_v_out_322151", "322151124", "story_v_out_322151.awb")

						arg_525_1:RecordAudio("322151124", var_528_79)
						arg_525_1:RecordAudio("322151124", var_528_79)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_322151", "322151124", "story_v_out_322151.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_322151", "322151124", "story_v_out_322151.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_80 = var_528_69 + 0.3
			local var_528_81 = math.max(var_528_70, arg_525_1.talkMaxDuration)

			if var_528_80 <= arg_525_1.time_ and arg_525_1.time_ < var_528_80 + var_528_81 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_80) / var_528_81

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_80 + var_528_81 and arg_525_1.time_ < var_528_80 + var_528_81 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play322151125 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 322151125
		arg_531_1.duration_ = 6.5

		local var_531_0 = {
			zh = 6.5,
			ja = 4.3
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play322151126(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["10100ui_story"].transform
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.var_.moveOldPos10100ui_story = var_534_0.localPosition
			end

			local var_534_2 = 0.001

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2
				local var_534_4 = Vector3.New(0, -1.16, -6.25)

				var_534_0.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos10100ui_story, var_534_4, var_534_3)

				local var_534_5 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_5.x, var_534_5.y, var_534_5.z)

				local var_534_6 = var_534_0.localEulerAngles

				var_534_6.z = 0
				var_534_6.x = 0
				var_534_0.localEulerAngles = var_534_6
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 then
				var_534_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_534_7 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_7.x, var_534_7.y, var_534_7.z)

				local var_534_8 = var_534_0.localEulerAngles

				var_534_8.z = 0
				var_534_8.x = 0
				var_534_0.localEulerAngles = var_534_8
			end

			local var_534_9 = 0

			if var_534_9 < arg_531_1.time_ and arg_531_1.time_ <= var_534_9 + arg_534_0 then
				arg_531_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action24_2")
			end

			local var_534_10 = 0

			if var_534_10 < arg_531_1.time_ and arg_531_1.time_ <= var_534_10 + arg_534_0 then
				arg_531_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_534_11 = 0
			local var_534_12 = 0.5

			if var_534_11 < arg_531_1.time_ and arg_531_1.time_ <= var_534_11 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_13 = arg_531_1:FormatText(StoryNameCfg[1021].name)

				arg_531_1.leftNameTxt_.text = var_534_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_14 = arg_531_1:GetWordFromCfg(322151125)
				local var_534_15 = arg_531_1:FormatText(var_534_14.content)

				arg_531_1.text_.text = var_534_15

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_16 = 20
				local var_534_17 = utf8.len(var_534_15)
				local var_534_18 = var_534_16 <= 0 and var_534_12 or var_534_12 * (var_534_17 / var_534_16)

				if var_534_18 > 0 and var_534_12 < var_534_18 then
					arg_531_1.talkMaxDuration = var_534_18

					if var_534_18 + var_534_11 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_18 + var_534_11
					end
				end

				arg_531_1.text_.text = var_534_15
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151125", "story_v_out_322151.awb") ~= 0 then
					local var_534_19 = manager.audio:GetVoiceLength("story_v_out_322151", "322151125", "story_v_out_322151.awb") / 1000

					if var_534_19 + var_534_11 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_19 + var_534_11
					end

					if var_534_14.prefab_name ~= "" and arg_531_1.actors_[var_534_14.prefab_name] ~= nil then
						local var_534_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_14.prefab_name].transform, "story_v_out_322151", "322151125", "story_v_out_322151.awb")

						arg_531_1:RecordAudio("322151125", var_534_20)
						arg_531_1:RecordAudio("322151125", var_534_20)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_322151", "322151125", "story_v_out_322151.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_322151", "322151125", "story_v_out_322151.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_21 = math.max(var_534_12, arg_531_1.talkMaxDuration)

			if var_534_11 <= arg_531_1.time_ and arg_531_1.time_ < var_534_11 + var_534_21 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_11) / var_534_21

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_11 + var_534_21 and arg_531_1.time_ < var_534_11 + var_534_21 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play322151126 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 322151126
		arg_535_1.duration_ = 5.53

		local var_535_0 = {
			zh = 4.066,
			ja = 5.533
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play322151127(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1089ui_story"].transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPos1089ui_story = var_538_0.localPosition
			end

			local var_538_2 = 0.001

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2
				local var_538_4 = Vector3.New(0.7, -1.1, -6.17)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1089ui_story, var_538_4, var_538_3)

				local var_538_5 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_5.x, var_538_5.y, var_538_5.z)

				local var_538_6 = var_538_0.localEulerAngles

				var_538_6.z = 0
				var_538_6.x = 0
				var_538_0.localEulerAngles = var_538_6
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_538_7 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_7.x, var_538_7.y, var_538_7.z)

				local var_538_8 = var_538_0.localEulerAngles

				var_538_8.z = 0
				var_538_8.x = 0
				var_538_0.localEulerAngles = var_538_8
			end

			local var_538_9 = arg_535_1.actors_["10100ui_story"].transform
			local var_538_10 = 0

			if var_538_10 < arg_535_1.time_ and arg_535_1.time_ <= var_538_10 + arg_538_0 then
				arg_535_1.var_.moveOldPos10100ui_story = var_538_9.localPosition
			end

			local var_538_11 = 0.001

			if var_538_10 <= arg_535_1.time_ and arg_535_1.time_ < var_538_10 + var_538_11 then
				local var_538_12 = (arg_535_1.time_ - var_538_10) / var_538_11
				local var_538_13 = Vector3.New(-0.7, -1.16, -6.25)

				var_538_9.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10100ui_story, var_538_13, var_538_12)

				local var_538_14 = manager.ui.mainCamera.transform.position - var_538_9.position

				var_538_9.forward = Vector3.New(var_538_14.x, var_538_14.y, var_538_14.z)

				local var_538_15 = var_538_9.localEulerAngles

				var_538_15.z = 0
				var_538_15.x = 0
				var_538_9.localEulerAngles = var_538_15
			end

			if arg_535_1.time_ >= var_538_10 + var_538_11 and arg_535_1.time_ < var_538_10 + var_538_11 + arg_538_0 then
				var_538_9.localPosition = Vector3.New(-0.7, -1.16, -6.25)

				local var_538_16 = manager.ui.mainCamera.transform.position - var_538_9.position

				var_538_9.forward = Vector3.New(var_538_16.x, var_538_16.y, var_538_16.z)

				local var_538_17 = var_538_9.localEulerAngles

				var_538_17.z = 0
				var_538_17.x = 0
				var_538_9.localEulerAngles = var_538_17
			end

			local var_538_18 = arg_535_1.actors_["1089ui_story"]
			local var_538_19 = 0

			if var_538_19 < arg_535_1.time_ and arg_535_1.time_ <= var_538_19 + arg_538_0 and not isNil(var_538_18) and arg_535_1.var_.characterEffect1089ui_story == nil then
				arg_535_1.var_.characterEffect1089ui_story = var_538_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_20 = 0.200000002980232

			if var_538_19 <= arg_535_1.time_ and arg_535_1.time_ < var_538_19 + var_538_20 and not isNil(var_538_18) then
				local var_538_21 = (arg_535_1.time_ - var_538_19) / var_538_20

				if arg_535_1.var_.characterEffect1089ui_story and not isNil(var_538_18) then
					arg_535_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= var_538_19 + var_538_20 and arg_535_1.time_ < var_538_19 + var_538_20 + arg_538_0 and not isNil(var_538_18) and arg_535_1.var_.characterEffect1089ui_story then
				arg_535_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_538_22 = arg_535_1.actors_["10100ui_story"]
			local var_538_23 = 0

			if var_538_23 < arg_535_1.time_ and arg_535_1.time_ <= var_538_23 + arg_538_0 and not isNil(var_538_22) and arg_535_1.var_.characterEffect10100ui_story == nil then
				arg_535_1.var_.characterEffect10100ui_story = var_538_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_24 = 0.200000002980232

			if var_538_23 <= arg_535_1.time_ and arg_535_1.time_ < var_538_23 + var_538_24 and not isNil(var_538_22) then
				local var_538_25 = (arg_535_1.time_ - var_538_23) / var_538_24

				if arg_535_1.var_.characterEffect10100ui_story and not isNil(var_538_22) then
					local var_538_26 = Mathf.Lerp(0, 0.5, var_538_25)

					arg_535_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_535_1.var_.characterEffect10100ui_story.fillRatio = var_538_26
				end
			end

			if arg_535_1.time_ >= var_538_23 + var_538_24 and arg_535_1.time_ < var_538_23 + var_538_24 + arg_538_0 and not isNil(var_538_22) and arg_535_1.var_.characterEffect10100ui_story then
				local var_538_27 = 0.5

				arg_535_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_535_1.var_.characterEffect10100ui_story.fillRatio = var_538_27
			end

			local var_538_28 = 0

			if var_538_28 < arg_535_1.time_ and arg_535_1.time_ <= var_538_28 + arg_538_0 then
				arg_535_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_538_29 = 0

			if var_538_29 < arg_535_1.time_ and arg_535_1.time_ <= var_538_29 + arg_538_0 then
				arg_535_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_538_30 = 0
			local var_538_31 = 0.325

			if var_538_30 < arg_535_1.time_ and arg_535_1.time_ <= var_538_30 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_32 = arg_535_1:FormatText(StoryNameCfg[1031].name)

				arg_535_1.leftNameTxt_.text = var_538_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_33 = arg_535_1:GetWordFromCfg(322151126)
				local var_538_34 = arg_535_1:FormatText(var_538_33.content)

				arg_535_1.text_.text = var_538_34

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_35 = 13
				local var_538_36 = utf8.len(var_538_34)
				local var_538_37 = var_538_35 <= 0 and var_538_31 or var_538_31 * (var_538_36 / var_538_35)

				if var_538_37 > 0 and var_538_31 < var_538_37 then
					arg_535_1.talkMaxDuration = var_538_37

					if var_538_37 + var_538_30 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_37 + var_538_30
					end
				end

				arg_535_1.text_.text = var_538_34
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151126", "story_v_out_322151.awb") ~= 0 then
					local var_538_38 = manager.audio:GetVoiceLength("story_v_out_322151", "322151126", "story_v_out_322151.awb") / 1000

					if var_538_38 + var_538_30 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_38 + var_538_30
					end

					if var_538_33.prefab_name ~= "" and arg_535_1.actors_[var_538_33.prefab_name] ~= nil then
						local var_538_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_33.prefab_name].transform, "story_v_out_322151", "322151126", "story_v_out_322151.awb")

						arg_535_1:RecordAudio("322151126", var_538_39)
						arg_535_1:RecordAudio("322151126", var_538_39)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_322151", "322151126", "story_v_out_322151.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_322151", "322151126", "story_v_out_322151.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_40 = math.max(var_538_31, arg_535_1.talkMaxDuration)

			if var_538_30 <= arg_535_1.time_ and arg_535_1.time_ < var_538_30 + var_538_40 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_30) / var_538_40

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_30 + var_538_40 and arg_535_1.time_ < var_538_30 + var_538_40 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play322151127 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 322151127
		arg_539_1.duration_ = 9.2

		local var_539_0 = {
			zh = 6.4,
			ja = 9.2
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play322151128(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["10100ui_story"].transform
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.var_.moveOldPos10100ui_story = var_542_0.localPosition
			end

			local var_542_2 = 0.001

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2
				local var_542_4 = Vector3.New(-0.7, -1.16, -6.25)

				var_542_0.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos10100ui_story, var_542_4, var_542_3)

				local var_542_5 = manager.ui.mainCamera.transform.position - var_542_0.position

				var_542_0.forward = Vector3.New(var_542_5.x, var_542_5.y, var_542_5.z)

				local var_542_6 = var_542_0.localEulerAngles

				var_542_6.z = 0
				var_542_6.x = 0
				var_542_0.localEulerAngles = var_542_6
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 then
				var_542_0.localPosition = Vector3.New(-0.7, -1.16, -6.25)

				local var_542_7 = manager.ui.mainCamera.transform.position - var_542_0.position

				var_542_0.forward = Vector3.New(var_542_7.x, var_542_7.y, var_542_7.z)

				local var_542_8 = var_542_0.localEulerAngles

				var_542_8.z = 0
				var_542_8.x = 0
				var_542_0.localEulerAngles = var_542_8
			end

			local var_542_9 = arg_539_1.actors_["10100ui_story"]
			local var_542_10 = 0

			if var_542_10 < arg_539_1.time_ and arg_539_1.time_ <= var_542_10 + arg_542_0 and not isNil(var_542_9) and arg_539_1.var_.characterEffect10100ui_story == nil then
				arg_539_1.var_.characterEffect10100ui_story = var_542_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_11 = 0.200000002980232

			if var_542_10 <= arg_539_1.time_ and arg_539_1.time_ < var_542_10 + var_542_11 and not isNil(var_542_9) then
				local var_542_12 = (arg_539_1.time_ - var_542_10) / var_542_11

				if arg_539_1.var_.characterEffect10100ui_story and not isNil(var_542_9) then
					arg_539_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= var_542_10 + var_542_11 and arg_539_1.time_ < var_542_10 + var_542_11 + arg_542_0 and not isNil(var_542_9) and arg_539_1.var_.characterEffect10100ui_story then
				arg_539_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_542_13 = arg_539_1.actors_["1089ui_story"]
			local var_542_14 = 0

			if var_542_14 < arg_539_1.time_ and arg_539_1.time_ <= var_542_14 + arg_542_0 and not isNil(var_542_13) and arg_539_1.var_.characterEffect1089ui_story == nil then
				arg_539_1.var_.characterEffect1089ui_story = var_542_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_15 = 0.200000002980232

			if var_542_14 <= arg_539_1.time_ and arg_539_1.time_ < var_542_14 + var_542_15 and not isNil(var_542_13) then
				local var_542_16 = (arg_539_1.time_ - var_542_14) / var_542_15

				if arg_539_1.var_.characterEffect1089ui_story and not isNil(var_542_13) then
					local var_542_17 = Mathf.Lerp(0, 0.5, var_542_16)

					arg_539_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1089ui_story.fillRatio = var_542_17
				end
			end

			if arg_539_1.time_ >= var_542_14 + var_542_15 and arg_539_1.time_ < var_542_14 + var_542_15 + arg_542_0 and not isNil(var_542_13) and arg_539_1.var_.characterEffect1089ui_story then
				local var_542_18 = 0.5

				arg_539_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1089ui_story.fillRatio = var_542_18
			end

			local var_542_19 = 0

			if var_542_19 < arg_539_1.time_ and arg_539_1.time_ <= var_542_19 + arg_542_0 then
				arg_539_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action20_1")
			end

			local var_542_20 = 0

			if var_542_20 < arg_539_1.time_ and arg_539_1.time_ <= var_542_20 + arg_542_0 then
				arg_539_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_542_21 = 0
			local var_542_22 = 0.6

			if var_542_21 < arg_539_1.time_ and arg_539_1.time_ <= var_542_21 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_23 = arg_539_1:FormatText(StoryNameCfg[1021].name)

				arg_539_1.leftNameTxt_.text = var_542_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_24 = arg_539_1:GetWordFromCfg(322151127)
				local var_542_25 = arg_539_1:FormatText(var_542_24.content)

				arg_539_1.text_.text = var_542_25

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_26 = 24
				local var_542_27 = utf8.len(var_542_25)
				local var_542_28 = var_542_26 <= 0 and var_542_22 or var_542_22 * (var_542_27 / var_542_26)

				if var_542_28 > 0 and var_542_22 < var_542_28 then
					arg_539_1.talkMaxDuration = var_542_28

					if var_542_28 + var_542_21 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_28 + var_542_21
					end
				end

				arg_539_1.text_.text = var_542_25
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151127", "story_v_out_322151.awb") ~= 0 then
					local var_542_29 = manager.audio:GetVoiceLength("story_v_out_322151", "322151127", "story_v_out_322151.awb") / 1000

					if var_542_29 + var_542_21 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_29 + var_542_21
					end

					if var_542_24.prefab_name ~= "" and arg_539_1.actors_[var_542_24.prefab_name] ~= nil then
						local var_542_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_24.prefab_name].transform, "story_v_out_322151", "322151127", "story_v_out_322151.awb")

						arg_539_1:RecordAudio("322151127", var_542_30)
						arg_539_1:RecordAudio("322151127", var_542_30)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_322151", "322151127", "story_v_out_322151.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_322151", "322151127", "story_v_out_322151.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_31 = math.max(var_542_22, arg_539_1.talkMaxDuration)

			if var_542_21 <= arg_539_1.time_ and arg_539_1.time_ < var_542_21 + var_542_31 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_21) / var_542_31

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_21 + var_542_31 and arg_539_1.time_ < var_542_21 + var_542_31 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play322151128 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 322151128
		arg_543_1.duration_ = 11.2

		local var_543_0 = {
			zh = 11.2,
			ja = 6.5
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play322151129(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = "L08f"

			if arg_543_1.bgs_[var_546_0] == nil then
				local var_546_1 = Object.Instantiate(arg_543_1.paintGo_)

				var_546_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_546_0)
				var_546_1.name = var_546_0
				var_546_1.transform.parent = arg_543_1.stage_.transform
				var_546_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_543_1.bgs_[var_546_0] = var_546_1
			end

			local var_546_2 = 2

			if var_546_2 < arg_543_1.time_ and arg_543_1.time_ <= var_546_2 + arg_546_0 then
				local var_546_3 = manager.ui.mainCamera.transform.localPosition
				local var_546_4 = Vector3.New(0, 0, 10) + Vector3.New(var_546_3.x, var_546_3.y, 0)
				local var_546_5 = arg_543_1.bgs_.L08f

				var_546_5.transform.localPosition = var_546_4
				var_546_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_546_6 = var_546_5:GetComponent("SpriteRenderer")

				if var_546_6 and var_546_6.sprite then
					local var_546_7 = (var_546_5.transform.localPosition - var_546_3).z
					local var_546_8 = manager.ui.mainCameraCom_
					local var_546_9 = 2 * var_546_7 * Mathf.Tan(var_546_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_546_10 = var_546_9 * var_546_8.aspect
					local var_546_11 = var_546_6.sprite.bounds.size.x
					local var_546_12 = var_546_6.sprite.bounds.size.y
					local var_546_13 = var_546_10 / var_546_11
					local var_546_14 = var_546_9 / var_546_12
					local var_546_15 = var_546_14 < var_546_13 and var_546_13 or var_546_14

					var_546_5.transform.localScale = Vector3.New(var_546_15, var_546_15, 0)
				end

				for iter_546_0, iter_546_1 in pairs(arg_543_1.bgs_) do
					if iter_546_0 ~= "L08f" then
						iter_546_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_546_16 = 4

			if var_546_16 < arg_543_1.time_ and arg_543_1.time_ <= var_546_16 + arg_546_0 then
				arg_543_1.allBtn_.enabled = false
			end

			local var_546_17 = 0.3

			if arg_543_1.time_ >= var_546_16 + var_546_17 and arg_543_1.time_ < var_546_16 + var_546_17 + arg_546_0 then
				arg_543_1.allBtn_.enabled = true
			end

			local var_546_18 = 0

			if var_546_18 < arg_543_1.time_ and arg_543_1.time_ <= var_546_18 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_19 = 2

			if var_546_18 <= arg_543_1.time_ and arg_543_1.time_ < var_546_18 + var_546_19 then
				local var_546_20 = (arg_543_1.time_ - var_546_18) / var_546_19
				local var_546_21 = Color.New(0, 0, 0)

				var_546_21.a = Mathf.Lerp(0, 1, var_546_20)
				arg_543_1.mask_.color = var_546_21
			end

			if arg_543_1.time_ >= var_546_18 + var_546_19 and arg_543_1.time_ < var_546_18 + var_546_19 + arg_546_0 then
				local var_546_22 = Color.New(0, 0, 0)

				var_546_22.a = 1
				arg_543_1.mask_.color = var_546_22
			end

			local var_546_23 = 2

			if var_546_23 < arg_543_1.time_ and arg_543_1.time_ <= var_546_23 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_24 = 2

			if var_546_23 <= arg_543_1.time_ and arg_543_1.time_ < var_546_23 + var_546_24 then
				local var_546_25 = (arg_543_1.time_ - var_546_23) / var_546_24
				local var_546_26 = Color.New(0, 0, 0)

				var_546_26.a = Mathf.Lerp(1, 0, var_546_25)
				arg_543_1.mask_.color = var_546_26
			end

			if arg_543_1.time_ >= var_546_23 + var_546_24 and arg_543_1.time_ < var_546_23 + var_546_24 + arg_546_0 then
				local var_546_27 = Color.New(0, 0, 0)
				local var_546_28 = 0

				arg_543_1.mask_.enabled = false
				var_546_27.a = var_546_28
				arg_543_1.mask_.color = var_546_27
			end

			local var_546_29 = arg_543_1.actors_["10100ui_story"].transform
			local var_546_30 = 1.96599999815226

			if var_546_30 < arg_543_1.time_ and arg_543_1.time_ <= var_546_30 + arg_546_0 then
				arg_543_1.var_.moveOldPos10100ui_story = var_546_29.localPosition
			end

			local var_546_31 = 0.001

			if var_546_30 <= arg_543_1.time_ and arg_543_1.time_ < var_546_30 + var_546_31 then
				local var_546_32 = (arg_543_1.time_ - var_546_30) / var_546_31
				local var_546_33 = Vector3.New(0, 100, 0)

				var_546_29.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos10100ui_story, var_546_33, var_546_32)

				local var_546_34 = manager.ui.mainCamera.transform.position - var_546_29.position

				var_546_29.forward = Vector3.New(var_546_34.x, var_546_34.y, var_546_34.z)

				local var_546_35 = var_546_29.localEulerAngles

				var_546_35.z = 0
				var_546_35.x = 0
				var_546_29.localEulerAngles = var_546_35
			end

			if arg_543_1.time_ >= var_546_30 + var_546_31 and arg_543_1.time_ < var_546_30 + var_546_31 + arg_546_0 then
				var_546_29.localPosition = Vector3.New(0, 100, 0)

				local var_546_36 = manager.ui.mainCamera.transform.position - var_546_29.position

				var_546_29.forward = Vector3.New(var_546_36.x, var_546_36.y, var_546_36.z)

				local var_546_37 = var_546_29.localEulerAngles

				var_546_37.z = 0
				var_546_37.x = 0
				var_546_29.localEulerAngles = var_546_37
			end

			local var_546_38 = arg_543_1.actors_["1089ui_story"].transform
			local var_546_39 = 1.96599999815226

			if var_546_39 < arg_543_1.time_ and arg_543_1.time_ <= var_546_39 + arg_546_0 then
				arg_543_1.var_.moveOldPos1089ui_story = var_546_38.localPosition
			end

			local var_546_40 = 0.001

			if var_546_39 <= arg_543_1.time_ and arg_543_1.time_ < var_546_39 + var_546_40 then
				local var_546_41 = (arg_543_1.time_ - var_546_39) / var_546_40
				local var_546_42 = Vector3.New(0, 100, 0)

				var_546_38.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1089ui_story, var_546_42, var_546_41)

				local var_546_43 = manager.ui.mainCamera.transform.position - var_546_38.position

				var_546_38.forward = Vector3.New(var_546_43.x, var_546_43.y, var_546_43.z)

				local var_546_44 = var_546_38.localEulerAngles

				var_546_44.z = 0
				var_546_44.x = 0
				var_546_38.localEulerAngles = var_546_44
			end

			if arg_543_1.time_ >= var_546_39 + var_546_40 and arg_543_1.time_ < var_546_39 + var_546_40 + arg_546_0 then
				var_546_38.localPosition = Vector3.New(0, 100, 0)

				local var_546_45 = manager.ui.mainCamera.transform.position - var_546_38.position

				var_546_38.forward = Vector3.New(var_546_45.x, var_546_45.y, var_546_45.z)

				local var_546_46 = var_546_38.localEulerAngles

				var_546_46.z = 0
				var_546_46.x = 0
				var_546_38.localEulerAngles = var_546_46
			end

			local var_546_47 = "1052ui_story"

			if arg_543_1.actors_[var_546_47] == nil then
				local var_546_48 = Asset.Load("Char/" .. "1052ui_story")

				if not isNil(var_546_48) then
					local var_546_49 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_543_1.stage_.transform)

					var_546_49.name = var_546_47
					var_546_49.transform.localPosition = Vector3.New(0, 100, 0)
					arg_543_1.actors_[var_546_47] = var_546_49

					local var_546_50 = var_546_49:GetComponentInChildren(typeof(CharacterEffect))

					var_546_50.enabled = true

					local var_546_51 = GameObjectTools.GetOrAddComponent(var_546_49, typeof(DynamicBoneHelper))

					if var_546_51 then
						var_546_51:EnableDynamicBone(false)
					end

					arg_543_1:ShowWeapon(var_546_50.transform, false)

					arg_543_1.var_[var_546_47 .. "Animator"] = var_546_50.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_543_1.var_[var_546_47 .. "Animator"].applyRootMotion = true
					arg_543_1.var_[var_546_47 .. "LipSync"] = var_546_50.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_546_52 = arg_543_1.actors_["1052ui_story"].transform
			local var_546_53 = 3.8

			if var_546_53 < arg_543_1.time_ and arg_543_1.time_ <= var_546_53 + arg_546_0 then
				arg_543_1.var_.moveOldPos1052ui_story = var_546_52.localPosition
			end

			local var_546_54 = 0.001

			if var_546_53 <= arg_543_1.time_ and arg_543_1.time_ < var_546_53 + var_546_54 then
				local var_546_55 = (arg_543_1.time_ - var_546_53) / var_546_54
				local var_546_56 = Vector3.New(0, -1.05, -6.2)

				var_546_52.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1052ui_story, var_546_56, var_546_55)

				local var_546_57 = manager.ui.mainCamera.transform.position - var_546_52.position

				var_546_52.forward = Vector3.New(var_546_57.x, var_546_57.y, var_546_57.z)

				local var_546_58 = var_546_52.localEulerAngles

				var_546_58.z = 0
				var_546_58.x = 0
				var_546_52.localEulerAngles = var_546_58
			end

			if arg_543_1.time_ >= var_546_53 + var_546_54 and arg_543_1.time_ < var_546_53 + var_546_54 + arg_546_0 then
				var_546_52.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_546_59 = manager.ui.mainCamera.transform.position - var_546_52.position

				var_546_52.forward = Vector3.New(var_546_59.x, var_546_59.y, var_546_59.z)

				local var_546_60 = var_546_52.localEulerAngles

				var_546_60.z = 0
				var_546_60.x = 0
				var_546_52.localEulerAngles = var_546_60
			end

			local var_546_61 = arg_543_1.actors_["1052ui_story"]
			local var_546_62 = 3.8

			if var_546_62 < arg_543_1.time_ and arg_543_1.time_ <= var_546_62 + arg_546_0 and not isNil(var_546_61) and arg_543_1.var_.characterEffect1052ui_story == nil then
				arg_543_1.var_.characterEffect1052ui_story = var_546_61:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_63 = 0.200000002980232

			if var_546_62 <= arg_543_1.time_ and arg_543_1.time_ < var_546_62 + var_546_63 and not isNil(var_546_61) then
				local var_546_64 = (arg_543_1.time_ - var_546_62) / var_546_63

				if arg_543_1.var_.characterEffect1052ui_story and not isNil(var_546_61) then
					arg_543_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_62 + var_546_63 and arg_543_1.time_ < var_546_62 + var_546_63 + arg_546_0 and not isNil(var_546_61) and arg_543_1.var_.characterEffect1052ui_story then
				arg_543_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_546_65 = 3.8

			if var_546_65 < arg_543_1.time_ and arg_543_1.time_ <= var_546_65 + arg_546_0 then
				arg_543_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_546_66 = 3.8

			if var_546_66 < arg_543_1.time_ and arg_543_1.time_ <= var_546_66 + arg_546_0 then
				arg_543_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_546_67 = 0.2
			local var_546_68 = 1

			if var_546_67 < arg_543_1.time_ and arg_543_1.time_ <= var_546_67 + arg_546_0 then
				local var_546_69 = "stop"
				local var_546_70 = "effect"

				arg_543_1:AudioAction(var_546_69, var_546_70, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_546_71 = 1.53333333333333
			local var_546_72 = 1

			if var_546_71 < arg_543_1.time_ and arg_543_1.time_ <= var_546_71 + arg_546_0 then
				local var_546_73 = "play"
				local var_546_74 = "effect"

				arg_543_1:AudioAction(var_546_73, var_546_74, "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_543_1.frameCnt_ <= 1 then
				arg_543_1.dialog_:SetActive(false)
			end

			local var_546_75 = 4
			local var_546_76 = 0.25

			if var_546_75 < arg_543_1.time_ and arg_543_1.time_ <= var_546_75 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				arg_543_1.dialog_:SetActive(true)

				arg_543_1.dialogCg_.alpha = 0

				local var_546_77 = LeanTween.value(arg_543_1.dialog_, 0, 1, 0.3)

				var_546_77:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_543_1.dialogCg_.alpha = arg_547_0
				end))
				var_546_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_543_1.dialog_)
					var_546_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_543_1.duration_ = arg_543_1.duration_ + 0.3

				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_78 = arg_543_1:FormatText(StoryNameCfg[263].name)

				arg_543_1.leftNameTxt_.text = var_546_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_79 = arg_543_1:GetWordFromCfg(322151128)
				local var_546_80 = arg_543_1:FormatText(var_546_79.content)

				arg_543_1.text_.text = var_546_80

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_81 = 10
				local var_546_82 = utf8.len(var_546_80)
				local var_546_83 = var_546_81 <= 0 and var_546_76 or var_546_76 * (var_546_82 / var_546_81)

				if var_546_83 > 0 and var_546_76 < var_546_83 then
					arg_543_1.talkMaxDuration = var_546_83
					var_546_75 = var_546_75 + 0.3

					if var_546_83 + var_546_75 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_83 + var_546_75
					end
				end

				arg_543_1.text_.text = var_546_80
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151128", "story_v_out_322151.awb") ~= 0 then
					local var_546_84 = manager.audio:GetVoiceLength("story_v_out_322151", "322151128", "story_v_out_322151.awb") / 1000

					if var_546_84 + var_546_75 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_84 + var_546_75
					end

					if var_546_79.prefab_name ~= "" and arg_543_1.actors_[var_546_79.prefab_name] ~= nil then
						local var_546_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_79.prefab_name].transform, "story_v_out_322151", "322151128", "story_v_out_322151.awb")

						arg_543_1:RecordAudio("322151128", var_546_85)
						arg_543_1:RecordAudio("322151128", var_546_85)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_322151", "322151128", "story_v_out_322151.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_322151", "322151128", "story_v_out_322151.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_86 = var_546_75 + 0.3
			local var_546_87 = math.max(var_546_76, arg_543_1.talkMaxDuration)

			if var_546_86 <= arg_543_1.time_ and arg_543_1.time_ < var_546_86 + var_546_87 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_86) / var_546_87

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_86 + var_546_87 and arg_543_1.time_ < var_546_86 + var_546_87 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play322151129 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 322151129
		arg_549_1.duration_ = 2.8

		local var_549_0 = {
			zh = 2.333,
			ja = 2.8
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play322151130(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action5_1")
			end

			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_552_2 = 0
			local var_552_3 = 0.25

			if var_552_2 < arg_549_1.time_ and arg_549_1.time_ <= var_552_2 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_4 = arg_549_1:FormatText(StoryNameCfg[263].name)

				arg_549_1.leftNameTxt_.text = var_552_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_5 = arg_549_1:GetWordFromCfg(322151129)
				local var_552_6 = arg_549_1:FormatText(var_552_5.content)

				arg_549_1.text_.text = var_552_6

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_7 = 10
				local var_552_8 = utf8.len(var_552_6)
				local var_552_9 = var_552_7 <= 0 and var_552_3 or var_552_3 * (var_552_8 / var_552_7)

				if var_552_9 > 0 and var_552_3 < var_552_9 then
					arg_549_1.talkMaxDuration = var_552_9

					if var_552_9 + var_552_2 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_9 + var_552_2
					end
				end

				arg_549_1.text_.text = var_552_6
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151129", "story_v_out_322151.awb") ~= 0 then
					local var_552_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151129", "story_v_out_322151.awb") / 1000

					if var_552_10 + var_552_2 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_10 + var_552_2
					end

					if var_552_5.prefab_name ~= "" and arg_549_1.actors_[var_552_5.prefab_name] ~= nil then
						local var_552_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_5.prefab_name].transform, "story_v_out_322151", "322151129", "story_v_out_322151.awb")

						arg_549_1:RecordAudio("322151129", var_552_11)
						arg_549_1:RecordAudio("322151129", var_552_11)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_322151", "322151129", "story_v_out_322151.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_322151", "322151129", "story_v_out_322151.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_12 = math.max(var_552_3, arg_549_1.talkMaxDuration)

			if var_552_2 <= arg_549_1.time_ and arg_549_1.time_ < var_552_2 + var_552_12 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_2) / var_552_12

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_2 + var_552_12 and arg_549_1.time_ < var_552_2 + var_552_12 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play322151130 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 322151130
		arg_553_1.duration_ = 4.3

		local var_553_0 = {
			zh = 2.966,
			ja = 4.3
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play322151131(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1052ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1052ui_story == nil then
				arg_553_1.var_.characterEffect1052ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect1052ui_story and not isNil(var_556_0) then
					local var_556_4 = Mathf.Lerp(0, 0.5, var_556_3)

					arg_553_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1052ui_story.fillRatio = var_556_4
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1052ui_story then
				local var_556_5 = 0.5

				arg_553_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1052ui_story.fillRatio = var_556_5
			end

			local var_556_6 = 0
			local var_556_7 = 0.35

			if var_556_6 < arg_553_1.time_ and arg_553_1.time_ <= var_556_6 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_8 = arg_553_1:FormatText(StoryNameCfg[1167].name)

				arg_553_1.leftNameTxt_.text = var_556_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_9 = arg_553_1:GetWordFromCfg(322151130)
				local var_556_10 = arg_553_1:FormatText(var_556_9.content)

				arg_553_1.text_.text = var_556_10

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_11 = 14
				local var_556_12 = utf8.len(var_556_10)
				local var_556_13 = var_556_11 <= 0 and var_556_7 or var_556_7 * (var_556_12 / var_556_11)

				if var_556_13 > 0 and var_556_7 < var_556_13 then
					arg_553_1.talkMaxDuration = var_556_13

					if var_556_13 + var_556_6 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_13 + var_556_6
					end
				end

				arg_553_1.text_.text = var_556_10
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151130", "story_v_out_322151.awb") ~= 0 then
					local var_556_14 = manager.audio:GetVoiceLength("story_v_out_322151", "322151130", "story_v_out_322151.awb") / 1000

					if var_556_14 + var_556_6 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_14 + var_556_6
					end

					if var_556_9.prefab_name ~= "" and arg_553_1.actors_[var_556_9.prefab_name] ~= nil then
						local var_556_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_9.prefab_name].transform, "story_v_out_322151", "322151130", "story_v_out_322151.awb")

						arg_553_1:RecordAudio("322151130", var_556_15)
						arg_553_1:RecordAudio("322151130", var_556_15)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_322151", "322151130", "story_v_out_322151.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_322151", "322151130", "story_v_out_322151.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_16 = math.max(var_556_7, arg_553_1.talkMaxDuration)

			if var_556_6 <= arg_553_1.time_ and arg_553_1.time_ < var_556_6 + var_556_16 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_6) / var_556_16

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_6 + var_556_16 and arg_553_1.time_ < var_556_6 + var_556_16 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play322151131 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 322151131
		arg_557_1.duration_ = 8.33

		local var_557_0 = {
			zh = 8.333,
			ja = 6.366
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play322151132(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1052ui_story"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1052ui_story == nil then
				arg_557_1.var_.characterEffect1052ui_story = var_560_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.200000002980232

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.characterEffect1052ui_story and not isNil(var_560_0) then
					arg_557_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1052ui_story then
				arg_557_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_560_4 = 0

			if var_560_4 < arg_557_1.time_ and arg_557_1.time_ <= var_560_4 + arg_560_0 then
				arg_557_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action5_2")
			end

			local var_560_5 = 0

			if var_560_5 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_560_6 = 0
			local var_560_7 = 0.5

			if var_560_6 < arg_557_1.time_ and arg_557_1.time_ <= var_560_6 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_8 = arg_557_1:FormatText(StoryNameCfg[263].name)

				arg_557_1.leftNameTxt_.text = var_560_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_9 = arg_557_1:GetWordFromCfg(322151131)
				local var_560_10 = arg_557_1:FormatText(var_560_9.content)

				arg_557_1.text_.text = var_560_10

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_11 = 20
				local var_560_12 = utf8.len(var_560_10)
				local var_560_13 = var_560_11 <= 0 and var_560_7 or var_560_7 * (var_560_12 / var_560_11)

				if var_560_13 > 0 and var_560_7 < var_560_13 then
					arg_557_1.talkMaxDuration = var_560_13

					if var_560_13 + var_560_6 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_13 + var_560_6
					end
				end

				arg_557_1.text_.text = var_560_10
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151131", "story_v_out_322151.awb") ~= 0 then
					local var_560_14 = manager.audio:GetVoiceLength("story_v_out_322151", "322151131", "story_v_out_322151.awb") / 1000

					if var_560_14 + var_560_6 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_14 + var_560_6
					end

					if var_560_9.prefab_name ~= "" and arg_557_1.actors_[var_560_9.prefab_name] ~= nil then
						local var_560_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_9.prefab_name].transform, "story_v_out_322151", "322151131", "story_v_out_322151.awb")

						arg_557_1:RecordAudio("322151131", var_560_15)
						arg_557_1:RecordAudio("322151131", var_560_15)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_322151", "322151131", "story_v_out_322151.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_322151", "322151131", "story_v_out_322151.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_16 = math.max(var_560_7, arg_557_1.talkMaxDuration)

			if var_560_6 <= arg_557_1.time_ and arg_557_1.time_ < var_560_6 + var_560_16 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_6) / var_560_16

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_6 + var_560_16 and arg_557_1.time_ < var_560_6 + var_560_16 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play322151132 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 322151132
		arg_561_1.duration_ = 6.73

		local var_561_0 = {
			zh = 6.6,
			ja = 6.733
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play322151133(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = "ST0507a"

			if arg_561_1.bgs_[var_564_0] == nil then
				local var_564_1 = Object.Instantiate(arg_561_1.paintGo_)

				var_564_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_564_0)
				var_564_1.name = var_564_0
				var_564_1.transform.parent = arg_561_1.stage_.transform
				var_564_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_561_1.bgs_[var_564_0] = var_564_1
			end

			local var_564_2 = 2

			if var_564_2 < arg_561_1.time_ and arg_561_1.time_ <= var_564_2 + arg_564_0 then
				local var_564_3 = manager.ui.mainCamera.transform.localPosition
				local var_564_4 = Vector3.New(0, 0, 10) + Vector3.New(var_564_3.x, var_564_3.y, 0)
				local var_564_5 = arg_561_1.bgs_.ST0507a

				var_564_5.transform.localPosition = var_564_4
				var_564_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_564_6 = var_564_5:GetComponent("SpriteRenderer")

				if var_564_6 and var_564_6.sprite then
					local var_564_7 = (var_564_5.transform.localPosition - var_564_3).z
					local var_564_8 = manager.ui.mainCameraCom_
					local var_564_9 = 2 * var_564_7 * Mathf.Tan(var_564_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_564_10 = var_564_9 * var_564_8.aspect
					local var_564_11 = var_564_6.sprite.bounds.size.x
					local var_564_12 = var_564_6.sprite.bounds.size.y
					local var_564_13 = var_564_10 / var_564_11
					local var_564_14 = var_564_9 / var_564_12
					local var_564_15 = var_564_14 < var_564_13 and var_564_13 or var_564_14

					var_564_5.transform.localScale = Vector3.New(var_564_15, var_564_15, 0)
				end

				for iter_564_0, iter_564_1 in pairs(arg_561_1.bgs_) do
					if iter_564_0 ~= "ST0507a" then
						iter_564_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_564_16 = 4

			if var_564_16 < arg_561_1.time_ and arg_561_1.time_ <= var_564_16 + arg_564_0 then
				arg_561_1.allBtn_.enabled = false
			end

			local var_564_17 = 0.3

			if arg_561_1.time_ >= var_564_16 + var_564_17 and arg_561_1.time_ < var_564_16 + var_564_17 + arg_564_0 then
				arg_561_1.allBtn_.enabled = true
			end

			local var_564_18 = 0

			if var_564_18 < arg_561_1.time_ and arg_561_1.time_ <= var_564_18 + arg_564_0 then
				arg_561_1.mask_.enabled = true
				arg_561_1.mask_.raycastTarget = true

				arg_561_1:SetGaussion(false)
			end

			local var_564_19 = 2

			if var_564_18 <= arg_561_1.time_ and arg_561_1.time_ < var_564_18 + var_564_19 then
				local var_564_20 = (arg_561_1.time_ - var_564_18) / var_564_19
				local var_564_21 = Color.New(0, 0, 0)

				var_564_21.a = Mathf.Lerp(0, 1, var_564_20)
				arg_561_1.mask_.color = var_564_21
			end

			if arg_561_1.time_ >= var_564_18 + var_564_19 and arg_561_1.time_ < var_564_18 + var_564_19 + arg_564_0 then
				local var_564_22 = Color.New(0, 0, 0)

				var_564_22.a = 1
				arg_561_1.mask_.color = var_564_22
			end

			local var_564_23 = 2

			if var_564_23 < arg_561_1.time_ and arg_561_1.time_ <= var_564_23 + arg_564_0 then
				arg_561_1.mask_.enabled = true
				arg_561_1.mask_.raycastTarget = true

				arg_561_1:SetGaussion(false)
			end

			local var_564_24 = 2

			if var_564_23 <= arg_561_1.time_ and arg_561_1.time_ < var_564_23 + var_564_24 then
				local var_564_25 = (arg_561_1.time_ - var_564_23) / var_564_24
				local var_564_26 = Color.New(0, 0, 0)

				var_564_26.a = Mathf.Lerp(1, 0, var_564_25)
				arg_561_1.mask_.color = var_564_26
			end

			if arg_561_1.time_ >= var_564_23 + var_564_24 and arg_561_1.time_ < var_564_23 + var_564_24 + arg_564_0 then
				local var_564_27 = Color.New(0, 0, 0)
				local var_564_28 = 0

				arg_561_1.mask_.enabled = false
				var_564_27.a = var_564_28
				arg_561_1.mask_.color = var_564_27
			end

			local var_564_29 = arg_561_1.actors_["1052ui_story"].transform
			local var_564_30 = 2

			if var_564_30 < arg_561_1.time_ and arg_561_1.time_ <= var_564_30 + arg_564_0 then
				arg_561_1.var_.moveOldPos1052ui_story = var_564_29.localPosition
			end

			local var_564_31 = 0.001

			if var_564_30 <= arg_561_1.time_ and arg_561_1.time_ < var_564_30 + var_564_31 then
				local var_564_32 = (arg_561_1.time_ - var_564_30) / var_564_31
				local var_564_33 = Vector3.New(0, 100, 0)

				var_564_29.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1052ui_story, var_564_33, var_564_32)

				local var_564_34 = manager.ui.mainCamera.transform.position - var_564_29.position

				var_564_29.forward = Vector3.New(var_564_34.x, var_564_34.y, var_564_34.z)

				local var_564_35 = var_564_29.localEulerAngles

				var_564_35.z = 0
				var_564_35.x = 0
				var_564_29.localEulerAngles = var_564_35
			end

			if arg_561_1.time_ >= var_564_30 + var_564_31 and arg_561_1.time_ < var_564_30 + var_564_31 + arg_564_0 then
				var_564_29.localPosition = Vector3.New(0, 100, 0)

				local var_564_36 = manager.ui.mainCamera.transform.position - var_564_29.position

				var_564_29.forward = Vector3.New(var_564_36.x, var_564_36.y, var_564_36.z)

				local var_564_37 = var_564_29.localEulerAngles

				var_564_37.z = 0
				var_564_37.x = 0
				var_564_29.localEulerAngles = var_564_37
			end

			local var_564_38 = arg_561_1.actors_["1052ui_story"]
			local var_564_39 = 2

			if var_564_39 < arg_561_1.time_ and arg_561_1.time_ <= var_564_39 + arg_564_0 and not isNil(var_564_38) and arg_561_1.var_.characterEffect1052ui_story == nil then
				arg_561_1.var_.characterEffect1052ui_story = var_564_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_40 = 0.034000001847744

			if var_564_39 <= arg_561_1.time_ and arg_561_1.time_ < var_564_39 + var_564_40 and not isNil(var_564_38) then
				local var_564_41 = (arg_561_1.time_ - var_564_39) / var_564_40

				if arg_561_1.var_.characterEffect1052ui_story and not isNil(var_564_38) then
					local var_564_42 = Mathf.Lerp(0, 0.5, var_564_41)

					arg_561_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1052ui_story.fillRatio = var_564_42
				end
			end

			if arg_561_1.time_ >= var_564_39 + var_564_40 and arg_561_1.time_ < var_564_39 + var_564_40 + arg_564_0 and not isNil(var_564_38) and arg_561_1.var_.characterEffect1052ui_story then
				local var_564_43 = 0.5

				arg_561_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1052ui_story.fillRatio = var_564_43
			end

			local var_564_44 = 0.233333333333333
			local var_564_45 = 1

			if var_564_44 < arg_561_1.time_ and arg_561_1.time_ <= var_564_44 + arg_564_0 then
				local var_564_46 = "stop"
				local var_564_47 = "effect"

				arg_561_1:AudioAction(var_564_46, var_564_47, "se_story_140", "se_story_140_amb_drain", "")
			end

			local var_564_48 = 1.6
			local var_564_49 = 1

			if var_564_48 < arg_561_1.time_ and arg_561_1.time_ <= var_564_48 + arg_564_0 then
				local var_564_50 = "play"
				local var_564_51 = "effect"

				arg_561_1:AudioAction(var_564_50, var_564_51, "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			if arg_561_1.frameCnt_ <= 1 then
				arg_561_1.dialog_:SetActive(false)
			end

			local var_564_52 = 4
			local var_564_53 = 0.25

			if var_564_52 < arg_561_1.time_ and arg_561_1.time_ <= var_564_52 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0

				arg_561_1.dialog_:SetActive(true)

				arg_561_1.dialogCg_.alpha = 0

				local var_564_54 = LeanTween.value(arg_561_1.dialog_, 0, 1, 0.3)

				var_564_54:setOnUpdate(LuaHelper.FloatAction(function(arg_565_0)
					arg_561_1.dialogCg_.alpha = arg_565_0
				end))
				var_564_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_561_1.dialog_)
					var_564_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_561_1.duration_ = arg_561_1.duration_ + 0.3

				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_55 = arg_561_1:FormatText(StoryNameCfg[591].name)

				arg_561_1.leftNameTxt_.text = var_564_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_56 = arg_561_1:GetWordFromCfg(322151132)
				local var_564_57 = arg_561_1:FormatText(var_564_56.content)

				arg_561_1.text_.text = var_564_57

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_58 = 10
				local var_564_59 = utf8.len(var_564_57)
				local var_564_60 = var_564_58 <= 0 and var_564_53 or var_564_53 * (var_564_59 / var_564_58)

				if var_564_60 > 0 and var_564_53 < var_564_60 then
					arg_561_1.talkMaxDuration = var_564_60
					var_564_52 = var_564_52 + 0.3

					if var_564_60 + var_564_52 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_60 + var_564_52
					end
				end

				arg_561_1.text_.text = var_564_57
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151132", "story_v_out_322151.awb") ~= 0 then
					local var_564_61 = manager.audio:GetVoiceLength("story_v_out_322151", "322151132", "story_v_out_322151.awb") / 1000

					if var_564_61 + var_564_52 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_61 + var_564_52
					end

					if var_564_56.prefab_name ~= "" and arg_561_1.actors_[var_564_56.prefab_name] ~= nil then
						local var_564_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_56.prefab_name].transform, "story_v_out_322151", "322151132", "story_v_out_322151.awb")

						arg_561_1:RecordAudio("322151132", var_564_62)
						arg_561_1:RecordAudio("322151132", var_564_62)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_322151", "322151132", "story_v_out_322151.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_322151", "322151132", "story_v_out_322151.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_63 = var_564_52 + 0.3
			local var_564_64 = math.max(var_564_53, arg_561_1.talkMaxDuration)

			if var_564_63 <= arg_561_1.time_ and arg_561_1.time_ < var_564_63 + var_564_64 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_63) / var_564_64

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_63 + var_564_64 and arg_561_1.time_ < var_564_63 + var_564_64 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play322151133 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 322151133
		arg_567_1.duration_ = 2.4

		local var_567_0 = {
			zh = 2.4,
			ja = 2.3
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play322151134(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.25

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[1020].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:GetWordFromCfg(322151133)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 10
				local var_570_6 = utf8.len(var_570_4)
				local var_570_7 = var_570_5 <= 0 and var_570_1 or var_570_1 * (var_570_6 / var_570_5)

				if var_570_7 > 0 and var_570_1 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151133", "story_v_out_322151.awb") ~= 0 then
					local var_570_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151133", "story_v_out_322151.awb") / 1000

					if var_570_8 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_0
					end

					if var_570_3.prefab_name ~= "" and arg_567_1.actors_[var_570_3.prefab_name] ~= nil then
						local var_570_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_3.prefab_name].transform, "story_v_out_322151", "322151133", "story_v_out_322151.awb")

						arg_567_1:RecordAudio("322151133", var_570_9)
						arg_567_1:RecordAudio("322151133", var_570_9)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_322151", "322151133", "story_v_out_322151.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_322151", "322151133", "story_v_out_322151.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_10 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_10 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_10

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_10 and arg_567_1.time_ < var_570_0 + var_570_10 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play322151134 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 322151134
		arg_571_1.duration_ = 2.2

		local var_571_0 = {
			zh = 2.2,
			ja = 2.133
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play322151135(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 0.225

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_2 = arg_571_1:FormatText(StoryNameCfg[591].name)

				arg_571_1.leftNameTxt_.text = var_574_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_3 = arg_571_1:GetWordFromCfg(322151134)
				local var_574_4 = arg_571_1:FormatText(var_574_3.content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 9
				local var_574_6 = utf8.len(var_574_4)
				local var_574_7 = var_574_5 <= 0 and var_574_1 or var_574_1 * (var_574_6 / var_574_5)

				if var_574_7 > 0 and var_574_1 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151134", "story_v_out_322151.awb") ~= 0 then
					local var_574_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151134", "story_v_out_322151.awb") / 1000

					if var_574_8 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_8 + var_574_0
					end

					if var_574_3.prefab_name ~= "" and arg_571_1.actors_[var_574_3.prefab_name] ~= nil then
						local var_574_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_3.prefab_name].transform, "story_v_out_322151", "322151134", "story_v_out_322151.awb")

						arg_571_1:RecordAudio("322151134", var_574_9)
						arg_571_1:RecordAudio("322151134", var_574_9)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_322151", "322151134", "story_v_out_322151.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_322151", "322151134", "story_v_out_322151.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_10 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_10 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_10

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_10 and arg_571_1.time_ < var_574_0 + var_574_10 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play322151135 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 322151135
		arg_575_1.duration_ = 2.4

		local var_575_0 = {
			zh = 2.3,
			ja = 2.4
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play322151136(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.15

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_2 = arg_575_1:FormatText(StoryNameCfg[1020].name)

				arg_575_1.leftNameTxt_.text = var_578_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_3 = arg_575_1:GetWordFromCfg(322151135)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 6
				local var_578_6 = utf8.len(var_578_4)
				local var_578_7 = var_578_5 <= 0 and var_578_1 or var_578_1 * (var_578_6 / var_578_5)

				if var_578_7 > 0 and var_578_1 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151135", "story_v_out_322151.awb") ~= 0 then
					local var_578_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151135", "story_v_out_322151.awb") / 1000

					if var_578_8 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_0
					end

					if var_578_3.prefab_name ~= "" and arg_575_1.actors_[var_578_3.prefab_name] ~= nil then
						local var_578_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_3.prefab_name].transform, "story_v_out_322151", "322151135", "story_v_out_322151.awb")

						arg_575_1:RecordAudio("322151135", var_578_9)
						arg_575_1:RecordAudio("322151135", var_578_9)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_322151", "322151135", "story_v_out_322151.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_322151", "322151135", "story_v_out_322151.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_10 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_10 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_10

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_10 and arg_575_1.time_ < var_578_0 + var_578_10 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play322151136 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 322151136
		arg_579_1.duration_ = 8.07

		local var_579_0 = {
			zh = 5.865999999999,
			ja = 8.065999999999
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play322151137(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 2

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				local var_582_1 = manager.ui.mainCamera.transform.localPosition
				local var_582_2 = Vector3.New(0, 0, 10) + Vector3.New(var_582_1.x, var_582_1.y, 0)
				local var_582_3 = arg_579_1.bgs_.MS2209a

				var_582_3.transform.localPosition = var_582_2
				var_582_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_582_4 = var_582_3:GetComponent("SpriteRenderer")

				if var_582_4 and var_582_4.sprite then
					local var_582_5 = (var_582_3.transform.localPosition - var_582_1).z
					local var_582_6 = manager.ui.mainCameraCom_
					local var_582_7 = 2 * var_582_5 * Mathf.Tan(var_582_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_582_8 = var_582_7 * var_582_6.aspect
					local var_582_9 = var_582_4.sprite.bounds.size.x
					local var_582_10 = var_582_4.sprite.bounds.size.y
					local var_582_11 = var_582_8 / var_582_9
					local var_582_12 = var_582_7 / var_582_10
					local var_582_13 = var_582_12 < var_582_11 and var_582_11 or var_582_12

					var_582_3.transform.localScale = Vector3.New(var_582_13, var_582_13, 0)
				end

				for iter_582_0, iter_582_1 in pairs(arg_579_1.bgs_) do
					if iter_582_0 ~= "MS2209a" then
						iter_582_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_582_14 = 4

			if var_582_14 < arg_579_1.time_ and arg_579_1.time_ <= var_582_14 + arg_582_0 then
				arg_579_1.allBtn_.enabled = false
			end

			local var_582_15 = 0.3

			if arg_579_1.time_ >= var_582_14 + var_582_15 and arg_579_1.time_ < var_582_14 + var_582_15 + arg_582_0 then
				arg_579_1.allBtn_.enabled = true
			end

			local var_582_16 = 0

			if var_582_16 < arg_579_1.time_ and arg_579_1.time_ <= var_582_16 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_17 = 2

			if var_582_16 <= arg_579_1.time_ and arg_579_1.time_ < var_582_16 + var_582_17 then
				local var_582_18 = (arg_579_1.time_ - var_582_16) / var_582_17
				local var_582_19 = Color.New(0, 0, 0)

				var_582_19.a = Mathf.Lerp(0, 1, var_582_18)
				arg_579_1.mask_.color = var_582_19
			end

			if arg_579_1.time_ >= var_582_16 + var_582_17 and arg_579_1.time_ < var_582_16 + var_582_17 + arg_582_0 then
				local var_582_20 = Color.New(0, 0, 0)

				var_582_20.a = 1
				arg_579_1.mask_.color = var_582_20
			end

			local var_582_21 = 2

			if var_582_21 < arg_579_1.time_ and arg_579_1.time_ <= var_582_21 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_22 = 2

			if var_582_21 <= arg_579_1.time_ and arg_579_1.time_ < var_582_21 + var_582_22 then
				local var_582_23 = (arg_579_1.time_ - var_582_21) / var_582_22
				local var_582_24 = Color.New(0, 0, 0)

				var_582_24.a = Mathf.Lerp(1, 0, var_582_23)
				arg_579_1.mask_.color = var_582_24
			end

			if arg_579_1.time_ >= var_582_21 + var_582_22 and arg_579_1.time_ < var_582_21 + var_582_22 + arg_582_0 then
				local var_582_25 = Color.New(0, 0, 0)
				local var_582_26 = 0

				arg_579_1.mask_.enabled = false
				var_582_25.a = var_582_26
				arg_579_1.mask_.color = var_582_25
			end

			local var_582_27 = 0.1
			local var_582_28 = 1

			if var_582_27 < arg_579_1.time_ and arg_579_1.time_ <= var_582_27 + arg_582_0 then
				local var_582_29 = "stop"
				local var_582_30 = "effect"

				arg_579_1:AudioAction(var_582_29, var_582_30, "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			local var_582_31 = 1.6
			local var_582_32 = 1

			if var_582_31 < arg_579_1.time_ and arg_579_1.time_ <= var_582_31 + arg_582_0 then
				local var_582_33 = "play"
				local var_582_34 = "effect"

				arg_579_1:AudioAction(var_582_33, var_582_34, "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			if arg_579_1.frameCnt_ <= 1 then
				arg_579_1.dialog_:SetActive(false)
			end

			local var_582_35 = 3.999999999999
			local var_582_36 = 0.3

			if var_582_35 < arg_579_1.time_ and arg_579_1.time_ <= var_582_35 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0

				arg_579_1.dialog_:SetActive(true)

				arg_579_1.dialogCg_.alpha = 0

				local var_582_37 = LeanTween.value(arg_579_1.dialog_, 0, 1, 0.3)

				var_582_37:setOnUpdate(LuaHelper.FloatAction(function(arg_583_0)
					arg_579_1.dialogCg_.alpha = arg_583_0
				end))
				var_582_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_579_1.dialog_)
					var_582_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_579_1.duration_ = arg_579_1.duration_ + 0.3

				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_38 = arg_579_1:FormatText(StoryNameCfg[613].name)

				arg_579_1.leftNameTxt_.text = var_582_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_39 = arg_579_1:GetWordFromCfg(322151136)
				local var_582_40 = arg_579_1:FormatText(var_582_39.content)

				arg_579_1.text_.text = var_582_40

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_41 = 12
				local var_582_42 = utf8.len(var_582_40)
				local var_582_43 = var_582_41 <= 0 and var_582_36 or var_582_36 * (var_582_42 / var_582_41)

				if var_582_43 > 0 and var_582_36 < var_582_43 then
					arg_579_1.talkMaxDuration = var_582_43
					var_582_35 = var_582_35 + 0.3

					if var_582_43 + var_582_35 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_43 + var_582_35
					end
				end

				arg_579_1.text_.text = var_582_40
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151136", "story_v_out_322151.awb") ~= 0 then
					local var_582_44 = manager.audio:GetVoiceLength("story_v_out_322151", "322151136", "story_v_out_322151.awb") / 1000

					if var_582_44 + var_582_35 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_44 + var_582_35
					end

					if var_582_39.prefab_name ~= "" and arg_579_1.actors_[var_582_39.prefab_name] ~= nil then
						local var_582_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_39.prefab_name].transform, "story_v_out_322151", "322151136", "story_v_out_322151.awb")

						arg_579_1:RecordAudio("322151136", var_582_45)
						arg_579_1:RecordAudio("322151136", var_582_45)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_322151", "322151136", "story_v_out_322151.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_322151", "322151136", "story_v_out_322151.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_46 = var_582_35 + 0.3
			local var_582_47 = math.max(var_582_36, arg_579_1.talkMaxDuration)

			if var_582_46 <= arg_579_1.time_ and arg_579_1.time_ < var_582_46 + var_582_47 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_46) / var_582_47

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_46 + var_582_47 and arg_579_1.time_ < var_582_46 + var_582_47 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play322151137 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 322151137
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play322151138(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 0.175

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_2 = arg_585_1:FormatText(StoryNameCfg[7].name)

				arg_585_1.leftNameTxt_.text = var_588_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_3 = arg_585_1:GetWordFromCfg(322151137)
				local var_588_4 = arg_585_1:FormatText(var_588_3.content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_5 = 7
				local var_588_6 = utf8.len(var_588_4)
				local var_588_7 = var_588_5 <= 0 and var_588_1 or var_588_1 * (var_588_6 / var_588_5)

				if var_588_7 > 0 and var_588_1 < var_588_7 then
					arg_585_1.talkMaxDuration = var_588_7

					if var_588_7 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_7 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_8 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_8 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_8

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_8 and arg_585_1.time_ < var_588_0 + var_588_8 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play322151138 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 322151138
		arg_589_1.duration_ = 4.93

		local var_589_0 = {
			zh = 3.633,
			ja = 4.933
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play322151139(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0
			local var_592_1 = 0.45

			if var_592_0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_2 = arg_589_1:FormatText(StoryNameCfg[613].name)

				arg_589_1.leftNameTxt_.text = var_592_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_3 = arg_589_1:GetWordFromCfg(322151138)
				local var_592_4 = arg_589_1:FormatText(var_592_3.content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 18
				local var_592_6 = utf8.len(var_592_4)
				local var_592_7 = var_592_5 <= 0 and var_592_1 or var_592_1 * (var_592_6 / var_592_5)

				if var_592_7 > 0 and var_592_1 < var_592_7 then
					arg_589_1.talkMaxDuration = var_592_7

					if var_592_7 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_0
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151138", "story_v_out_322151.awb") ~= 0 then
					local var_592_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151138", "story_v_out_322151.awb") / 1000

					if var_592_8 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_8 + var_592_0
					end

					if var_592_3.prefab_name ~= "" and arg_589_1.actors_[var_592_3.prefab_name] ~= nil then
						local var_592_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_3.prefab_name].transform, "story_v_out_322151", "322151138", "story_v_out_322151.awb")

						arg_589_1:RecordAudio("322151138", var_592_9)
						arg_589_1:RecordAudio("322151138", var_592_9)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_322151", "322151138", "story_v_out_322151.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_322151", "322151138", "story_v_out_322151.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_10 = math.max(var_592_1, arg_589_1.talkMaxDuration)

			if var_592_0 <= arg_589_1.time_ and arg_589_1.time_ < var_592_0 + var_592_10 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_0) / var_592_10

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_0 + var_592_10 and arg_589_1.time_ < var_592_0 + var_592_10 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play322151139 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 322151139
		arg_593_1.duration_ = 4.4

		local var_593_0 = {
			zh = 3.833,
			ja = 4.4
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play322151140(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 0.4

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[613].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_3 = arg_593_1:GetWordFromCfg(322151139)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 16
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151139", "story_v_out_322151.awb") ~= 0 then
					local var_596_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151139", "story_v_out_322151.awb") / 1000

					if var_596_8 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_8 + var_596_0
					end

					if var_596_3.prefab_name ~= "" and arg_593_1.actors_[var_596_3.prefab_name] ~= nil then
						local var_596_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_3.prefab_name].transform, "story_v_out_322151", "322151139", "story_v_out_322151.awb")

						arg_593_1:RecordAudio("322151139", var_596_9)
						arg_593_1:RecordAudio("322151139", var_596_9)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_322151", "322151139", "story_v_out_322151.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_322151", "322151139", "story_v_out_322151.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_10 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_10 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_10

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_10 and arg_593_1.time_ < var_596_0 + var_596_10 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play322151140 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 322151140
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play322151141(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0
			local var_600_1 = 0.55

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_2 = arg_597_1:FormatText(StoryNameCfg[7].name)

				arg_597_1.leftNameTxt_.text = var_600_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_3 = arg_597_1:GetWordFromCfg(322151140)
				local var_600_4 = arg_597_1:FormatText(var_600_3.content)

				arg_597_1.text_.text = var_600_4

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 22
				local var_600_6 = utf8.len(var_600_4)
				local var_600_7 = var_600_5 <= 0 and var_600_1 or var_600_1 * (var_600_6 / var_600_5)

				if var_600_7 > 0 and var_600_1 < var_600_7 then
					arg_597_1.talkMaxDuration = var_600_7

					if var_600_7 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_7 + var_600_0
					end
				end

				arg_597_1.text_.text = var_600_4
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_8 = math.max(var_600_1, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_8 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_0) / var_600_8

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_8 and arg_597_1.time_ < var_600_0 + var_600_8 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play322151141 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 322151141
		arg_601_1.duration_ = 9.87

		local var_601_0 = {
			zh = 6.3,
			ja = 9.866
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play322151142(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0
			local var_604_1 = 0.725

			if var_604_0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_2 = arg_601_1:FormatText(StoryNameCfg[613].name)

				arg_601_1.leftNameTxt_.text = var_604_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_3 = arg_601_1:GetWordFromCfg(322151141)
				local var_604_4 = arg_601_1:FormatText(var_604_3.content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 29
				local var_604_6 = utf8.len(var_604_4)
				local var_604_7 = var_604_5 <= 0 and var_604_1 or var_604_1 * (var_604_6 / var_604_5)

				if var_604_7 > 0 and var_604_1 < var_604_7 then
					arg_601_1.talkMaxDuration = var_604_7

					if var_604_7 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_0
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151141", "story_v_out_322151.awb") ~= 0 then
					local var_604_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151141", "story_v_out_322151.awb") / 1000

					if var_604_8 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_8 + var_604_0
					end

					if var_604_3.prefab_name ~= "" and arg_601_1.actors_[var_604_3.prefab_name] ~= nil then
						local var_604_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_3.prefab_name].transform, "story_v_out_322151", "322151141", "story_v_out_322151.awb")

						arg_601_1:RecordAudio("322151141", var_604_9)
						arg_601_1:RecordAudio("322151141", var_604_9)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_322151", "322151141", "story_v_out_322151.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_322151", "322151141", "story_v_out_322151.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_10 = math.max(var_604_1, arg_601_1.talkMaxDuration)

			if var_604_0 <= arg_601_1.time_ and arg_601_1.time_ < var_604_0 + var_604_10 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_0) / var_604_10

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_0 + var_604_10 and arg_601_1.time_ < var_604_0 + var_604_10 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play322151142 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 322151142
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play322151143(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.6

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_2 = arg_605_1:FormatText(StoryNameCfg[7].name)

				arg_605_1.leftNameTxt_.text = var_608_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_3 = arg_605_1:GetWordFromCfg(322151142)
				local var_608_4 = arg_605_1:FormatText(var_608_3.content)

				arg_605_1.text_.text = var_608_4

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_5 = 24
				local var_608_6 = utf8.len(var_608_4)
				local var_608_7 = var_608_5 <= 0 and var_608_1 or var_608_1 * (var_608_6 / var_608_5)

				if var_608_7 > 0 and var_608_1 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_4
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_8 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_8 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_8

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_8 and arg_605_1.time_ < var_608_0 + var_608_8 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play322151143 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 322151143
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play322151144(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0
			local var_612_1 = 1.575

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_2 = arg_609_1:FormatText(StoryNameCfg[7].name)

				arg_609_1.leftNameTxt_.text = var_612_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_3 = arg_609_1:GetWordFromCfg(322151143)
				local var_612_4 = arg_609_1:FormatText(var_612_3.content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_5 = 63
				local var_612_6 = utf8.len(var_612_4)
				local var_612_7 = var_612_5 <= 0 and var_612_1 or var_612_1 * (var_612_6 / var_612_5)

				if var_612_7 > 0 and var_612_1 < var_612_7 then
					arg_609_1.talkMaxDuration = var_612_7

					if var_612_7 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_7 + var_612_0
					end
				end

				arg_609_1.text_.text = var_612_4
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_8 = math.max(var_612_1, arg_609_1.talkMaxDuration)

			if var_612_0 <= arg_609_1.time_ and arg_609_1.time_ < var_612_0 + var_612_8 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_0) / var_612_8

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_0 + var_612_8 and arg_609_1.time_ < var_612_0 + var_612_8 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play322151144 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 322151144
		arg_613_1.duration_ = 1.57

		local var_613_0 = {
			zh = 0.999999999999,
			ja = 1.566
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play322151145(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 0.075

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[613].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_3 = arg_613_1:GetWordFromCfg(322151144)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 3
				local var_616_6 = utf8.len(var_616_4)
				local var_616_7 = var_616_5 <= 0 and var_616_1 or var_616_1 * (var_616_6 / var_616_5)

				if var_616_7 > 0 and var_616_1 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151144", "story_v_out_322151.awb") ~= 0 then
					local var_616_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151144", "story_v_out_322151.awb") / 1000

					if var_616_8 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_8 + var_616_0
					end

					if var_616_3.prefab_name ~= "" and arg_613_1.actors_[var_616_3.prefab_name] ~= nil then
						local var_616_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_3.prefab_name].transform, "story_v_out_322151", "322151144", "story_v_out_322151.awb")

						arg_613_1:RecordAudio("322151144", var_616_9)
						arg_613_1:RecordAudio("322151144", var_616_9)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_322151", "322151144", "story_v_out_322151.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_322151", "322151144", "story_v_out_322151.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_10 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_10 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_10

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_10 and arg_613_1.time_ < var_616_0 + var_616_10 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play322151145 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 322151145
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play322151146(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 0.125

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_2 = arg_617_1:FormatText(StoryNameCfg[7].name)

				arg_617_1.leftNameTxt_.text = var_620_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_3 = arg_617_1:GetWordFromCfg(322151145)
				local var_620_4 = arg_617_1:FormatText(var_620_3.content)

				arg_617_1.text_.text = var_620_4

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 5
				local var_620_6 = utf8.len(var_620_4)
				local var_620_7 = var_620_5 <= 0 and var_620_1 or var_620_1 * (var_620_6 / var_620_5)

				if var_620_7 > 0 and var_620_1 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_4
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_8 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_8 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_8

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_8 and arg_617_1.time_ < var_620_0 + var_620_8 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play322151146 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 322151146
		arg_621_1.duration_ = 5.83

		local var_621_0 = {
			zh = 4.9,
			ja = 5.833
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play322151147(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0
			local var_624_1 = 0.625

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_2 = arg_621_1:FormatText(StoryNameCfg[613].name)

				arg_621_1.leftNameTxt_.text = var_624_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_3 = arg_621_1:GetWordFromCfg(322151146)
				local var_624_4 = arg_621_1:FormatText(var_624_3.content)

				arg_621_1.text_.text = var_624_4

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 25
				local var_624_6 = utf8.len(var_624_4)
				local var_624_7 = var_624_5 <= 0 and var_624_1 or var_624_1 * (var_624_6 / var_624_5)

				if var_624_7 > 0 and var_624_1 < var_624_7 then
					arg_621_1.talkMaxDuration = var_624_7

					if var_624_7 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_7 + var_624_0
					end
				end

				arg_621_1.text_.text = var_624_4
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151146", "story_v_out_322151.awb") ~= 0 then
					local var_624_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151146", "story_v_out_322151.awb") / 1000

					if var_624_8 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_8 + var_624_0
					end

					if var_624_3.prefab_name ~= "" and arg_621_1.actors_[var_624_3.prefab_name] ~= nil then
						local var_624_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_3.prefab_name].transform, "story_v_out_322151", "322151146", "story_v_out_322151.awb")

						arg_621_1:RecordAudio("322151146", var_624_9)
						arg_621_1:RecordAudio("322151146", var_624_9)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_322151", "322151146", "story_v_out_322151.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_322151", "322151146", "story_v_out_322151.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_10 = math.max(var_624_1, arg_621_1.talkMaxDuration)

			if var_624_0 <= arg_621_1.time_ and arg_621_1.time_ < var_624_0 + var_624_10 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_0) / var_624_10

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_0 + var_624_10 and arg_621_1.time_ < var_624_0 + var_624_10 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play322151147 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 322151147
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play322151148(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0
			local var_628_1 = 0.575

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_2 = arg_625_1:FormatText(StoryNameCfg[7].name)

				arg_625_1.leftNameTxt_.text = var_628_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_3 = arg_625_1:GetWordFromCfg(322151147)
				local var_628_4 = arg_625_1:FormatText(var_628_3.content)

				arg_625_1.text_.text = var_628_4

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_5 = 23
				local var_628_6 = utf8.len(var_628_4)
				local var_628_7 = var_628_5 <= 0 and var_628_1 or var_628_1 * (var_628_6 / var_628_5)

				if var_628_7 > 0 and var_628_1 < var_628_7 then
					arg_625_1.talkMaxDuration = var_628_7

					if var_628_7 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_7 + var_628_0
					end
				end

				arg_625_1.text_.text = var_628_4
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_8 = math.max(var_628_1, arg_625_1.talkMaxDuration)

			if var_628_0 <= arg_625_1.time_ and arg_625_1.time_ < var_628_0 + var_628_8 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_0) / var_628_8

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_0 + var_628_8 and arg_625_1.time_ < var_628_0 + var_628_8 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play322151148 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 322151148
		arg_629_1.duration_ = 7

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play322151149(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 1

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				local var_632_1 = manager.ui.mainCamera.transform.localPosition
				local var_632_2 = Vector3.New(0, 0, 10) + Vector3.New(var_632_1.x, var_632_1.y, 0)
				local var_632_3 = arg_629_1.bgs_.MS2209

				var_632_3.transform.localPosition = var_632_2
				var_632_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_632_4 = var_632_3:GetComponent("SpriteRenderer")

				if var_632_4 and var_632_4.sprite then
					local var_632_5 = (var_632_3.transform.localPosition - var_632_1).z
					local var_632_6 = manager.ui.mainCameraCom_
					local var_632_7 = 2 * var_632_5 * Mathf.Tan(var_632_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_632_8 = var_632_7 * var_632_6.aspect
					local var_632_9 = var_632_4.sprite.bounds.size.x
					local var_632_10 = var_632_4.sprite.bounds.size.y
					local var_632_11 = var_632_8 / var_632_9
					local var_632_12 = var_632_7 / var_632_10
					local var_632_13 = var_632_12 < var_632_11 and var_632_11 or var_632_12

					var_632_3.transform.localScale = Vector3.New(var_632_13, var_632_13, 0)
				end

				for iter_632_0, iter_632_1 in pairs(arg_629_1.bgs_) do
					if iter_632_0 ~= "MS2209" then
						iter_632_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_632_14 = 2

			if var_632_14 < arg_629_1.time_ and arg_629_1.time_ <= var_632_14 + arg_632_0 then
				arg_629_1.allBtn_.enabled = false
			end

			local var_632_15 = 0.3

			if arg_629_1.time_ >= var_632_14 + var_632_15 and arg_629_1.time_ < var_632_14 + var_632_15 + arg_632_0 then
				arg_629_1.allBtn_.enabled = true
			end

			local var_632_16 = 0

			if var_632_16 < arg_629_1.time_ and arg_629_1.time_ <= var_632_16 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_17 = 1

			if var_632_16 <= arg_629_1.time_ and arg_629_1.time_ < var_632_16 + var_632_17 then
				local var_632_18 = (arg_629_1.time_ - var_632_16) / var_632_17
				local var_632_19 = Color.New(0, 0, 0)

				var_632_19.a = Mathf.Lerp(0, 1, var_632_18)
				arg_629_1.mask_.color = var_632_19
			end

			if arg_629_1.time_ >= var_632_16 + var_632_17 and arg_629_1.time_ < var_632_16 + var_632_17 + arg_632_0 then
				local var_632_20 = Color.New(0, 0, 0)

				var_632_20.a = 1
				arg_629_1.mask_.color = var_632_20
			end

			local var_632_21 = 1

			if var_632_21 < arg_629_1.time_ and arg_629_1.time_ <= var_632_21 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_22 = 1

			if var_632_21 <= arg_629_1.time_ and arg_629_1.time_ < var_632_21 + var_632_22 then
				local var_632_23 = (arg_629_1.time_ - var_632_21) / var_632_22
				local var_632_24 = Color.New(0, 0, 0)

				var_632_24.a = Mathf.Lerp(1, 0, var_632_23)
				arg_629_1.mask_.color = var_632_24
			end

			if arg_629_1.time_ >= var_632_21 + var_632_22 and arg_629_1.time_ < var_632_21 + var_632_22 + arg_632_0 then
				local var_632_25 = Color.New(0, 0, 0)
				local var_632_26 = 0

				arg_629_1.mask_.enabled = false
				var_632_25.a = var_632_26
				arg_629_1.mask_.color = var_632_25
			end

			local var_632_27 = 1
			local var_632_28 = 1

			if var_632_27 < arg_629_1.time_ and arg_629_1.time_ <= var_632_27 + arg_632_0 then
				local var_632_29 = "stop"
				local var_632_30 = "effect"

				arg_629_1:AudioAction(var_632_29, var_632_30, "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			local var_632_31 = 1.1
			local var_632_32 = 1

			if var_632_31 < arg_629_1.time_ and arg_629_1.time_ <= var_632_31 + arg_632_0 then
				local var_632_33 = "play"
				local var_632_34 = "effect"

				arg_629_1:AudioAction(var_632_33, var_632_34, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_632_35 = manager.ui.mainCamera.transform
			local var_632_36 = 1

			if var_632_36 < arg_629_1.time_ and arg_629_1.time_ <= var_632_36 + arg_632_0 then
				local var_632_37 = arg_629_1.var_.effect1148
				local var_632_38
				local var_632_39 = var_632_35

				if not var_632_37 then
					var_632_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_632_39)
					var_632_37.name = "1148"
					arg_629_1.var_.effect1148 = var_632_37
				else
					var_632_37.transform:SetParent(var_632_39)
				end

				var_632_37.transform.localPosition = Vector3.New(0, 0, 0)
				var_632_37.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_629_1.frameCnt_ <= 1 then
				arg_629_1.dialog_:SetActive(false)
			end

			local var_632_40 = 2
			local var_632_41 = 0.825

			if var_632_40 < arg_629_1.time_ and arg_629_1.time_ <= var_632_40 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0

				arg_629_1.dialog_:SetActive(true)

				arg_629_1.dialogCg_.alpha = 0

				local var_632_42 = LeanTween.value(arg_629_1.dialog_, 0, 1, 0.3)

				var_632_42:setOnUpdate(LuaHelper.FloatAction(function(arg_633_0)
					arg_629_1.dialogCg_.alpha = arg_633_0
				end))
				var_632_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_629_1.dialog_)
					var_632_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_629_1.duration_ = arg_629_1.duration_ + 0.3

				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_43 = arg_629_1:GetWordFromCfg(322151148)
				local var_632_44 = arg_629_1:FormatText(var_632_43.content)

				arg_629_1.text_.text = var_632_44

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_45 = 33
				local var_632_46 = utf8.len(var_632_44)
				local var_632_47 = var_632_45 <= 0 and var_632_41 or var_632_41 * (var_632_46 / var_632_45)

				if var_632_47 > 0 and var_632_41 < var_632_47 then
					arg_629_1.talkMaxDuration = var_632_47
					var_632_40 = var_632_40 + 0.3

					if var_632_47 + var_632_40 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_47 + var_632_40
					end
				end

				arg_629_1.text_.text = var_632_44
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_48 = var_632_40 + 0.3
			local var_632_49 = math.max(var_632_41, arg_629_1.talkMaxDuration)

			if var_632_48 <= arg_629_1.time_ and arg_629_1.time_ < var_632_48 + var_632_49 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_48) / var_632_49

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_48 + var_632_49 and arg_629_1.time_ < var_632_48 + var_632_49 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play322151149 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 322151149
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play322151150(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 1.225

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_2 = arg_635_1:GetWordFromCfg(322151149)
				local var_638_3 = arg_635_1:FormatText(var_638_2.content)

				arg_635_1.text_.text = var_638_3

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_4 = 49
				local var_638_5 = utf8.len(var_638_3)
				local var_638_6 = var_638_4 <= 0 and var_638_1 or var_638_1 * (var_638_5 / var_638_4)

				if var_638_6 > 0 and var_638_1 < var_638_6 then
					arg_635_1.talkMaxDuration = var_638_6

					if var_638_6 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_6 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_3
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_7 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_7 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_7

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_7 and arg_635_1.time_ < var_638_0 + var_638_7 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play322151150 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 322151150
		arg_639_1.duration_ = 6.33

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play322151151(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = arg_639_1.bgs_.MS2209.transform
			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.var_.moveOldPosMS2209 = var_642_0.localPosition
			end

			local var_642_2 = 0.001

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_2 then
				local var_642_3 = (arg_639_1.time_ - var_642_1) / var_642_2
				local var_642_4 = Vector3.New(0, 2, 5)

				var_642_0.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPosMS2209, var_642_4, var_642_3)
			end

			if arg_639_1.time_ >= var_642_1 + var_642_2 and arg_639_1.time_ < var_642_1 + var_642_2 + arg_642_0 then
				var_642_0.localPosition = Vector3.New(0, 2, 5)
			end

			local var_642_5 = arg_639_1.bgs_.MS2209.transform
			local var_642_6 = 0.034

			if var_642_6 < arg_639_1.time_ and arg_639_1.time_ <= var_642_6 + arg_642_0 then
				arg_639_1.var_.moveOldPosMS2209 = var_642_5.localPosition
			end

			local var_642_7 = 1.29933333333333

			if var_642_6 <= arg_639_1.time_ and arg_639_1.time_ < var_642_6 + var_642_7 then
				local var_642_8 = (arg_639_1.time_ - var_642_6) / var_642_7
				local var_642_9 = Vector3.New(0, 2, 4.5)

				var_642_5.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPosMS2209, var_642_9, var_642_8)
			end

			if arg_639_1.time_ >= var_642_6 + var_642_7 and arg_639_1.time_ < var_642_6 + var_642_7 + arg_642_0 then
				var_642_5.localPosition = Vector3.New(0, 2, 4.5)
			end

			local var_642_10 = 0

			if var_642_10 < arg_639_1.time_ and arg_639_1.time_ <= var_642_10 + arg_642_0 then
				arg_639_1.allBtn_.enabled = false
			end

			local var_642_11 = 1.33333333333333

			if arg_639_1.time_ >= var_642_10 + var_642_11 and arg_639_1.time_ < var_642_10 + var_642_11 + arg_642_0 then
				arg_639_1.allBtn_.enabled = true
			end

			if arg_639_1.frameCnt_ <= 1 then
				arg_639_1.dialog_:SetActive(false)
			end

			local var_642_12 = 1.33333333333333
			local var_642_13 = 0.9

			if var_642_12 < arg_639_1.time_ and arg_639_1.time_ <= var_642_12 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0

				arg_639_1.dialog_:SetActive(true)

				arg_639_1.dialogCg_.alpha = 0

				local var_642_14 = LeanTween.value(arg_639_1.dialog_, 0, 1, 0.3)

				var_642_14:setOnUpdate(LuaHelper.FloatAction(function(arg_643_0)
					arg_639_1.dialogCg_.alpha = arg_643_0
				end))
				var_642_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_639_1.dialog_)
					var_642_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_639_1.duration_ = arg_639_1.duration_ + 0.3

				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_15 = arg_639_1:FormatText(StoryNameCfg[7].name)

				arg_639_1.leftNameTxt_.text = var_642_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_16 = arg_639_1:GetWordFromCfg(322151150)
				local var_642_17 = arg_639_1:FormatText(var_642_16.content)

				arg_639_1.text_.text = var_642_17

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_18 = 36
				local var_642_19 = utf8.len(var_642_17)
				local var_642_20 = var_642_18 <= 0 and var_642_13 or var_642_13 * (var_642_19 / var_642_18)

				if var_642_20 > 0 and var_642_13 < var_642_20 then
					arg_639_1.talkMaxDuration = var_642_20
					var_642_12 = var_642_12 + 0.3

					if var_642_20 + var_642_12 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_20 + var_642_12
					end
				end

				arg_639_1.text_.text = var_642_17
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_21 = var_642_12 + 0.3
			local var_642_22 = math.max(var_642_13, arg_639_1.talkMaxDuration)

			if var_642_21 <= arg_639_1.time_ and arg_639_1.time_ < var_642_21 + var_642_22 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_21) / var_642_22

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_21 + var_642_22 and arg_639_1.time_ < var_642_21 + var_642_22 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.29933333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play322151151 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 322151151
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play322151152(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.35

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_2 = arg_645_1:FormatText(StoryNameCfg[7].name)

				arg_645_1.leftNameTxt_.text = var_648_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_3 = arg_645_1:GetWordFromCfg(322151151)
				local var_648_4 = arg_645_1:FormatText(var_648_3.content)

				arg_645_1.text_.text = var_648_4

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 14
				local var_648_6 = utf8.len(var_648_4)
				local var_648_7 = var_648_5 <= 0 and var_648_1 or var_648_1 * (var_648_6 / var_648_5)

				if var_648_7 > 0 and var_648_1 < var_648_7 then
					arg_645_1.talkMaxDuration = var_648_7

					if var_648_7 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_7 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_4
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_8 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_8 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_8

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_8 and arg_645_1.time_ < var_648_0 + var_648_8 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play322151152 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 322151152
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play322151153(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 1.3

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_2 = arg_649_1:GetWordFromCfg(322151152)
				local var_652_3 = arg_649_1:FormatText(var_652_2.content)

				arg_649_1.text_.text = var_652_3

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_4 = 52
				local var_652_5 = utf8.len(var_652_3)
				local var_652_6 = var_652_4 <= 0 and var_652_1 or var_652_1 * (var_652_5 / var_652_4)

				if var_652_6 > 0 and var_652_1 < var_652_6 then
					arg_649_1.talkMaxDuration = var_652_6

					if var_652_6 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_6 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_3
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_7 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_7 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_7

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_7 and arg_649_1.time_ < var_652_0 + var_652_7 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play322151153 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 322151153
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play322151154(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0.1
			local var_656_1 = 1

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				local var_656_2 = "play"
				local var_656_3 = "effect"

				arg_653_1:AudioAction(var_656_2, var_656_3, "minigame_activity_3_7", "minigame_activity_3_7_bullet_laser", "")
			end

			local var_656_4 = manager.ui.mainCamera.transform
			local var_656_5 = 0.1

			if var_656_5 < arg_653_1.time_ and arg_653_1.time_ <= var_656_5 + arg_656_0 then
				arg_653_1.var_.shakeOldPos = var_656_4.localPosition
			end

			local var_656_6 = 0.5

			if var_656_5 <= arg_653_1.time_ and arg_653_1.time_ < var_656_5 + var_656_6 then
				local var_656_7 = (arg_653_1.time_ - var_656_5) / 0.066
				local var_656_8, var_656_9 = math.modf(var_656_7)

				var_656_4.localPosition = Vector3.New(var_656_9 * 0.13, var_656_9 * 0.13, var_656_9 * 0.13) + arg_653_1.var_.shakeOldPos
			end

			if arg_653_1.time_ >= var_656_5 + var_656_6 and arg_653_1.time_ < var_656_5 + var_656_6 + arg_656_0 then
				var_656_4.localPosition = arg_653_1.var_.shakeOldPos
			end

			local var_656_10 = 0
			local var_656_11 = 1.6

			if var_656_10 < arg_653_1.time_ and arg_653_1.time_ <= var_656_10 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_12 = arg_653_1:GetWordFromCfg(322151153)
				local var_656_13 = arg_653_1:FormatText(var_656_12.content)

				arg_653_1.text_.text = var_656_13

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_14 = 64
				local var_656_15 = utf8.len(var_656_13)
				local var_656_16 = var_656_14 <= 0 and var_656_11 or var_656_11 * (var_656_15 / var_656_14)

				if var_656_16 > 0 and var_656_11 < var_656_16 then
					arg_653_1.talkMaxDuration = var_656_16

					if var_656_16 + var_656_10 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_16 + var_656_10
					end
				end

				arg_653_1.text_.text = var_656_13
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_17 = math.max(var_656_11, arg_653_1.talkMaxDuration)

			if var_656_10 <= arg_653_1.time_ and arg_653_1.time_ < var_656_10 + var_656_17 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_10) / var_656_17

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_10 + var_656_17 and arg_653_1.time_ < var_656_10 + var_656_17 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play322151154 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 322151154
		arg_657_1.duration_ = 5.27

		local var_657_0 = {
			zh = 3.233,
			ja = 5.266
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play322151155(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0
			local var_660_1 = 0.3

			if var_660_0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_2 = arg_657_1:FormatText(StoryNameCfg[613].name)

				arg_657_1.leftNameTxt_.text = var_660_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_3 = arg_657_1:GetWordFromCfg(322151154)
				local var_660_4 = arg_657_1:FormatText(var_660_3.content)

				arg_657_1.text_.text = var_660_4

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_5 = 12
				local var_660_6 = utf8.len(var_660_4)
				local var_660_7 = var_660_5 <= 0 and var_660_1 or var_660_1 * (var_660_6 / var_660_5)

				if var_660_7 > 0 and var_660_1 < var_660_7 then
					arg_657_1.talkMaxDuration = var_660_7

					if var_660_7 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_7 + var_660_0
					end
				end

				arg_657_1.text_.text = var_660_4
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151154", "story_v_out_322151.awb") ~= 0 then
					local var_660_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151154", "story_v_out_322151.awb") / 1000

					if var_660_8 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_8 + var_660_0
					end

					if var_660_3.prefab_name ~= "" and arg_657_1.actors_[var_660_3.prefab_name] ~= nil then
						local var_660_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_3.prefab_name].transform, "story_v_out_322151", "322151154", "story_v_out_322151.awb")

						arg_657_1:RecordAudio("322151154", var_660_9)
						arg_657_1:RecordAudio("322151154", var_660_9)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_322151", "322151154", "story_v_out_322151.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_322151", "322151154", "story_v_out_322151.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_10 = math.max(var_660_1, arg_657_1.talkMaxDuration)

			if var_660_0 <= arg_657_1.time_ and arg_657_1.time_ < var_660_0 + var_660_10 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_0) / var_660_10

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_0 + var_660_10 and arg_657_1.time_ < var_660_0 + var_660_10 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play322151155 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 322151155
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play322151156(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0
			local var_664_1 = 0.7

			if var_664_0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_0 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_2 = arg_661_1:FormatText(StoryNameCfg[7].name)

				arg_661_1.leftNameTxt_.text = var_664_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_3 = arg_661_1:GetWordFromCfg(322151155)
				local var_664_4 = arg_661_1:FormatText(var_664_3.content)

				arg_661_1.text_.text = var_664_4

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_5 = 28
				local var_664_6 = utf8.len(var_664_4)
				local var_664_7 = var_664_5 <= 0 and var_664_1 or var_664_1 * (var_664_6 / var_664_5)

				if var_664_7 > 0 and var_664_1 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_0
					end
				end

				arg_661_1.text_.text = var_664_4
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_8 = math.max(var_664_1, arg_661_1.talkMaxDuration)

			if var_664_0 <= arg_661_1.time_ and arg_661_1.time_ < var_664_0 + var_664_8 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_0) / var_664_8

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_0 + var_664_8 and arg_661_1.time_ < var_664_0 + var_664_8 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play322151156 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 322151156
		arg_665_1.duration_ = 5.82

		local var_665_0 = {
			zh = 5.38266666666667,
			ja = 5.81666666666667
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play322151157(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.bgs_.MS2209.transform
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 then
				arg_665_1.var_.moveOldPosMS2209 = var_668_0.localPosition
			end

			local var_668_2 = 0.316666666666667

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2
				local var_668_4 = Vector3.New(-0.1, 2.6, 4.5)

				var_668_0.localPosition = Vector3.Lerp(arg_665_1.var_.moveOldPosMS2209, var_668_4, var_668_3)
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 then
				var_668_0.localPosition = Vector3.New(-0.1, 2.6, 4.5)
			end

			local var_668_5 = 0

			if var_668_5 < arg_665_1.time_ and arg_665_1.time_ <= var_668_5 + arg_668_0 then
				arg_665_1.allBtn_.enabled = false
			end

			local var_668_6 = 0.466666666666667

			if arg_665_1.time_ >= var_668_5 + var_668_6 and arg_665_1.time_ < var_668_5 + var_668_6 + arg_668_0 then
				arg_665_1.allBtn_.enabled = true
			end

			if arg_665_1.frameCnt_ <= 1 then
				arg_665_1.dialog_:SetActive(false)
			end

			local var_668_7 = 0.316666666666667
			local var_668_8 = 0.425

			if var_668_7 < arg_665_1.time_ and arg_665_1.time_ <= var_668_7 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0

				arg_665_1.dialog_:SetActive(true)

				arg_665_1.dialogCg_.alpha = 0

				local var_668_9 = LeanTween.value(arg_665_1.dialog_, 0, 1, 0.3)

				var_668_9:setOnUpdate(LuaHelper.FloatAction(function(arg_669_0)
					arg_665_1.dialogCg_.alpha = arg_669_0
				end))
				var_668_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_665_1.dialog_)
					var_668_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_665_1.duration_ = arg_665_1.duration_ + 0.3

				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_10 = arg_665_1:FormatText(StoryNameCfg[613].name)

				arg_665_1.leftNameTxt_.text = var_668_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_11 = arg_665_1:GetWordFromCfg(322151156)
				local var_668_12 = arg_665_1:FormatText(var_668_11.content)

				arg_665_1.text_.text = var_668_12

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_13 = 17
				local var_668_14 = utf8.len(var_668_12)
				local var_668_15 = var_668_13 <= 0 and var_668_8 or var_668_8 * (var_668_14 / var_668_13)

				if var_668_15 > 0 and var_668_8 < var_668_15 then
					arg_665_1.talkMaxDuration = var_668_15
					var_668_7 = var_668_7 + 0.3

					if var_668_15 + var_668_7 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_15 + var_668_7
					end
				end

				arg_665_1.text_.text = var_668_12
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151156", "story_v_out_322151.awb") ~= 0 then
					local var_668_16 = manager.audio:GetVoiceLength("story_v_out_322151", "322151156", "story_v_out_322151.awb") / 1000

					if var_668_16 + var_668_7 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_16 + var_668_7
					end

					if var_668_11.prefab_name ~= "" and arg_665_1.actors_[var_668_11.prefab_name] ~= nil then
						local var_668_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_11.prefab_name].transform, "story_v_out_322151", "322151156", "story_v_out_322151.awb")

						arg_665_1:RecordAudio("322151156", var_668_17)
						arg_665_1:RecordAudio("322151156", var_668_17)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_out_322151", "322151156", "story_v_out_322151.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_out_322151", "322151156", "story_v_out_322151.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_18 = var_668_7 + 0.3
			local var_668_19 = math.max(var_668_8, arg_665_1.talkMaxDuration)

			if var_668_18 <= arg_665_1.time_ and arg_665_1.time_ < var_668_18 + var_668_19 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_18) / var_668_19

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_18 + var_668_19 and arg_665_1.time_ < var_668_18 + var_668_19 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.316666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 2.6, 4.5),
					endPos = Vector3.New(-0.1, 2.6, 4.5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_665_1:InitPlayNodeList()
	end,
	Play322151157 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 322151157
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play322151158(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0
			local var_674_1 = 0.85

			if var_674_0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_2 = arg_671_1:GetWordFromCfg(322151157)
				local var_674_3 = arg_671_1:FormatText(var_674_2.content)

				arg_671_1.text_.text = var_674_3

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_4 = 34
				local var_674_5 = utf8.len(var_674_3)
				local var_674_6 = var_674_4 <= 0 and var_674_1 or var_674_1 * (var_674_5 / var_674_4)

				if var_674_6 > 0 and var_674_1 < var_674_6 then
					arg_671_1.talkMaxDuration = var_674_6

					if var_674_6 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_6 + var_674_0
					end
				end

				arg_671_1.text_.text = var_674_3
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_7 = math.max(var_674_1, arg_671_1.talkMaxDuration)

			if var_674_0 <= arg_671_1.time_ and arg_671_1.time_ < var_674_0 + var_674_7 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_0) / var_674_7

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_0 + var_674_7 and arg_671_1.time_ < var_674_0 + var_674_7 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play322151158 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 322151158
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play322151159(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0
			local var_678_1 = 0.375

			if var_678_0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_2 = arg_675_1:FormatText(StoryNameCfg[7].name)

				arg_675_1.leftNameTxt_.text = var_678_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_3 = arg_675_1:GetWordFromCfg(322151158)
				local var_678_4 = arg_675_1:FormatText(var_678_3.content)

				arg_675_1.text_.text = var_678_4

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_5 = 15
				local var_678_6 = utf8.len(var_678_4)
				local var_678_7 = var_678_5 <= 0 and var_678_1 or var_678_1 * (var_678_6 / var_678_5)

				if var_678_7 > 0 and var_678_1 < var_678_7 then
					arg_675_1.talkMaxDuration = var_678_7

					if var_678_7 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_7 + var_678_0
					end
				end

				arg_675_1.text_.text = var_678_4
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_8 = math.max(var_678_1, arg_675_1.talkMaxDuration)

			if var_678_0 <= arg_675_1.time_ and arg_675_1.time_ < var_678_0 + var_678_8 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_0) / var_678_8

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_0 + var_678_8 and arg_675_1.time_ < var_678_0 + var_678_8 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play322151159 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 322151159
		arg_679_1.duration_ = 4.7

		local var_679_0 = {
			zh = 3.69933333333333,
			ja = 4.69933333333333
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play322151160(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = manager.ui.mainCamera.transform
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 then
				arg_679_1.var_.shakeOldPos = var_682_0.localPosition
			end

			local var_682_2 = 0.233333333333333

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / 0.066
				local var_682_4, var_682_5 = math.modf(var_682_3)

				var_682_0.localPosition = Vector3.New(var_682_5 * 0.13, var_682_5 * 0.13, var_682_5 * 0.13) + arg_679_1.var_.shakeOldPos
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 then
				var_682_0.localPosition = arg_679_1.var_.shakeOldPos
			end

			if arg_679_1.frameCnt_ <= 1 then
				arg_679_1.dialog_:SetActive(false)
			end

			local var_682_6 = 0.233333333333333
			local var_682_7 = 0.275

			if var_682_6 < arg_679_1.time_ and arg_679_1.time_ <= var_682_6 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0

				arg_679_1.dialog_:SetActive(true)

				arg_679_1.dialogCg_.alpha = 0

				local var_682_8 = LeanTween.value(arg_679_1.dialog_, 0, 1, 0.3)

				var_682_8:setOnUpdate(LuaHelper.FloatAction(function(arg_683_0)
					arg_679_1.dialogCg_.alpha = arg_683_0
				end))
				var_682_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_679_1.dialog_)
					var_682_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_679_1.duration_ = arg_679_1.duration_ + 0.3

				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_9 = arg_679_1:FormatText(StoryNameCfg[613].name)

				arg_679_1.leftNameTxt_.text = var_682_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_10 = arg_679_1:GetWordFromCfg(322151159)
				local var_682_11 = arg_679_1:FormatText(var_682_10.content)

				arg_679_1.text_.text = var_682_11

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_12 = 11
				local var_682_13 = utf8.len(var_682_11)
				local var_682_14 = var_682_12 <= 0 and var_682_7 or var_682_7 * (var_682_13 / var_682_12)

				if var_682_14 > 0 and var_682_7 < var_682_14 then
					arg_679_1.talkMaxDuration = var_682_14
					var_682_6 = var_682_6 + 0.3

					if var_682_14 + var_682_6 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_14 + var_682_6
					end
				end

				arg_679_1.text_.text = var_682_11
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151159", "story_v_out_322151.awb") ~= 0 then
					local var_682_15 = manager.audio:GetVoiceLength("story_v_out_322151", "322151159", "story_v_out_322151.awb") / 1000

					if var_682_15 + var_682_6 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_15 + var_682_6
					end

					if var_682_10.prefab_name ~= "" and arg_679_1.actors_[var_682_10.prefab_name] ~= nil then
						local var_682_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_10.prefab_name].transform, "story_v_out_322151", "322151159", "story_v_out_322151.awb")

						arg_679_1:RecordAudio("322151159", var_682_16)
						arg_679_1:RecordAudio("322151159", var_682_16)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_out_322151", "322151159", "story_v_out_322151.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_out_322151", "322151159", "story_v_out_322151.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_17 = var_682_6 + 0.3
			local var_682_18 = math.max(var_682_7, arg_679_1.talkMaxDuration)

			if var_682_17 <= arg_679_1.time_ and arg_679_1.time_ < var_682_17 + var_682_18 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_17) / var_682_18

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_17 + var_682_18 and arg_679_1.time_ < var_682_17 + var_682_18 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play322151160 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 322151160
		arg_685_1.duration_ = 4.33

		local var_685_0 = {
			zh = 3.066,
			ja = 4.333
		}
		local var_685_1 = manager.audio:GetLocalizationFlag()

		if var_685_0[var_685_1] ~= nil then
			arg_685_1.duration_ = var_685_0[var_685_1]
		end

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play322151161(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0
			local var_688_1 = 0.35

			if var_688_0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_2 = arg_685_1:FormatText(StoryNameCfg[613].name)

				arg_685_1.leftNameTxt_.text = var_688_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_3 = arg_685_1:GetWordFromCfg(322151160)
				local var_688_4 = arg_685_1:FormatText(var_688_3.content)

				arg_685_1.text_.text = var_688_4

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_5 = 14
				local var_688_6 = utf8.len(var_688_4)
				local var_688_7 = var_688_5 <= 0 and var_688_1 or var_688_1 * (var_688_6 / var_688_5)

				if var_688_7 > 0 and var_688_1 < var_688_7 then
					arg_685_1.talkMaxDuration = var_688_7

					if var_688_7 + var_688_0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_7 + var_688_0
					end
				end

				arg_685_1.text_.text = var_688_4
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151160", "story_v_out_322151.awb") ~= 0 then
					local var_688_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151160", "story_v_out_322151.awb") / 1000

					if var_688_8 + var_688_0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_8 + var_688_0
					end

					if var_688_3.prefab_name ~= "" and arg_685_1.actors_[var_688_3.prefab_name] ~= nil then
						local var_688_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_3.prefab_name].transform, "story_v_out_322151", "322151160", "story_v_out_322151.awb")

						arg_685_1:RecordAudio("322151160", var_688_9)
						arg_685_1:RecordAudio("322151160", var_688_9)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_out_322151", "322151160", "story_v_out_322151.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_out_322151", "322151160", "story_v_out_322151.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_10 = math.max(var_688_1, arg_685_1.talkMaxDuration)

			if var_688_0 <= arg_685_1.time_ and arg_685_1.time_ < var_688_0 + var_688_10 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_0) / var_688_10

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_0 + var_688_10 and arg_685_1.time_ < var_688_0 + var_688_10 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play322151161 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 322151161
		arg_689_1.duration_ = 5.53

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play322151162(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = arg_689_1.bgs_.MS2209.transform
			local var_692_1 = 0

			if var_692_1 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1.var_.moveOldPosMS2209 = var_692_0.localPosition
			end

			local var_692_2 = 0.533333333333333

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_2 then
				local var_692_3 = (arg_689_1.time_ - var_692_1) / var_692_2
				local var_692_4 = Vector3.New(0, 2.6, 4.5)

				var_692_0.localPosition = Vector3.Lerp(arg_689_1.var_.moveOldPosMS2209, var_692_4, var_692_3)
			end

			if arg_689_1.time_ >= var_692_1 + var_692_2 and arg_689_1.time_ < var_692_1 + var_692_2 + arg_692_0 then
				var_692_0.localPosition = Vector3.New(0, 2.6, 4.5)
			end

			local var_692_5 = 0

			if var_692_5 < arg_689_1.time_ and arg_689_1.time_ <= var_692_5 + arg_692_0 then
				arg_689_1.allBtn_.enabled = false
			end

			local var_692_6 = 0.733333333333333

			if arg_689_1.time_ >= var_692_5 + var_692_6 and arg_689_1.time_ < var_692_5 + var_692_6 + arg_692_0 then
				arg_689_1.allBtn_.enabled = true
			end

			if arg_689_1.frameCnt_ <= 1 then
				arg_689_1.dialog_:SetActive(false)
			end

			local var_692_7 = 0.533333333333333
			local var_692_8 = 0.575

			if var_692_7 < arg_689_1.time_ and arg_689_1.time_ <= var_692_7 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0

				arg_689_1.dialog_:SetActive(true)

				arg_689_1.dialogCg_.alpha = 0

				local var_692_9 = LeanTween.value(arg_689_1.dialog_, 0, 1, 0.3)

				var_692_9:setOnUpdate(LuaHelper.FloatAction(function(arg_693_0)
					arg_689_1.dialogCg_.alpha = arg_693_0
				end))
				var_692_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_689_1.dialog_)
					var_692_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_689_1.duration_ = arg_689_1.duration_ + 0.3

				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_10 = arg_689_1:FormatText(StoryNameCfg[7].name)

				arg_689_1.leftNameTxt_.text = var_692_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_11 = arg_689_1:GetWordFromCfg(322151161)
				local var_692_12 = arg_689_1:FormatText(var_692_11.content)

				arg_689_1.text_.text = var_692_12

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_13 = 23
				local var_692_14 = utf8.len(var_692_12)
				local var_692_15 = var_692_13 <= 0 and var_692_8 or var_692_8 * (var_692_14 / var_692_13)

				if var_692_15 > 0 and var_692_8 < var_692_15 then
					arg_689_1.talkMaxDuration = var_692_15
					var_692_7 = var_692_7 + 0.3

					if var_692_15 + var_692_7 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_15 + var_692_7
					end
				end

				arg_689_1.text_.text = var_692_12
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_16 = var_692_7 + 0.3
			local var_692_17 = math.max(var_692_8, arg_689_1.talkMaxDuration)

			if var_692_16 <= arg_689_1.time_ and arg_689_1.time_ < var_692_16 + var_692_17 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_16) / var_692_17

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_16 + var_692_17 and arg_689_1.time_ < var_692_16 + var_692_17 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.533333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.1, 2.6, 4.5),
					endPos = Vector3.New(0, 2.6, 4.5),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_689_1:InitPlayNodeList()
	end,
	Play322151162 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 322151162
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play322151163(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0
			local var_698_1 = 1.225

			if var_698_0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_2 = arg_695_1:FormatText(StoryNameCfg[7].name)

				arg_695_1.leftNameTxt_.text = var_698_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_3 = arg_695_1:GetWordFromCfg(322151162)
				local var_698_4 = arg_695_1:FormatText(var_698_3.content)

				arg_695_1.text_.text = var_698_4

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_5 = 49
				local var_698_6 = utf8.len(var_698_4)
				local var_698_7 = var_698_5 <= 0 and var_698_1 or var_698_1 * (var_698_6 / var_698_5)

				if var_698_7 > 0 and var_698_1 < var_698_7 then
					arg_695_1.talkMaxDuration = var_698_7

					if var_698_7 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_7 + var_698_0
					end
				end

				arg_695_1.text_.text = var_698_4
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_8 = math.max(var_698_1, arg_695_1.talkMaxDuration)

			if var_698_0 <= arg_695_1.time_ and arg_695_1.time_ < var_698_0 + var_698_8 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_0) / var_698_8

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_0 + var_698_8 and arg_695_1.time_ < var_698_0 + var_698_8 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play322151163 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 322151163
		arg_699_1.duration_ = 5.23

		local var_699_0 = {
			zh = 3.166,
			ja = 5.233
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play322151164(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = 0
			local var_702_1 = 0.3

			if var_702_0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_0 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_2 = arg_699_1:FormatText(StoryNameCfg[613].name)

				arg_699_1.leftNameTxt_.text = var_702_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_3 = arg_699_1:GetWordFromCfg(322151163)
				local var_702_4 = arg_699_1:FormatText(var_702_3.content)

				arg_699_1.text_.text = var_702_4

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_5 = 12
				local var_702_6 = utf8.len(var_702_4)
				local var_702_7 = var_702_5 <= 0 and var_702_1 or var_702_1 * (var_702_6 / var_702_5)

				if var_702_7 > 0 and var_702_1 < var_702_7 then
					arg_699_1.talkMaxDuration = var_702_7

					if var_702_7 + var_702_0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_7 + var_702_0
					end
				end

				arg_699_1.text_.text = var_702_4
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151163", "story_v_out_322151.awb") ~= 0 then
					local var_702_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151163", "story_v_out_322151.awb") / 1000

					if var_702_8 + var_702_0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_8 + var_702_0
					end

					if var_702_3.prefab_name ~= "" and arg_699_1.actors_[var_702_3.prefab_name] ~= nil then
						local var_702_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_3.prefab_name].transform, "story_v_out_322151", "322151163", "story_v_out_322151.awb")

						arg_699_1:RecordAudio("322151163", var_702_9)
						arg_699_1:RecordAudio("322151163", var_702_9)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_322151", "322151163", "story_v_out_322151.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_322151", "322151163", "story_v_out_322151.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_10 = math.max(var_702_1, arg_699_1.talkMaxDuration)

			if var_702_0 <= arg_699_1.time_ and arg_699_1.time_ < var_702_0 + var_702_10 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_0) / var_702_10

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_0 + var_702_10 and arg_699_1.time_ < var_702_0 + var_702_10 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play322151164 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 322151164
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play322151165(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = 0
			local var_706_1 = 1.225

			if var_706_0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_0 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_2 = arg_703_1:FormatText(StoryNameCfg[7].name)

				arg_703_1.leftNameTxt_.text = var_706_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_3 = arg_703_1:GetWordFromCfg(322151164)
				local var_706_4 = arg_703_1:FormatText(var_706_3.content)

				arg_703_1.text_.text = var_706_4

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_5 = 49
				local var_706_6 = utf8.len(var_706_4)
				local var_706_7 = var_706_5 <= 0 and var_706_1 or var_706_1 * (var_706_6 / var_706_5)

				if var_706_7 > 0 and var_706_1 < var_706_7 then
					arg_703_1.talkMaxDuration = var_706_7

					if var_706_7 + var_706_0 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_7 + var_706_0
					end
				end

				arg_703_1.text_.text = var_706_4
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_8 = math.max(var_706_1, arg_703_1.talkMaxDuration)

			if var_706_0 <= arg_703_1.time_ and arg_703_1.time_ < var_706_0 + var_706_8 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_0) / var_706_8

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_0 + var_706_8 and arg_703_1.time_ < var_706_0 + var_706_8 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play322151165 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 322151165
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play322151166(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0
			local var_710_1 = 0.85

			if var_710_0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_2 = arg_707_1:FormatText(StoryNameCfg[7].name)

				arg_707_1.leftNameTxt_.text = var_710_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_3 = arg_707_1:GetWordFromCfg(322151165)
				local var_710_4 = arg_707_1:FormatText(var_710_3.content)

				arg_707_1.text_.text = var_710_4

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_5 = 34
				local var_710_6 = utf8.len(var_710_4)
				local var_710_7 = var_710_5 <= 0 and var_710_1 or var_710_1 * (var_710_6 / var_710_5)

				if var_710_7 > 0 and var_710_1 < var_710_7 then
					arg_707_1.talkMaxDuration = var_710_7

					if var_710_7 + var_710_0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_7 + var_710_0
					end
				end

				arg_707_1.text_.text = var_710_4
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_8 = math.max(var_710_1, arg_707_1.talkMaxDuration)

			if var_710_0 <= arg_707_1.time_ and arg_707_1.time_ < var_710_0 + var_710_8 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_0) / var_710_8

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_0 + var_710_8 and arg_707_1.time_ < var_710_0 + var_710_8 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play322151166 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 322151166
		arg_711_1.duration_ = 4.2

		local var_711_0 = {
			zh = 3.566,
			ja = 4.2
		}
		local var_711_1 = manager.audio:GetLocalizationFlag()

		if var_711_0[var_711_1] ~= nil then
			arg_711_1.duration_ = var_711_0[var_711_1]
		end

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play322151167(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0
			local var_714_1 = 0.375

			if var_714_0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_2 = arg_711_1:FormatText(StoryNameCfg[613].name)

				arg_711_1.leftNameTxt_.text = var_714_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_3 = arg_711_1:GetWordFromCfg(322151166)
				local var_714_4 = arg_711_1:FormatText(var_714_3.content)

				arg_711_1.text_.text = var_714_4

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_5 = 15
				local var_714_6 = utf8.len(var_714_4)
				local var_714_7 = var_714_5 <= 0 and var_714_1 or var_714_1 * (var_714_6 / var_714_5)

				if var_714_7 > 0 and var_714_1 < var_714_7 then
					arg_711_1.talkMaxDuration = var_714_7

					if var_714_7 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_7 + var_714_0
					end
				end

				arg_711_1.text_.text = var_714_4
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151166", "story_v_out_322151.awb") ~= 0 then
					local var_714_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151166", "story_v_out_322151.awb") / 1000

					if var_714_8 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_8 + var_714_0
					end

					if var_714_3.prefab_name ~= "" and arg_711_1.actors_[var_714_3.prefab_name] ~= nil then
						local var_714_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_3.prefab_name].transform, "story_v_out_322151", "322151166", "story_v_out_322151.awb")

						arg_711_1:RecordAudio("322151166", var_714_9)
						arg_711_1:RecordAudio("322151166", var_714_9)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_out_322151", "322151166", "story_v_out_322151.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_out_322151", "322151166", "story_v_out_322151.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_10 = math.max(var_714_1, arg_711_1.talkMaxDuration)

			if var_714_0 <= arg_711_1.time_ and arg_711_1.time_ < var_714_0 + var_714_10 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_0) / var_714_10

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_0 + var_714_10 and arg_711_1.time_ < var_714_0 + var_714_10 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play322151167 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 322151167
		arg_715_1.duration_ = 5.37

		local var_715_0 = {
			zh = 3.966,
			ja = 5.366
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play322151168(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0
			local var_718_1 = 0.35

			if var_718_0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_2 = arg_715_1:FormatText(StoryNameCfg[613].name)

				arg_715_1.leftNameTxt_.text = var_718_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_3 = arg_715_1:GetWordFromCfg(322151167)
				local var_718_4 = arg_715_1:FormatText(var_718_3.content)

				arg_715_1.text_.text = var_718_4

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_5 = 14
				local var_718_6 = utf8.len(var_718_4)
				local var_718_7 = var_718_5 <= 0 and var_718_1 or var_718_1 * (var_718_6 / var_718_5)

				if var_718_7 > 0 and var_718_1 < var_718_7 then
					arg_715_1.talkMaxDuration = var_718_7

					if var_718_7 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_7 + var_718_0
					end
				end

				arg_715_1.text_.text = var_718_4
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151167", "story_v_out_322151.awb") ~= 0 then
					local var_718_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151167", "story_v_out_322151.awb") / 1000

					if var_718_8 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_8 + var_718_0
					end

					if var_718_3.prefab_name ~= "" and arg_715_1.actors_[var_718_3.prefab_name] ~= nil then
						local var_718_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_3.prefab_name].transform, "story_v_out_322151", "322151167", "story_v_out_322151.awb")

						arg_715_1:RecordAudio("322151167", var_718_9)
						arg_715_1:RecordAudio("322151167", var_718_9)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_out_322151", "322151167", "story_v_out_322151.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_out_322151", "322151167", "story_v_out_322151.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_10 = math.max(var_718_1, arg_715_1.talkMaxDuration)

			if var_718_0 <= arg_715_1.time_ and arg_715_1.time_ < var_718_0 + var_718_10 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_0) / var_718_10

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_0 + var_718_10 and arg_715_1.time_ < var_718_0 + var_718_10 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play322151168 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 322151168
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play322151169(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0
			local var_722_1 = 0.05

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_2 = arg_719_1:FormatText(StoryNameCfg[7].name)

				arg_719_1.leftNameTxt_.text = var_722_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_3 = arg_719_1:GetWordFromCfg(322151168)
				local var_722_4 = arg_719_1:FormatText(var_722_3.content)

				arg_719_1.text_.text = var_722_4

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_5 = 2
				local var_722_6 = utf8.len(var_722_4)
				local var_722_7 = var_722_5 <= 0 and var_722_1 or var_722_1 * (var_722_6 / var_722_5)

				if var_722_7 > 0 and var_722_1 < var_722_7 then
					arg_719_1.talkMaxDuration = var_722_7

					if var_722_7 + var_722_0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_7 + var_722_0
					end
				end

				arg_719_1.text_.text = var_722_4
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_8 = math.max(var_722_1, arg_719_1.talkMaxDuration)

			if var_722_0 <= arg_719_1.time_ and arg_719_1.time_ < var_722_0 + var_722_8 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_0) / var_722_8

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_0 + var_722_8 and arg_719_1.time_ < var_722_0 + var_722_8 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play322151169 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 322151169
		arg_723_1.duration_ = 6.57

		local var_723_0 = {
			zh = 3.7,
			ja = 6.566
		}
		local var_723_1 = manager.audio:GetLocalizationFlag()

		if var_723_0[var_723_1] ~= nil then
			arg_723_1.duration_ = var_723_0[var_723_1]
		end

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play322151170(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = 0
			local var_726_1 = 0.475

			if var_726_0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				local var_726_2 = arg_723_1:FormatText(StoryNameCfg[613].name)

				arg_723_1.leftNameTxt_.text = var_726_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_3 = arg_723_1:GetWordFromCfg(322151169)
				local var_726_4 = arg_723_1:FormatText(var_726_3.content)

				arg_723_1.text_.text = var_726_4

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_5 = 19
				local var_726_6 = utf8.len(var_726_4)
				local var_726_7 = var_726_5 <= 0 and var_726_1 or var_726_1 * (var_726_6 / var_726_5)

				if var_726_7 > 0 and var_726_1 < var_726_7 then
					arg_723_1.talkMaxDuration = var_726_7

					if var_726_7 + var_726_0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_7 + var_726_0
					end
				end

				arg_723_1.text_.text = var_726_4
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151169", "story_v_out_322151.awb") ~= 0 then
					local var_726_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151169", "story_v_out_322151.awb") / 1000

					if var_726_8 + var_726_0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_8 + var_726_0
					end

					if var_726_3.prefab_name ~= "" and arg_723_1.actors_[var_726_3.prefab_name] ~= nil then
						local var_726_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_3.prefab_name].transform, "story_v_out_322151", "322151169", "story_v_out_322151.awb")

						arg_723_1:RecordAudio("322151169", var_726_9)
						arg_723_1:RecordAudio("322151169", var_726_9)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_out_322151", "322151169", "story_v_out_322151.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_out_322151", "322151169", "story_v_out_322151.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_10 = math.max(var_726_1, arg_723_1.talkMaxDuration)

			if var_726_0 <= arg_723_1.time_ and arg_723_1.time_ < var_726_0 + var_726_10 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_0) / var_726_10

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_0 + var_726_10 and arg_723_1.time_ < var_726_0 + var_726_10 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play322151170 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 322151170
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play322151171(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = 0
			local var_730_1 = 1.125

			if var_730_0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_0 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				local var_730_2 = arg_727_1:FormatText(StoryNameCfg[7].name)

				arg_727_1.leftNameTxt_.text = var_730_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_3 = arg_727_1:GetWordFromCfg(322151170)
				local var_730_4 = arg_727_1:FormatText(var_730_3.content)

				arg_727_1.text_.text = var_730_4

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_5 = 45
				local var_730_6 = utf8.len(var_730_4)
				local var_730_7 = var_730_5 <= 0 and var_730_1 or var_730_1 * (var_730_6 / var_730_5)

				if var_730_7 > 0 and var_730_1 < var_730_7 then
					arg_727_1.talkMaxDuration = var_730_7

					if var_730_7 + var_730_0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_7 + var_730_0
					end
				end

				arg_727_1.text_.text = var_730_4
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_8 = math.max(var_730_1, arg_727_1.talkMaxDuration)

			if var_730_0 <= arg_727_1.time_ and arg_727_1.time_ < var_730_0 + var_730_8 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_0) / var_730_8

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_0 + var_730_8 and arg_727_1.time_ < var_730_0 + var_730_8 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play322151171 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 322151171
		arg_731_1.duration_ = 9.7

		local var_731_0 = {
			zh = 5.866,
			ja = 9.7
		}
		local var_731_1 = manager.audio:GetLocalizationFlag()

		if var_731_0[var_731_1] ~= nil then
			arg_731_1.duration_ = var_731_0[var_731_1]
		end

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play322151172(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0
			local var_734_1 = 0.725

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_2 = arg_731_1:FormatText(StoryNameCfg[613].name)

				arg_731_1.leftNameTxt_.text = var_734_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_3 = arg_731_1:GetWordFromCfg(322151171)
				local var_734_4 = arg_731_1:FormatText(var_734_3.content)

				arg_731_1.text_.text = var_734_4

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_5 = 29
				local var_734_6 = utf8.len(var_734_4)
				local var_734_7 = var_734_5 <= 0 and var_734_1 or var_734_1 * (var_734_6 / var_734_5)

				if var_734_7 > 0 and var_734_1 < var_734_7 then
					arg_731_1.talkMaxDuration = var_734_7

					if var_734_7 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_7 + var_734_0
					end
				end

				arg_731_1.text_.text = var_734_4
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151171", "story_v_out_322151.awb") ~= 0 then
					local var_734_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151171", "story_v_out_322151.awb") / 1000

					if var_734_8 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_8 + var_734_0
					end

					if var_734_3.prefab_name ~= "" and arg_731_1.actors_[var_734_3.prefab_name] ~= nil then
						local var_734_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_3.prefab_name].transform, "story_v_out_322151", "322151171", "story_v_out_322151.awb")

						arg_731_1:RecordAudio("322151171", var_734_9)
						arg_731_1:RecordAudio("322151171", var_734_9)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_out_322151", "322151171", "story_v_out_322151.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_out_322151", "322151171", "story_v_out_322151.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_10 = math.max(var_734_1, arg_731_1.talkMaxDuration)

			if var_734_0 <= arg_731_1.time_ and arg_731_1.time_ < var_734_0 + var_734_10 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_0) / var_734_10

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_0 + var_734_10 and arg_731_1.time_ < var_734_0 + var_734_10 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play322151172 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 322151172
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play322151173(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = 0
			local var_738_1 = 0.85

			if var_738_0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_0 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				local var_738_2 = arg_735_1:FormatText(StoryNameCfg[7].name)

				arg_735_1.leftNameTxt_.text = var_738_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_3 = arg_735_1:GetWordFromCfg(322151172)
				local var_738_4 = arg_735_1:FormatText(var_738_3.content)

				arg_735_1.text_.text = var_738_4

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_5 = 34
				local var_738_6 = utf8.len(var_738_4)
				local var_738_7 = var_738_5 <= 0 and var_738_1 or var_738_1 * (var_738_6 / var_738_5)

				if var_738_7 > 0 and var_738_1 < var_738_7 then
					arg_735_1.talkMaxDuration = var_738_7

					if var_738_7 + var_738_0 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_7 + var_738_0
					end
				end

				arg_735_1.text_.text = var_738_4
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_8 = math.max(var_738_1, arg_735_1.talkMaxDuration)

			if var_738_0 <= arg_735_1.time_ and arg_735_1.time_ < var_738_0 + var_738_8 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_0) / var_738_8

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_0 + var_738_8 and arg_735_1.time_ < var_738_0 + var_738_8 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play322151173 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 322151173
		arg_739_1.duration_ = 3.3

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play322151174(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = 0
			local var_742_1 = 0.05

			if var_742_0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_0 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				local var_742_2 = arg_739_1:FormatText(StoryNameCfg[613].name)

				arg_739_1.leftNameTxt_.text = var_742_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_3 = arg_739_1:GetWordFromCfg(322151173)
				local var_742_4 = arg_739_1:FormatText(var_742_3.content)

				arg_739_1.text_.text = var_742_4

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_5 = 2
				local var_742_6 = utf8.len(var_742_4)
				local var_742_7 = var_742_5 <= 0 and var_742_1 or var_742_1 * (var_742_6 / var_742_5)

				if var_742_7 > 0 and var_742_1 < var_742_7 then
					arg_739_1.talkMaxDuration = var_742_7

					if var_742_7 + var_742_0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_7 + var_742_0
					end
				end

				arg_739_1.text_.text = var_742_4
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151173", "story_v_out_322151.awb") ~= 0 then
					local var_742_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151173", "story_v_out_322151.awb") / 1000

					if var_742_8 + var_742_0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_8 + var_742_0
					end

					if var_742_3.prefab_name ~= "" and arg_739_1.actors_[var_742_3.prefab_name] ~= nil then
						local var_742_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_739_1.actors_[var_742_3.prefab_name].transform, "story_v_out_322151", "322151173", "story_v_out_322151.awb")

						arg_739_1:RecordAudio("322151173", var_742_9)
						arg_739_1:RecordAudio("322151173", var_742_9)
					else
						arg_739_1:AudioAction("play", "voice", "story_v_out_322151", "322151173", "story_v_out_322151.awb")
					end

					arg_739_1:RecordHistoryTalkVoice("story_v_out_322151", "322151173", "story_v_out_322151.awb")
				end

				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_10 = math.max(var_742_1, arg_739_1.talkMaxDuration)

			if var_742_0 <= arg_739_1.time_ and arg_739_1.time_ < var_742_0 + var_742_10 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_0) / var_742_10

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_0 + var_742_10 and arg_739_1.time_ < var_742_0 + var_742_10 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play322151174 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 322151174
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
			arg_743_1.auto_ = false
		end

		function arg_743_1.playNext_(arg_745_0)
			arg_743_1.onStoryFinished_()
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = 0
			local var_746_1 = 0.475

			if var_746_0 < arg_743_1.time_ and arg_743_1.time_ <= var_746_0 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				local var_746_2 = arg_743_1:FormatText(StoryNameCfg[7].name)

				arg_743_1.leftNameTxt_.text = var_746_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_3 = arg_743_1:GetWordFromCfg(322151174)
				local var_746_4 = arg_743_1:FormatText(var_746_3.content)

				arg_743_1.text_.text = var_746_4

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_5 = 19
				local var_746_6 = utf8.len(var_746_4)
				local var_746_7 = var_746_5 <= 0 and var_746_1 or var_746_1 * (var_746_6 / var_746_5)

				if var_746_7 > 0 and var_746_1 < var_746_7 then
					arg_743_1.talkMaxDuration = var_746_7

					if var_746_7 + var_746_0 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_7 + var_746_0
					end
				end

				arg_743_1.text_.text = var_746_4
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_8 = math.max(var_746_1, arg_743_1.talkMaxDuration)

			if var_746_0 <= arg_743_1.time_ and arg_743_1.time_ < var_746_0 + var_746_8 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_0) / var_746_8

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_0 + var_746_8 and arg_743_1.time_ < var_746_0 + var_746_8 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/ST0502",
		"TextureConfig/Background/ST0510",
		"TextureConfig/Background/MS2209",
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/MS2209a",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L08f",
		"TextureConfig/Background/ST0507a"
	},
	voices = {
		"story_v_out_322151.awb"
	}
}
