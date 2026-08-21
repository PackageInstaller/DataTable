return {
	Play304071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304071001
		arg_1_1.duration_ = 8.03

		local var_1_0 = {
			zh = 8.03266666666667,
			ja = 3.09966666666667
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
				arg_1_0:Play304071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B02e"

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
				local var_4_5 = arg_1_1.bgs_.B02e

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
					if iter_4_0 ~= "B02e" then
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

			local var_4_33 = 0.2
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_4_37 = 1
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "music"

				arg_1_1:AudioAction(var_4_39, var_4_40, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_41 = ""
				local var_4_42 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if var_4_42 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_42 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_42

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_42
						arg_1_1.bgmTxt2_.text = var_4_42
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

			local var_4_43 = 0
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_47 = 1.76666666666667
			local var_4_48 = 0.625

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

				local var_4_51 = arg_1_1:GetWordFromCfg(304071001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071001", "story_v_out_304071.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_304071", "304071001", "story_v_out_304071.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_304071", "304071001", "story_v_out_304071.awb")

						arg_1_1:RecordAudio("304071001", var_4_57)
						arg_1_1:RecordAudio("304071001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304071", "304071001", "story_v_out_304071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304071", "304071001", "story_v_out_304071.awb")
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
	Play304071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304071003(arg_8_1)
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
			local var_11_7 = 1.525

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

				local var_11_8 = arg_8_1:GetWordFromCfg(304071002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 61
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
	Play304071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304071003
		arg_12_1.duration_ = 12.5

		local var_12_0 = {
			zh = 6.6,
			ja = 12.5
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
				arg_12_0:Play304071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1019ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["1019ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1019ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_15_20 = 0
			local var_15_21 = 0.825

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_22 = arg_12_1:FormatText(StoryNameCfg[13].name)

				arg_12_1.leftNameTxt_.text = var_15_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(304071003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 33
				local var_15_26 = utf8.len(var_15_24)
				local var_15_27 = var_15_25 <= 0 and var_15_21 or var_15_21 * (var_15_26 / var_15_25)

				if var_15_27 > 0 and var_15_21 < var_15_27 then
					arg_12_1.talkMaxDuration = var_15_27

					if var_15_27 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_27 + var_15_20
					end
				end

				arg_12_1.text_.text = var_15_24
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071003", "story_v_out_304071.awb") ~= 0 then
					local var_15_28 = manager.audio:GetVoiceLength("story_v_out_304071", "304071003", "story_v_out_304071.awb") / 1000

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end

					if var_15_23.prefab_name ~= "" and arg_12_1.actors_[var_15_23.prefab_name] ~= nil then
						local var_15_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_23.prefab_name].transform, "story_v_out_304071", "304071003", "story_v_out_304071.awb")

						arg_12_1:RecordAudio("304071003", var_15_29)
						arg_12_1:RecordAudio("304071003", var_15_29)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304071", "304071003", "story_v_out_304071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304071", "304071003", "story_v_out_304071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_30 = math.max(var_15_21, arg_12_1.talkMaxDuration)

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_30 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_20) / var_15_30

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_20 + var_15_30 and arg_12_1.time_ < var_15_20 + var_15_30 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play304071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304071004
		arg_16_1.duration_ = 6.4

		local var_16_0 = {
			zh = 6.4,
			ja = 6.3
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
				arg_16_0:Play304071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.575

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(304071004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071004", "story_v_out_304071.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071004", "story_v_out_304071.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_304071", "304071004", "story_v_out_304071.awb")

						arg_16_1:RecordAudio("304071004", var_19_9)
						arg_16_1:RecordAudio("304071004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304071", "304071004", "story_v_out_304071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304071", "304071004", "story_v_out_304071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play304071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304071005
		arg_20_1.duration_ = 5.8

		local var_20_0 = {
			zh = 5.8,
			ja = 1.999999999999
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
				arg_20_0:Play304071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1084ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(-0.7, -0.97, -6)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(-0.7, -0.97, -6)

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

			local var_23_18 = arg_20_1.actors_["1084ui_story"]
			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 and not isNil(var_23_18) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_20 = 0.200000002980232

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_20 and not isNil(var_23_18) then
				local var_23_21 = (arg_20_1.time_ - var_23_19) / var_23_20

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_18) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_19 + var_23_20 and arg_20_1.time_ < var_23_19 + var_23_20 + arg_23_0 and not isNil(var_23_18) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
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
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_23_29 = 0

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_30 = 0
			local var_23_31 = 0.575

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_32 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_33 = arg_20_1:GetWordFromCfg(304071005)
				local var_23_34 = arg_20_1:FormatText(var_23_33.content)

				arg_20_1.text_.text = var_23_34

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_35 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071005", "story_v_out_304071.awb") ~= 0 then
					local var_23_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071005", "story_v_out_304071.awb") / 1000

					if var_23_38 + var_23_30 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_38 + var_23_30
					end

					if var_23_33.prefab_name ~= "" and arg_20_1.actors_[var_23_33.prefab_name] ~= nil then
						local var_23_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_33.prefab_name].transform, "story_v_out_304071", "304071005", "story_v_out_304071.awb")

						arg_20_1:RecordAudio("304071005", var_23_39)
						arg_20_1:RecordAudio("304071005", var_23_39)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304071", "304071005", "story_v_out_304071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304071", "304071005", "story_v_out_304071.awb")
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
				actorName = "1084ui_story",
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
	Play304071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304071006
		arg_24_1.duration_ = 7.67

		local var_24_0 = {
			zh = 6.066,
			ja = 7.666
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
				arg_24_0:Play304071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1011ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_24_1.stage_.transform)

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

			local var_27_5 = arg_24_1.actors_["1011ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_5.localPosition
			end

			local var_27_7 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7
				local var_27_9 = Vector3.New(0.7, -0.71, -6)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, var_27_9, var_27_8)

				local var_27_10 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_10.x, var_27_10.y, var_27_10.z)

				local var_27_11 = var_27_5.localEulerAngles

				var_27_11.z = 0
				var_27_11.x = 0
				var_27_5.localEulerAngles = var_27_11
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_5.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_5.localEulerAngles = var_27_13
			end

			local var_27_14 = arg_24_1.actors_["1011ui_story"]
			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect1011ui_story == nil then
				arg_24_1.var_.characterEffect1011ui_story = var_27_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_16 = 0.200000002980232

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_16 and not isNil(var_27_14) then
				local var_27_17 = (arg_24_1.time_ - var_27_15) / var_27_16

				if arg_24_1.var_.characterEffect1011ui_story and not isNil(var_27_14) then
					arg_24_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_15 + var_27_16 and arg_24_1.time_ < var_27_15 + var_27_16 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect1011ui_story then
				arg_24_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_27_18 = arg_24_1.actors_["1084ui_story"]
			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_20 = 0.200000002980232

			if var_27_19 <= arg_24_1.time_ and arg_24_1.time_ < var_27_19 + var_27_20 and not isNil(var_27_18) then
				local var_27_21 = (arg_24_1.time_ - var_27_19) / var_27_20

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_18) then
					local var_27_22 = Mathf.Lerp(0, 0.5, var_27_21)

					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_22
				end
			end

			if arg_24_1.time_ >= var_27_19 + var_27_20 and arg_24_1.time_ < var_27_19 + var_27_20 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect1084ui_story then
				local var_27_23 = 0.5

				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_23
			end

			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_26 = 0
			local var_27_27 = 0.625

			if var_27_26 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_28 = arg_24_1:FormatText(StoryNameCfg[37].name)

				arg_24_1.leftNameTxt_.text = var_27_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_29 = arg_24_1:GetWordFromCfg(304071006)
				local var_27_30 = arg_24_1:FormatText(var_27_29.content)

				arg_24_1.text_.text = var_27_30

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_31 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071006", "story_v_out_304071.awb") ~= 0 then
					local var_27_34 = manager.audio:GetVoiceLength("story_v_out_304071", "304071006", "story_v_out_304071.awb") / 1000

					if var_27_34 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_26
					end

					if var_27_29.prefab_name ~= "" and arg_24_1.actors_[var_27_29.prefab_name] ~= nil then
						local var_27_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_29.prefab_name].transform, "story_v_out_304071", "304071006", "story_v_out_304071.awb")

						arg_24_1:RecordAudio("304071006", var_27_35)
						arg_24_1:RecordAudio("304071006", var_27_35)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304071", "304071006", "story_v_out_304071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304071", "304071006", "story_v_out_304071.awb")
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
				actorName = "1011ui_story",
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
	Play304071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304071007
		arg_28_1.duration_ = 3.33

		local var_28_0 = {
			zh = 3.333,
			ja = 2.966
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
				arg_28_0:Play304071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_9.localPosition
			end

			local var_31_11 = 0.001

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11
				local var_31_13 = Vector3.New(0, 100, 0)

				var_31_9.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_13, var_31_12)

				local var_31_14 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_14.x, var_31_14.y, var_31_14.z)

				local var_31_15 = var_31_9.localEulerAngles

				var_31_15.z = 0
				var_31_15.x = 0
				var_31_9.localEulerAngles = var_31_15
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 then
				var_31_9.localPosition = Vector3.New(0, 100, 0)

				local var_31_16 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_16.x, var_31_16.y, var_31_16.z)

				local var_31_17 = var_31_9.localEulerAngles

				var_31_17.z = 0
				var_31_17.x = 0
				var_31_9.localEulerAngles = var_31_17
			end

			local var_31_18 = arg_28_1.actors_["1019ui_story"]
			local var_31_19 = 0

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 and not isNil(var_31_18) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_20 = 0.200000002980232

			if var_31_19 <= arg_28_1.time_ and arg_28_1.time_ < var_31_19 + var_31_20 and not isNil(var_31_18) then
				local var_31_21 = (arg_28_1.time_ - var_31_19) / var_31_20

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_18) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_19 + var_31_20 and arg_28_1.time_ < var_31_19 + var_31_20 + arg_31_0 and not isNil(var_31_18) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_22 = arg_28_1.actors_["1011ui_story"]
			local var_31_23 = 0

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 and not isNil(var_31_22) and arg_28_1.var_.characterEffect1011ui_story == nil then
				arg_28_1.var_.characterEffect1011ui_story = var_31_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_24 = 0.200000002980232

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_24 and not isNil(var_31_22) then
				local var_31_25 = (arg_28_1.time_ - var_31_23) / var_31_24

				if arg_28_1.var_.characterEffect1011ui_story and not isNil(var_31_22) then
					local var_31_26 = Mathf.Lerp(0, 0.5, var_31_25)

					arg_28_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1011ui_story.fillRatio = var_31_26
				end
			end

			if arg_28_1.time_ >= var_31_23 + var_31_24 and arg_28_1.time_ < var_31_23 + var_31_24 + arg_31_0 and not isNil(var_31_22) and arg_28_1.var_.characterEffect1011ui_story then
				local var_31_27 = 0.5

				arg_28_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1011ui_story.fillRatio = var_31_27
			end

			local var_31_28 = 0

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_2")
			end

			local var_31_29 = 0

			if var_31_29 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_30 = 0
			local var_31_31 = 0.45

			if var_31_30 < arg_28_1.time_ and arg_28_1.time_ <= var_31_30 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_32 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_33 = arg_28_1:GetWordFromCfg(304071007)
				local var_31_34 = arg_28_1:FormatText(var_31_33.content)

				arg_28_1.text_.text = var_31_34

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_35 = 18
				local var_31_36 = utf8.len(var_31_34)
				local var_31_37 = var_31_35 <= 0 and var_31_31 or var_31_31 * (var_31_36 / var_31_35)

				if var_31_37 > 0 and var_31_31 < var_31_37 then
					arg_28_1.talkMaxDuration = var_31_37

					if var_31_37 + var_31_30 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_37 + var_31_30
					end
				end

				arg_28_1.text_.text = var_31_34
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071007", "story_v_out_304071.awb") ~= 0 then
					local var_31_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071007", "story_v_out_304071.awb") / 1000

					if var_31_38 + var_31_30 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_38 + var_31_30
					end

					if var_31_33.prefab_name ~= "" and arg_28_1.actors_[var_31_33.prefab_name] ~= nil then
						local var_31_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_33.prefab_name].transform, "story_v_out_304071", "304071007", "story_v_out_304071.awb")

						arg_28_1:RecordAudio("304071007", var_31_39)
						arg_28_1:RecordAudio("304071007", var_31_39)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304071", "304071007", "story_v_out_304071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304071", "304071007", "story_v_out_304071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_40 = math.max(var_31_31, arg_28_1.talkMaxDuration)

			if var_31_30 <= arg_28_1.time_ and arg_28_1.time_ < var_31_30 + var_31_40 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_30) / var_31_40

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_30 + var_31_40 and arg_28_1.time_ < var_31_30 + var_31_40 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play304071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304071008
		arg_32_1.duration_ = 7.67

		local var_32_0 = {
			zh = 4.1,
			ja = 7.666
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
				arg_32_0:Play304071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.575

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(304071008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 23
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071008", "story_v_out_304071.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071008", "story_v_out_304071.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_304071", "304071008", "story_v_out_304071.awb")

						arg_32_1:RecordAudio("304071008", var_35_9)
						arg_32_1:RecordAudio("304071008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304071", "304071008", "story_v_out_304071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304071", "304071008", "story_v_out_304071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304071009
		arg_36_1.duration_ = 11.07

		local var_36_0 = {
			zh = 9.066,
			ja = 11.066
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
				arg_36_0:Play304071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1011ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1011ui_story == nil then
				arg_36_1.var_.characterEffect1011ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1011ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1011ui_story then
				arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1019ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1019ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action423")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_12 = 0
			local var_39_13 = 0.875

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[37].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(304071009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071009", "story_v_out_304071.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071009", "story_v_out_304071.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_304071", "304071009", "story_v_out_304071.awb")

						arg_36_1:RecordAudio("304071009", var_39_21)
						arg_36_1:RecordAudio("304071009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304071", "304071009", "story_v_out_304071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304071", "304071009", "story_v_out_304071.awb")
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
	Play304071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304071010
		arg_40_1.duration_ = 7.03

		local var_40_0 = {
			zh = 7.033,
			ja = 1.999999999999
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
				arg_40_0:Play304071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(-0.7, -0.97, -6)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["1084ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_9) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_13 = arg_40_1.actors_["1011ui_story"]
			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 and not isNil(var_43_13) and arg_40_1.var_.characterEffect1011ui_story == nil then
				arg_40_1.var_.characterEffect1011ui_story = var_43_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_15 = 0.200000002980232

			if var_43_14 <= arg_40_1.time_ and arg_40_1.time_ < var_43_14 + var_43_15 and not isNil(var_43_13) then
				local var_43_16 = (arg_40_1.time_ - var_43_14) / var_43_15

				if arg_40_1.var_.characterEffect1011ui_story and not isNil(var_43_13) then
					local var_43_17 = Mathf.Lerp(0, 0.5, var_43_16)

					arg_40_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1011ui_story.fillRatio = var_43_17
				end
			end

			if arg_40_1.time_ >= var_43_14 + var_43_15 and arg_40_1.time_ < var_43_14 + var_43_15 + arg_43_0 and not isNil(var_43_13) and arg_40_1.var_.characterEffect1011ui_story then
				local var_43_18 = 0.5

				arg_40_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1011ui_story.fillRatio = var_43_18
			end

			local var_43_19 = 0

			if var_43_19 < arg_40_1.time_ and arg_40_1.time_ <= var_43_19 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			local var_43_20 = 0

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_21 = arg_40_1.actors_["1019ui_story"].transform
			local var_43_22 = 0

			if var_43_22 < arg_40_1.time_ and arg_40_1.time_ <= var_43_22 + arg_43_0 then
				arg_40_1.var_.moveOldPos1019ui_story = var_43_21.localPosition
			end

			local var_43_23 = 0.001

			if var_43_22 <= arg_40_1.time_ and arg_40_1.time_ < var_43_22 + var_43_23 then
				local var_43_24 = (arg_40_1.time_ - var_43_22) / var_43_23
				local var_43_25 = Vector3.New(0, 100, 0)

				var_43_21.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1019ui_story, var_43_25, var_43_24)

				local var_43_26 = manager.ui.mainCamera.transform.position - var_43_21.position

				var_43_21.forward = Vector3.New(var_43_26.x, var_43_26.y, var_43_26.z)

				local var_43_27 = var_43_21.localEulerAngles

				var_43_27.z = 0
				var_43_27.x = 0
				var_43_21.localEulerAngles = var_43_27
			end

			if arg_40_1.time_ >= var_43_22 + var_43_23 and arg_40_1.time_ < var_43_22 + var_43_23 + arg_43_0 then
				var_43_21.localPosition = Vector3.New(0, 100, 0)

				local var_43_28 = manager.ui.mainCamera.transform.position - var_43_21.position

				var_43_21.forward = Vector3.New(var_43_28.x, var_43_28.y, var_43_28.z)

				local var_43_29 = var_43_21.localEulerAngles

				var_43_29.z = 0
				var_43_29.x = 0
				var_43_21.localEulerAngles = var_43_29
			end

			local var_43_30 = 0
			local var_43_31 = 0.825

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_32 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_33 = arg_40_1:GetWordFromCfg(304071010)
				local var_43_34 = arg_40_1:FormatText(var_43_33.content)

				arg_40_1.text_.text = var_43_34

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_35 = 33
				local var_43_36 = utf8.len(var_43_34)
				local var_43_37 = var_43_35 <= 0 and var_43_31 or var_43_31 * (var_43_36 / var_43_35)

				if var_43_37 > 0 and var_43_31 < var_43_37 then
					arg_40_1.talkMaxDuration = var_43_37

					if var_43_37 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_37 + var_43_30
					end
				end

				arg_40_1.text_.text = var_43_34
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071010", "story_v_out_304071.awb") ~= 0 then
					local var_43_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071010", "story_v_out_304071.awb") / 1000

					if var_43_38 + var_43_30 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_38 + var_43_30
					end

					if var_43_33.prefab_name ~= "" and arg_40_1.actors_[var_43_33.prefab_name] ~= nil then
						local var_43_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_33.prefab_name].transform, "story_v_out_304071", "304071010", "story_v_out_304071.awb")

						arg_40_1:RecordAudio("304071010", var_43_39)
						arg_40_1:RecordAudio("304071010", var_43_39)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304071", "304071010", "story_v_out_304071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304071", "304071010", "story_v_out_304071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_40 = math.max(var_43_31, arg_40_1.talkMaxDuration)

			if var_43_30 <= arg_40_1.time_ and arg_40_1.time_ < var_43_30 + var_43_40 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_30) / var_43_40

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_30 + var_43_40 and arg_40_1.time_ < var_43_30 + var_43_40 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_40_1:InitPlayNodeList()
	end,
	Play304071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304071011
		arg_44_1.duration_ = 6.27

		local var_44_0 = {
			zh = 6.266,
			ja = 1.333
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
				arg_44_0:Play304071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.6

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(304071011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071011", "story_v_out_304071.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071011", "story_v_out_304071.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_304071", "304071011", "story_v_out_304071.awb")

						arg_44_1:RecordAudio("304071011", var_47_9)
						arg_44_1:RecordAudio("304071011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304071", "304071011", "story_v_out_304071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304071", "304071011", "story_v_out_304071.awb")
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
	Play304071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304071012
		arg_48_1.duration_ = 8.47

		local var_48_0 = {
			zh = 8.466,
			ja = 7.966
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
				arg_48_0:Play304071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1011ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0.7, -0.71, -6)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1011ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1011ui_story == nil then
				arg_48_1.var_.characterEffect1011ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1011ui_story and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1011ui_story then
				arg_48_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_51_13 = arg_48_1.actors_["1084ui_story"]
			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 and not isNil(var_51_13) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_15 = 0.200000002980232

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_15 and not isNil(var_51_13) then
				local var_51_16 = (arg_48_1.time_ - var_51_14) / var_51_15

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_13) then
					local var_51_17 = Mathf.Lerp(0, 0.5, var_51_16)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_17
				end
			end

			if arg_48_1.time_ >= var_51_14 + var_51_15 and arg_48_1.time_ < var_51_14 + var_51_15 + arg_51_0 and not isNil(var_51_13) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_18 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_18
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_21 = 0
			local var_51_22 = 0.875

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_23 = arg_48_1:FormatText(StoryNameCfg[37].name)

				arg_48_1.leftNameTxt_.text = var_51_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_24 = arg_48_1:GetWordFromCfg(304071012)
				local var_51_25 = arg_48_1:FormatText(var_51_24.content)

				arg_48_1.text_.text = var_51_25

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_26 = 35
				local var_51_27 = utf8.len(var_51_25)
				local var_51_28 = var_51_26 <= 0 and var_51_22 or var_51_22 * (var_51_27 / var_51_26)

				if var_51_28 > 0 and var_51_22 < var_51_28 then
					arg_48_1.talkMaxDuration = var_51_28

					if var_51_28 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_21
					end
				end

				arg_48_1.text_.text = var_51_25
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071012", "story_v_out_304071.awb") ~= 0 then
					local var_51_29 = manager.audio:GetVoiceLength("story_v_out_304071", "304071012", "story_v_out_304071.awb") / 1000

					if var_51_29 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_29 + var_51_21
					end

					if var_51_24.prefab_name ~= "" and arg_48_1.actors_[var_51_24.prefab_name] ~= nil then
						local var_51_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_24.prefab_name].transform, "story_v_out_304071", "304071012", "story_v_out_304071.awb")

						arg_48_1:RecordAudio("304071012", var_51_30)
						arg_48_1:RecordAudio("304071012", var_51_30)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304071", "304071012", "story_v_out_304071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304071", "304071012", "story_v_out_304071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_31 = math.max(var_51_22, arg_48_1.talkMaxDuration)

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_31 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_21) / var_51_31

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_21 + var_51_31 and arg_48_1.time_ < var_51_21 + var_51_31 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play304071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304071013
		arg_52_1.duration_ = 5.43

		local var_52_0 = {
			zh = 5.433,
			ja = 4.133
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
				arg_52_0:Play304071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.475

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[37].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(304071013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071013", "story_v_out_304071.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071013", "story_v_out_304071.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_304071", "304071013", "story_v_out_304071.awb")

						arg_52_1:RecordAudio("304071013", var_55_9)
						arg_52_1:RecordAudio("304071013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304071", "304071013", "story_v_out_304071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304071", "304071013", "story_v_out_304071.awb")
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
	Play304071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304071014
		arg_56_1.duration_ = 4.7

		local var_56_0 = {
			zh = 4.166,
			ja = 4.7
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
				arg_56_0:Play304071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1019ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_9.localPosition
			end

			local var_59_11 = 0.001

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11
				local var_59_13 = Vector3.New(0, 100, 0)

				var_59_9.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_13, var_59_12)

				local var_59_14 = manager.ui.mainCamera.transform.position - var_59_9.position

				var_59_9.forward = Vector3.New(var_59_14.x, var_59_14.y, var_59_14.z)

				local var_59_15 = var_59_9.localEulerAngles

				var_59_15.z = 0
				var_59_15.x = 0
				var_59_9.localEulerAngles = var_59_15
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 then
				var_59_9.localPosition = Vector3.New(0, 100, 0)

				local var_59_16 = manager.ui.mainCamera.transform.position - var_59_9.position

				var_59_9.forward = Vector3.New(var_59_16.x, var_59_16.y, var_59_16.z)

				local var_59_17 = var_59_9.localEulerAngles

				var_59_17.z = 0
				var_59_17.x = 0
				var_59_9.localEulerAngles = var_59_17
			end

			local var_59_18 = arg_56_1.actors_["1011ui_story"].transform
			local var_59_19 = 0

			if var_59_19 < arg_56_1.time_ and arg_56_1.time_ <= var_59_19 + arg_59_0 then
				arg_56_1.var_.moveOldPos1011ui_story = var_59_18.localPosition
			end

			local var_59_20 = 0.001

			if var_59_19 <= arg_56_1.time_ and arg_56_1.time_ < var_59_19 + var_59_20 then
				local var_59_21 = (arg_56_1.time_ - var_59_19) / var_59_20
				local var_59_22 = Vector3.New(0, 100, 0)

				var_59_18.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1011ui_story, var_59_22, var_59_21)

				local var_59_23 = manager.ui.mainCamera.transform.position - var_59_18.position

				var_59_18.forward = Vector3.New(var_59_23.x, var_59_23.y, var_59_23.z)

				local var_59_24 = var_59_18.localEulerAngles

				var_59_24.z = 0
				var_59_24.x = 0
				var_59_18.localEulerAngles = var_59_24
			end

			if arg_56_1.time_ >= var_59_19 + var_59_20 and arg_56_1.time_ < var_59_19 + var_59_20 + arg_59_0 then
				var_59_18.localPosition = Vector3.New(0, 100, 0)

				local var_59_25 = manager.ui.mainCamera.transform.position - var_59_18.position

				var_59_18.forward = Vector3.New(var_59_25.x, var_59_25.y, var_59_25.z)

				local var_59_26 = var_59_18.localEulerAngles

				var_59_26.z = 0
				var_59_26.x = 0
				var_59_18.localEulerAngles = var_59_26
			end

			local var_59_27 = arg_56_1.actors_["1019ui_story"]
			local var_59_28 = 0

			if var_59_28 < arg_56_1.time_ and arg_56_1.time_ <= var_59_28 + arg_59_0 and not isNil(var_59_27) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_29 = 0.200000002980232

			if var_59_28 <= arg_56_1.time_ and arg_56_1.time_ < var_59_28 + var_59_29 and not isNil(var_59_27) then
				local var_59_30 = (arg_56_1.time_ - var_59_28) / var_59_29

				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_27) then
					arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_28 + var_59_29 and arg_56_1.time_ < var_59_28 + var_59_29 + arg_59_0 and not isNil(var_59_27) and arg_56_1.var_.characterEffect1019ui_story then
				arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_59_31 = arg_56_1.actors_["1011ui_story"]
			local var_59_32 = 0

			if var_59_32 < arg_56_1.time_ and arg_56_1.time_ <= var_59_32 + arg_59_0 and not isNil(var_59_31) and arg_56_1.var_.characterEffect1011ui_story == nil then
				arg_56_1.var_.characterEffect1011ui_story = var_59_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_33 = 0.200000002980232

			if var_59_32 <= arg_56_1.time_ and arg_56_1.time_ < var_59_32 + var_59_33 and not isNil(var_59_31) then
				local var_59_34 = (arg_56_1.time_ - var_59_32) / var_59_33

				if arg_56_1.var_.characterEffect1011ui_story and not isNil(var_59_31) then
					local var_59_35 = Mathf.Lerp(0, 0.5, var_59_34)

					arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1011ui_story.fillRatio = var_59_35
				end
			end

			if arg_56_1.time_ >= var_59_32 + var_59_33 and arg_56_1.time_ < var_59_32 + var_59_33 + arg_59_0 and not isNil(var_59_31) and arg_56_1.var_.characterEffect1011ui_story then
				local var_59_36 = 0.5

				arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1011ui_story.fillRatio = var_59_36
			end

			local var_59_37 = 0

			if var_59_37 < arg_56_1.time_ and arg_56_1.time_ <= var_59_37 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_59_38 = 0

			if var_59_38 < arg_56_1.time_ and arg_56_1.time_ <= var_59_38 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_59_39 = 0
			local var_59_40 = 0.3

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_41 = arg_56_1:FormatText(StoryNameCfg[13].name)

				arg_56_1.leftNameTxt_.text = var_59_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_42 = arg_56_1:GetWordFromCfg(304071014)
				local var_59_43 = arg_56_1:FormatText(var_59_42.content)

				arg_56_1.text_.text = var_59_43

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_44 = 12
				local var_59_45 = utf8.len(var_59_43)
				local var_59_46 = var_59_44 <= 0 and var_59_40 or var_59_40 * (var_59_45 / var_59_44)

				if var_59_46 > 0 and var_59_40 < var_59_46 then
					arg_56_1.talkMaxDuration = var_59_46

					if var_59_46 + var_59_39 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_46 + var_59_39
					end
				end

				arg_56_1.text_.text = var_59_43
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071014", "story_v_out_304071.awb") ~= 0 then
					local var_59_47 = manager.audio:GetVoiceLength("story_v_out_304071", "304071014", "story_v_out_304071.awb") / 1000

					if var_59_47 + var_59_39 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_47 + var_59_39
					end

					if var_59_42.prefab_name ~= "" and arg_56_1.actors_[var_59_42.prefab_name] ~= nil then
						local var_59_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_42.prefab_name].transform, "story_v_out_304071", "304071014", "story_v_out_304071.awb")

						arg_56_1:RecordAudio("304071014", var_59_48)
						arg_56_1:RecordAudio("304071014", var_59_48)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304071", "304071014", "story_v_out_304071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304071", "304071014", "story_v_out_304071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_49 = math.max(var_59_40, arg_56_1.talkMaxDuration)

			if var_59_39 <= arg_56_1.time_ and arg_56_1.time_ < var_59_39 + var_59_49 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_39) / var_59_49

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_39 + var_59_49 and arg_56_1.time_ < var_59_39 + var_59_49 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play304071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304071015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play304071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1019ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, var_63_4, var_63_3)

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

			local var_63_9 = arg_60_1.actors_["1019ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_9) then
					local var_63_13 = Mathf.Lerp(0, 0.5, var_63_12)

					arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1019ui_story.fillRatio = var_63_13
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1019ui_story then
				local var_63_14 = 0.5

				arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1019ui_story.fillRatio = var_63_14
			end

			local var_63_15 = 0
			local var_63_16 = 1.4

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_17 = arg_60_1:GetWordFromCfg(304071015)
				local var_63_18 = arg_60_1:FormatText(var_63_17.content)

				arg_60_1.text_.text = var_63_18

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_19 = 56
				local var_63_20 = utf8.len(var_63_18)
				local var_63_21 = var_63_19 <= 0 and var_63_16 or var_63_16 * (var_63_20 / var_63_19)

				if var_63_21 > 0 and var_63_16 < var_63_21 then
					arg_60_1.talkMaxDuration = var_63_21

					if var_63_21 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_18
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_22 and arg_60_1.time_ < var_63_15 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play304071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304071016
		arg_64_1.duration_ = 5.8

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_1 = 1

			if arg_64_1.time_ >= var_67_0 + var_67_1 and arg_64_1.time_ < var_67_0 + var_67_1 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_2 = manager.ui.mainCamera.transform
			local var_67_3 = 0.366666666666667

			if var_67_3 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				local var_67_4 = arg_64_1.var_.effectuuuu
				local var_67_5
				local var_67_6 = var_67_2

				if not var_67_4 then
					var_67_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_67_6)
					var_67_4.name = "uuuu"
					arg_64_1.var_.effectuuuu = var_67_4
				else
					var_67_4.transform:SetParent(var_67_6)
				end

				var_67_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_67_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_67_7 = 1.7777777777777777
				local var_67_8 = Screen.width / Screen.height
				local var_67_9 = var_67_8 / var_67_7
				local var_67_10 = Mathf.Max(var_67_7 / var_67_8, 1)

				var_67_4.transform.localScale = Vector3.New(var_67_4.transform.localScale.x * var_67_9, var_67_4.transform.localScale.y * var_67_10, var_67_4.transform.localScale.z)
			end

			local var_67_11 = manager.ui.mainCamera.transform
			local var_67_12 = 1.83333332737287

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				local var_67_13 = arg_64_1.var_.effectuuuu

				if var_67_13 then
					Object.Destroy(var_67_13)

					arg_64_1.var_.effectuuuu = nil
				end
			end

			local var_67_14 = 0.9
			local var_67_15 = 1

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				local var_67_16 = "play"
				local var_67_17 = "effect"

				arg_64_1:AudioAction(var_67_16, var_67_17, "se_story_127", "se_story_127_hit", "")
			end

			local var_67_18 = 0.8
			local var_67_19 = 1

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				local var_67_20 = "play"
				local var_67_21 = "effect"

				arg_64_1:AudioAction(var_67_20, var_67_21, "se_story_122_03", "se_story_122_03_hit", "")
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_22 = 0.799999997019768
			local var_67_23 = 1.125

			if var_67_22 < arg_64_1.time_ and arg_64_1.time_ <= var_67_22 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_24 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_24:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_25 = arg_64_1:GetWordFromCfg(304071016)
				local var_67_26 = arg_64_1:FormatText(var_67_25.content)

				arg_64_1.text_.text = var_67_26

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_27 = 44
				local var_67_28 = utf8.len(var_67_26)
				local var_67_29 = var_67_27 <= 0 and var_67_23 or var_67_23 * (var_67_28 / var_67_27)

				if var_67_29 > 0 and var_67_23 < var_67_29 then
					arg_64_1.talkMaxDuration = var_67_29
					var_67_22 = var_67_22 + 0.3

					if var_67_29 + var_67_22 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_29 + var_67_22
					end
				end

				arg_64_1.text_.text = var_67_26
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_30 = var_67_22 + 0.3
			local var_67_31 = math.max(var_67_23, arg_64_1.talkMaxDuration)

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_31 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_30) / var_67_31

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_30 + var_67_31 and arg_64_1.time_ < var_67_30 + var_67_31 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1,
				amplitudeGain = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play304071017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304071017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play304071018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.725

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(304071017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 69
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play304071018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304071018
		arg_74_1.duration_ = 3.47

		local var_74_0 = {
			zh = 3.466,
			ja = 3.1
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
				arg_74_0:Play304071019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "1013ui_story"

			if arg_74_1.actors_[var_77_0] == nil then
				local var_77_1 = Asset.Load("Char/" .. "1013ui_story")

				if not isNil(var_77_1) then
					local var_77_2 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_74_1.stage_.transform)

					var_77_2.name = var_77_0
					var_77_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_74_1.actors_[var_77_0] = var_77_2

					local var_77_3 = var_77_2:GetComponentInChildren(typeof(CharacterEffect))

					var_77_3.enabled = true

					local var_77_4 = GameObjectTools.GetOrAddComponent(var_77_2, typeof(DynamicBoneHelper))

					if var_77_4 then
						var_77_4:EnableDynamicBone(false)
					end

					arg_74_1:ShowWeapon(var_77_3.transform, false)

					arg_74_1.var_[var_77_0 .. "Animator"] = var_77_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_74_1.var_[var_77_0 .. "Animator"].applyRootMotion = true
					arg_74_1.var_[var_77_0 .. "LipSync"] = var_77_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_77_5 = arg_74_1.actors_["1013ui_story"]
			local var_77_6 = 0

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 and not isNil(var_77_5) and arg_74_1.var_.characterEffect1013ui_story == nil then
				arg_74_1.var_.characterEffect1013ui_story = var_77_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_7 = 0.200000002980232

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_7 and not isNil(var_77_5) then
				local var_77_8 = (arg_74_1.time_ - var_77_6) / var_77_7

				if arg_74_1.var_.characterEffect1013ui_story and not isNil(var_77_5) then
					arg_74_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_6 + var_77_7 and arg_74_1.time_ < var_77_6 + var_77_7 + arg_77_0 and not isNil(var_77_5) and arg_74_1.var_.characterEffect1013ui_story then
				arg_74_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_77_9 = 0
			local var_77_10 = 0.225

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_11 = arg_74_1:FormatText(StoryNameCfg[36].name)

				arg_74_1.leftNameTxt_.text = var_77_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_12 = arg_74_1:GetWordFromCfg(304071018)
				local var_77_13 = arg_74_1:FormatText(var_77_12.content)

				arg_74_1.text_.text = var_77_13

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_14 = 9
				local var_77_15 = utf8.len(var_77_13)
				local var_77_16 = var_77_14 <= 0 and var_77_10 or var_77_10 * (var_77_15 / var_77_14)

				if var_77_16 > 0 and var_77_10 < var_77_16 then
					arg_74_1.talkMaxDuration = var_77_16

					if var_77_16 + var_77_9 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_16 + var_77_9
					end
				end

				arg_74_1.text_.text = var_77_13
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071018", "story_v_out_304071.awb") ~= 0 then
					local var_77_17 = manager.audio:GetVoiceLength("story_v_out_304071", "304071018", "story_v_out_304071.awb") / 1000

					if var_77_17 + var_77_9 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_17 + var_77_9
					end

					if var_77_12.prefab_name ~= "" and arg_74_1.actors_[var_77_12.prefab_name] ~= nil then
						local var_77_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_12.prefab_name].transform, "story_v_out_304071", "304071018", "story_v_out_304071.awb")

						arg_74_1:RecordAudio("304071018", var_77_18)
						arg_74_1:RecordAudio("304071018", var_77_18)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_304071", "304071018", "story_v_out_304071.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_304071", "304071018", "story_v_out_304071.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_19 = math.max(var_77_10, arg_74_1.talkMaxDuration)

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_19 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_9) / var_77_19

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_9 + var_77_19 and arg_74_1.time_ < var_77_9 + var_77_19 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304071019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 304071019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play304071020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1013ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1013ui_story == nil then
				arg_78_1.var_.characterEffect1013ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1013ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1013ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1013ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1013ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 1.375

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(304071019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 55
				local var_81_11 = utf8.len(var_81_9)
				local var_81_12 = var_81_10 <= 0 and var_81_7 or var_81_7 * (var_81_11 / var_81_10)

				if var_81_12 > 0 and var_81_7 < var_81_12 then
					arg_78_1.talkMaxDuration = var_81_12

					if var_81_12 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_13 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_13 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_13

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_13 and arg_78_1.time_ < var_81_6 + var_81_13 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play304071020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 304071020
		arg_82_1.duration_ = 5.67

		local var_82_0 = {
			zh = 5.666,
			ja = 1.999999999999
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
				arg_82_0:Play304071021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1084ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1084ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(-0.7, -0.97, -6)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1084ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["1084ui_story"]
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1084ui_story == nil then
				arg_82_1.var_.characterEffect1084ui_story = var_85_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.200000002980232

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 and not isNil(var_85_9) then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11

				if arg_82_1.var_.characterEffect1084ui_story and not isNil(var_85_9) then
					arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1084ui_story then
				arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_85_13 = 0

			if var_85_13 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action475")
			end

			local var_85_14 = 0
			local var_85_15 = 0.7

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_16 = arg_82_1:FormatText(StoryNameCfg[6].name)

				arg_82_1.leftNameTxt_.text = var_85_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_17 = arg_82_1:GetWordFromCfg(304071020)
				local var_85_18 = arg_82_1:FormatText(var_85_17.content)

				arg_82_1.text_.text = var_85_18

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_19 = 28
				local var_85_20 = utf8.len(var_85_18)
				local var_85_21 = var_85_19 <= 0 and var_85_15 or var_85_15 * (var_85_20 / var_85_19)

				if var_85_21 > 0 and var_85_15 < var_85_21 then
					arg_82_1.talkMaxDuration = var_85_21

					if var_85_21 + var_85_14 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_21 + var_85_14
					end
				end

				arg_82_1.text_.text = var_85_18
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071020", "story_v_out_304071.awb") ~= 0 then
					local var_85_22 = manager.audio:GetVoiceLength("story_v_out_304071", "304071020", "story_v_out_304071.awb") / 1000

					if var_85_22 + var_85_14 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_14
					end

					if var_85_17.prefab_name ~= "" and arg_82_1.actors_[var_85_17.prefab_name] ~= nil then
						local var_85_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_17.prefab_name].transform, "story_v_out_304071", "304071020", "story_v_out_304071.awb")

						arg_82_1:RecordAudio("304071020", var_85_23)
						arg_82_1:RecordAudio("304071020", var_85_23)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_304071", "304071020", "story_v_out_304071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_304071", "304071020", "story_v_out_304071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_24 = math.max(var_85_15, arg_82_1.talkMaxDuration)

			if var_85_14 <= arg_82_1.time_ and arg_82_1.time_ < var_85_14 + var_85_24 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_14) / var_85_24

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_14 + var_85_24 and arg_82_1.time_ < var_85_14 + var_85_24 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play304071021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 304071021
		arg_86_1.duration_ = 12.03

		local var_86_0 = {
			zh = 6.433,
			ja = 12.033
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
				arg_86_0:Play304071022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1013ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1013ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0.7, -0.66, -6.15)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1013ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1013ui_story"]
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1013ui_story == nil then
				arg_86_1.var_.characterEffect1013ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.200000002980232

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 and not isNil(var_89_9) then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11

				if arg_86_1.var_.characterEffect1013ui_story and not isNil(var_89_9) then
					arg_86_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1013ui_story then
				arg_86_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_89_13 = arg_86_1.actors_["1084ui_story"]
			local var_89_14 = 0

			if var_89_14 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 and not isNil(var_89_13) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_15 = 0.200000002980232

			if var_89_14 <= arg_86_1.time_ and arg_86_1.time_ < var_89_14 + var_89_15 and not isNil(var_89_13) then
				local var_89_16 = (arg_86_1.time_ - var_89_14) / var_89_15

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_13) then
					local var_89_17 = Mathf.Lerp(0, 0.5, var_89_16)

					arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_17
				end
			end

			if arg_86_1.time_ >= var_89_14 + var_89_15 and arg_86_1.time_ < var_89_14 + var_89_15 + arg_89_0 and not isNil(var_89_13) and arg_86_1.var_.characterEffect1084ui_story then
				local var_89_18 = 0.5

				arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_18
			end

			local var_89_19 = 0

			if var_89_19 < arg_86_1.time_ and arg_86_1.time_ <= var_89_19 + arg_89_0 then
				arg_86_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action3_1")
			end

			local var_89_20 = 0

			if var_89_20 < arg_86_1.time_ and arg_86_1.time_ <= var_89_20 + arg_89_0 then
				arg_86_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_21 = 0
			local var_89_22 = 0.725

			if var_89_21 < arg_86_1.time_ and arg_86_1.time_ <= var_89_21 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_23 = arg_86_1:FormatText(StoryNameCfg[36].name)

				arg_86_1.leftNameTxt_.text = var_89_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_24 = arg_86_1:GetWordFromCfg(304071021)
				local var_89_25 = arg_86_1:FormatText(var_89_24.content)

				arg_86_1.text_.text = var_89_25

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_26 = 29
				local var_89_27 = utf8.len(var_89_25)
				local var_89_28 = var_89_26 <= 0 and var_89_22 or var_89_22 * (var_89_27 / var_89_26)

				if var_89_28 > 0 and var_89_22 < var_89_28 then
					arg_86_1.talkMaxDuration = var_89_28

					if var_89_28 + var_89_21 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_28 + var_89_21
					end
				end

				arg_86_1.text_.text = var_89_25
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071021", "story_v_out_304071.awb") ~= 0 then
					local var_89_29 = manager.audio:GetVoiceLength("story_v_out_304071", "304071021", "story_v_out_304071.awb") / 1000

					if var_89_29 + var_89_21 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_29 + var_89_21
					end

					if var_89_24.prefab_name ~= "" and arg_86_1.actors_[var_89_24.prefab_name] ~= nil then
						local var_89_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_24.prefab_name].transform, "story_v_out_304071", "304071021", "story_v_out_304071.awb")

						arg_86_1:RecordAudio("304071021", var_89_30)
						arg_86_1:RecordAudio("304071021", var_89_30)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_304071", "304071021", "story_v_out_304071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_304071", "304071021", "story_v_out_304071.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_31 = math.max(var_89_22, arg_86_1.talkMaxDuration)

			if var_89_21 <= arg_86_1.time_ and arg_86_1.time_ < var_89_21 + var_89_31 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_21) / var_89_31

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_21 + var_89_31 and arg_86_1.time_ < var_89_21 + var_89_31 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play304071022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304071022
		arg_90_1.duration_ = 5.87

		local var_90_0 = {
			zh = 5.866,
			ja = 1.999999999999
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
				arg_90_0:Play304071023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1084ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["1013ui_story"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1013ui_story == nil then
				arg_90_1.var_.characterEffect1013ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect1013ui_story and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1013ui_story.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1013ui_story then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1013ui_story.fillRatio = var_93_9
			end

			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_93_11 = 0

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_12 = 0
			local var_93_13 = 0.7

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_14 = arg_90_1:FormatText(StoryNameCfg[6].name)

				arg_90_1.leftNameTxt_.text = var_93_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_15 = arg_90_1:GetWordFromCfg(304071022)
				local var_93_16 = arg_90_1:FormatText(var_93_15.content)

				arg_90_1.text_.text = var_93_16

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 28
				local var_93_18 = utf8.len(var_93_16)
				local var_93_19 = var_93_17 <= 0 and var_93_13 or var_93_13 * (var_93_18 / var_93_17)

				if var_93_19 > 0 and var_93_13 < var_93_19 then
					arg_90_1.talkMaxDuration = var_93_19

					if var_93_19 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_12
					end
				end

				arg_90_1.text_.text = var_93_16
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071022", "story_v_out_304071.awb") ~= 0 then
					local var_93_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071022", "story_v_out_304071.awb") / 1000

					if var_93_20 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_20 + var_93_12
					end

					if var_93_15.prefab_name ~= "" and arg_90_1.actors_[var_93_15.prefab_name] ~= nil then
						local var_93_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_15.prefab_name].transform, "story_v_out_304071", "304071022", "story_v_out_304071.awb")

						arg_90_1:RecordAudio("304071022", var_93_21)
						arg_90_1:RecordAudio("304071022", var_93_21)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_304071", "304071022", "story_v_out_304071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_304071", "304071022", "story_v_out_304071.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_13, arg_90_1.talkMaxDuration)

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_12) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_12 + var_93_22 and arg_90_1.time_ < var_93_12 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304071023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 304071023
		arg_94_1.duration_ = 8.1

		local var_94_0 = {
			zh = 6.2,
			ja = 8.1
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
				arg_94_0:Play304071024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1013ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1013ui_story == nil then
				arg_94_1.var_.characterEffect1013ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1013ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1013ui_story then
				arg_94_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["1084ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.200000002980232

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1084ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1084ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1084ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action432")
			end

			local var_97_11 = 0
			local var_97_12 = 0.75

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_13 = arg_94_1:FormatText(StoryNameCfg[36].name)

				arg_94_1.leftNameTxt_.text = var_97_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_14 = arg_94_1:GetWordFromCfg(304071023)
				local var_97_15 = arg_94_1:FormatText(var_97_14.content)

				arg_94_1.text_.text = var_97_15

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_16 = 30
				local var_97_17 = utf8.len(var_97_15)
				local var_97_18 = var_97_16 <= 0 and var_97_12 or var_97_12 * (var_97_17 / var_97_16)

				if var_97_18 > 0 and var_97_12 < var_97_18 then
					arg_94_1.talkMaxDuration = var_97_18

					if var_97_18 + var_97_11 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_18 + var_97_11
					end
				end

				arg_94_1.text_.text = var_97_15
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071023", "story_v_out_304071.awb") ~= 0 then
					local var_97_19 = manager.audio:GetVoiceLength("story_v_out_304071", "304071023", "story_v_out_304071.awb") / 1000

					if var_97_19 + var_97_11 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_19 + var_97_11
					end

					if var_97_14.prefab_name ~= "" and arg_94_1.actors_[var_97_14.prefab_name] ~= nil then
						local var_97_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_14.prefab_name].transform, "story_v_out_304071", "304071023", "story_v_out_304071.awb")

						arg_94_1:RecordAudio("304071023", var_97_20)
						arg_94_1:RecordAudio("304071023", var_97_20)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_304071", "304071023", "story_v_out_304071.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_304071", "304071023", "story_v_out_304071.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_21 = math.max(var_97_12, arg_94_1.talkMaxDuration)

			if var_97_11 <= arg_94_1.time_ and arg_94_1.time_ < var_97_11 + var_97_21 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_11) / var_97_21

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_11 + var_97_21 and arg_94_1.time_ < var_97_11 + var_97_21 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play304071024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 304071024
		arg_98_1.duration_ = 5.13

		local var_98_0 = {
			zh = 5,
			ja = 5.133
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
				arg_98_0:Play304071025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action424")
			end

			local var_101_1 = 0
			local var_101_2 = 0.6

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_3 = arg_98_1:FormatText(StoryNameCfg[36].name)

				arg_98_1.leftNameTxt_.text = var_101_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_4 = arg_98_1:GetWordFromCfg(304071024)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071024", "story_v_out_304071.awb") ~= 0 then
					local var_101_9 = manager.audio:GetVoiceLength("story_v_out_304071", "304071024", "story_v_out_304071.awb") / 1000

					if var_101_9 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_1
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_out_304071", "304071024", "story_v_out_304071.awb")

						arg_98_1:RecordAudio("304071024", var_101_10)
						arg_98_1:RecordAudio("304071024", var_101_10)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_304071", "304071024", "story_v_out_304071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_304071", "304071024", "story_v_out_304071.awb")
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
	Play304071025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 304071025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play304071026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1013ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1013ui_story == nil then
				arg_102_1.var_.characterEffect1013ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1013ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1013ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1013ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1013ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 0.9

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_8 = arg_102_1:GetWordFromCfg(304071025)
				local var_105_9 = arg_102_1:FormatText(var_105_8.content)

				arg_102_1.text_.text = var_105_9

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_10 = 36
				local var_105_11 = utf8.len(var_105_9)
				local var_105_12 = var_105_10 <= 0 and var_105_7 or var_105_7 * (var_105_11 / var_105_10)

				if var_105_12 > 0 and var_105_7 < var_105_12 then
					arg_102_1.talkMaxDuration = var_105_12

					if var_105_12 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_9
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_13 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_13 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_13

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_13 and arg_102_1.time_ < var_105_6 + var_105_13 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play304071026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 304071026
		arg_106_1.duration_ = 5.13

		local var_106_0 = {
			zh = 5.133,
			ja = 1.999999999999
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
				arg_106_0:Play304071027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1084ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1084ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_109_4 = 0

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_6 = 0
			local var_109_7 = 0.6

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[6].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_9 = arg_106_1:GetWordFromCfg(304071026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 24
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071026", "story_v_out_304071.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_304071", "304071026", "story_v_out_304071.awb") / 1000

					if var_109_14 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_6
					end

					if var_109_9.prefab_name ~= "" and arg_106_1.actors_[var_109_9.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_9.prefab_name].transform, "story_v_out_304071", "304071026", "story_v_out_304071.awb")

						arg_106_1:RecordAudio("304071026", var_109_15)
						arg_106_1:RecordAudio("304071026", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_304071", "304071026", "story_v_out_304071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_304071", "304071026", "story_v_out_304071.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_16 and arg_106_1.time_ < var_109_6 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play304071027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 304071027
		arg_110_1.duration_ = 4.63

		local var_110_0 = {
			zh = 4.633,
			ja = 3.033
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
				arg_110_0:Play304071028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1013ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1013ui_story == nil then
				arg_110_1.var_.characterEffect1013ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1013ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1013ui_story then
				arg_110_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1084ui_story"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1084ui_story == nil then
				arg_110_1.var_.characterEffect1084ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.200000002980232

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.characterEffect1084ui_story and not isNil(var_113_4) then
					local var_113_8 = Mathf.Lerp(0, 0.5, var_113_7)

					arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1084ui_story.fillRatio = var_113_8
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1084ui_story then
				local var_113_9 = 0.5

				arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1084ui_story.fillRatio = var_113_9
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action4_2")
			end

			local var_113_11 = 0

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_113_12 = 0
			local var_113_13 = 0.475

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_14 = arg_110_1:FormatText(StoryNameCfg[36].name)

				arg_110_1.leftNameTxt_.text = var_113_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_15 = arg_110_1:GetWordFromCfg(304071027)
				local var_113_16 = arg_110_1:FormatText(var_113_15.content)

				arg_110_1.text_.text = var_113_16

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071027", "story_v_out_304071.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071027", "story_v_out_304071.awb") / 1000

					if var_113_20 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_12
					end

					if var_113_15.prefab_name ~= "" and arg_110_1.actors_[var_113_15.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_15.prefab_name].transform, "story_v_out_304071", "304071027", "story_v_out_304071.awb")

						arg_110_1:RecordAudio("304071027", var_113_21)
						arg_110_1:RecordAudio("304071027", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_304071", "304071027", "story_v_out_304071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_304071", "304071027", "story_v_out_304071.awb")
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
	Play304071028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 304071028
		arg_114_1.duration_ = 3.3

		local var_114_0 = {
			zh = 3.3,
			ja = 1.999999999999
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
				arg_114_0:Play304071029(arg_114_1)
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

			local var_117_4 = arg_114_1.actors_["1013ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1013ui_story == nil then
				arg_114_1.var_.characterEffect1013ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1013ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1013ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1013ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1013ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action447")
			end

			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_117_12 = 0
			local var_117_13 = 0.375

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_14 = arg_114_1:FormatText(StoryNameCfg[6].name)

				arg_114_1.leftNameTxt_.text = var_117_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:GetWordFromCfg(304071028)
				local var_117_16 = arg_114_1:FormatText(var_117_15.content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 15
				local var_117_18 = utf8.len(var_117_16)
				local var_117_19 = var_117_17 <= 0 and var_117_13 or var_117_13 * (var_117_18 / var_117_17)

				if var_117_19 > 0 and var_117_13 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071028", "story_v_out_304071.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071028", "story_v_out_304071.awb") / 1000

					if var_117_20 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_12
					end

					if var_117_15.prefab_name ~= "" and arg_114_1.actors_[var_117_15.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_15.prefab_name].transform, "story_v_out_304071", "304071028", "story_v_out_304071.awb")

						arg_114_1:RecordAudio("304071028", var_117_21)
						arg_114_1:RecordAudio("304071028", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_304071", "304071028", "story_v_out_304071.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_304071", "304071028", "story_v_out_304071.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_22 and arg_114_1.time_ < var_117_12 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play304071029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 304071029
		arg_118_1.duration_ = 13.5

		local var_118_0 = {
			zh = 8.633,
			ja = 13.5
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
				arg_118_0:Play304071030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1011ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1011ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(-0.7, -0.71, -6)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1011ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["1084ui_story"].transform
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_9.localPosition
			end

			local var_121_11 = 0.001

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11
				local var_121_13 = Vector3.New(0, 100, 0)

				var_121_9.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, var_121_13, var_121_12)

				local var_121_14 = manager.ui.mainCamera.transform.position - var_121_9.position

				var_121_9.forward = Vector3.New(var_121_14.x, var_121_14.y, var_121_14.z)

				local var_121_15 = var_121_9.localEulerAngles

				var_121_15.z = 0
				var_121_15.x = 0
				var_121_9.localEulerAngles = var_121_15
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 then
				var_121_9.localPosition = Vector3.New(0, 100, 0)

				local var_121_16 = manager.ui.mainCamera.transform.position - var_121_9.position

				var_121_9.forward = Vector3.New(var_121_16.x, var_121_16.y, var_121_16.z)

				local var_121_17 = var_121_9.localEulerAngles

				var_121_17.z = 0
				var_121_17.x = 0
				var_121_9.localEulerAngles = var_121_17
			end

			local var_121_18 = arg_118_1.actors_["1011ui_story"]
			local var_121_19 = 0

			if var_121_19 < arg_118_1.time_ and arg_118_1.time_ <= var_121_19 + arg_121_0 and not isNil(var_121_18) and arg_118_1.var_.characterEffect1011ui_story == nil then
				arg_118_1.var_.characterEffect1011ui_story = var_121_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_20 = 0.200000002980232

			if var_121_19 <= arg_118_1.time_ and arg_118_1.time_ < var_121_19 + var_121_20 and not isNil(var_121_18) then
				local var_121_21 = (arg_118_1.time_ - var_121_19) / var_121_20

				if arg_118_1.var_.characterEffect1011ui_story and not isNil(var_121_18) then
					arg_118_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_19 + var_121_20 and arg_118_1.time_ < var_121_19 + var_121_20 + arg_121_0 and not isNil(var_121_18) and arg_118_1.var_.characterEffect1011ui_story then
				arg_118_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_121_22 = arg_118_1.actors_["1084ui_story"]
			local var_121_23 = 0

			if var_121_23 < arg_118_1.time_ and arg_118_1.time_ <= var_121_23 + arg_121_0 and not isNil(var_121_22) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_24 = 0.200000002980232

			if var_121_23 <= arg_118_1.time_ and arg_118_1.time_ < var_121_23 + var_121_24 and not isNil(var_121_22) then
				local var_121_25 = (arg_118_1.time_ - var_121_23) / var_121_24

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_22) then
					local var_121_26 = Mathf.Lerp(0, 0.5, var_121_25)

					arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_26
				end
			end

			if arg_118_1.time_ >= var_121_23 + var_121_24 and arg_118_1.time_ < var_121_23 + var_121_24 + arg_121_0 and not isNil(var_121_22) and arg_118_1.var_.characterEffect1084ui_story then
				local var_121_27 = 0.5

				arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_27
			end

			local var_121_28 = 0

			if var_121_28 < arg_118_1.time_ and arg_118_1.time_ <= var_121_28 + arg_121_0 then
				arg_118_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_121_29 = 0

			if var_121_29 < arg_118_1.time_ and arg_118_1.time_ <= var_121_29 + arg_121_0 then
				arg_118_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_121_30 = 0
			local var_121_31 = 0.875

			if var_121_30 < arg_118_1.time_ and arg_118_1.time_ <= var_121_30 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_32 = arg_118_1:FormatText(StoryNameCfg[37].name)

				arg_118_1.leftNameTxt_.text = var_121_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_33 = arg_118_1:GetWordFromCfg(304071029)
				local var_121_34 = arg_118_1:FormatText(var_121_33.content)

				arg_118_1.text_.text = var_121_34

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_35 = 35
				local var_121_36 = utf8.len(var_121_34)
				local var_121_37 = var_121_35 <= 0 and var_121_31 or var_121_31 * (var_121_36 / var_121_35)

				if var_121_37 > 0 and var_121_31 < var_121_37 then
					arg_118_1.talkMaxDuration = var_121_37

					if var_121_37 + var_121_30 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_37 + var_121_30
					end
				end

				arg_118_1.text_.text = var_121_34
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071029", "story_v_out_304071.awb") ~= 0 then
					local var_121_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071029", "story_v_out_304071.awb") / 1000

					if var_121_38 + var_121_30 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_38 + var_121_30
					end

					if var_121_33.prefab_name ~= "" and arg_118_1.actors_[var_121_33.prefab_name] ~= nil then
						local var_121_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_33.prefab_name].transform, "story_v_out_304071", "304071029", "story_v_out_304071.awb")

						arg_118_1:RecordAudio("304071029", var_121_39)
						arg_118_1:RecordAudio("304071029", var_121_39)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_304071", "304071029", "story_v_out_304071.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_304071", "304071029", "story_v_out_304071.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_40 = math.max(var_121_31, arg_118_1.talkMaxDuration)

			if var_121_30 <= arg_118_1.time_ and arg_118_1.time_ < var_121_30 + var_121_40 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_30) / var_121_40

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_30 + var_121_40 and arg_118_1.time_ < var_121_30 + var_121_40 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play304071030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 304071030
		arg_122_1.duration_ = 3.33

		local var_122_0 = {
			zh = 1.999999999999,
			ja = 3.333
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play304071031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1013ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1013ui_story == nil then
				arg_122_1.var_.characterEffect1013ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1013ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1013ui_story then
				arg_122_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["1011ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1011ui_story == nil then
				arg_122_1.var_.characterEffect1011ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.200000002980232

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect1011ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1011ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1011ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1011ui_story.fillRatio = var_125_9
			end

			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action7_1")
			end

			local var_125_11 = 0

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_125_12 = 0
			local var_125_13 = 0.175

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_14 = arg_122_1:FormatText(StoryNameCfg[36].name)

				arg_122_1.leftNameTxt_.text = var_125_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_15 = arg_122_1:GetWordFromCfg(304071030)
				local var_125_16 = arg_122_1:FormatText(var_125_15.content)

				arg_122_1.text_.text = var_125_16

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_17 = 7
				local var_125_18 = utf8.len(var_125_16)
				local var_125_19 = var_125_17 <= 0 and var_125_13 or var_125_13 * (var_125_18 / var_125_17)

				if var_125_19 > 0 and var_125_13 < var_125_19 then
					arg_122_1.talkMaxDuration = var_125_19

					if var_125_19 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_12
					end
				end

				arg_122_1.text_.text = var_125_16
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071030", "story_v_out_304071.awb") ~= 0 then
					local var_125_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071030", "story_v_out_304071.awb") / 1000

					if var_125_20 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_20 + var_125_12
					end

					if var_125_15.prefab_name ~= "" and arg_122_1.actors_[var_125_15.prefab_name] ~= nil then
						local var_125_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_15.prefab_name].transform, "story_v_out_304071", "304071030", "story_v_out_304071.awb")

						arg_122_1:RecordAudio("304071030", var_125_21)
						arg_122_1:RecordAudio("304071030", var_125_21)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_304071", "304071030", "story_v_out_304071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_304071", "304071030", "story_v_out_304071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_22 = math.max(var_125_13, arg_122_1.talkMaxDuration)

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_22 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_12) / var_125_22

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_12 + var_125_22 and arg_122_1.time_ < var_125_12 + var_125_22 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play304071031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 304071031
		arg_126_1.duration_ = 3.03

		local var_126_0 = {
			zh = 2.5,
			ja = 3.033
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play304071032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1011ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1011ui_story == nil then
				arg_126_1.var_.characterEffect1011ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1011ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1011ui_story then
				arg_126_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["1013ui_story"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1013ui_story == nil then
				arg_126_1.var_.characterEffect1013ui_story = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.200000002980232

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.characterEffect1013ui_story and not isNil(var_129_4) then
					local var_129_8 = Mathf.Lerp(0, 0.5, var_129_7)

					arg_126_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1013ui_story.fillRatio = var_129_8
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1013ui_story then
				local var_129_9 = 0.5

				arg_126_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1013ui_story.fillRatio = var_129_9
			end

			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action428")
			end

			local var_129_11 = 0

			if var_129_11 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_12 = 0
			local var_129_13 = 0.2

			if var_129_12 < arg_126_1.time_ and arg_126_1.time_ <= var_129_12 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_14 = arg_126_1:FormatText(StoryNameCfg[37].name)

				arg_126_1.leftNameTxt_.text = var_129_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_15 = arg_126_1:GetWordFromCfg(304071031)
				local var_129_16 = arg_126_1:FormatText(var_129_15.content)

				arg_126_1.text_.text = var_129_16

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_17 = 8
				local var_129_18 = utf8.len(var_129_16)
				local var_129_19 = var_129_17 <= 0 and var_129_13 or var_129_13 * (var_129_18 / var_129_17)

				if var_129_19 > 0 and var_129_13 < var_129_19 then
					arg_126_1.talkMaxDuration = var_129_19

					if var_129_19 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_12
					end
				end

				arg_126_1.text_.text = var_129_16
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071031", "story_v_out_304071.awb") ~= 0 then
					local var_129_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071031", "story_v_out_304071.awb") / 1000

					if var_129_20 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_20 + var_129_12
					end

					if var_129_15.prefab_name ~= "" and arg_126_1.actors_[var_129_15.prefab_name] ~= nil then
						local var_129_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_15.prefab_name].transform, "story_v_out_304071", "304071031", "story_v_out_304071.awb")

						arg_126_1:RecordAudio("304071031", var_129_21)
						arg_126_1:RecordAudio("304071031", var_129_21)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_304071", "304071031", "story_v_out_304071.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_304071", "304071031", "story_v_out_304071.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_22 = math.max(var_129_13, arg_126_1.talkMaxDuration)

			if var_129_12 <= arg_126_1.time_ and arg_126_1.time_ < var_129_12 + var_129_22 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_12) / var_129_22

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_12 + var_129_22 and arg_126_1.time_ < var_129_12 + var_129_22 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play304071032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 304071032
		arg_130_1.duration_ = 8.9

		local var_130_0 = {
			zh = 8.6,
			ja = 8.9
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play304071033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1013ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1013ui_story == nil then
				arg_130_1.var_.characterEffect1013ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1013ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1013ui_story then
				arg_130_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["1011ui_story"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1011ui_story == nil then
				arg_130_1.var_.characterEffect1011ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.200000002980232

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.characterEffect1011ui_story and not isNil(var_133_4) then
					local var_133_8 = Mathf.Lerp(0, 0.5, var_133_7)

					arg_130_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1011ui_story.fillRatio = var_133_8
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1011ui_story then
				local var_133_9 = 0.5

				arg_130_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1011ui_story.fillRatio = var_133_9
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action7_2")
			end

			local var_133_11 = 0

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_133_12 = 0
			local var_133_13 = 1

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[36].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(304071032)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 40
				local var_133_18 = utf8.len(var_133_16)
				local var_133_19 = var_133_17 <= 0 and var_133_13 or var_133_13 * (var_133_18 / var_133_17)

				if var_133_19 > 0 and var_133_13 < var_133_19 then
					arg_130_1.talkMaxDuration = var_133_19

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071032", "story_v_out_304071.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071032", "story_v_out_304071.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_304071", "304071032", "story_v_out_304071.awb")

						arg_130_1:RecordAudio("304071032", var_133_21)
						arg_130_1:RecordAudio("304071032", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_304071", "304071032", "story_v_out_304071.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_304071", "304071032", "story_v_out_304071.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_22 and arg_130_1.time_ < var_133_12 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play304071033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 304071033
		arg_134_1.duration_ = 4

		local var_134_0 = {
			zh = 4,
			ja = 1.999999999999
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play304071034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1084ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1084ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(-0.7, -0.97, -6)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1084ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = arg_134_1.actors_["1011ui_story"].transform
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.var_.moveOldPos1011ui_story = var_137_9.localPosition
			end

			local var_137_11 = 0.001

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / var_137_11
				local var_137_13 = Vector3.New(0, 100, 0)

				var_137_9.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1011ui_story, var_137_13, var_137_12)

				local var_137_14 = manager.ui.mainCamera.transform.position - var_137_9.position

				var_137_9.forward = Vector3.New(var_137_14.x, var_137_14.y, var_137_14.z)

				local var_137_15 = var_137_9.localEulerAngles

				var_137_15.z = 0
				var_137_15.x = 0
				var_137_9.localEulerAngles = var_137_15
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 then
				var_137_9.localPosition = Vector3.New(0, 100, 0)

				local var_137_16 = manager.ui.mainCamera.transform.position - var_137_9.position

				var_137_9.forward = Vector3.New(var_137_16.x, var_137_16.y, var_137_16.z)

				local var_137_17 = var_137_9.localEulerAngles

				var_137_17.z = 0
				var_137_17.x = 0
				var_137_9.localEulerAngles = var_137_17
			end

			local var_137_18 = arg_134_1.actors_["1013ui_story"].transform
			local var_137_19 = 0

			if var_137_19 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 then
				arg_134_1.var_.moveOldPos1013ui_story = var_137_18.localPosition
			end

			local var_137_20 = 0.001

			if var_137_19 <= arg_134_1.time_ and arg_134_1.time_ < var_137_19 + var_137_20 then
				local var_137_21 = (arg_134_1.time_ - var_137_19) / var_137_20
				local var_137_22 = Vector3.New(0.7, -0.66, -6.15)

				var_137_18.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1013ui_story, var_137_22, var_137_21)

				local var_137_23 = manager.ui.mainCamera.transform.position - var_137_18.position

				var_137_18.forward = Vector3.New(var_137_23.x, var_137_23.y, var_137_23.z)

				local var_137_24 = var_137_18.localEulerAngles

				var_137_24.z = 0
				var_137_24.x = 0
				var_137_18.localEulerAngles = var_137_24
			end

			if arg_134_1.time_ >= var_137_19 + var_137_20 and arg_134_1.time_ < var_137_19 + var_137_20 + arg_137_0 then
				var_137_18.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_137_25 = manager.ui.mainCamera.transform.position - var_137_18.position

				var_137_18.forward = Vector3.New(var_137_25.x, var_137_25.y, var_137_25.z)

				local var_137_26 = var_137_18.localEulerAngles

				var_137_26.z = 0
				var_137_26.x = 0
				var_137_18.localEulerAngles = var_137_26
			end

			local var_137_27 = arg_134_1.actors_["1084ui_story"]
			local var_137_28 = 0

			if var_137_28 < arg_134_1.time_ and arg_134_1.time_ <= var_137_28 + arg_137_0 and not isNil(var_137_27) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_29 = 0.200000002980232

			if var_137_28 <= arg_134_1.time_ and arg_134_1.time_ < var_137_28 + var_137_29 and not isNil(var_137_27) then
				local var_137_30 = (arg_134_1.time_ - var_137_28) / var_137_29

				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_27) then
					arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_28 + var_137_29 and arg_134_1.time_ < var_137_28 + var_137_29 + arg_137_0 and not isNil(var_137_27) and arg_134_1.var_.characterEffect1084ui_story then
				arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_137_31 = arg_134_1.actors_["1013ui_story"]
			local var_137_32 = 0

			if var_137_32 < arg_134_1.time_ and arg_134_1.time_ <= var_137_32 + arg_137_0 and not isNil(var_137_31) and arg_134_1.var_.characterEffect1013ui_story == nil then
				arg_134_1.var_.characterEffect1013ui_story = var_137_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_33 = 0.200000002980232

			if var_137_32 <= arg_134_1.time_ and arg_134_1.time_ < var_137_32 + var_137_33 and not isNil(var_137_31) then
				local var_137_34 = (arg_134_1.time_ - var_137_32) / var_137_33

				if arg_134_1.var_.characterEffect1013ui_story and not isNil(var_137_31) then
					local var_137_35 = Mathf.Lerp(0, 0.5, var_137_34)

					arg_134_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1013ui_story.fillRatio = var_137_35
				end
			end

			if arg_134_1.time_ >= var_137_32 + var_137_33 and arg_134_1.time_ < var_137_32 + var_137_33 + arg_137_0 and not isNil(var_137_31) and arg_134_1.var_.characterEffect1013ui_story then
				local var_137_36 = 0.5

				arg_134_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1013ui_story.fillRatio = var_137_36
			end

			local var_137_37 = 0

			if var_137_37 < arg_134_1.time_ and arg_134_1.time_ <= var_137_37 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_137_38 = 0

			if var_137_38 < arg_134_1.time_ and arg_134_1.time_ <= var_137_38 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_39 = 0
			local var_137_40 = 0.325

			if var_137_39 < arg_134_1.time_ and arg_134_1.time_ <= var_137_39 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_41 = arg_134_1:FormatText(StoryNameCfg[6].name)

				arg_134_1.leftNameTxt_.text = var_137_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_42 = arg_134_1:GetWordFromCfg(304071033)
				local var_137_43 = arg_134_1:FormatText(var_137_42.content)

				arg_134_1.text_.text = var_137_43

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_44 = 13
				local var_137_45 = utf8.len(var_137_43)
				local var_137_46 = var_137_44 <= 0 and var_137_40 or var_137_40 * (var_137_45 / var_137_44)

				if var_137_46 > 0 and var_137_40 < var_137_46 then
					arg_134_1.talkMaxDuration = var_137_46

					if var_137_46 + var_137_39 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_46 + var_137_39
					end
				end

				arg_134_1.text_.text = var_137_43
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071033", "story_v_out_304071.awb") ~= 0 then
					local var_137_47 = manager.audio:GetVoiceLength("story_v_out_304071", "304071033", "story_v_out_304071.awb") / 1000

					if var_137_47 + var_137_39 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_47 + var_137_39
					end

					if var_137_42.prefab_name ~= "" and arg_134_1.actors_[var_137_42.prefab_name] ~= nil then
						local var_137_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_42.prefab_name].transform, "story_v_out_304071", "304071033", "story_v_out_304071.awb")

						arg_134_1:RecordAudio("304071033", var_137_48)
						arg_134_1:RecordAudio("304071033", var_137_48)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_304071", "304071033", "story_v_out_304071.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_304071", "304071033", "story_v_out_304071.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_49 = math.max(var_137_40, arg_134_1.talkMaxDuration)

			if var_137_39 <= arg_134_1.time_ and arg_134_1.time_ < var_137_39 + var_137_49 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_39) / var_137_49

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_39 + var_137_49 and arg_134_1.time_ < var_137_39 + var_137_49 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play304071034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 304071034
		arg_138_1.duration_ = 4.23

		local var_138_0 = {
			zh = 3.1,
			ja = 4.233
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play304071035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1013ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1013ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0.7, -0.66, -6.15)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1013ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = arg_138_1.actors_["1013ui_story"]
			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1013ui_story == nil then
				arg_138_1.var_.characterEffect1013ui_story = var_141_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_11 = 0.200000002980232

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_11 and not isNil(var_141_9) then
				local var_141_12 = (arg_138_1.time_ - var_141_10) / var_141_11

				if arg_138_1.var_.characterEffect1013ui_story and not isNil(var_141_9) then
					arg_138_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_10 + var_141_11 and arg_138_1.time_ < var_141_10 + var_141_11 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1013ui_story then
				arg_138_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_141_13 = arg_138_1.actors_["1084ui_story"]
			local var_141_14 = 0

			if var_141_14 < arg_138_1.time_ and arg_138_1.time_ <= var_141_14 + arg_141_0 and not isNil(var_141_13) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_15 = 0.200000002980232

			if var_141_14 <= arg_138_1.time_ and arg_138_1.time_ < var_141_14 + var_141_15 and not isNil(var_141_13) then
				local var_141_16 = (arg_138_1.time_ - var_141_14) / var_141_15

				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_13) then
					local var_141_17 = Mathf.Lerp(0, 0.5, var_141_16)

					arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_17
				end
			end

			if arg_138_1.time_ >= var_141_14 + var_141_15 and arg_138_1.time_ < var_141_14 + var_141_15 + arg_141_0 and not isNil(var_141_13) and arg_138_1.var_.characterEffect1084ui_story then
				local var_141_18 = 0.5

				arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_18
			end

			local var_141_19 = 0

			if var_141_19 < arg_138_1.time_ and arg_138_1.time_ <= var_141_19 + arg_141_0 then
				arg_138_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			local var_141_20 = 0

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_21 = 0
			local var_141_22 = 0.4

			if var_141_21 < arg_138_1.time_ and arg_138_1.time_ <= var_141_21 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_23 = arg_138_1:FormatText(StoryNameCfg[35].name)

				arg_138_1.leftNameTxt_.text = var_141_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_24 = arg_138_1:GetWordFromCfg(304071034)
				local var_141_25 = arg_138_1:FormatText(var_141_24.content)

				arg_138_1.text_.text = var_141_25

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_26 = 16
				local var_141_27 = utf8.len(var_141_25)
				local var_141_28 = var_141_26 <= 0 and var_141_22 or var_141_22 * (var_141_27 / var_141_26)

				if var_141_28 > 0 and var_141_22 < var_141_28 then
					arg_138_1.talkMaxDuration = var_141_28

					if var_141_28 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_28 + var_141_21
					end
				end

				arg_138_1.text_.text = var_141_25
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071034", "story_v_out_304071.awb") ~= 0 then
					local var_141_29 = manager.audio:GetVoiceLength("story_v_out_304071", "304071034", "story_v_out_304071.awb") / 1000

					if var_141_29 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_29 + var_141_21
					end

					if var_141_24.prefab_name ~= "" and arg_138_1.actors_[var_141_24.prefab_name] ~= nil then
						local var_141_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_24.prefab_name].transform, "story_v_out_304071", "304071034", "story_v_out_304071.awb")

						arg_138_1:RecordAudio("304071034", var_141_30)
						arg_138_1:RecordAudio("304071034", var_141_30)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_304071", "304071034", "story_v_out_304071.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_304071", "304071034", "story_v_out_304071.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_31 = math.max(var_141_22, arg_138_1.talkMaxDuration)

			if var_141_21 <= arg_138_1.time_ and arg_138_1.time_ < var_141_21 + var_141_31 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_21) / var_141_31

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_21 + var_141_31 and arg_138_1.time_ < var_141_21 + var_141_31 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play304071035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 304071035
		arg_142_1.duration_ = 12

		local var_142_0 = {
			zh = 8.833,
			ja = 12
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play304071036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.025

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[35].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:GetWordFromCfg(304071035)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 41
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071035", "story_v_out_304071.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071035", "story_v_out_304071.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_304071", "304071035", "story_v_out_304071.awb")

						arg_142_1:RecordAudio("304071035", var_145_9)
						arg_142_1:RecordAudio("304071035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_304071", "304071035", "story_v_out_304071.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_304071", "304071035", "story_v_out_304071.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play304071036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 304071036
		arg_146_1.duration_ = 2.7

		local var_146_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play304071037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1011ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1011ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(-0.7, -0.71, -6)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1011ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1011ui_story"]
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1011ui_story == nil then
				arg_146_1.var_.characterEffect1011ui_story = var_149_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_11 = 0.200000002980232

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 and not isNil(var_149_9) then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11

				if arg_146_1.var_.characterEffect1011ui_story and not isNil(var_149_9) then
					arg_146_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1011ui_story then
				arg_146_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_149_13 = arg_146_1.actors_["1013ui_story"]
			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 and not isNil(var_149_13) and arg_146_1.var_.characterEffect1013ui_story == nil then
				arg_146_1.var_.characterEffect1013ui_story = var_149_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_15 = 0.200000002980232

			if var_149_14 <= arg_146_1.time_ and arg_146_1.time_ < var_149_14 + var_149_15 and not isNil(var_149_13) then
				local var_149_16 = (arg_146_1.time_ - var_149_14) / var_149_15

				if arg_146_1.var_.characterEffect1013ui_story and not isNil(var_149_13) then
					local var_149_17 = Mathf.Lerp(0, 0.5, var_149_16)

					arg_146_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1013ui_story.fillRatio = var_149_17
				end
			end

			if arg_146_1.time_ >= var_149_14 + var_149_15 and arg_146_1.time_ < var_149_14 + var_149_15 + arg_149_0 and not isNil(var_149_13) and arg_146_1.var_.characterEffect1013ui_story then
				local var_149_18 = 0.5

				arg_146_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1013ui_story.fillRatio = var_149_18
			end

			local var_149_19 = 0

			if var_149_19 < arg_146_1.time_ and arg_146_1.time_ <= var_149_19 + arg_149_0 then
				arg_146_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_2")
			end

			local var_149_20 = 0

			if var_149_20 < arg_146_1.time_ and arg_146_1.time_ <= var_149_20 + arg_149_0 then
				arg_146_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_149_21 = arg_146_1.actors_["1084ui_story"].transform
			local var_149_22 = 0

			if var_149_22 < arg_146_1.time_ and arg_146_1.time_ <= var_149_22 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_21.localPosition
			end

			local var_149_23 = 0.001

			if var_149_22 <= arg_146_1.time_ and arg_146_1.time_ < var_149_22 + var_149_23 then
				local var_149_24 = (arg_146_1.time_ - var_149_22) / var_149_23
				local var_149_25 = Vector3.New(0, 100, 0)

				var_149_21.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, var_149_25, var_149_24)

				local var_149_26 = manager.ui.mainCamera.transform.position - var_149_21.position

				var_149_21.forward = Vector3.New(var_149_26.x, var_149_26.y, var_149_26.z)

				local var_149_27 = var_149_21.localEulerAngles

				var_149_27.z = 0
				var_149_27.x = 0
				var_149_21.localEulerAngles = var_149_27
			end

			if arg_146_1.time_ >= var_149_22 + var_149_23 and arg_146_1.time_ < var_149_22 + var_149_23 + arg_149_0 then
				var_149_21.localPosition = Vector3.New(0, 100, 0)

				local var_149_28 = manager.ui.mainCamera.transform.position - var_149_21.position

				var_149_21.forward = Vector3.New(var_149_28.x, var_149_28.y, var_149_28.z)

				local var_149_29 = var_149_21.localEulerAngles

				var_149_29.z = 0
				var_149_29.x = 0
				var_149_21.localEulerAngles = var_149_29
			end

			local var_149_30 = 0
			local var_149_31 = 0.075

			if var_149_30 < arg_146_1.time_ and arg_146_1.time_ <= var_149_30 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_32 = arg_146_1:FormatText(StoryNameCfg[37].name)

				arg_146_1.leftNameTxt_.text = var_149_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_33 = arg_146_1:GetWordFromCfg(304071036)
				local var_149_34 = arg_146_1:FormatText(var_149_33.content)

				arg_146_1.text_.text = var_149_34

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_35 = 3
				local var_149_36 = utf8.len(var_149_34)
				local var_149_37 = var_149_35 <= 0 and var_149_31 or var_149_31 * (var_149_36 / var_149_35)

				if var_149_37 > 0 and var_149_31 < var_149_37 then
					arg_146_1.talkMaxDuration = var_149_37

					if var_149_37 + var_149_30 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_37 + var_149_30
					end
				end

				arg_146_1.text_.text = var_149_34
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071036", "story_v_out_304071.awb") ~= 0 then
					local var_149_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071036", "story_v_out_304071.awb") / 1000

					if var_149_38 + var_149_30 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_38 + var_149_30
					end

					if var_149_33.prefab_name ~= "" and arg_146_1.actors_[var_149_33.prefab_name] ~= nil then
						local var_149_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_33.prefab_name].transform, "story_v_out_304071", "304071036", "story_v_out_304071.awb")

						arg_146_1:RecordAudio("304071036", var_149_39)
						arg_146_1:RecordAudio("304071036", var_149_39)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_304071", "304071036", "story_v_out_304071.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_304071", "304071036", "story_v_out_304071.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_40 = math.max(var_149_31, arg_146_1.talkMaxDuration)

			if var_149_30 <= arg_146_1.time_ and arg_146_1.time_ < var_149_30 + var_149_40 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_30) / var_149_40

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_30 + var_149_40 and arg_146_1.time_ < var_149_30 + var_149_40 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play304071037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 304071037
		arg_150_1.duration_ = 2

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play304071038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1013ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1013ui_story == nil then
				arg_150_1.var_.characterEffect1013ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1013ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1013ui_story then
				arg_150_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_153_4 = arg_150_1.actors_["1011ui_story"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1011ui_story == nil then
				arg_150_1.var_.characterEffect1011ui_story = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.200000002980232

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect1011ui_story and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1011ui_story.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1011ui_story then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1011ui_story.fillRatio = var_153_9
			end

			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_153_11 = 0
			local var_153_12 = 0.075

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_13 = arg_150_1:FormatText(StoryNameCfg[35].name)

				arg_150_1.leftNameTxt_.text = var_153_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_14 = arg_150_1:GetWordFromCfg(304071037)
				local var_153_15 = arg_150_1:FormatText(var_153_14.content)

				arg_150_1.text_.text = var_153_15

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_16 = 3
				local var_153_17 = utf8.len(var_153_15)
				local var_153_18 = var_153_16 <= 0 and var_153_12 or var_153_12 * (var_153_17 / var_153_16)

				if var_153_18 > 0 and var_153_12 < var_153_18 then
					arg_150_1.talkMaxDuration = var_153_18

					if var_153_18 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_18 + var_153_11
					end
				end

				arg_150_1.text_.text = var_153_15
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071037", "story_v_out_304071.awb") ~= 0 then
					local var_153_19 = manager.audio:GetVoiceLength("story_v_out_304071", "304071037", "story_v_out_304071.awb") / 1000

					if var_153_19 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_11
					end

					if var_153_14.prefab_name ~= "" and arg_150_1.actors_[var_153_14.prefab_name] ~= nil then
						local var_153_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_14.prefab_name].transform, "story_v_out_304071", "304071037", "story_v_out_304071.awb")

						arg_150_1:RecordAudio("304071037", var_153_20)
						arg_150_1:RecordAudio("304071037", var_153_20)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_304071", "304071037", "story_v_out_304071.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_304071", "304071037", "story_v_out_304071.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_21 = math.max(var_153_12, arg_150_1.talkMaxDuration)

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_21 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_11) / var_153_21

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_11 + var_153_21 and arg_150_1.time_ < var_153_11 + var_153_21 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play304071038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 304071038
		arg_154_1.duration_ = 21.33

		local var_154_0 = {
			zh = 14.7,
			ja = 21.333
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play304071039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = "B02f"

			if arg_154_1.bgs_[var_157_0] == nil then
				local var_157_1 = Object.Instantiate(arg_154_1.paintGo_)

				var_157_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_157_0)
				var_157_1.name = var_157_0
				var_157_1.transform.parent = arg_154_1.stage_.transform
				var_157_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.bgs_[var_157_0] = var_157_1
			end

			local var_157_2 = 1.98333333333233

			if var_157_2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				local var_157_3 = manager.ui.mainCamera.transform.localPosition
				local var_157_4 = Vector3.New(0, 0, 10) + Vector3.New(var_157_3.x, var_157_3.y, 0)
				local var_157_5 = arg_154_1.bgs_.B02f

				var_157_5.transform.localPosition = var_157_4
				var_157_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_6 = var_157_5:GetComponent("SpriteRenderer")

				if var_157_6 and var_157_6.sprite then
					local var_157_7 = (var_157_5.transform.localPosition - var_157_3).z
					local var_157_8 = manager.ui.mainCameraCom_
					local var_157_9 = 2 * var_157_7 * Mathf.Tan(var_157_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_157_10 = var_157_9 * var_157_8.aspect
					local var_157_11 = var_157_6.sprite.bounds.size.x
					local var_157_12 = var_157_6.sprite.bounds.size.y
					local var_157_13 = var_157_10 / var_157_11
					local var_157_14 = var_157_9 / var_157_12
					local var_157_15 = var_157_14 < var_157_13 and var_157_13 or var_157_14

					var_157_5.transform.localScale = Vector3.New(var_157_15, var_157_15, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "B02f" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_16 = "S0105"

			if arg_154_1.bgs_[var_157_16] == nil then
				local var_157_17 = Object.Instantiate(arg_154_1.paintGo_)

				var_157_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_157_16)
				var_157_17.name = var_157_16
				var_157_17.transform.parent = arg_154_1.stage_.transform
				var_157_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.bgs_[var_157_16] = var_157_17
			end

			local var_157_18 = 6.2

			if var_157_18 < arg_154_1.time_ and arg_154_1.time_ <= var_157_18 + arg_157_0 then
				local var_157_19 = manager.ui.mainCamera.transform.localPosition
				local var_157_20 = Vector3.New(0, 0, 10) + Vector3.New(var_157_19.x, var_157_19.y, 0)
				local var_157_21 = arg_154_1.bgs_.S0105

				var_157_21.transform.localPosition = var_157_20
				var_157_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_22 = var_157_21:GetComponent("SpriteRenderer")

				if var_157_22 and var_157_22.sprite then
					local var_157_23 = (var_157_21.transform.localPosition - var_157_19).z
					local var_157_24 = manager.ui.mainCameraCom_
					local var_157_25 = 2 * var_157_23 * Mathf.Tan(var_157_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_157_26 = var_157_25 * var_157_24.aspect
					local var_157_27 = var_157_22.sprite.bounds.size.x
					local var_157_28 = var_157_22.sprite.bounds.size.y
					local var_157_29 = var_157_26 / var_157_27
					local var_157_30 = var_157_25 / var_157_28
					local var_157_31 = var_157_30 < var_157_29 and var_157_29 or var_157_30

					var_157_21.transform.localScale = Vector3.New(var_157_31, var_157_31, 0)
				end

				for iter_157_2, iter_157_3 in pairs(arg_154_1.bgs_) do
					if iter_157_2 ~= "S0105" then
						iter_157_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_32 = 1.999999999999

			if var_157_32 < arg_154_1.time_ and arg_154_1.time_ <= var_157_32 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			local var_157_33 = 0.3

			if arg_154_1.time_ >= var_157_32 + var_157_33 and arg_154_1.time_ < var_157_32 + var_157_33 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_34 = 0

			if var_157_34 < arg_154_1.time_ and arg_154_1.time_ <= var_157_34 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_35 = 2

			if var_157_34 <= arg_154_1.time_ and arg_154_1.time_ < var_157_34 + var_157_35 then
				local var_157_36 = (arg_154_1.time_ - var_157_34) / var_157_35
				local var_157_37 = Color.New(0, 0, 0)

				var_157_37.a = Mathf.Lerp(0, 1, var_157_36)
				arg_154_1.mask_.color = var_157_37
			end

			if arg_154_1.time_ >= var_157_34 + var_157_35 and arg_154_1.time_ < var_157_34 + var_157_35 + arg_157_0 then
				local var_157_38 = Color.New(0, 0, 0)

				var_157_38.a = 1
				arg_154_1.mask_.color = var_157_38
			end

			local var_157_39 = 1.999999999999

			if var_157_39 < arg_154_1.time_ and arg_154_1.time_ <= var_157_39 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_40 = 2

			if var_157_39 <= arg_154_1.time_ and arg_154_1.time_ < var_157_39 + var_157_40 then
				local var_157_41 = (arg_154_1.time_ - var_157_39) / var_157_40
				local var_157_42 = Color.New(0, 0, 0)

				var_157_42.a = Mathf.Lerp(1, 0, var_157_41)
				arg_154_1.mask_.color = var_157_42
			end

			if arg_154_1.time_ >= var_157_39 + var_157_40 and arg_154_1.time_ < var_157_39 + var_157_40 + arg_157_0 then
				local var_157_43 = Color.New(0, 0, 0)
				local var_157_44 = 0

				arg_154_1.mask_.enabled = false
				var_157_43.a = var_157_44
				arg_154_1.mask_.color = var_157_43
			end

			local var_157_45 = "3008ui_story"

			if arg_154_1.actors_[var_157_45] == nil then
				local var_157_46 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_157_46) then
					local var_157_47 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_154_1.stage_.transform)

					var_157_47.name = var_157_45
					var_157_47.transform.localPosition = Vector3.New(0, 100, 0)
					arg_154_1.actors_[var_157_45] = var_157_47

					local var_157_48 = var_157_47:GetComponentInChildren(typeof(CharacterEffect))

					var_157_48.enabled = true

					local var_157_49 = GameObjectTools.GetOrAddComponent(var_157_47, typeof(DynamicBoneHelper))

					if var_157_49 then
						var_157_49:EnableDynamicBone(false)
					end

					arg_154_1:ShowWeapon(var_157_48.transform, false)

					arg_154_1.var_[var_157_45 .. "Animator"] = var_157_48.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_154_1.var_[var_157_45 .. "Animator"].applyRootMotion = true
					arg_154_1.var_[var_157_45 .. "LipSync"] = var_157_48.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_157_50 = arg_154_1.actors_["3008ui_story"].transform
			local var_157_51 = 1.999999999999

			if var_157_51 < arg_154_1.time_ and arg_154_1.time_ <= var_157_51 + arg_157_0 then
				arg_154_1.var_.moveOldPos3008ui_story = var_157_50.localPosition
			end

			local var_157_52 = 0.001

			if var_157_51 <= arg_154_1.time_ and arg_154_1.time_ < var_157_51 + var_157_52 then
				local var_157_53 = (arg_154_1.time_ - var_157_51) / var_157_52
				local var_157_54 = Vector3.New(0, 100, 0)

				var_157_50.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos3008ui_story, var_157_54, var_157_53)

				local var_157_55 = manager.ui.mainCamera.transform.position - var_157_50.position

				var_157_50.forward = Vector3.New(var_157_55.x, var_157_55.y, var_157_55.z)

				local var_157_56 = var_157_50.localEulerAngles

				var_157_56.z = 0
				var_157_56.x = 0
				var_157_50.localEulerAngles = var_157_56
			end

			if arg_154_1.time_ >= var_157_51 + var_157_52 and arg_154_1.time_ < var_157_51 + var_157_52 + arg_157_0 then
				var_157_50.localPosition = Vector3.New(0, 100, 0)

				local var_157_57 = manager.ui.mainCamera.transform.position - var_157_50.position

				var_157_50.forward = Vector3.New(var_157_57.x, var_157_57.y, var_157_57.z)

				local var_157_58 = var_157_50.localEulerAngles

				var_157_58.z = 0
				var_157_58.x = 0
				var_157_50.localEulerAngles = var_157_58
			end

			local var_157_59 = arg_154_1.actors_["1011ui_story"].transform
			local var_157_60 = 1.999999999999

			if var_157_60 < arg_154_1.time_ and arg_154_1.time_ <= var_157_60 + arg_157_0 then
				arg_154_1.var_.moveOldPos1011ui_story = var_157_59.localPosition
			end

			local var_157_61 = 0.001

			if var_157_60 <= arg_154_1.time_ and arg_154_1.time_ < var_157_60 + var_157_61 then
				local var_157_62 = (arg_154_1.time_ - var_157_60) / var_157_61
				local var_157_63 = Vector3.New(0, 100, 0)

				var_157_59.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1011ui_story, var_157_63, var_157_62)

				local var_157_64 = manager.ui.mainCamera.transform.position - var_157_59.position

				var_157_59.forward = Vector3.New(var_157_64.x, var_157_64.y, var_157_64.z)

				local var_157_65 = var_157_59.localEulerAngles

				var_157_65.z = 0
				var_157_65.x = 0
				var_157_59.localEulerAngles = var_157_65
			end

			if arg_154_1.time_ >= var_157_60 + var_157_61 and arg_154_1.time_ < var_157_60 + var_157_61 + arg_157_0 then
				var_157_59.localPosition = Vector3.New(0, 100, 0)

				local var_157_66 = manager.ui.mainCamera.transform.position - var_157_59.position

				var_157_59.forward = Vector3.New(var_157_66.x, var_157_66.y, var_157_66.z)

				local var_157_67 = var_157_59.localEulerAngles

				var_157_67.z = 0
				var_157_67.x = 0
				var_157_59.localEulerAngles = var_157_67
			end

			local var_157_68 = arg_154_1.actors_["1013ui_story"].transform
			local var_157_69 = 1.999999999999

			if var_157_69 < arg_154_1.time_ and arg_154_1.time_ <= var_157_69 + arg_157_0 then
				arg_154_1.var_.moveOldPos1013ui_story = var_157_68.localPosition
			end

			local var_157_70 = 0.001

			if var_157_69 <= arg_154_1.time_ and arg_154_1.time_ < var_157_69 + var_157_70 then
				local var_157_71 = (arg_154_1.time_ - var_157_69) / var_157_70
				local var_157_72 = Vector3.New(0, 100, 0)

				var_157_68.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1013ui_story, var_157_72, var_157_71)

				local var_157_73 = manager.ui.mainCamera.transform.position - var_157_68.position

				var_157_68.forward = Vector3.New(var_157_73.x, var_157_73.y, var_157_73.z)

				local var_157_74 = var_157_68.localEulerAngles

				var_157_74.z = 0
				var_157_74.x = 0
				var_157_68.localEulerAngles = var_157_74
			end

			if arg_154_1.time_ >= var_157_69 + var_157_70 and arg_154_1.time_ < var_157_69 + var_157_70 + arg_157_0 then
				var_157_68.localPosition = Vector3.New(0, 100, 0)

				local var_157_75 = manager.ui.mainCamera.transform.position - var_157_68.position

				var_157_68.forward = Vector3.New(var_157_75.x, var_157_75.y, var_157_75.z)

				local var_157_76 = var_157_68.localEulerAngles

				var_157_76.z = 0
				var_157_76.x = 0
				var_157_68.localEulerAngles = var_157_76
			end

			local var_157_77 = arg_154_1.actors_["3008ui_story"]
			local var_157_78 = 1.999999999999

			if var_157_78 < arg_154_1.time_ and arg_154_1.time_ <= var_157_78 + arg_157_0 and not isNil(var_157_77) and arg_154_1.var_.characterEffect3008ui_story == nil then
				arg_154_1.var_.characterEffect3008ui_story = var_157_77:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_79 = 0.200000002980232

			if var_157_78 <= arg_154_1.time_ and arg_154_1.time_ < var_157_78 + var_157_79 and not isNil(var_157_77) then
				local var_157_80 = (arg_154_1.time_ - var_157_78) / var_157_79

				if arg_154_1.var_.characterEffect3008ui_story and not isNil(var_157_77) then
					arg_154_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_78 + var_157_79 and arg_154_1.time_ < var_157_78 + var_157_79 + arg_157_0 and not isNil(var_157_77) and arg_154_1.var_.characterEffect3008ui_story then
				arg_154_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_157_81 = arg_154_1.actors_["1013ui_story"]
			local var_157_82 = 1.999999999999

			if var_157_82 < arg_154_1.time_ and arg_154_1.time_ <= var_157_82 + arg_157_0 and not isNil(var_157_81) and arg_154_1.var_.characterEffect1013ui_story == nil then
				arg_154_1.var_.characterEffect1013ui_story = var_157_81:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_83 = 0.200000002980232

			if var_157_82 <= arg_154_1.time_ and arg_154_1.time_ < var_157_82 + var_157_83 and not isNil(var_157_81) then
				local var_157_84 = (arg_154_1.time_ - var_157_82) / var_157_83

				if arg_154_1.var_.characterEffect1013ui_story and not isNil(var_157_81) then
					local var_157_85 = Mathf.Lerp(0, 0.5, var_157_84)

					arg_154_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1013ui_story.fillRatio = var_157_85
				end
			end

			if arg_154_1.time_ >= var_157_82 + var_157_83 and arg_154_1.time_ < var_157_82 + var_157_83 + arg_157_0 and not isNil(var_157_81) and arg_154_1.var_.characterEffect1013ui_story then
				local var_157_86 = 0.5

				arg_154_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1013ui_story.fillRatio = var_157_86
			end

			local var_157_87 = arg_154_1.bgs_.S0105.transform
			local var_157_88 = 6.2

			if var_157_88 < arg_154_1.time_ and arg_154_1.time_ <= var_157_88 + arg_157_0 then
				arg_154_1.var_.moveOldPosS0105 = var_157_87.localPosition
			end

			local var_157_89 = 2.33333333333334

			if var_157_88 <= arg_154_1.time_ and arg_154_1.time_ < var_157_88 + var_157_89 then
				local var_157_90 = (arg_154_1.time_ - var_157_88) / var_157_89
				local var_157_91 = Vector3.New(0, 1, 9)

				var_157_87.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPosS0105, var_157_91, var_157_90)
			end

			if arg_154_1.time_ >= var_157_88 + var_157_89 and arg_154_1.time_ < var_157_88 + var_157_89 + arg_157_0 then
				var_157_87.localPosition = Vector3.New(0, 1, 9)
			end

			local var_157_92 = 2
			local var_157_93 = 3
			local var_157_94 = "B02f"

			if var_157_92 < arg_154_1.time_ and arg_154_1.time_ <= var_157_92 + arg_157_0 then
				arg_154_1.timestampController_:SetSelectedState("show")
				arg_154_1.timestampAni_:Play("in")

				arg_154_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_157_94)

				arg_154_1.timestampColorController_:SetSelectedState("hot")
				arg_154_1.timeColdImg_:SetAlpha(0.031)

				local var_157_95 = arg_154_1:GetWordFromCfg(102)
				local var_157_96 = arg_154_1:FormatText(var_157_95.content)

				arg_154_1.text_timeText_.text = var_157_96
				arg_154_1.text_timeText_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_timeText_)

				local var_157_97 = arg_154_1:GetWordFromCfg(501133)
				local var_157_98 = arg_154_1:FormatText(var_157_97.content)

				arg_154_1.text_siteText_.text = var_157_98

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_siteText_)
			end

			if arg_154_1.time_ >= var_157_92 + var_157_93 and arg_154_1.time_ < var_157_92 + var_157_93 + arg_157_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_154_1.timestampAni_, "out", function()
					arg_154_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_157_99 = 5

			if var_157_99 < arg_154_1.time_ and arg_154_1.time_ <= var_157_99 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_100 = 1.2

			if var_157_99 <= arg_154_1.time_ and arg_154_1.time_ < var_157_99 + var_157_100 then
				local var_157_101 = (arg_154_1.time_ - var_157_99) / var_157_100
				local var_157_102 = Color.New(0, 0, 0)

				var_157_102.a = Mathf.Lerp(0, 1, var_157_101)
				arg_154_1.mask_.color = var_157_102
			end

			if arg_154_1.time_ >= var_157_99 + var_157_100 and arg_154_1.time_ < var_157_99 + var_157_100 + arg_157_0 then
				local var_157_103 = Color.New(0, 0, 0)

				var_157_103.a = 1
				arg_154_1.mask_.color = var_157_103
			end

			local var_157_104 = 6.2

			if var_157_104 < arg_154_1.time_ and arg_154_1.time_ <= var_157_104 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_105 = 1.53333333333334

			if var_157_104 <= arg_154_1.time_ and arg_154_1.time_ < var_157_104 + var_157_105 then
				local var_157_106 = (arg_154_1.time_ - var_157_104) / var_157_105
				local var_157_107 = Color.New(0, 0, 0)

				var_157_107.a = Mathf.Lerp(1, 0, var_157_106)
				arg_154_1.mask_.color = var_157_107
			end

			if arg_154_1.time_ >= var_157_104 + var_157_105 and arg_154_1.time_ < var_157_104 + var_157_105 + arg_157_0 then
				local var_157_108 = Color.New(0, 0, 0)
				local var_157_109 = 0

				arg_154_1.mask_.enabled = false
				var_157_108.a = var_157_109
				arg_154_1.mask_.color = var_157_108
			end

			local var_157_110 = 3.76666666666667

			if var_157_110 < arg_154_1.time_ and arg_154_1.time_ <= var_157_110 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			local var_157_111 = 4.33333333333333

			if arg_154_1.time_ >= var_157_110 + var_157_111 and arg_154_1.time_ < var_157_110 + var_157_111 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_112 = 6.2

			arg_154_1.isInRecall_ = false

			if var_157_112 < arg_154_1.time_ and arg_154_1.time_ <= var_157_112 + arg_157_0 then
				arg_154_1.screenFilterGo_:SetActive(true)

				arg_154_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")

				for iter_157_4, iter_157_5 in pairs(arg_154_1.actors_) do
					local var_157_113 = iter_157_5:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_157_6, iter_157_7 in ipairs(var_157_113) do
						if iter_157_7.color.r > 0.51 then
							iter_157_7.color = Color.New(1, 1, 1)
						else
							iter_157_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_157_114 = 2.624999999999

			if var_157_112 <= arg_154_1.time_ and arg_154_1.time_ < var_157_112 + var_157_114 then
				local var_157_115 = (arg_154_1.time_ - var_157_112) / var_157_114

				arg_154_1.screenFilterEffect_.weight = Mathf.Lerp(0, 0.314, var_157_115)
			end

			if arg_154_1.time_ >= var_157_112 + var_157_114 and arg_154_1.time_ < var_157_112 + var_157_114 + arg_157_0 then
				arg_154_1.screenFilterEffect_.weight = 0.314
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_116 = 8.1
			local var_157_117 = 0.725

			if var_157_116 < arg_154_1.time_ and arg_154_1.time_ <= var_157_116 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_118 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_118:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_154_1.dialogCg_.alpha = arg_159_0
				end))
				var_157_118:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_118:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_119 = arg_154_1:FormatText(StoryNameCfg[20].name)

				arg_154_1.leftNameTxt_.text = var_157_119

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_120 = arg_154_1:GetWordFromCfg(304071038)
				local var_157_121 = arg_154_1:FormatText(var_157_120.content)

				arg_154_1.text_.text = var_157_121

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_122 = 29
				local var_157_123 = utf8.len(var_157_121)
				local var_157_124 = var_157_122 <= 0 and var_157_117 or var_157_117 * (var_157_123 / var_157_122)

				if var_157_124 > 0 and var_157_117 < var_157_124 then
					arg_154_1.talkMaxDuration = var_157_124
					var_157_116 = var_157_116 + 0.3

					if var_157_124 + var_157_116 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_124 + var_157_116
					end
				end

				arg_154_1.text_.text = var_157_121
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071038", "story_v_out_304071.awb") ~= 0 then
					local var_157_125 = manager.audio:GetVoiceLength("story_v_out_304071", "304071038", "story_v_out_304071.awb") / 1000

					if var_157_125 + var_157_116 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_125 + var_157_116
					end

					if var_157_120.prefab_name ~= "" and arg_154_1.actors_[var_157_120.prefab_name] ~= nil then
						local var_157_126 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_120.prefab_name].transform, "story_v_out_304071", "304071038", "story_v_out_304071.awb")

						arg_154_1:RecordAudio("304071038", var_157_126)
						arg_154_1:RecordAudio("304071038", var_157_126)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_304071", "304071038", "story_v_out_304071.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_304071", "304071038", "story_v_out_304071.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_127 = var_157_116 + 0.3
			local var_157_128 = math.max(var_157_117, arg_154_1.talkMaxDuration)

			if var_157_127 <= arg_154_1.time_ and arg_154_1.time_ < var_157_127 + var_157_128 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_127) / var_157_128

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_127 + var_157_128 and arg_154_1.time_ < var_157_127 + var_157_128 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0105",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.33333333333334,
				startTime = 6.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play304071039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 304071039
		arg_161_1.duration_ = 7.63

		local var_161_0 = {
			zh = 7.633,
			ja = 5.433
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play304071040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.9

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[35].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(304071039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 36
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071039", "story_v_out_304071.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071039", "story_v_out_304071.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_304071", "304071039", "story_v_out_304071.awb")

						arg_161_1:RecordAudio("304071039", var_164_9)
						arg_161_1:RecordAudio("304071039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_304071", "304071039", "story_v_out_304071.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_304071", "304071039", "story_v_out_304071.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play304071040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 304071040
		arg_165_1.duration_ = 9.37

		local var_165_0 = {
			zh = 5.633,
			ja = 9.366
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play304071041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.725

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[35].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(304071040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 29
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071040", "story_v_out_304071.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071040", "story_v_out_304071.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_304071", "304071040", "story_v_out_304071.awb")

						arg_165_1:RecordAudio("304071040", var_168_9)
						arg_165_1:RecordAudio("304071040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_304071", "304071040", "story_v_out_304071.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_304071", "304071040", "story_v_out_304071.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play304071041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 304071041
		arg_169_1.duration_ = 7.07

		local var_169_0 = {
			zh = 5.733,
			ja = 7.066
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play304071042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.625

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[20].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(304071041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 25
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071041", "story_v_out_304071.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071041", "story_v_out_304071.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_304071", "304071041", "story_v_out_304071.awb")

						arg_169_1:RecordAudio("304071041", var_172_9)
						arg_169_1:RecordAudio("304071041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_304071", "304071041", "story_v_out_304071.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_304071", "304071041", "story_v_out_304071.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play304071042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 304071042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play304071043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1013ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1013ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, 100, 0)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1013ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, 100, 0)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["3008ui_story"].transform
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.var_.moveOldPos3008ui_story = var_176_9.localPosition
			end

			local var_176_11 = 0.001

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11
				local var_176_13 = Vector3.New(0, 100, 0)

				var_176_9.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos3008ui_story, var_176_13, var_176_12)

				local var_176_14 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_14.x, var_176_14.y, var_176_14.z)

				local var_176_15 = var_176_9.localEulerAngles

				var_176_15.z = 0
				var_176_15.x = 0
				var_176_9.localEulerAngles = var_176_15
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 then
				var_176_9.localPosition = Vector3.New(0, 100, 0)

				local var_176_16 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_16.x, var_176_16.y, var_176_16.z)

				local var_176_17 = var_176_9.localEulerAngles

				var_176_17.z = 0
				var_176_17.x = 0
				var_176_9.localEulerAngles = var_176_17
			end

			local var_176_18 = arg_173_1.actors_["3008ui_story"]
			local var_176_19 = 0

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 and not isNil(var_176_18) and arg_173_1.var_.characterEffect3008ui_story == nil then
				arg_173_1.var_.characterEffect3008ui_story = var_176_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_20 = 0.200000002980232

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_20 and not isNil(var_176_18) then
				local var_176_21 = (arg_173_1.time_ - var_176_19) / var_176_20

				if arg_173_1.var_.characterEffect3008ui_story and not isNil(var_176_18) then
					local var_176_22 = Mathf.Lerp(0, 0.5, var_176_21)

					arg_173_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_173_1.var_.characterEffect3008ui_story.fillRatio = var_176_22
				end
			end

			if arg_173_1.time_ >= var_176_19 + var_176_20 and arg_173_1.time_ < var_176_19 + var_176_20 + arg_176_0 and not isNil(var_176_18) and arg_173_1.var_.characterEffect3008ui_story then
				local var_176_23 = 0.5

				arg_173_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_173_1.var_.characterEffect3008ui_story.fillRatio = var_176_23
			end

			local var_176_24 = 0
			local var_176_25 = 1.325

			if var_176_24 < arg_173_1.time_ and arg_173_1.time_ <= var_176_24 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_26 = arg_173_1:GetWordFromCfg(304071042)
				local var_176_27 = arg_173_1:FormatText(var_176_26.content)

				arg_173_1.text_.text = var_176_27

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_28 = 53
				local var_176_29 = utf8.len(var_176_27)
				local var_176_30 = var_176_28 <= 0 and var_176_25 or var_176_25 * (var_176_29 / var_176_28)

				if var_176_30 > 0 and var_176_25 < var_176_30 then
					arg_173_1.talkMaxDuration = var_176_30

					if var_176_30 + var_176_24 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_30 + var_176_24
					end
				end

				arg_173_1.text_.text = var_176_27
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_31 = math.max(var_176_25, arg_173_1.talkMaxDuration)

			if var_176_24 <= arg_173_1.time_ and arg_173_1.time_ < var_176_24 + var_176_31 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_24) / var_176_31

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_24 + var_176_31 and arg_173_1.time_ < var_176_24 + var_176_31 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play304071043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 304071043
		arg_177_1.duration_ = 8.93

		local var_177_0 = {
			zh = 4.833,
			ja = 8.933
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play304071044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.775

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[20].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(304071043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 31
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071043", "story_v_out_304071.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071043", "story_v_out_304071.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_304071", "304071043", "story_v_out_304071.awb")

						arg_177_1:RecordAudio("304071043", var_180_9)
						arg_177_1:RecordAudio("304071043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_304071", "304071043", "story_v_out_304071.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_304071", "304071043", "story_v_out_304071.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play304071044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 304071044
		arg_181_1.duration_ = 3.9

		local var_181_0 = {
			zh = 3.9,
			ja = 3.566
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play304071045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["2020ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect2020ui_story == nil then
				arg_181_1.var_.characterEffect2020ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect2020ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect2020ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect2020ui_story then
				arg_181_1.var_.characterEffect2020ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["3008ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect3008ui_story == nil then
				arg_181_1.var_.characterEffect3008ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect3008ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_181_1.var_.characterEffect3008ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect3008ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_181_1.var_.characterEffect3008ui_story.fillRatio = var_184_9
			end

			local var_184_10 = 0
			local var_184_11 = 0.4

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_12 = arg_181_1:FormatText(StoryNameCfg[19].name)

				arg_181_1.leftNameTxt_.text = var_184_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_13 = arg_181_1:GetWordFromCfg(304071044)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_15 = 16
				local var_184_16 = utf8.len(var_184_14)
				local var_184_17 = var_184_15 <= 0 and var_184_11 or var_184_11 * (var_184_16 / var_184_15)

				if var_184_17 > 0 and var_184_11 < var_184_17 then
					arg_181_1.talkMaxDuration = var_184_17

					if var_184_17 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_10
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071044", "story_v_out_304071.awb") ~= 0 then
					local var_184_18 = manager.audio:GetVoiceLength("story_v_out_304071", "304071044", "story_v_out_304071.awb") / 1000

					if var_184_18 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_10
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_304071", "304071044", "story_v_out_304071.awb")

						arg_181_1:RecordAudio("304071044", var_184_19)
						arg_181_1:RecordAudio("304071044", var_184_19)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_304071", "304071044", "story_v_out_304071.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_304071", "304071044", "story_v_out_304071.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_20 = math.max(var_184_11, arg_181_1.talkMaxDuration)

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_20 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_10) / var_184_20

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_10 + var_184_20 and arg_181_1.time_ < var_184_10 + var_184_20 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play304071045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 304071045
		arg_185_1.duration_ = 6.83

		local var_185_0 = {
			zh = 6.833,
			ja = 6.633
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play304071046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.975

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[20].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(304071045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071045", "story_v_out_304071.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071045", "story_v_out_304071.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_304071", "304071045", "story_v_out_304071.awb")

						arg_185_1:RecordAudio("304071045", var_188_9)
						arg_185_1:RecordAudio("304071045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_304071", "304071045", "story_v_out_304071.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_304071", "304071045", "story_v_out_304071.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play304071046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 304071046
		arg_189_1.duration_ = 8

		local var_189_0 = {
			zh = 5.066,
			ja = 8
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play304071047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.65

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[20].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(304071046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 26
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071046", "story_v_out_304071.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071046", "story_v_out_304071.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_304071", "304071046", "story_v_out_304071.awb")

						arg_189_1:RecordAudio("304071046", var_192_9)
						arg_189_1:RecordAudio("304071046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_304071", "304071046", "story_v_out_304071.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_304071", "304071046", "story_v_out_304071.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play304071047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 304071047
		arg_193_1.duration_ = 5.07

		local var_193_0 = {
			zh = 5.066,
			ja = 4.333
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play304071048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["2020ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect2020ui_story == nil then
				arg_193_1.var_.characterEffect2020ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect2020ui_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect2020ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect2020ui_story then
				arg_193_1.var_.characterEffect2020ui_story.fillFlat = false
			end

			local var_196_4 = arg_193_1.actors_["3008ui_story"]
			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect3008ui_story == nil then
				arg_193_1.var_.characterEffect3008ui_story = var_196_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_6 = 0.200000002980232

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_6 and not isNil(var_196_4) then
				local var_196_7 = (arg_193_1.time_ - var_196_5) / var_196_6

				if arg_193_1.var_.characterEffect3008ui_story and not isNil(var_196_4) then
					local var_196_8 = Mathf.Lerp(0, 0.5, var_196_7)

					arg_193_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_193_1.var_.characterEffect3008ui_story.fillRatio = var_196_8
				end
			end

			if arg_193_1.time_ >= var_196_5 + var_196_6 and arg_193_1.time_ < var_196_5 + var_196_6 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect3008ui_story then
				local var_196_9 = 0.5

				arg_193_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_193_1.var_.characterEffect3008ui_story.fillRatio = var_196_9
			end

			local var_196_10 = 0
			local var_196_11 = 0.525

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_12 = arg_193_1:FormatText(StoryNameCfg[19].name)

				arg_193_1.leftNameTxt_.text = var_196_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_13 = arg_193_1:GetWordFromCfg(304071047)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_15 = 21
				local var_196_16 = utf8.len(var_196_14)
				local var_196_17 = var_196_15 <= 0 and var_196_11 or var_196_11 * (var_196_16 / var_196_15)

				if var_196_17 > 0 and var_196_11 < var_196_17 then
					arg_193_1.talkMaxDuration = var_196_17

					if var_196_17 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_10
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071047", "story_v_out_304071.awb") ~= 0 then
					local var_196_18 = manager.audio:GetVoiceLength("story_v_out_304071", "304071047", "story_v_out_304071.awb") / 1000

					if var_196_18 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_10
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_304071", "304071047", "story_v_out_304071.awb")

						arg_193_1:RecordAudio("304071047", var_196_19)
						arg_193_1:RecordAudio("304071047", var_196_19)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_304071", "304071047", "story_v_out_304071.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_304071", "304071047", "story_v_out_304071.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_20 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_20 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_10) / var_196_20

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_10 + var_196_20 and arg_193_1.time_ < var_196_10 + var_196_20 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play304071048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 304071048
		arg_197_1.duration_ = 17.13

		local var_197_0 = {
			zh = 14.3,
			ja = 17.133
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play304071049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.7

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				local var_200_1 = manager.ui.mainCamera.transform.localPosition
				local var_200_2 = Vector3.New(0, 0, 10) + Vector3.New(var_200_1.x, var_200_1.y, 0)
				local var_200_3 = arg_197_1.bgs_.B02f

				var_200_3.transform.localPosition = var_200_2
				var_200_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_4 = var_200_3:GetComponent("SpriteRenderer")

				if var_200_4 and var_200_4.sprite then
					local var_200_5 = (var_200_3.transform.localPosition - var_200_1).z
					local var_200_6 = manager.ui.mainCameraCom_
					local var_200_7 = 2 * var_200_5 * Mathf.Tan(var_200_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_8 = var_200_7 * var_200_6.aspect
					local var_200_9 = var_200_4.sprite.bounds.size.x
					local var_200_10 = var_200_4.sprite.bounds.size.y
					local var_200_11 = var_200_8 / var_200_9
					local var_200_12 = var_200_7 / var_200_10
					local var_200_13 = var_200_12 < var_200_11 and var_200_11 or var_200_12

					var_200_3.transform.localScale = Vector3.New(var_200_13, var_200_13, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "B02f" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_14 = 1.7

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			local var_200_15 = 0.3

			if arg_197_1.time_ >= var_200_14 + var_200_15 and arg_197_1.time_ < var_200_14 + var_200_15 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_17 = 1.7

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17
				local var_200_19 = Color.New(0, 0, 0)

				var_200_19.a = Mathf.Lerp(0, 1, var_200_18)
				arg_197_1.mask_.color = var_200_19
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				local var_200_20 = Color.New(0, 0, 0)

				var_200_20.a = 1
				arg_197_1.mask_.color = var_200_20
			end

			local var_200_21 = 1.7

			if var_200_21 < arg_197_1.time_ and arg_197_1.time_ <= var_200_21 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_22 = 2

			if var_200_21 <= arg_197_1.time_ and arg_197_1.time_ < var_200_21 + var_200_22 then
				local var_200_23 = (arg_197_1.time_ - var_200_21) / var_200_22
				local var_200_24 = Color.New(0, 0, 0)

				var_200_24.a = Mathf.Lerp(1, 0, var_200_23)
				arg_197_1.mask_.color = var_200_24
			end

			if arg_197_1.time_ >= var_200_21 + var_200_22 and arg_197_1.time_ < var_200_21 + var_200_22 + arg_200_0 then
				local var_200_25 = Color.New(0, 0, 0)
				local var_200_26 = 0

				arg_197_1.mask_.enabled = false
				var_200_25.a = var_200_26
				arg_197_1.mask_.color = var_200_25
			end

			local var_200_27 = arg_197_1.actors_["1013ui_story"].transform
			local var_200_28 = 3.3

			if var_200_28 < arg_197_1.time_ and arg_197_1.time_ <= var_200_28 + arg_200_0 then
				arg_197_1.var_.moveOldPos1013ui_story = var_200_27.localPosition
			end

			local var_200_29 = 0.001

			if var_200_28 <= arg_197_1.time_ and arg_197_1.time_ < var_200_28 + var_200_29 then
				local var_200_30 = (arg_197_1.time_ - var_200_28) / var_200_29
				local var_200_31 = Vector3.New(0, -0.66, -6.15)

				var_200_27.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1013ui_story, var_200_31, var_200_30)

				local var_200_32 = manager.ui.mainCamera.transform.position - var_200_27.position

				var_200_27.forward = Vector3.New(var_200_32.x, var_200_32.y, var_200_32.z)

				local var_200_33 = var_200_27.localEulerAngles

				var_200_33.z = 0
				var_200_33.x = 0
				var_200_27.localEulerAngles = var_200_33
			end

			if arg_197_1.time_ >= var_200_28 + var_200_29 and arg_197_1.time_ < var_200_28 + var_200_29 + arg_200_0 then
				var_200_27.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_200_34 = manager.ui.mainCamera.transform.position - var_200_27.position

				var_200_27.forward = Vector3.New(var_200_34.x, var_200_34.y, var_200_34.z)

				local var_200_35 = var_200_27.localEulerAngles

				var_200_35.z = 0
				var_200_35.x = 0
				var_200_27.localEulerAngles = var_200_35
			end

			local var_200_36 = arg_197_1.actors_["1013ui_story"]
			local var_200_37 = 3.3

			if var_200_37 < arg_197_1.time_ and arg_197_1.time_ <= var_200_37 + arg_200_0 and not isNil(var_200_36) and arg_197_1.var_.characterEffect1013ui_story == nil then
				arg_197_1.var_.characterEffect1013ui_story = var_200_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_38 = 0.200000002980232

			if var_200_37 <= arg_197_1.time_ and arg_197_1.time_ < var_200_37 + var_200_38 and not isNil(var_200_36) then
				local var_200_39 = (arg_197_1.time_ - var_200_37) / var_200_38

				if arg_197_1.var_.characterEffect1013ui_story and not isNil(var_200_36) then
					arg_197_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_37 + var_200_38 and arg_197_1.time_ < var_200_37 + var_200_38 + arg_200_0 and not isNil(var_200_36) and arg_197_1.var_.characterEffect1013ui_story then
				arg_197_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_200_40 = 3.3

			if var_200_40 < arg_197_1.time_ and arg_197_1.time_ <= var_200_40 + arg_200_0 then
				arg_197_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action11_1")
			end

			local var_200_41 = 3.3

			if var_200_41 < arg_197_1.time_ and arg_197_1.time_ <= var_200_41 + arg_200_0 then
				arg_197_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_42 = 1.7

			arg_197_1.isInRecall_ = false

			if var_200_42 < arg_197_1.time_ and arg_197_1.time_ <= var_200_42 + arg_200_0 then
				arg_197_1.screenFilterGo_:SetActive(true)

				arg_197_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")

				for iter_200_2, iter_200_3 in pairs(arg_197_1.actors_) do
					local var_200_43 = iter_200_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_200_4, iter_200_5 in ipairs(var_200_43) do
						if iter_200_5.color.r > 0.51 then
							iter_200_5.color = Color.New(1, 1, 1)
						else
							iter_200_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_200_44 = 0.133333333333333

			if var_200_42 <= arg_197_1.time_ and arg_197_1.time_ < var_200_42 + var_200_44 then
				local var_200_45 = (arg_197_1.time_ - var_200_42) / var_200_44

				arg_197_1.screenFilterEffect_.weight = Mathf.Lerp(0, 0, var_200_45)
			end

			if arg_197_1.time_ >= var_200_42 + var_200_44 and arg_197_1.time_ < var_200_42 + var_200_44 + arg_200_0 then
				arg_197_1.screenFilterEffect_.weight = 0
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_46 = 3.7
			local var_200_47 = 1.175

			if var_200_46 < arg_197_1.time_ and arg_197_1.time_ <= var_200_46 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_48 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_48:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_49 = arg_197_1:FormatText(StoryNameCfg[35].name)

				arg_197_1.leftNameTxt_.text = var_200_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_50 = arg_197_1:GetWordFromCfg(304071048)
				local var_200_51 = arg_197_1:FormatText(var_200_50.content)

				arg_197_1.text_.text = var_200_51

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_52 = 47
				local var_200_53 = utf8.len(var_200_51)
				local var_200_54 = var_200_52 <= 0 and var_200_47 or var_200_47 * (var_200_53 / var_200_52)

				if var_200_54 > 0 and var_200_47 < var_200_54 then
					arg_197_1.talkMaxDuration = var_200_54
					var_200_46 = var_200_46 + 0.3

					if var_200_54 + var_200_46 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_54 + var_200_46
					end
				end

				arg_197_1.text_.text = var_200_51
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071048", "story_v_out_304071.awb") ~= 0 then
					local var_200_55 = manager.audio:GetVoiceLength("story_v_out_304071", "304071048", "story_v_out_304071.awb") / 1000

					if var_200_55 + var_200_46 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_55 + var_200_46
					end

					if var_200_50.prefab_name ~= "" and arg_197_1.actors_[var_200_50.prefab_name] ~= nil then
						local var_200_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_50.prefab_name].transform, "story_v_out_304071", "304071048", "story_v_out_304071.awb")

						arg_197_1:RecordAudio("304071048", var_200_56)
						arg_197_1:RecordAudio("304071048", var_200_56)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_304071", "304071048", "story_v_out_304071.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_304071", "304071048", "story_v_out_304071.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_57 = var_200_46 + 0.3
			local var_200_58 = math.max(var_200_47, arg_197_1.talkMaxDuration)

			if var_200_57 <= arg_197_1.time_ and arg_197_1.time_ < var_200_57 + var_200_58 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_57) / var_200_58

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_57 + var_200_58 and arg_197_1.time_ < var_200_57 + var_200_58 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play304071049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 304071049
		arg_203_1.duration_ = 11.27

		local var_203_0 = {
			zh = 7.8,
			ja = 11.266
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play304071050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.9

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[35].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(304071049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 36
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071049", "story_v_out_304071.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071049", "story_v_out_304071.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_304071", "304071049", "story_v_out_304071.awb")

						arg_203_1:RecordAudio("304071049", var_206_9)
						arg_203_1:RecordAudio("304071049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_304071", "304071049", "story_v_out_304071.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_304071", "304071049", "story_v_out_304071.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play304071050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 304071050
		arg_207_1.duration_ = 4.5

		local var_207_0 = {
			zh = 4.5,
			ja = 1.999999999999
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play304071051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1084ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1084ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(-0.7, -0.97, -6)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1084ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1013ui_story"].transform
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.var_.moveOldPos1013ui_story = var_210_9.localPosition
			end

			local var_210_11 = 0.001

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11
				local var_210_13 = Vector3.New(0.7, -0.66, -6.15)

				var_210_9.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1013ui_story, var_210_13, var_210_12)

				local var_210_14 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_14.x, var_210_14.y, var_210_14.z)

				local var_210_15 = var_210_9.localEulerAngles

				var_210_15.z = 0
				var_210_15.x = 0
				var_210_9.localEulerAngles = var_210_15
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 then
				var_210_9.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_210_16 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_16.x, var_210_16.y, var_210_16.z)

				local var_210_17 = var_210_9.localEulerAngles

				var_210_17.z = 0
				var_210_17.x = 0
				var_210_9.localEulerAngles = var_210_17
			end

			local var_210_18 = arg_207_1.actors_["1084ui_story"]
			local var_210_19 = 0

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 and not isNil(var_210_18) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = var_210_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_20 = 0.200000002980232

			if var_210_19 <= arg_207_1.time_ and arg_207_1.time_ < var_210_19 + var_210_20 and not isNil(var_210_18) then
				local var_210_21 = (arg_207_1.time_ - var_210_19) / var_210_20

				if arg_207_1.var_.characterEffect1084ui_story and not isNil(var_210_18) then
					arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_19 + var_210_20 and arg_207_1.time_ < var_210_19 + var_210_20 + arg_210_0 and not isNil(var_210_18) and arg_207_1.var_.characterEffect1084ui_story then
				arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_210_22 = arg_207_1.actors_["1013ui_story"]
			local var_210_23 = 0

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.characterEffect1013ui_story == nil then
				arg_207_1.var_.characterEffect1013ui_story = var_210_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_24 = 0.200000002980232

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_24 and not isNil(var_210_22) then
				local var_210_25 = (arg_207_1.time_ - var_210_23) / var_210_24

				if arg_207_1.var_.characterEffect1013ui_story and not isNil(var_210_22) then
					local var_210_26 = Mathf.Lerp(0, 0.5, var_210_25)

					arg_207_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1013ui_story.fillRatio = var_210_26
				end
			end

			if arg_207_1.time_ >= var_210_23 + var_210_24 and arg_207_1.time_ < var_210_23 + var_210_24 + arg_210_0 and not isNil(var_210_22) and arg_207_1.var_.characterEffect1013ui_story then
				local var_210_27 = 0.5

				arg_207_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1013ui_story.fillRatio = var_210_27
			end

			local var_210_28 = 0

			if var_210_28 < arg_207_1.time_ and arg_207_1.time_ <= var_210_28 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_210_29 = 0

			if var_210_29 < arg_207_1.time_ and arg_207_1.time_ <= var_210_29 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_210_30 = 0
			local var_210_31 = 0.475

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_32 = arg_207_1:FormatText(StoryNameCfg[6].name)

				arg_207_1.leftNameTxt_.text = var_210_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_33 = arg_207_1:GetWordFromCfg(304071050)
				local var_210_34 = arg_207_1:FormatText(var_210_33.content)

				arg_207_1.text_.text = var_210_34

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_35 = 19
				local var_210_36 = utf8.len(var_210_34)
				local var_210_37 = var_210_35 <= 0 and var_210_31 or var_210_31 * (var_210_36 / var_210_35)

				if var_210_37 > 0 and var_210_31 < var_210_37 then
					arg_207_1.talkMaxDuration = var_210_37

					if var_210_37 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_30
					end
				end

				arg_207_1.text_.text = var_210_34
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071050", "story_v_out_304071.awb") ~= 0 then
					local var_210_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071050", "story_v_out_304071.awb") / 1000

					if var_210_38 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_38 + var_210_30
					end

					if var_210_33.prefab_name ~= "" and arg_207_1.actors_[var_210_33.prefab_name] ~= nil then
						local var_210_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_33.prefab_name].transform, "story_v_out_304071", "304071050", "story_v_out_304071.awb")

						arg_207_1:RecordAudio("304071050", var_210_39)
						arg_207_1:RecordAudio("304071050", var_210_39)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_304071", "304071050", "story_v_out_304071.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_304071", "304071050", "story_v_out_304071.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_40 = math.max(var_210_31, arg_207_1.talkMaxDuration)

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_40 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_30) / var_210_40

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_30 + var_210_40 and arg_207_1.time_ < var_210_30 + var_210_40 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play304071051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 304071051
		arg_211_1.duration_ = 20.93

		local var_211_0 = {
			zh = 12.566,
			ja = 20.933
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play304071052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1013ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1013ui_story == nil then
				arg_211_1.var_.characterEffect1013ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1013ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1013ui_story then
				arg_211_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_214_4 = arg_211_1.actors_["1084ui_story"]
			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_6 and not isNil(var_214_4) then
				local var_214_7 = (arg_211_1.time_ - var_214_5) / var_214_6

				if arg_211_1.var_.characterEffect1084ui_story and not isNil(var_214_4) then
					local var_214_8 = Mathf.Lerp(0, 0.5, var_214_7)

					arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1084ui_story.fillRatio = var_214_8
				end
			end

			if arg_211_1.time_ >= var_214_5 + var_214_6 and arg_211_1.time_ < var_214_5 + var_214_6 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1084ui_story then
				local var_214_9 = 0.5

				arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1084ui_story.fillRatio = var_214_9
			end

			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action11_2")
			end

			local var_214_11 = 0
			local var_214_12 = 1.5

			if var_214_11 < arg_211_1.time_ and arg_211_1.time_ <= var_214_11 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_13 = arg_211_1:FormatText(StoryNameCfg[35].name)

				arg_211_1.leftNameTxt_.text = var_214_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_14 = arg_211_1:GetWordFromCfg(304071051)
				local var_214_15 = arg_211_1:FormatText(var_214_14.content)

				arg_211_1.text_.text = var_214_15

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_16 = 60
				local var_214_17 = utf8.len(var_214_15)
				local var_214_18 = var_214_16 <= 0 and var_214_12 or var_214_12 * (var_214_17 / var_214_16)

				if var_214_18 > 0 and var_214_12 < var_214_18 then
					arg_211_1.talkMaxDuration = var_214_18

					if var_214_18 + var_214_11 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_18 + var_214_11
					end
				end

				arg_211_1.text_.text = var_214_15
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071051", "story_v_out_304071.awb") ~= 0 then
					local var_214_19 = manager.audio:GetVoiceLength("story_v_out_304071", "304071051", "story_v_out_304071.awb") / 1000

					if var_214_19 + var_214_11 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_19 + var_214_11
					end

					if var_214_14.prefab_name ~= "" and arg_211_1.actors_[var_214_14.prefab_name] ~= nil then
						local var_214_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_14.prefab_name].transform, "story_v_out_304071", "304071051", "story_v_out_304071.awb")

						arg_211_1:RecordAudio("304071051", var_214_20)
						arg_211_1:RecordAudio("304071051", var_214_20)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_304071", "304071051", "story_v_out_304071.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_304071", "304071051", "story_v_out_304071.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_21 = math.max(var_214_12, arg_211_1.talkMaxDuration)

			if var_214_11 <= arg_211_1.time_ and arg_211_1.time_ < var_214_11 + var_214_21 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_11) / var_214_21

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_11 + var_214_21 and arg_211_1.time_ < var_214_11 + var_214_21 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play304071052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 304071052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play304071053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1084ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1084ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, 100, 0)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1084ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, 100, 0)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1013ui_story"].transform
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1.var_.moveOldPos1013ui_story = var_218_9.localPosition
			end

			local var_218_11 = 0.001

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11
				local var_218_13 = Vector3.New(0, 100, 0)

				var_218_9.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1013ui_story, var_218_13, var_218_12)

				local var_218_14 = manager.ui.mainCamera.transform.position - var_218_9.position

				var_218_9.forward = Vector3.New(var_218_14.x, var_218_14.y, var_218_14.z)

				local var_218_15 = var_218_9.localEulerAngles

				var_218_15.z = 0
				var_218_15.x = 0
				var_218_9.localEulerAngles = var_218_15
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 then
				var_218_9.localPosition = Vector3.New(0, 100, 0)

				local var_218_16 = manager.ui.mainCamera.transform.position - var_218_9.position

				var_218_9.forward = Vector3.New(var_218_16.x, var_218_16.y, var_218_16.z)

				local var_218_17 = var_218_9.localEulerAngles

				var_218_17.z = 0
				var_218_17.x = 0
				var_218_9.localEulerAngles = var_218_17
			end

			local var_218_18 = arg_215_1.actors_["1013ui_story"]
			local var_218_19 = 0

			if var_218_19 < arg_215_1.time_ and arg_215_1.time_ <= var_218_19 + arg_218_0 and not isNil(var_218_18) and arg_215_1.var_.characterEffect1013ui_story == nil then
				arg_215_1.var_.characterEffect1013ui_story = var_218_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_20 = 0.200000002980232

			if var_218_19 <= arg_215_1.time_ and arg_215_1.time_ < var_218_19 + var_218_20 and not isNil(var_218_18) then
				local var_218_21 = (arg_215_1.time_ - var_218_19) / var_218_20

				if arg_215_1.var_.characterEffect1013ui_story and not isNil(var_218_18) then
					local var_218_22 = Mathf.Lerp(0, 0.5, var_218_21)

					arg_215_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1013ui_story.fillRatio = var_218_22
				end
			end

			if arg_215_1.time_ >= var_218_19 + var_218_20 and arg_215_1.time_ < var_218_19 + var_218_20 + arg_218_0 and not isNil(var_218_18) and arg_215_1.var_.characterEffect1013ui_story then
				local var_218_23 = 0.5

				arg_215_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1013ui_story.fillRatio = var_218_23
			end

			local var_218_24 = 0
			local var_218_25 = 0.875

			if var_218_24 < arg_215_1.time_ and arg_215_1.time_ <= var_218_24 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_26 = arg_215_1:GetWordFromCfg(304071052)
				local var_218_27 = arg_215_1:FormatText(var_218_26.content)

				arg_215_1.text_.text = var_218_27

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_28 = 35
				local var_218_29 = utf8.len(var_218_27)
				local var_218_30 = var_218_28 <= 0 and var_218_25 or var_218_25 * (var_218_29 / var_218_28)

				if var_218_30 > 0 and var_218_25 < var_218_30 then
					arg_215_1.talkMaxDuration = var_218_30

					if var_218_30 + var_218_24 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_30 + var_218_24
					end
				end

				arg_215_1.text_.text = var_218_27
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_31 = math.max(var_218_25, arg_215_1.talkMaxDuration)

			if var_218_24 <= arg_215_1.time_ and arg_215_1.time_ < var_218_24 + var_218_31 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_24) / var_218_31

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_24 + var_218_31 and arg_215_1.time_ < var_218_24 + var_218_31 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play304071053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 304071053
		arg_219_1.duration_ = 2.37

		local var_219_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play304071054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1019ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1019ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1019ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1019ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1019ui_story == nil then
				arg_219_1.var_.characterEffect1019ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect1019ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1019ui_story then
				arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_15 = 0
			local var_222_16 = 0.15

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_17 = arg_219_1:FormatText(StoryNameCfg[13].name)

				arg_219_1.leftNameTxt_.text = var_222_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_18 = arg_219_1:GetWordFromCfg(304071053)
				local var_222_19 = arg_219_1:FormatText(var_222_18.content)

				arg_219_1.text_.text = var_222_19

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_20 = 6
				local var_222_21 = utf8.len(var_222_19)
				local var_222_22 = var_222_20 <= 0 and var_222_16 or var_222_16 * (var_222_21 / var_222_20)

				if var_222_22 > 0 and var_222_16 < var_222_22 then
					arg_219_1.talkMaxDuration = var_222_22

					if var_222_22 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_22 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_19
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071053", "story_v_out_304071.awb") ~= 0 then
					local var_222_23 = manager.audio:GetVoiceLength("story_v_out_304071", "304071053", "story_v_out_304071.awb") / 1000

					if var_222_23 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_15
					end

					if var_222_18.prefab_name ~= "" and arg_219_1.actors_[var_222_18.prefab_name] ~= nil then
						local var_222_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_18.prefab_name].transform, "story_v_out_304071", "304071053", "story_v_out_304071.awb")

						arg_219_1:RecordAudio("304071053", var_222_24)
						arg_219_1:RecordAudio("304071053", var_222_24)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_304071", "304071053", "story_v_out_304071.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_304071", "304071053", "story_v_out_304071.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_25 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_25 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_25

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_25 and arg_219_1.time_ < var_222_15 + var_222_25 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play304071054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 304071054
		arg_223_1.duration_ = 7.43

		local var_223_0 = {
			zh = 7.433,
			ja = 5.666
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play304071055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1013ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1013ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, -0.66, -6.15)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1013ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1019ui_story"].transform
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1.var_.moveOldPos1019ui_story = var_226_9.localPosition
			end

			local var_226_11 = 0.001

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11
				local var_226_13 = Vector3.New(0, 100, 0)

				var_226_9.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1019ui_story, var_226_13, var_226_12)

				local var_226_14 = manager.ui.mainCamera.transform.position - var_226_9.position

				var_226_9.forward = Vector3.New(var_226_14.x, var_226_14.y, var_226_14.z)

				local var_226_15 = var_226_9.localEulerAngles

				var_226_15.z = 0
				var_226_15.x = 0
				var_226_9.localEulerAngles = var_226_15
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 then
				var_226_9.localPosition = Vector3.New(0, 100, 0)

				local var_226_16 = manager.ui.mainCamera.transform.position - var_226_9.position

				var_226_9.forward = Vector3.New(var_226_16.x, var_226_16.y, var_226_16.z)

				local var_226_17 = var_226_9.localEulerAngles

				var_226_17.z = 0
				var_226_17.x = 0
				var_226_9.localEulerAngles = var_226_17
			end

			local var_226_18 = arg_223_1.actors_["1013ui_story"]
			local var_226_19 = 0

			if var_226_19 < arg_223_1.time_ and arg_223_1.time_ <= var_226_19 + arg_226_0 and not isNil(var_226_18) and arg_223_1.var_.characterEffect1013ui_story == nil then
				arg_223_1.var_.characterEffect1013ui_story = var_226_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_20 = 0.200000002980232

			if var_226_19 <= arg_223_1.time_ and arg_223_1.time_ < var_226_19 + var_226_20 and not isNil(var_226_18) then
				local var_226_21 = (arg_223_1.time_ - var_226_19) / var_226_20

				if arg_223_1.var_.characterEffect1013ui_story and not isNil(var_226_18) then
					arg_223_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_19 + var_226_20 and arg_223_1.time_ < var_226_19 + var_226_20 + arg_226_0 and not isNil(var_226_18) and arg_223_1.var_.characterEffect1013ui_story then
				arg_223_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_226_22 = arg_223_1.actors_["1019ui_story"]
			local var_226_23 = 0

			if var_226_23 < arg_223_1.time_ and arg_223_1.time_ <= var_226_23 + arg_226_0 and not isNil(var_226_22) and arg_223_1.var_.characterEffect1019ui_story == nil then
				arg_223_1.var_.characterEffect1019ui_story = var_226_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_24 = 0.200000002980232

			if var_226_23 <= arg_223_1.time_ and arg_223_1.time_ < var_226_23 + var_226_24 and not isNil(var_226_22) then
				local var_226_25 = (arg_223_1.time_ - var_226_23) / var_226_24

				if arg_223_1.var_.characterEffect1019ui_story and not isNil(var_226_22) then
					local var_226_26 = Mathf.Lerp(0, 0.5, var_226_25)

					arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1019ui_story.fillRatio = var_226_26
				end
			end

			if arg_223_1.time_ >= var_226_23 + var_226_24 and arg_223_1.time_ < var_226_23 + var_226_24 + arg_226_0 and not isNil(var_226_22) and arg_223_1.var_.characterEffect1019ui_story then
				local var_226_27 = 0.5

				arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1019ui_story.fillRatio = var_226_27
			end

			local var_226_28 = 0

			if var_226_28 < arg_223_1.time_ and arg_223_1.time_ <= var_226_28 + arg_226_0 then
				arg_223_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action2_1")
			end

			local var_226_29 = 0

			if var_226_29 < arg_223_1.time_ and arg_223_1.time_ <= var_226_29 + arg_226_0 then
				arg_223_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_226_30 = 0
			local var_226_31 = 0.75

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_32 = arg_223_1:FormatText(StoryNameCfg[35].name)

				arg_223_1.leftNameTxt_.text = var_226_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_33 = arg_223_1:GetWordFromCfg(304071054)
				local var_226_34 = arg_223_1:FormatText(var_226_33.content)

				arg_223_1.text_.text = var_226_34

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_35 = 30
				local var_226_36 = utf8.len(var_226_34)
				local var_226_37 = var_226_35 <= 0 and var_226_31 or var_226_31 * (var_226_36 / var_226_35)

				if var_226_37 > 0 and var_226_31 < var_226_37 then
					arg_223_1.talkMaxDuration = var_226_37

					if var_226_37 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_37 + var_226_30
					end
				end

				arg_223_1.text_.text = var_226_34
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071054", "story_v_out_304071.awb") ~= 0 then
					local var_226_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071054", "story_v_out_304071.awb") / 1000

					if var_226_38 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_38 + var_226_30
					end

					if var_226_33.prefab_name ~= "" and arg_223_1.actors_[var_226_33.prefab_name] ~= nil then
						local var_226_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_33.prefab_name].transform, "story_v_out_304071", "304071054", "story_v_out_304071.awb")

						arg_223_1:RecordAudio("304071054", var_226_39)
						arg_223_1:RecordAudio("304071054", var_226_39)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_304071", "304071054", "story_v_out_304071.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_304071", "304071054", "story_v_out_304071.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_40 = math.max(var_226_31, arg_223_1.talkMaxDuration)

			if var_226_30 <= arg_223_1.time_ and arg_223_1.time_ < var_226_30 + var_226_40 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_30) / var_226_40

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_30 + var_226_40 and arg_223_1.time_ < var_226_30 + var_226_40 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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

		arg_223_1:InitPlayNodeList()
	end,
	Play304071055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 304071055
		arg_227_1.duration_ = 3.4

		local var_227_0 = {
			zh = 3.4,
			ja = 1.999999999999
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
				arg_227_0:Play304071056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1084ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1084ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(-0.7, -0.97, -6)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1084ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1013ui_story"].transform
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1.var_.moveOldPos1013ui_story = var_230_9.localPosition
			end

			local var_230_11 = 0.001

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11
				local var_230_13 = Vector3.New(0, 100, 0)

				var_230_9.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1013ui_story, var_230_13, var_230_12)

				local var_230_14 = manager.ui.mainCamera.transform.position - var_230_9.position

				var_230_9.forward = Vector3.New(var_230_14.x, var_230_14.y, var_230_14.z)

				local var_230_15 = var_230_9.localEulerAngles

				var_230_15.z = 0
				var_230_15.x = 0
				var_230_9.localEulerAngles = var_230_15
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 then
				var_230_9.localPosition = Vector3.New(0, 100, 0)

				local var_230_16 = manager.ui.mainCamera.transform.position - var_230_9.position

				var_230_9.forward = Vector3.New(var_230_16.x, var_230_16.y, var_230_16.z)

				local var_230_17 = var_230_9.localEulerAngles

				var_230_17.z = 0
				var_230_17.x = 0
				var_230_9.localEulerAngles = var_230_17
			end

			local var_230_18 = arg_227_1.actors_["1084ui_story"]
			local var_230_19 = 0

			if var_230_19 < arg_227_1.time_ and arg_227_1.time_ <= var_230_19 + arg_230_0 and not isNil(var_230_18) and arg_227_1.var_.characterEffect1084ui_story == nil then
				arg_227_1.var_.characterEffect1084ui_story = var_230_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_20 = 0.200000002980232

			if var_230_19 <= arg_227_1.time_ and arg_227_1.time_ < var_230_19 + var_230_20 and not isNil(var_230_18) then
				local var_230_21 = (arg_227_1.time_ - var_230_19) / var_230_20

				if arg_227_1.var_.characterEffect1084ui_story and not isNil(var_230_18) then
					arg_227_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_19 + var_230_20 and arg_227_1.time_ < var_230_19 + var_230_20 + arg_230_0 and not isNil(var_230_18) and arg_227_1.var_.characterEffect1084ui_story then
				arg_227_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_230_22 = arg_227_1.actors_["1013ui_story"]
			local var_230_23 = 0

			if var_230_23 < arg_227_1.time_ and arg_227_1.time_ <= var_230_23 + arg_230_0 and not isNil(var_230_22) and arg_227_1.var_.characterEffect1013ui_story == nil then
				arg_227_1.var_.characterEffect1013ui_story = var_230_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_24 = 0.200000002980232

			if var_230_23 <= arg_227_1.time_ and arg_227_1.time_ < var_230_23 + var_230_24 and not isNil(var_230_22) then
				local var_230_25 = (arg_227_1.time_ - var_230_23) / var_230_24

				if arg_227_1.var_.characterEffect1013ui_story and not isNil(var_230_22) then
					local var_230_26 = Mathf.Lerp(0, 0.5, var_230_25)

					arg_227_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1013ui_story.fillRatio = var_230_26
				end
			end

			if arg_227_1.time_ >= var_230_23 + var_230_24 and arg_227_1.time_ < var_230_23 + var_230_24 + arg_230_0 and not isNil(var_230_22) and arg_227_1.var_.characterEffect1013ui_story then
				local var_230_27 = 0.5

				arg_227_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1013ui_story.fillRatio = var_230_27
			end

			local var_230_28 = 0

			if var_230_28 < arg_227_1.time_ and arg_227_1.time_ <= var_230_28 + arg_230_0 then
				arg_227_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			local var_230_29 = 0

			if var_230_29 < arg_227_1.time_ and arg_227_1.time_ <= var_230_29 + arg_230_0 then
				arg_227_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_230_30 = 0
			local var_230_31 = 0.325

			if var_230_30 < arg_227_1.time_ and arg_227_1.time_ <= var_230_30 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_32 = arg_227_1:FormatText(StoryNameCfg[6].name)

				arg_227_1.leftNameTxt_.text = var_230_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_33 = arg_227_1:GetWordFromCfg(304071055)
				local var_230_34 = arg_227_1:FormatText(var_230_33.content)

				arg_227_1.text_.text = var_230_34

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_35 = 13
				local var_230_36 = utf8.len(var_230_34)
				local var_230_37 = var_230_35 <= 0 and var_230_31 or var_230_31 * (var_230_36 / var_230_35)

				if var_230_37 > 0 and var_230_31 < var_230_37 then
					arg_227_1.talkMaxDuration = var_230_37

					if var_230_37 + var_230_30 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_37 + var_230_30
					end
				end

				arg_227_1.text_.text = var_230_34
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071055", "story_v_out_304071.awb") ~= 0 then
					local var_230_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071055", "story_v_out_304071.awb") / 1000

					if var_230_38 + var_230_30 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_38 + var_230_30
					end

					if var_230_33.prefab_name ~= "" and arg_227_1.actors_[var_230_33.prefab_name] ~= nil then
						local var_230_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_33.prefab_name].transform, "story_v_out_304071", "304071055", "story_v_out_304071.awb")

						arg_227_1:RecordAudio("304071055", var_230_39)
						arg_227_1:RecordAudio("304071055", var_230_39)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_304071", "304071055", "story_v_out_304071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_304071", "304071055", "story_v_out_304071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_40 = math.max(var_230_31, arg_227_1.talkMaxDuration)

			if var_230_30 <= arg_227_1.time_ and arg_227_1.time_ < var_230_30 + var_230_40 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_30) / var_230_40

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_30 + var_230_40 and arg_227_1.time_ < var_230_30 + var_230_40 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
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
	Play304071056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 304071056
		arg_231_1.duration_ = 5.57

		local var_231_0 = {
			zh = 3.033,
			ja = 5.566
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play304071057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1011ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1011ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0.7, -0.71, -6)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1011ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["1011ui_story"]
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1011ui_story == nil then
				arg_231_1.var_.characterEffect1011ui_story = var_234_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_11 = 0.200000002980232

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 and not isNil(var_234_9) then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11

				if arg_231_1.var_.characterEffect1011ui_story and not isNil(var_234_9) then
					arg_231_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1011ui_story then
				arg_231_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_234_13 = arg_231_1.actors_["1084ui_story"]
			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 and not isNil(var_234_13) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_15 = 0.200000002980232

			if var_234_14 <= arg_231_1.time_ and arg_231_1.time_ < var_234_14 + var_234_15 and not isNil(var_234_13) then
				local var_234_16 = (arg_231_1.time_ - var_234_14) / var_234_15

				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_13) then
					local var_234_17 = Mathf.Lerp(0, 0.5, var_234_16)

					arg_231_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1084ui_story.fillRatio = var_234_17
				end
			end

			if arg_231_1.time_ >= var_234_14 + var_234_15 and arg_231_1.time_ < var_234_14 + var_234_15 + arg_234_0 and not isNil(var_234_13) and arg_231_1.var_.characterEffect1084ui_story then
				local var_234_18 = 0.5

				arg_231_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1084ui_story.fillRatio = var_234_18
			end

			local var_234_19 = 0

			if var_234_19 < arg_231_1.time_ and arg_231_1.time_ <= var_234_19 + arg_234_0 then
				arg_231_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_234_20 = 0

			if var_234_20 < arg_231_1.time_ and arg_231_1.time_ <= var_234_20 + arg_234_0 then
				arg_231_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_234_21 = 0
			local var_234_22 = 0.375

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_23 = arg_231_1:FormatText(StoryNameCfg[37].name)

				arg_231_1.leftNameTxt_.text = var_234_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_24 = arg_231_1:GetWordFromCfg(304071056)
				local var_234_25 = arg_231_1:FormatText(var_234_24.content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_26 = 15
				local var_234_27 = utf8.len(var_234_25)
				local var_234_28 = var_234_26 <= 0 and var_234_22 or var_234_22 * (var_234_27 / var_234_26)

				if var_234_28 > 0 and var_234_22 < var_234_28 then
					arg_231_1.talkMaxDuration = var_234_28

					if var_234_28 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_21
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071056", "story_v_out_304071.awb") ~= 0 then
					local var_234_29 = manager.audio:GetVoiceLength("story_v_out_304071", "304071056", "story_v_out_304071.awb") / 1000

					if var_234_29 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_29 + var_234_21
					end

					if var_234_24.prefab_name ~= "" and arg_231_1.actors_[var_234_24.prefab_name] ~= nil then
						local var_234_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_24.prefab_name].transform, "story_v_out_304071", "304071056", "story_v_out_304071.awb")

						arg_231_1:RecordAudio("304071056", var_234_30)
						arg_231_1:RecordAudio("304071056", var_234_30)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_304071", "304071056", "story_v_out_304071.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_304071", "304071056", "story_v_out_304071.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_31 = math.max(var_234_22, arg_231_1.talkMaxDuration)

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_21) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_21 + var_234_31 and arg_231_1.time_ < var_234_21 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play304071057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 304071057
		arg_235_1.duration_ = 7.97

		local var_235_0 = {
			zh = 7.966,
			ja = 1.999999999999
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play304071058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1084ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1084ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1084ui_story then
				arg_235_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["1011ui_story"]
			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1011ui_story == nil then
				arg_235_1.var_.characterEffect1011ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.200000002980232

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 and not isNil(var_238_4) then
				local var_238_7 = (arg_235_1.time_ - var_238_5) / var_238_6

				if arg_235_1.var_.characterEffect1011ui_story and not isNil(var_238_4) then
					local var_238_8 = Mathf.Lerp(0, 0.5, var_238_7)

					arg_235_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1011ui_story.fillRatio = var_238_8
				end
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1011ui_story then
				local var_238_9 = 0.5

				arg_235_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1011ui_story.fillRatio = var_238_9
			end

			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			local var_238_11 = 0
			local var_238_12 = 0.625

			if var_238_11 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_13 = arg_235_1:FormatText(StoryNameCfg[6].name)

				arg_235_1.leftNameTxt_.text = var_238_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_14 = arg_235_1:GetWordFromCfg(304071057)
				local var_238_15 = arg_235_1:FormatText(var_238_14.content)

				arg_235_1.text_.text = var_238_15

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_16 = 25
				local var_238_17 = utf8.len(var_238_15)
				local var_238_18 = var_238_16 <= 0 and var_238_12 or var_238_12 * (var_238_17 / var_238_16)

				if var_238_18 > 0 and var_238_12 < var_238_18 then
					arg_235_1.talkMaxDuration = var_238_18

					if var_238_18 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_11
					end
				end

				arg_235_1.text_.text = var_238_15
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071057", "story_v_out_304071.awb") ~= 0 then
					local var_238_19 = manager.audio:GetVoiceLength("story_v_out_304071", "304071057", "story_v_out_304071.awb") / 1000

					if var_238_19 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_19 + var_238_11
					end

					if var_238_14.prefab_name ~= "" and arg_235_1.actors_[var_238_14.prefab_name] ~= nil then
						local var_238_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_14.prefab_name].transform, "story_v_out_304071", "304071057", "story_v_out_304071.awb")

						arg_235_1:RecordAudio("304071057", var_238_20)
						arg_235_1:RecordAudio("304071057", var_238_20)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_304071", "304071057", "story_v_out_304071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_304071", "304071057", "story_v_out_304071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_21 = math.max(var_238_12, arg_235_1.talkMaxDuration)

			if var_238_11 <= arg_235_1.time_ and arg_235_1.time_ < var_238_11 + var_238_21 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_11) / var_238_21

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_11 + var_238_21 and arg_235_1.time_ < var_238_11 + var_238_21 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play304071058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 304071058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play304071059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1084ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1084ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, 100, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1084ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, 100, 0)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1011ui_story"].transform
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1.var_.moveOldPos1011ui_story = var_242_9.localPosition
			end

			local var_242_11 = 0.001

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11
				local var_242_13 = Vector3.New(0, 100, 0)

				var_242_9.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1011ui_story, var_242_13, var_242_12)

				local var_242_14 = manager.ui.mainCamera.transform.position - var_242_9.position

				var_242_9.forward = Vector3.New(var_242_14.x, var_242_14.y, var_242_14.z)

				local var_242_15 = var_242_9.localEulerAngles

				var_242_15.z = 0
				var_242_15.x = 0
				var_242_9.localEulerAngles = var_242_15
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 then
				var_242_9.localPosition = Vector3.New(0, 100, 0)

				local var_242_16 = manager.ui.mainCamera.transform.position - var_242_9.position

				var_242_9.forward = Vector3.New(var_242_16.x, var_242_16.y, var_242_16.z)

				local var_242_17 = var_242_9.localEulerAngles

				var_242_17.z = 0
				var_242_17.x = 0
				var_242_9.localEulerAngles = var_242_17
			end

			local var_242_18 = arg_239_1.actors_["1084ui_story"]
			local var_242_19 = 0

			if var_242_19 < arg_239_1.time_ and arg_239_1.time_ <= var_242_19 + arg_242_0 and not isNil(var_242_18) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = var_242_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_20 = 0.200000002980232

			if var_242_19 <= arg_239_1.time_ and arg_239_1.time_ < var_242_19 + var_242_20 and not isNil(var_242_18) then
				local var_242_21 = (arg_239_1.time_ - var_242_19) / var_242_20

				if arg_239_1.var_.characterEffect1084ui_story and not isNil(var_242_18) then
					local var_242_22 = Mathf.Lerp(0, 0.5, var_242_21)

					arg_239_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1084ui_story.fillRatio = var_242_22
				end
			end

			if arg_239_1.time_ >= var_242_19 + var_242_20 and arg_239_1.time_ < var_242_19 + var_242_20 + arg_242_0 and not isNil(var_242_18) and arg_239_1.var_.characterEffect1084ui_story then
				local var_242_23 = 0.5

				arg_239_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1084ui_story.fillRatio = var_242_23
			end

			local var_242_24 = 0
			local var_242_25 = 1.375

			if var_242_24 < arg_239_1.time_ and arg_239_1.time_ <= var_242_24 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_26 = arg_239_1:GetWordFromCfg(304071058)
				local var_242_27 = arg_239_1:FormatText(var_242_26.content)

				arg_239_1.text_.text = var_242_27

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_28 = 55
				local var_242_29 = utf8.len(var_242_27)
				local var_242_30 = var_242_28 <= 0 and var_242_25 or var_242_25 * (var_242_29 / var_242_28)

				if var_242_30 > 0 and var_242_25 < var_242_30 then
					arg_239_1.talkMaxDuration = var_242_30

					if var_242_30 + var_242_24 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_30 + var_242_24
					end
				end

				arg_239_1.text_.text = var_242_27
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_31 = math.max(var_242_25, arg_239_1.talkMaxDuration)

			if var_242_24 <= arg_239_1.time_ and arg_239_1.time_ < var_242_24 + var_242_31 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_24) / var_242_31

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_24 + var_242_31 and arg_239_1.time_ < var_242_24 + var_242_31 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play304071059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 304071059
		arg_243_1.duration_ = 7.37

		local var_243_0 = {
			zh = 5.933,
			ja = 7.366
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play304071060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1019ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1019ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1019ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1019ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1019ui_story == nil then
				arg_243_1.var_.characterEffect1019ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1019ui_story and not isNil(var_246_9) then
					arg_243_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1019ui_story then
				arg_243_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_246_13 = 0

			if var_246_13 < arg_243_1.time_ and arg_243_1.time_ <= var_246_13 + arg_246_0 then
				arg_243_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_15 = 0
			local var_246_16 = 0.75

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[13].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(304071059)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 30
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071059", "story_v_out_304071.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_304071", "304071059", "story_v_out_304071.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_304071", "304071059", "story_v_out_304071.awb")

						arg_243_1:RecordAudio("304071059", var_246_24)
						arg_243_1:RecordAudio("304071059", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_304071", "304071059", "story_v_out_304071.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_304071", "304071059", "story_v_out_304071.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play304071060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 304071060
		arg_247_1.duration_ = 8.3

		local var_247_0 = {
			zh = 5.833,
			ja = 8.3
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play304071061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1013ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1013ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0.7, -0.66, -6.15)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1013ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1013ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1013ui_story == nil then
				arg_247_1.var_.characterEffect1013ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1013ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1013ui_story then
				arg_247_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_250_13 = arg_247_1.actors_["1019ui_story"]
			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect1019ui_story == nil then
				arg_247_1.var_.characterEffect1019ui_story = var_250_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_15 = 0.200000002980232

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_15 and not isNil(var_250_13) then
				local var_250_16 = (arg_247_1.time_ - var_250_14) / var_250_15

				if arg_247_1.var_.characterEffect1019ui_story and not isNil(var_250_13) then
					local var_250_17 = Mathf.Lerp(0, 0.5, var_250_16)

					arg_247_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1019ui_story.fillRatio = var_250_17
				end
			end

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect1019ui_story then
				local var_250_18 = 0.5

				arg_247_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1019ui_story.fillRatio = var_250_18
			end

			local var_250_19 = 0

			if var_250_19 < arg_247_1.time_ and arg_247_1.time_ <= var_250_19 + arg_250_0 then
				arg_247_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action2_2")
			end

			local var_250_20 = 0

			if var_250_20 < arg_247_1.time_ and arg_247_1.time_ <= var_250_20 + arg_250_0 then
				arg_247_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_250_21 = 0
			local var_250_22 = 0.525

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_23 = arg_247_1:FormatText(StoryNameCfg[35].name)

				arg_247_1.leftNameTxt_.text = var_250_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_24 = arg_247_1:GetWordFromCfg(304071060)
				local var_250_25 = arg_247_1:FormatText(var_250_24.content)

				arg_247_1.text_.text = var_250_25

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_26 = 21
				local var_250_27 = utf8.len(var_250_25)
				local var_250_28 = var_250_26 <= 0 and var_250_22 or var_250_22 * (var_250_27 / var_250_26)

				if var_250_28 > 0 and var_250_22 < var_250_28 then
					arg_247_1.talkMaxDuration = var_250_28

					if var_250_28 + var_250_21 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_28 + var_250_21
					end
				end

				arg_247_1.text_.text = var_250_25
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071060", "story_v_out_304071.awb") ~= 0 then
					local var_250_29 = manager.audio:GetVoiceLength("story_v_out_304071", "304071060", "story_v_out_304071.awb") / 1000

					if var_250_29 + var_250_21 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_29 + var_250_21
					end

					if var_250_24.prefab_name ~= "" and arg_247_1.actors_[var_250_24.prefab_name] ~= nil then
						local var_250_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_24.prefab_name].transform, "story_v_out_304071", "304071060", "story_v_out_304071.awb")

						arg_247_1:RecordAudio("304071060", var_250_30)
						arg_247_1:RecordAudio("304071060", var_250_30)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_304071", "304071060", "story_v_out_304071.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_304071", "304071060", "story_v_out_304071.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_31 = math.max(var_250_22, arg_247_1.talkMaxDuration)

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_31 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_21) / var_250_31

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_21 + var_250_31 and arg_247_1.time_ < var_250_21 + var_250_31 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play304071061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 304071061
		arg_251_1.duration_ = 9.33

		local var_251_0 = {
			zh = 8.1,
			ja = 9.333
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play304071062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 1.05

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[35].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:GetWordFromCfg(304071061)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 42
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071061", "story_v_out_304071.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071061", "story_v_out_304071.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_304071", "304071061", "story_v_out_304071.awb")

						arg_251_1:RecordAudio("304071061", var_254_9)
						arg_251_1:RecordAudio("304071061", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_304071", "304071061", "story_v_out_304071.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_304071", "304071061", "story_v_out_304071.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play304071062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 304071062
		arg_255_1.duration_ = 3.97

		local var_255_0 = {
			zh = 3.066,
			ja = 3.966
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play304071063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1019ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1019ui_story == nil then
				arg_255_1.var_.characterEffect1019ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1019ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1019ui_story then
				arg_255_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["1013ui_story"]
			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1013ui_story == nil then
				arg_255_1.var_.characterEffect1013ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_6 = 0.200000002980232

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_6 and not isNil(var_258_4) then
				local var_258_7 = (arg_255_1.time_ - var_258_5) / var_258_6

				if arg_255_1.var_.characterEffect1013ui_story and not isNil(var_258_4) then
					local var_258_8 = Mathf.Lerp(0, 0.5, var_258_7)

					arg_255_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1013ui_story.fillRatio = var_258_8
				end
			end

			if arg_255_1.time_ >= var_258_5 + var_258_6 and arg_255_1.time_ < var_258_5 + var_258_6 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1013ui_story then
				local var_258_9 = 0.5

				arg_255_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1013ui_story.fillRatio = var_258_9
			end

			local var_258_10 = 0
			local var_258_11 = 0.375

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_12 = arg_255_1:FormatText(StoryNameCfg[13].name)

				arg_255_1.leftNameTxt_.text = var_258_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(304071062)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 15
				local var_258_16 = utf8.len(var_258_14)
				local var_258_17 = var_258_15 <= 0 and var_258_11 or var_258_11 * (var_258_16 / var_258_15)

				if var_258_17 > 0 and var_258_11 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_10
					end
				end

				arg_255_1.text_.text = var_258_14
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071062", "story_v_out_304071.awb") ~= 0 then
					local var_258_18 = manager.audio:GetVoiceLength("story_v_out_304071", "304071062", "story_v_out_304071.awb") / 1000

					if var_258_18 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_10
					end

					if var_258_13.prefab_name ~= "" and arg_255_1.actors_[var_258_13.prefab_name] ~= nil then
						local var_258_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_13.prefab_name].transform, "story_v_out_304071", "304071062", "story_v_out_304071.awb")

						arg_255_1:RecordAudio("304071062", var_258_19)
						arg_255_1:RecordAudio("304071062", var_258_19)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_304071", "304071062", "story_v_out_304071.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_304071", "304071062", "story_v_out_304071.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_20 = math.max(var_258_11, arg_255_1.talkMaxDuration)

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_20 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_10) / var_258_20

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_10 + var_258_20 and arg_255_1.time_ < var_258_10 + var_258_20 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play304071063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 304071063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play304071064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1019ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1019ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(0, 100, 0)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1019ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, 100, 0)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["1013ui_story"].transform
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.var_.moveOldPos1013ui_story = var_262_9.localPosition
			end

			local var_262_11 = 0.001

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11
				local var_262_13 = Vector3.New(0, 100, 0)

				var_262_9.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1013ui_story, var_262_13, var_262_12)

				local var_262_14 = manager.ui.mainCamera.transform.position - var_262_9.position

				var_262_9.forward = Vector3.New(var_262_14.x, var_262_14.y, var_262_14.z)

				local var_262_15 = var_262_9.localEulerAngles

				var_262_15.z = 0
				var_262_15.x = 0
				var_262_9.localEulerAngles = var_262_15
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 then
				var_262_9.localPosition = Vector3.New(0, 100, 0)

				local var_262_16 = manager.ui.mainCamera.transform.position - var_262_9.position

				var_262_9.forward = Vector3.New(var_262_16.x, var_262_16.y, var_262_16.z)

				local var_262_17 = var_262_9.localEulerAngles

				var_262_17.z = 0
				var_262_17.x = 0
				var_262_9.localEulerAngles = var_262_17
			end

			local var_262_18 = arg_259_1.actors_["1019ui_story"]
			local var_262_19 = 0

			if var_262_19 < arg_259_1.time_ and arg_259_1.time_ <= var_262_19 + arg_262_0 and not isNil(var_262_18) and arg_259_1.var_.characterEffect1019ui_story == nil then
				arg_259_1.var_.characterEffect1019ui_story = var_262_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_20 = 0.200000002980232

			if var_262_19 <= arg_259_1.time_ and arg_259_1.time_ < var_262_19 + var_262_20 and not isNil(var_262_18) then
				local var_262_21 = (arg_259_1.time_ - var_262_19) / var_262_20

				if arg_259_1.var_.characterEffect1019ui_story and not isNil(var_262_18) then
					local var_262_22 = Mathf.Lerp(0, 0.5, var_262_21)

					arg_259_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1019ui_story.fillRatio = var_262_22
				end
			end

			if arg_259_1.time_ >= var_262_19 + var_262_20 and arg_259_1.time_ < var_262_19 + var_262_20 + arg_262_0 and not isNil(var_262_18) and arg_259_1.var_.characterEffect1019ui_story then
				local var_262_23 = 0.5

				arg_259_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1019ui_story.fillRatio = var_262_23
			end

			local var_262_24 = 0
			local var_262_25 = 0.9

			if var_262_24 < arg_259_1.time_ and arg_259_1.time_ <= var_262_24 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_26 = arg_259_1:GetWordFromCfg(304071063)
				local var_262_27 = arg_259_1:FormatText(var_262_26.content)

				arg_259_1.text_.text = var_262_27

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_28 = 36
				local var_262_29 = utf8.len(var_262_27)
				local var_262_30 = var_262_28 <= 0 and var_262_25 or var_262_25 * (var_262_29 / var_262_28)

				if var_262_30 > 0 and var_262_25 < var_262_30 then
					arg_259_1.talkMaxDuration = var_262_30

					if var_262_30 + var_262_24 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_30 + var_262_24
					end
				end

				arg_259_1.text_.text = var_262_27
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_31 = math.max(var_262_25, arg_259_1.talkMaxDuration)

			if var_262_24 <= arg_259_1.time_ and arg_259_1.time_ < var_262_24 + var_262_31 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_24) / var_262_31

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_24 + var_262_31 and arg_259_1.time_ < var_262_24 + var_262_31 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play304071064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 304071064
		arg_263_1.duration_ = 9.07

		local var_263_0 = {
			zh = 6.266,
			ja = 9.066
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play304071065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1013ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1013ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, -0.66, -6.15)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1013ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1013ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1013ui_story == nil then
				arg_263_1.var_.characterEffect1013ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1013ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1013ui_story then
				arg_263_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_266_15 = 0
			local var_266_16 = 0.525

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[35].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(304071064)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 21
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071064", "story_v_out_304071.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_304071", "304071064", "story_v_out_304071.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_304071", "304071064", "story_v_out_304071.awb")

						arg_263_1:RecordAudio("304071064", var_266_24)
						arg_263_1:RecordAudio("304071064", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_304071", "304071064", "story_v_out_304071.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_304071", "304071064", "story_v_out_304071.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play304071065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 304071065
		arg_267_1.duration_ = 1.63

		local var_267_0 = {
			zh = 1.6,
			ja = 1.633
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play304071066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1019ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1019ui_story == nil then
				arg_267_1.var_.characterEffect1019ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1019ui_story and not isNil(var_270_0) then
					arg_267_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1019ui_story then
				arg_267_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["1013ui_story"]
			local var_270_5 = 0

			if var_270_5 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect1013ui_story == nil then
				arg_267_1.var_.characterEffect1013ui_story = var_270_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_6 = 0.200000002980232

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 and not isNil(var_270_4) then
				local var_270_7 = (arg_267_1.time_ - var_270_5) / var_270_6

				if arg_267_1.var_.characterEffect1013ui_story and not isNil(var_270_4) then
					local var_270_8 = Mathf.Lerp(0, 0.5, var_270_7)

					arg_267_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1013ui_story.fillRatio = var_270_8
				end
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect1013ui_story then
				local var_270_9 = 0.5

				arg_267_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1013ui_story.fillRatio = var_270_9
			end

			local var_270_10 = 0
			local var_270_11 = 0.15

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_12 = arg_267_1:FormatText(StoryNameCfg[13].name)

				arg_267_1.leftNameTxt_.text = var_270_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_13 = arg_267_1:GetWordFromCfg(304071065)
				local var_270_14 = arg_267_1:FormatText(var_270_13.content)

				arg_267_1.text_.text = var_270_14

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_15 = 6
				local var_270_16 = utf8.len(var_270_14)
				local var_270_17 = var_270_15 <= 0 and var_270_11 or var_270_11 * (var_270_16 / var_270_15)

				if var_270_17 > 0 and var_270_11 < var_270_17 then
					arg_267_1.talkMaxDuration = var_270_17

					if var_270_17 + var_270_10 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_17 + var_270_10
					end
				end

				arg_267_1.text_.text = var_270_14
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071065", "story_v_out_304071.awb") ~= 0 then
					local var_270_18 = manager.audio:GetVoiceLength("story_v_out_304071", "304071065", "story_v_out_304071.awb") / 1000

					if var_270_18 + var_270_10 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_18 + var_270_10
					end

					if var_270_13.prefab_name ~= "" and arg_267_1.actors_[var_270_13.prefab_name] ~= nil then
						local var_270_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_13.prefab_name].transform, "story_v_out_304071", "304071065", "story_v_out_304071.awb")

						arg_267_1:RecordAudio("304071065", var_270_19)
						arg_267_1:RecordAudio("304071065", var_270_19)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_304071", "304071065", "story_v_out_304071.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_304071", "304071065", "story_v_out_304071.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_20 = math.max(var_270_11, arg_267_1.talkMaxDuration)

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_20 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_10) / var_270_20

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_10 + var_270_20 and arg_267_1.time_ < var_270_10 + var_270_20 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play304071066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 304071066
		arg_271_1.duration_ = 4.3

		local var_271_0 = {
			zh = 4.3,
			ja = 1.999999999999
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play304071067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1084ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1084ui_story = var_274_0.localPosition
			end

			local var_274_2 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2
				local var_274_4 = Vector3.New(-0.7, -0.97, -6)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1084ui_story, var_274_4, var_274_3)

				local var_274_5 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_5.x, var_274_5.y, var_274_5.z)

				local var_274_6 = var_274_0.localEulerAngles

				var_274_6.z = 0
				var_274_6.x = 0
				var_274_0.localEulerAngles = var_274_6
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_274_7 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_7.x, var_274_7.y, var_274_7.z)

				local var_274_8 = var_274_0.localEulerAngles

				var_274_8.z = 0
				var_274_8.x = 0
				var_274_0.localEulerAngles = var_274_8
			end

			local var_274_9 = arg_271_1.actors_["1084ui_story"]
			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1084ui_story == nil then
				arg_271_1.var_.characterEffect1084ui_story = var_274_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_11 and not isNil(var_274_9) then
				local var_274_12 = (arg_271_1.time_ - var_274_10) / var_274_11

				if arg_271_1.var_.characterEffect1084ui_story and not isNil(var_274_9) then
					arg_271_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_10 + var_274_11 and arg_271_1.time_ < var_274_10 + var_274_11 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1084ui_story then
				arg_271_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_274_13 = arg_271_1.actors_["1019ui_story"]
			local var_274_14 = 0

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 and not isNil(var_274_13) and arg_271_1.var_.characterEffect1019ui_story == nil then
				arg_271_1.var_.characterEffect1019ui_story = var_274_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_15 = 0.200000002980232

			if var_274_14 <= arg_271_1.time_ and arg_271_1.time_ < var_274_14 + var_274_15 and not isNil(var_274_13) then
				local var_274_16 = (arg_271_1.time_ - var_274_14) / var_274_15

				if arg_271_1.var_.characterEffect1019ui_story and not isNil(var_274_13) then
					local var_274_17 = Mathf.Lerp(0, 0.5, var_274_16)

					arg_271_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1019ui_story.fillRatio = var_274_17
				end
			end

			if arg_271_1.time_ >= var_274_14 + var_274_15 and arg_271_1.time_ < var_274_14 + var_274_15 + arg_274_0 and not isNil(var_274_13) and arg_271_1.var_.characterEffect1019ui_story then
				local var_274_18 = 0.5

				arg_271_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1019ui_story.fillRatio = var_274_18
			end

			local var_274_19 = 0

			if var_274_19 < arg_271_1.time_ and arg_271_1.time_ <= var_274_19 + arg_274_0 then
				arg_271_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_274_20 = 0

			if var_274_20 < arg_271_1.time_ and arg_271_1.time_ <= var_274_20 + arg_274_0 then
				arg_271_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_274_21 = arg_271_1.actors_["1013ui_story"].transform
			local var_274_22 = 0

			if var_274_22 < arg_271_1.time_ and arg_271_1.time_ <= var_274_22 + arg_274_0 then
				arg_271_1.var_.moveOldPos1013ui_story = var_274_21.localPosition
			end

			local var_274_23 = 0.001

			if var_274_22 <= arg_271_1.time_ and arg_271_1.time_ < var_274_22 + var_274_23 then
				local var_274_24 = (arg_271_1.time_ - var_274_22) / var_274_23
				local var_274_25 = Vector3.New(0, 100, 0)

				var_274_21.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1013ui_story, var_274_25, var_274_24)

				local var_274_26 = manager.ui.mainCamera.transform.position - var_274_21.position

				var_274_21.forward = Vector3.New(var_274_26.x, var_274_26.y, var_274_26.z)

				local var_274_27 = var_274_21.localEulerAngles

				var_274_27.z = 0
				var_274_27.x = 0
				var_274_21.localEulerAngles = var_274_27
			end

			if arg_271_1.time_ >= var_274_22 + var_274_23 and arg_271_1.time_ < var_274_22 + var_274_23 + arg_274_0 then
				var_274_21.localPosition = Vector3.New(0, 100, 0)

				local var_274_28 = manager.ui.mainCamera.transform.position - var_274_21.position

				var_274_21.forward = Vector3.New(var_274_28.x, var_274_28.y, var_274_28.z)

				local var_274_29 = var_274_21.localEulerAngles

				var_274_29.z = 0
				var_274_29.x = 0
				var_274_21.localEulerAngles = var_274_29
			end

			local var_274_30 = 0
			local var_274_31 = 0.5

			if var_274_30 < arg_271_1.time_ and arg_271_1.time_ <= var_274_30 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_32 = arg_271_1:FormatText(StoryNameCfg[6].name)

				arg_271_1.leftNameTxt_.text = var_274_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_33 = arg_271_1:GetWordFromCfg(304071066)
				local var_274_34 = arg_271_1:FormatText(var_274_33.content)

				arg_271_1.text_.text = var_274_34

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_35 = 20
				local var_274_36 = utf8.len(var_274_34)
				local var_274_37 = var_274_35 <= 0 and var_274_31 or var_274_31 * (var_274_36 / var_274_35)

				if var_274_37 > 0 and var_274_31 < var_274_37 then
					arg_271_1.talkMaxDuration = var_274_37

					if var_274_37 + var_274_30 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_37 + var_274_30
					end
				end

				arg_271_1.text_.text = var_274_34
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071066", "story_v_out_304071.awb") ~= 0 then
					local var_274_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071066", "story_v_out_304071.awb") / 1000

					if var_274_38 + var_274_30 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_38 + var_274_30
					end

					if var_274_33.prefab_name ~= "" and arg_271_1.actors_[var_274_33.prefab_name] ~= nil then
						local var_274_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_33.prefab_name].transform, "story_v_out_304071", "304071066", "story_v_out_304071.awb")

						arg_271_1:RecordAudio("304071066", var_274_39)
						arg_271_1:RecordAudio("304071066", var_274_39)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_304071", "304071066", "story_v_out_304071.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_304071", "304071066", "story_v_out_304071.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_40 = math.max(var_274_31, arg_271_1.talkMaxDuration)

			if var_274_30 <= arg_271_1.time_ and arg_271_1.time_ < var_274_30 + var_274_40 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_30) / var_274_40

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_30 + var_274_40 and arg_271_1.time_ < var_274_30 + var_274_40 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play304071067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 304071067
		arg_275_1.duration_ = 9.97

		local var_275_0 = {
			zh = 6.066,
			ja = 9.966
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play304071068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1011ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos1011ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0.7, -0.71, -6)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1011ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["1011ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1011ui_story == nil then
				arg_275_1.var_.characterEffect1011ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect1011ui_story and not isNil(var_278_9) then
					arg_275_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1011ui_story then
				arg_275_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_278_13 = arg_275_1.actors_["1084ui_story"]
			local var_278_14 = 0

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 and not isNil(var_278_13) and arg_275_1.var_.characterEffect1084ui_story == nil then
				arg_275_1.var_.characterEffect1084ui_story = var_278_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_15 = 0.200000002980232

			if var_278_14 <= arg_275_1.time_ and arg_275_1.time_ < var_278_14 + var_278_15 and not isNil(var_278_13) then
				local var_278_16 = (arg_275_1.time_ - var_278_14) / var_278_15

				if arg_275_1.var_.characterEffect1084ui_story and not isNil(var_278_13) then
					local var_278_17 = Mathf.Lerp(0, 0.5, var_278_16)

					arg_275_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1084ui_story.fillRatio = var_278_17
				end
			end

			if arg_275_1.time_ >= var_278_14 + var_278_15 and arg_275_1.time_ < var_278_14 + var_278_15 + arg_278_0 and not isNil(var_278_13) and arg_275_1.var_.characterEffect1084ui_story then
				local var_278_18 = 0.5

				arg_275_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1084ui_story.fillRatio = var_278_18
			end

			local var_278_19 = 0

			if var_278_19 < arg_275_1.time_ and arg_275_1.time_ <= var_278_19 + arg_278_0 then
				arg_275_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action425")
			end

			local var_278_20 = 0

			if var_278_20 < arg_275_1.time_ and arg_275_1.time_ <= var_278_20 + arg_278_0 then
				arg_275_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_278_21 = 0
			local var_278_22 = 0.6

			if var_278_21 < arg_275_1.time_ and arg_275_1.time_ <= var_278_21 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_23 = arg_275_1:FormatText(StoryNameCfg[37].name)

				arg_275_1.leftNameTxt_.text = var_278_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_24 = arg_275_1:GetWordFromCfg(304071067)
				local var_278_25 = arg_275_1:FormatText(var_278_24.content)

				arg_275_1.text_.text = var_278_25

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_26 = 24
				local var_278_27 = utf8.len(var_278_25)
				local var_278_28 = var_278_26 <= 0 and var_278_22 or var_278_22 * (var_278_27 / var_278_26)

				if var_278_28 > 0 and var_278_22 < var_278_28 then
					arg_275_1.talkMaxDuration = var_278_28

					if var_278_28 + var_278_21 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_28 + var_278_21
					end
				end

				arg_275_1.text_.text = var_278_25
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071067", "story_v_out_304071.awb") ~= 0 then
					local var_278_29 = manager.audio:GetVoiceLength("story_v_out_304071", "304071067", "story_v_out_304071.awb") / 1000

					if var_278_29 + var_278_21 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_29 + var_278_21
					end

					if var_278_24.prefab_name ~= "" and arg_275_1.actors_[var_278_24.prefab_name] ~= nil then
						local var_278_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_24.prefab_name].transform, "story_v_out_304071", "304071067", "story_v_out_304071.awb")

						arg_275_1:RecordAudio("304071067", var_278_30)
						arg_275_1:RecordAudio("304071067", var_278_30)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_304071", "304071067", "story_v_out_304071.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_304071", "304071067", "story_v_out_304071.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_31 = math.max(var_278_22, arg_275_1.talkMaxDuration)

			if var_278_21 <= arg_275_1.time_ and arg_275_1.time_ < var_278_21 + var_278_31 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_21) / var_278_31

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_21 + var_278_31 and arg_275_1.time_ < var_278_21 + var_278_31 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play304071068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 304071068
		arg_279_1.duration_ = 7.03

		local var_279_0 = {
			zh = 7.033,
			ja = 1.333
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play304071069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1084ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1084ui_story == nil then
				arg_279_1.var_.characterEffect1084ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1084ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1084ui_story then
				arg_279_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_282_4 = arg_279_1.actors_["1011ui_story"]
			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1011ui_story == nil then
				arg_279_1.var_.characterEffect1011ui_story = var_282_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_6 = 0.200000002980232

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_6 and not isNil(var_282_4) then
				local var_282_7 = (arg_279_1.time_ - var_282_5) / var_282_6

				if arg_279_1.var_.characterEffect1011ui_story and not isNil(var_282_4) then
					local var_282_8 = Mathf.Lerp(0, 0.5, var_282_7)

					arg_279_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1011ui_story.fillRatio = var_282_8
				end
			end

			if arg_279_1.time_ >= var_282_5 + var_282_6 and arg_279_1.time_ < var_282_5 + var_282_6 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1011ui_story then
				local var_282_9 = 0.5

				arg_279_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1011ui_story.fillRatio = var_282_9
			end

			local var_282_10 = 0
			local var_282_11 = 0.85

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_12 = arg_279_1:FormatText(StoryNameCfg[6].name)

				arg_279_1.leftNameTxt_.text = var_282_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_13 = arg_279_1:GetWordFromCfg(304071068)
				local var_282_14 = arg_279_1:FormatText(var_282_13.content)

				arg_279_1.text_.text = var_282_14

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_15 = 34
				local var_282_16 = utf8.len(var_282_14)
				local var_282_17 = var_282_15 <= 0 and var_282_11 or var_282_11 * (var_282_16 / var_282_15)

				if var_282_17 > 0 and var_282_11 < var_282_17 then
					arg_279_1.talkMaxDuration = var_282_17

					if var_282_17 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_17 + var_282_10
					end
				end

				arg_279_1.text_.text = var_282_14
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071068", "story_v_out_304071.awb") ~= 0 then
					local var_282_18 = manager.audio:GetVoiceLength("story_v_out_304071", "304071068", "story_v_out_304071.awb") / 1000

					if var_282_18 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_18 + var_282_10
					end

					if var_282_13.prefab_name ~= "" and arg_279_1.actors_[var_282_13.prefab_name] ~= nil then
						local var_282_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_13.prefab_name].transform, "story_v_out_304071", "304071068", "story_v_out_304071.awb")

						arg_279_1:RecordAudio("304071068", var_282_19)
						arg_279_1:RecordAudio("304071068", var_282_19)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_304071", "304071068", "story_v_out_304071.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_304071", "304071068", "story_v_out_304071.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_20 = math.max(var_282_11, arg_279_1.talkMaxDuration)

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_20 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_10) / var_282_20

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_10 + var_282_20 and arg_279_1.time_ < var_282_10 + var_282_20 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play304071069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 304071069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play304071070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1084ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos1084ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, 100, 0)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1084ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, 100, 0)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["1011ui_story"].transform
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 then
				arg_283_1.var_.moveOldPos1011ui_story = var_286_9.localPosition
			end

			local var_286_11 = 0.001

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11
				local var_286_13 = Vector3.New(0, 100, 0)

				var_286_9.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1011ui_story, var_286_13, var_286_12)

				local var_286_14 = manager.ui.mainCamera.transform.position - var_286_9.position

				var_286_9.forward = Vector3.New(var_286_14.x, var_286_14.y, var_286_14.z)

				local var_286_15 = var_286_9.localEulerAngles

				var_286_15.z = 0
				var_286_15.x = 0
				var_286_9.localEulerAngles = var_286_15
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 then
				var_286_9.localPosition = Vector3.New(0, 100, 0)

				local var_286_16 = manager.ui.mainCamera.transform.position - var_286_9.position

				var_286_9.forward = Vector3.New(var_286_16.x, var_286_16.y, var_286_16.z)

				local var_286_17 = var_286_9.localEulerAngles

				var_286_17.z = 0
				var_286_17.x = 0
				var_286_9.localEulerAngles = var_286_17
			end

			local var_286_18 = arg_283_1.actors_["1084ui_story"]
			local var_286_19 = 0

			if var_286_19 < arg_283_1.time_ and arg_283_1.time_ <= var_286_19 + arg_286_0 and not isNil(var_286_18) and arg_283_1.var_.characterEffect1084ui_story == nil then
				arg_283_1.var_.characterEffect1084ui_story = var_286_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_20 = 0.200000002980232

			if var_286_19 <= arg_283_1.time_ and arg_283_1.time_ < var_286_19 + var_286_20 and not isNil(var_286_18) then
				local var_286_21 = (arg_283_1.time_ - var_286_19) / var_286_20

				if arg_283_1.var_.characterEffect1084ui_story and not isNil(var_286_18) then
					local var_286_22 = Mathf.Lerp(0, 0.5, var_286_21)

					arg_283_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1084ui_story.fillRatio = var_286_22
				end
			end

			if arg_283_1.time_ >= var_286_19 + var_286_20 and arg_283_1.time_ < var_286_19 + var_286_20 + arg_286_0 and not isNil(var_286_18) and arg_283_1.var_.characterEffect1084ui_story then
				local var_286_23 = 0.5

				arg_283_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1084ui_story.fillRatio = var_286_23
			end

			local var_286_24 = 0
			local var_286_25 = 0.8

			if var_286_24 < arg_283_1.time_ and arg_283_1.time_ <= var_286_24 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_26 = arg_283_1:GetWordFromCfg(304071069)
				local var_286_27 = arg_283_1:FormatText(var_286_26.content)

				arg_283_1.text_.text = var_286_27

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_28 = 32
				local var_286_29 = utf8.len(var_286_27)
				local var_286_30 = var_286_28 <= 0 and var_286_25 or var_286_25 * (var_286_29 / var_286_28)

				if var_286_30 > 0 and var_286_25 < var_286_30 then
					arg_283_1.talkMaxDuration = var_286_30

					if var_286_30 + var_286_24 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_30 + var_286_24
					end
				end

				arg_283_1.text_.text = var_286_27
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_31 = math.max(var_286_25, arg_283_1.talkMaxDuration)

			if var_286_24 <= arg_283_1.time_ and arg_283_1.time_ < var_286_24 + var_286_31 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_24) / var_286_31

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_24 + var_286_31 and arg_283_1.time_ < var_286_24 + var_286_31 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play304071070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 304071070
		arg_287_1.duration_ = 15.23

		local var_287_0 = {
			zh = 9.5,
			ja = 15.233
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play304071071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1019ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1019ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1019ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["1019ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1019ui_story == nil then
				arg_287_1.var_.characterEffect1019ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1019ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1019ui_story then
				arg_287_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_290_13 = 0

			if var_290_13 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_290_14 = 0

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_290_15 = 0
			local var_290_16 = 1.225

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[13].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(304071070)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 49
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071070", "story_v_out_304071.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_304071", "304071070", "story_v_out_304071.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_304071", "304071070", "story_v_out_304071.awb")

						arg_287_1:RecordAudio("304071070", var_290_24)
						arg_287_1:RecordAudio("304071070", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_304071", "304071070", "story_v_out_304071.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_304071", "304071070", "story_v_out_304071.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play304071071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 304071071
		arg_291_1.duration_ = 9.4

		local var_291_0 = {
			zh = 5.8,
			ja = 9.4
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play304071072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1013ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos1013ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0.7, -0.66, -6.15)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1013ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0.7, -0.66, -6.15)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["1013ui_story"]
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect1013ui_story == nil then
				arg_291_1.var_.characterEffect1013ui_story = var_294_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_11 = 0.200000002980232

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_11 and not isNil(var_294_9) then
				local var_294_12 = (arg_291_1.time_ - var_294_10) / var_294_11

				if arg_291_1.var_.characterEffect1013ui_story and not isNil(var_294_9) then
					arg_291_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_10 + var_294_11 and arg_291_1.time_ < var_294_10 + var_294_11 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect1013ui_story then
				arg_291_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_294_13 = arg_291_1.actors_["1019ui_story"]
			local var_294_14 = 0

			if var_294_14 < arg_291_1.time_ and arg_291_1.time_ <= var_294_14 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.characterEffect1019ui_story == nil then
				arg_291_1.var_.characterEffect1019ui_story = var_294_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_15 = 0.200000002980232

			if var_294_14 <= arg_291_1.time_ and arg_291_1.time_ < var_294_14 + var_294_15 and not isNil(var_294_13) then
				local var_294_16 = (arg_291_1.time_ - var_294_14) / var_294_15

				if arg_291_1.var_.characterEffect1019ui_story and not isNil(var_294_13) then
					local var_294_17 = Mathf.Lerp(0, 0.5, var_294_16)

					arg_291_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1019ui_story.fillRatio = var_294_17
				end
			end

			if arg_291_1.time_ >= var_294_14 + var_294_15 and arg_291_1.time_ < var_294_14 + var_294_15 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.characterEffect1019ui_story then
				local var_294_18 = 0.5

				arg_291_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1019ui_story.fillRatio = var_294_18
			end

			local var_294_19 = 0

			if var_294_19 < arg_291_1.time_ and arg_291_1.time_ <= var_294_19 + arg_294_0 then
				arg_291_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4105")
			end

			local var_294_20 = 0

			if var_294_20 < arg_291_1.time_ and arg_291_1.time_ <= var_294_20 + arg_294_0 then
				arg_291_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_294_21 = 0
			local var_294_22 = 0.5

			if var_294_21 < arg_291_1.time_ and arg_291_1.time_ <= var_294_21 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_23 = arg_291_1:FormatText(StoryNameCfg[35].name)

				arg_291_1.leftNameTxt_.text = var_294_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_24 = arg_291_1:GetWordFromCfg(304071071)
				local var_294_25 = arg_291_1:FormatText(var_294_24.content)

				arg_291_1.text_.text = var_294_25

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_26 = 20
				local var_294_27 = utf8.len(var_294_25)
				local var_294_28 = var_294_26 <= 0 and var_294_22 or var_294_22 * (var_294_27 / var_294_26)

				if var_294_28 > 0 and var_294_22 < var_294_28 then
					arg_291_1.talkMaxDuration = var_294_28

					if var_294_28 + var_294_21 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_28 + var_294_21
					end
				end

				arg_291_1.text_.text = var_294_25
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071071", "story_v_out_304071.awb") ~= 0 then
					local var_294_29 = manager.audio:GetVoiceLength("story_v_out_304071", "304071071", "story_v_out_304071.awb") / 1000

					if var_294_29 + var_294_21 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_29 + var_294_21
					end

					if var_294_24.prefab_name ~= "" and arg_291_1.actors_[var_294_24.prefab_name] ~= nil then
						local var_294_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_24.prefab_name].transform, "story_v_out_304071", "304071071", "story_v_out_304071.awb")

						arg_291_1:RecordAudio("304071071", var_294_30)
						arg_291_1:RecordAudio("304071071", var_294_30)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_304071", "304071071", "story_v_out_304071.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_304071", "304071071", "story_v_out_304071.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_31 = math.max(var_294_22, arg_291_1.talkMaxDuration)

			if var_294_21 <= arg_291_1.time_ and arg_291_1.time_ < var_294_21 + var_294_31 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_21) / var_294_31

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_21 + var_294_31 and arg_291_1.time_ < var_294_21 + var_294_31 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play304071072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 304071072
		arg_295_1.duration_ = 6.7

		local var_295_0 = {
			zh = 5.166,
			ja = 6.7
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play304071073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.65

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[35].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(304071072)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 26
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071072", "story_v_out_304071.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071072", "story_v_out_304071.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_304071", "304071072", "story_v_out_304071.awb")

						arg_295_1:RecordAudio("304071072", var_298_9)
						arg_295_1:RecordAudio("304071072", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_304071", "304071072", "story_v_out_304071.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_304071", "304071072", "story_v_out_304071.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play304071073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 304071073
		arg_299_1.duration_ = 10

		local var_299_0 = {
			zh = 7.766,
			ja = 10
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play304071074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1019ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1019ui_story == nil then
				arg_299_1.var_.characterEffect1019ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1019ui_story and not isNil(var_302_0) then
					arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1019ui_story then
				arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_302_4 = arg_299_1.actors_["1013ui_story"]
			local var_302_5 = 0

			if var_302_5 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect1013ui_story == nil then
				arg_299_1.var_.characterEffect1013ui_story = var_302_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_6 = 0.200000002980232

			if var_302_5 <= arg_299_1.time_ and arg_299_1.time_ < var_302_5 + var_302_6 and not isNil(var_302_4) then
				local var_302_7 = (arg_299_1.time_ - var_302_5) / var_302_6

				if arg_299_1.var_.characterEffect1013ui_story and not isNil(var_302_4) then
					local var_302_8 = Mathf.Lerp(0, 0.5, var_302_7)

					arg_299_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1013ui_story.fillRatio = var_302_8
				end
			end

			if arg_299_1.time_ >= var_302_5 + var_302_6 and arg_299_1.time_ < var_302_5 + var_302_6 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect1013ui_story then
				local var_302_9 = 0.5

				arg_299_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1013ui_story.fillRatio = var_302_9
			end

			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_302_11 = 0

			if var_302_11 < arg_299_1.time_ and arg_299_1.time_ <= var_302_11 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_302_12 = 0
			local var_302_13 = 0.925

			if var_302_12 < arg_299_1.time_ and arg_299_1.time_ <= var_302_12 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_14 = arg_299_1:FormatText(StoryNameCfg[13].name)

				arg_299_1.leftNameTxt_.text = var_302_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_15 = arg_299_1:GetWordFromCfg(304071073)
				local var_302_16 = arg_299_1:FormatText(var_302_15.content)

				arg_299_1.text_.text = var_302_16

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_17 = 37
				local var_302_18 = utf8.len(var_302_16)
				local var_302_19 = var_302_17 <= 0 and var_302_13 or var_302_13 * (var_302_18 / var_302_17)

				if var_302_19 > 0 and var_302_13 < var_302_19 then
					arg_299_1.talkMaxDuration = var_302_19

					if var_302_19 + var_302_12 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_19 + var_302_12
					end
				end

				arg_299_1.text_.text = var_302_16
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071073", "story_v_out_304071.awb") ~= 0 then
					local var_302_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071073", "story_v_out_304071.awb") / 1000

					if var_302_20 + var_302_12 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_12
					end

					if var_302_15.prefab_name ~= "" and arg_299_1.actors_[var_302_15.prefab_name] ~= nil then
						local var_302_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_15.prefab_name].transform, "story_v_out_304071", "304071073", "story_v_out_304071.awb")

						arg_299_1:RecordAudio("304071073", var_302_21)
						arg_299_1:RecordAudio("304071073", var_302_21)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_304071", "304071073", "story_v_out_304071.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_304071", "304071073", "story_v_out_304071.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_22 = math.max(var_302_13, arg_299_1.talkMaxDuration)

			if var_302_12 <= arg_299_1.time_ and arg_299_1.time_ < var_302_12 + var_302_22 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_12) / var_302_22

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_12 + var_302_22 and arg_299_1.time_ < var_302_12 + var_302_22 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play304071074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 304071074
		arg_303_1.duration_ = 4.3

		local var_303_0 = {
			zh = 4.3,
			ja = 4.233
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play304071075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1013ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1013ui_story == nil then
				arg_303_1.var_.characterEffect1013ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1013ui_story and not isNil(var_306_0) then
					arg_303_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1013ui_story then
				arg_303_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_306_4 = arg_303_1.actors_["1019ui_story"]
			local var_306_5 = 0

			if var_306_5 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect1019ui_story == nil then
				arg_303_1.var_.characterEffect1019ui_story = var_306_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_6 = 0.200000002980232

			if var_306_5 <= arg_303_1.time_ and arg_303_1.time_ < var_306_5 + var_306_6 and not isNil(var_306_4) then
				local var_306_7 = (arg_303_1.time_ - var_306_5) / var_306_6

				if arg_303_1.var_.characterEffect1019ui_story and not isNil(var_306_4) then
					local var_306_8 = Mathf.Lerp(0, 0.5, var_306_7)

					arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1019ui_story.fillRatio = var_306_8
				end
			end

			if arg_303_1.time_ >= var_306_5 + var_306_6 and arg_303_1.time_ < var_306_5 + var_306_6 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect1019ui_story then
				local var_306_9 = 0.5

				arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1019ui_story.fillRatio = var_306_9
			end

			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action5_2")
			end

			local var_306_11 = 0
			local var_306_12 = 0.475

			if var_306_11 < arg_303_1.time_ and arg_303_1.time_ <= var_306_11 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_13 = arg_303_1:FormatText(StoryNameCfg[35].name)

				arg_303_1.leftNameTxt_.text = var_306_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_14 = arg_303_1:GetWordFromCfg(304071074)
				local var_306_15 = arg_303_1:FormatText(var_306_14.content)

				arg_303_1.text_.text = var_306_15

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_16 = 19
				local var_306_17 = utf8.len(var_306_15)
				local var_306_18 = var_306_16 <= 0 and var_306_12 or var_306_12 * (var_306_17 / var_306_16)

				if var_306_18 > 0 and var_306_12 < var_306_18 then
					arg_303_1.talkMaxDuration = var_306_18

					if var_306_18 + var_306_11 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_18 + var_306_11
					end
				end

				arg_303_1.text_.text = var_306_15
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071074", "story_v_out_304071.awb") ~= 0 then
					local var_306_19 = manager.audio:GetVoiceLength("story_v_out_304071", "304071074", "story_v_out_304071.awb") / 1000

					if var_306_19 + var_306_11 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_19 + var_306_11
					end

					if var_306_14.prefab_name ~= "" and arg_303_1.actors_[var_306_14.prefab_name] ~= nil then
						local var_306_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_14.prefab_name].transform, "story_v_out_304071", "304071074", "story_v_out_304071.awb")

						arg_303_1:RecordAudio("304071074", var_306_20)
						arg_303_1:RecordAudio("304071074", var_306_20)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_304071", "304071074", "story_v_out_304071.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_304071", "304071074", "story_v_out_304071.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_21 = math.max(var_306_12, arg_303_1.talkMaxDuration)

			if var_306_11 <= arg_303_1.time_ and arg_303_1.time_ < var_306_11 + var_306_21 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_11) / var_306_21

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_11 + var_306_21 and arg_303_1.time_ < var_306_11 + var_306_21 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play304071075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 304071075
		arg_307_1.duration_ = 6.57

		local var_307_0 = {
			zh = 6.566,
			ja = 1.999999999999
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play304071076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1084ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1084ui_story = var_310_0.localPosition
			end

			local var_310_2 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2
				local var_310_4 = Vector3.New(-0.7, -0.97, -6)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1084ui_story, var_310_4, var_310_3)

				local var_310_5 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_5.x, var_310_5.y, var_310_5.z)

				local var_310_6 = var_310_0.localEulerAngles

				var_310_6.z = 0
				var_310_6.x = 0
				var_310_0.localEulerAngles = var_310_6
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_310_7 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_7.x, var_310_7.y, var_310_7.z)

				local var_310_8 = var_310_0.localEulerAngles

				var_310_8.z = 0
				var_310_8.x = 0
				var_310_0.localEulerAngles = var_310_8
			end

			local var_310_9 = arg_307_1.actors_["1019ui_story"].transform
			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 then
				arg_307_1.var_.moveOldPos1019ui_story = var_310_9.localPosition
			end

			local var_310_11 = 0.001

			if var_310_10 <= arg_307_1.time_ and arg_307_1.time_ < var_310_10 + var_310_11 then
				local var_310_12 = (arg_307_1.time_ - var_310_10) / var_310_11
				local var_310_13 = Vector3.New(0, 100, 0)

				var_310_9.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1019ui_story, var_310_13, var_310_12)

				local var_310_14 = manager.ui.mainCamera.transform.position - var_310_9.position

				var_310_9.forward = Vector3.New(var_310_14.x, var_310_14.y, var_310_14.z)

				local var_310_15 = var_310_9.localEulerAngles

				var_310_15.z = 0
				var_310_15.x = 0
				var_310_9.localEulerAngles = var_310_15
			end

			if arg_307_1.time_ >= var_310_10 + var_310_11 and arg_307_1.time_ < var_310_10 + var_310_11 + arg_310_0 then
				var_310_9.localPosition = Vector3.New(0, 100, 0)

				local var_310_16 = manager.ui.mainCamera.transform.position - var_310_9.position

				var_310_9.forward = Vector3.New(var_310_16.x, var_310_16.y, var_310_16.z)

				local var_310_17 = var_310_9.localEulerAngles

				var_310_17.z = 0
				var_310_17.x = 0
				var_310_9.localEulerAngles = var_310_17
			end

			local var_310_18 = arg_307_1.actors_["1084ui_story"]
			local var_310_19 = 0

			if var_310_19 < arg_307_1.time_ and arg_307_1.time_ <= var_310_19 + arg_310_0 and not isNil(var_310_18) and arg_307_1.var_.characterEffect1084ui_story == nil then
				arg_307_1.var_.characterEffect1084ui_story = var_310_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_20 = 0.200000002980232

			if var_310_19 <= arg_307_1.time_ and arg_307_1.time_ < var_310_19 + var_310_20 and not isNil(var_310_18) then
				local var_310_21 = (arg_307_1.time_ - var_310_19) / var_310_20

				if arg_307_1.var_.characterEffect1084ui_story and not isNil(var_310_18) then
					arg_307_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_19 + var_310_20 and arg_307_1.time_ < var_310_19 + var_310_20 + arg_310_0 and not isNil(var_310_18) and arg_307_1.var_.characterEffect1084ui_story then
				arg_307_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_310_22 = arg_307_1.actors_["1013ui_story"]
			local var_310_23 = 0

			if var_310_23 < arg_307_1.time_ and arg_307_1.time_ <= var_310_23 + arg_310_0 and not isNil(var_310_22) and arg_307_1.var_.characterEffect1013ui_story == nil then
				arg_307_1.var_.characterEffect1013ui_story = var_310_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_24 = 0.200000002980232

			if var_310_23 <= arg_307_1.time_ and arg_307_1.time_ < var_310_23 + var_310_24 and not isNil(var_310_22) then
				local var_310_25 = (arg_307_1.time_ - var_310_23) / var_310_24

				if arg_307_1.var_.characterEffect1013ui_story and not isNil(var_310_22) then
					local var_310_26 = Mathf.Lerp(0, 0.5, var_310_25)

					arg_307_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1013ui_story.fillRatio = var_310_26
				end
			end

			if arg_307_1.time_ >= var_310_23 + var_310_24 and arg_307_1.time_ < var_310_23 + var_310_24 + arg_310_0 and not isNil(var_310_22) and arg_307_1.var_.characterEffect1013ui_story then
				local var_310_27 = 0.5

				arg_307_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1013ui_story.fillRatio = var_310_27
			end

			local var_310_28 = 0

			if var_310_28 < arg_307_1.time_ and arg_307_1.time_ <= var_310_28 + arg_310_0 then
				arg_307_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_310_29 = 0

			if var_310_29 < arg_307_1.time_ and arg_307_1.time_ <= var_310_29 + arg_310_0 then
				arg_307_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_310_30 = 0
			local var_310_31 = 0.7

			if var_310_30 < arg_307_1.time_ and arg_307_1.time_ <= var_310_30 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_32 = arg_307_1:FormatText(StoryNameCfg[6].name)

				arg_307_1.leftNameTxt_.text = var_310_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_33 = arg_307_1:GetWordFromCfg(304071075)
				local var_310_34 = arg_307_1:FormatText(var_310_33.content)

				arg_307_1.text_.text = var_310_34

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_35 = 28
				local var_310_36 = utf8.len(var_310_34)
				local var_310_37 = var_310_35 <= 0 and var_310_31 or var_310_31 * (var_310_36 / var_310_35)

				if var_310_37 > 0 and var_310_31 < var_310_37 then
					arg_307_1.talkMaxDuration = var_310_37

					if var_310_37 + var_310_30 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_37 + var_310_30
					end
				end

				arg_307_1.text_.text = var_310_34
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071075", "story_v_out_304071.awb") ~= 0 then
					local var_310_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071075", "story_v_out_304071.awb") / 1000

					if var_310_38 + var_310_30 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_38 + var_310_30
					end

					if var_310_33.prefab_name ~= "" and arg_307_1.actors_[var_310_33.prefab_name] ~= nil then
						local var_310_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_33.prefab_name].transform, "story_v_out_304071", "304071075", "story_v_out_304071.awb")

						arg_307_1:RecordAudio("304071075", var_310_39)
						arg_307_1:RecordAudio("304071075", var_310_39)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_304071", "304071075", "story_v_out_304071.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_304071", "304071075", "story_v_out_304071.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_40 = math.max(var_310_31, arg_307_1.talkMaxDuration)

			if var_310_30 <= arg_307_1.time_ and arg_307_1.time_ < var_310_30 + var_310_40 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_30) / var_310_40

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_30 + var_310_40 and arg_307_1.time_ < var_310_30 + var_310_40 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_307_1:InitPlayNodeList()
	end,
	Play304071076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 304071076
		arg_311_1.duration_ = 6.5

		local var_311_0 = {
			zh = 5.633,
			ja = 6.5
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play304071077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1013ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1013ui_story == nil then
				arg_311_1.var_.characterEffect1013ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1013ui_story and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1013ui_story then
				arg_311_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_314_4 = arg_311_1.actors_["1084ui_story"]
			local var_314_5 = 0

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect1084ui_story == nil then
				arg_311_1.var_.characterEffect1084ui_story = var_314_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_6 = 0.200000002980232

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_6 and not isNil(var_314_4) then
				local var_314_7 = (arg_311_1.time_ - var_314_5) / var_314_6

				if arg_311_1.var_.characterEffect1084ui_story and not isNil(var_314_4) then
					local var_314_8 = Mathf.Lerp(0, 0.5, var_314_7)

					arg_311_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1084ui_story.fillRatio = var_314_8
				end
			end

			if arg_311_1.time_ >= var_314_5 + var_314_6 and arg_311_1.time_ < var_314_5 + var_314_6 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect1084ui_story then
				local var_314_9 = 0.5

				arg_311_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1084ui_story.fillRatio = var_314_9
			end

			local var_314_10 = 0

			if var_314_10 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 then
				arg_311_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action1_1")
			end

			local var_314_11 = 0

			if var_314_11 < arg_311_1.time_ and arg_311_1.time_ <= var_314_11 + arg_314_0 then
				arg_311_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_314_12 = 0
			local var_314_13 = 0.55

			if var_314_12 < arg_311_1.time_ and arg_311_1.time_ <= var_314_12 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_14 = arg_311_1:FormatText(StoryNameCfg[35].name)

				arg_311_1.leftNameTxt_.text = var_314_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_15 = arg_311_1:GetWordFromCfg(304071076)
				local var_314_16 = arg_311_1:FormatText(var_314_15.content)

				arg_311_1.text_.text = var_314_16

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_17 = 22
				local var_314_18 = utf8.len(var_314_16)
				local var_314_19 = var_314_17 <= 0 and var_314_13 or var_314_13 * (var_314_18 / var_314_17)

				if var_314_19 > 0 and var_314_13 < var_314_19 then
					arg_311_1.talkMaxDuration = var_314_19

					if var_314_19 + var_314_12 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_19 + var_314_12
					end
				end

				arg_311_1.text_.text = var_314_16
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071076", "story_v_out_304071.awb") ~= 0 then
					local var_314_20 = manager.audio:GetVoiceLength("story_v_out_304071", "304071076", "story_v_out_304071.awb") / 1000

					if var_314_20 + var_314_12 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_20 + var_314_12
					end

					if var_314_15.prefab_name ~= "" and arg_311_1.actors_[var_314_15.prefab_name] ~= nil then
						local var_314_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_15.prefab_name].transform, "story_v_out_304071", "304071076", "story_v_out_304071.awb")

						arg_311_1:RecordAudio("304071076", var_314_21)
						arg_311_1:RecordAudio("304071076", var_314_21)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_304071", "304071076", "story_v_out_304071.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_304071", "304071076", "story_v_out_304071.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_22 = math.max(var_314_13, arg_311_1.talkMaxDuration)

			if var_314_12 <= arg_311_1.time_ and arg_311_1.time_ < var_314_12 + var_314_22 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_12) / var_314_22

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_12 + var_314_22 and arg_311_1.time_ < var_314_12 + var_314_22 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play304071077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 304071077
		arg_315_1.duration_ = 9.1

		local var_315_0 = {
			zh = 6.2,
			ja = 9.1
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play304071078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action7_1")
			end

			local var_318_1 = 0
			local var_318_2 = 0.8

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_3 = arg_315_1:FormatText(StoryNameCfg[35].name)

				arg_315_1.leftNameTxt_.text = var_318_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(304071077)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_6 = 32
				local var_318_7 = utf8.len(var_318_5)
				local var_318_8 = var_318_6 <= 0 and var_318_2 or var_318_2 * (var_318_7 / var_318_6)

				if var_318_8 > 0 and var_318_2 < var_318_8 then
					arg_315_1.talkMaxDuration = var_318_8

					if var_318_8 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071077", "story_v_out_304071.awb") ~= 0 then
					local var_318_9 = manager.audio:GetVoiceLength("story_v_out_304071", "304071077", "story_v_out_304071.awb") / 1000

					if var_318_9 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_1
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_out_304071", "304071077", "story_v_out_304071.awb")

						arg_315_1:RecordAudio("304071077", var_318_10)
						arg_315_1:RecordAudio("304071077", var_318_10)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_304071", "304071077", "story_v_out_304071.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_304071", "304071077", "story_v_out_304071.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_11 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_11 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_11

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_11 and arg_315_1.time_ < var_318_1 + var_318_11 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play304071078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 304071078
		arg_319_1.duration_ = 2

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play304071079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1011ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1011ui_story == nil then
				arg_319_1.var_.characterEffect1011ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1011ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1011ui_story then
				arg_319_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_322_4 = arg_319_1.actors_["1013ui_story"]
			local var_322_5 = 0

			if var_322_5 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 and not isNil(var_322_4) and arg_319_1.var_.characterEffect1013ui_story == nil then
				arg_319_1.var_.characterEffect1013ui_story = var_322_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_6 = 0.200000002980232

			if var_322_5 <= arg_319_1.time_ and arg_319_1.time_ < var_322_5 + var_322_6 and not isNil(var_322_4) then
				local var_322_7 = (arg_319_1.time_ - var_322_5) / var_322_6

				if arg_319_1.var_.characterEffect1013ui_story and not isNil(var_322_4) then
					local var_322_8 = Mathf.Lerp(0, 0.5, var_322_7)

					arg_319_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1013ui_story.fillRatio = var_322_8
				end
			end

			if arg_319_1.time_ >= var_322_5 + var_322_6 and arg_319_1.time_ < var_322_5 + var_322_6 + arg_322_0 and not isNil(var_322_4) and arg_319_1.var_.characterEffect1013ui_story then
				local var_322_9 = 0.5

				arg_319_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1013ui_story.fillRatio = var_322_9
			end

			local var_322_10 = 0

			if var_322_10 < arg_319_1.time_ and arg_319_1.time_ <= var_322_10 + arg_322_0 then
				arg_319_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_322_11 = 0

			if var_322_11 < arg_319_1.time_ and arg_319_1.time_ <= var_322_11 + arg_322_0 then
				arg_319_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_322_12 = arg_319_1.actors_["1084ui_story"].transform
			local var_322_13 = 0

			if var_322_13 < arg_319_1.time_ and arg_319_1.time_ <= var_322_13 + arg_322_0 then
				arg_319_1.var_.moveOldPos1084ui_story = var_322_12.localPosition
			end

			local var_322_14 = 0.001

			if var_322_13 <= arg_319_1.time_ and arg_319_1.time_ < var_322_13 + var_322_14 then
				local var_322_15 = (arg_319_1.time_ - var_322_13) / var_322_14
				local var_322_16 = Vector3.New(0, 100, 0)

				var_322_12.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1084ui_story, var_322_16, var_322_15)

				local var_322_17 = manager.ui.mainCamera.transform.position - var_322_12.position

				var_322_12.forward = Vector3.New(var_322_17.x, var_322_17.y, var_322_17.z)

				local var_322_18 = var_322_12.localEulerAngles

				var_322_18.z = 0
				var_322_18.x = 0
				var_322_12.localEulerAngles = var_322_18
			end

			if arg_319_1.time_ >= var_322_13 + var_322_14 and arg_319_1.time_ < var_322_13 + var_322_14 + arg_322_0 then
				var_322_12.localPosition = Vector3.New(0, 100, 0)

				local var_322_19 = manager.ui.mainCamera.transform.position - var_322_12.position

				var_322_12.forward = Vector3.New(var_322_19.x, var_322_19.y, var_322_19.z)

				local var_322_20 = var_322_12.localEulerAngles

				var_322_20.z = 0
				var_322_20.x = 0
				var_322_12.localEulerAngles = var_322_20
			end

			local var_322_21 = arg_319_1.actors_["1011ui_story"].transform
			local var_322_22 = 0

			if var_322_22 < arg_319_1.time_ and arg_319_1.time_ <= var_322_22 + arg_322_0 then
				arg_319_1.var_.moveOldPos1011ui_story = var_322_21.localPosition
			end

			local var_322_23 = 0.001

			if var_322_22 <= arg_319_1.time_ and arg_319_1.time_ < var_322_22 + var_322_23 then
				local var_322_24 = (arg_319_1.time_ - var_322_22) / var_322_23
				local var_322_25 = Vector3.New(-0.7, -0.71, -6)

				var_322_21.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1011ui_story, var_322_25, var_322_24)

				local var_322_26 = manager.ui.mainCamera.transform.position - var_322_21.position

				var_322_21.forward = Vector3.New(var_322_26.x, var_322_26.y, var_322_26.z)

				local var_322_27 = var_322_21.localEulerAngles

				var_322_27.z = 0
				var_322_27.x = 0
				var_322_21.localEulerAngles = var_322_27
			end

			if arg_319_1.time_ >= var_322_22 + var_322_23 and arg_319_1.time_ < var_322_22 + var_322_23 + arg_322_0 then
				var_322_21.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_322_28 = manager.ui.mainCamera.transform.position - var_322_21.position

				var_322_21.forward = Vector3.New(var_322_28.x, var_322_28.y, var_322_28.z)

				local var_322_29 = var_322_21.localEulerAngles

				var_322_29.z = 0
				var_322_29.x = 0
				var_322_21.localEulerAngles = var_322_29
			end

			local var_322_30 = 0
			local var_322_31 = 0.125

			if var_322_30 < arg_319_1.time_ and arg_319_1.time_ <= var_322_30 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_32 = arg_319_1:FormatText(StoryNameCfg[37].name)

				arg_319_1.leftNameTxt_.text = var_322_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_33 = arg_319_1:GetWordFromCfg(304071078)
				local var_322_34 = arg_319_1:FormatText(var_322_33.content)

				arg_319_1.text_.text = var_322_34

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_35 = 5
				local var_322_36 = utf8.len(var_322_34)
				local var_322_37 = var_322_35 <= 0 and var_322_31 or var_322_31 * (var_322_36 / var_322_35)

				if var_322_37 > 0 and var_322_31 < var_322_37 then
					arg_319_1.talkMaxDuration = var_322_37

					if var_322_37 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_37 + var_322_30
					end
				end

				arg_319_1.text_.text = var_322_34
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071078", "story_v_out_304071.awb") ~= 0 then
					local var_322_38 = manager.audio:GetVoiceLength("story_v_out_304071", "304071078", "story_v_out_304071.awb") / 1000

					if var_322_38 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_38 + var_322_30
					end

					if var_322_33.prefab_name ~= "" and arg_319_1.actors_[var_322_33.prefab_name] ~= nil then
						local var_322_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_33.prefab_name].transform, "story_v_out_304071", "304071078", "story_v_out_304071.awb")

						arg_319_1:RecordAudio("304071078", var_322_39)
						arg_319_1:RecordAudio("304071078", var_322_39)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_304071", "304071078", "story_v_out_304071.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_304071", "304071078", "story_v_out_304071.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_40 = math.max(var_322_31, arg_319_1.talkMaxDuration)

			if var_322_30 <= arg_319_1.time_ and arg_319_1.time_ < var_322_30 + var_322_40 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_30) / var_322_40

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_30 + var_322_40 and arg_319_1.time_ < var_322_30 + var_322_40 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play304071079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 304071079
		arg_323_1.duration_ = 10.77

		local var_323_0 = {
			zh = 8.4,
			ja = 10.766
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play304071080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1013ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1013ui_story == nil then
				arg_323_1.var_.characterEffect1013ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1013ui_story and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1013ui_story then
				arg_323_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_326_4 = arg_323_1.actors_["1011ui_story"]
			local var_326_5 = 0

			if var_326_5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 and not isNil(var_326_4) and arg_323_1.var_.characterEffect1011ui_story == nil then
				arg_323_1.var_.characterEffect1011ui_story = var_326_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_6 = 0.200000002980232

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_6 and not isNil(var_326_4) then
				local var_326_7 = (arg_323_1.time_ - var_326_5) / var_326_6

				if arg_323_1.var_.characterEffect1011ui_story and not isNil(var_326_4) then
					local var_326_8 = Mathf.Lerp(0, 0.5, var_326_7)

					arg_323_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1011ui_story.fillRatio = var_326_8
				end
			end

			if arg_323_1.time_ >= var_326_5 + var_326_6 and arg_323_1.time_ < var_326_5 + var_326_6 + arg_326_0 and not isNil(var_326_4) and arg_323_1.var_.characterEffect1011ui_story then
				local var_326_9 = 0.5

				arg_323_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1011ui_story.fillRatio = var_326_9
			end

			local var_326_10 = 0
			local var_326_11 = 1

			if var_326_10 < arg_323_1.time_ and arg_323_1.time_ <= var_326_10 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_12 = arg_323_1:FormatText(StoryNameCfg[35].name)

				arg_323_1.leftNameTxt_.text = var_326_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_13 = arg_323_1:GetWordFromCfg(304071079)
				local var_326_14 = arg_323_1:FormatText(var_326_13.content)

				arg_323_1.text_.text = var_326_14

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_15 = 40
				local var_326_16 = utf8.len(var_326_14)
				local var_326_17 = var_326_15 <= 0 and var_326_11 or var_326_11 * (var_326_16 / var_326_15)

				if var_326_17 > 0 and var_326_11 < var_326_17 then
					arg_323_1.talkMaxDuration = var_326_17

					if var_326_17 + var_326_10 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_17 + var_326_10
					end
				end

				arg_323_1.text_.text = var_326_14
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071079", "story_v_out_304071.awb") ~= 0 then
					local var_326_18 = manager.audio:GetVoiceLength("story_v_out_304071", "304071079", "story_v_out_304071.awb") / 1000

					if var_326_18 + var_326_10 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_18 + var_326_10
					end

					if var_326_13.prefab_name ~= "" and arg_323_1.actors_[var_326_13.prefab_name] ~= nil then
						local var_326_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_13.prefab_name].transform, "story_v_out_304071", "304071079", "story_v_out_304071.awb")

						arg_323_1:RecordAudio("304071079", var_326_19)
						arg_323_1:RecordAudio("304071079", var_326_19)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_304071", "304071079", "story_v_out_304071.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_304071", "304071079", "story_v_out_304071.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_20 = math.max(var_326_11, arg_323_1.talkMaxDuration)

			if var_326_10 <= arg_323_1.time_ and arg_323_1.time_ < var_326_10 + var_326_20 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_10) / var_326_20

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_10 + var_326_20 and arg_323_1.time_ < var_326_10 + var_326_20 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play304071080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 304071080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play304071081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1011ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1011ui_story = var_330_0.localPosition
			end

			local var_330_2 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2
				local var_330_4 = Vector3.New(0, 100, 0)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1011ui_story, var_330_4, var_330_3)

				local var_330_5 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_5.x, var_330_5.y, var_330_5.z)

				local var_330_6 = var_330_0.localEulerAngles

				var_330_6.z = 0
				var_330_6.x = 0
				var_330_0.localEulerAngles = var_330_6
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, 100, 0)

				local var_330_7 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_7.x, var_330_7.y, var_330_7.z)

				local var_330_8 = var_330_0.localEulerAngles

				var_330_8.z = 0
				var_330_8.x = 0
				var_330_0.localEulerAngles = var_330_8
			end

			local var_330_9 = arg_327_1.actors_["1013ui_story"].transform
			local var_330_10 = 0

			if var_330_10 < arg_327_1.time_ and arg_327_1.time_ <= var_330_10 + arg_330_0 then
				arg_327_1.var_.moveOldPos1013ui_story = var_330_9.localPosition
			end

			local var_330_11 = 0.001

			if var_330_10 <= arg_327_1.time_ and arg_327_1.time_ < var_330_10 + var_330_11 then
				local var_330_12 = (arg_327_1.time_ - var_330_10) / var_330_11
				local var_330_13 = Vector3.New(0, 100, 0)

				var_330_9.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1013ui_story, var_330_13, var_330_12)

				local var_330_14 = manager.ui.mainCamera.transform.position - var_330_9.position

				var_330_9.forward = Vector3.New(var_330_14.x, var_330_14.y, var_330_14.z)

				local var_330_15 = var_330_9.localEulerAngles

				var_330_15.z = 0
				var_330_15.x = 0
				var_330_9.localEulerAngles = var_330_15
			end

			if arg_327_1.time_ >= var_330_10 + var_330_11 and arg_327_1.time_ < var_330_10 + var_330_11 + arg_330_0 then
				var_330_9.localPosition = Vector3.New(0, 100, 0)

				local var_330_16 = manager.ui.mainCamera.transform.position - var_330_9.position

				var_330_9.forward = Vector3.New(var_330_16.x, var_330_16.y, var_330_16.z)

				local var_330_17 = var_330_9.localEulerAngles

				var_330_17.z = 0
				var_330_17.x = 0
				var_330_9.localEulerAngles = var_330_17
			end

			local var_330_18 = arg_327_1.actors_["1013ui_story"]
			local var_330_19 = 0

			if var_330_19 < arg_327_1.time_ and arg_327_1.time_ <= var_330_19 + arg_330_0 and not isNil(var_330_18) and arg_327_1.var_.characterEffect1013ui_story == nil then
				arg_327_1.var_.characterEffect1013ui_story = var_330_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_20 = 0.200000002980232

			if var_330_19 <= arg_327_1.time_ and arg_327_1.time_ < var_330_19 + var_330_20 and not isNil(var_330_18) then
				local var_330_21 = (arg_327_1.time_ - var_330_19) / var_330_20

				if arg_327_1.var_.characterEffect1013ui_story and not isNil(var_330_18) then
					local var_330_22 = Mathf.Lerp(0, 0.5, var_330_21)

					arg_327_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1013ui_story.fillRatio = var_330_22
				end
			end

			if arg_327_1.time_ >= var_330_19 + var_330_20 and arg_327_1.time_ < var_330_19 + var_330_20 + arg_330_0 and not isNil(var_330_18) and arg_327_1.var_.characterEffect1013ui_story then
				local var_330_23 = 0.5

				arg_327_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1013ui_story.fillRatio = var_330_23
			end

			local var_330_24 = 0
			local var_330_25 = 1.625

			if var_330_24 < arg_327_1.time_ and arg_327_1.time_ <= var_330_24 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_26 = arg_327_1:GetWordFromCfg(304071080)
				local var_330_27 = arg_327_1:FormatText(var_330_26.content)

				arg_327_1.text_.text = var_330_27

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_28 = 65
				local var_330_29 = utf8.len(var_330_27)
				local var_330_30 = var_330_28 <= 0 and var_330_25 or var_330_25 * (var_330_29 / var_330_28)

				if var_330_30 > 0 and var_330_25 < var_330_30 then
					arg_327_1.talkMaxDuration = var_330_30

					if var_330_30 + var_330_24 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_30 + var_330_24
					end
				end

				arg_327_1.text_.text = var_330_27
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_31 = math.max(var_330_25, arg_327_1.talkMaxDuration)

			if var_330_24 <= arg_327_1.time_ and arg_327_1.time_ < var_330_24 + var_330_31 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_24) / var_330_31

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_24 + var_330_31 and arg_327_1.time_ < var_330_24 + var_330_31 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play304071081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 304071081
		arg_331_1.duration_ = 8.9

		local var_331_0 = {
			zh = 8.7,
			ja = 8.9
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play304071082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = "10002ui_story"

			if arg_331_1.actors_[var_334_0] == nil then
				local var_334_1 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_334_1) then
					local var_334_2 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_331_1.stage_.transform)

					var_334_2.name = var_334_0
					var_334_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_331_1.actors_[var_334_0] = var_334_2

					local var_334_3 = var_334_2:GetComponentInChildren(typeof(CharacterEffect))

					var_334_3.enabled = true

					local var_334_4 = GameObjectTools.GetOrAddComponent(var_334_2, typeof(DynamicBoneHelper))

					if var_334_4 then
						var_334_4:EnableDynamicBone(false)
					end

					arg_331_1:ShowWeapon(var_334_3.transform, false)

					arg_331_1.var_[var_334_0 .. "Animator"] = var_334_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_331_1.var_[var_334_0 .. "Animator"].applyRootMotion = true
					arg_331_1.var_[var_334_0 .. "LipSync"] = var_334_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_334_5 = arg_331_1.actors_["10002ui_story"].transform
			local var_334_6 = 0

			if var_334_6 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.var_.moveOldPos10002ui_story = var_334_5.localPosition
			end

			local var_334_7 = 0.001

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_7 then
				local var_334_8 = (arg_331_1.time_ - var_334_6) / var_334_7
				local var_334_9 = Vector3.New(0, -1.2, -5.8)

				var_334_5.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10002ui_story, var_334_9, var_334_8)

				local var_334_10 = manager.ui.mainCamera.transform.position - var_334_5.position

				var_334_5.forward = Vector3.New(var_334_10.x, var_334_10.y, var_334_10.z)

				local var_334_11 = var_334_5.localEulerAngles

				var_334_11.z = 0
				var_334_11.x = 0
				var_334_5.localEulerAngles = var_334_11
			end

			if arg_331_1.time_ >= var_334_6 + var_334_7 and arg_331_1.time_ < var_334_6 + var_334_7 + arg_334_0 then
				var_334_5.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_334_12 = manager.ui.mainCamera.transform.position - var_334_5.position

				var_334_5.forward = Vector3.New(var_334_12.x, var_334_12.y, var_334_12.z)

				local var_334_13 = var_334_5.localEulerAngles

				var_334_13.z = 0
				var_334_13.x = 0
				var_334_5.localEulerAngles = var_334_13
			end

			local var_334_14 = arg_331_1.actors_["10002ui_story"]
			local var_334_15 = 0

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 and not isNil(var_334_14) and arg_331_1.var_.characterEffect10002ui_story == nil then
				arg_331_1.var_.characterEffect10002ui_story = var_334_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_16 = 0.200000002980232

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_16 and not isNil(var_334_14) then
				local var_334_17 = (arg_331_1.time_ - var_334_15) / var_334_16

				if arg_331_1.var_.characterEffect10002ui_story and not isNil(var_334_14) then
					arg_331_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_15 + var_334_16 and arg_331_1.time_ < var_334_15 + var_334_16 + arg_334_0 and not isNil(var_334_14) and arg_331_1.var_.characterEffect10002ui_story then
				arg_331_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_334_18 = 0

			if var_334_18 < arg_331_1.time_ and arg_331_1.time_ <= var_334_18 + arg_334_0 then
				arg_331_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_334_19 = 0

			if var_334_19 < arg_331_1.time_ and arg_331_1.time_ <= var_334_19 + arg_334_0 then
				arg_331_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_334_20 = 0
			local var_334_21 = 0.8

			if var_334_20 < arg_331_1.time_ and arg_331_1.time_ <= var_334_20 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_22 = arg_331_1:FormatText(StoryNameCfg[39].name)

				arg_331_1.leftNameTxt_.text = var_334_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_23 = arg_331_1:GetWordFromCfg(304071081)
				local var_334_24 = arg_331_1:FormatText(var_334_23.content)

				arg_331_1.text_.text = var_334_24

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_25 = 32
				local var_334_26 = utf8.len(var_334_24)
				local var_334_27 = var_334_25 <= 0 and var_334_21 or var_334_21 * (var_334_26 / var_334_25)

				if var_334_27 > 0 and var_334_21 < var_334_27 then
					arg_331_1.talkMaxDuration = var_334_27

					if var_334_27 + var_334_20 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_27 + var_334_20
					end
				end

				arg_331_1.text_.text = var_334_24
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071081", "story_v_out_304071.awb") ~= 0 then
					local var_334_28 = manager.audio:GetVoiceLength("story_v_out_304071", "304071081", "story_v_out_304071.awb") / 1000

					if var_334_28 + var_334_20 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_28 + var_334_20
					end

					if var_334_23.prefab_name ~= "" and arg_331_1.actors_[var_334_23.prefab_name] ~= nil then
						local var_334_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_23.prefab_name].transform, "story_v_out_304071", "304071081", "story_v_out_304071.awb")

						arg_331_1:RecordAudio("304071081", var_334_29)
						arg_331_1:RecordAudio("304071081", var_334_29)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_304071", "304071081", "story_v_out_304071.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_304071", "304071081", "story_v_out_304071.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_30 = math.max(var_334_21, arg_331_1.talkMaxDuration)

			if var_334_20 <= arg_331_1.time_ and arg_331_1.time_ < var_334_20 + var_334_30 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_20) / var_334_30

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_20 + var_334_30 and arg_331_1.time_ < var_334_20 + var_334_30 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play304071082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 304071082
		arg_335_1.duration_ = 7.87

		local var_335_0 = {
			zh = 5.6,
			ja = 7.866
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
			arg_335_1.auto_ = false
		end

		function arg_335_1.playNext_(arg_337_0)
			arg_335_1.onStoryFinished_()
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.625

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[39].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_3 = arg_335_1:GetWordFromCfg(304071082)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_304071", "304071082", "story_v_out_304071.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_304071", "304071082", "story_v_out_304071.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_304071", "304071082", "story_v_out_304071.awb")

						arg_335_1:RecordAudio("304071082", var_338_9)
						arg_335_1:RecordAudio("304071082", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_304071", "304071082", "story_v_out_304071.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_304071", "304071082", "story_v_out_304071.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02e",
		"TextureConfig/Background/B02f",
		"TextureConfig/Background/S0105"
	},
	voices = {
		"story_v_out_304071.awb"
	}
}
