return {
	Play114142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114142001
		arg_1_1.duration_ = 7.43

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F04"

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
				local var_4_5 = arg_1_1.bgs_.F04

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
					if iter_4_0 ~= "F04" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 2
			local var_4_29 = 0.566666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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
			local var_4_35 = 0.2

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[246].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3031")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(114142001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142001", "story_v_out_114142.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_114142", "114142001", "story_v_out_114142.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_114142", "114142001", "story_v_out_114142.awb")

						arg_1_1:RecordAudio("114142001", var_4_44)
						arg_1_1:RecordAudio("114142001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114142", "114142001", "story_v_out_114142.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114142", "114142001", "story_v_out_114142.awb")
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
	Play114142002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114142002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114142003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.425

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(114142002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 57
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play114142003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114142003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114142004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.275

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(114142003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 51
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114142004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114142004
		arg_17_1.duration_ = 4.83

		local var_17_0 = {
			ja = 3.333,
			ko = 4.833,
			zh = 4.1,
			en = 3.333
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114142005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1042ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1042ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1042ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(-0.7, -1.06, -6.2)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1042ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_16 = arg_17_1.actors_["1042ui_story"]
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.characterEffect1042ui_story == nil then
				arg_17_1.var_.characterEffect1042ui_story = var_20_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_18 = 0.2

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_18 and not isNil(var_20_16) then
				local var_20_19 = (arg_17_1.time_ - var_20_17) / var_20_18

				if arg_17_1.var_.characterEffect1042ui_story and not isNil(var_20_16) then
					arg_17_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_17 + var_20_18 and arg_17_1.time_ < var_20_17 + var_20_18 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.characterEffect1042ui_story then
				arg_17_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_20_20 = 0
			local var_20_21 = 0.525

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[205].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(114142004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 21
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142004", "story_v_out_114142.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_114142", "114142004", "story_v_out_114142.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_114142", "114142004", "story_v_out_114142.awb")

						arg_17_1:RecordAudio("114142004", var_20_29)
						arg_17_1:RecordAudio("114142004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114142", "114142004", "story_v_out_114142.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114142", "114142004", "story_v_out_114142.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play114142005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114142005
		arg_21_1.duration_ = 2.13

		local var_21_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.133,
			en = 1.999999999999
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114142006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1042ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1042ui_story == nil then
				arg_21_1.var_.characterEffect1042ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1042ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1042ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1042ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1042ui_story.fillRatio = var_24_5
			end

			local var_24_6 = "1068ui_story"

			if arg_21_1.actors_[var_24_6] == nil then
				local var_24_7 = Asset.Load("Char/" .. "1068ui_story")

				if not isNil(var_24_7) then
					local var_24_8 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_21_1.stage_.transform)

					var_24_8.name = var_24_6
					var_24_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_6] = var_24_8

					local var_24_9 = var_24_8:GetComponentInChildren(typeof(CharacterEffect))

					var_24_9.enabled = true

					local var_24_10 = GameObjectTools.GetOrAddComponent(var_24_8, typeof(DynamicBoneHelper))

					if var_24_10 then
						var_24_10:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_9.transform, false)

					arg_21_1.var_[var_24_6 .. "Animator"] = var_24_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_6 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_6 .. "LipSync"] = var_24_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_11 = arg_21_1.actors_["1068ui_story"].transform
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.var_.moveOldPos1068ui_story = var_24_11.localPosition
			end

			local var_24_13 = 0.001

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 then
				local var_24_14 = (arg_21_1.time_ - var_24_12) / var_24_13
				local var_24_15 = Vector3.New(0.7, -0.95, -5.88)

				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1068ui_story, var_24_15, var_24_14)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_11.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_11.localEulerAngles = var_24_17
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(0.7, -0.95, -5.88)

				local var_24_18 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_18.x, var_24_18.y, var_24_18.z)

				local var_24_19 = var_24_11.localEulerAngles

				var_24_19.z = 0
				var_24_19.x = 0
				var_24_11.localEulerAngles = var_24_19
			end

			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_22 = arg_21_1.actors_["1068ui_story"]
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.characterEffect1068ui_story == nil then
				arg_21_1.var_.characterEffect1068ui_story = var_24_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_24 = 0.2

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 and not isNil(var_24_22) then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24

				if arg_21_1.var_.characterEffect1068ui_story and not isNil(var_24_22) then
					arg_21_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.characterEffect1068ui_story then
				arg_21_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_24_26 = 0
			local var_24_27 = 0.25

			if var_24_26 < arg_21_1.time_ and arg_21_1.time_ <= var_24_26 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_28 = arg_21_1:FormatText(StoryNameCfg[218].name)

				arg_21_1.leftNameTxt_.text = var_24_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_29 = arg_21_1:GetWordFromCfg(114142005)
				local var_24_30 = arg_21_1:FormatText(var_24_29.content)

				arg_21_1.text_.text = var_24_30

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_31 = 10
				local var_24_32 = utf8.len(var_24_30)
				local var_24_33 = var_24_31 <= 0 and var_24_27 or var_24_27 * (var_24_32 / var_24_31)

				if var_24_33 > 0 and var_24_27 < var_24_33 then
					arg_21_1.talkMaxDuration = var_24_33

					if var_24_33 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_33 + var_24_26
					end
				end

				arg_21_1.text_.text = var_24_30
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142005", "story_v_out_114142.awb") ~= 0 then
					local var_24_34 = manager.audio:GetVoiceLength("story_v_out_114142", "114142005", "story_v_out_114142.awb") / 1000

					if var_24_34 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_34 + var_24_26
					end

					if var_24_29.prefab_name ~= "" and arg_21_1.actors_[var_24_29.prefab_name] ~= nil then
						local var_24_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_29.prefab_name].transform, "story_v_out_114142", "114142005", "story_v_out_114142.awb")

						arg_21_1:RecordAudio("114142005", var_24_35)
						arg_21_1:RecordAudio("114142005", var_24_35)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114142", "114142005", "story_v_out_114142.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114142", "114142005", "story_v_out_114142.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_36 = math.max(var_24_27, arg_21_1.talkMaxDuration)

			if var_24_26 <= arg_21_1.time_ and arg_21_1.time_ < var_24_26 + var_24_36 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_26) / var_24_36

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_26 + var_24_36 and arg_21_1.time_ < var_24_26 + var_24_36 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114142006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114142006
		arg_25_1.duration_ = 7

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114142007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1068ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1068ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1068ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1042ui_story"].transform
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.var_.moveOldPos1042ui_story = var_28_9.localPosition
			end

			local var_28_11 = 0.001

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11
				local var_28_13 = Vector3.New(0, 100, 0)

				var_28_9.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1042ui_story, var_28_13, var_28_12)

				local var_28_14 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_14.x, var_28_14.y, var_28_14.z)

				local var_28_15 = var_28_9.localEulerAngles

				var_28_15.z = 0
				var_28_15.x = 0
				var_28_9.localEulerAngles = var_28_15
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 then
				var_28_9.localPosition = Vector3.New(0, 100, 0)

				local var_28_16 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_16.x, var_28_16.y, var_28_16.z)

				local var_28_17 = var_28_9.localEulerAngles

				var_28_17.z = 0
				var_28_17.x = 0
				var_28_9.localEulerAngles = var_28_17
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = false

				arg_25_1:SetGaussion(false)
			end

			local var_28_19 = 2

			if var_28_18 <= arg_25_1.time_ and arg_25_1.time_ < var_28_18 + var_28_19 then
				local var_28_20 = (arg_25_1.time_ - var_28_18) / var_28_19
				local var_28_21 = Color.New(1, 1, 1)

				var_28_21.a = Mathf.Lerp(1, 0, var_28_20)
				arg_25_1.mask_.color = var_28_21
			end

			if arg_25_1.time_ >= var_28_18 + var_28_19 and arg_25_1.time_ < var_28_18 + var_28_19 + arg_28_0 then
				local var_28_22 = Color.New(1, 1, 1)
				local var_28_23 = 0

				arg_25_1.mask_.enabled = false
				var_28_22.a = var_28_23
				arg_25_1.mask_.color = var_28_22
			end

			local var_28_24 = "OM0208"

			if arg_25_1.bgs_[var_28_24] == nil then
				local var_28_25 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_25:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_24)
				var_28_25.name = var_28_24
				var_28_25.transform.parent = arg_25_1.stage_.transform
				var_28_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_24] = var_28_25
			end

			local var_28_26 = 0

			if var_28_26 < arg_25_1.time_ and arg_25_1.time_ <= var_28_26 + arg_28_0 then
				local var_28_27 = manager.ui.mainCamera.transform.localPosition
				local var_28_28 = Vector3.New(0, 0, 10) + Vector3.New(var_28_27.x, var_28_27.y, 0)
				local var_28_29 = arg_25_1.bgs_.OM0208

				var_28_29.transform.localPosition = var_28_28
				var_28_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_30 = var_28_29:GetComponent("SpriteRenderer")

				if var_28_30 and var_28_30.sprite then
					local var_28_31 = (var_28_29.transform.localPosition - var_28_27).z
					local var_28_32 = manager.ui.mainCameraCom_
					local var_28_33 = 2 * var_28_31 * Mathf.Tan(var_28_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_34 = var_28_33 * var_28_32.aspect
					local var_28_35 = var_28_30.sprite.bounds.size.x
					local var_28_36 = var_28_30.sprite.bounds.size.y
					local var_28_37 = var_28_34 / var_28_35
					local var_28_38 = var_28_33 / var_28_36
					local var_28_39 = var_28_38 < var_28_37 and var_28_37 or var_28_38

					var_28_29.transform.localScale = Vector3.New(var_28_39, var_28_39, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "OM0208" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_40 = 2
			local var_28_41 = 1.075

			if var_28_40 < arg_25_1.time_ and arg_25_1.time_ <= var_28_40 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_42 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_42:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_43 = arg_25_1:GetWordFromCfg(114142006)
				local var_28_44 = arg_25_1:FormatText(var_28_43.content)

				arg_25_1.text_.text = var_28_44

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_45 = 43
				local var_28_46 = utf8.len(var_28_44)
				local var_28_47 = var_28_45 <= 0 and var_28_41 or var_28_41 * (var_28_46 / var_28_45)

				if var_28_47 > 0 and var_28_41 < var_28_47 then
					arg_25_1.talkMaxDuration = var_28_47
					var_28_40 = var_28_40 + 0.3

					if var_28_47 + var_28_40 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_47 + var_28_40
					end
				end

				arg_25_1.text_.text = var_28_44
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_48 = var_28_40 + 0.3
			local var_28_49 = math.max(var_28_41, arg_25_1.talkMaxDuration)

			if var_28_48 <= arg_25_1.time_ and arg_25_1.time_ < var_28_48 + var_28_49 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_48) / var_28_49

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_48 + var_28_49 and arg_25_1.time_ < var_28_48 + var_28_49 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play114142007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 114142007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play114142008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 1.575

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_2 = arg_31_1:GetWordFromCfg(114142007)
				local var_34_3 = arg_31_1:FormatText(var_34_2.content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 63
				local var_34_5 = utf8.len(var_34_3)
				local var_34_6 = var_34_4 <= 0 and var_34_1 or var_34_1 * (var_34_5 / var_34_4)

				if var_34_6 > 0 and var_34_1 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6

					if var_34_6 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_7 and arg_31_1.time_ < var_34_0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play114142008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 114142008
		arg_35_1.duration_ = 2.63

		local var_35_0 = {
			ja = 2.633,
			ko = 1.866,
			zh = 2.233,
			en = 1.7
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play114142009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.3

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[218].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1068")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(114142008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 12
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142008", "story_v_out_114142.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_114142", "114142008", "story_v_out_114142.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_114142", "114142008", "story_v_out_114142.awb")

						arg_35_1:RecordAudio("114142008", var_38_9)
						arg_35_1:RecordAudio("114142008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_114142", "114142008", "story_v_out_114142.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_114142", "114142008", "story_v_out_114142.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play114142009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 114142009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play114142010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.1

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

				local var_42_2 = arg_39_1:GetWordFromCfg(114142009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 44
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
	Play114142010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 114142010
		arg_43_1.duration_ = 1.87

		local var_43_0 = {
			ja = 1.866,
			ko = 1.2,
			zh = 1,
			en = 1.1
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play114142011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.1

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[205].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(114142010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142010", "story_v_out_114142.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_114142", "114142010", "story_v_out_114142.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_114142", "114142010", "story_v_out_114142.awb")

						arg_43_1:RecordAudio("114142010", var_46_9)
						arg_43_1:RecordAudio("114142010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_114142", "114142010", "story_v_out_114142.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_114142", "114142010", "story_v_out_114142.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_10 and arg_43_1.time_ < var_46_0 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play114142011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 114142011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play114142012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				local var_50_2 = "play"
				local var_50_3 = "effect"

				arg_47_1:AudioAction(var_50_2, var_50_3, "se_story_11", "se_story_11_book", "")
			end

			local var_50_4 = 0
			local var_50_5 = 0.675

			if var_50_4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(114142011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 27
				local var_50_9 = utf8.len(var_50_7)
				local var_50_10 = var_50_8 <= 0 and var_50_5 or var_50_5 * (var_50_9 / var_50_8)

				if var_50_10 > 0 and var_50_5 < var_50_10 then
					arg_47_1.talkMaxDuration = var_50_10

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_11 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_11 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_11

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_11 and arg_47_1.time_ < var_50_4 + var_50_11 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play114142012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 114142012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play114142013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 1.35

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(114142012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 54
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play114142013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 114142013
		arg_55_1.duration_ = 2.4

		local var_55_0 = {
			ja = 2.133,
			ko = 1.966,
			zh = 2.4,
			en = 1.666
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
				arg_55_0:Play114142014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.2

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[214].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(114142013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 8
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142013", "story_v_out_114142.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_114142", "114142013", "story_v_out_114142.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_114142", "114142013", "story_v_out_114142.awb")

						arg_55_1:RecordAudio("114142013", var_58_9)
						arg_55_1:RecordAudio("114142013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_114142", "114142013", "story_v_out_114142.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_114142", "114142013", "story_v_out_114142.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play114142014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 114142014
		arg_59_1.duration_ = 1.8

		local var_59_0 = {
			ja = 1.2,
			ko = 1.2,
			zh = 1.8,
			en = 1.5
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play114142015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.125

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[215].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(114142014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 5
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142014", "story_v_out_114142.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_114142", "114142014", "story_v_out_114142.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_114142", "114142014", "story_v_out_114142.awb")

						arg_59_1:RecordAudio("114142014", var_62_9)
						arg_59_1:RecordAudio("114142014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_114142", "114142014", "story_v_out_114142.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_114142", "114142014", "story_v_out_114142.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play114142015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 114142015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play114142016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.725

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

				local var_66_2 = arg_63_1:GetWordFromCfg(114142015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 29
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
	Play114142016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 114142016
		arg_67_1.duration_ = 7

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play114142017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_1 = 2

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_1 then
				local var_70_2 = (arg_67_1.time_ - var_70_0) / var_70_1
				local var_70_3 = Color.New(1, 1, 1)

				var_70_3.a = Mathf.Lerp(1, 0, var_70_2)
				arg_67_1.mask_.color = var_70_3
			end

			if arg_67_1.time_ >= var_70_0 + var_70_1 and arg_67_1.time_ < var_70_0 + var_70_1 + arg_70_0 then
				local var_70_4 = Color.New(1, 1, 1)
				local var_70_5 = 0

				arg_67_1.mask_.enabled = false
				var_70_4.a = var_70_5
				arg_67_1.mask_.color = var_70_4
			end

			local var_70_6 = manager.ui.mainCamera.transform
			local var_70_7 = 1

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 then
				arg_67_1.var_.shakeOldPos = var_70_6.localPosition
			end

			local var_70_8 = 1

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 then
				local var_70_9 = (arg_67_1.time_ - var_70_7) / 0.066
				local var_70_10, var_70_11 = math.modf(var_70_9)

				var_70_6.localPosition = Vector3.New(var_70_11 * 0.13, var_70_11 * 0.13, var_70_11 * 0.13) + arg_67_1.var_.shakeOldPos
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 then
				var_70_6.localPosition = arg_67_1.var_.shakeOldPos
			end

			local var_70_12 = 1.999999999999
			local var_70_13 = 1

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				local var_70_14 = "play"
				local var_70_15 = "effect"

				arg_67_1:AudioAction(var_70_14, var_70_15, "se_story_11", "se_story_11_attack", "")
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_16 = 1.999999999999
			local var_70_17 = 0.175

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_18 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_18:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_19 = arg_67_1:GetWordFromCfg(114142016)
				local var_70_20 = arg_67_1:FormatText(var_70_19.content)

				arg_67_1.text_.text = var_70_20

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_21 = 7
				local var_70_22 = utf8.len(var_70_20)
				local var_70_23 = var_70_21 <= 0 and var_70_17 or var_70_17 * (var_70_22 / var_70_21)

				if var_70_23 > 0 and var_70_17 < var_70_23 then
					arg_67_1.talkMaxDuration = var_70_23
					var_70_16 = var_70_16 + 0.3

					if var_70_23 + var_70_16 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_16
					end
				end

				arg_67_1.text_.text = var_70_20
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_24 = var_70_16 + 0.3
			local var_70_25 = math.max(var_70_17, arg_67_1.talkMaxDuration)

			if var_70_24 <= arg_67_1.time_ and arg_67_1.time_ < var_70_24 + var_70_25 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_24) / var_70_25

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_24 + var_70_25 and arg_67_1.time_ < var_70_24 + var_70_25 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play114142017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114142017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114142018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				local var_76_2 = "play"
				local var_76_3 = "effect"

				arg_73_1:AudioAction(var_76_2, var_76_3, "se_story_11", "se_story_11_attack02", "")
			end

			local var_76_4 = 0
			local var_76_5 = 1.15

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(114142017)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_8 = 46
				local var_76_9 = utf8.len(var_76_7)
				local var_76_10 = var_76_8 <= 0 and var_76_5 or var_76_5 * (var_76_9 / var_76_8)

				if var_76_10 > 0 and var_76_5 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_11 and arg_73_1.time_ < var_76_4 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114142018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114142018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114142019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.725

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(114142018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 69
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114142019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114142019
		arg_81_1.duration_ = 9

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114142020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 2

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				local var_84_1 = manager.ui.mainCamera.transform.localPosition
				local var_84_2 = Vector3.New(0, 0, 10) + Vector3.New(var_84_1.x, var_84_1.y, 0)
				local var_84_3 = arg_81_1.bgs_.F04

				var_84_3.transform.localPosition = var_84_2
				var_84_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_4 = var_84_3:GetComponent("SpriteRenderer")

				if var_84_4 and var_84_4.sprite then
					local var_84_5 = (var_84_3.transform.localPosition - var_84_1).z
					local var_84_6 = manager.ui.mainCameraCom_
					local var_84_7 = 2 * var_84_5 * Mathf.Tan(var_84_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_84_8 = var_84_7 * var_84_6.aspect
					local var_84_9 = var_84_4.sprite.bounds.size.x
					local var_84_10 = var_84_4.sprite.bounds.size.y
					local var_84_11 = var_84_8 / var_84_9
					local var_84_12 = var_84_7 / var_84_10
					local var_84_13 = var_84_12 < var_84_11 and var_84_11 or var_84_12

					var_84_3.transform.localScale = Vector3.New(var_84_13, var_84_13, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "F04" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_15 = 2

			if var_84_14 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_15 then
				local var_84_16 = (arg_81_1.time_ - var_84_14) / var_84_15
				local var_84_17 = Color.New(0, 0, 0)

				var_84_17.a = Mathf.Lerp(0, 1, var_84_16)
				arg_81_1.mask_.color = var_84_17
			end

			if arg_81_1.time_ >= var_84_14 + var_84_15 and arg_81_1.time_ < var_84_14 + var_84_15 + arg_84_0 then
				local var_84_18 = Color.New(0, 0, 0)

				var_84_18.a = 1
				arg_81_1.mask_.color = var_84_18
			end

			local var_84_19 = 2

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_20 = 2

			if var_84_19 <= arg_81_1.time_ and arg_81_1.time_ < var_84_19 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_19) / var_84_20
				local var_84_22 = Color.New(0, 0, 0)

				var_84_22.a = Mathf.Lerp(1, 0, var_84_21)
				arg_81_1.mask_.color = var_84_22
			end

			if arg_81_1.time_ >= var_84_19 + var_84_20 and arg_81_1.time_ < var_84_19 + var_84_20 + arg_84_0 then
				local var_84_23 = Color.New(0, 0, 0)
				local var_84_24 = 0

				arg_81_1.mask_.enabled = false
				var_84_23.a = var_84_24
				arg_81_1.mask_.color = var_84_23
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_25 = 4
			local var_84_26 = 0.825

			if var_84_25 < arg_81_1.time_ and arg_81_1.time_ <= var_84_25 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_27 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_27:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_28 = arg_81_1:GetWordFromCfg(114142019)
				local var_84_29 = arg_81_1:FormatText(var_84_28.content)

				arg_81_1.text_.text = var_84_29

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_30 = 33
				local var_84_31 = utf8.len(var_84_29)
				local var_84_32 = var_84_30 <= 0 and var_84_26 or var_84_26 * (var_84_31 / var_84_30)

				if var_84_32 > 0 and var_84_26 < var_84_32 then
					arg_81_1.talkMaxDuration = var_84_32
					var_84_25 = var_84_25 + 0.3

					if var_84_32 + var_84_25 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_32 + var_84_25
					end
				end

				arg_81_1.text_.text = var_84_29
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_33 = var_84_25 + 0.3
			local var_84_34 = math.max(var_84_26, arg_81_1.talkMaxDuration)

			if var_84_33 <= arg_81_1.time_ and arg_81_1.time_ < var_84_33 + var_84_34 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_33) / var_84_34

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_33 + var_84_34 and arg_81_1.time_ < var_84_33 + var_84_34 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114142020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114142020
		arg_87_1.duration_ = 3.67

		local var_87_0 = {
			ja = 3.666,
			ko = 2.966,
			zh = 3.5,
			en = 2.4
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play114142021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "6045_story"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_90_1) then
					local var_90_2 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_87_1.stage_.transform)

					var_90_2.name = var_90_0
					var_90_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_87_1.actors_[var_90_0] = var_90_2

					local var_90_3 = var_90_2:GetComponentInChildren(typeof(CharacterEffect))

					var_90_3.enabled = true

					local var_90_4 = GameObjectTools.GetOrAddComponent(var_90_2, typeof(DynamicBoneHelper))

					if var_90_4 then
						var_90_4:EnableDynamicBone(false)
					end

					arg_87_1:ShowWeapon(var_90_3.transform, false)

					arg_87_1.var_[var_90_0 .. "Animator"] = var_90_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_87_1.var_[var_90_0 .. "Animator"].applyRootMotion = true
					arg_87_1.var_[var_90_0 .. "LipSync"] = var_90_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_90_5 = arg_87_1.actors_["6045_story"].transform
			local var_90_6 = 0

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.var_.moveOldPos6045_story = var_90_5.localPosition

				local var_90_7 = GameObjectTools.GetOrAddComponent(var_90_5.gameObject, typeof(DynamicBoneHelper))

				if var_90_7 then
					var_90_7:EnableDynamicBone(false)
				end
			end

			local var_90_8 = 0.001

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_8 then
				local var_90_9 = (arg_87_1.time_ - var_90_6) / var_90_8
				local var_90_10 = Vector3.New(0.7, -0.5, -6.3)

				var_90_5.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos6045_story, var_90_10, var_90_9)

				local var_90_11 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_11.x, var_90_11.y, var_90_11.z)

				local var_90_12 = var_90_5.localEulerAngles

				var_90_12.z = 0
				var_90_12.x = 0
				var_90_5.localEulerAngles = var_90_12
			end

			if arg_87_1.time_ >= var_90_6 + var_90_8 and arg_87_1.time_ < var_90_6 + var_90_8 + arg_90_0 then
				var_90_5.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_90_13 = manager.ui.mainCamera.transform.position - var_90_5.position

				var_90_5.forward = Vector3.New(var_90_13.x, var_90_13.y, var_90_13.z)

				local var_90_14 = var_90_5.localEulerAngles

				var_90_14.z = 0
				var_90_14.x = 0
				var_90_5.localEulerAngles = var_90_14

				local var_90_15 = GameObjectTools.GetOrAddComponent(var_90_5.gameObject, typeof(DynamicBoneHelper))

				if var_90_15 then
					var_90_15:EnableDynamicBone(true)
				end
			end

			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_90_17 = 0

			if var_90_17 < arg_87_1.time_ and arg_87_1.time_ <= var_90_17 + arg_90_0 then
				arg_87_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_90_18 = arg_87_1.actors_["6045_story"]
			local var_90_19 = 0

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 and not isNil(var_90_18) and arg_87_1.var_.characterEffect6045_story == nil then
				arg_87_1.var_.characterEffect6045_story = var_90_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_20 = 0.2

			if var_90_19 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 and not isNil(var_90_18) then
				local var_90_21 = (arg_87_1.time_ - var_90_19) / var_90_20

				if arg_87_1.var_.characterEffect6045_story and not isNil(var_90_18) then
					arg_87_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 and not isNil(var_90_18) and arg_87_1.var_.characterEffect6045_story then
				arg_87_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_90_22 = "6046_story"

			if arg_87_1.actors_[var_90_22] == nil then
				local var_90_23 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_90_23) then
					local var_90_24 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_87_1.stage_.transform)

					var_90_24.name = var_90_22
					var_90_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_87_1.actors_[var_90_22] = var_90_24

					local var_90_25 = var_90_24:GetComponentInChildren(typeof(CharacterEffect))

					var_90_25.enabled = true

					local var_90_26 = GameObjectTools.GetOrAddComponent(var_90_24, typeof(DynamicBoneHelper))

					if var_90_26 then
						var_90_26:EnableDynamicBone(false)
					end

					arg_87_1:ShowWeapon(var_90_25.transform, false)

					arg_87_1.var_[var_90_22 .. "Animator"] = var_90_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_87_1.var_[var_90_22 .. "Animator"].applyRootMotion = true
					arg_87_1.var_[var_90_22 .. "LipSync"] = var_90_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_90_27 = 0

			if var_90_27 < arg_87_1.time_ and arg_87_1.time_ <= var_90_27 + arg_90_0 then
				arg_87_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_90_28 = 0

			if var_90_28 < arg_87_1.time_ and arg_87_1.time_ <= var_90_28 + arg_90_0 then
				arg_87_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_90_29 = arg_87_1.actors_["6046_story"]
			local var_90_30 = 0

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 and not isNil(var_90_29) and arg_87_1.var_.characterEffect6046_story == nil then
				arg_87_1.var_.characterEffect6046_story = var_90_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_31 = 0.2

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_31 and not isNil(var_90_29) then
				local var_90_32 = (arg_87_1.time_ - var_90_30) / var_90_31

				if arg_87_1.var_.characterEffect6046_story and not isNil(var_90_29) then
					arg_87_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_30 + var_90_31 and arg_87_1.time_ < var_90_30 + var_90_31 + arg_90_0 and not isNil(var_90_29) and arg_87_1.var_.characterEffect6046_story then
				arg_87_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_90_33 = arg_87_1.actors_["6046_story"].transform
			local var_90_34 = 0

			if var_90_34 < arg_87_1.time_ and arg_87_1.time_ <= var_90_34 + arg_90_0 then
				arg_87_1.var_.moveOldPos6046_story = var_90_33.localPosition

				local var_90_35 = GameObjectTools.GetOrAddComponent(var_90_33.gameObject, typeof(DynamicBoneHelper))

				if var_90_35 then
					var_90_35:EnableDynamicBone(false)
				end
			end

			local var_90_36 = 0.001

			if var_90_34 <= arg_87_1.time_ and arg_87_1.time_ < var_90_34 + var_90_36 then
				local var_90_37 = (arg_87_1.time_ - var_90_34) / var_90_36
				local var_90_38 = Vector3.New(-0.7, -0.5, -6.3)

				var_90_33.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos6046_story, var_90_38, var_90_37)

				local var_90_39 = manager.ui.mainCamera.transform.position - var_90_33.position

				var_90_33.forward = Vector3.New(var_90_39.x, var_90_39.y, var_90_39.z)

				local var_90_40 = var_90_33.localEulerAngles

				var_90_40.z = 0
				var_90_40.x = 0
				var_90_33.localEulerAngles = var_90_40
			end

			if arg_87_1.time_ >= var_90_34 + var_90_36 and arg_87_1.time_ < var_90_34 + var_90_36 + arg_90_0 then
				var_90_33.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_90_41 = manager.ui.mainCamera.transform.position - var_90_33.position

				var_90_33.forward = Vector3.New(var_90_41.x, var_90_41.y, var_90_41.z)

				local var_90_42 = var_90_33.localEulerAngles

				var_90_42.z = 0
				var_90_42.x = 0
				var_90_33.localEulerAngles = var_90_42

				local var_90_43 = GameObjectTools.GetOrAddComponent(var_90_33.gameObject, typeof(DynamicBoneHelper))

				if var_90_43 then
					var_90_43:EnableDynamicBone(true)
				end
			end

			local var_90_44 = 0
			local var_90_45 = 0.275

			if var_90_44 < arg_87_1.time_ and arg_87_1.time_ <= var_90_44 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_46 = arg_87_1:FormatText(StoryNameCfg[233].name)

				arg_87_1.leftNameTxt_.text = var_90_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_47 = arg_87_1:GetWordFromCfg(114142020)
				local var_90_48 = arg_87_1:FormatText(var_90_47.content)

				arg_87_1.text_.text = var_90_48

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_49 = 11
				local var_90_50 = utf8.len(var_90_48)
				local var_90_51 = var_90_49 <= 0 and var_90_45 or var_90_45 * (var_90_50 / var_90_49)

				if var_90_51 > 0 and var_90_45 < var_90_51 then
					arg_87_1.talkMaxDuration = var_90_51

					if var_90_51 + var_90_44 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_51 + var_90_44
					end
				end

				arg_87_1.text_.text = var_90_48
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142020", "story_v_out_114142.awb") ~= 0 then
					local var_90_52 = manager.audio:GetVoiceLength("story_v_out_114142", "114142020", "story_v_out_114142.awb") / 1000

					if var_90_52 + var_90_44 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_52 + var_90_44
					end

					if var_90_47.prefab_name ~= "" and arg_87_1.actors_[var_90_47.prefab_name] ~= nil then
						local var_90_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_47.prefab_name].transform, "story_v_out_114142", "114142020", "story_v_out_114142.awb")

						arg_87_1:RecordAudio("114142020", var_90_53)
						arg_87_1:RecordAudio("114142020", var_90_53)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_114142", "114142020", "story_v_out_114142.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_114142", "114142020", "story_v_out_114142.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_54 = math.max(var_90_45, arg_87_1.talkMaxDuration)

			if var_90_44 <= arg_87_1.time_ and arg_87_1.time_ < var_90_44 + var_90_54 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_44) / var_90_54

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_44 + var_90_54 and arg_87_1.time_ < var_90_44 + var_90_54 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play114142021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114142021
		arg_91_1.duration_ = 5.37

		local var_91_0 = {
			ja = 5.366,
			ko = 2.666,
			zh = 3.733,
			en = 4.033
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play114142022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["6046_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos6046_story = var_94_0.localPosition

				local var_94_2 = GameObjectTools.GetOrAddComponent(var_94_0.gameObject, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(false)
				end
			end

			local var_94_3 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_3 then
				local var_94_4 = (arg_91_1.time_ - var_94_1) / var_94_3
				local var_94_5 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos6046_story, var_94_5, var_94_4)

				local var_94_6 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_6.x, var_94_6.y, var_94_6.z)

				local var_94_7 = var_94_0.localEulerAngles

				var_94_7.z = 0
				var_94_7.x = 0
				var_94_0.localEulerAngles = var_94_7
			end

			if arg_91_1.time_ >= var_94_1 + var_94_3 and arg_91_1.time_ < var_94_1 + var_94_3 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_8 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_8.x, var_94_8.y, var_94_8.z)

				local var_94_9 = var_94_0.localEulerAngles

				var_94_9.z = 0
				var_94_9.x = 0
				var_94_0.localEulerAngles = var_94_9

				local var_94_10 = GameObjectTools.GetOrAddComponent(var_94_0.gameObject, typeof(DynamicBoneHelper))

				if var_94_10 then
					var_94_10:EnableDynamicBone(true)
				end
			end

			local var_94_11 = arg_91_1.actors_["6045_story"].transform
			local var_94_12 = 0

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.var_.moveOldPos6045_story = var_94_11.localPosition

				local var_94_13 = GameObjectTools.GetOrAddComponent(var_94_11.gameObject, typeof(DynamicBoneHelper))

				if var_94_13 then
					var_94_13:EnableDynamicBone(false)
				end
			end

			local var_94_14 = 0.001

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_14 then
				local var_94_15 = (arg_91_1.time_ - var_94_12) / var_94_14
				local var_94_16 = Vector3.New(0, 100, 0)

				var_94_11.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos6045_story, var_94_16, var_94_15)

				local var_94_17 = manager.ui.mainCamera.transform.position - var_94_11.position

				var_94_11.forward = Vector3.New(var_94_17.x, var_94_17.y, var_94_17.z)

				local var_94_18 = var_94_11.localEulerAngles

				var_94_18.z = 0
				var_94_18.x = 0
				var_94_11.localEulerAngles = var_94_18
			end

			if arg_91_1.time_ >= var_94_12 + var_94_14 and arg_91_1.time_ < var_94_12 + var_94_14 + arg_94_0 then
				var_94_11.localPosition = Vector3.New(0, 100, 0)

				local var_94_19 = manager.ui.mainCamera.transform.position - var_94_11.position

				var_94_11.forward = Vector3.New(var_94_19.x, var_94_19.y, var_94_19.z)

				local var_94_20 = var_94_11.localEulerAngles

				var_94_20.z = 0
				var_94_20.x = 0
				var_94_11.localEulerAngles = var_94_20

				local var_94_21 = GameObjectTools.GetOrAddComponent(var_94_11.gameObject, typeof(DynamicBoneHelper))

				if var_94_21 then
					var_94_21:EnableDynamicBone(true)
				end
			end

			local var_94_22 = arg_91_1.actors_["1068ui_story"].transform
			local var_94_23 = 0

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.var_.moveOldPos1068ui_story = var_94_22.localPosition
			end

			local var_94_24 = 0.001

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_24 then
				local var_94_25 = (arg_91_1.time_ - var_94_23) / var_94_24
				local var_94_26 = Vector3.New(0, -0.95, -5.88)

				var_94_22.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1068ui_story, var_94_26, var_94_25)

				local var_94_27 = manager.ui.mainCamera.transform.position - var_94_22.position

				var_94_22.forward = Vector3.New(var_94_27.x, var_94_27.y, var_94_27.z)

				local var_94_28 = var_94_22.localEulerAngles

				var_94_28.z = 0
				var_94_28.x = 0
				var_94_22.localEulerAngles = var_94_28
			end

			if arg_91_1.time_ >= var_94_23 + var_94_24 and arg_91_1.time_ < var_94_23 + var_94_24 + arg_94_0 then
				var_94_22.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_94_29 = manager.ui.mainCamera.transform.position - var_94_22.position

				var_94_22.forward = Vector3.New(var_94_29.x, var_94_29.y, var_94_29.z)

				local var_94_30 = var_94_22.localEulerAngles

				var_94_30.z = 0
				var_94_30.x = 0
				var_94_22.localEulerAngles = var_94_30
			end

			local var_94_31 = 0

			if var_94_31 < arg_91_1.time_ and arg_91_1.time_ <= var_94_31 + arg_94_0 then
				arg_91_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action6_1")
			end

			local var_94_32 = 0

			if var_94_32 < arg_91_1.time_ and arg_91_1.time_ <= var_94_32 + arg_94_0 then
				arg_91_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_94_33 = arg_91_1.actors_["1068ui_story"]
			local var_94_34 = 0

			if var_94_34 < arg_91_1.time_ and arg_91_1.time_ <= var_94_34 + arg_94_0 and not isNil(var_94_33) and arg_91_1.var_.characterEffect1068ui_story == nil then
				arg_91_1.var_.characterEffect1068ui_story = var_94_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_35 = 0.2

			if var_94_34 <= arg_91_1.time_ and arg_91_1.time_ < var_94_34 + var_94_35 and not isNil(var_94_33) then
				local var_94_36 = (arg_91_1.time_ - var_94_34) / var_94_35

				if arg_91_1.var_.characterEffect1068ui_story and not isNil(var_94_33) then
					arg_91_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_34 + var_94_35 and arg_91_1.time_ < var_94_34 + var_94_35 + arg_94_0 and not isNil(var_94_33) and arg_91_1.var_.characterEffect1068ui_story then
				arg_91_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_94_37 = 0
			local var_94_38 = 0.225

			if var_94_37 < arg_91_1.time_ and arg_91_1.time_ <= var_94_37 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_39 = arg_91_1:FormatText(StoryNameCfg[218].name)

				arg_91_1.leftNameTxt_.text = var_94_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_40 = arg_91_1:GetWordFromCfg(114142021)
				local var_94_41 = arg_91_1:FormatText(var_94_40.content)

				arg_91_1.text_.text = var_94_41

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_42 = 9
				local var_94_43 = utf8.len(var_94_41)
				local var_94_44 = var_94_42 <= 0 and var_94_38 or var_94_38 * (var_94_43 / var_94_42)

				if var_94_44 > 0 and var_94_38 < var_94_44 then
					arg_91_1.talkMaxDuration = var_94_44

					if var_94_44 + var_94_37 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_44 + var_94_37
					end
				end

				arg_91_1.text_.text = var_94_41
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142021", "story_v_out_114142.awb") ~= 0 then
					local var_94_45 = manager.audio:GetVoiceLength("story_v_out_114142", "114142021", "story_v_out_114142.awb") / 1000

					if var_94_45 + var_94_37 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_45 + var_94_37
					end

					if var_94_40.prefab_name ~= "" and arg_91_1.actors_[var_94_40.prefab_name] ~= nil then
						local var_94_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_40.prefab_name].transform, "story_v_out_114142", "114142021", "story_v_out_114142.awb")

						arg_91_1:RecordAudio("114142021", var_94_46)
						arg_91_1:RecordAudio("114142021", var_94_46)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_114142", "114142021", "story_v_out_114142.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_114142", "114142021", "story_v_out_114142.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_47 = math.max(var_94_38, arg_91_1.talkMaxDuration)

			if var_94_37 <= arg_91_1.time_ and arg_91_1.time_ < var_94_37 + var_94_47 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_37) / var_94_47

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_37 + var_94_47 and arg_91_1.time_ < var_94_37 + var_94_47 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play114142022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114142022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114142023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1068ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1068ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, 100, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1068ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, 100, 0)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = 0
			local var_98_10 = 1

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_11 = arg_95_1:GetWordFromCfg(114142022)
				local var_98_12 = arg_95_1:FormatText(var_98_11.content)

				arg_95_1.text_.text = var_98_12

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 40
				local var_98_14 = utf8.len(var_98_12)
				local var_98_15 = var_98_13 <= 0 and var_98_10 or var_98_10 * (var_98_14 / var_98_13)

				if var_98_15 > 0 and var_98_10 < var_98_15 then
					arg_95_1.talkMaxDuration = var_98_15

					if var_98_15 + var_98_9 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_15 + var_98_9
					end
				end

				arg_95_1.text_.text = var_98_12
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_10, arg_95_1.talkMaxDuration)

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_9) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_9 + var_98_16 and arg_95_1.time_ < var_98_9 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play114142023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114142023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114142024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.05

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(114142023)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 42
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114142024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114142024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114142025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.3

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(114142024)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 52
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114142025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114142025
		arg_107_1.duration_ = 6.1

		local var_107_0 = {
			ja = 4.9,
			ko = 4.5,
			zh = 4.366,
			en = 6.1
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play114142026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.525

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[210].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(114142025)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 20
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114142", "114142025", "story_v_out_114142.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_114142", "114142025", "story_v_out_114142.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_114142", "114142025", "story_v_out_114142.awb")

						arg_107_1:RecordAudio("114142025", var_110_9)
						arg_107_1:RecordAudio("114142025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114142", "114142025", "story_v_out_114142.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114142", "114142025", "story_v_out_114142.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114142026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114142026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
			arg_111_1.auto_ = false
		end

		function arg_111_1.playNext_(arg_113_0)
			arg_111_1.onStoryFinished_()
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.975

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(114142026)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 39
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/OM0208"
	},
	voices = {
		"story_v_out_114142.awb"
	}
}
