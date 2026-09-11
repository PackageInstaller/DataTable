return {
	Play426081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426081001
		arg_1_1.duration_ = 12.43

		local var_1_0 = {
			zh = 10.899999999999,
			ja = 12.432999999999
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
				arg_1_0:Play426081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2401 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2401")
				var_4_0.name = "ST2401"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2401 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2401

				arg_1_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2401" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 1.999999999999
			local var_4_14 = 1.1

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(426081001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 44 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 44)

				if (44 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 44)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081001", "story_v_out_426081.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_426081", "426081001", "story_v_out_426081.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_426081", "426081001", "story_v_out_426081.awb")

						arg_1_1:RecordAudio("426081001", var_4_21)
						arg_1_1:RecordAudio("426081001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_426081", "426081001", "story_v_out_426081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_426081", "426081001", "story_v_out_426081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 426081002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play426081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.675

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(426081002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 27 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 27)

				if (27 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 27)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play426081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 426081003
		arg_12_1.duration_ = 7.07

		local var_12_0 = {
			zh = 7.066,
			ja = 6.833
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
				arg_12_0:Play426081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.975

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(426081003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 39 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 39)

				if (39 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 39)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081003", "story_v_out_426081.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081003", "story_v_out_426081.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_426081", "426081003", "story_v_out_426081.awb")

						arg_12_1:RecordAudio("426081003", var_15_6)
						arg_12_1:RecordAudio("426081003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_426081", "426081003", "story_v_out_426081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_426081", "426081003", "story_v_out_426081.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play426081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 426081004
		arg_16_1.duration_ = 7.2

		local var_16_0 = {
			zh = 5.733,
			ja = 7.2
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
				arg_16_0:Play426081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.875

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(426081004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 35 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 35)

				if (35 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 35)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081004", "story_v_out_426081.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081004", "story_v_out_426081.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_426081", "426081004", "story_v_out_426081.awb")

						arg_16_1:RecordAudio("426081004", var_19_6)
						arg_16_1:RecordAudio("426081004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_426081", "426081004", "story_v_out_426081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_426081", "426081004", "story_v_out_426081.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play426081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 426081005
		arg_20_1.duration_ = 9

		local var_20_0 = {
			zh = 5.266,
			ja = 9
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
				arg_20_0:Play426081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.75

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(426081005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 30 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 30)

				if (30 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 30)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081005", "story_v_out_426081.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081005", "story_v_out_426081.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_426081", "426081005", "story_v_out_426081.awb")

						arg_20_1:RecordAudio("426081005", var_23_6)
						arg_20_1:RecordAudio("426081005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_426081", "426081005", "story_v_out_426081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_426081", "426081005", "story_v_out_426081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play426081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 426081006
		arg_24_1.duration_ = 12.03

		local var_24_0 = {
			zh = 9.266,
			ja = 12.033
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
				arg_24_0:Play426081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.125

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(426081006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 45 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 45)

				if (45 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 45)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081006", "story_v_out_426081.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081006", "story_v_out_426081.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_426081", "426081006", "story_v_out_426081.awb")

						arg_24_1:RecordAudio("426081006", var_27_6)
						arg_24_1:RecordAudio("426081006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_426081", "426081006", "story_v_out_426081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_426081", "426081006", "story_v_out_426081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play426081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 426081007
		arg_28_1.duration_ = 8.6

		local var_28_0 = {
			zh = 4.766,
			ja = 8.6
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
				arg_28_0:Play426081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.675

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(426081007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 27 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 27)

				if (27 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 27)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081007", "story_v_out_426081.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081007", "story_v_out_426081.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_426081", "426081007", "story_v_out_426081.awb")

						arg_28_1:RecordAudio("426081007", var_31_6)
						arg_28_1:RecordAudio("426081007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_426081", "426081007", "story_v_out_426081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_426081", "426081007", "story_v_out_426081.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play426081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 426081008
		arg_32_1.duration_ = 4.57

		local var_32_0 = {
			zh = 3.6,
			ja = 4.566
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
				arg_32_0:Play426081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.35

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(426081008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 14 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 14)

				if (14 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 14)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081008", "story_v_out_426081.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081008", "story_v_out_426081.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_426081", "426081008", "story_v_out_426081.awb")

						arg_32_1:RecordAudio("426081008", var_35_6)
						arg_32_1:RecordAudio("426081008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_426081", "426081008", "story_v_out_426081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_426081", "426081008", "story_v_out_426081.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play426081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 426081009
		arg_36_1.duration_ = 6.93

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play426081010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_39_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_2 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_2

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_2
						arg_36_1.bgmTxt2_.text = var_39_2
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_36_1.time_ and arg_36_1.time_ <= 0.433333333333333 + arg_39_0 then
				arg_36_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_39_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_5 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_5

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_5
						arg_36_1.bgmTxt2_.text = var_39_5
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_36_1.time_ and arg_36_1.time_ <= 0.133333333333333 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car02", "")
			end

			if 0.133333333333333 < arg_36_1.time_ and arg_36_1.time_ <= 0.133333333333333 + arg_39_0 then
				arg_36_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if 0.433333333333333 < arg_36_1.time_ and arg_36_1.time_ <= 0.433333333333333 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_39_9 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_9 + 2.26666666666667 and arg_36_1.time_ < var_39_9 + 2.26666666666667 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_10 = manager.ui.mainCamera.transform

			if 0.866666666666667 < arg_36_1.time_ and arg_36_1.time_ <= 0.866666666666667 + arg_39_0 then
				arg_36_1.var_.shakeOldPos = var_39_10.localPosition
			end

			local var_39_11 = 0.4666667

			if 0.866666666666667 <= arg_36_1.time_ and arg_36_1.time_ < 0.866666666666667 + var_39_11 then
				local var_39_12, var_39_13 = math.modf((arg_36_1.time_ - 0.866666666666667) / 0.066)

				var_39_10.localPosition = Vector3.New(var_39_13 * 0.13, var_39_13 * 0.13, var_39_13 * 0.13) + arg_36_1.var_.shakeOldPos
			end

			if arg_36_1.time_ >= 0.866666666666667 + var_39_11 and arg_36_1.time_ < 0.866666666666667 + var_39_11 + arg_39_0 then
				var_39_10.localPosition = arg_36_1.var_.shakeOldPos
			end

			local var_39_14 = arg_36_1.bgs_.ST2401.transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPosST2401 = var_39_14.localPosition
			end

			local var_39_15 = 1.63333333333333

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_15 then
				var_39_14.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosST2401, Vector3.New(0, 1, 8.5), (arg_36_1.time_ - 0) / var_39_15)
			end

			if arg_36_1.time_ >= 0 + var_39_15 and arg_36_1.time_ < 0 + var_39_15 + arg_39_0 then
				var_39_14.localPosition = Vector3.New(0, 1, 8.5)
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_16 = 1.93333333333333
			local var_39_17 = 1.175

			if 1.93333333333333 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_18 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_18:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_36_1.dialogCg_.alpha = arg_42_0
				end))
				var_39_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(426081009).content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 47 <= 0 and var_39_17 or var_39_17 * (utf8.len(var_39_19) / 47)

				if (47 <= 0 and var_39_17 or var_39_17 * (utf8.len(var_39_19) / 47)) > 0 and var_39_17 < var_39_21 then
					arg_36_1.talkMaxDuration = var_39_21
					var_39_16 = var_39_16 + 0.3

					if var_39_21 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_21 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = var_39_16 + 0.3
			local var_39_23 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_16 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_22 + var_39_23 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_22) / var_39_23

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_22 + var_39_23 and arg_36_1.time_ < var_39_22 + var_39_23 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST2401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.63333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 8.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play426081010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 426081010
		arg_44_1.duration_ = 5.17

		local var_44_0 = {
			zh = 4.3,
			ja = 5.166
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
				arg_44_0:Play426081011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.3

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(426081010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 12 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 12)

				if (12 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 12)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081010", "story_v_out_426081.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081010", "story_v_out_426081.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_426081", "426081010", "story_v_out_426081.awb")

						arg_44_1:RecordAudio("426081010", var_47_6)
						arg_44_1:RecordAudio("426081010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_426081", "426081010", "story_v_out_426081.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_426081", "426081010", "story_v_out_426081.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play426081011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 426081011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play426081012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(426081011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 20)

				if (20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 20)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play426081012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 426081012
		arg_52_1.duration_ = 5.03

		local var_52_0 = {
			zh = 4.433,
			ja = 5.033
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
				arg_52_0:Play426081013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.475

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:GetWordFromCfg(426081012)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 19 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 19)

				if (19 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 19)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081012", "story_v_out_426081.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081012", "story_v_out_426081.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_426081", "426081012", "story_v_out_426081.awb")

						arg_52_1:RecordAudio("426081012", var_55_6)
						arg_52_1:RecordAudio("426081012", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_426081", "426081012", "story_v_out_426081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_426081", "426081012", "story_v_out_426081.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play426081013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 426081013
		arg_56_1.duration_ = 8.07

		local var_56_0 = {
			zh = 7.2,
			ja = 8.066
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
				arg_56_0:Play426081014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if arg_56_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_59_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_56_1.stage_.transform)

				var_59_0.name = "1054ui_story"
				var_59_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["1054ui_story"] = var_59_0

				local var_59_1 = var_59_0:GetComponentInChildren(typeof(CharacterEffect))

				var_59_1.enabled = true

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_1.transform, false)

				arg_56_1.var_["1054ui_story" .. "Animator"] = var_59_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_56_1.var_["1054ui_story" .. "LipSync"] = var_59_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_3 = arg_56_1.actors_["1054ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1054ui_story = var_59_3.localPosition

				local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_4 then
					var_59_4:EnableDynamicBone(false)
				end
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_56_1.time_ - 0) / var_59_5)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0, -0.985, -6)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(true)
				end
			end

			local var_59_7 = arg_56_1.actors_["1054ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect1054ui_story == nil then
				arg_56_1.var_.characterEffect1054ui_story = var_59_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_8 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_8 and not isNil(var_59_7) then
				if arg_56_1.var_.characterEffect1054ui_story and not isNil(var_59_7) then
					arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_8 and arg_56_1.time_ < 0 + var_59_8 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect1054ui_story then
				arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_59_10 = 0
			local var_59_11 = 0.8

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_12 = arg_56_1:GetWordFromCfg(426081013)
				local var_59_13 = arg_56_1:FormatText(var_59_12.content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 32 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 32)

				if (32 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 32)) > 0 and var_59_11 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081013", "story_v_out_426081.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_out_426081", "426081013", "story_v_out_426081.awb") / 1000

					if var_59_16 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_10
					end

					if var_59_12.prefab_name ~= "" and arg_56_1.actors_[var_59_12.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_12.prefab_name].transform, "story_v_out_426081", "426081013", "story_v_out_426081.awb")

						arg_56_1:RecordAudio("426081013", var_59_17)
						arg_56_1:RecordAudio("426081013", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_426081", "426081013", "story_v_out_426081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_426081", "426081013", "story_v_out_426081.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_18 and arg_56_1.time_ < var_59_10 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play426081014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 426081014
		arg_60_1.duration_ = 1.8

		local var_60_0 = {
			zh = 1.1,
			ja = 1.8
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
				arg_60_0:Play426081015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = arg_60_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) then
				if arg_60_1.var_.characterEffect1054ui_story and not isNil(arg_60_1.actors_["1054ui_story"]) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.125

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(426081014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 5 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 5)

				if (5 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 5)) > 0 and var_63_2 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081014", "story_v_out_426081.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_out_426081", "426081014", "story_v_out_426081.awb") / 1000

					if var_63_7 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_1
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_426081", "426081014", "story_v_out_426081.awb")

						arg_60_1:RecordAudio("426081014", var_63_8)
						arg_60_1:RecordAudio("426081014", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_426081", "426081014", "story_v_out_426081.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_426081", "426081014", "story_v_out_426081.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_9 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_9

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_9 and arg_60_1.time_ < var_63_1 + var_63_9 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play426081015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 426081015
		arg_64_1.duration_ = 2.03

		local var_64_0 = {
			zh = 1.491,
			ja = 2.025
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
				arg_64_0:Play426081016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = arg_64_1.actors_["1054ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).z)
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles = arg_64_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).z)
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles = arg_64_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = manager.ui.mainCamera.transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.shakeOldPos = var_67_3.localPosition
			end

			local var_67_4 = 0.6

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				local var_67_5, var_67_6 = math.modf((arg_64_1.time_ - 0) / 0.066)

				var_67_3.localPosition = Vector3.New(var_67_6 * 0.13, var_67_6 * 0.13, var_67_6 * 0.13) + arg_64_1.var_.shakeOldPos
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_3.localPosition = arg_64_1.var_.shakeOldPos
			end

			local var_67_7 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			if arg_64_1.time_ >= var_67_7 + 0.6 and arg_64_1.time_ < var_67_7 + 0.6 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_8 = 0.425
			local var_67_9 = 0.175

			if 0.425 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_10 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_10:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1493].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_11 = arg_64_1:GetWordFromCfg(426081015)
				local var_67_12 = arg_64_1:FormatText(var_67_11.content)

				arg_64_1.text_.text = var_67_12

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_14 = 7 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_12) / 7)

				if (7 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_12) / 7)) > 0 and var_67_9 < var_67_14 then
					arg_64_1.talkMaxDuration = var_67_14
					var_67_8 = var_67_8 + 0.3

					if var_67_14 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_8
					end
				end

				arg_64_1.text_.text = var_67_12
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081015", "story_v_out_426081.awb") ~= 0 then
					local var_67_15 = manager.audio:GetVoiceLength("story_v_out_426081", "426081015", "story_v_out_426081.awb") / 1000

					if var_67_15 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_8
					end

					if var_67_11.prefab_name ~= "" and arg_64_1.actors_[var_67_11.prefab_name] ~= nil then
						local var_67_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_11.prefab_name].transform, "story_v_out_426081", "426081015", "story_v_out_426081.awb")

						arg_64_1:RecordAudio("426081015", var_67_16)
						arg_64_1:RecordAudio("426081015", var_67_16)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_426081", "426081015", "story_v_out_426081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_426081", "426081015", "story_v_out_426081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_17 = var_67_8 + 0.3
			local var_67_18 = math.max(var_67_9, arg_64_1.talkMaxDuration)

			if var_67_8 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_17) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_17 + var_67_18 and arg_64_1.time_ < var_67_17 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play426081016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 426081016
		arg_70_1.duration_ = 6.58

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play426081017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_9000

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1054ui_story = arg_70_1.actors_["1054ui_story"].transform.localPosition

				local var_73_0 = GameObjectTools.GetOrAddComponent(arg_70_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_73_0 then
					var_73_0:EnableDynamicBone(false)
				end
			end

			local var_73_1 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_1 then
				arg_70_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_1)
				arg_70_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).z)
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles = arg_70_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_1 and arg_70_1.time_ < 0 + var_73_1 + arg_73_0 then
				arg_70_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1054ui_story"].transform.position).z)
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1054ui_story"].transform.localEulerAngles = arg_70_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_73_2 = GameObjectTools.GetOrAddComponent(arg_70_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(true)
				end
			end

			if 0.533333333333333 < arg_70_1.time_ and arg_70_1.time_ <= 0.533333333333333 + arg_73_0 then
				arg_70_1:AudioAction("play", "effect", "se_story_15", "se_story_15_metal", "")
			end

			local var_73_4 = "ST47"

			if arg_70_1.bgs_.ST47 == nil then
				local var_73_5 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_4)
				var_73_5.name = var_73_4
				var_73_5.transform.parent = arg_70_1.stage_.transform
				var_73_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_4] = var_73_5
			end

			if 0.333333333333333 < arg_70_1.time_ and arg_70_1.time_ <= 0.333333333333333 + arg_73_0 then
				local var_73_6 = arg_70_1.bgs_.ST47

				arg_70_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_7 = var_73_6:GetComponent("SpriteRenderer")

				if var_73_7 and var_73_7.sprite then
					local var_73_8 = 2 * (var_73_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_6.transform.localScale = Vector3.New(var_73_8 / var_73_7.sprite.bounds.size.y < var_73_8 * manager.ui.mainCameraCom_.aspect / var_73_7.sprite.bounds.size.x and var_73_8 * manager.ui.mainCameraCom_.aspect / var_73_7.sprite.bounds.size.x or var_73_8 / var_73_7.sprite.bounds.size.y, var_73_8 / var_73_7.sprite.bounds.size.y < var_73_8 * manager.ui.mainCameraCom_.aspect / var_73_7.sprite.bounds.size.x and var_73_8 * manager.ui.mainCameraCom_.aspect / var_73_7.sprite.bounds.size.x or var_73_8 / var_73_7.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST47" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				local var_73_9 = arg_70_1.var_.effectheibaishanwuchang1

				if not arg_70_1.var_.effectheibaishanwuchang1 then
					var_73_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_73_9.name = "heibaishanwuchang1"
					arg_70_1.var_.effectheibaishanwuchang1 = var_73_9
				else
					var_73_9.transform:SetParent(var_73_9000)
				end

				var_73_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_73_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.23333333333333 < arg_70_1.time_ and arg_70_1.time_ <= 2.23333333333333 + arg_73_0 then
				if arg_70_1.var_.effectheibaishanwuchang1 then
					Object.Destroy(arg_70_1.var_.effectheibaishanwuchang1)

					arg_70_1.var_.effectheibaishanwuchang1 = nil
				end
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_12 = 1.58333333333333
			local var_73_13 = 0.95

			if 1.58333333333333 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_14 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_14:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_15 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(426081016).content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 38 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 38)

				if (38 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 38)) > 0 and var_73_13 < var_73_17 then
					arg_70_1.talkMaxDuration = var_73_17
					var_73_12 = var_73_12 + 0.3

					if var_73_17 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_17 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_18 = var_73_12 + 0.3
			local var_73_19 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_18 + var_73_19 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_18) / var_73_19

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_18 + var_73_19 and arg_70_1.time_ < var_73_18 + var_73_19 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play426081017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 426081017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play426081018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0.133333333333333 < arg_76_1.time_ and arg_76_1.time_ <= 0.133333333333333 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword15", "")
			end

			if 0.2 < arg_76_1.time_ and arg_76_1.time_ <= 0.2 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun03", "")
			end

			local var_79_2 = 0
			local var_79_3 = 1.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(426081017).content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 48 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_4) / 48)

				if (48 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_4) / 48)) > 0 and var_79_3 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_7 and arg_76_1.time_ < var_79_2 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play426081018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 426081018
		arg_80_1.duration_ = 5.07

		local var_80_0 = {
			zh = 3.2,
			ja = 5.066
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
				arg_80_0:Play426081019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.35

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:GetWordFromCfg(426081018)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 14 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 14)

				if (14 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 14)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081018", "story_v_out_426081.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081018", "story_v_out_426081.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_426081", "426081018", "story_v_out_426081.awb")

						arg_80_1:RecordAudio("426081018", var_83_6)
						arg_80_1:RecordAudio("426081018", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_426081", "426081018", "story_v_out_426081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_426081", "426081018", "story_v_out_426081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play426081019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 426081019
		arg_84_1.duration_ = 4.07

		local var_84_0 = {
			zh = 2.166,
			ja = 4.066
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
				arg_84_0:Play426081020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1054ui_story = arg_84_1.actors_["1054ui_story"].transform.localPosition

				local var_87_0 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_0 then
					var_87_0:EnableDynamicBone(false)
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_84_1.time_ - 0) / var_87_1)
				arg_84_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1054ui_story"].transform.position).z)
				arg_84_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1054ui_story"].transform.localEulerAngles = arg_84_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_84_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1054ui_story"].transform.position).z)
				arg_84_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1054ui_story"].transform.localEulerAngles = arg_84_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_87_2 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(true)
				end
			end

			local var_87_3 = arg_84_1.actors_["1054ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1054ui_story == nil then
				arg_84_1.var_.characterEffect1054ui_story = var_87_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_4 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 and not isNil(var_87_3) then
				if arg_84_1.var_.characterEffect1054ui_story and not isNil(var_87_3) then
					arg_84_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1054ui_story then
				arg_84_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_87_6 = 0
			local var_87_7 = 0.275

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_8 = arg_84_1:GetWordFromCfg(426081019)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 11 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 11)

				if (11 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 11)) > 0 and var_87_7 < var_87_11 then
					arg_84_1.talkMaxDuration = var_87_11

					if var_87_11 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081019", "story_v_out_426081.awb") ~= 0 then
					local var_87_12 = manager.audio:GetVoiceLength("story_v_out_426081", "426081019", "story_v_out_426081.awb") / 1000

					if var_87_12 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_6
					end

					if var_87_8.prefab_name ~= "" and arg_84_1.actors_[var_87_8.prefab_name] ~= nil then
						local var_87_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_8.prefab_name].transform, "story_v_out_426081", "426081019", "story_v_out_426081.awb")

						arg_84_1:RecordAudio("426081019", var_87_13)
						arg_84_1:RecordAudio("426081019", var_87_13)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_426081", "426081019", "story_v_out_426081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_426081", "426081019", "story_v_out_426081.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play426081020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 426081020
		arg_88_1.duration_ = 6.13

		local var_88_0 = {
			zh = 3.666,
			ja = 6.133
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
				arg_88_0:Play426081021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1054ui_story"]) and arg_88_1.var_.characterEffect1054ui_story == nil then
				arg_88_1.var_.characterEffect1054ui_story = arg_88_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1054ui_story"]) then
				if arg_88_1.var_.characterEffect1054ui_story and not isNil(arg_88_1.actors_["1054ui_story"]) then
					arg_88_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1054ui_story"]) and arg_88_1.var_.characterEffect1054ui_story then
				arg_88_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.45

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(426081020)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_6 = 18 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 18)

				if (18 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 18)) > 0 and var_91_2 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081020", "story_v_out_426081.awb") ~= 0 then
					local var_91_7 = manager.audio:GetVoiceLength("story_v_out_426081", "426081020", "story_v_out_426081.awb") / 1000

					if var_91_7 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_1
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_426081", "426081020", "story_v_out_426081.awb")

						arg_88_1:RecordAudio("426081020", var_91_8)
						arg_88_1:RecordAudio("426081020", var_91_8)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_426081", "426081020", "story_v_out_426081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_426081", "426081020", "story_v_out_426081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_9 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_9 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_9

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_9 and arg_88_1.time_ < var_91_1 + var_91_9 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play426081021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 426081021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play426081022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_9000

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1054ui_story = arg_92_1.actors_["1054ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).z)
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles = arg_92_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).z)
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles = arg_92_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			if 0.133333333333333 < arg_92_1.time_ and arg_92_1.time_ <= 0.133333333333333 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword09", "")
			end

			if 0.333333333333333 < arg_92_1.time_ and arg_92_1.time_ <= 0.333333333333333 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_128", "se_story_128_metal", "")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				local var_95_5 = arg_92_1.var_.effectdaofeng123

				if not arg_92_1.var_.effectdaofeng123 then
					var_95_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_95_5.name = "daofeng123"
					arg_92_1.var_.effectdaofeng123 = var_95_5
				else
					var_95_5.transform:SetParent(var_95_9000)
				end

				var_95_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_95_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_95_7 = 0
			local var_95_8 = 1.25

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_9 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(426081021).content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 50 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_9) / 50)

				if (50 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_9) / 50)) > 0 and var_95_8 < var_95_11 then
					arg_92_1.talkMaxDuration = var_95_11

					if var_95_11 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_7
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_8, arg_92_1.talkMaxDuration)

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_7) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_7 + var_95_12 and arg_92_1.time_ < var_95_7 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play426081022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 426081022
		arg_96_1.duration_ = 4.1

		local var_96_0 = {
			zh = 3.933,
			ja = 4.1
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
				arg_96_0:Play426081023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.4

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:GetWordFromCfg(426081022)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 16 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 16)

				if (16 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 16)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081022", "story_v_out_426081.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081022", "story_v_out_426081.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_426081", "426081022", "story_v_out_426081.awb")

						arg_96_1:RecordAudio("426081022", var_99_6)
						arg_96_1:RecordAudio("426081022", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_426081", "426081022", "story_v_out_426081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_426081", "426081022", "story_v_out_426081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play426081023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 426081023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play426081024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.925

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(426081023).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 37 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 37)

				if (37 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 37)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play426081024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 426081024
		arg_104_1.duration_ = 2.73

		local var_104_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_104_0:Play426081025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1054ui_story = arg_104_1.actors_["1054ui_story"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1054ui_story"].transform.position).z)
				arg_104_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1054ui_story"].transform.localEulerAngles = arg_104_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_104_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1054ui_story"].transform.position).z)
				arg_104_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1054ui_story"].transform.localEulerAngles = arg_104_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["1054ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1054ui_story == nil then
				arg_104_1.var_.characterEffect1054ui_story = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect1054ui_story and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1054ui_story then
				arg_104_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_107_6 = 0
			local var_107_7 = 0.175

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(426081024)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 7 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 7)

				if (7 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 7)) > 0 and var_107_7 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081024", "story_v_out_426081.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_426081", "426081024", "story_v_out_426081.awb") / 1000

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_out_426081", "426081024", "story_v_out_426081.awb")

						arg_104_1:RecordAudio("426081024", var_107_13)
						arg_104_1:RecordAudio("426081024", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_426081", "426081024", "story_v_out_426081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_426081", "426081024", "story_v_out_426081.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play426081025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 426081025
		arg_108_1.duration_ = 6

		local var_108_0 = {
			zh = 5.2,
			ja = 6
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
				arg_108_0:Play426081026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_111_0 = 0
			local var_111_1 = 0.55

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(426081025)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 22 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 22)

				if (22 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 22)) > 0 and var_111_1 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081025", "story_v_out_426081.awb") ~= 0 then
					local var_111_6 = manager.audio:GetVoiceLength("story_v_out_426081", "426081025", "story_v_out_426081.awb") / 1000

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end

					if var_111_2.prefab_name ~= "" and arg_108_1.actors_[var_111_2.prefab_name] ~= nil then
						local var_111_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_2.prefab_name].transform, "story_v_out_426081", "426081025", "story_v_out_426081.awb")

						arg_108_1:RecordAudio("426081025", var_111_7)
						arg_108_1:RecordAudio("426081025", var_111_7)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_426081", "426081025", "story_v_out_426081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_426081", "426081025", "story_v_out_426081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play426081026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 426081026
		arg_112_1.duration_ = 3.77

		local var_112_0 = {
			zh = 2.433,
			ja = 3.766
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
				arg_112_0:Play426081027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1054ui_story"]) and arg_112_1.var_.characterEffect1054ui_story == nil then
				arg_112_1.var_.characterEffect1054ui_story = arg_112_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1054ui_story"]) then
				if arg_112_1.var_.characterEffect1054ui_story and not isNil(arg_112_1.actors_["1054ui_story"]) then
					arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1054ui_story"]) and arg_112_1.var_.characterEffect1054ui_story then
				arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 0.225

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(426081026)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 9 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 9)

				if (9 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_4) / 9)) > 0 and var_115_2 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081026", "story_v_out_426081.awb") ~= 0 then
					local var_115_7 = manager.audio:GetVoiceLength("story_v_out_426081", "426081026", "story_v_out_426081.awb") / 1000

					if var_115_7 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_1
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_426081", "426081026", "story_v_out_426081.awb")

						arg_112_1:RecordAudio("426081026", var_115_8)
						arg_112_1:RecordAudio("426081026", var_115_8)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_426081", "426081026", "story_v_out_426081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_426081", "426081026", "story_v_out_426081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_9 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_9 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_9

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_9 and arg_112_1.time_ < var_115_1 + var_115_9 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play426081027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 426081027
		arg_116_1.duration_ = 5.63

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play426081028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_9000

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1054ui_story = arg_116_1.actors_["1054ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).z)
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles = arg_116_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).z)
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles = arg_116_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			if 0.133333333333333 < arg_116_1.time_ and arg_116_1.time_ <= 0.133333333333333 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_150", "se_story_150_push", "")
			end

			local var_119_4 = arg_116_1.bgs_.ST47.transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPosST47 = var_119_4.localPosition
			end

			local var_119_5 = 1.13333333333333

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_5 then
				var_119_4.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPosST47, Vector3.New(0, 1, 9.5), (arg_116_1.time_ - 0) / var_119_5)
			end

			if arg_116_1.time_ >= 0 + var_119_5 and arg_116_1.time_ < 0 + var_119_5 + arg_119_0 then
				var_119_4.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_119_6 = manager.ui.mainCamera.transform

			if 0.633333333333333 < arg_116_1.time_ and arg_116_1.time_ <= 0.633333333333333 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_6.localPosition
			end

			local var_119_7 = 0.5

			if 0.633333333333333 <= arg_116_1.time_ and arg_116_1.time_ < 0.633333333333333 + var_119_7 then
				local var_119_8, var_119_9 = math.modf((arg_116_1.time_ - 0.633333333333333) / 0.066)

				var_119_6.localPosition = Vector3.New(var_119_9 * 0.13, var_119_9 * 0.13, var_119_9 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= 0.633333333333333 + var_119_7 and arg_116_1.time_ < 0.633333333333333 + var_119_7 + arg_119_0 then
				var_119_6.localPosition = arg_116_1.var_.shakeOldPos
			end

			if 0.466666666666667 < arg_116_1.time_ and arg_116_1.time_ <= 0.466666666666667 + arg_119_0 then
				local var_119_10 = arg_116_1.var_.effectguaiwupusha1

				if not arg_116_1.var_.effectguaiwupusha1 then
					var_119_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_119_10.name = "guaiwupusha1"
					arg_116_1.var_.effectguaiwupusha1 = var_119_10
				else
					var_119_10.transform:SetParent(var_119_9000)
				end

				var_119_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_119_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_119_12 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= var_119_12 + 1.6 and arg_116_1.time_ < var_119_12 + 1.6 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_13 = 0.633333333333333
			local var_119_14 = 1.625

			if 0.633333333333333 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_15 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_15:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_16 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(426081027).content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_18 = 65 <= 0 and var_119_14 or var_119_14 * (utf8.len(var_119_16) / 65)

				if (65 <= 0 and var_119_14 or var_119_14 * (utf8.len(var_119_16) / 65)) > 0 and var_119_14 < var_119_18 then
					arg_116_1.talkMaxDuration = var_119_18
					var_119_13 = var_119_13 + 0.3

					if var_119_18 + var_119_13 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_18 + var_119_13
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_19 = var_119_13 + 0.3
			local var_119_20 = math.max(var_119_14, arg_116_1.talkMaxDuration)

			if var_119_13 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_19 + var_119_20 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_19) / var_119_20

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_19 + var_119_20 and arg_116_1.time_ < var_119_19 + var_119_20 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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
				needEase = true,
				actorName = "ST47",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play426081028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 426081028
		arg_122_1.duration_ = 2.3

		local var_122_0 = {
			zh = 2.3,
			ja = 1.999999999999
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
				arg_122_0:Play426081029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1054ui_story = arg_122_1.actors_["1054ui_story"].transform.localPosition

				local var_125_0 = GameObjectTools.GetOrAddComponent(arg_122_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_125_0 then
					var_125_0:EnableDynamicBone(false)
				end
			end

			local var_125_1 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_1 then
				arg_122_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_122_1.time_ - 0) / var_125_1)
				arg_122_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1054ui_story"].transform.position).z)
				arg_122_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1054ui_story"].transform.localEulerAngles = arg_122_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_1 and arg_122_1.time_ < 0 + var_125_1 + arg_125_0 then
				arg_122_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_122_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1054ui_story"].transform.position).z)
				arg_122_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1054ui_story"].transform.localEulerAngles = arg_122_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_125_2 = GameObjectTools.GetOrAddComponent(arg_122_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(true)
				end
			end

			local var_125_3 = arg_122_1.actors_["1054ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect1054ui_story == nil then
				arg_122_1.var_.characterEffect1054ui_story = var_125_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_4 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 and not isNil(var_125_3) then
				if arg_122_1.var_.characterEffect1054ui_story and not isNil(var_125_3) then
					arg_122_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect1054ui_story then
				arg_122_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_125_6 = 0
			local var_125_7 = 0.075

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_8 = arg_122_1:GetWordFromCfg(426081028)
				local var_125_9 = arg_122_1:FormatText(var_125_8.content)

				arg_122_1.text_.text = var_125_9

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 3 <= 0 and var_125_7 or var_125_7 * (utf8.len(var_125_9) / 3)

				if (3 <= 0 and var_125_7 or var_125_7 * (utf8.len(var_125_9) / 3)) > 0 and var_125_7 < var_125_11 then
					arg_122_1.talkMaxDuration = var_125_11

					if var_125_11 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_11 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_9
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081028", "story_v_out_426081.awb") ~= 0 then
					local var_125_12 = manager.audio:GetVoiceLength("story_v_out_426081", "426081028", "story_v_out_426081.awb") / 1000

					if var_125_12 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_6
					end

					if var_125_8.prefab_name ~= "" and arg_122_1.actors_[var_125_8.prefab_name] ~= nil then
						local var_125_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_8.prefab_name].transform, "story_v_out_426081", "426081028", "story_v_out_426081.awb")

						arg_122_1:RecordAudio("426081028", var_125_13)
						arg_122_1:RecordAudio("426081028", var_125_13)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_426081", "426081028", "story_v_out_426081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_426081", "426081028", "story_v_out_426081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_14 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_14 and arg_122_1.time_ < var_125_6 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play426081029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 426081029
		arg_126_1.duration_ = 3.47

		local var_126_0 = {
			zh = 2.733,
			ja = 3.466
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
				arg_126_0:Play426081030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1054ui_story"]) and arg_126_1.var_.characterEffect1054ui_story == nil then
				arg_126_1.var_.characterEffect1054ui_story = arg_126_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1054ui_story"]) then
				if arg_126_1.var_.characterEffect1054ui_story and not isNil(arg_126_1.actors_["1054ui_story"]) then
					arg_126_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1054ui_story"]) and arg_126_1.var_.characterEffect1054ui_story then
				arg_126_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.375

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:GetWordFromCfg(426081029)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_6 = 15 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_4) / 15)

				if (15 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_4) / 15)) > 0 and var_129_2 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081029", "story_v_out_426081.awb") ~= 0 then
					local var_129_7 = manager.audio:GetVoiceLength("story_v_out_426081", "426081029", "story_v_out_426081.awb") / 1000

					if var_129_7 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_1
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_426081", "426081029", "story_v_out_426081.awb")

						arg_126_1:RecordAudio("426081029", var_129_8)
						arg_126_1:RecordAudio("426081029", var_129_8)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_426081", "426081029", "story_v_out_426081.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_426081", "426081029", "story_v_out_426081.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_9 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_9 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_9

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_9 and arg_126_1.time_ < var_129_1 + var_129_9 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play426081030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 426081030
		arg_130_1.duration_ = 4.67

		local var_130_0 = {
			zh = 3.633,
			ja = 4.666
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
				arg_130_0:Play426081031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1054ui_story = arg_130_1.actors_["1054ui_story"].transform.localPosition

				local var_133_0 = GameObjectTools.GetOrAddComponent(arg_130_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_133_0 then
					var_133_0:EnableDynamicBone(false)
				end
			end

			local var_133_1 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 then
				arg_130_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_130_1.time_ - 0) / var_133_1)
				arg_130_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1054ui_story"].transform.position).z)
				arg_130_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1054ui_story"].transform.localEulerAngles = arg_130_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 then
				arg_130_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_130_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1054ui_story"].transform.position).z)
				arg_130_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1054ui_story"].transform.localEulerAngles = arg_130_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_133_2 = GameObjectTools.GetOrAddComponent(arg_130_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(true)
				end
			end

			local var_133_3 = arg_130_1.actors_["1054ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1054ui_story == nil then
				arg_130_1.var_.characterEffect1054ui_story = var_133_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 and not isNil(var_133_3) then
				if arg_130_1.var_.characterEffect1054ui_story and not isNil(var_133_3) then
					arg_130_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1054ui_story then
				arg_130_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_133_6 = 0
			local var_133_7 = 0.325

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(426081030)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 13 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 13)

				if (13 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 13)) > 0 and var_133_7 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081030", "story_v_out_426081.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_426081", "426081030", "story_v_out_426081.awb") / 1000

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end

					if var_133_8.prefab_name ~= "" and arg_130_1.actors_[var_133_8.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_8.prefab_name].transform, "story_v_out_426081", "426081030", "story_v_out_426081.awb")

						arg_130_1:RecordAudio("426081030", var_133_13)
						arg_130_1:RecordAudio("426081030", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_426081", "426081030", "story_v_out_426081.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_426081", "426081030", "story_v_out_426081.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play426081031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 426081031
		arg_134_1.duration_ = 11.07

		local var_134_0 = {
			zh = 6.233,
			ja = 11.066
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
				arg_134_0:Play426081032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1054ui_story"]) and arg_134_1.var_.characterEffect1054ui_story == nil then
				arg_134_1.var_.characterEffect1054ui_story = arg_134_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1054ui_story"]) then
				if arg_134_1.var_.characterEffect1054ui_story and not isNil(arg_134_1.actors_["1054ui_story"]) then
					arg_134_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1054ui_story"]) and arg_134_1.var_.characterEffect1054ui_story then
				arg_134_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.9

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(426081031)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_6 = 36 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_4) / 36)

				if (36 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_4) / 36)) > 0 and var_137_2 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081031", "story_v_out_426081.awb") ~= 0 then
					local var_137_7 = manager.audio:GetVoiceLength("story_v_out_426081", "426081031", "story_v_out_426081.awb") / 1000

					if var_137_7 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_1
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_426081", "426081031", "story_v_out_426081.awb")

						arg_134_1:RecordAudio("426081031", var_137_8)
						arg_134_1:RecordAudio("426081031", var_137_8)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_426081", "426081031", "story_v_out_426081.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_426081", "426081031", "story_v_out_426081.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_9 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_9 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_9

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_9 and arg_134_1.time_ < var_137_1 + var_137_9 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play426081032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 426081032
		arg_138_1.duration_ = 3.5

		local var_138_0 = {
			zh = 2.633,
			ja = 3.5
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
				arg_138_0:Play426081033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.425

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:GetWordFromCfg(426081032)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 17 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 17)

				if (17 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 17)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081032", "story_v_out_426081.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081032", "story_v_out_426081.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_out_426081", "426081032", "story_v_out_426081.awb")

						arg_138_1:RecordAudio("426081032", var_141_6)
						arg_138_1:RecordAudio("426081032", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_426081", "426081032", "story_v_out_426081.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_426081", "426081032", "story_v_out_426081.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play426081033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 426081033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play426081034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1054ui_story = arg_142_1.actors_["1054ui_story"].transform.localPosition

				local var_145_0 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_0 then
					var_145_0:EnableDynamicBone(false)
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_1)
				arg_142_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1054ui_story"].transform.position).z)
				arg_142_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1054ui_story"].transform.localEulerAngles = arg_142_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_142_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1054ui_story"].transform.position).z)
				arg_142_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1054ui_story"].transform.localEulerAngles = arg_142_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_145_2 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(true)
				end
			end

			local var_145_3 = 0
			local var_145_4 = 0.625

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_3 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_5 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(426081033).content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 25 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_5) / 25)

				if (25 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_5) / 25)) > 0 and var_145_4 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_3 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_3
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_4, arg_142_1.talkMaxDuration)

			if var_145_3 <= arg_142_1.time_ and arg_142_1.time_ < var_145_3 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_3) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_3 + var_145_8 and arg_142_1.time_ < var_145_3 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play426081034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 426081034
		arg_146_1.duration_ = 5

		local var_146_0 = {
			zh = 3.233,
			ja = 5
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
				arg_146_0:Play426081035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.475

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:GetWordFromCfg(426081034)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 19 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 19)

				if (19 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 19)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081034", "story_v_out_426081.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081034", "story_v_out_426081.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_426081", "426081034", "story_v_out_426081.awb")

						arg_146_1:RecordAudio("426081034", var_149_6)
						arg_146_1:RecordAudio("426081034", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_426081", "426081034", "story_v_out_426081.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_426081", "426081034", "story_v_out_426081.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play426081035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 426081035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play426081036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_9000

			if 0.6 < arg_150_1.time_ and arg_150_1.time_ <= 0.6 + arg_153_0 then
				arg_150_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword02", "")
			end

			if 0.766666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 0.766666666666667 + arg_153_0 then
				arg_150_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_153_2 = arg_150_1.bgs_.ST47.transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPosST47 = var_153_2.localPosition
			end

			local var_153_3 = 1.13333333333333

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 then
				var_153_2.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPosST47, Vector3.New(0, 1, 10), (arg_150_1.time_ - 0) / var_153_3)
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 then
				var_153_2.localPosition = Vector3.New(0, 1, 10)
			end

			local var_153_4 = manager.ui.mainCamera.transform

			if 0.633333333333333 < arg_150_1.time_ and arg_150_1.time_ <= 0.633333333333333 + arg_153_0 then
				arg_150_1.var_.shakeOldPos = var_153_4.localPosition
			end

			local var_153_5 = 0.5

			if 0.633333333333333 <= arg_150_1.time_ and arg_150_1.time_ < 0.633333333333333 + var_153_5 then
				local var_153_6, var_153_7 = math.modf((arg_150_1.time_ - 0.633333333333333) / 0.066)

				var_153_4.localPosition = Vector3.New(var_153_7 * 0.13, var_153_7 * 0.13, var_153_7 * 0.13) + arg_150_1.var_.shakeOldPos
			end

			if arg_150_1.time_ >= 0.633333333333333 + var_153_5 and arg_150_1.time_ < 0.633333333333333 + var_153_5 + arg_153_0 then
				var_153_4.localPosition = arg_150_1.var_.shakeOldPos
			end

			if 0.466666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 0.466666666666667 + arg_153_0 then
				local var_153_8 = arg_150_1.var_.effectguaiwupusha1

				if not arg_150_1.var_.effectguaiwupusha1 then
					var_153_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_153_8.name = "guaiwupusha1"
					arg_150_1.var_.effectguaiwupusha1 = var_153_8
				else
					var_153_8.transform:SetParent(var_153_9000)
				end

				var_153_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_153_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_153_10 = 0

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.allBtn_.enabled = false
			end

			if arg_150_1.time_ >= var_153_10 + 1.6 and arg_150_1.time_ < var_153_10 + 1.6 + arg_153_0 then
				arg_150_1.allBtn_.enabled = true
			end

			local var_153_11 = 0
			local var_153_12 = 1.15

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_13 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(426081035).content)

				arg_150_1.text_.text = var_153_13

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_15 = 46 <= 0 and var_153_12 or var_153_12 * (utf8.len(var_153_13) / 46)

				if (46 <= 0 and var_153_12 or var_153_12 * (utf8.len(var_153_13) / 46)) > 0 and var_153_12 < var_153_15 then
					arg_150_1.talkMaxDuration = var_153_15

					if var_153_15 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_15 + var_153_11
					end
				end

				arg_150_1.text_.text = var_153_13
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_12, arg_150_1.talkMaxDuration)

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_11) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_11 + var_153_16 and arg_150_1.time_ < var_153_11 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST47",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play426081036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 426081036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play426081037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0.533333333333333 < arg_154_1.time_ and arg_154_1.time_ <= 0.533333333333333 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story_4", "se_story_4_arm_1", "")
			end

			local var_157_1 = 0
			local var_157_2 = 0.8

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(426081036).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 32 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 32)

				if (32 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 32)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play426081037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 426081037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play426081038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.825

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(426081037).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 33 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 33)

				if (33 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 33)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play426081038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 426081038
		arg_162_1.duration_ = 5.03

		local var_162_0 = {
			zh = 5.033,
			ja = 4.9
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play426081039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1054ui_story = arg_162_1.actors_["1054ui_story"].transform.localPosition

				local var_165_0 = GameObjectTools.GetOrAddComponent(arg_162_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_165_0 then
					var_165_0:EnableDynamicBone(false)
				end
			end

			local var_165_1 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_1 then
				arg_162_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_162_1.time_ - 0) / var_165_1)
				arg_162_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1054ui_story"].transform.position).z)
				arg_162_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1054ui_story"].transform.localEulerAngles = arg_162_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_1 and arg_162_1.time_ < 0 + var_165_1 + arg_165_0 then
				arg_162_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_162_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1054ui_story"].transform.position).z)
				arg_162_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1054ui_story"].transform.localEulerAngles = arg_162_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_165_2 = GameObjectTools.GetOrAddComponent(arg_162_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(true)
				end
			end

			local var_165_3 = arg_162_1.actors_["1054ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_3) and arg_162_1.var_.characterEffect1054ui_story == nil then
				arg_162_1.var_.characterEffect1054ui_story = var_165_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_4 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 and not isNil(var_165_3) then
				if arg_162_1.var_.characterEffect1054ui_story and not isNil(var_165_3) then
					arg_162_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 and not isNil(var_165_3) and arg_162_1.var_.characterEffect1054ui_story then
				arg_162_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action9_2")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_165_6 = 0
			local var_165_7 = 0.275

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_8 = arg_162_1:GetWordFromCfg(426081038)
				local var_165_9 = arg_162_1:FormatText(var_165_8.content)

				arg_162_1.text_.text = var_165_9

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_11 = 11 <= 0 and var_165_7 or var_165_7 * (utf8.len(var_165_9) / 11)

				if (11 <= 0 and var_165_7 or var_165_7 * (utf8.len(var_165_9) / 11)) > 0 and var_165_7 < var_165_11 then
					arg_162_1.talkMaxDuration = var_165_11

					if var_165_11 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_11 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_9
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081038", "story_v_out_426081.awb") ~= 0 then
					local var_165_12 = manager.audio:GetVoiceLength("story_v_out_426081", "426081038", "story_v_out_426081.awb") / 1000

					if var_165_12 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_12 + var_165_6
					end

					if var_165_8.prefab_name ~= "" and arg_162_1.actors_[var_165_8.prefab_name] ~= nil then
						local var_165_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_8.prefab_name].transform, "story_v_out_426081", "426081038", "story_v_out_426081.awb")

						arg_162_1:RecordAudio("426081038", var_165_13)
						arg_162_1:RecordAudio("426081038", var_165_13)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_426081", "426081038", "story_v_out_426081.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_426081", "426081038", "story_v_out_426081.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_14 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_14 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_14

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_14 and arg_162_1.time_ < var_165_6 + var_165_14 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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

		arg_162_1:InitPlayNodeList()
	end,
	Play426081039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 426081039
		arg_166_1.duration_ = 9

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play426081040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 2 < arg_166_1.time_ and arg_166_1.time_ <= 2 + arg_169_0 then
				local var_169_0 = arg_166_1.bgs_.ST47

				arg_166_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_1 = var_169_0:GetComponent("SpriteRenderer")

				if var_169_1 and var_169_1.sprite then
					local var_169_2 = 2 * (var_169_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_0.transform.localScale = Vector3.New(var_169_2 / var_169_1.sprite.bounds.size.y < var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x and var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x or var_169_2 / var_169_1.sprite.bounds.size.y, var_169_2 / var_169_1.sprite.bounds.size.y < var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x and var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x or var_169_2 / var_169_1.sprite.bounds.size.y, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST47" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_3 = 4

			if 4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_3 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_3 + 0.3 and arg_166_1.time_ < var_169_3 + 0.3 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_4 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_5 = 2

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_5 then
				local var_169_6 = Color.New(0, 0, 0)

				var_169_6.a = Mathf.Lerp(0, 1, (arg_166_1.time_ - var_169_4) / var_169_5)
				arg_166_1.mask_.color = var_169_6
			end

			if arg_166_1.time_ >= var_169_4 + var_169_5 and arg_166_1.time_ < var_169_4 + var_169_5 + arg_169_0 then
				local var_169_7 = Color.New(0, 0, 0)

				var_169_7.a = 1
				arg_166_1.mask_.color = var_169_7
			end

			local var_169_8 = 2

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_9 = 2

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_9 then
				local var_169_10 = Color.New(0, 0, 0)

				var_169_10.a = Mathf.Lerp(1, 0, (arg_166_1.time_ - var_169_8) / var_169_9)
				arg_166_1.mask_.color = var_169_10
			end

			if arg_166_1.time_ >= var_169_8 + var_169_9 and arg_166_1.time_ < var_169_8 + var_169_9 + arg_169_0 then
				local var_169_11 = Color.New(0, 0, 0)

				arg_166_1.mask_.enabled = false
				var_169_11.a = 0
				arg_166_1.mask_.color = var_169_11
			end

			local var_169_12 = arg_166_1.actors_["1054ui_story"].transform

			if 1.96599999815226 < arg_166_1.time_ and arg_166_1.time_ <= 1.96599999815226 + arg_169_0 then
				arg_166_1.var_.moveOldPos1054ui_story = var_169_12.localPosition

				local var_169_13 = GameObjectTools.GetOrAddComponent(var_169_12.gameObject, typeof(DynamicBoneHelper))

				if var_169_13 then
					var_169_13:EnableDynamicBone(false)
				end
			end

			local var_169_14 = 0.001

			if 1.96599999815226 <= arg_166_1.time_ and arg_166_1.time_ < 1.96599999815226 + var_169_14 then
				var_169_12.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 1.96599999815226) / var_169_14)
				var_169_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_12.position).x, (manager.ui.mainCamera.transform.position - var_169_12.position).y, (manager.ui.mainCamera.transform.position - var_169_12.position).z)
				var_169_12.localEulerAngles.z = 0
				var_169_12.localEulerAngles.x = 0
				var_169_12.localEulerAngles = var_169_12.localEulerAngles
			end

			if arg_166_1.time_ >= 1.96599999815226 + var_169_14 and arg_166_1.time_ < 1.96599999815226 + var_169_14 + arg_169_0 then
				var_169_12.localPosition = Vector3.New(0, 100, 0)
				var_169_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_12.position).x, (manager.ui.mainCamera.transform.position - var_169_12.position).y, (manager.ui.mainCamera.transform.position - var_169_12.position).z)
				var_169_12.localEulerAngles.z = 0
				var_169_12.localEulerAngles.x = 0
				var_169_12.localEulerAngles = var_169_12.localEulerAngles

				local var_169_15 = GameObjectTools.GetOrAddComponent(var_169_12.gameObject, typeof(DynamicBoneHelper))

				if var_169_15 then
					var_169_15:EnableDynamicBone(true)
				end
			end

			local var_169_16 = arg_166_1.actors_["1054ui_story"]

			if 1.96599999815226 < arg_166_1.time_ and arg_166_1.time_ <= 1.96599999815226 + arg_169_0 and not isNil(var_169_16) and arg_166_1.var_.characterEffect1054ui_story == nil then
				arg_166_1.var_.characterEffect1054ui_story = var_169_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_17 = 0.034000001847744

			if 1.96599999815226 <= arg_166_1.time_ and arg_166_1.time_ < 1.96599999815226 + var_169_17 and not isNil(var_169_16) then
				if arg_166_1.var_.characterEffect1054ui_story and not isNil(var_169_16) then
					arg_166_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 1.96599999815226) / var_169_17)
				end
			end

			if arg_166_1.time_ >= 1.96599999815226 + var_169_17 and arg_166_1.time_ < 1.96599999815226 + var_169_17 + arg_169_0 and not isNil(var_169_16) and arg_166_1.var_.characterEffect1054ui_story then
				arg_166_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_18 = 4
			local var_169_19 = 0.975

			if 4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_20 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_20:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_21 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(426081039).content)

				arg_166_1.text_.text = var_169_21

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_23 = 39 <= 0 and var_169_19 or var_169_19 * (utf8.len(var_169_21) / 39)

				if (39 <= 0 and var_169_19 or var_169_19 * (utf8.len(var_169_21) / 39)) > 0 and var_169_19 < var_169_23 then
					arg_166_1.talkMaxDuration = var_169_23
					var_169_18 = var_169_18 + 0.3

					if var_169_23 + var_169_18 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_18
					end
				end

				arg_166_1.text_.text = var_169_21
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_24 = var_169_18 + 0.3
			local var_169_25 = math.max(var_169_19, arg_166_1.talkMaxDuration)

			if var_169_18 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_24 + var_169_25 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_24) / var_169_25

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_24 + var_169_25 and arg_166_1.time_ < var_169_24 + var_169_25 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play426081040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 426081040
		arg_172_1.duration_ = 3.3

		local var_172_0 = {
			zh = 2.4,
			ja = 3.3
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
				arg_172_0:Play426081041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.325

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(426081040)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 13 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 13)

				if (13 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 13)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081040", "story_v_out_426081.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081040", "story_v_out_426081.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_426081", "426081040", "story_v_out_426081.awb")

						arg_172_1:RecordAudio("426081040", var_175_6)
						arg_172_1:RecordAudio("426081040", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_426081", "426081040", "story_v_out_426081.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_426081", "426081040", "story_v_out_426081.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play426081041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 426081041
		arg_176_1.duration_ = 2.97

		local var_176_0 = {
			zh = 2.966,
			ja = 1.333
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
				arg_176_0:Play426081042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.075

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:GetWordFromCfg(426081041)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 3 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 3)

				if (3 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 3)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081041", "story_v_out_426081.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081041", "story_v_out_426081.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_426081", "426081041", "story_v_out_426081.awb")

						arg_176_1:RecordAudio("426081041", var_179_6)
						arg_176_1:RecordAudio("426081041", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_426081", "426081041", "story_v_out_426081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_426081", "426081041", "story_v_out_426081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play426081042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 426081042
		arg_180_1.duration_ = 3.2

		local var_180_0 = {
			zh = 2.633,
			ja = 3.2
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
				arg_180_0:Play426081043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1054ui_story"]) and arg_180_1.var_.characterEffect1054ui_story == nil then
				arg_180_1.var_.characterEffect1054ui_story = arg_180_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1054ui_story"]) then
				if arg_180_1.var_.characterEffect1054ui_story and not isNil(arg_180_1.actors_["1054ui_story"]) then
					arg_180_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1054ui_story"]) and arg_180_1.var_.characterEffect1054ui_story then
				arg_180_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.35

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:GetWordFromCfg(426081042)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 14 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 14)

				if (14 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 14)) > 0 and var_183_2 < var_183_6 then
					arg_180_1.talkMaxDuration = var_183_6

					if var_183_6 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081042", "story_v_out_426081.awb") ~= 0 then
					local var_183_7 = manager.audio:GetVoiceLength("story_v_out_426081", "426081042", "story_v_out_426081.awb") / 1000

					if var_183_7 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_1
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_426081", "426081042", "story_v_out_426081.awb")

						arg_180_1:RecordAudio("426081042", var_183_8)
						arg_180_1:RecordAudio("426081042", var_183_8)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_426081", "426081042", "story_v_out_426081.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_426081", "426081042", "story_v_out_426081.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_9 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_9 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_9

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_9 and arg_180_1.time_ < var_183_1 + var_183_9 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play426081043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 426081043
		arg_184_1.duration_ = 5.6

		local var_184_0 = {
			zh = 3.4,
			ja = 5.6
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play426081044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.4

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_1 = arg_184_1:GetWordFromCfg(426081043)
				local var_187_2 = arg_184_1:FormatText(var_187_1.content)

				arg_184_1.text_.text = var_187_2

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 16 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 16)

				if (16 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 16)) > 0 and var_187_0 < var_187_4 then
					arg_184_1.talkMaxDuration = var_187_4

					if var_187_4 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_4 + 0
					end
				end

				arg_184_1.text_.text = var_187_2
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081043", "story_v_out_426081.awb") ~= 0 then
					local var_187_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081043", "story_v_out_426081.awb") / 1000

					if var_187_5 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + 0
					end

					if var_187_1.prefab_name ~= "" and arg_184_1.actors_[var_187_1.prefab_name] ~= nil then
						local var_187_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_1.prefab_name].transform, "story_v_out_426081", "426081043", "story_v_out_426081.awb")

						arg_184_1:RecordAudio("426081043", var_187_6)
						arg_184_1:RecordAudio("426081043", var_187_6)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_426081", "426081043", "story_v_out_426081.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_426081", "426081043", "story_v_out_426081.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play426081044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 426081044
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play426081045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1054ui_story = arg_188_1.actors_["1054ui_story"].transform.localPosition

				local var_191_0 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_0 then
					var_191_0:EnableDynamicBone(false)
				end
			end

			local var_191_1 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 then
				arg_188_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_188_1.time_ - 0) / var_191_1)
				arg_188_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1054ui_story"].transform.position).z)
				arg_188_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1054ui_story"].transform.localEulerAngles = arg_188_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 then
				arg_188_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1054ui_story"].transform.position).z)
				arg_188_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1054ui_story"].transform.localEulerAngles = arg_188_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_191_2 = GameObjectTools.GetOrAddComponent(arg_188_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(true)
				end
			end

			local var_191_3 = 0
			local var_191_4 = 1.25

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_3 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_5 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(426081044).content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 50 <= 0 and var_191_4 or var_191_4 * (utf8.len(var_191_5) / 50)

				if (50 <= 0 and var_191_4 or var_191_4 * (utf8.len(var_191_5) / 50)) > 0 and var_191_4 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_3 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_3
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_8 = math.max(var_191_4, arg_188_1.talkMaxDuration)

			if var_191_3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_3 + var_191_8 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_3) / var_191_8

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_3 + var_191_8 and arg_188_1.time_ < var_191_3 + var_191_8 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play426081045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 426081045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play426081046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.875

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(426081045).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 35 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 35)

				if (35 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 35)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play426081046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 426081046
		arg_196_1.duration_ = 9.43

		local var_196_0 = {
			zh = 5.8,
			ja = 9.433
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play426081047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.85

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_1 = arg_196_1:GetWordFromCfg(426081046)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 34 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 34)

				if (34 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 34)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081046", "story_v_out_426081.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081046", "story_v_out_426081.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_out_426081", "426081046", "story_v_out_426081.awb")

						arg_196_1:RecordAudio("426081046", var_199_6)
						arg_196_1:RecordAudio("426081046", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_426081", "426081046", "story_v_out_426081.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_426081", "426081046", "story_v_out_426081.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play426081047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 426081047
		arg_200_1.duration_ = 5.7

		local var_200_0 = {
			zh = 5.466,
			ja = 5.7
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
				arg_200_0:Play426081048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.8

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_1 = arg_200_1:GetWordFromCfg(426081047)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 32 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 32)

				if (32 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 32)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081047", "story_v_out_426081.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081047", "story_v_out_426081.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_426081", "426081047", "story_v_out_426081.awb")

						arg_200_1:RecordAudio("426081047", var_203_6)
						arg_200_1:RecordAudio("426081047", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_426081", "426081047", "story_v_out_426081.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_426081", "426081047", "story_v_out_426081.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play426081048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 426081048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play426081049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.9

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_2 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_2:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_3 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(426081048).content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 36 <= 0 and var_207_1 or var_207_1 * (utf8.len(var_207_3) / 36)

				if (36 <= 0 and var_207_1 or var_207_1 * (utf8.len(var_207_3) / 36)) > 0 and var_207_1 < var_207_5 then
					arg_204_1.talkMaxDuration = var_207_5
					var_207_0 = var_207_0 + 0.3

					if var_207_5 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_6 = var_207_0 + 0.3
			local var_207_7 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 + 0.3 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_6) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_6 + var_207_7 and arg_204_1.time_ < var_207_6 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play426081049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 426081049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play426081050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.55

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(426081049).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 22 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 22)

				if (22 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 22)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play426081050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 426081050
		arg_214_1.duration_ = 1.37

		local var_214_0 = {
			zh = 1.166,
			ja = 1.366
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play426081051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.125

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(426081050)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 5 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 5)

				if (5 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 5)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081050", "story_v_out_426081.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081050", "story_v_out_426081.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_426081", "426081050", "story_v_out_426081.awb")

						arg_214_1:RecordAudio("426081050", var_217_6)
						arg_214_1:RecordAudio("426081050", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_426081", "426081050", "story_v_out_426081.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_426081", "426081050", "story_v_out_426081.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play426081051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 426081051
		arg_218_1.duration_ = 8.2

		local var_218_0 = {
			zh = 3.8,
			ja = 8.2
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play426081052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if arg_218_1.actors_["1012ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1012ui_story"))) then
				local var_221_0 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_218_1.stage_.transform)

				var_221_0.name = "1012ui_story"
				var_221_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1012ui_story"] = var_221_0

				local var_221_1 = var_221_0:GetComponentInChildren(typeof(CharacterEffect))

				var_221_1.enabled = true

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_0, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end

				arg_218_1:ShowWeapon(var_221_1.transform, false)

				arg_218_1.var_["1012ui_story" .. "Animator"] = var_221_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_218_1.var_["1012ui_story" .. "Animator"].applyRootMotion = true
				arg_218_1.var_["1012ui_story" .. "LipSync"] = var_221_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_221_3 = arg_218_1.actors_["1012ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1012ui_story = var_221_3.localPosition
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_3.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_218_1.time_ - 0) / var_221_4)
				var_221_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_3.position).x, (manager.ui.mainCamera.transform.position - var_221_3.position).y, (manager.ui.mainCamera.transform.position - var_221_3.position).z)
				var_221_3.localEulerAngles.z = 0
				var_221_3.localEulerAngles.x = 0
				var_221_3.localEulerAngles = var_221_3.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_3.localPosition = Vector3.New(0, -1.05, -6.24)
				var_221_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_3.position).x, (manager.ui.mainCamera.transform.position - var_221_3.position).y, (manager.ui.mainCamera.transform.position - var_221_3.position).z)
				var_221_3.localEulerAngles.z = 0
				var_221_3.localEulerAngles.x = 0
				var_221_3.localEulerAngles = var_221_3.localEulerAngles
			end

			local var_221_5 = arg_218_1.actors_["1012ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1012ui_story == nil then
				arg_218_1.var_.characterEffect1012ui_story = var_221_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_6 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_6 and not isNil(var_221_5) then
				if arg_218_1.var_.characterEffect1012ui_story and not isNil(var_221_5) then
					arg_218_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_6 and arg_218_1.time_ < 0 + var_221_6 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1012ui_story then
				arg_218_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_221_8 = 0
			local var_221_9 = 0.55

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_8 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_10 = arg_218_1:GetWordFromCfg(426081051)
				local var_221_11 = arg_218_1:FormatText(var_221_10.content)

				arg_218_1.text_.text = var_221_11

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_13 = 22 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 22)

				if (22 <= 0 and var_221_9 or var_221_9 * (utf8.len(var_221_11) / 22)) > 0 and var_221_9 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_8
					end
				end

				arg_218_1.text_.text = var_221_11
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081051", "story_v_out_426081.awb") ~= 0 then
					local var_221_14 = manager.audio:GetVoiceLength("story_v_out_426081", "426081051", "story_v_out_426081.awb") / 1000

					if var_221_14 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_8
					end

					if var_221_10.prefab_name ~= "" and arg_218_1.actors_[var_221_10.prefab_name] ~= nil then
						local var_221_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_10.prefab_name].transform, "story_v_out_426081", "426081051", "story_v_out_426081.awb")

						arg_218_1:RecordAudio("426081051", var_221_15)
						arg_218_1:RecordAudio("426081051", var_221_15)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_426081", "426081051", "story_v_out_426081.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_426081", "426081051", "story_v_out_426081.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = math.max(var_221_9, arg_218_1.talkMaxDuration)

			if var_221_8 <= arg_218_1.time_ and arg_218_1.time_ < var_221_8 + var_221_16 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_8) / var_221_16

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_8 + var_221_16 and arg_218_1.time_ < var_221_8 + var_221_16 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play426081052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 426081052
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play426081053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1012ui_story = arg_222_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1012ui_story"].transform.position).z)
				arg_222_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1012ui_story"].transform.localEulerAngles = arg_222_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1012ui_story"].transform.position).z)
				arg_222_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1012ui_story"].transform.localEulerAngles = arg_222_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["1012ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1012ui_story == nil then
				arg_222_1.var_.characterEffect1012ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1012ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_2)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1012ui_story then
				arg_222_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_225_3 = 0
			local var_225_4 = 0.55

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_3 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_5 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(426081052).content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 22 <= 0 and var_225_4 or var_225_4 * (utf8.len(var_225_5) / 22)

				if (22 <= 0 and var_225_4 or var_225_4 * (utf8.len(var_225_5) / 22)) > 0 and var_225_4 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_3 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_3
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_4, arg_222_1.talkMaxDuration)

			if var_225_3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_3 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_3) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_3 + var_225_8 and arg_222_1.time_ < var_225_3 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 426081053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play426081054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.525

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(426081053).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 21 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 21)

				if (21 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 21)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play426081054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 426081054
		arg_230_1.duration_ = 9

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play426081055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if arg_230_1.bgs_.ST07a == nil then
				local var_233_0 = Object.Instantiate(arg_230_1.paintGo_)

				var_233_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07a")
				var_233_0.name = "ST07a"
				var_233_0.transform.parent = arg_230_1.stage_.transform
				var_233_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.bgs_.ST07a = var_233_0
			end

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= 2 + arg_233_0 then
				local var_233_1 = arg_230_1.bgs_.ST07a

				arg_230_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_233_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_2 = var_233_1:GetComponent("SpriteRenderer")

				if var_233_2 and var_233_2.sprite then
					local var_233_3 = 2 * (var_233_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_233_1.transform.localScale = Vector3.New(var_233_3 / var_233_2.sprite.bounds.size.y < var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x and var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x or var_233_3 / var_233_2.sprite.bounds.size.y, var_233_3 / var_233_2.sprite.bounds.size.y < var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x and var_233_3 * manager.ui.mainCameraCom_.aspect / var_233_2.sprite.bounds.size.x or var_233_3 / var_233_2.sprite.bounds.size.y, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST07a" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_4 = 4

			if 4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			if arg_230_1.time_ >= var_233_4 + 0.3 and arg_230_1.time_ < var_233_4 + 0.3 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			local var_233_5 = 0

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_6 = 2

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_6 then
				local var_233_7 = Color.New(0, 0, 0)

				var_233_7.a = Mathf.Lerp(0, 1, (arg_230_1.time_ - var_233_5) / var_233_6)
				arg_230_1.mask_.color = var_233_7
			end

			if arg_230_1.time_ >= var_233_5 + var_233_6 and arg_230_1.time_ < var_233_5 + var_233_6 + arg_233_0 then
				local var_233_8 = Color.New(0, 0, 0)

				var_233_8.a = 1
				arg_230_1.mask_.color = var_233_8
			end

			local var_233_9 = 2

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_10 = 2

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_10 then
				local var_233_11 = Color.New(0, 0, 0)

				var_233_11.a = Mathf.Lerp(1, 0, (arg_230_1.time_ - var_233_9) / var_233_10)
				arg_230_1.mask_.color = var_233_11
			end

			if arg_230_1.time_ >= var_233_9 + var_233_10 and arg_230_1.time_ < var_233_9 + var_233_10 + arg_233_0 then
				local var_233_12 = Color.New(0, 0, 0)

				arg_230_1.mask_.enabled = false
				var_233_12.a = 0
				arg_230_1.mask_.color = var_233_12
			end

			if 2.30833333333333 < arg_230_1.time_ and arg_230_1.time_ <= 2.30833333333333 + arg_233_0 then
				arg_230_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 3 < arg_230_1.time_ and arg_230_1.time_ <= 3 + arg_233_0 then
				arg_230_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_15 = 4
			local var_233_16 = 0.825

			if 4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_15 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_17 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_17:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_18 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(426081054).content)

				arg_230_1.text_.text = var_233_18

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_20 = 33 <= 0 and var_233_16 or var_233_16 * (utf8.len(var_233_18) / 33)

				if (33 <= 0 and var_233_16 or var_233_16 * (utf8.len(var_233_18) / 33)) > 0 and var_233_16 < var_233_20 then
					arg_230_1.talkMaxDuration = var_233_20
					var_233_15 = var_233_15 + 0.3

					if var_233_20 + var_233_15 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_20 + var_233_15
					end
				end

				arg_230_1.text_.text = var_233_18
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_21 = var_233_15 + 0.3
			local var_233_22 = math.max(var_233_16, arg_230_1.talkMaxDuration)

			if var_233_15 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_21 + var_233_22 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_21) / var_233_22

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_21 + var_233_22 and arg_230_1.time_ < var_233_21 + var_233_22 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play426081055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 426081055
		arg_236_1.duration_ = 6.5

		local var_236_0 = {
			zh = 3.5,
			ja = 6.5
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
				arg_236_0:Play426081056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1012ui_story = arg_236_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1012ui_story"].transform.position).z)
				arg_236_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1012ui_story"].transform.localEulerAngles = arg_236_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_236_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1012ui_story"].transform.position).z)
				arg_236_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1012ui_story"].transform.localEulerAngles = arg_236_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1012ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1012ui_story == nil then
				arg_236_1.var_.characterEffect1012ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1012ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1012ui_story then
				arg_236_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_239_4 = 0
			local var_239_5 = 0.425

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(426081055)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 17 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 17)

				if (17 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 17)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081055", "story_v_out_426081.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_out_426081", "426081055", "story_v_out_426081.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_out_426081", "426081055", "story_v_out_426081.awb")

						arg_236_1:RecordAudio("426081055", var_239_11)
						arg_236_1:RecordAudio("426081055", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_426081", "426081055", "story_v_out_426081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_426081", "426081055", "story_v_out_426081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 426081056
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play426081057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1012ui_story"]) and arg_240_1.var_.characterEffect1012ui_story == nil then
				arg_240_1.var_.characterEffect1012ui_story = arg_240_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1012ui_story"]) then
				if arg_240_1.var_.characterEffect1012ui_story and not isNil(arg_240_1.actors_["1012ui_story"]) then
					arg_240_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1012ui_story"]) and arg_240_1.var_.characterEffect1012ui_story then
				arg_240_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_243_1 = 0
			local var_243_2 = 0.925

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(426081056).content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 37 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 37)

				if (37 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 37)) > 0 and var_243_2 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_6 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_6 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_6

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_6 and arg_240_1.time_ < var_243_1 + var_243_6 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play426081057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 426081057
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play426081058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.3

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(426081057).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 12 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 12)

				if (12 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 12)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play426081058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 426081058
		arg_248_1.duration_ = 9.17

		local var_248_0 = {
			zh = 5.833,
			ja = 9.166
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play426081059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1012ui_story = arg_248_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1012ui_story"].transform.position).z)
				arg_248_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1012ui_story"].transform.localEulerAngles = arg_248_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_248_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1012ui_story"].transform.position).z)
				arg_248_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1012ui_story"].transform.localEulerAngles = arg_248_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1012ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1012ui_story == nil then
				arg_248_1.var_.characterEffect1012ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect1012ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1012ui_story then
				arg_248_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_251_4 = 0
			local var_251_5 = 0.725

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_6 = arg_248_1:GetWordFromCfg(426081058)
				local var_251_7 = arg_248_1:FormatText(var_251_6.content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 29 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 29)

				if (29 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 29)) > 0 and var_251_5 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081058", "story_v_out_426081.awb") ~= 0 then
					local var_251_10 = manager.audio:GetVoiceLength("story_v_out_426081", "426081058", "story_v_out_426081.awb") / 1000

					if var_251_10 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_4
					end

					if var_251_6.prefab_name ~= "" and arg_248_1.actors_[var_251_6.prefab_name] ~= nil then
						local var_251_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_6.prefab_name].transform, "story_v_out_426081", "426081058", "story_v_out_426081.awb")

						arg_248_1:RecordAudio("426081058", var_251_11)
						arg_248_1:RecordAudio("426081058", var_251_11)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_426081", "426081058", "story_v_out_426081.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_426081", "426081058", "story_v_out_426081.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_12 and arg_248_1.time_ < var_251_4 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 426081059
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play426081060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1012ui_story = arg_252_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1012ui_story"].transform.position).z)
				arg_252_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1012ui_story"].transform.localEulerAngles = arg_252_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1012ui_story"].transform.position).z)
				arg_252_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1012ui_story"].transform.localEulerAngles = arg_252_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_255_1 = arg_252_1.actors_["1012ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect1012ui_story == nil then
				arg_252_1.var_.characterEffect1012ui_story = var_255_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 and not isNil(var_255_1) then
				if arg_252_1.var_.characterEffect1012ui_story and not isNil(var_255_1) then
					arg_252_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_2)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect1012ui_story then
				arg_252_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_255_3 = 0
			local var_255_4 = 0.2

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_5 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(426081059).content)

				arg_252_1.text_.text = var_255_5

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_7 = 8 <= 0 and var_255_4 or var_255_4 * (utf8.len(var_255_5) / 8)

				if (8 <= 0 and var_255_4 or var_255_4 * (utf8.len(var_255_5) / 8)) > 0 and var_255_4 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_3 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_3
					end
				end

				arg_252_1.text_.text = var_255_5
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_8 = math.max(var_255_4, arg_252_1.talkMaxDuration)

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_8 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_3) / var_255_8

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_3 + var_255_8 and arg_252_1.time_ < var_255_3 + var_255_8 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 426081060
		arg_256_1.duration_ = 6.9

		local var_256_0 = {
			zh = 4.633,
			ja = 6.9
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play426081061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.675

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_256_1.callingController_:SetSelectedState("calling")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:GetWordFromCfg(426081060)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 27 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 27)

				if (27 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 27)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081060", "story_v_out_426081.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081060", "story_v_out_426081.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_426081", "426081060", "story_v_out_426081.awb")

						arg_256_1:RecordAudio("426081060", var_259_6)
						arg_256_1:RecordAudio("426081060", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_426081", "426081060", "story_v_out_426081.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_426081", "426081060", "story_v_out_426081.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play426081061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 426081061
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play426081062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.875

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(426081061).content)

				arg_260_1.text_.text = var_263_1

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_3 = 35 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 35)

				if (35 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 35)) > 0 and var_263_0 < var_263_3 then
					arg_260_1.talkMaxDuration = var_263_3

					if var_263_3 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_3 + 0
					end
				end

				arg_260_1.text_.text = var_263_1
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_4 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_4

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play426081062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 426081062
		arg_264_1.duration_ = 9.6

		local var_264_0 = {
			zh = 7.3,
			ja = 9.6
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
				arg_264_0:Play426081063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.925

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_264_1.callingController_:SetSelectedState("calling")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:GetWordFromCfg(426081062)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 37 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 37)

				if (37 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 37)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081062", "story_v_out_426081.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081062", "story_v_out_426081.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_426081", "426081062", "story_v_out_426081.awb")

						arg_264_1:RecordAudio("426081062", var_267_6)
						arg_264_1:RecordAudio("426081062", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_426081", "426081062", "story_v_out_426081.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_426081", "426081062", "story_v_out_426081.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play426081063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 426081063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play426081064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.8

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(426081063).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 32 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 32)

				if (32 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 32)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play426081064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 426081064
		arg_272_1.duration_ = 9.87

		local var_272_0 = {
			zh = 5.766,
			ja = 9.866
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
				arg_272_0:Play426081065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.725

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_272_1.callingController_:SetSelectedState("calling")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:GetWordFromCfg(426081064)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 29 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 29)

				if (29 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 29)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081064", "story_v_out_426081.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081064", "story_v_out_426081.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_426081", "426081064", "story_v_out_426081.awb")

						arg_272_1:RecordAudio("426081064", var_275_6)
						arg_272_1:RecordAudio("426081064", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_426081", "426081064", "story_v_out_426081.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_426081", "426081064", "story_v_out_426081.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play426081065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 426081065
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play426081066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.95

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_1 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(426081065).content)

				arg_276_1.text_.text = var_279_1

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_3 = 38 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 38)

				if (38 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 38)) > 0 and var_279_0 < var_279_3 then
					arg_276_1.talkMaxDuration = var_279_3

					if var_279_3 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_3 + 0
					end
				end

				arg_276_1.text_.text = var_279_1
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_4 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_4

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play426081066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 426081066
		arg_280_1.duration_ = 16.5

		local var_280_0 = {
			zh = 6.333,
			ja = 16.5
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play426081067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.725

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_280_1.callingController_:SetSelectedState("calling")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_1 = arg_280_1:GetWordFromCfg(426081066)
				local var_283_2 = arg_280_1:FormatText(var_283_1.content)

				arg_280_1.text_.text = var_283_2

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 29 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 29)

				if (29 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 29)) > 0 and var_283_0 < var_283_4 then
					arg_280_1.talkMaxDuration = var_283_4

					if var_283_4 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_4 + 0
					end
				end

				arg_280_1.text_.text = var_283_2
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081066", "story_v_out_426081.awb") ~= 0 then
					local var_283_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081066", "story_v_out_426081.awb") / 1000

					if var_283_5 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + 0
					end

					if var_283_1.prefab_name ~= "" and arg_280_1.actors_[var_283_1.prefab_name] ~= nil then
						local var_283_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_1.prefab_name].transform, "story_v_out_426081", "426081066", "story_v_out_426081.awb")

						arg_280_1:RecordAudio("426081066", var_283_6)
						arg_280_1:RecordAudio("426081066", var_283_6)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_426081", "426081066", "story_v_out_426081.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_426081", "426081066", "story_v_out_426081.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_7 and arg_280_1.time_ < 0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play426081067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 426081067
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play426081068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.275

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(426081067).content)

				arg_284_1.text_.text = var_287_1

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_3 = 11 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 11)

				if (11 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 11)) > 0 and var_287_0 < var_287_3 then
					arg_284_1.talkMaxDuration = var_287_3

					if var_287_3 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_3 + 0
					end
				end

				arg_284_1.text_.text = var_287_1
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_4 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_4

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play426081068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 426081068
		arg_288_1.duration_ = 14.7

		local var_288_0 = {
			zh = 8.633,
			ja = 14.7
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play426081069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1012ui_story = arg_288_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_291_0 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1012ui_story"].transform.position).z)
				arg_288_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1012ui_story"].transform.localEulerAngles = arg_288_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_288_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1012ui_story"].transform.position).z)
				arg_288_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1012ui_story"].transform.localEulerAngles = arg_288_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_291_1 = arg_288_1.actors_["1012ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1012ui_story == nil then
				arg_288_1.var_.characterEffect1012ui_story = var_291_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 and not isNil(var_291_1) then
				if arg_288_1.var_.characterEffect1012ui_story and not isNil(var_291_1) then
					arg_288_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1012ui_story then
				arg_288_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_291_4 = 0
			local var_291_5 = 1.075

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:GetWordFromCfg(426081068)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 43 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 43)

				if (43 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 43)) > 0 and var_291_5 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081068", "story_v_out_426081.awb") ~= 0 then
					local var_291_10 = manager.audio:GetVoiceLength("story_v_out_426081", "426081068", "story_v_out_426081.awb") / 1000

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end

					if var_291_6.prefab_name ~= "" and arg_288_1.actors_[var_291_6.prefab_name] ~= nil then
						local var_291_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_6.prefab_name].transform, "story_v_out_426081", "426081068", "story_v_out_426081.awb")

						arg_288_1:RecordAudio("426081068", var_291_11)
						arg_288_1:RecordAudio("426081068", var_291_11)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_426081", "426081068", "story_v_out_426081.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_426081", "426081068", "story_v_out_426081.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_12 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_12 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_12

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_12 and arg_288_1.time_ < var_291_4 + var_291_12 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play426081069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 426081069
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play426081070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1012ui_story = arg_292_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_295_0 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 then
				arg_292_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_0)
				arg_292_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1012ui_story"].transform.position).z)
				arg_292_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1012ui_story"].transform.localEulerAngles = arg_292_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 then
				arg_292_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1012ui_story"].transform.position).z)
				arg_292_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1012ui_story"].transform.localEulerAngles = arg_292_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_295_1 = arg_292_1.actors_["1012ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1012ui_story == nil then
				arg_292_1.var_.characterEffect1012ui_story = var_295_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_2 and not isNil(var_295_1) then
				if arg_292_1.var_.characterEffect1012ui_story and not isNil(var_295_1) then
					arg_292_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_2)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_2 and arg_292_1.time_ < 0 + var_295_2 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1012ui_story then
				arg_292_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_295_3 = 0
			local var_295_4 = 0.975

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_3 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_5 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(426081069).content)

				arg_292_1.text_.text = var_295_5

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_7 = 39 <= 0 and var_295_4 or var_295_4 * (utf8.len(var_295_5) / 39)

				if (39 <= 0 and var_295_4 or var_295_4 * (utf8.len(var_295_5) / 39)) > 0 and var_295_4 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_3 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_3
					end
				end

				arg_292_1.text_.text = var_295_5
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_8 = math.max(var_295_4, arg_292_1.talkMaxDuration)

			if var_295_3 <= arg_292_1.time_ and arg_292_1.time_ < var_295_3 + var_295_8 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_3) / var_295_8

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_3 + var_295_8 and arg_292_1.time_ < var_295_3 + var_295_8 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play426081070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 426081070
		arg_296_1.duration_ = 9

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play426081071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if arg_296_1.bgs_.J27f == nil then
				local var_299_0 = Object.Instantiate(arg_296_1.paintGo_)

				var_299_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27f")
				var_299_0.name = "J27f"
				var_299_0.transform.parent = arg_296_1.stage_.transform
				var_299_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.bgs_.J27f = var_299_0
			end

			if 2 < arg_296_1.time_ and arg_296_1.time_ <= 2 + arg_299_0 then
				local var_299_1 = arg_296_1.bgs_.J27f

				arg_296_1.bgs_.J27f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_299_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_2 = var_299_1:GetComponent("SpriteRenderer")

				if var_299_2 and var_299_2.sprite then
					local var_299_3 = 2 * (var_299_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_299_1.transform.localScale = Vector3.New(var_299_3 / var_299_2.sprite.bounds.size.y < var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x and var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x or var_299_3 / var_299_2.sprite.bounds.size.y, var_299_3 / var_299_2.sprite.bounds.size.y < var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x and var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x or var_299_3 / var_299_2.sprite.bounds.size.y, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "J27f" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_4 = 3.999999999999

			if 3.999999999999 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			if arg_296_1.time_ >= var_299_4 + 0.3 and arg_296_1.time_ < var_299_4 + 0.3 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_5 = 0

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_6 = 2

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_6 then
				local var_299_7 = Color.New(0, 0, 0)

				var_299_7.a = Mathf.Lerp(0, 1, (arg_296_1.time_ - var_299_5) / var_299_6)
				arg_296_1.mask_.color = var_299_7
			end

			if arg_296_1.time_ >= var_299_5 + var_299_6 and arg_296_1.time_ < var_299_5 + var_299_6 + arg_299_0 then
				local var_299_8 = Color.New(0, 0, 0)

				var_299_8.a = 1
				arg_296_1.mask_.color = var_299_8
			end

			local var_299_9 = 2

			if 2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_10 = 2

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_10 then
				local var_299_11 = Color.New(0, 0, 0)

				var_299_11.a = Mathf.Lerp(1, 0, (arg_296_1.time_ - var_299_9) / var_299_10)
				arg_296_1.mask_.color = var_299_11
			end

			if arg_296_1.time_ >= var_299_9 + var_299_10 and arg_296_1.time_ < var_299_9 + var_299_10 + arg_299_0 then
				local var_299_12 = Color.New(0, 0, 0)

				arg_296_1.mask_.enabled = false
				var_299_12.a = 0
				arg_296_1.mask_.color = var_299_12
			end

			if 2.33333333333333 < arg_296_1.time_ and arg_296_1.time_ <= 2.33333333333333 + arg_299_0 then
				arg_296_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 2.8 < arg_296_1.time_ and arg_296_1.time_ <= 2.8 + arg_299_0 then
				arg_296_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_15 = 3.999999999999
			local var_299_16 = 1.075

			if 3.999999999999 < arg_296_1.time_ and arg_296_1.time_ <= var_299_15 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_17 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_17:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_18 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(426081070).content)

				arg_296_1.text_.text = var_299_18

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_20 = 43 <= 0 and var_299_16 or var_299_16 * (utf8.len(var_299_18) / 43)

				if (43 <= 0 and var_299_16 or var_299_16 * (utf8.len(var_299_18) / 43)) > 0 and var_299_16 < var_299_20 then
					arg_296_1.talkMaxDuration = var_299_20
					var_299_15 = var_299_15 + 0.3

					if var_299_20 + var_299_15 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_20 + var_299_15
					end
				end

				arg_296_1.text_.text = var_299_18
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_21 = var_299_15 + 0.3
			local var_299_22 = math.max(var_299_16, arg_296_1.talkMaxDuration)

			if var_299_15 + 0.3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_21 + var_299_22 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_21) / var_299_22

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_21 + var_299_22 and arg_296_1.time_ < var_299_21 + var_299_22 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play426081071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 426081071
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play426081072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.325

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[7].name)

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

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(426081071).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 13 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 13)

				if (13 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 13)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play426081072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 426081072
		arg_306_1.duration_ = 7.23

		local var_306_0 = {
			zh = 5.1,
			ja = 7.233
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
				arg_306_0:Play426081073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1012ui_story = arg_306_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_309_0 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 then
				arg_306_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_306_1.time_ - 0) / var_309_0)
				arg_306_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1012ui_story"].transform.position).z)
				arg_306_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1012ui_story"].transform.localEulerAngles = arg_306_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 then
				arg_306_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_306_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1012ui_story"].transform.position).z)
				arg_306_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1012ui_story"].transform.localEulerAngles = arg_306_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_309_1 = arg_306_1.actors_["1012ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1012ui_story == nil then
				arg_306_1.var_.characterEffect1012ui_story = var_309_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_2 and not isNil(var_309_1) then
				if arg_306_1.var_.characterEffect1012ui_story and not isNil(var_309_1) then
					arg_306_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_2 and arg_306_1.time_ < 0 + var_309_2 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1012ui_story then
				arg_306_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_309_4 = 0
			local var_309_5 = 0.625

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_6 = arg_306_1:GetWordFromCfg(426081072)
				local var_309_7 = arg_306_1:FormatText(var_309_6.content)

				arg_306_1.text_.text = var_309_7

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_9 = 25 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 25)

				if (25 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 25)) > 0 and var_309_5 < var_309_9 then
					arg_306_1.talkMaxDuration = var_309_9

					if var_309_9 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_9 + var_309_4
					end
				end

				arg_306_1.text_.text = var_309_7
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081072", "story_v_out_426081.awb") ~= 0 then
					local var_309_10 = manager.audio:GetVoiceLength("story_v_out_426081", "426081072", "story_v_out_426081.awb") / 1000

					if var_309_10 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_4
					end

					if var_309_6.prefab_name ~= "" and arg_306_1.actors_[var_309_6.prefab_name] ~= nil then
						local var_309_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_6.prefab_name].transform, "story_v_out_426081", "426081072", "story_v_out_426081.awb")

						arg_306_1:RecordAudio("426081072", var_309_11)
						arg_306_1:RecordAudio("426081072", var_309_11)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_426081", "426081072", "story_v_out_426081.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_426081", "426081072", "story_v_out_426081.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_12 = math.max(var_309_5, arg_306_1.talkMaxDuration)

			if var_309_4 <= arg_306_1.time_ and arg_306_1.time_ < var_309_4 + var_309_12 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_4) / var_309_12

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_4 + var_309_12 and arg_306_1.time_ < var_309_4 + var_309_12 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play426081073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 426081073
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play426081074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1012ui_story"]) and arg_310_1.var_.characterEffect1012ui_story == nil then
				arg_310_1.var_.characterEffect1012ui_story = arg_310_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1012ui_story"]) then
				if arg_310_1.var_.characterEffect1012ui_story and not isNil(arg_310_1.actors_["1012ui_story"]) then
					arg_310_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_0)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1012ui_story"]) and arg_310_1.var_.characterEffect1012ui_story then
				arg_310_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_313_1 = 0
			local var_313_2 = 0.925

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

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

				local var_313_3 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(426081073).content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 37 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_3) / 37)

				if (37 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_3) / 37)) > 0 and var_313_2 < var_313_5 then
					arg_310_1.talkMaxDuration = var_313_5

					if var_313_5 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + var_313_1
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_6 = math.max(var_313_2, arg_310_1.talkMaxDuration)

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_6 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_1) / var_313_6

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_1 + var_313_6 and arg_310_1.time_ < var_313_1 + var_313_6 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play426081074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 426081074
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play426081075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos1012ui_story = arg_314_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_317_0 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 then
				arg_314_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_314_1.time_ - 0) / var_317_0)
				arg_314_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1012ui_story"].transform.position).z)
				arg_314_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1012ui_story"].transform.localEulerAngles = arg_314_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 then
				arg_314_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_314_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1012ui_story"].transform.position).z)
				arg_314_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1012ui_story"].transform.localEulerAngles = arg_314_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_317_1 = 0
			local var_317_2 = 1

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_3 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(426081074).content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 40 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 40)

				if (40 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 40)) > 0 and var_317_2 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_1
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_6 = math.max(var_317_2, arg_314_1.talkMaxDuration)

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_6 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_1) / var_317_6

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_1 + var_317_6 and arg_314_1.time_ < var_317_1 + var_317_6 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play426081075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 426081075
		arg_318_1.duration_ = 9

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play426081076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_9000

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= 2 + arg_321_0 then
				local var_321_0 = arg_318_1.bgs_.J27f

				arg_318_1.bgs_.J27f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_321_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_1 = var_321_0:GetComponent("SpriteRenderer")

				if var_321_1 and var_321_1.sprite then
					local var_321_2 = 2 * (var_321_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_321_0.transform.localScale = Vector3.New(var_321_2 / var_321_1.sprite.bounds.size.y < var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x and var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x or var_321_2 / var_321_1.sprite.bounds.size.y, var_321_2 / var_321_1.sprite.bounds.size.y < var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x and var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x or var_321_2 / var_321_1.sprite.bounds.size.y, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "J27f" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_321_3 = 4

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_3 + arg_321_0 then
				arg_318_1.allBtn_.enabled = false
			end

			if arg_318_1.time_ >= var_321_3 + 0.3 and arg_318_1.time_ < var_321_3 + 0.3 + arg_321_0 then
				arg_318_1.allBtn_.enabled = true
			end

			local var_321_4 = 0

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_5 = 2

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_5 then
				local var_321_6 = Color.New(0, 0, 0)

				var_321_6.a = Mathf.Lerp(0, 1, (arg_318_1.time_ - var_321_4) / var_321_5)
				arg_318_1.mask_.color = var_321_6
			end

			if arg_318_1.time_ >= var_321_4 + var_321_5 and arg_318_1.time_ < var_321_4 + var_321_5 + arg_321_0 then
				local var_321_7 = Color.New(0, 0, 0)

				var_321_7.a = 1
				arg_318_1.mask_.color = var_321_7
			end

			local var_321_8 = 2

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_8 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_9 = 2

			if var_321_8 <= arg_318_1.time_ and arg_318_1.time_ < var_321_8 + var_321_9 then
				local var_321_10 = Color.New(0, 0, 0)

				var_321_10.a = Mathf.Lerp(1, 0, (arg_318_1.time_ - var_321_8) / var_321_9)
				arg_318_1.mask_.color = var_321_10
			end

			if arg_318_1.time_ >= var_321_8 + var_321_9 and arg_318_1.time_ < var_321_8 + var_321_9 + arg_321_0 then
				local var_321_11 = Color.New(0, 0, 0)

				arg_318_1.mask_.enabled = false
				var_321_11.a = 0
				arg_318_1.mask_.color = var_321_11
			end

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= 2 + arg_321_0 then
				arg_318_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_321_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_318_1.bgmTxt_.text ~= var_321_14 and arg_318_1.bgmTxt_.text ~= "" then
						if arg_318_1.bgmTxt2_.text ~= "" then
							arg_318_1.bgmTxt_.text = arg_318_1.bgmTxt2_.text
						end

						arg_318_1.bgmTxt2_.text = var_321_14

						arg_318_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_318_1.bgmTxt_.text = var_321_14
						arg_318_1.bgmTxt2_.text = var_321_14
					end

					if arg_318_1.bgmTimer then
						arg_318_1.bgmTimer:Stop()

						arg_318_1.bgmTimer = nil
					end

					if arg_318_1.settingData.show_music_name == 1 then
						arg_318_1.musicController:SetSelectedState("show")
						arg_318_1.musicAnimator_:Play("open", 0, 0)

						if arg_318_1.settingData.music_time ~= 0 then
							arg_318_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_318_1.settingData.music_time), function()
								if arg_318_1 == nil or isNil(arg_318_1.bgmTxt_) then
									return
								end

								arg_318_1.musicController:SetSelectedState("hide")
								arg_318_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= 2 + arg_321_0 then
				local var_321_15 = arg_318_1.var_.effectshanshangfeng1

				if not arg_318_1.var_.effectshanshangfeng1 then
					var_321_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_321_15.name = "shanshangfeng1"
					arg_318_1.var_.effectshanshangfeng1 = var_321_15
				else
					var_321_15.transform:SetParent(var_321_9000)
				end

				var_321_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_321_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_17 = 4
			local var_321_18 = 0.9

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_17 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_19 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_19:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_318_1.dialogCg_.alpha = arg_323_0
				end))
				var_321_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_20 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(426081075).content)

				arg_318_1.text_.text = var_321_20

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_22 = 36 <= 0 and var_321_18 or var_321_18 * (utf8.len(var_321_20) / 36)

				if (36 <= 0 and var_321_18 or var_321_18 * (utf8.len(var_321_20) / 36)) > 0 and var_321_18 < var_321_22 then
					arg_318_1.talkMaxDuration = var_321_22
					var_321_17 = var_321_17 + 0.3

					if var_321_22 + var_321_17 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_22 + var_321_17
					end
				end

				arg_318_1.text_.text = var_321_20
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_23 = var_321_17 + 0.3
			local var_321_24 = math.max(var_321_18, arg_318_1.talkMaxDuration)

			if var_321_17 + 0.3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_23 + var_321_24 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_23) / var_321_24

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_23 + var_321_24 and arg_318_1.time_ < var_321_23 + var_321_24 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play426081076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 426081076
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play426081077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_328_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_2 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_2

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_2
						arg_325_1.bgmTxt2_.text = var_328_2
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_325_1.time_ and arg_325_1.time_ <= 0.3 + arg_328_0 then
				arg_325_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_328_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_325_1.bgmTxt_.text ~= var_328_5 and arg_325_1.bgmTxt_.text ~= "" then
						if arg_325_1.bgmTxt2_.text ~= "" then
							arg_325_1.bgmTxt_.text = arg_325_1.bgmTxt2_.text
						end

						arg_325_1.bgmTxt2_.text = var_328_5

						arg_325_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_325_1.bgmTxt_.text = var_328_5
						arg_325_1.bgmTxt2_.text = var_328_5
					end

					if arg_325_1.bgmTimer then
						arg_325_1.bgmTimer:Stop()

						arg_325_1.bgmTimer = nil
					end

					if arg_325_1.settingData.show_music_name == 1 then
						arg_325_1.musicController:SetSelectedState("show")
						arg_325_1.musicAnimator_:Play("open", 0, 0)

						if arg_325_1.settingData.music_time ~= 0 then
							arg_325_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_325_1.settingData.music_time), function()
								if arg_325_1 == nil or isNil(arg_325_1.bgmTxt_) then
									return
								end

								arg_325_1.musicController:SetSelectedState("hide")
								arg_325_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_328_6 = 0
			local var_328_7 = 0.7

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_8 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(426081076).content)

				arg_325_1.text_.text = var_328_8

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 28 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_8) / 28)

				if (28 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_8) / 28)) > 0 and var_328_7 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_8
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_11 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_11 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_11

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_11 and arg_325_1.time_ < var_328_6 + var_328_11 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play426081077 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 426081077
		arg_331_1.duration_ = 1.8

		local var_331_0 = {
			zh = 1.8,
			ja = 1.3
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
				arg_331_0:Play426081078(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.125

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(426081077)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 5 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 5)

				if (5 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 5)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081077", "story_v_out_426081.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081077", "story_v_out_426081.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_426081", "426081077", "story_v_out_426081.awb")

						arg_331_1:RecordAudio("426081077", var_334_6)
						arg_331_1:RecordAudio("426081077", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_426081", "426081077", "story_v_out_426081.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_426081", "426081077", "story_v_out_426081.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play426081078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 426081078
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play426081079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.075

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(426081078).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 3 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 3)

				if (3 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 3)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play426081079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426081079
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play426081080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.875

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(426081079).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 35 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 35)

				if (35 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 35)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play426081080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426081080
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play426081081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.175

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(426081080).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 7 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 7)

				if (7 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 7)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play426081081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 426081081
		arg_347_1.duration_ = 4.4

		local var_347_0 = {
			zh = 4.4,
			ja = 2.633
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
				arg_347_0:Play426081082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.225

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(426081081)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 9 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 9)

				if (9 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 9)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081081", "story_v_out_426081.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081081", "story_v_out_426081.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_426081", "426081081", "story_v_out_426081.awb")

						arg_347_1:RecordAudio("426081081", var_350_6)
						arg_347_1:RecordAudio("426081081", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_426081", "426081081", "story_v_out_426081.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_426081", "426081081", "story_v_out_426081.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play426081082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 426081082
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play426081083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.575

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(426081082).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 23 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 23)

				if (23 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 23)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play426081083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 426081083
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play426081084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.275

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(426081083).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 51 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 51)

				if (51 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 51)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play426081084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 426081084
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play426081085(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.775

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(426081084).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 31 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 31)

				if (31 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 31)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play426081085 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 426081085
		arg_363_1.duration_ = 6.47

		local var_363_0 = {
			zh = 6.466,
			ja = 5.966
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
				arg_363_0:Play426081086(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.3

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(426081085)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 12 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 12)

				if (12 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 12)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081085", "story_v_out_426081.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081085", "story_v_out_426081.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_426081", "426081085", "story_v_out_426081.awb")

						arg_363_1:RecordAudio("426081085", var_366_6)
						arg_363_1:RecordAudio("426081085", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_426081", "426081085", "story_v_out_426081.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_426081", "426081085", "story_v_out_426081.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play426081086 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 426081086
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play426081087(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.45

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(426081086).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 18 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 18)

				if (18 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 18)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play426081087 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 426081087
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play426081088(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.05

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(426081087).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 42 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 42)

				if (42 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 42)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play426081088 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 426081088
		arg_375_1.duration_ = 4.5

		local var_375_0 = {
			zh = 4.5,
			ja = 1.5
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
				arg_375_0:Play426081089(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.05

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_1 = arg_375_1:GetWordFromCfg(426081088)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 2 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 2)

				if (2 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 2)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081088", "story_v_out_426081.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081088", "story_v_out_426081.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_out_426081", "426081088", "story_v_out_426081.awb")

						arg_375_1:RecordAudio("426081088", var_378_6)
						arg_375_1:RecordAudio("426081088", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_426081", "426081088", "story_v_out_426081.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_426081", "426081088", "story_v_out_426081.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play426081089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 426081089
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play426081090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.375

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(426081089).content)

				arg_379_1.text_.text = var_382_1

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_3 = 15 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 15)

				if (15 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 15)) > 0 and var_382_0 < var_382_3 then
					arg_379_1.talkMaxDuration = var_382_3

					if var_382_3 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_3 + 0
					end
				end

				arg_379_1.text_.text = var_382_1
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_4 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_4

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play426081090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 426081090
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play426081091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1.025

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(426081090).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 41 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 41)

				if (41 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 41)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play426081091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 426081091
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play426081092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.6

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(426081091).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 24 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 24)

				if (24 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 24)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play426081092 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 426081092
		arg_391_1.duration_ = 8.27

		local var_391_0 = {
			zh = 7.7,
			ja = 8.266
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play426081093(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.325

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:GetWordFromCfg(426081092)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 13 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 13)

				if (13 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 13)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081092", "story_v_out_426081.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081092", "story_v_out_426081.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_426081", "426081092", "story_v_out_426081.awb")

						arg_391_1:RecordAudio("426081092", var_394_6)
						arg_391_1:RecordAudio("426081092", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_426081", "426081092", "story_v_out_426081.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_426081", "426081092", "story_v_out_426081.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play426081093 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 426081093
		arg_395_1.duration_ = 1

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"

			SetActive(arg_395_1.choicesGo_, true)

			for iter_396_0, iter_396_1 in ipairs(arg_395_1.choices_) do
				SetActive(iter_396_1.go, iter_396_0 <= 1)
			end

			arg_395_1.choices_[1].txt.text = arg_395_1:FormatText(StoryChoiceCfg[1608].name)
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play426081094(arg_395_1)
			end

			arg_395_1:RecordChoiceLog(426081093, 1608)
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			if arg_395_1.time_ >= 0 + 0.666666666666667 and arg_395_1.time_ < 0 + 0.666666666666667 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play426081094 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 426081094
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play426081095(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.15

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(426081094).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 6 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 6)

				if (6 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 6)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play426081095 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 426081095
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play426081096(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.225

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(426081095).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 9 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 9)

				if (9 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 9)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play426081096 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 426081096
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play426081097(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.7

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(426081096).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 28 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 28)

				if (28 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 28)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play426081097 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 426081097
		arg_411_1.duration_ = 4.1

		local var_411_0 = {
			zh = 4.1,
			ja = 1.4
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play426081098(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.15

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:GetWordFromCfg(426081097)
				local var_414_2 = arg_411_1:FormatText(var_414_1.content)

				arg_411_1.text_.text = var_414_2

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 6 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 6)

				if (6 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 6)) > 0 and var_414_0 < var_414_4 then
					arg_411_1.talkMaxDuration = var_414_4

					if var_414_4 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_4 + 0
					end
				end

				arg_411_1.text_.text = var_414_2
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081097", "story_v_out_426081.awb") ~= 0 then
					local var_414_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081097", "story_v_out_426081.awb") / 1000

					if var_414_5 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + 0
					end

					if var_414_1.prefab_name ~= "" and arg_411_1.actors_[var_414_1.prefab_name] ~= nil then
						local var_414_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_1.prefab_name].transform, "story_v_out_426081", "426081097", "story_v_out_426081.awb")

						arg_411_1:RecordAudio("426081097", var_414_6)
						arg_411_1:RecordAudio("426081097", var_414_6)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_426081", "426081097", "story_v_out_426081.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_426081", "426081097", "story_v_out_426081.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_7 and arg_411_1.time_ < 0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play426081098 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 426081098
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play426081099(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 1.05

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(426081098).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 42 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 42)

				if (42 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 42)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play426081099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 426081099
		arg_419_1.duration_ = 2.5

		local var_419_0 = {
			zh = 2.5,
			ja = 1.4
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play426081100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.1

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_1 = arg_419_1:GetWordFromCfg(426081099)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 4 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 4)

				if (4 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 4)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081099", "story_v_out_426081.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081099", "story_v_out_426081.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_426081", "426081099", "story_v_out_426081.awb")

						arg_419_1:RecordAudio("426081099", var_422_6)
						arg_419_1:RecordAudio("426081099", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_426081", "426081099", "story_v_out_426081.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_426081", "426081099", "story_v_out_426081.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play426081100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 426081100
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play426081101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.15

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(426081100).content)

				arg_423_1.text_.text = var_426_1

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_3 = 6 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 6)

				if (6 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 6)) > 0 and var_426_0 < var_426_3 then
					arg_423_1.talkMaxDuration = var_426_3

					if var_426_3 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_3 + 0
					end
				end

				arg_423_1.text_.text = var_426_1
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_4 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_4 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_4

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_4 and arg_423_1.time_ < 0 + var_426_4 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play426081101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 426081101
		arg_427_1.duration_ = 2.33

		local var_427_0 = {
			zh = 2.333,
			ja = 2.3
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play426081102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.1

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:GetWordFromCfg(426081101)
				local var_430_2 = arg_427_1:FormatText(var_430_1.content)

				arg_427_1.text_.text = var_430_2

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 4 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 4)

				if (4 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 4)) > 0 and var_430_0 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end

				arg_427_1.text_.text = var_430_2
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426081", "426081101", "story_v_out_426081.awb") ~= 0 then
					local var_430_5 = manager.audio:GetVoiceLength("story_v_out_426081", "426081101", "story_v_out_426081.awb") / 1000

					if var_430_5 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + 0
					end

					if var_430_1.prefab_name ~= "" and arg_427_1.actors_[var_430_1.prefab_name] ~= nil then
						local var_430_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_1.prefab_name].transform, "story_v_out_426081", "426081101", "story_v_out_426081.awb")

						arg_427_1:RecordAudio("426081101", var_430_6)
						arg_427_1:RecordAudio("426081101", var_430_6)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_426081", "426081101", "story_v_out_426081.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_426081", "426081101", "story_v_out_426081.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play426081102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 426081102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play426081103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.15

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(426081102).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 6 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 6)

				if (6 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 6)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play426081103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 426081103
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play426081104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 1.125

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(426081103).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 45 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 45)

				if (45 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 45)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play426081104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 426081104
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
			arg_439_1.auto_ = false
		end

		function arg_439_1.playNext_(arg_441_0)
			arg_439_1.onStoryFinished_()
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.825

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(426081104).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 33 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 33)

				if (33 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 33)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/J27f"
	},
	voices = {
		"story_v_out_426081.awb"
	}
}
