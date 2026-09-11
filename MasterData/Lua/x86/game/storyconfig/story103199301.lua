return {
	Play319931001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319931001
		arg_1_1.duration_ = 6.79

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319931002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = 1.78867580434307
			local var_4_12 = 0.825

			if 1.78867580434307 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319931001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)

				if (33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319931002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319931002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319931003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.225

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(319931002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 49 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 49)

				if (49 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 49)) > 0 and var_11_0 < var_11_3 then
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
	Play319931003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319931003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319931004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.425

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(319931003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 17 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 17)

				if (17 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 17)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play319931004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319931004
		arg_16_1.duration_ = 4.9

		local var_16_0 = {
			zh = 4.9,
			ja = 4
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
				arg_16_0:Play319931005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(319931004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 14 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 14)

				if (14 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 14)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931004", "story_v_out_319931.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931004", "story_v_out_319931.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_319931", "319931004", "story_v_out_319931.awb")

						arg_16_1:RecordAudio("319931004", var_19_6)
						arg_16_1:RecordAudio("319931004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319931", "319931004", "story_v_out_319931.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319931", "319931004", "story_v_out_319931.awb")
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
	Play319931005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319931005
		arg_20_1.duration_ = 6.57

		local var_20_0 = {
			zh = 6.566,
			ja = 6.4
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
				arg_20_0:Play319931006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(319931005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 19 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 19)

				if (19 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 19)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931005", "story_v_out_319931.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931005", "story_v_out_319931.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_319931", "319931005", "story_v_out_319931.awb")

						arg_20_1:RecordAudio("319931005", var_23_6)
						arg_20_1:RecordAudio("319931005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_319931", "319931005", "story_v_out_319931.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_319931", "319931005", "story_v_out_319931.awb")
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
	Play319931006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319931006
		arg_24_1.duration_ = 1.83

		local var_24_0 = {
			zh = 1.466,
			ja = 1.833
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
				arg_24_0:Play319931007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.125

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10050")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(319931006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 5 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 5)

				if (5 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 5)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931006", "story_v_out_319931.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931006", "story_v_out_319931.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_319931", "319931006", "story_v_out_319931.awb")

						arg_24_1:RecordAudio("319931006", var_27_6)
						arg_24_1:RecordAudio("319931006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_319931", "319931006", "story_v_out_319931.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_319931", "319931006", "story_v_out_319931.awb")
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
	Play319931007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319931007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319931008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "10079ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["10079ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["10079ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["10079ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["10079ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10079ui_story = var_31_3.localPosition
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_28_1.time_ - 0) / var_31_4)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_31_5 = arg_28_1.actors_["10079ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect10079ui_story == nil then
				arg_28_1.var_.characterEffect10079ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.characterEffect10079ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect10079ui_story then
				arg_28_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_31_8 = 0
			local var_31_9 = 0.05

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(319931007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 2 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 2)

				if (2 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 2)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931007", "story_v_out_319931.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_319931", "319931007", "story_v_out_319931.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_out_319931", "319931007", "story_v_out_319931.awb")

						arg_28_1:RecordAudio("319931007", var_31_15)
						arg_28_1:RecordAudio("319931007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_319931", "319931007", "story_v_out_319931.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_319931", "319931007", "story_v_out_319931.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play319931008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319931008
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319931009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.bgs_.I11r == nil then
				local var_35_0 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_35_0.name = "I11r"
				var_35_0.transform.parent = arg_32_1.stage_.transform
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_.I11r = var_35_0
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				local var_35_1 = arg_32_1.bgs_.I11r

				arg_32_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_2 = var_35_1:GetComponent("SpriteRenderer")

				if var_35_2 and var_35_2.sprite then
					local var_35_3 = 2 * (var_35_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_1.transform.localScale = Vector3.New(var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "I11r" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_4 = 2

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= var_35_4 + 0.3 and arg_32_1.time_ < var_35_4 + 0.3 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_5 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_6 = 2

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = Color.New(1, 1, 1)

				var_35_7.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_5) / var_35_6)
				arg_32_1.mask_.color = var_35_7
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				local var_35_8 = Color.New(1, 1, 1)

				arg_32_1.mask_.enabled = false
				var_35_8.a = 0
				arg_32_1.mask_.color = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["10079ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10079ui_story = var_35_9.localPosition
			end

			local var_35_10 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 then
				var_35_9.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_10)
				var_35_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_9.position).x, (manager.ui.mainCamera.transform.position - var_35_9.position).y, (manager.ui.mainCamera.transform.position - var_35_9.position).z)
				var_35_9.localEulerAngles.z = 0
				var_35_9.localEulerAngles.x = 0
				var_35_9.localEulerAngles = var_35_9.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 then
				var_35_9.localPosition = Vector3.New(0, 100, 0)
				var_35_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_9.position).x, (manager.ui.mainCamera.transform.position - var_35_9.position).y, (manager.ui.mainCamera.transform.position - var_35_9.position).z)
				var_35_9.localEulerAngles.z = 0
				var_35_9.localEulerAngles.x = 0
				var_35_9.localEulerAngles = var_35_9.localEulerAngles
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_11 = 2
			local var_35_12 = 0.95

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_13 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_13:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(319931008).content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_16 = 38 <= 0 and var_35_12 or var_35_12 * (utf8.len(var_35_14) / 38)

				if (38 <= 0 and var_35_12 or var_35_12 * (utf8.len(var_35_14) / 38)) > 0 and var_35_12 < var_35_16 then
					arg_32_1.talkMaxDuration = var_35_16
					var_35_11 = var_35_11 + 0.3

					if var_35_16 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_17 = var_35_11 + 0.3
			local var_35_18 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_17) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play319931009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319931009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319931010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.775

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(319931009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 31 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 31)

				if (31 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 31)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319931010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 319931010
		arg_42_1.duration_ = 2.8

		local var_42_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_42_0:Play319931011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10079ui_story = arg_42_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_45_0 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				arg_42_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_42_1.time_ - 0) / var_45_0)
				arg_42_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10079ui_story"].transform.position).z)
				arg_42_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["10079ui_story"].transform.localEulerAngles = arg_42_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				arg_42_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_42_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["10079ui_story"].transform.position).z)
				arg_42_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["10079ui_story"].transform.localEulerAngles = arg_42_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_45_1 = arg_42_1.actors_["10079ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect10079ui_story == nil then
				arg_42_1.var_.characterEffect10079ui_story = var_45_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_2 and not isNil(var_45_1) then
				if arg_42_1.var_.characterEffect10079ui_story and not isNil(var_45_1) then
					arg_42_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_2 and arg_42_1.time_ < 0 + var_45_2 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect10079ui_story then
				arg_42_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_45_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_6 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_6

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_6
						arg_42_1.bgmTxt2_.text = var_45_6
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_42_1.time_ and arg_42_1.time_ <= 0.233333333333333 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_45_9 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_9 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_9

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_9
						arg_42_1.bgmTxt2_.text = var_45_9
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_10 = 0
			local var_45_11 = 0.175

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_12 = arg_42_1:GetWordFromCfg(319931010)
				local var_45_13 = arg_42_1:FormatText(var_45_12.content)

				arg_42_1.text_.text = var_45_13

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_15 = 7 <= 0 and var_45_11 or var_45_11 * (utf8.len(var_45_13) / 7)

				if (7 <= 0 and var_45_11 or var_45_11 * (utf8.len(var_45_13) / 7)) > 0 and var_45_11 < var_45_15 then
					arg_42_1.talkMaxDuration = var_45_15

					if var_45_15 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_10
					end
				end

				arg_42_1.text_.text = var_45_13
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931010", "story_v_out_319931.awb") ~= 0 then
					local var_45_16 = manager.audio:GetVoiceLength("story_v_out_319931", "319931010", "story_v_out_319931.awb") / 1000

					if var_45_16 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_10
					end

					if var_45_12.prefab_name ~= "" and arg_42_1.actors_[var_45_12.prefab_name] ~= nil then
						local var_45_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_12.prefab_name].transform, "story_v_out_319931", "319931010", "story_v_out_319931.awb")

						arg_42_1:RecordAudio("319931010", var_45_17)
						arg_42_1:RecordAudio("319931010", var_45_17)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_319931", "319931010", "story_v_out_319931.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_319931", "319931010", "story_v_out_319931.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_18 = math.max(var_45_11, arg_42_1.talkMaxDuration)

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_18 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_10) / var_45_18

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_10 + var_45_18 and arg_42_1.time_ < var_45_10 + var_45_18 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319931011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319931011
		arg_48_1.duration_ = 8.2

		local var_48_0 = {
			zh = 8.2,
			ja = 7.633
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
				arg_48_0:Play319931012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if arg_48_1.actors_["10075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10075ui_story"))) then
				local var_51_0 = Object.Instantiate(Asset.Load("Char/" .. "10075ui_story"), arg_48_1.stage_.transform)

				var_51_0.name = "10075ui_story"
				var_51_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["10075ui_story"] = var_51_0

				local var_51_1 = var_51_0:GetComponentInChildren(typeof(CharacterEffect))

				var_51_1.enabled = true

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end

				arg_48_1:ShowWeapon(var_51_1.transform, false)

				arg_48_1.var_["10075ui_story" .. "Animator"] = var_51_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_48_1.var_["10075ui_story" .. "Animator"].applyRootMotion = true
				arg_48_1.var_["10075ui_story" .. "LipSync"] = var_51_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_51_3 = arg_48_1.actors_["10075ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10075ui_story = var_51_3.localPosition
			end

			local var_51_4 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				var_51_3.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10075ui_story, Vector3.New(0.7, -0.715, -6.15), (arg_48_1.time_ - 0) / var_51_4)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_3.localPosition = Vector3.New(0.7, -0.715, -6.15)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			local var_51_5 = arg_48_1.actors_["10075ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect10075ui_story == nil then
				arg_48_1.var_.characterEffect10075ui_story = var_51_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_6 and not isNil(var_51_5) then
				if arg_48_1.var_.characterEffect10075ui_story and not isNil(var_51_5) then
					arg_48_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_6 and arg_48_1.time_ < 0 + var_51_6 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect10075ui_story then
				arg_48_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_51_8 = arg_48_1.actors_["10079ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10079ui_story = var_51_8.localPosition
			end

			local var_51_9 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_9 then
				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_48_1.time_ - 0) / var_51_9)
				var_51_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_8.position).x, (manager.ui.mainCamera.transform.position - var_51_8.position).y, (manager.ui.mainCamera.transform.position - var_51_8.position).z)
				var_51_8.localEulerAngles.z = 0
				var_51_8.localEulerAngles.x = 0
				var_51_8.localEulerAngles = var_51_8.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_9 and arg_48_1.time_ < 0 + var_51_9 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_51_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_8.position).x, (manager.ui.mainCamera.transform.position - var_51_8.position).y, (manager.ui.mainCamera.transform.position - var_51_8.position).z)
				var_51_8.localEulerAngles.z = 0
				var_51_8.localEulerAngles.x = 0
				var_51_8.localEulerAngles = var_51_8.localEulerAngles
			end

			local var_51_10 = arg_48_1.actors_["10079ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect10079ui_story == nil then
				arg_48_1.var_.characterEffect10079ui_story = var_51_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_11 and not isNil(var_51_10) then
				if arg_48_1.var_.characterEffect10079ui_story and not isNil(var_51_10) then
					arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_11)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_11 and arg_48_1.time_ < 0 + var_51_11 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect10079ui_story then
				arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_51_12 = 0
			local var_51_13 = 0.45

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_14 = arg_48_1:GetWordFromCfg(319931011)
				local var_51_15 = arg_48_1:FormatText(var_51_14.content)

				arg_48_1.text_.text = var_51_15

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 18 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_15) / 18)

				if (18 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_15) / 18)) > 0 and var_51_13 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_15
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931011", "story_v_out_319931.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_319931", "319931011", "story_v_out_319931.awb") / 1000

					if var_51_18 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_12
					end

					if var_51_14.prefab_name ~= "" and arg_48_1.actors_[var_51_14.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_14.prefab_name].transform, "story_v_out_319931", "319931011", "story_v_out_319931.awb")

						arg_48_1:RecordAudio("319931011", var_51_19)
						arg_48_1:RecordAudio("319931011", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319931", "319931011", "story_v_out_319931.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319931", "319931011", "story_v_out_319931.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_20 and arg_48_1.time_ < var_51_12 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319931012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319931012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319931013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10075ui_story"]) and arg_52_1.var_.characterEffect10075ui_story == nil then
				arg_52_1.var_.characterEffect10075ui_story = arg_52_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10075ui_story"]) then
				if arg_52_1.var_.characterEffect10075ui_story and not isNil(arg_52_1.actors_["10075ui_story"]) then
					arg_52_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10075ui_story"]) and arg_52_1.var_.characterEffect10075ui_story then
				arg_52_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_crystal2", "")
			end

			local var_55_2 = arg_52_1.actors_["10075ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10075ui_story = var_55_2.localPosition
			end

			local var_55_3 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 then
				var_55_2.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_3)
				var_55_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_2.position).x, (manager.ui.mainCamera.transform.position - var_55_2.position).y, (manager.ui.mainCamera.transform.position - var_55_2.position).z)
				var_55_2.localEulerAngles.z = 0
				var_55_2.localEulerAngles.x = 0
				var_55_2.localEulerAngles = var_55_2.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 then
				var_55_2.localPosition = Vector3.New(0, 100, 0)
				var_55_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_2.position).x, (manager.ui.mainCamera.transform.position - var_55_2.position).y, (manager.ui.mainCamera.transform.position - var_55_2.position).z)
				var_55_2.localEulerAngles.z = 0
				var_55_2.localEulerAngles.x = 0
				var_55_2.localEulerAngles = var_55_2.localEulerAngles
			end

			local var_55_4 = arg_52_1.actors_["10079ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10079ui_story = var_55_4.localPosition
			end

			local var_55_5 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 then
				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_5)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(0, 100, 0)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			local var_55_6 = 0
			local var_55_7 = 1.15

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(319931012).content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 46 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_8) / 46)

				if (46 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_8) / 46)) > 0 and var_55_7 < var_55_10 then
					arg_52_1.talkMaxDuration = var_55_10

					if var_55_10 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_11 and arg_52_1.time_ < var_55_6 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play319931013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319931013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319931014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.825

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(319931013).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 33 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 33)

				if (33 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 33)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play319931014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319931014
		arg_60_1.duration_ = 2.73

		local var_60_0 = {
			zh = 2.733,
			ja = 2.533
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
				arg_60_0:Play319931015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10079ui_story = arg_60_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10079ui_story"].transform.position).z)
				arg_60_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10079ui_story"].transform.localEulerAngles = arg_60_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_60_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10079ui_story"].transform.position).z)
				arg_60_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10079ui_story"].transform.localEulerAngles = arg_60_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_63_1 = arg_60_1.actors_["10079ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect10079ui_story == nil then
				arg_60_1.var_.characterEffect10079ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect10079ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect10079ui_story then
				arg_60_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_63_4 = 0
			local var_63_5 = 0.175

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(319931014)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 7 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 7)

				if (7 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 7)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931014", "story_v_out_319931.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931014", "story_v_out_319931.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_319931", "319931014", "story_v_out_319931.awb")

						arg_60_1:RecordAudio("319931014", var_63_11)
						arg_60_1:RecordAudio("319931014", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319931", "319931014", "story_v_out_319931.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319931", "319931014", "story_v_out_319931.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play319931015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319931015
		arg_64_1.duration_ = 3.83

		local var_64_0 = {
			zh = 3.8,
			ja = 3.833
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
				arg_64_0:Play319931016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.375

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:GetWordFromCfg(319931015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 15 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 15)

				if (15 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 15)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931015", "story_v_out_319931.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931015", "story_v_out_319931.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_319931", "319931015", "story_v_out_319931.awb")

						arg_64_1:RecordAudio("319931015", var_67_6)
						arg_64_1:RecordAudio("319931015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_319931", "319931015", "story_v_out_319931.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_319931", "319931015", "story_v_out_319931.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play319931016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319931016
		arg_68_1.duration_ = 5.97

		local var_68_0 = {
			zh = 5.966,
			ja = 4.833
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
				arg_68_0:Play319931017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_0 = 0
			local var_71_1 = 0.4

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(319931016)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 16 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 16)

				if (16 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 16)) > 0 and var_71_1 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931016", "story_v_out_319931.awb") ~= 0 then
					local var_71_6 = manager.audio:GetVoiceLength("story_v_out_319931", "319931016", "story_v_out_319931.awb") / 1000

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end

					if var_71_2.prefab_name ~= "" and arg_68_1.actors_[var_71_2.prefab_name] ~= nil then
						local var_71_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_2.prefab_name].transform, "story_v_out_319931", "319931016", "story_v_out_319931.awb")

						arg_68_1:RecordAudio("319931016", var_71_7)
						arg_68_1:RecordAudio("319931016", var_71_7)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319931", "319931016", "story_v_out_319931.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319931", "319931016", "story_v_out_319931.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319931017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319931017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319931018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["10079ui_story"]) and arg_72_1.var_.characterEffect10079ui_story == nil then
				arg_72_1.var_.characterEffect10079ui_story = arg_72_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["10079ui_story"]) then
				if arg_72_1.var_.characterEffect10079ui_story and not isNil(arg_72_1.actors_["10079ui_story"]) then
					arg_72_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["10079ui_story"]) and arg_72_1.var_.characterEffect10079ui_story then
				arg_72_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_75_1 = arg_72_1.actors_["10079ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10079ui_story = var_75_1.localPosition
			end

			local var_75_2 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 then
				var_75_1.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_2)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 then
				var_75_1.localPosition = Vector3.New(0, 100, 0)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			local var_75_3 = 0
			local var_75_4 = 1.175

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_3 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(319931017).content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 47 <= 0 and var_75_4 or var_75_4 * (utf8.len(var_75_5) / 47)

				if (47 <= 0 and var_75_4 or var_75_4 * (utf8.len(var_75_5) / 47)) > 0 and var_75_4 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_3 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_3
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_4, arg_72_1.talkMaxDuration)

			if var_75_3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_3 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_3) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_3 + var_75_8 and arg_72_1.time_ < var_75_3 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play319931018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319931018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319931019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(319931018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 55 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 55)

				if (55 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 55)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play319931019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319931019
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319931020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10079ui_story = arg_80_1.actors_["10079ui_story"].transform.localPosition

				arg_80_1:ShowWeapon(arg_80_1.var_["10079ui_story" .. "Animator"].transform, true)
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10079ui_story"].transform.position).z)
				arg_80_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10079ui_story"].transform.localEulerAngles = arg_80_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_80_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10079ui_story"].transform.position).z)
				arg_80_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10079ui_story"].transform.localEulerAngles = arg_80_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["10079ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect10079ui_story == nil then
				arg_80_1.var_.characterEffect10079ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect10079ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect10079ui_story then
				arg_80_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_83_4 = 0
			local var_83_5 = 0.1

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(319931019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 4 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 4)

				if (4 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 4)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931019", "story_v_out_319931.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931019", "story_v_out_319931.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_319931", "319931019", "story_v_out_319931.awb")

						arg_80_1:RecordAudio("319931019", var_83_11)
						arg_80_1:RecordAudio("319931019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319931", "319931019", "story_v_out_319931.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319931", "319931019", "story_v_out_319931.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319931020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319931020
		arg_84_1.duration_ = 2

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319931021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_0 = 1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				local var_87_1 = Color.New(1, 1, 1)

				var_87_1.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.mask_.color = var_87_1
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				local var_87_2 = Color.New(1, 1, 1)

				arg_84_1.mask_.enabled = false
				var_87_2.a = 0
				arg_84_1.mask_.color = var_87_2
			end

			local var_87_3 = manager.ui.mainCamera.transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.shakeOldPos = var_87_3.localPosition
			end

			local var_87_4 = 0.5

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				local var_87_5, var_87_6 = math.modf((arg_84_1.time_ - 0) / 0.066)

				var_87_3.localPosition = Vector3.New(var_87_6 * 0.13, var_87_6 * 0.13, var_87_6 * 0.13) + arg_84_1.var_.shakeOldPos
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_3.localPosition = arg_84_1.var_.shakeOldPos
			end

			local var_87_7 = arg_84_1.actors_["10079ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10079ui_story = var_87_7.localPosition

				arg_84_1:ShowWeapon(arg_84_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_87_8 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_8 then
				var_87_7.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_8)
				var_87_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_7.position).x, (manager.ui.mainCamera.transform.position - var_87_7.position).y, (manager.ui.mainCamera.transform.position - var_87_7.position).z)
				var_87_7.localEulerAngles.z = 0
				var_87_7.localEulerAngles.x = 0
				var_87_7.localEulerAngles = var_87_7.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_8 and arg_84_1.time_ < 0 + var_87_8 + arg_87_0 then
				var_87_7.localPosition = Vector3.New(0, 100, 0)
				var_87_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_7.position).x, (manager.ui.mainCamera.transform.position - var_87_7.position).y, (manager.ui.mainCamera.transform.position - var_87_7.position).z)
				var_87_7.localEulerAngles.z = 0
				var_87_7.localEulerAngles.x = 0
				var_87_7.localEulerAngles = var_87_7.localEulerAngles
			end

			local var_87_9 = 0
			local var_87_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931020", "story_v_out_319931.awb") / 1000

			if var_87_10 > 0 and 1.566 < var_87_10 and var_87_10 + var_87_9 > arg_84_1.duration_ then
				arg_84_1.duration_ = var_87_10 + var_87_9
			end

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1:AudioAction("play", "voice", "story_v_out_319931", "319931020", "story_v_out_319931.awb")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				local var_87_12 = arg_84_1.bgs_.STblack

				arg_84_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_87_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_13 = var_87_12:GetComponent("SpriteRenderer")

				if var_87_13 and var_87_13.sprite then
					local var_87_14 = 2 * (var_87_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_87_12.transform.localScale = Vector3.New(var_87_14 / var_87_13.sprite.bounds.size.y < var_87_14 * manager.ui.mainCameraCom_.aspect / var_87_13.sprite.bounds.size.x and var_87_14 * manager.ui.mainCameraCom_.aspect / var_87_13.sprite.bounds.size.x or var_87_14 / var_87_13.sprite.bounds.size.y, var_87_14 / var_87_13.sprite.bounds.size.y < var_87_14 * manager.ui.mainCameraCom_.aspect / var_87_13.sprite.bounds.size.x and var_87_14 * manager.ui.mainCameraCom_.aspect / var_87_13.sprite.bounds.size.x or var_87_14 / var_87_13.sprite.bounds.size.y, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "STblack" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				local var_87_15 = arg_84_1.fswbg_.transform:Find("textbox/adapt/content") or arg_84_1.fswbg_.transform:Find("textbox/content")
				local var_87_16 = arg_84_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_87_17 = var_87_15:GetComponent("RectTransform")

				var_87_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_87_17.offsetMin = Vector2.New(0, 0)
				var_87_17.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.fswbg_:SetActive(true)
				arg_84_1.dialog_:SetActive(false)

				arg_84_1.fswtw_.percent = 0
				arg_84_1.fswt_.text = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(319931020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.fswt_)

				arg_84_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_84_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_84_1.fswtw_:SetDirty()

				arg_84_1.typewritterCharCountI18N = 0

				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			local var_87_18 = 0.149999999998999

			if 0.149999999998999 < arg_84_1.time_ and arg_84_1.time_ <= var_87_18 + arg_87_0 then
				arg_84_1.var_.oldValueTypewriter = arg_84_1.fswtw_.percent

				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			local var_87_19 = 0
			local var_87_20 = 0
			local var_87_21, var_87_22 = arg_84_1:GetPercentByPara(arg_84_1:FormatText(arg_84_1:GetWordFromCfg(319931020).content), 1)

			if var_87_18 < arg_84_1.time_ and arg_84_1.time_ <= var_87_18 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				local var_87_23 = var_87_19 <= 0 and var_87_20 or var_87_20 * ((var_87_22 - arg_84_1.typewritterCharCountI18N) / var_87_19)

				if (var_87_19 <= 0 and var_87_20 or var_87_20 * ((var_87_22 - arg_84_1.typewritterCharCountI18N) / var_87_19)) > 0 and var_87_20 < var_87_23 then
					arg_84_1.talkMaxDuration = var_87_23

					if var_87_23 + var_87_18 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_18
					end
				end
			end

			local var_87_24 = math.max(0, arg_84_1.talkMaxDuration)

			if var_87_18 <= arg_84_1.time_ and arg_84_1.time_ < var_87_18 + var_87_24 then
				arg_84_1.fswtw_.percent = Mathf.Lerp(arg_84_1.var_.oldValueTypewriter, var_87_21, (arg_84_1.time_ - var_87_18) / var_87_24)
				arg_84_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_84_1.fswtw_:SetDirty()
			end

			if arg_84_1.time_ >= var_87_18 + var_87_24 and arg_84_1.time_ < var_87_18 + var_87_24 + arg_87_0 then
				arg_84_1.fswtw_.percent = var_87_21

				arg_84_1.fswtw_:SetDirty()
				arg_84_1:ShowNextGo(true)

				arg_84_1.typewritterCharCountI18N = var_87_22
			end

			local var_87_25 = 0.149999999998999

			if 0.149999999998999 < arg_84_1.time_ and arg_84_1.time_ <= var_87_25 + arg_87_0 then
				arg_84_1.var_.oldValueTypewriter = arg_84_1.fswtw_.percent

				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			local var_87_26 = 3
			local var_87_27 = 0.200000000001001
			local var_87_28, var_87_29 = arg_84_1:GetPercentByPara(arg_84_1:FormatText(arg_84_1:GetWordFromCfg(319931020).content), 1)

			if var_87_25 < arg_84_1.time_ and arg_84_1.time_ <= var_87_25 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				local var_87_30 = var_87_26 <= 0 and var_87_27 or var_87_27 * ((var_87_29 - arg_84_1.typewritterCharCountI18N) / var_87_26)

				if (var_87_26 <= 0 and var_87_27 or var_87_27 * ((var_87_29 - arg_84_1.typewritterCharCountI18N) / var_87_26)) > 0 and var_87_27 < var_87_30 then
					arg_84_1.talkMaxDuration = var_87_30

					if var_87_30 + var_87_25 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_30 + var_87_25
					end
				end
			end

			local var_87_31 = math.max(0.200000000001001, arg_84_1.talkMaxDuration)

			if var_87_25 <= arg_84_1.time_ and arg_84_1.time_ < var_87_25 + var_87_31 then
				arg_84_1.fswtw_.percent = Mathf.Lerp(arg_84_1.var_.oldValueTypewriter, var_87_28, (arg_84_1.time_ - var_87_25) / var_87_31)
				arg_84_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_84_1.fswtw_:SetDirty()
			end

			if arg_84_1.time_ >= var_87_25 + var_87_31 and arg_84_1.time_ < var_87_25 + var_87_31 + arg_87_0 then
				arg_84_1.fswtw_.percent = var_87_28

				arg_84_1.fswtw_:SetDirty()
				arg_84_1:ShowNextGo(true)

				arg_84_1.typewritterCharCountI18N = var_87_29
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.cswbg_:SetActive(true)

				local var_87_32 = arg_84_1.cswt_:GetComponent("RectTransform")

				arg_84_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_87_32.offsetMin = Vector2.New(410, 330)
				var_87_32.offsetMax = Vector2.New(-400, -175)
				arg_84_1.cswt_.text = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(419079).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.cswt_)

				arg_84_1.cswt_.fontSize = 180
				arg_84_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_84_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_84_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play319931021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319931021
		arg_88_1.duration_ = 6.5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319931022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0.999999999999 < arg_88_1.time_ and arg_88_1.time_ <= 0.999999999999 + arg_91_0 then
				local var_91_0 = arg_88_1.bgs_.STblack

				arg_88_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_1 = var_91_0:GetComponent("SpriteRenderer")

				if var_91_1 and var_91_1.sprite then
					local var_91_2 = 2 * (var_91_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_0.transform.localScale = Vector3.New(var_91_2 / var_91_1.sprite.bounds.size.y < var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x and var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x or var_91_2 / var_91_1.sprite.bounds.size.y, var_91_2 / var_91_1.sprite.bounds.size.y < var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x and var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x or var_91_2 / var_91_1.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "STblack" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_3 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_4 = 1

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_4 then
				local var_91_5 = Color.New(0, 0, 0)

				var_91_5.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - var_91_3) / var_91_4)
				arg_88_1.mask_.color = var_91_5
			end

			if arg_88_1.time_ >= var_91_3 + var_91_4 and arg_88_1.time_ < var_91_3 + var_91_4 + arg_91_0 then
				local var_91_6 = Color.New(0, 0, 0)

				var_91_6.a = 1
				arg_88_1.mask_.color = var_91_6
			end

			local var_91_7 = 1

			if 1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_8 = 1

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_8 then
				local var_91_9 = Color.New(0, 0, 0)

				var_91_9.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_7) / var_91_8)
				arg_88_1.mask_.color = var_91_9
			end

			if arg_88_1.time_ >= var_91_7 + var_91_8 and arg_88_1.time_ < var_91_7 + var_91_8 + arg_91_0 then
				local var_91_10 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_10.a = 0
				arg_88_1.mask_.color = var_91_10
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.fswbg_:SetActive(true)
				arg_88_1.dialog_:SetActive(false)

				arg_88_1.fswtw_.percent = 0
				arg_88_1.fswt_.text = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(319931020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.fswt_)

				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_88_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_88_1.fswtw_:SetDirty()

				arg_88_1.typewritterCharCountI18N = 0

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_11 = 0.149999999998999

			if 0.149999999998999 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.var_.oldValueTypewriter = arg_88_1.fswtw_.percent

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_12 = 0
			local var_91_13 = 0
			local var_91_14, var_91_15 = arg_88_1:GetPercentByPara(arg_88_1:FormatText(arg_88_1:GetWordFromCfg(319931020).content), 1)

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				local var_91_16 = var_91_12 <= 0 and var_91_13 or var_91_13 * ((var_91_15 - arg_88_1.typewritterCharCountI18N) / var_91_12)

				if (var_91_12 <= 0 and var_91_13 or var_91_13 * ((var_91_15 - arg_88_1.typewritterCharCountI18N) / var_91_12)) > 0 and var_91_13 < var_91_16 then
					arg_88_1.talkMaxDuration = var_91_16

					if var_91_16 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_16 + var_91_11
					end
				end
			end

			local var_91_17 = math.max(0, arg_88_1.talkMaxDuration)

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_17 then
				arg_88_1.fswtw_.percent = Mathf.Lerp(arg_88_1.var_.oldValueTypewriter, var_91_14, (arg_88_1.time_ - var_91_11) / var_91_17)
				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_88_1.fswtw_:SetDirty()
			end

			if arg_88_1.time_ >= var_91_11 + var_91_17 and arg_88_1.time_ < var_91_11 + var_91_17 + arg_91_0 then
				arg_88_1.fswtw_.percent = var_91_14

				arg_88_1.fswtw_:SetDirty()
				arg_88_1:ShowNextGo(true)

				arg_88_1.typewritterCharCountI18N = var_91_15
			end

			if 0.15 < arg_88_1.time_ and arg_88_1.time_ <= 0.15 + arg_91_0 then
				arg_88_1.fswbg_:SetActive(false)
				arg_88_1.dialog_:SetActive(false)
				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.cswbg_:SetActive(false)
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_18 = 1.5
			local var_91_19 = 0.85

			if 1.5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_20 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_20:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_21 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(319931021).content)

				arg_88_1.text_.text = var_91_21

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_23 = 34 <= 0 and var_91_19 or var_91_19 * (utf8.len(var_91_21) / 34)

				if (34 <= 0 and var_91_19 or var_91_19 * (utf8.len(var_91_21) / 34)) > 0 and var_91_19 < var_91_23 then
					arg_88_1.talkMaxDuration = var_91_23
					var_91_18 = var_91_18 + 0.3

					if var_91_23 + var_91_18 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_18
					end
				end

				arg_88_1.text_.text = var_91_21
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_24 = var_91_18 + 0.3
			local var_91_25 = math.max(var_91_19, arg_88_1.talkMaxDuration)

			if var_91_18 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_24 + var_91_25 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_24) / var_91_25

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_24 + var_91_25 and arg_88_1.time_ < var_91_24 + var_91_25 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319931022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319931022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play319931023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.4

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(319931022).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 56 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 56)

				if (56 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 56)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319931023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319931023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319931024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 1.05

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(319931023).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 42 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 42)

				if (42 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 42)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play319931024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319931024
		arg_102_1.duration_ = 1.92

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play319931025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = manager.audio:GetVoiceLength("story_v_out_319931", "319931024", "story_v_out_319931.awb") / 1000

			if var_105_0 > 0 and 1.633 < var_105_0 and var_105_0 + 0.283333333332333 > arg_102_1.duration_ then
				arg_102_1.duration_ = var_105_0 + 0.283333333332333
			end

			if 0.283333333332333 < arg_102_1.time_ and arg_102_1.time_ <= 0.283333333332333 + arg_105_0 then
				arg_102_1:AudioAction("play", "voice", "story_v_out_319931", "319931024", "story_v_out_319931.awb")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				local var_105_2 = arg_102_1.fswbg_.transform:Find("textbox/adapt/content") or arg_102_1.fswbg_.transform:Find("textbox/content")
				local var_105_3 = arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_105_4 = var_105_2:GetComponent("RectTransform")

				var_105_2:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_105_4.offsetMin = Vector2.New(0, 0)
				var_105_4.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.fswbg_:SetActive(true)
				arg_102_1.dialog_:SetActive(false)

				arg_102_1.fswtw_.percent = 0
				arg_102_1.fswt_.text = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(319931024).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.fswt_)

				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_102_1.fswtw_:SetDirty()

				arg_102_1.typewritterCharCountI18N = 0

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_5 = 0.149999999998999

			if 0.149999999998999 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.var_.oldValueTypewriter = arg_102_1.fswtw_.percent

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_6 = 0
			local var_105_7 = 0
			local var_105_8, var_105_9 = arg_102_1:GetPercentByPara(arg_102_1:FormatText(arg_102_1:GetWordFromCfg(319931024).content), 1)

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				local var_105_10 = var_105_6 <= 0 and var_105_7 or var_105_7 * ((var_105_9 - arg_102_1.typewritterCharCountI18N) / var_105_6)

				if (var_105_6 <= 0 and var_105_7 or var_105_7 * ((var_105_9 - arg_102_1.typewritterCharCountI18N) / var_105_6)) > 0 and var_105_7 < var_105_10 then
					arg_102_1.talkMaxDuration = var_105_10

					if var_105_10 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_5
					end
				end
			end

			local var_105_11 = math.max(0, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_11 then
				arg_102_1.fswtw_.percent = Mathf.Lerp(arg_102_1.var_.oldValueTypewriter, var_105_8, (arg_102_1.time_ - var_105_5) / var_105_11)
				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.fswtw_:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_11 and arg_102_1.time_ < var_105_5 + var_105_11 + arg_105_0 then
				arg_102_1.fswtw_.percent = var_105_8

				arg_102_1.fswtw_:SetDirty()
				arg_102_1:ShowNextGo(true)

				arg_102_1.typewritterCharCountI18N = var_105_9
			end

			local var_105_12 = 0.283333333332333

			if 0.283333333332333 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 then
				arg_102_1.var_.oldValueTypewriter = arg_102_1.fswtw_.percent

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_13 = 4
			local var_105_14 = 0.266666666666667
			local var_105_15, var_105_16 = arg_102_1:GetPercentByPara(arg_102_1:FormatText(arg_102_1:GetWordFromCfg(319931024).content), 1)

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				local var_105_17 = var_105_13 <= 0 and var_105_14 or var_105_14 * ((var_105_16 - arg_102_1.typewritterCharCountI18N) / var_105_13)

				if (var_105_13 <= 0 and var_105_14 or var_105_14 * ((var_105_16 - arg_102_1.typewritterCharCountI18N) / var_105_13)) > 0 and var_105_14 < var_105_17 then
					arg_102_1.talkMaxDuration = var_105_17

					if var_105_17 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_17 + var_105_12
					end
				end
			end

			local var_105_18 = math.max(0.266666666666667, arg_102_1.talkMaxDuration)

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_18 then
				arg_102_1.fswtw_.percent = Mathf.Lerp(arg_102_1.var_.oldValueTypewriter, var_105_15, (arg_102_1.time_ - var_105_12) / var_105_18)
				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.fswtw_:SetDirty()
			end

			if arg_102_1.time_ >= var_105_12 + var_105_18 and arg_102_1.time_ < var_105_12 + var_105_18 + arg_105_0 then
				arg_102_1.fswtw_.percent = var_105_15

				arg_102_1.fswtw_:SetDirty()
				arg_102_1:ShowNextGo(true)

				arg_102_1.typewritterCharCountI18N = var_105_16
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.cswbg_:SetActive(true)

				local var_105_19 = arg_102_1.cswt_:GetComponent("RectTransform")

				arg_102_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_105_19.offsetMin = Vector2.New(410, 330)
				var_105_19.offsetMax = Vector2.New(-400, -175)
				arg_102_1.cswt_.text = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(419080).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.cswt_)

				arg_102_1.cswt_.fontSize = 180
				arg_102_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_102_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play319931025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 319931025
		arg_106_1.duration_ = 5.9

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play319931026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_0 = 0.149999999998999

			if 0.149999999998999 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.var_.oldValueTypewriter = arg_106_1.fswtw_.percent

				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_1 = 0
			local var_109_2 = 0
			local var_109_3, var_109_4 = arg_106_1:GetPercentByPara(arg_106_1:FormatText(arg_106_1:GetWordFromCfg(319931024).content), 1)

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				local var_109_5 = var_109_1 <= 0 and var_109_2 or var_109_2 * ((var_109_4 - arg_106_1.typewritterCharCountI18N) / var_109_1)

				if (var_109_1 <= 0 and var_109_2 or var_109_2 * ((var_109_4 - arg_106_1.typewritterCharCountI18N) / var_109_1)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_0
					end
				end
			end

			local var_109_6 = math.max(0, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_6 then
				arg_106_1.fswtw_.percent = Mathf.Lerp(arg_106_1.var_.oldValueTypewriter, var_109_3, (arg_106_1.time_ - var_109_0) / var_109_6)
				arg_106_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_106_1.fswtw_:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_6 and arg_106_1.time_ < var_109_0 + var_109_6 + arg_109_0 then
				arg_106_1.fswtw_.percent = var_109_3

				arg_106_1.fswtw_:SetDirty()
				arg_106_1:ShowNextGo(true)

				arg_106_1.typewritterCharCountI18N = var_109_4
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.cswbg_:SetActive(false)
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				local var_109_7 = arg_106_1.bgs_.STblack

				arg_106_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_109_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_109_8 = var_109_7:GetComponent("SpriteRenderer")

				if var_109_8 and var_109_8.sprite then
					local var_109_9 = 2 * (var_109_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_109_7.transform.localScale = Vector3.New(var_109_9 / var_109_8.sprite.bounds.size.y < var_109_9 * manager.ui.mainCameraCom_.aspect / var_109_8.sprite.bounds.size.x and var_109_9 * manager.ui.mainCameraCom_.aspect / var_109_8.sprite.bounds.size.x or var_109_9 / var_109_8.sprite.bounds.size.y, var_109_9 / var_109_8.sprite.bounds.size.y < var_109_9 * manager.ui.mainCameraCom_.aspect / var_109_8.sprite.bounds.size.x and var_109_9 * manager.ui.mainCameraCom_.aspect / var_109_8.sprite.bounds.size.x or var_109_9 / var_109_8.sprite.bounds.size.y, 0)
				end

				for iter_109_0, iter_109_1 in pairs(arg_106_1.bgs_) do
					if iter_109_0 ~= "STblack" then
						iter_109_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_109_10 = 1.00008890058234e-12

			if 1.00008890058234e-12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_11 = 1

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 then
				local var_109_12 = Color.New(0, 0, 0)

				var_109_12.a = Mathf.Lerp(1, 0, (arg_106_1.time_ - var_109_10) / var_109_11)
				arg_106_1.mask_.color = var_109_12
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 then
				local var_109_13 = Color.New(0, 0, 0)

				arg_106_1.mask_.enabled = false
				var_109_13.a = 0
				arg_106_1.mask_.color = var_109_13
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_14 = 0.9
			local var_109_15 = 1.7

			if 0.9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_16 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_16:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_17 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(319931025).content)

				arg_106_1.text_.text = var_109_17

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_19 = 68 <= 0 and var_109_15 or var_109_15 * (utf8.len(var_109_17) / 68)

				if (68 <= 0 and var_109_15 or var_109_15 * (utf8.len(var_109_17) / 68)) > 0 and var_109_15 < var_109_19 then
					arg_106_1.talkMaxDuration = var_109_19
					var_109_14 = var_109_14 + 0.3

					if var_109_19 + var_109_14 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_14
					end
				end

				arg_106_1.text_.text = var_109_17
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_20 = var_109_14 + 0.3
			local var_109_21 = math.max(var_109_15, arg_106_1.talkMaxDuration)

			if var_109_14 + 0.3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_20 + var_109_21 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_20) / var_109_21

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_20 + var_109_21 and arg_106_1.time_ < var_109_20 + var_109_21 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play319931026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319931026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319931027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_115_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_112_1.bgmTxt_.text ~= var_115_2 and arg_112_1.bgmTxt_.text ~= "" then
						if arg_112_1.bgmTxt2_.text ~= "" then
							arg_112_1.bgmTxt_.text = arg_112_1.bgmTxt2_.text
						end

						arg_112_1.bgmTxt2_.text = var_115_2

						arg_112_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_112_1.bgmTxt_.text = var_115_2
						arg_112_1.bgmTxt2_.text = var_115_2
					end

					if arg_112_1.bgmTimer then
						arg_112_1.bgmTimer:Stop()

						arg_112_1.bgmTimer = nil
					end

					if arg_112_1.settingData.show_music_name == 1 then
						arg_112_1.musicController:SetSelectedState("show")
						arg_112_1.musicAnimator_:Play("open", 0, 0)

						if arg_112_1.settingData.music_time ~= 0 then
							arg_112_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_112_1.settingData.music_time), function()
								if arg_112_1 == nil or isNil(arg_112_1.bgmTxt_) then
									return
								end

								arg_112_1.musicController:SetSelectedState("hide")
								arg_112_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_115_3 = 0
			local var_115_4 = 0.775

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_5 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(319931026).content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 31 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 31)

				if (31 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 31)) > 0 and var_115_4 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_3
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_4, arg_112_1.talkMaxDuration)

			if var_115_3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_3 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_3) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_3 + var_115_8 and arg_112_1.time_ < var_115_3 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319931027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319931027
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319931028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.I11r

				arg_117_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "I11r" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 1

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_3 + 0.3 and arg_117_1.time_ < var_120_3 + 0.3 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_4 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_5 = 1

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_5 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_4) / var_120_5)
				arg_117_1.mask_.color = var_120_6
			end

			if arg_117_1.time_ >= var_120_4 + var_120_5 and arg_117_1.time_ < var_120_4 + var_120_5 + arg_120_0 then
				local var_120_7 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_7.a = 0
				arg_117_1.mask_.color = var_120_7
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_8 = 1
			local var_120_9 = 0.35

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_10 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_10:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_11 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(319931027).content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 14 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 14)

				if (14 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 14)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13
					var_120_8 = var_120_8 + 0.3

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = var_120_8 + 0.3
			local var_120_15 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_14 + var_120_15 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_14) / var_120_15

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319931028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319931028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play319931029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.5

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(319931028).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 60 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 60)

				if (60 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 60)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play319931029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319931029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play319931030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.85

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(319931029).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 34 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 34)

				if (34 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 34)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319931030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319931030
		arg_131_1.duration_ = 3.93

		local var_131_0 = {
			zh = 2,
			ja = 3.933
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play319931031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10075ui_story = arg_131_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10075ui_story"].transform.position).z)
				arg_131_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10075ui_story"].transform.localEulerAngles = arg_131_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0, -0.715, -6.15)
				arg_131_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10075ui_story"].transform.position).z)
				arg_131_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10075ui_story"].transform.localEulerAngles = arg_131_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["10075ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10075ui_story == nil then
				arg_131_1.var_.characterEffect10075ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect10075ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10075ui_story then
				arg_131_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action3_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_134_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_131_1.bgmTxt_.text ~= var_134_6 and arg_131_1.bgmTxt_.text ~= "" then
						if arg_131_1.bgmTxt2_.text ~= "" then
							arg_131_1.bgmTxt_.text = arg_131_1.bgmTxt2_.text
						end

						arg_131_1.bgmTxt2_.text = var_134_6

						arg_131_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_131_1.bgmTxt_.text = var_134_6
						arg_131_1.bgmTxt2_.text = var_134_6
					end

					if arg_131_1.bgmTimer then
						arg_131_1.bgmTimer:Stop()

						arg_131_1.bgmTimer = nil
					end

					if arg_131_1.settingData.show_music_name == 1 then
						arg_131_1.musicController:SetSelectedState("show")
						arg_131_1.musicAnimator_:Play("open", 0, 0)

						if arg_131_1.settingData.music_time ~= 0 then
							arg_131_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_131_1.settingData.music_time), function()
								if arg_131_1 == nil or isNil(arg_131_1.bgmTxt_) then
									return
								end

								arg_131_1.musicController:SetSelectedState("hide")
								arg_131_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_131_1.time_ and arg_131_1.time_ <= 0.233333333333333 + arg_134_0 then
				arg_131_1:AudioAction("play", "music", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_134_9 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if "" ~= "" then
					if arg_131_1.bgmTxt_.text ~= var_134_9 and arg_131_1.bgmTxt_.text ~= "" then
						if arg_131_1.bgmTxt2_.text ~= "" then
							arg_131_1.bgmTxt_.text = arg_131_1.bgmTxt2_.text
						end

						arg_131_1.bgmTxt2_.text = var_134_9

						arg_131_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_131_1.bgmTxt_.text = var_134_9
						arg_131_1.bgmTxt2_.text = var_134_9
					end

					if arg_131_1.bgmTimer then
						arg_131_1.bgmTimer:Stop()

						arg_131_1.bgmTimer = nil
					end

					if arg_131_1.settingData.show_music_name == 1 then
						arg_131_1.musicController:SetSelectedState("show")
						arg_131_1.musicAnimator_:Play("open", 0, 0)

						if arg_131_1.settingData.music_time ~= 0 then
							arg_131_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_131_1.settingData.music_time), function()
								if arg_131_1 == nil or isNil(arg_131_1.bgmTxt_) then
									return
								end

								arg_131_1.musicController:SetSelectedState("hide")
								arg_131_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_134_10 = 0
			local var_134_11 = 0.2

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_12 = arg_131_1:GetWordFromCfg(319931030)
				local var_134_13 = arg_131_1:FormatText(var_134_12.content)

				arg_131_1.text_.text = var_134_13

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_15 = 8 <= 0 and var_134_11 or var_134_11 * (utf8.len(var_134_13) / 8)

				if (8 <= 0 and var_134_11 or var_134_11 * (utf8.len(var_134_13) / 8)) > 0 and var_134_11 < var_134_15 then
					arg_131_1.talkMaxDuration = var_134_15

					if var_134_15 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_15 + var_134_10
					end
				end

				arg_131_1.text_.text = var_134_13
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931030", "story_v_out_319931.awb") ~= 0 then
					local var_134_16 = manager.audio:GetVoiceLength("story_v_out_319931", "319931030", "story_v_out_319931.awb") / 1000

					if var_134_16 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_10
					end

					if var_134_12.prefab_name ~= "" and arg_131_1.actors_[var_134_12.prefab_name] ~= nil then
						local var_134_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_12.prefab_name].transform, "story_v_out_319931", "319931030", "story_v_out_319931.awb")

						arg_131_1:RecordAudio("319931030", var_134_17)
						arg_131_1:RecordAudio("319931030", var_134_17)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319931", "319931030", "story_v_out_319931.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319931", "319931030", "story_v_out_319931.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_18 = math.max(var_134_11, arg_131_1.talkMaxDuration)

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_18 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_10) / var_134_18

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_10 + var_134_18 and arg_131_1.time_ < var_134_10 + var_134_18 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play319931031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319931031
		arg_137_1.duration_ = 4.13

		local var_137_0 = {
			zh = 2.933,
			ja = 4.133
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play319931032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10079ui_story = arg_137_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10079ui_story"].transform.position).z)
				arg_137_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10079ui_story"].transform.localEulerAngles = arg_137_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_137_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10079ui_story"].transform.position).z)
				arg_137_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10079ui_story"].transform.localEulerAngles = arg_137_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10079ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10079ui_story == nil then
				arg_137_1.var_.characterEffect10079ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10079ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10079ui_story then
				arg_137_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_4 = arg_137_1.actors_["10075ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10075ui_story = var_140_4.localPosition
			end

			local var_140_5 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 then
				var_140_4.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_137_1.time_ - 0) / var_140_5)
				var_140_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_4.position).x, (manager.ui.mainCamera.transform.position - var_140_4.position).y, (manager.ui.mainCamera.transform.position - var_140_4.position).z)
				var_140_4.localEulerAngles.z = 0
				var_140_4.localEulerAngles.x = 0
				var_140_4.localEulerAngles = var_140_4.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 then
				var_140_4.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_140_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_4.position).x, (manager.ui.mainCamera.transform.position - var_140_4.position).y, (manager.ui.mainCamera.transform.position - var_140_4.position).z)
				var_140_4.localEulerAngles.z = 0
				var_140_4.localEulerAngles.x = 0
				var_140_4.localEulerAngles = var_140_4.localEulerAngles
			end

			local var_140_6 = arg_137_1.actors_["10075ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10075ui_story == nil then
				arg_137_1.var_.characterEffect10075ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_7 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 and not isNil(var_140_6) then
				if arg_137_1.var_.characterEffect10075ui_story and not isNil(var_140_6) then
					arg_137_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_7)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10075ui_story then
				arg_137_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_140_8 = 0
			local var_140_9 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(319931031)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 15 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 15)

				if (15 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 15)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931031", "story_v_out_319931.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_319931", "319931031", "story_v_out_319931.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_319931", "319931031", "story_v_out_319931.awb")

						arg_137_1:RecordAudio("319931031", var_140_15)
						arg_137_1:RecordAudio("319931031", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319931", "319931031", "story_v_out_319931.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319931", "319931031", "story_v_out_319931.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play319931032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319931032
		arg_141_1.duration_ = 5

		local var_141_0 = {
			zh = 4.3,
			ja = 5
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319931033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10079ui_story"]) and arg_141_1.var_.characterEffect10079ui_story == nil then
				arg_141_1.var_.characterEffect10079ui_story = arg_141_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10079ui_story"]) then
				if arg_141_1.var_.characterEffect10079ui_story and not isNil(arg_141_1.actors_["10079ui_story"]) then
					arg_141_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10079ui_story"]) and arg_141_1.var_.characterEffect10079ui_story then
				arg_141_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action435")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_144_1 = arg_141_1.actors_["10075ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10075ui_story == nil then
				arg_141_1.var_.characterEffect10075ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10075ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10075ui_story then
				arg_141_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_144_4 = 0
			local var_144_5 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(319931032)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 14 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 14)

				if (14 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 14)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931032", "story_v_out_319931.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931032", "story_v_out_319931.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_319931", "319931032", "story_v_out_319931.awb")

						arg_141_1:RecordAudio("319931032", var_144_11)
						arg_141_1:RecordAudio("319931032", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319931", "319931032", "story_v_out_319931.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319931", "319931032", "story_v_out_319931.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319931033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319931033
		arg_145_1.duration_ = 5

		local var_145_0 = {
			zh = 3.933,
			ja = 5
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play319931034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10079ui_story"]) and arg_145_1.var_.characterEffect10079ui_story == nil then
				arg_145_1.var_.characterEffect10079ui_story = arg_145_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10079ui_story"]) then
				if arg_145_1.var_.characterEffect10079ui_story and not isNil(arg_145_1.actors_["10079ui_story"]) then
					arg_145_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10079ui_story"]) and arg_145_1.var_.characterEffect10079ui_story then
				arg_145_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_148_2 = arg_145_1.actors_["10075ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10075ui_story == nil then
				arg_145_1.var_.characterEffect10075ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect10075ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10075ui_story then
				arg_145_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_148_4 = 0
			local var_148_5 = 0.4

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(319931033)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 16 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 16)

				if (16 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 16)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931033", "story_v_out_319931.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931033", "story_v_out_319931.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_319931", "319931033", "story_v_out_319931.awb")

						arg_145_1:RecordAudio("319931033", var_148_11)
						arg_145_1:RecordAudio("319931033", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319931", "319931033", "story_v_out_319931.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319931", "319931033", "story_v_out_319931.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319931034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319931034
		arg_149_1.duration_ = 14.4

		local var_149_0 = {
			zh = 14.4,
			ja = 5.566
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play319931035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10075ui_story"]) and arg_149_1.var_.characterEffect10075ui_story == nil then
				arg_149_1.var_.characterEffect10075ui_story = arg_149_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10075ui_story"]) then
				if arg_149_1.var_.characterEffect10075ui_story and not isNil(arg_149_1.actors_["10075ui_story"]) then
					arg_149_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10075ui_story"]) and arg_149_1.var_.characterEffect10075ui_story then
				arg_149_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action5_2")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_152_2 = arg_149_1.actors_["10079ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10079ui_story == nil then
				arg_149_1.var_.characterEffect10079ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect10079ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10079ui_story then
				arg_149_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.8

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(319931034)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 32 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 32)

				if (32 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 32)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931034", "story_v_out_319931.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931034", "story_v_out_319931.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_319931", "319931034", "story_v_out_319931.awb")

						arg_149_1:RecordAudio("319931034", var_152_11)
						arg_149_1:RecordAudio("319931034", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319931", "319931034", "story_v_out_319931.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319931", "319931034", "story_v_out_319931.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play319931035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319931035
		arg_153_1.duration_ = 4.37

		local var_153_0 = {
			zh = 3.4,
			ja = 4.366
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play319931036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10079ui_story"]) and arg_153_1.var_.characterEffect10079ui_story == nil then
				arg_153_1.var_.characterEffect10079ui_story = arg_153_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10079ui_story"]) then
				if arg_153_1.var_.characterEffect10079ui_story and not isNil(arg_153_1.actors_["10079ui_story"]) then
					arg_153_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10079ui_story"]) and arg_153_1.var_.characterEffect10079ui_story then
				arg_153_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_2 = arg_153_1.actors_["10075ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect10075ui_story == nil then
				arg_153_1.var_.characterEffect10075ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect10075ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect10075ui_story then
				arg_153_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 0.3

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(319931035)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 12 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 12)

				if (12 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 12)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931035", "story_v_out_319931.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931035", "story_v_out_319931.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_319931", "319931035", "story_v_out_319931.awb")

						arg_153_1:RecordAudio("319931035", var_156_11)
						arg_153_1:RecordAudio("319931035", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_319931", "319931035", "story_v_out_319931.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_319931", "319931035", "story_v_out_319931.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play319931036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319931036
		arg_157_1.duration_ = 13.1

		local var_157_0 = {
			zh = 9.966,
			ja = 13.1
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play319931037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10079ui_story"]) and arg_157_1.var_.characterEffect10079ui_story == nil then
				arg_157_1.var_.characterEffect10079ui_story = arg_157_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10079ui_story"]) then
				if arg_157_1.var_.characterEffect10079ui_story and not isNil(arg_157_1.actors_["10079ui_story"]) then
					arg_157_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10079ui_story"]) and arg_157_1.var_.characterEffect10079ui_story then
				arg_157_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_160_1 = arg_157_1.actors_["10075ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10075ui_story == nil then
				arg_157_1.var_.characterEffect10075ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect10075ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10075ui_story then
				arg_157_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_160_4 = 0
			local var_160_5 = 0.95

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(319931036)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 38 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 38)

				if (38 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 38)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931036", "story_v_out_319931.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931036", "story_v_out_319931.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_319931", "319931036", "story_v_out_319931.awb")

						arg_157_1:RecordAudio("319931036", var_160_11)
						arg_157_1:RecordAudio("319931036", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_319931", "319931036", "story_v_out_319931.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_319931", "319931036", "story_v_out_319931.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319931037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319931037
		arg_161_1.duration_ = 12.53

		local var_161_0 = {
			zh = 11.233,
			ja = 12.533
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
				arg_161_0:Play319931038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.95

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(319931037)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 38)

				if (38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 38)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931037", "story_v_out_319931.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931037", "story_v_out_319931.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_319931", "319931037", "story_v_out_319931.awb")

						arg_161_1:RecordAudio("319931037", var_164_6)
						arg_161_1:RecordAudio("319931037", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319931", "319931037", "story_v_out_319931.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319931", "319931037", "story_v_out_319931.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319931038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319931038
		arg_165_1.duration_ = 13.53

		local var_165_0 = {
			zh = 9.533,
			ja = 13.533
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
				arg_165_0:Play319931039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.825

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(319931038)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 33 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 33)

				if (33 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 33)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931038", "story_v_out_319931.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931038", "story_v_out_319931.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_319931", "319931038", "story_v_out_319931.awb")

						arg_165_1:RecordAudio("319931038", var_168_6)
						arg_165_1:RecordAudio("319931038", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319931", "319931038", "story_v_out_319931.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319931", "319931038", "story_v_out_319931.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319931039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319931039
		arg_169_1.duration_ = 20

		local var_169_0 = {
			zh = 13.333,
			ja = 20
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
				arg_169_0:Play319931040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.15

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(319931039)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 46 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 46)

				if (46 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 46)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931039", "story_v_out_319931.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931039", "story_v_out_319931.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_319931", "319931039", "story_v_out_319931.awb")

						arg_169_1:RecordAudio("319931039", var_172_6)
						arg_169_1:RecordAudio("319931039", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319931", "319931039", "story_v_out_319931.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319931", "319931039", "story_v_out_319931.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319931040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319931040
		arg_173_1.duration_ = 6.93

		local var_173_0 = {
			zh = 5.866,
			ja = 6.933
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319931041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10079ui_story"]) and arg_173_1.var_.characterEffect10079ui_story == nil then
				arg_173_1.var_.characterEffect10079ui_story = arg_173_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10079ui_story"]) then
				if arg_173_1.var_.characterEffect10079ui_story and not isNil(arg_173_1.actors_["10079ui_story"]) then
					arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10079ui_story"]) and arg_173_1.var_.characterEffect10079ui_story then
				arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_2 = arg_173_1.actors_["10075ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect10075ui_story == nil then
				arg_173_1.var_.characterEffect10075ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect10075ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_3)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect10075ui_story then
				arg_173_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_176_4 = 0
			local var_176_5 = 0.6

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(319931040)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 24 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 24)

				if (24 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 24)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931040", "story_v_out_319931.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931040", "story_v_out_319931.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_319931", "319931040", "story_v_out_319931.awb")

						arg_173_1:RecordAudio("319931040", var_176_11)
						arg_173_1:RecordAudio("319931040", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319931", "319931040", "story_v_out_319931.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319931", "319931040", "story_v_out_319931.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319931041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319931041
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319931042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10079ui_story"]) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = arg_177_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10079ui_story"]) then
				if arg_177_1.var_.characterEffect10079ui_story and not isNil(arg_177_1.actors_["10079ui_story"]) then
					arg_177_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10079ui_story"]) and arg_177_1.var_.characterEffect10079ui_story then
				arg_177_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_180_1 = arg_177_1.actors_["10079ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10079ui_story = var_180_1.localPosition
			end

			local var_180_2 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 then
				var_180_1.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_2)
				var_180_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_1.position).x, (manager.ui.mainCamera.transform.position - var_180_1.position).y, (manager.ui.mainCamera.transform.position - var_180_1.position).z)
				var_180_1.localEulerAngles.z = 0
				var_180_1.localEulerAngles.x = 0
				var_180_1.localEulerAngles = var_180_1.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 then
				var_180_1.localPosition = Vector3.New(0, 100, 0)
				var_180_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_1.position).x, (manager.ui.mainCamera.transform.position - var_180_1.position).y, (manager.ui.mainCamera.transform.position - var_180_1.position).z)
				var_180_1.localEulerAngles.z = 0
				var_180_1.localEulerAngles.x = 0
				var_180_1.localEulerAngles = var_180_1.localEulerAngles
			end

			local var_180_3 = arg_177_1.actors_["10075ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10075ui_story = var_180_3.localPosition
			end

			local var_180_4 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_3.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_4)
				var_180_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_3.position).x, (manager.ui.mainCamera.transform.position - var_180_3.position).y, (manager.ui.mainCamera.transform.position - var_180_3.position).z)
				var_180_3.localEulerAngles.z = 0
				var_180_3.localEulerAngles.x = 0
				var_180_3.localEulerAngles = var_180_3.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_3.localPosition = Vector3.New(0, 100, 0)
				var_180_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_3.position).x, (manager.ui.mainCamera.transform.position - var_180_3.position).y, (manager.ui.mainCamera.transform.position - var_180_3.position).z)
				var_180_3.localEulerAngles.z = 0
				var_180_3.localEulerAngles.x = 0
				var_180_3.localEulerAngles = var_180_3.localEulerAngles
			end

			local var_180_5 = 0
			local var_180_6 = 0.9

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(319931041).content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 36 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_7) / 36)

				if (36 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_7) / 36)) > 0 and var_180_6 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_10 and arg_177_1.time_ < var_180_5 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play319931042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319931042
		arg_181_1.duration_ = 7

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319931043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if arg_181_1.bgs_.I11i == nil then
				local var_184_0 = Object.Instantiate(arg_181_1.paintGo_)

				var_184_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11i")
				var_184_0.name = "I11i"
				var_184_0.transform.parent = arg_181_1.stage_.transform
				var_184_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.bgs_.I11i = var_184_0
			end

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				local var_184_1 = arg_181_1.bgs_.I11i

				arg_181_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_2 = var_184_1:GetComponent("SpriteRenderer")

				if var_184_2 and var_184_2.sprite then
					local var_184_3 = 2 * (var_184_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_1.transform.localScale = Vector3.New(var_184_3 / var_184_2.sprite.bounds.size.y < var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x and var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x or var_184_3 / var_184_2.sprite.bounds.size.y, var_184_3 / var_184_2.sprite.bounds.size.y < var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x and var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x or var_184_3 / var_184_2.sprite.bounds.size.y, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "I11i" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_4 = 2

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			if arg_181_1.time_ >= var_184_4 + 0.3 and arg_181_1.time_ < var_184_4 + 0.3 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			local var_184_5 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_6 = 1

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 then
				local var_184_7 = Color.New(0, 0, 0)

				var_184_7.a = Mathf.Lerp(0, 1, (arg_181_1.time_ - var_184_5) / var_184_6)
				arg_181_1.mask_.color = var_184_7
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 then
				local var_184_8 = Color.New(0, 0, 0)

				var_184_8.a = 1
				arg_181_1.mask_.color = var_184_8
			end

			local var_184_9 = 1

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_10 = 1

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 then
				local var_184_11 = Color.New(0, 0, 0)

				var_184_11.a = Mathf.Lerp(1, 0, (arg_181_1.time_ - var_184_9) / var_184_10)
				arg_181_1.mask_.color = var_184_11
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 then
				local var_184_12 = Color.New(0, 0, 0)

				arg_181_1.mask_.enabled = false
				var_184_12.a = 0
				arg_181_1.mask_.color = var_184_12
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_13 = 2
			local var_184_14 = 0.65

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_15 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_15:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_16 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(319931042).content)

				arg_181_1.text_.text = var_184_16

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_18 = 26 <= 0 and var_184_14 or var_184_14 * (utf8.len(var_184_16) / 26)

				if (26 <= 0 and var_184_14 or var_184_14 * (utf8.len(var_184_16) / 26)) > 0 and var_184_14 < var_184_18 then
					arg_181_1.talkMaxDuration = var_184_18
					var_184_13 = var_184_13 + 0.3

					if var_184_18 + var_184_13 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_13
					end
				end

				arg_181_1.text_.text = var_184_16
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_19 = var_184_13 + 0.3
			local var_184_20 = math.max(var_184_14, arg_181_1.talkMaxDuration)

			if var_184_13 + 0.3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_19 + var_184_20 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_19) / var_184_20

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_19 + var_184_20 and arg_181_1.time_ < var_184_19 + var_184_20 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319931043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319931043
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319931044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.925

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(319931043).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 37 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 37)

				if (37 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 37)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319931044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319931044
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319931045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.15

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(319931044).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 46 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 46)

				if (46 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 46)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319931045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319931045
		arg_195_1.duration_ = 4.27

		local var_195_0 = {
			zh = 1.999999999999,
			ja = 4.266
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
				arg_195_0:Play319931046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if arg_195_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_198_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_195_1.stage_.transform)

				var_198_0.name = "1084ui_story"
				var_198_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1084ui_story"] = var_198_0

				local var_198_1 = var_198_0:GetComponentInChildren(typeof(CharacterEffect))

				var_198_1.enabled = true

				local var_198_2 = GameObjectTools.GetOrAddComponent(var_198_0, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(false)
				end

				arg_195_1:ShowWeapon(var_198_1.transform, false)

				arg_195_1.var_["1084ui_story" .. "Animator"] = var_198_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_195_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_195_1.var_["1084ui_story" .. "LipSync"] = var_198_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_198_3 = arg_195_1.actors_["1084ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1084ui_story = var_198_3.localPosition

				arg_195_1:ShowWeapon(arg_195_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_3.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_195_1.time_ - 0) / var_198_4)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			local var_198_5 = arg_195_1.actors_["1084ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect1084ui_story == nil then
				arg_195_1.var_.characterEffect1084ui_story = var_198_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.characterEffect1084ui_story and not isNil(var_198_5) then
					arg_195_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect1084ui_story then
				arg_195_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_198_8 = 0
			local var_198_9 = 0.225

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_10 = arg_195_1:GetWordFromCfg(319931045)
				local var_198_11 = arg_195_1:FormatText(var_198_10.content)

				arg_195_1.text_.text = var_198_11

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_13 = 9 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 9)

				if (9 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 9)) > 0 and var_198_9 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_11
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931045", "story_v_out_319931.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_out_319931", "319931045", "story_v_out_319931.awb") / 1000

					if var_198_14 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_8
					end

					if var_198_10.prefab_name ~= "" and arg_195_1.actors_[var_198_10.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_10.prefab_name].transform, "story_v_out_319931", "319931045", "story_v_out_319931.awb")

						arg_195_1:RecordAudio("319931045", var_198_15)
						arg_195_1:RecordAudio("319931045", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319931", "319931045", "story_v_out_319931.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319931", "319931045", "story_v_out_319931.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_16 and arg_195_1.time_ < var_198_8 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play319931046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319931046
		arg_199_1.duration_ = 13.4

		local var_199_0 = {
			zh = 13.4,
			ja = 9.266
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319931047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10075ui_story"]) and arg_199_1.var_.characterEffect10075ui_story == nil then
				arg_199_1.var_.characterEffect10075ui_story = arg_199_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10075ui_story"]) then
				if arg_199_1.var_.characterEffect10075ui_story and not isNil(arg_199_1.actors_["10075ui_story"]) then
					arg_199_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10075ui_story"]) and arg_199_1.var_.characterEffect10075ui_story then
				arg_199_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_202_2 = arg_199_1.actors_["1084ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1084ui_story == nil then
				arg_199_1.var_.characterEffect1084ui_story = var_202_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.characterEffect1084ui_story and not isNil(var_202_2) then
					arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_3)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1084ui_story then
				arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_202_4 = arg_199_1.actors_["10075ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10075ui_story = var_202_4.localPosition
			end

			local var_202_5 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 then
				var_202_4.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_199_1.time_ - 0) / var_202_5)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 then
				var_202_4.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			local var_202_6 = 0
			local var_202_7 = 0.825

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(319931046)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 33 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 33)

				if (33 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 33)) > 0 and var_202_7 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931046", "story_v_out_319931.awb") ~= 0 then
					local var_202_12 = manager.audio:GetVoiceLength("story_v_out_319931", "319931046", "story_v_out_319931.awb") / 1000

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end

					if var_202_8.prefab_name ~= "" and arg_199_1.actors_[var_202_8.prefab_name] ~= nil then
						local var_202_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_8.prefab_name].transform, "story_v_out_319931", "319931046", "story_v_out_319931.awb")

						arg_199_1:RecordAudio("319931046", var_202_13)
						arg_199_1:RecordAudio("319931046", var_202_13)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319931", "319931046", "story_v_out_319931.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319931", "319931046", "story_v_out_319931.awb")
				end

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

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play319931047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319931047
		arg_203_1.duration_ = 10

		local var_203_0 = {
			zh = 7.766,
			ja = 10
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
				arg_203_0:Play319931048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.625

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(319931047)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 25 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 25)

				if (25 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 25)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931047", "story_v_out_319931.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931047", "story_v_out_319931.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_319931", "319931047", "story_v_out_319931.awb")

						arg_203_1:RecordAudio("319931047", var_206_6)
						arg_203_1:RecordAudio("319931047", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319931", "319931047", "story_v_out_319931.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319931", "319931047", "story_v_out_319931.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play319931048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319931048
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play319931049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10075ui_story"]) and arg_207_1.var_.characterEffect10075ui_story == nil then
				arg_207_1.var_.characterEffect10075ui_story = arg_207_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10075ui_story"]) then
				if arg_207_1.var_.characterEffect10075ui_story and not isNil(arg_207_1.actors_["10075ui_story"]) then
					arg_207_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10075ui_story"]) and arg_207_1.var_.characterEffect10075ui_story then
				arg_207_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.775

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(319931048).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 31 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 31)

				if (31 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 31)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play319931049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319931049
		arg_211_1.duration_ = 7.33

		local var_211_0 = {
			zh = 3.666,
			ja = 7.333
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
				arg_211_0:Play319931050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10075ui_story"]) and arg_211_1.var_.characterEffect10075ui_story == nil then
				arg_211_1.var_.characterEffect10075ui_story = arg_211_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10075ui_story"]) then
				if arg_211_1.var_.characterEffect10075ui_story and not isNil(arg_211_1.actors_["10075ui_story"]) then
					arg_211_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10075ui_story"]) and arg_211_1.var_.characterEffect10075ui_story then
				arg_211_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			local var_214_2 = 0
			local var_214_3 = 0.3

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(319931049)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 12 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 12)

				if (12 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 12)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931049", "story_v_out_319931.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931049", "story_v_out_319931.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_319931", "319931049", "story_v_out_319931.awb")

						arg_211_1:RecordAudio("319931049", var_214_9)
						arg_211_1:RecordAudio("319931049", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319931", "319931049", "story_v_out_319931.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319931", "319931049", "story_v_out_319931.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319931050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319931050
		arg_215_1.duration_ = 6.33

		local var_215_0 = {
			zh = 5.766,
			ja = 6.333
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319931051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10075ui_story"]) and arg_215_1.var_.characterEffect10075ui_story == nil then
				arg_215_1.var_.characterEffect10075ui_story = arg_215_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10075ui_story"]) then
				if arg_215_1.var_.characterEffect10075ui_story and not isNil(arg_215_1.actors_["10075ui_story"]) then
					arg_215_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10075ui_story"]) and arg_215_1.var_.characterEffect10075ui_story then
				arg_215_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_218_1 = arg_215_1.actors_["1084ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1084ui_story == nil then
				arg_215_1.var_.characterEffect1084ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1084ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1084ui_story then
				arg_215_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_218_4 = 0
			local var_218_5 = 0.475

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(319931050)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 19 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 19)

				if (19 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 19)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931050", "story_v_out_319931.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931050", "story_v_out_319931.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_319931", "319931050", "story_v_out_319931.awb")

						arg_215_1:RecordAudio("319931050", var_218_11)
						arg_215_1:RecordAudio("319931050", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_319931", "319931050", "story_v_out_319931.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_319931", "319931050", "story_v_out_319931.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319931051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319931051
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319931052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = arg_219_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(arg_219_1.actors_["1084ui_story"]) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.5

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(319931051).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 20 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 20)

				if (20 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 20)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319931052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319931052
		arg_223_1.duration_ = 4.6

		local var_223_0 = {
			zh = 4.033,
			ja = 4.6
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
				arg_223_0:Play319931053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if arg_223_1.bgs_.ML0207 == nil then
				local var_226_0 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0207")
				var_226_0.name = "ML0207"
				var_226_0.transform.parent = arg_223_1.stage_.transform
				var_226_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_.ML0207 = var_226_0
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				local var_226_1 = arg_223_1.bgs_.ML0207

				arg_223_1.bgs_.ML0207.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_2 = var_226_1:GetComponent("SpriteRenderer")

				if var_226_2 and var_226_2.sprite then
					local var_226_3 = 2 * (var_226_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_1.transform.localScale = Vector3.New(var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "ML0207" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_4 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_4 + 0.3 and arg_223_1.time_ < var_226_4 + 0.3 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_5 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_6 = 2

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_6 then
				local var_226_7 = Color.New(1, 1, 1)

				var_226_7.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_5) / var_226_6)
				arg_223_1.mask_.color = var_226_7
			end

			if arg_223_1.time_ >= var_226_5 + var_226_6 and arg_223_1.time_ < var_226_5 + var_226_6 + arg_226_0 then
				local var_226_8 = Color.New(1, 1, 1)

				arg_223_1.mask_.enabled = false
				var_226_8.a = 0
				arg_223_1.mask_.color = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1084ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1084ui_story = var_226_9.localPosition
			end

			local var_226_10 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_10 then
				var_226_9.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_10)
				var_226_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_9.position).x, (manager.ui.mainCamera.transform.position - var_226_9.position).y, (manager.ui.mainCamera.transform.position - var_226_9.position).z)
				var_226_9.localEulerAngles.z = 0
				var_226_9.localEulerAngles.x = 0
				var_226_9.localEulerAngles = var_226_9.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_10 and arg_223_1.time_ < 0 + var_226_10 + arg_226_0 then
				var_226_9.localPosition = Vector3.New(0, 100, 0)
				var_226_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_9.position).x, (manager.ui.mainCamera.transform.position - var_226_9.position).y, (manager.ui.mainCamera.transform.position - var_226_9.position).z)
				var_226_9.localEulerAngles.z = 0
				var_226_9.localEulerAngles.x = 0
				var_226_9.localEulerAngles = var_226_9.localEulerAngles
			end

			local var_226_11 = arg_223_1.actors_["10075ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10075ui_story = var_226_11.localPosition
			end

			local var_226_12 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_12 then
				var_226_11.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_12)
				var_226_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_11.position).x, (manager.ui.mainCamera.transform.position - var_226_11.position).y, (manager.ui.mainCamera.transform.position - var_226_11.position).z)
				var_226_11.localEulerAngles.z = 0
				var_226_11.localEulerAngles.x = 0
				var_226_11.localEulerAngles = var_226_11.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_12 and arg_223_1.time_ < 0 + var_226_12 + arg_226_0 then
				var_226_11.localPosition = Vector3.New(0, 100, 0)
				var_226_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_11.position).x, (manager.ui.mainCamera.transform.position - var_226_11.position).y, (manager.ui.mainCamera.transform.position - var_226_11.position).z)
				var_226_11.localEulerAngles.z = 0
				var_226_11.localEulerAngles.x = 0
				var_226_11.localEulerAngles = var_226_11.localEulerAngles
			end

			local var_226_13 = arg_223_1.bgs_.ML0207.transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPosML0207 = var_226_13.localPosition
			end

			local var_226_14 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_14 then
				var_226_13.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosML0207, Vector3.New(0, 1, 9.5), (arg_223_1.time_ - 0) / var_226_14)
			end

			if arg_223_1.time_ >= 0 + var_226_14 and arg_223_1.time_ < 0 + var_226_14 + arg_226_0 then
				var_226_13.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_226_15 = arg_223_1.bgs_.ML0207.transform

			if 0.0166666666666667 < arg_223_1.time_ and arg_223_1.time_ <= 0.0166666666666667 + arg_226_0 then
				arg_223_1.var_.moveOldPosML0207 = var_226_15.localPosition
			end

			local var_226_16 = 3.5

			if 0.0166666666666667 <= arg_223_1.time_ and arg_223_1.time_ < 0.0166666666666667 + var_226_16 then
				var_226_15.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosML0207, Vector3.New(0, 1, 10), (arg_223_1.time_ - 0.0166666666666667) / var_226_16)
			end

			if arg_223_1.time_ >= 0.0166666666666667 + var_226_16 and arg_223_1.time_ < 0.0166666666666667 + var_226_16 + arg_226_0 then
				var_226_15.localPosition = Vector3.New(0, 1, 10)
			end

			local var_226_17 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_17 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_17 + 1.51666666666667 and arg_223_1.time_ < var_226_17 + 1.51666666666667 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_18 = 2
			local var_226_19 = 0.15

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_18 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_20 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_20:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_21 = arg_223_1:GetWordFromCfg(319931052)
				local var_226_22 = arg_223_1:FormatText(var_226_21.content)

				arg_223_1.text_.text = var_226_22

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_24 = 6 <= 0 and var_226_19 or var_226_19 * (utf8.len(var_226_22) / 6)

				if (6 <= 0 and var_226_19 or var_226_19 * (utf8.len(var_226_22) / 6)) > 0 and var_226_19 < var_226_24 then
					arg_223_1.talkMaxDuration = var_226_24
					var_226_18 = var_226_18 + 0.3

					if var_226_24 + var_226_18 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_24 + var_226_18
					end
				end

				arg_223_1.text_.text = var_226_22
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931052", "story_v_out_319931.awb") ~= 0 then
					local var_226_25 = manager.audio:GetVoiceLength("story_v_out_319931", "319931052", "story_v_out_319931.awb") / 1000

					if var_226_25 + var_226_18 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_25 + var_226_18
					end

					if var_226_21.prefab_name ~= "" and arg_223_1.actors_[var_226_21.prefab_name] ~= nil then
						local var_226_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_21.prefab_name].transform, "story_v_out_319931", "319931052", "story_v_out_319931.awb")

						arg_223_1:RecordAudio("319931052", var_226_26)
						arg_223_1:RecordAudio("319931052", var_226_26)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_319931", "319931052", "story_v_out_319931.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_319931", "319931052", "story_v_out_319931.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_27 = var_226_18 + 0.3
			local var_226_28 = math.max(var_226_19, arg_223_1.talkMaxDuration)

			if var_226_18 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_27 + var_226_28 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_27) / var_226_28

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_27 + var_226_28 and arg_223_1.time_ < var_226_27 + var_226_28 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0207",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0207",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play319931053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319931053
		arg_229_1.duration_ = 5.83

		local var_229_0 = {
			zh = 2.966,
			ja = 5.833
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play319931054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10075ui_story"]) and arg_229_1.var_.characterEffect10075ui_story == nil then
				arg_229_1.var_.characterEffect10075ui_story = arg_229_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10075ui_story"]) then
				if arg_229_1.var_.characterEffect10075ui_story and not isNil(arg_229_1.actors_["10075ui_story"]) then
					arg_229_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10075ui_story"]) and arg_229_1.var_.characterEffect10075ui_story then
				arg_229_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.275

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(319931053)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 11 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_4) / 11)

				if (11 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_4) / 11)) > 0 and var_232_2 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931053", "story_v_out_319931.awb") ~= 0 then
					local var_232_7 = manager.audio:GetVoiceLength("story_v_out_319931", "319931053", "story_v_out_319931.awb") / 1000

					if var_232_7 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_1
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_319931", "319931053", "story_v_out_319931.awb")

						arg_229_1:RecordAudio("319931053", var_232_8)
						arg_229_1:RecordAudio("319931053", var_232_8)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319931", "319931053", "story_v_out_319931.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319931", "319931053", "story_v_out_319931.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_9 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_9 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_9

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_9 and arg_229_1.time_ < var_232_1 + var_232_9 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319931054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319931054
		arg_233_1.duration_ = 2.43

		local var_233_0 = {
			zh = 2.366,
			ja = 2.433
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play319931055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.175

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:GetWordFromCfg(319931054)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 7 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 7)

				if (7 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 7)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931054", "story_v_out_319931.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931054", "story_v_out_319931.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_319931", "319931054", "story_v_out_319931.awb")

						arg_233_1:RecordAudio("319931054", var_236_6)
						arg_233_1:RecordAudio("319931054", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_319931", "319931054", "story_v_out_319931.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_319931", "319931054", "story_v_out_319931.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play319931055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319931055
		arg_237_1.duration_ = 2.7

		local var_237_0 = {
			zh = 2.7,
			ja = 2.6
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319931056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.325

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(319931055)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 13 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 13)

				if (13 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 13)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931055", "story_v_out_319931.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931055", "story_v_out_319931.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_319931", "319931055", "story_v_out_319931.awb")

						arg_237_1:RecordAudio("319931055", var_240_6)
						arg_237_1:RecordAudio("319931055", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_319931", "319931055", "story_v_out_319931.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_319931", "319931055", "story_v_out_319931.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319931056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319931056
		arg_241_1.duration_ = 9.47

		local var_241_0 = {
			zh = 6.833,
			ja = 9.466
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play319931057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.675

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(319931056)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 27 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 27)

				if (27 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 27)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931056", "story_v_out_319931.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931056", "story_v_out_319931.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_319931", "319931056", "story_v_out_319931.awb")

						arg_241_1:RecordAudio("319931056", var_244_6)
						arg_241_1:RecordAudio("319931056", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_319931", "319931056", "story_v_out_319931.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_319931", "319931056", "story_v_out_319931.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319931057 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319931057
		arg_245_1.duration_ = 5.43

		local var_245_0 = {
			zh = 5.433,
			ja = 3.666
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319931058(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.525

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(319931057)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 21 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 21)

				if (21 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 21)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931057", "story_v_out_319931.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931057", "story_v_out_319931.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_319931", "319931057", "story_v_out_319931.awb")

						arg_245_1:RecordAudio("319931057", var_248_6)
						arg_245_1:RecordAudio("319931057", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319931", "319931057", "story_v_out_319931.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319931", "319931057", "story_v_out_319931.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play319931058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319931058
		arg_249_1.duration_ = 10

		local var_249_0 = {
			zh = 8.166,
			ja = 10
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319931059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.825

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(319931058)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 33 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 33)

				if (33 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 33)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931058", "story_v_out_319931.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931058", "story_v_out_319931.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_319931", "319931058", "story_v_out_319931.awb")

						arg_249_1:RecordAudio("319931058", var_252_6)
						arg_249_1:RecordAudio("319931058", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319931", "319931058", "story_v_out_319931.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319931", "319931058", "story_v_out_319931.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play319931059 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319931059
		arg_253_1.duration_ = 2

		local var_253_0 = {
			zh = 1.833,
			ja = 2
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
				arg_253_0:Play319931060(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.125

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(319931059)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 5 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 5)

				if (5 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 5)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931059", "story_v_out_319931.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931059", "story_v_out_319931.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_319931", "319931059", "story_v_out_319931.awb")

						arg_253_1:RecordAudio("319931059", var_256_6)
						arg_253_1:RecordAudio("319931059", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_319931", "319931059", "story_v_out_319931.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_319931", "319931059", "story_v_out_319931.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319931060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319931060
		arg_257_1.duration_ = 2.5

		local var_257_0 = {
			zh = 1.466,
			ja = 2.5
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
				arg_257_0:Play319931061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.1

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(319931060)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 4 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 4)

				if (4 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 4)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931060", "story_v_out_319931.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931060", "story_v_out_319931.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_319931", "319931060", "story_v_out_319931.awb")

						arg_257_1:RecordAudio("319931060", var_260_6)
						arg_257_1:RecordAudio("319931060", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_319931", "319931060", "story_v_out_319931.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_319931", "319931060", "story_v_out_319931.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319931061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319931061
		arg_261_1.duration_ = 4.4

		local var_261_0 = {
			zh = 4.4,
			ja = 4.1
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play319931062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.45

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(319931061)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 18 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 18)

				if (18 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 18)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931061", "story_v_out_319931.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931061", "story_v_out_319931.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_319931", "319931061", "story_v_out_319931.awb")

						arg_261_1:RecordAudio("319931061", var_264_6)
						arg_261_1:RecordAudio("319931061", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319931", "319931061", "story_v_out_319931.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319931", "319931061", "story_v_out_319931.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play319931062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319931062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play319931063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.5

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(319931062).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 20 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 20)

				if (20 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 20)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play319931063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319931063
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play319931064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				local var_272_0 = arg_269_1.bgs_.STblack

				arg_269_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_272_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_1 = var_272_0:GetComponent("SpriteRenderer")

				if var_272_1 and var_272_1.sprite then
					local var_272_2 = 2 * (var_272_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_272_0.transform.localScale = Vector3.New(var_272_2 / var_272_1.sprite.bounds.size.y < var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x and var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x or var_272_2 / var_272_1.sprite.bounds.size.y, var_272_2 / var_272_1.sprite.bounds.size.y < var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x and var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x or var_272_2 / var_272_1.sprite.bounds.size.y, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "STblack" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				local var_272_3 = arg_269_1.fswbg_.transform:Find("textbox/adapt/content") or arg_269_1.fswbg_.transform:Find("textbox/content")
				local var_272_4 = arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_272_5 = var_272_3:GetComponent("RectTransform")

				var_272_3:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_272_5.offsetMin = Vector2.New(0, 0)
				var_272_5.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.fswbg_:SetActive(true)
				arg_269_1.dialog_:SetActive(false)

				arg_269_1.fswtw_.percent = 0
				arg_269_1.fswt_.text = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(319931063).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.fswt_)

				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_269_1.fswtw_:SetDirty()

				arg_269_1.typewritterCharCountI18N = 0

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_6 = 0.149999999998999

			if 0.149999999998999 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_7 = 0
			local var_272_8 = 0
			local var_272_9, var_272_10 = arg_269_1:GetPercentByPara(arg_269_1:FormatText(arg_269_1:GetWordFromCfg(319931063).content), 1)

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_11 = var_272_7 <= 0 and var_272_8 or var_272_8 * ((var_272_10 - arg_269_1.typewritterCharCountI18N) / var_272_7)

				if (var_272_7 <= 0 and var_272_8 or var_272_8 * ((var_272_10 - arg_269_1.typewritterCharCountI18N) / var_272_7)) > 0 and var_272_8 < var_272_11 then
					arg_269_1.talkMaxDuration = var_272_11

					if var_272_11 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_6
					end
				end
			end

			local var_272_12 = math.max(0, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_12 then
				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_9, (arg_269_1.time_ - var_272_6) / var_272_12)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_12 and arg_269_1.time_ < var_272_6 + var_272_12 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_9

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_10
			end

			local var_272_13 = 0.15

			if 0.15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_14 = 36
			local var_272_15 = 2.4
			local var_272_16, var_272_17 = arg_269_1:GetPercentByPara(arg_269_1:FormatText(arg_269_1:GetWordFromCfg(319931063).content), 1)

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_18 = var_272_14 <= 0 and var_272_15 or var_272_15 * ((var_272_17 - arg_269_1.typewritterCharCountI18N) / var_272_14)

				if (var_272_14 <= 0 and var_272_15 or var_272_15 * ((var_272_17 - arg_269_1.typewritterCharCountI18N) / var_272_14)) > 0 and var_272_15 < var_272_18 then
					arg_269_1.talkMaxDuration = var_272_18

					if var_272_18 + var_272_13 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_18 + var_272_13
					end
				end
			end

			local var_272_19 = math.max(2.4, arg_269_1.talkMaxDuration)

			if var_272_13 <= arg_269_1.time_ and arg_269_1.time_ < var_272_13 + var_272_19 then
				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_16, (arg_269_1.time_ - var_272_13) / var_272_19)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_13 + var_272_19 and arg_269_1.time_ < var_272_13 + var_272_19 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_16

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_17
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.cswbg_:SetActive(true)

				local var_272_20 = arg_269_1.cswt_:GetComponent("RectTransform")

				arg_269_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_272_20.offsetMin = Vector2.New(410, 330)
				var_272_20.offsetMax = Vector2.New(-400, -180)
				arg_269_1.cswt_.text = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(419081).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.cswt_)

				arg_269_1.cswt_.fontSize = 175
				arg_269_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_269_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319931064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319931064
		arg_273_1.duration_ = 7

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319931065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if arg_273_1.bgs_.D999 == nil then
				local var_276_0 = Object.Instantiate(arg_273_1.paintGo_)

				var_276_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D999")
				var_276_0.name = "D999"
				var_276_0.transform.parent = arg_273_1.stage_.transform
				var_276_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.bgs_.D999 = var_276_0
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				local var_276_1 = arg_273_1.bgs_.D999

				arg_273_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_276_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_2 = var_276_1:GetComponent("SpriteRenderer")

				if var_276_2 and var_276_2.sprite then
					local var_276_3 = 2 * (var_276_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_276_1.transform.localScale = Vector3.New(var_276_3 / var_276_2.sprite.bounds.size.y < var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x and var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x or var_276_3 / var_276_2.sprite.bounds.size.y, var_276_3 / var_276_2.sprite.bounds.size.y < var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x and var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x or var_276_3 / var_276_2.sprite.bounds.size.y, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "D999" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_4 = 0

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_5 = 2

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_5 then
				local var_276_6 = Color.New(1, 1, 1)

				var_276_6.a = Mathf.Lerp(1, 0, (arg_273_1.time_ - var_276_4) / var_276_5)
				arg_273_1.mask_.color = var_276_6
			end

			if arg_273_1.time_ >= var_276_4 + var_276_5 and arg_273_1.time_ < var_276_4 + var_276_5 + arg_276_0 then
				local var_276_7 = Color.New(1, 1, 1)

				arg_273_1.mask_.enabled = false
				var_276_7.a = 0
				arg_273_1.mask_.color = var_276_7
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.fswbg_:SetActive(true)
				arg_273_1.dialog_:SetActive(false)

				arg_273_1.fswtw_.percent = 0
				arg_273_1.fswt_.text = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(319931020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.fswt_)

				arg_273_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_273_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_273_1.fswtw_:SetDirty()

				arg_273_1.typewritterCharCountI18N = 0

				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_8 = 0.149999999998999

			if 0.149999999998999 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.var_.oldValueTypewriter = arg_273_1.fswtw_.percent

				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_9 = 0
			local var_276_10 = 0
			local var_276_11, var_276_12 = arg_273_1:GetPercentByPara(arg_273_1:FormatText(arg_273_1:GetWordFromCfg(319931020).content), 1)

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				local var_276_13 = var_276_9 <= 0 and var_276_10 or var_276_10 * ((var_276_12 - arg_273_1.typewritterCharCountI18N) / var_276_9)

				if (var_276_9 <= 0 and var_276_10 or var_276_10 * ((var_276_12 - arg_273_1.typewritterCharCountI18N) / var_276_9)) > 0 and var_276_10 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_8
					end
				end
			end

			local var_276_14 = math.max(0, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_14 then
				arg_273_1.fswtw_.percent = Mathf.Lerp(arg_273_1.var_.oldValueTypewriter, var_276_11, (arg_273_1.time_ - var_276_8) / var_276_14)
				arg_273_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_273_1.fswtw_:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_14 and arg_273_1.time_ < var_276_8 + var_276_14 + arg_276_0 then
				arg_273_1.fswtw_.percent = var_276_11

				arg_273_1.fswtw_:SetDirty()
				arg_273_1:ShowNextGo(true)

				arg_273_1.typewritterCharCountI18N = var_276_12
			end

			if 0.15 < arg_273_1.time_ and arg_273_1.time_ <= 0.15 + arg_276_0 then
				arg_273_1.fswbg_:SetActive(false)
				arg_273_1.dialog_:SetActive(false)
				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.cswbg_:SetActive(false)
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_15 = 1.999999999999
			local var_276_16 = 0.5

			if 1.999999999999 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_17 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_17:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_18 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(319931064).content)

				arg_273_1.text_.text = var_276_18

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_20 = 20 <= 0 and var_276_16 or var_276_16 * (utf8.len(var_276_18) / 20)

				if (20 <= 0 and var_276_16 or var_276_16 * (utf8.len(var_276_18) / 20)) > 0 and var_276_16 < var_276_20 then
					arg_273_1.talkMaxDuration = var_276_20
					var_276_15 = var_276_15 + 0.3

					if var_276_20 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_20 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_18
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_21 = var_276_15 + 0.3
			local var_276_22 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 + 0.3 <= arg_273_1.time_ and arg_273_1.time_ < var_276_21 + var_276_22 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_21) / var_276_22

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_21 + var_276_22 and arg_273_1.time_ < var_276_21 + var_276_22 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play319931065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319931065
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319931066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.75

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(319931065).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 30 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 30)

				if (30 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 30)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play319931066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319931066
		arg_283_1.duration_ = 3.57

		local var_283_0 = {
			zh = 3.566,
			ja = 2.9
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play319931067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10075ui_story = arg_283_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10075ui_story"].transform.position).z)
				arg_283_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10075ui_story"].transform.localEulerAngles = arg_283_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(0, -0.715, -6.15)
				arg_283_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10075ui_story"].transform.position).z)
				arg_283_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10075ui_story"].transform.localEulerAngles = arg_283_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["10075ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10075ui_story == nil then
				arg_283_1.var_.characterEffect10075ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect10075ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10075ui_story then
				arg_283_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_286_4 = 0
			local var_286_5 = 0.275

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(319931066)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 11 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 11)

				if (11 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 11)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931066", "story_v_out_319931.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931066", "story_v_out_319931.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_319931", "319931066", "story_v_out_319931.awb")

						arg_283_1:RecordAudio("319931066", var_286_11)
						arg_283_1:RecordAudio("319931066", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_319931", "319931066", "story_v_out_319931.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_319931", "319931066", "story_v_out_319931.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319931067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319931067
		arg_287_1.duration_ = 5.6

		local var_287_0 = {
			zh = 1.999999999999,
			ja = 5.6
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
				arg_287_0:Play319931068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10079ui_story = arg_287_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).z)
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles = arg_287_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_287_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).z)
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles = arg_287_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["10079ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10079ui_story == nil then
				arg_287_1.var_.characterEffect10079ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect10079ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10079ui_story then
				arg_287_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_290_4 = arg_287_1.actors_["10075ui_story"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10075ui_story = var_290_4.localPosition
			end

			local var_290_5 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 then
				var_290_4.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_287_1.time_ - 0) / var_290_5)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 then
				var_290_4.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			local var_290_6 = arg_287_1.actors_["10075ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect10075ui_story == nil then
				arg_287_1.var_.characterEffect10075ui_story = var_290_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 and not isNil(var_290_6) then
				if arg_287_1.var_.characterEffect10075ui_story and not isNil(var_290_6) then
					arg_287_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_7)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect10075ui_story then
				arg_287_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_290_8 = 0
			local var_290_9 = 0.2

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_10 = arg_287_1:GetWordFromCfg(319931067)
				local var_290_11 = arg_287_1:FormatText(var_290_10.content)

				arg_287_1.text_.text = var_290_11

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_13 = 8 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 8)

				if (8 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 8)) > 0 and var_290_9 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_8
					end
				end

				arg_287_1.text_.text = var_290_11
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931067", "story_v_out_319931.awb") ~= 0 then
					local var_290_14 = manager.audio:GetVoiceLength("story_v_out_319931", "319931067", "story_v_out_319931.awb") / 1000

					if var_290_14 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_8
					end

					if var_290_10.prefab_name ~= "" and arg_287_1.actors_[var_290_10.prefab_name] ~= nil then
						local var_290_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_10.prefab_name].transform, "story_v_out_319931", "319931067", "story_v_out_319931.awb")

						arg_287_1:RecordAudio("319931067", var_290_15)
						arg_287_1:RecordAudio("319931067", var_290_15)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319931", "319931067", "story_v_out_319931.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319931", "319931067", "story_v_out_319931.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_16 = math.max(var_290_9, arg_287_1.talkMaxDuration)

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_8) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_8 + var_290_16 and arg_287_1.time_ < var_290_8 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319931068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319931068
		arg_291_1.duration_ = 8.53

		local var_291_0 = {
			zh = 8,
			ja = 8.533
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
				arg_291_0:Play319931069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10079ui_story"]) and arg_291_1.var_.characterEffect10079ui_story == nil then
				arg_291_1.var_.characterEffect10079ui_story = arg_291_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10079ui_story"]) then
				if arg_291_1.var_.characterEffect10079ui_story and not isNil(arg_291_1.actors_["10079ui_story"]) then
					arg_291_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10079ui_story"]) and arg_291_1.var_.characterEffect10079ui_story then
				arg_291_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_294_1 = arg_291_1.actors_["10075ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10075ui_story == nil then
				arg_291_1.var_.characterEffect10075ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect10075ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10075ui_story then
				arg_291_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_294_4 = 0
			local var_294_5 = 0.8

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:GetWordFromCfg(319931068)
				local var_294_7 = arg_291_1:FormatText(var_294_6.content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 32 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 32)

				if (32 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 32)) > 0 and var_294_5 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931068", "story_v_out_319931.awb") ~= 0 then
					local var_294_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931068", "story_v_out_319931.awb") / 1000

					if var_294_10 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_4
					end

					if var_294_6.prefab_name ~= "" and arg_291_1.actors_[var_294_6.prefab_name] ~= nil then
						local var_294_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_6.prefab_name].transform, "story_v_out_319931", "319931068", "story_v_out_319931.awb")

						arg_291_1:RecordAudio("319931068", var_294_11)
						arg_291_1:RecordAudio("319931068", var_294_11)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319931", "319931068", "story_v_out_319931.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319931", "319931068", "story_v_out_319931.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_12 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_12 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_12

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_12 and arg_291_1.time_ < var_294_4 + var_294_12 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319931069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319931069
		arg_295_1.duration_ = 9.13

		local var_295_0 = {
			zh = 7.8,
			ja = 9.133
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
				arg_295_0:Play319931070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.725

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:GetWordFromCfg(319931069)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 29 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 29)

				if (29 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 29)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931069", "story_v_out_319931.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_319931", "319931069", "story_v_out_319931.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_319931", "319931069", "story_v_out_319931.awb")

						arg_295_1:RecordAudio("319931069", var_298_6)
						arg_295_1:RecordAudio("319931069", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_319931", "319931069", "story_v_out_319931.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_319931", "319931069", "story_v_out_319931.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play319931070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319931070
		arg_299_1.duration_ = 13.53

		local var_299_0 = {
			zh = 8.8,
			ja = 13.533
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
				arg_299_0:Play319931071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_9000

			if arg_299_1.bgs_.XH0204 == nil then
				local var_302_0 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0204")
				var_302_0.name = "XH0204"
				var_302_0.transform.parent = arg_299_1.stage_.transform
				var_302_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_.XH0204 = var_302_0
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				local var_302_1 = arg_299_1.bgs_.XH0204

				arg_299_1.bgs_.XH0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_2 = var_302_1:GetComponent("SpriteRenderer")

				if var_302_2 and var_302_2.sprite then
					local var_302_3 = 2 * (var_302_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_1.transform.localScale = Vector3.New(var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, var_302_3 / var_302_2.sprite.bounds.size.y < var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x and var_302_3 * manager.ui.mainCameraCom_.aspect / var_302_2.sprite.bounds.size.x or var_302_3 / var_302_2.sprite.bounds.size.y, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "XH0204" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_4 = 0

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.allBtn_.enabled = false
			end

			if arg_299_1.time_ >= var_302_4 + 0.3 and arg_299_1.time_ < var_302_4 + 0.3 + arg_302_0 then
				arg_299_1.allBtn_.enabled = true
			end

			local var_302_5 = arg_299_1.actors_["10075ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10075ui_story = var_302_5.localPosition
			end

			local var_302_6 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_6 then
				var_302_5.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_6)
				var_302_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_5.position).x, (manager.ui.mainCamera.transform.position - var_302_5.position).y, (manager.ui.mainCamera.transform.position - var_302_5.position).z)
				var_302_5.localEulerAngles.z = 0
				var_302_5.localEulerAngles.x = 0
				var_302_5.localEulerAngles = var_302_5.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_6 and arg_299_1.time_ < 0 + var_302_6 + arg_302_0 then
				var_302_5.localPosition = Vector3.New(0, 100, 0)
				var_302_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_5.position).x, (manager.ui.mainCamera.transform.position - var_302_5.position).y, (manager.ui.mainCamera.transform.position - var_302_5.position).z)
				var_302_5.localEulerAngles.z = 0
				var_302_5.localEulerAngles.x = 0
				var_302_5.localEulerAngles = var_302_5.localEulerAngles
			end

			local var_302_7 = arg_299_1.actors_["10079ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10079ui_story = var_302_7.localPosition
			end

			local var_302_8 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_8 then
				var_302_7.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_8)
				var_302_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_7.position).x, (manager.ui.mainCamera.transform.position - var_302_7.position).y, (manager.ui.mainCamera.transform.position - var_302_7.position).z)
				var_302_7.localEulerAngles.z = 0
				var_302_7.localEulerAngles.x = 0
				var_302_7.localEulerAngles = var_302_7.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_8 and arg_299_1.time_ < 0 + var_302_8 + arg_302_0 then
				var_302_7.localPosition = Vector3.New(0, 100, 0)
				var_302_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_7.position).x, (manager.ui.mainCamera.transform.position - var_302_7.position).y, (manager.ui.mainCamera.transform.position - var_302_7.position).z)
				var_302_7.localEulerAngles.z = 0
				var_302_7.localEulerAngles.x = 0
				var_302_7.localEulerAngles = var_302_7.localEulerAngles
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				local var_302_9 = arg_299_1.var_.effecthuiyisi1

				if not arg_299_1.var_.effecthuiyisi1 then
					var_302_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_302_9.name = "huiyisi1"
					arg_299_1.var_.effecthuiyisi1 = var_302_9
				else
					var_302_9.transform:SetParent(var_302_9000)
				end

				var_302_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_302_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_299_1.time_ and arg_299_1.time_ <= 2 + arg_302_0 then
				if arg_299_1.var_.effecthuiyisi1 then
					Object.Destroy(arg_299_1.var_.effecthuiyisi1)

					arg_299_1.var_.effecthuiyisi1 = nil
				end
			end

			local var_302_12 = 0

			arg_299_1.isInRecall_ = false

			if var_302_12 < arg_299_1.time_ and arg_299_1.time_ <= var_302_12 + arg_302_0 then
				arg_299_1.screenFilterGo_:SetActive(true)

				arg_299_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_302_2, iter_302_3 in pairs(arg_299_1.actors_) do
					for iter_302_4, iter_302_5 in ipairs((iter_302_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_302_5.color = iter_302_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_302_13 = 0.0166666666666667

			if var_302_12 <= arg_299_1.time_ and arg_299_1.time_ < var_302_12 + var_302_13 then
				arg_299_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_299_1.time_ - var_302_12) / var_302_13)
			end

			if arg_299_1.time_ >= var_302_12 + var_302_13 and arg_299_1.time_ < var_302_12 + var_302_13 + arg_302_0 then
				arg_299_1.screenFilterEffect_.weight = 1
			end

			local var_302_14 = 0
			local var_302_15 = 0.65

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_16 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_16:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_17 = arg_299_1:GetWordFromCfg(319931070)
				local var_302_18 = arg_299_1:FormatText(var_302_17.content)

				arg_299_1.text_.text = var_302_18

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 26 <= 0 and var_302_15 or var_302_15 * (utf8.len(var_302_18) / 26)

				if (26 <= 0 and var_302_15 or var_302_15 * (utf8.len(var_302_18) / 26)) > 0 and var_302_15 < var_302_20 then
					arg_299_1.talkMaxDuration = var_302_20
					var_302_14 = var_302_14 + 0.3

					if var_302_20 + var_302_14 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_14
					end
				end

				arg_299_1.text_.text = var_302_18
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931070", "story_v_out_319931.awb") ~= 0 then
					local var_302_21 = manager.audio:GetVoiceLength("story_v_out_319931", "319931070", "story_v_out_319931.awb") / 1000

					if var_302_21 + var_302_14 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_21 + var_302_14
					end

					if var_302_17.prefab_name ~= "" and arg_299_1.actors_[var_302_17.prefab_name] ~= nil then
						local var_302_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_17.prefab_name].transform, "story_v_out_319931", "319931070", "story_v_out_319931.awb")

						arg_299_1:RecordAudio("319931070", var_302_22)
						arg_299_1:RecordAudio("319931070", var_302_22)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_319931", "319931070", "story_v_out_319931.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_319931", "319931070", "story_v_out_319931.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_23 = var_302_14 + 0.3
			local var_302_24 = math.max(var_302_15, arg_299_1.talkMaxDuration)

			if var_302_14 + 0.3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_23 + var_302_24 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_23) / var_302_24

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_23 + var_302_24 and arg_299_1.time_ < var_302_23 + var_302_24 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play319931071 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 319931071
		arg_305_1.duration_ = 9.7

		local var_305_0 = {
			zh = 6.833,
			ja = 9.7
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
				arg_305_0:Play319931072(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_9000

			if arg_305_1.bgs_.XH0506 == nil then
				local var_308_0 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0506")
				var_308_0.name = "XH0506"
				var_308_0.transform.parent = arg_305_1.stage_.transform
				var_308_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_.XH0506 = var_308_0
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				local var_308_1 = arg_305_1.bgs_.XH0506

				arg_305_1.bgs_.XH0506.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_308_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_2 = var_308_1:GetComponent("SpriteRenderer")

				if var_308_2 and var_308_2.sprite then
					local var_308_3 = 2 * (var_308_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_308_1.transform.localScale = Vector3.New(var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "XH0506" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				local var_308_4 = arg_305_1.var_.effecthuiyisi1

				if not arg_305_1.var_.effecthuiyisi1 then
					var_308_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_308_4.name = "huiyisi1"
					arg_305_1.var_.effecthuiyisi1 = var_308_4
				else
					var_308_4.transform:SetParent(var_308_9000)
				end

				var_308_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				if arg_305_1.var_.effecthuiyisi1 then
					Object.Destroy(arg_305_1.var_.effecthuiyisi1)

					arg_305_1.var_.effecthuiyisi1 = nil
				end
			end

			local var_308_7 = 0
			local var_308_8 = 0.6

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_9 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_9:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_10 = arg_305_1:GetWordFromCfg(319931071)
				local var_308_11 = arg_305_1:FormatText(var_308_10.content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_13 = 24 <= 0 and var_308_8 or var_308_8 * (utf8.len(var_308_11) / 24)

				if (24 <= 0 and var_308_8 or var_308_8 * (utf8.len(var_308_11) / 24)) > 0 and var_308_8 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13
					var_308_7 = var_308_7 + 0.3

					if var_308_13 + var_308_7 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_7
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931071", "story_v_out_319931.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_319931", "319931071", "story_v_out_319931.awb") / 1000

					if var_308_14 + var_308_7 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_7
					end

					if var_308_10.prefab_name ~= "" and arg_305_1.actors_[var_308_10.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_10.prefab_name].transform, "story_v_out_319931", "319931071", "story_v_out_319931.awb")

						arg_305_1:RecordAudio("319931071", var_308_15)
						arg_305_1:RecordAudio("319931071", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_319931", "319931071", "story_v_out_319931.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_319931", "319931071", "story_v_out_319931.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = var_308_7 + 0.3
			local var_308_17 = math.max(var_308_8, arg_305_1.talkMaxDuration)

			if var_308_7 + 0.3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_17 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_16) / var_308_17

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play319931072 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319931072
		arg_311_1.duration_ = 5.3

		local var_311_0 = {
			zh = 3.5,
			ja = 5.3
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
				arg_311_0:Play319931073(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if arg_311_1.bgs_.ML0101 == nil then
				local var_314_0 = Object.Instantiate(arg_311_1.paintGo_)

				var_314_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0101")
				var_314_0.name = "ML0101"
				var_314_0.transform.parent = arg_311_1.stage_.transform
				var_314_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.bgs_.ML0101 = var_314_0
			end

			if 1 < arg_311_1.time_ and arg_311_1.time_ <= 1 + arg_314_0 then
				local var_314_1 = arg_311_1.bgs_.ML0101

				arg_311_1.bgs_.ML0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_314_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_2 = var_314_1:GetComponent("SpriteRenderer")

				if var_314_2 and var_314_2.sprite then
					local var_314_3 = 2 * (var_314_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_314_1.transform.localScale = Vector3.New(var_314_3 / var_314_2.sprite.bounds.size.y < var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x and var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x or var_314_3 / var_314_2.sprite.bounds.size.y, var_314_3 / var_314_2.sprite.bounds.size.y < var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x and var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x or var_314_3 / var_314_2.sprite.bounds.size.y, 0)
				end

				for iter_314_0, iter_314_1 in pairs(arg_311_1.bgs_) do
					if iter_314_0 ~= "ML0101" then
						iter_314_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_314_4 = 1.999999999999

			if 1.999999999999 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			if arg_311_1.time_ >= var_314_4 + 0.3 and arg_311_1.time_ < var_314_4 + 0.3 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			local var_314_5 = 0

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_6 = 1

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_6 then
				local var_314_7 = Color.New(0, 0, 0)

				var_314_7.a = Mathf.Lerp(0, 1, (arg_311_1.time_ - var_314_5) / var_314_6)
				arg_311_1.mask_.color = var_314_7
			end

			if arg_311_1.time_ >= var_314_5 + var_314_6 and arg_311_1.time_ < var_314_5 + var_314_6 + arg_314_0 then
				local var_314_8 = Color.New(0, 0, 0)

				var_314_8.a = 1
				arg_311_1.mask_.color = var_314_8
			end

			local var_314_9 = 1

			if 1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_10 = 1

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 then
				local var_314_11 = Color.New(0, 0, 0)

				var_314_11.a = Mathf.Lerp(1, 0, (arg_311_1.time_ - var_314_9) / var_314_10)
				arg_311_1.mask_.color = var_314_11
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 then
				local var_314_12 = Color.New(0, 0, 0)

				arg_311_1.mask_.enabled = false
				var_314_12.a = 0
				arg_311_1.mask_.color = var_314_12
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_13 = 2
			local var_314_14 = 0.125

			if 2 < arg_311_1.time_ and arg_311_1.time_ <= var_314_13 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_15 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_15:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_16 = arg_311_1:GetWordFromCfg(319931072)
				local var_314_17 = arg_311_1:FormatText(var_314_16.content)

				arg_311_1.text_.text = var_314_17

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_19 = 5 <= 0 and var_314_14 or var_314_14 * (utf8.len(var_314_17) / 5)

				if (5 <= 0 and var_314_14 or var_314_14 * (utf8.len(var_314_17) / 5)) > 0 and var_314_14 < var_314_19 then
					arg_311_1.talkMaxDuration = var_314_19
					var_314_13 = var_314_13 + 0.3

					if var_314_19 + var_314_13 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_19 + var_314_13
					end
				end

				arg_311_1.text_.text = var_314_17
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931072", "story_v_out_319931.awb") ~= 0 then
					local var_314_20 = manager.audio:GetVoiceLength("story_v_out_319931", "319931072", "story_v_out_319931.awb") / 1000

					if var_314_20 + var_314_13 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_20 + var_314_13
					end

					if var_314_16.prefab_name ~= "" and arg_311_1.actors_[var_314_16.prefab_name] ~= nil then
						local var_314_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_16.prefab_name].transform, "story_v_out_319931", "319931072", "story_v_out_319931.awb")

						arg_311_1:RecordAudio("319931072", var_314_21)
						arg_311_1:RecordAudio("319931072", var_314_21)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319931", "319931072", "story_v_out_319931.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319931", "319931072", "story_v_out_319931.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_22 = var_314_13 + 0.3
			local var_314_23 = math.max(var_314_14, arg_311_1.talkMaxDuration)

			if var_314_13 + 0.3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_22 + var_314_23 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_22) / var_314_23

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_22 + var_314_23 and arg_311_1.time_ < var_314_22 + var_314_23 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play319931073 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319931073
		arg_317_1.duration_ = 4.63

		local var_317_0 = {
			zh = 4.133333333332,
			ja = 4.633
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play319931074(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if arg_317_1.bgs_.I10f == nil then
				local var_320_0 = Object.Instantiate(arg_317_1.paintGo_)

				var_320_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I10f")
				var_320_0.name = "I10f"
				var_320_0.transform.parent = arg_317_1.stage_.transform
				var_320_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.bgs_.I10f = var_320_0
			end

			if 1 < arg_317_1.time_ and arg_317_1.time_ <= 1 + arg_320_0 then
				local var_320_1 = arg_317_1.bgs_.I10f

				arg_317_1.bgs_.I10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_320_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_320_2 = var_320_1:GetComponent("SpriteRenderer")

				if var_320_2 and var_320_2.sprite then
					local var_320_3 = 2 * (var_320_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_320_1.transform.localScale = Vector3.New(var_320_3 / var_320_2.sprite.bounds.size.y < var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x and var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x or var_320_3 / var_320_2.sprite.bounds.size.y, var_320_3 / var_320_2.sprite.bounds.size.y < var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x and var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x or var_320_3 / var_320_2.sprite.bounds.size.y, 0)
				end

				for iter_320_0, iter_320_1 in pairs(arg_317_1.bgs_) do
					if iter_320_0 ~= "I10f" then
						iter_320_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_320_4 = 1.96599999815226

			if 1.96599999815226 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.allBtn_.enabled = false
			end

			if arg_317_1.time_ >= var_320_4 + 0.3 and arg_317_1.time_ < var_320_4 + 0.3 + arg_320_0 then
				arg_317_1.allBtn_.enabled = true
			end

			local var_320_5 = arg_317_1.actors_["10079ui_story"].transform

			if 1.96599999815226 < arg_317_1.time_ and arg_317_1.time_ <= 1.96599999815226 + arg_320_0 then
				arg_317_1.var_.moveOldPos10079ui_story = var_320_5.localPosition
			end

			local var_320_6 = 0.001

			if 1.96599999815226 <= arg_317_1.time_ and arg_317_1.time_ < 1.96599999815226 + var_320_6 then
				var_320_5.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_317_1.time_ - 1.96599999815226) / var_320_6)
				var_320_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_5.position).x, (manager.ui.mainCamera.transform.position - var_320_5.position).y, (manager.ui.mainCamera.transform.position - var_320_5.position).z)
				var_320_5.localEulerAngles.z = 0
				var_320_5.localEulerAngles.x = 0
				var_320_5.localEulerAngles = var_320_5.localEulerAngles
			end

			if arg_317_1.time_ >= 1.96599999815226 + var_320_6 and arg_317_1.time_ < 1.96599999815226 + var_320_6 + arg_320_0 then
				var_320_5.localPosition = Vector3.New(0, -0.95, -6.05)
				var_320_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_5.position).x, (manager.ui.mainCamera.transform.position - var_320_5.position).y, (manager.ui.mainCamera.transform.position - var_320_5.position).z)
				var_320_5.localEulerAngles.z = 0
				var_320_5.localEulerAngles.x = 0
				var_320_5.localEulerAngles = var_320_5.localEulerAngles
			end

			local var_320_7 = arg_317_1.actors_["10079ui_story"]

			if 1.96599999815226 < arg_317_1.time_ and arg_317_1.time_ <= 1.96599999815226 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.characterEffect10079ui_story == nil then
				arg_317_1.var_.characterEffect10079ui_story = var_320_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_8 = 0.034000001847744

			if 1.96599999815226 <= arg_317_1.time_ and arg_317_1.time_ < 1.96599999815226 + var_320_8 and not isNil(var_320_7) then
				if arg_317_1.var_.characterEffect10079ui_story and not isNil(var_320_7) then
					arg_317_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 1.96599999815226 + var_320_8 and arg_317_1.time_ < 1.96599999815226 + var_320_8 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.characterEffect10079ui_story then
				arg_317_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 1.96599999815226 < arg_317_1.time_ and arg_317_1.time_ <= 1.96599999815226 + arg_320_0 then
				arg_317_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 1.96599999815226 < arg_317_1.time_ and arg_317_1.time_ <= 1.96599999815226 + arg_320_0 then
				arg_317_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_10 = 0

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_11 = 1

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 then
				local var_320_12 = Color.New(0, 0, 0)

				var_320_12.a = Mathf.Lerp(0, 1, (arg_317_1.time_ - var_320_10) / var_320_11)
				arg_317_1.mask_.color = var_320_12
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 then
				local var_320_13 = Color.New(0, 0, 0)

				var_320_13.a = 1
				arg_317_1.mask_.color = var_320_13
			end

			local var_320_14 = 1

			if 1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_14 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_15 = 1

			if var_320_14 <= arg_317_1.time_ and arg_317_1.time_ < var_320_14 + var_320_15 then
				local var_320_16 = Color.New(0, 0, 0)

				var_320_16.a = Mathf.Lerp(1, 0, (arg_317_1.time_ - var_320_14) / var_320_15)
				arg_317_1.mask_.color = var_320_16
			end

			if arg_317_1.time_ >= var_320_14 + var_320_15 and arg_317_1.time_ < var_320_14 + var_320_15 + arg_320_0 then
				local var_320_17 = Color.New(0, 0, 0)

				arg_317_1.mask_.enabled = false
				var_320_17.a = 0
				arg_317_1.mask_.color = var_320_17
			end

			if arg_317_1.frameCnt_ <= 1 then
				arg_317_1.dialog_:SetActive(false)
			end

			local var_320_18 = 2
			local var_320_19 = 0.15

			if 2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_18 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				arg_317_1.dialog_:SetActive(true)

				arg_317_1.dialogCg_.alpha = 0

				local var_320_20 = LeanTween.value(arg_317_1.dialog_, 0, 1, 0.3)

				var_320_20:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_317_1.dialogCg_.alpha = arg_321_0
				end))
				var_320_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_317_1.dialog_)
					var_320_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_317_1.duration_ = arg_317_1.duration_ + 0.3

				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_21 = arg_317_1:GetWordFromCfg(319931073)
				local var_320_22 = arg_317_1:FormatText(var_320_21.content)

				arg_317_1.text_.text = var_320_22

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_24 = 6 <= 0 and var_320_19 or var_320_19 * (utf8.len(var_320_22) / 6)

				if (6 <= 0 and var_320_19 or var_320_19 * (utf8.len(var_320_22) / 6)) > 0 and var_320_19 < var_320_24 then
					arg_317_1.talkMaxDuration = var_320_24
					var_320_18 = var_320_18 + 0.3

					if var_320_24 + var_320_18 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_24 + var_320_18
					end
				end

				arg_317_1.text_.text = var_320_22
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931073", "story_v_out_319931.awb") ~= 0 then
					local var_320_25 = manager.audio:GetVoiceLength("story_v_out_319931", "319931073", "story_v_out_319931.awb") / 1000

					if var_320_25 + var_320_18 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_25 + var_320_18
					end

					if var_320_21.prefab_name ~= "" and arg_317_1.actors_[var_320_21.prefab_name] ~= nil then
						local var_320_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_21.prefab_name].transform, "story_v_out_319931", "319931073", "story_v_out_319931.awb")

						arg_317_1:RecordAudio("319931073", var_320_26)
						arg_317_1:RecordAudio("319931073", var_320_26)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_319931", "319931073", "story_v_out_319931.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_319931", "319931073", "story_v_out_319931.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_27 = var_320_18 + 0.3
			local var_320_28 = math.max(var_320_19, arg_317_1.talkMaxDuration)

			if var_320_18 + 0.3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_27 + var_320_28 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_27) / var_320_28

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_27 + var_320_28 and arg_317_1.time_ < var_320_27 + var_320_28 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play319931074 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 319931074
		arg_323_1.duration_ = 6.07

		local var_323_0 = {
			zh = 5.333,
			ja = 6.066
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
				arg_323_0:Play319931075(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				local var_326_0 = arg_323_1.bgs_.D999

				arg_323_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_326_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_326_1 = var_326_0:GetComponent("SpriteRenderer")

				if var_326_1 and var_326_1.sprite then
					local var_326_2 = 2 * (var_326_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_326_0.transform.localScale = Vector3.New(var_326_2 / var_326_1.sprite.bounds.size.y < var_326_2 * manager.ui.mainCameraCom_.aspect / var_326_1.sprite.bounds.size.x and var_326_2 * manager.ui.mainCameraCom_.aspect / var_326_1.sprite.bounds.size.x or var_326_2 / var_326_1.sprite.bounds.size.y, var_326_2 / var_326_1.sprite.bounds.size.y < var_326_2 * manager.ui.mainCameraCom_.aspect / var_326_1.sprite.bounds.size.x and var_326_2 * manager.ui.mainCameraCom_.aspect / var_326_1.sprite.bounds.size.x or var_326_2 / var_326_1.sprite.bounds.size.y, 0)
				end

				for iter_326_0, iter_326_1 in pairs(arg_323_1.bgs_) do
					if iter_326_0 ~= "D999" then
						iter_326_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_326_3 = 0

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_3 + arg_326_0 then
				arg_323_1.allBtn_.enabled = false
			end

			if arg_323_1.time_ >= var_326_3 + 0.3 and arg_323_1.time_ < var_326_3 + 0.3 + arg_326_0 then
				arg_323_1.allBtn_.enabled = true
			end

			local var_326_4 = 0

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_5 = 2

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_5 then
				local var_326_6 = Color.New(1, 1, 1)

				var_326_6.a = Mathf.Lerp(1, 0, (arg_323_1.time_ - var_326_4) / var_326_5)
				arg_323_1.mask_.color = var_326_6
			end

			if arg_323_1.time_ >= var_326_4 + var_326_5 and arg_323_1.time_ < var_326_4 + var_326_5 + arg_326_0 then
				local var_326_7 = Color.New(1, 1, 1)

				arg_323_1.mask_.enabled = false
				var_326_7.a = 0
				arg_323_1.mask_.color = var_326_7
			end

			local var_326_8 = arg_323_1.actors_["10079ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.characterEffect10079ui_story == nil then
				arg_323_1.var_.characterEffect10079ui_story = var_326_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_9 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_9 and not isNil(var_326_8) then
				if arg_323_1.var_.characterEffect10079ui_story and not isNil(var_326_8) then
					arg_323_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_9)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_9 and arg_323_1.time_ < 0 + var_326_9 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.characterEffect10079ui_story then
				arg_323_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_326_10 = arg_323_1.actors_["10079ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10079ui_story = var_326_10.localPosition
			end

			local var_326_11 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_11 then
				var_326_10.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_11)
				var_326_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_10.position).x, (manager.ui.mainCamera.transform.position - var_326_10.position).y, (manager.ui.mainCamera.transform.position - var_326_10.position).z)
				var_326_10.localEulerAngles.z = 0
				var_326_10.localEulerAngles.x = 0
				var_326_10.localEulerAngles = var_326_10.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_11 and arg_323_1.time_ < 0 + var_326_11 + arg_326_0 then
				var_326_10.localPosition = Vector3.New(0, 100, 0)
				var_326_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_10.position).x, (manager.ui.mainCamera.transform.position - var_326_10.position).y, (manager.ui.mainCamera.transform.position - var_326_10.position).z)
				var_326_10.localEulerAngles.z = 0
				var_326_10.localEulerAngles.x = 0
				var_326_10.localEulerAngles = var_326_10.localEulerAngles
			end

			local var_326_12 = 0

			arg_323_1.isInRecall_ = false

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.screenFilterGo_:SetActive(false)

				for iter_326_2, iter_326_3 in pairs(arg_323_1.actors_) do
					for iter_326_4, iter_326_5 in ipairs((iter_326_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_326_5.color = iter_326_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_326_13 = 0.0333333333333333

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_13 then
				arg_323_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_323_1.time_ - var_326_12) / var_326_13)
			end

			if arg_323_1.time_ >= var_326_12 + var_326_13 and arg_323_1.time_ < var_326_12 + var_326_13 + arg_326_0 then
				arg_323_1.screenFilterEffect_.weight = 0
			end

			if arg_323_1.frameCnt_ <= 1 then
				arg_323_1.dialog_:SetActive(false)
			end

			local var_326_14 = 2
			local var_326_15 = 0.35

			if 2 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0

				arg_323_1.dialog_:SetActive(true)

				arg_323_1.dialogCg_.alpha = 0

				local var_326_16 = LeanTween.value(arg_323_1.dialog_, 0, 1, 0.3)

				var_326_16:setOnUpdate(LuaHelper.FloatAction(function(arg_327_0)
					arg_323_1.dialogCg_.alpha = arg_327_0
				end))
				var_326_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_323_1.dialog_)
					var_326_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_323_1.duration_ = arg_323_1.duration_ + 0.3

				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_17 = arg_323_1:GetWordFromCfg(319931074)
				local var_326_18 = arg_323_1:FormatText(var_326_17.content)

				arg_323_1.text_.text = var_326_18

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 14 <= 0 and var_326_15 or var_326_15 * (utf8.len(var_326_18) / 14)

				if (14 <= 0 and var_326_15 or var_326_15 * (utf8.len(var_326_18) / 14)) > 0 and var_326_15 < var_326_20 then
					arg_323_1.talkMaxDuration = var_326_20
					var_326_14 = var_326_14 + 0.3

					if var_326_20 + var_326_14 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_20 + var_326_14
					end
				end

				arg_323_1.text_.text = var_326_18
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931074", "story_v_out_319931.awb") ~= 0 then
					local var_326_21 = manager.audio:GetVoiceLength("story_v_out_319931", "319931074", "story_v_out_319931.awb") / 1000

					if var_326_21 + var_326_14 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_21 + var_326_14
					end

					if var_326_17.prefab_name ~= "" and arg_323_1.actors_[var_326_17.prefab_name] ~= nil then
						local var_326_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_17.prefab_name].transform, "story_v_out_319931", "319931074", "story_v_out_319931.awb")

						arg_323_1:RecordAudio("319931074", var_326_22)
						arg_323_1:RecordAudio("319931074", var_326_22)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_319931", "319931074", "story_v_out_319931.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_319931", "319931074", "story_v_out_319931.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_23 = var_326_14 + 0.3
			local var_326_24 = math.max(var_326_15, arg_323_1.talkMaxDuration)

			if var_326_14 + 0.3 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_24 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_23) / var_326_24

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_23 + var_326_24 and arg_323_1.time_ < var_326_23 + var_326_24 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play319931075 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 319931075
		arg_329_1.duration_ = 5.53

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
			arg_329_1.auto_ = false
		end

		function arg_329_1.playNext_(arg_331_0)
			arg_329_1.onStoryFinished_()
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_332_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_329_1.bgmTxt_.text ~= var_332_2 and arg_329_1.bgmTxt_.text ~= "" then
						if arg_329_1.bgmTxt2_.text ~= "" then
							arg_329_1.bgmTxt_.text = arg_329_1.bgmTxt2_.text
						end

						arg_329_1.bgmTxt2_.text = var_332_2

						arg_329_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_329_1.bgmTxt_.text = var_332_2
						arg_329_1.bgmTxt2_.text = var_332_2
					end

					if arg_329_1.bgmTimer then
						arg_329_1.bgmTimer:Stop()

						arg_329_1.bgmTimer = nil
					end

					if arg_329_1.settingData.show_music_name == 1 then
						arg_329_1.musicController:SetSelectedState("show")
						arg_329_1.musicAnimator_:Play("open", 0, 0)

						if arg_329_1.settingData.music_time ~= 0 then
							arg_329_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_329_1.settingData.music_time), function()
								if arg_329_1 == nil or isNil(arg_329_1.bgmTxt_) then
									return
								end

								arg_329_1.musicController:SetSelectedState("hide")
								arg_329_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_3 = 0.533333333333333
			local var_332_4 = 0.7

			if 0.533333333333333 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_5 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_5:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_329_1.dialogCg_.alpha = arg_334_0
				end))
				var_332_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(319931075).content)

				arg_329_1.text_.text = var_332_6

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_8 = 28 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_6) / 28)

				if (28 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_6) / 28)) > 0 and var_332_4 < var_332_8 then
					arg_329_1.talkMaxDuration = var_332_8
					var_332_3 = var_332_3 + 0.3

					if var_332_8 + var_332_3 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_3
					end
				end

				arg_329_1.text_.text = var_332_6
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_9 = var_332_3 + 0.3
			local var_332_10 = math.max(var_332_4, arg_329_1.talkMaxDuration)

			if var_332_3 + 0.3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_9) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/ML0207",
		"TextureConfig/Background/D999",
		"TextureConfig/Background/XH0204",
		"TextureConfig/Background/XH0506",
		"TextureConfig/Background/ML0101",
		"TextureConfig/Background/I10f"
	},
	voices = {
		"story_v_out_319931.awb"
	}
}
