return {
	Play123011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123011002(arg_1_1)
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

			local var_4_11 = 1.999999999999
			local var_4_12 = 1.525

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
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

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123011001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 61 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 61)

				if (61 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 61)) > 0 and var_4_12 < var_4_16 then
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
	Play123011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 123011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play123011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.05

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(123011002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 42 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 42)

				if (42 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 42)) > 0 and var_11_0 < var_11_3 then
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
	Play123011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 123011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play123011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.7

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(123011003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 28 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 28)

				if (28 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 28)) > 0 and var_15_0 < var_15_3 then
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
	Play123011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 123011004
		arg_16_1.duration_ = 5.17

		local var_16_0 = {
			zh = 3.833,
			ja = 5.166
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
				arg_16_0:Play123011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[475].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(123011004)
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

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011004", "story_v_out_123011.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011004", "story_v_out_123011.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_123011", "123011004", "story_v_out_123011.awb")

						arg_16_1:RecordAudio("123011004", var_19_6)
						arg_16_1:RecordAudio("123011004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_123011", "123011004", "story_v_out_123011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_123011", "123011004", "story_v_out_123011.awb")
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
	Play123011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 123011005
		arg_20_1.duration_ = 5.73

		local var_20_0 = {
			zh = 4.533,
			ja = 5.733
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
				arg_20_0:Play123011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.5

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[475].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(123011005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 20 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 20)

				if (20 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 20)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011005", "story_v_out_123011.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011005", "story_v_out_123011.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_123011", "123011005", "story_v_out_123011.awb")

						arg_20_1:RecordAudio("123011005", var_23_6)
						arg_20_1:RecordAudio("123011005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_123011", "123011005", "story_v_out_123011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_123011", "123011005", "story_v_out_123011.awb")
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
	Play123011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 123011006
		arg_24_1.duration_ = 9.37

		local var_24_0 = {
			zh = 5.666,
			ja = 9.366
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
				arg_24_0:Play123011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[475].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(123011006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 13 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 13)

				if (13 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 13)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011006", "story_v_out_123011.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011006", "story_v_out_123011.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_123011", "123011006", "story_v_out_123011.awb")

						arg_24_1:RecordAudio("123011006", var_27_6)
						arg_24_1:RecordAudio("123011006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_123011", "123011006", "story_v_out_123011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_123011", "123011006", "story_v_out_123011.awb")
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
	Play123011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 123011007
		arg_28_1.duration_ = 7.97

		local var_28_0 = {
			zh = 4.4,
			ja = 7.966
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
				arg_28_0:Play123011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.35

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[475].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(123011007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 14 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 14)

				if (14 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 14)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011007", "story_v_out_123011.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011007", "story_v_out_123011.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_123011", "123011007", "story_v_out_123011.awb")

						arg_28_1:RecordAudio("123011007", var_31_6)
						arg_28_1:RecordAudio("123011007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_123011", "123011007", "story_v_out_123011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_123011", "123011007", "story_v_out_123011.awb")
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
	Play123011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 123011008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play123011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.575

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(123011008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 63 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 63)

				if (63 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 63)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play123011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 123011009
		arg_36_1.duration_ = 7

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play123011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.bgs_.BA0105 == nil then
				local var_39_0 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "BA0105")
				var_39_0.name = "BA0105"
				var_39_0.transform.parent = arg_36_1.stage_.transform
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_.BA0105 = var_39_0
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				local var_39_1 = arg_36_1.bgs_.BA0105

				arg_36_1.bgs_.BA0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_39_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_2 = var_39_1:GetComponent("SpriteRenderer")

				if var_39_2 and var_39_2.sprite then
					local var_39_3 = 2 * (var_39_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_39_1.transform.localScale = Vector3.New(var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "BA0105" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_4 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_5 = 2

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_5 then
				local var_39_6 = Color.New(0, 0, 0)

				var_39_6.a = Mathf.Lerp(1, 0, (arg_36_1.time_ - var_39_4) / var_39_5)
				arg_36_1.mask_.color = var_39_6
			end

			if arg_36_1.time_ >= var_39_4 + var_39_5 and arg_36_1.time_ < var_39_4 + var_39_5 + arg_39_0 then
				local var_39_7 = Color.New(0, 0, 0)

				arg_36_1.mask_.enabled = false
				var_39_7.a = 0
				arg_36_1.mask_.color = var_39_7
			end

			local var_39_8 = arg_36_1.bgs_.BA0105.transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPosBA0105 = var_39_8.localPosition
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosBA0105, Vector3.New(0, 1, 9.5), (arg_36_1.time_ - 0) / var_39_9)
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_39_10 = arg_36_1.bgs_.BA0105.transform

			if 0.0166666666666667 < arg_36_1.time_ and arg_36_1.time_ <= 0.0166666666666667 + arg_39_0 then
				arg_36_1.var_.moveOldPosBA0105 = var_39_10.localPosition
			end

			local var_39_11 = 3.5

			if 0.0166666666666667 <= arg_36_1.time_ and arg_36_1.time_ < 0.0166666666666667 + var_39_11 then
				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosBA0105, Vector3.New(0, 1, 10), (arg_36_1.time_ - 0.0166666666666667) / var_39_11)
			end

			if arg_36_1.time_ >= 0.0166666666666667 + var_39_11 and arg_36_1.time_ < 0.0166666666666667 + var_39_11 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 1, 10)
			end

			local var_39_12 = 2

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_12 + 1.51666666666667 and arg_36_1.time_ < var_39_12 + 1.51666666666667 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_39_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_15 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_15

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_15
						arg_36_1.bgmTxt2_.text = var_39_15
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

			if 1.8 < arg_36_1.time_ and arg_36_1.time_ <= 1.8 + arg_39_0 then
				arg_36_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_39_18 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_18 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_18

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_18
						arg_36_1.bgmTxt2_.text = var_39_18
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

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_19 = 1.999999999999
			local var_39_20 = 0.4

			if 1.999999999999 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_21 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_21:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_36_1.dialogCg_.alpha = arg_42_0
				end))
				var_39_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_22 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(123011009).content)

				arg_36_1.text_.text = var_39_22

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_24 = 16 <= 0 and var_39_20 or var_39_20 * (utf8.len(var_39_22) / 16)

				if (16 <= 0 and var_39_20 or var_39_20 * (utf8.len(var_39_22) / 16)) > 0 and var_39_20 < var_39_24 then
					arg_36_1.talkMaxDuration = var_39_24
					var_39_19 = var_39_19 + 0.3

					if var_39_24 + var_39_19 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_19
					end
				end

				arg_36_1.text_.text = var_39_22
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = var_39_19 + 0.3
			local var_39_26 = math.max(var_39_20, arg_36_1.talkMaxDuration)

			if var_39_19 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_25 + var_39_26 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_25) / var_39_26

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_25 + var_39_26 and arg_36_1.time_ < var_39_25 + var_39_26 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "BA0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "BA0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play123011010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 123011010
		arg_44_1.duration_ = 9

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play123011011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 1.999999999999 < arg_44_1.time_ and arg_44_1.time_ <= 1.999999999999 + arg_47_0 then
				local var_47_0 = arg_44_1.bgs_.STblack

				arg_44_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_1 = var_47_0:GetComponent("SpriteRenderer")

				if var_47_1 and var_47_1.sprite then
					local var_47_2 = 2 * (var_47_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_0.transform.localScale = Vector3.New(var_47_2 / var_47_1.sprite.bounds.size.y < var_47_2 * manager.ui.mainCameraCom_.aspect / var_47_1.sprite.bounds.size.x and var_47_2 * manager.ui.mainCameraCom_.aspect / var_47_1.sprite.bounds.size.x or var_47_2 / var_47_1.sprite.bounds.size.y, var_47_2 / var_47_1.sprite.bounds.size.y < var_47_2 * manager.ui.mainCameraCom_.aspect / var_47_1.sprite.bounds.size.x and var_47_2 * manager.ui.mainCameraCom_.aspect / var_47_1.sprite.bounds.size.x or var_47_2 / var_47_1.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "STblack" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_3 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_3 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_4 = 2

			if var_47_3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_3 + var_47_4 then
				local var_47_5 = Color.New(0, 0, 0)

				var_47_5.a = Mathf.Lerp(0, 1, (arg_44_1.time_ - var_47_3) / var_47_4)
				arg_44_1.mask_.color = var_47_5
			end

			if arg_44_1.time_ >= var_47_3 + var_47_4 and arg_44_1.time_ < var_47_3 + var_47_4 + arg_47_0 then
				local var_47_6 = Color.New(0, 0, 0)

				var_47_6.a = 1
				arg_44_1.mask_.color = var_47_6
			end

			local var_47_7 = 2

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_8 = 2

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_8 then
				local var_47_9 = Color.New(0, 0, 0)

				var_47_9.a = Mathf.Lerp(1, 0, (arg_44_1.time_ - var_47_7) / var_47_8)
				arg_44_1.mask_.color = var_47_9
			end

			if arg_44_1.time_ >= var_47_7 + var_47_8 and arg_44_1.time_ < var_47_7 + var_47_8 + arg_47_0 then
				local var_47_10 = Color.New(0, 0, 0)

				arg_44_1.mask_.enabled = false
				var_47_10.a = 0
				arg_44_1.mask_.color = var_47_10
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_11 = 3.999999999999
			local var_47_12 = 1.725

			if 3.999999999999 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_13 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_13:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(123011010).content)

				arg_44_1.text_.text = var_47_14

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_16 = 69 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_14) / 69)

				if (69 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_14) / 69)) > 0 and var_47_12 < var_47_16 then
					arg_44_1.talkMaxDuration = var_47_16
					var_47_11 = var_47_11 + 0.3

					if var_47_16 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_16 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_14
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_17 = var_47_11 + 0.3
			local var_47_18 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_18 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_17) / var_47_18

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_17 + var_47_18 and arg_44_1.time_ < var_47_17 + var_47_18 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play123011011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 123011011
		arg_50_1.duration_ = 7

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play123011012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.bgs_.BA0101 == nil then
				local var_53_0 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "BA0101")
				var_53_0.name = "BA0101"
				var_53_0.transform.parent = arg_50_1.stage_.transform
				var_53_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_.BA0101 = var_53_0
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				local var_53_1 = arg_50_1.bgs_.BA0101

				arg_50_1.bgs_.BA0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_53_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_2 = var_53_1:GetComponent("SpriteRenderer")

				if var_53_2 and var_53_2.sprite then
					local var_53_3 = 2 * (var_53_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_53_1.transform.localScale = Vector3.New(var_53_3 / var_53_2.sprite.bounds.size.y < var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x and var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x or var_53_3 / var_53_2.sprite.bounds.size.y, var_53_3 / var_53_2.sprite.bounds.size.y < var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x and var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x or var_53_3 / var_53_2.sprite.bounds.size.y, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "BA0101" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_4 = 0

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_5 = 2

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_5 then
				local var_53_6 = Color.New(0, 0, 0)

				var_53_6.a = Mathf.Lerp(1, 0, (arg_50_1.time_ - var_53_4) / var_53_5)
				arg_50_1.mask_.color = var_53_6
			end

			if arg_50_1.time_ >= var_53_4 + var_53_5 and arg_50_1.time_ < var_53_4 + var_53_5 + arg_53_0 then
				local var_53_7 = Color.New(0, 0, 0)

				arg_50_1.mask_.enabled = false
				var_53_7.a = 0
				arg_50_1.mask_.color = var_53_7
			end

			local var_53_8 = arg_50_1.bgs_.BA0101.transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPosBA0101 = var_53_8.localPosition
			end

			local var_53_9 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_9 then
				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPosBA0101, Vector3.New(0, 1, 2), (arg_50_1.time_ - 0) / var_53_9)
			end

			if arg_50_1.time_ >= 0 + var_53_9 and arg_50_1.time_ < 0 + var_53_9 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(0, 1, 2)
			end

			local var_53_10 = arg_50_1.bgs_.BA0101.transform

			if 0.0166666666666667 < arg_50_1.time_ and arg_50_1.time_ <= 0.0166666666666667 + arg_53_0 then
				arg_50_1.var_.moveOldPosBA0101 = var_53_10.localPosition
			end

			local var_53_11 = 4

			if 0.0166666666666667 <= arg_50_1.time_ and arg_50_1.time_ < 0.0166666666666667 + var_53_11 then
				var_53_10.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPosBA0101, Vector3.New(0, 0.5, 2), (arg_50_1.time_ - 0.0166666666666667) / var_53_11)
			end

			if arg_50_1.time_ >= 0.0166666666666667 + var_53_11 and arg_50_1.time_ < 0.0166666666666667 + var_53_11 + arg_53_0 then
				var_53_10.localPosition = Vector3.New(0, 0.5, 2)
			end

			local var_53_12 = 1.999999999999

			if 1.999999999999 < arg_50_1.time_ and arg_50_1.time_ <= var_53_12 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			if arg_50_1.time_ >= var_53_12 + 2.01666666666767 and arg_50_1.time_ < var_53_12 + 2.01666666666767 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_13 = 1.999999999999
			local var_53_14 = 0.975

			if 1.999999999999 < arg_50_1.time_ and arg_50_1.time_ <= var_53_13 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_15 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_15:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_50_1.dialogCg_.alpha = arg_54_0
				end))
				var_53_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_16 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(123011011).content)

				arg_50_1.text_.text = var_53_16

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_18 = 39 <= 0 and var_53_14 or var_53_14 * (utf8.len(var_53_16) / 39)

				if (39 <= 0 and var_53_14 or var_53_14 * (utf8.len(var_53_16) / 39)) > 0 and var_53_14 < var_53_18 then
					arg_50_1.talkMaxDuration = var_53_18
					var_53_13 = var_53_13 + 0.3

					if var_53_18 + var_53_13 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_18 + var_53_13
					end
				end

				arg_50_1.text_.text = var_53_16
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_19 = var_53_13 + 0.3
			local var_53_20 = math.max(var_53_14, arg_50_1.talkMaxDuration)

			if var_53_13 + 0.3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_19 + var_53_20 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_19) / var_53_20

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_19 + var_53_20 and arg_50_1.time_ < var_53_19 + var_53_20 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "BA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "BA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play123011012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 123011012
		arg_56_1.duration_ = 10.73

		local var_56_0 = {
			zh = 7.966,
			ja = 10.733
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
				arg_56_0:Play123011013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.075

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:GetWordFromCfg(123011012)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 43 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 43)

				if (43 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 43)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011012", "story_v_out_123011.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011012", "story_v_out_123011.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_123011", "123011012", "story_v_out_123011.awb")

						arg_56_1:RecordAudio("123011012", var_59_6)
						arg_56_1:RecordAudio("123011012", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_123011", "123011012", "story_v_out_123011.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_123011", "123011012", "story_v_out_123011.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play123011013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 123011013
		arg_60_1.duration_ = 12.97

		local var_60_0 = {
			zh = 7.533,
			ja = 12.966
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
				arg_60_0:Play123011014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.8

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:GetWordFromCfg(123011013)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 32 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 32)

				if (32 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 32)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011013", "story_v_out_123011.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011013", "story_v_out_123011.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_123011", "123011013", "story_v_out_123011.awb")

						arg_60_1:RecordAudio("123011013", var_63_6)
						arg_60_1:RecordAudio("123011013", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_123011", "123011013", "story_v_out_123011.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_123011", "123011013", "story_v_out_123011.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play123011014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 123011014
		arg_64_1.duration_ = 7.83

		local var_64_0 = {
			zh = 5.633,
			ja = 7.833
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
				arg_64_0:Play123011015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.625

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:GetWordFromCfg(123011014)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 25 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 25)

				if (25 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 25)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011014", "story_v_out_123011.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011014", "story_v_out_123011.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_123011", "123011014", "story_v_out_123011.awb")

						arg_64_1:RecordAudio("123011014", var_67_6)
						arg_64_1:RecordAudio("123011014", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_123011", "123011014", "story_v_out_123011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_123011", "123011014", "story_v_out_123011.awb")
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
	Play123011015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 123011015
		arg_68_1.duration_ = 17.57

		local var_68_0 = {
			zh = 12.2,
			ja = 17.566
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
				arg_68_0:Play123011016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.4

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:GetWordFromCfg(123011015)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 56 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 56)

				if (56 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 56)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011015", "story_v_out_123011.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011015", "story_v_out_123011.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_123011", "123011015", "story_v_out_123011.awb")

						arg_68_1:RecordAudio("123011015", var_71_6)
						arg_68_1:RecordAudio("123011015", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_123011", "123011015", "story_v_out_123011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_123011", "123011015", "story_v_out_123011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play123011016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 123011016
		arg_72_1.duration_ = 11.9

		local var_72_0 = {
			zh = 9.8,
			ja = 11.9
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
				arg_72_0:Play123011017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.15

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(123011016)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 46 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 46)

				if (46 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 46)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011016", "story_v_out_123011.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011016", "story_v_out_123011.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_123011", "123011016", "story_v_out_123011.awb")

						arg_72_1:RecordAudio("123011016", var_75_6)
						arg_72_1:RecordAudio("123011016", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_123011", "123011016", "story_v_out_123011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_123011", "123011016", "story_v_out_123011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play123011017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 123011017
		arg_76_1.duration_ = 11.63

		local var_76_0 = {
			zh = 10.533,
			ja = 11.633
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
				arg_76_0:Play123011018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.925

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(123011017)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 37 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 37)

				if (37 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 37)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011017", "story_v_out_123011.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011017", "story_v_out_123011.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_123011", "123011017", "story_v_out_123011.awb")

						arg_76_1:RecordAudio("123011017", var_79_6)
						arg_76_1:RecordAudio("123011017", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_123011", "123011017", "story_v_out_123011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_123011", "123011017", "story_v_out_123011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play123011018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 123011018
		arg_80_1.duration_ = 8.5

		local var_80_0 = {
			zh = 7.7,
			ja = 8.5
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
				arg_80_0:Play123011019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 1

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(123011018)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 40 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 40)

				if (40 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 40)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011018", "story_v_out_123011.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011018", "story_v_out_123011.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_123011", "123011018", "story_v_out_123011.awb")

						arg_80_1:RecordAudio("123011018", var_83_6)
						arg_80_1:RecordAudio("123011018", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_123011", "123011018", "story_v_out_123011.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_123011", "123011018", "story_v_out_123011.awb")
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
	Play123011019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 123011019
		arg_84_1.duration_ = 5

		local var_84_0 = {
			zh = 2.966,
			ja = 5
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
				arg_84_0:Play123011020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.375

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:GetWordFromCfg(123011019)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 15 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 15)

				if (15 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 15)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011019", "story_v_out_123011.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011019", "story_v_out_123011.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_123011", "123011019", "story_v_out_123011.awb")

						arg_84_1:RecordAudio("123011019", var_87_6)
						arg_84_1:RecordAudio("123011019", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_123011", "123011019", "story_v_out_123011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_123011", "123011019", "story_v_out_123011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play123011020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 123011020
		arg_88_1.duration_ = 9

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play123011021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_0 = 2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				local var_91_1 = Color.New(0, 0, 0)

				var_91_1.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.mask_.color = var_91_1
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				local var_91_2 = Color.New(0, 0, 0)

				var_91_2.a = 1
				arg_88_1.mask_.color = var_91_2
			end

			local var_91_3 = 2

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_4 = 2

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_4 then
				local var_91_5 = Color.New(0, 0, 0)

				var_91_5.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_3) / var_91_4)
				arg_88_1.mask_.color = var_91_5
			end

			if arg_88_1.time_ >= var_91_3 + var_91_4 and arg_88_1.time_ < var_91_3 + var_91_4 + arg_91_0 then
				local var_91_6 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_6.a = 0
				arg_88_1.mask_.color = var_91_6
			end

			local var_91_7 = arg_88_1.bgs_.BA0101.transform

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				arg_88_1.var_.moveOldPosBA0101 = var_91_7.localPosition
			end

			local var_91_8 = 0.001

			if 2 <= arg_88_1.time_ and arg_88_1.time_ < 2 + var_91_8 then
				var_91_7.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosBA0101, Vector3.New(0, 0.5, 7), (arg_88_1.time_ - 2) / var_91_8)
			end

			if arg_88_1.time_ >= 2 + var_91_8 and arg_88_1.time_ < 2 + var_91_8 + arg_91_0 then
				var_91_7.localPosition = Vector3.New(0, 0.5, 7)
			end

			local var_91_9 = arg_88_1.bgs_.BA0101.transform

			if 2.01666666666667 < arg_88_1.time_ and arg_88_1.time_ <= 2.01666666666667 + arg_91_0 then
				arg_88_1.var_.moveOldPosBA0101 = var_91_9.localPosition
			end

			local var_91_10 = 2

			if 2.01666666666667 <= arg_88_1.time_ and arg_88_1.time_ < 2.01666666666667 + var_91_10 then
				var_91_9.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosBA0101, Vector3.New(0, 1, 8), (arg_88_1.time_ - 2.01666666666667) / var_91_10)
			end

			if arg_88_1.time_ >= 2.01666666666667 + var_91_10 and arg_88_1.time_ < 2.01666666666667 + var_91_10 + arg_91_0 then
				var_91_9.localPosition = Vector3.New(0, 1, 8)
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_11 = 4
			local var_91_12 = 0.625

			if 4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_13 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_13:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_14 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(123011020).content)

				arg_88_1.text_.text = var_91_14

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_16 = 25 <= 0 and var_91_12 or var_91_12 * (utf8.len(var_91_14) / 25)

				if (25 <= 0 and var_91_12 or var_91_12 * (utf8.len(var_91_14) / 25)) > 0 and var_91_12 < var_91_16 then
					arg_88_1.talkMaxDuration = var_91_16
					var_91_11 = var_91_11 + 0.3

					if var_91_16 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_16 + var_91_11
					end
				end

				arg_88_1.text_.text = var_91_14
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_17 = var_91_11 + 0.3
			local var_91_18 = math.max(var_91_12, arg_88_1.talkMaxDuration)

			if var_91_11 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_18 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_17) / var_91_18

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_17 + var_91_18 and arg_88_1.time_ < var_91_17 + var_91_18 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "BA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "BA0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play123011021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 123011021
		arg_94_1.duration_ = 3.1

		local var_94_0 = {
			zh = 2,
			ja = 3.1
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
				arg_94_0:Play123011022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.175

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(123011021)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 7 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 7)

				if (7 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 7)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011021", "story_v_out_123011.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011021", "story_v_out_123011.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_123011", "123011021", "story_v_out_123011.awb")

						arg_94_1:RecordAudio("123011021", var_97_6)
						arg_94_1:RecordAudio("123011021", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_123011", "123011021", "story_v_out_123011.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_123011", "123011021", "story_v_out_123011.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play123011022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 123011022
		arg_98_1.duration_ = 9.9

		local var_98_0 = {
			zh = 9.266,
			ja = 9.9
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
				arg_98_0:Play123011023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 1.175

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(123011022)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 47 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 47)

				if (47 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 47)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011022", "story_v_out_123011.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011022", "story_v_out_123011.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_123011", "123011022", "story_v_out_123011.awb")

						arg_98_1:RecordAudio("123011022", var_101_6)
						arg_98_1:RecordAudio("123011022", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_123011", "123011022", "story_v_out_123011.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_123011", "123011022", "story_v_out_123011.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play123011023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 123011023
		arg_102_1.duration_ = 4.03

		local var_102_0 = {
			zh = 1.033,
			ja = 4.033
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
				arg_102_0:Play123011024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.075

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(123011023)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 3 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 3)

				if (3 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 3)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011023", "story_v_out_123011.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011023", "story_v_out_123011.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_123011", "123011023", "story_v_out_123011.awb")

						arg_102_1:RecordAudio("123011023", var_105_6)
						arg_102_1:RecordAudio("123011023", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_123011", "123011023", "story_v_out_123011.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_123011", "123011023", "story_v_out_123011.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play123011024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 123011024
		arg_106_1.duration_ = 5.17

		local var_106_0 = {
			zh = 4.733,
			ja = 5.166
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
				arg_106_0:Play123011025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.65

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:GetWordFromCfg(123011024)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 26 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 26)

				if (26 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 26)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011024", "story_v_out_123011.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011024", "story_v_out_123011.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_123011", "123011024", "story_v_out_123011.awb")

						arg_106_1:RecordAudio("123011024", var_109_6)
						arg_106_1:RecordAudio("123011024", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_123011", "123011024", "story_v_out_123011.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_123011", "123011024", "story_v_out_123011.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play123011025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 123011025
		arg_110_1.duration_ = 8.4

		local var_110_0 = {
			zh = 6.466,
			ja = 8.4
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
				arg_110_0:Play123011026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.825

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(123011025)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 33 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 33)

				if (33 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 33)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011025", "story_v_out_123011.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011025", "story_v_out_123011.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_123011", "123011025", "story_v_out_123011.awb")

						arg_110_1:RecordAudio("123011025", var_113_6)
						arg_110_1:RecordAudio("123011025", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_123011", "123011025", "story_v_out_123011.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_123011", "123011025", "story_v_out_123011.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play123011026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 123011026
		arg_114_1.duration_ = 3.23

		local var_114_0 = {
			zh = 2.1,
			ja = 3.233
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
				arg_114_0:Play123011027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.275

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(123011026)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 11 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 11)

				if (11 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 11)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011026", "story_v_out_123011.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011026", "story_v_out_123011.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_123011", "123011026", "story_v_out_123011.awb")

						arg_114_1:RecordAudio("123011026", var_117_6)
						arg_114_1:RecordAudio("123011026", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_123011", "123011026", "story_v_out_123011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_123011", "123011026", "story_v_out_123011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play123011027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 123011027
		arg_118_1.duration_ = 2.13

		local var_118_0 = {
			zh = 2.133,
			ja = 1.8
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
				arg_118_0:Play123011028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.125

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(123011027)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 5 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 5)

				if (5 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 5)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011027", "story_v_out_123011.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011027", "story_v_out_123011.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_123011", "123011027", "story_v_out_123011.awb")

						arg_118_1:RecordAudio("123011027", var_121_6)
						arg_118_1:RecordAudio("123011027", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_123011", "123011027", "story_v_out_123011.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_123011", "123011027", "story_v_out_123011.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play123011028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 123011028
		arg_122_1.duration_ = 9.37

		local var_122_0 = {
			zh = 9.033,
			ja = 9.366
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
				arg_122_0:Play123011029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.8

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:GetWordFromCfg(123011028)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 32 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 32)

				if (32 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 32)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011028", "story_v_out_123011.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011028", "story_v_out_123011.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_123011", "123011028", "story_v_out_123011.awb")

						arg_122_1:RecordAudio("123011028", var_125_6)
						arg_122_1:RecordAudio("123011028", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_123011", "123011028", "story_v_out_123011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_123011", "123011028", "story_v_out_123011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play123011029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 123011029
		arg_126_1.duration_ = 6.13

		local var_126_0 = {
			zh = 4.2,
			ja = 6.133
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
				arg_126_0:Play123011030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.4

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(123011029)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 16 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 16)

				if (16 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 16)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011029", "story_v_out_123011.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011029", "story_v_out_123011.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_123011", "123011029", "story_v_out_123011.awb")

						arg_126_1:RecordAudio("123011029", var_129_6)
						arg_126_1:RecordAudio("123011029", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_123011", "123011029", "story_v_out_123011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_123011", "123011029", "story_v_out_123011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play123011030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 123011030
		arg_130_1.duration_ = 17.87

		local var_130_0 = {
			zh = 16.9,
			ja = 17.866
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
				arg_130_0:Play123011031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 1.825

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:GetWordFromCfg(123011030)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 73 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 73)

				if (73 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 73)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011030", "story_v_out_123011.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011030", "story_v_out_123011.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_123011", "123011030", "story_v_out_123011.awb")

						arg_130_1:RecordAudio("123011030", var_133_6)
						arg_130_1:RecordAudio("123011030", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_123011", "123011030", "story_v_out_123011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_123011", "123011030", "story_v_out_123011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play123011031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 123011031
		arg_134_1.duration_ = 9.67

		local var_134_0 = {
			zh = 8.5,
			ja = 9.666
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
				arg_134_0:Play123011032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 1.05

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:GetWordFromCfg(123011031)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 42 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 42)

				if (42 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 42)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011031", "story_v_out_123011.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011031", "story_v_out_123011.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_123011", "123011031", "story_v_out_123011.awb")

						arg_134_1:RecordAudio("123011031", var_137_6)
						arg_134_1:RecordAudio("123011031", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_123011", "123011031", "story_v_out_123011.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_123011", "123011031", "story_v_out_123011.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play123011032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 123011032
		arg_138_1.duration_ = 3.23

		local var_138_0 = {
			zh = 1.633,
			ja = 3.233
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
				arg_138_0:Play123011033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.175

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_1 = arg_138_1:GetWordFromCfg(123011032)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 7 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 7)

				if (7 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 7)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011032", "story_v_out_123011.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011032", "story_v_out_123011.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_out_123011", "123011032", "story_v_out_123011.awb")

						arg_138_1:RecordAudio("123011032", var_141_6)
						arg_138_1:RecordAudio("123011032", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_123011", "123011032", "story_v_out_123011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_123011", "123011032", "story_v_out_123011.awb")
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
	Play123011033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 123011033
		arg_142_1.duration_ = 5.93

		local var_142_0 = {
			zh = 3.2,
			ja = 5.933
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
				arg_142_0:Play123011034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.4

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:GetWordFromCfg(123011033)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 16 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 16)

				if (16 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 16)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011033", "story_v_out_123011.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011033", "story_v_out_123011.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_out_123011", "123011033", "story_v_out_123011.awb")

						arg_142_1:RecordAudio("123011033", var_145_6)
						arg_142_1:RecordAudio("123011033", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_123011", "123011033", "story_v_out_123011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_123011", "123011033", "story_v_out_123011.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play123011034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 123011034
		arg_146_1.duration_ = 1.8

		local var_146_0 = {
			zh = 1.233,
			ja = 1.8
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
				arg_146_0:Play123011035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.15

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:GetWordFromCfg(123011034)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 6 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 6)

				if (6 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 6)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011034", "story_v_out_123011.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011034", "story_v_out_123011.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_123011", "123011034", "story_v_out_123011.awb")

						arg_146_1:RecordAudio("123011034", var_149_6)
						arg_146_1:RecordAudio("123011034", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_123011", "123011034", "story_v_out_123011.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_123011", "123011034", "story_v_out_123011.awb")
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
	Play123011035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 123011035
		arg_150_1.duration_ = 12.23

		local var_150_0 = {
			zh = 11.6,
			ja = 12.233
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play123011036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 1.475

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(123011035)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 59 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 59)

				if (59 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 59)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011035", "story_v_out_123011.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011035", "story_v_out_123011.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_123011", "123011035", "story_v_out_123011.awb")

						arg_150_1:RecordAudio("123011035", var_153_6)
						arg_150_1:RecordAudio("123011035", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_123011", "123011035", "story_v_out_123011.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_123011", "123011035", "story_v_out_123011.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play123011036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 123011036
		arg_154_1.duration_ = 14.47

		local var_154_0 = {
			zh = 14.433,
			ja = 14.466
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
				arg_154_0:Play123011037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.825

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:GetWordFromCfg(123011036)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 72 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 72)

				if (72 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 72)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011036", "story_v_out_123011.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011036", "story_v_out_123011.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_123011", "123011036", "story_v_out_123011.awb")

						arg_154_1:RecordAudio("123011036", var_157_6)
						arg_154_1:RecordAudio("123011036", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_123011", "123011036", "story_v_out_123011.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_123011", "123011036", "story_v_out_123011.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play123011037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 123011037
		arg_158_1.duration_ = 3.17

		local var_158_0 = {
			zh = 3.033,
			ja = 3.166
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play123011038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.4

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:GetWordFromCfg(123011037)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 16 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 16)

				if (16 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 16)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011037", "story_v_out_123011.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011037", "story_v_out_123011.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_123011", "123011037", "story_v_out_123011.awb")

						arg_158_1:RecordAudio("123011037", var_161_6)
						arg_158_1:RecordAudio("123011037", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_123011", "123011037", "story_v_out_123011.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_123011", "123011037", "story_v_out_123011.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play123011038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 123011038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play123011039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.775

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(123011038).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 31 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 31)

				if (31 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 31)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play123011039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 123011039
		arg_166_1.duration_ = 9.47

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play123011040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 1.125

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:GetWordFromCfg(123011039)
				local var_169_2 = arg_166_1:FormatText(var_169_1.content)

				arg_166_1.text_.text = var_169_2

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 45 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 45)

				if (45 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 45)) > 0 and var_169_0 < var_169_4 then
					arg_166_1.talkMaxDuration = var_169_4

					if var_169_4 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_4 + 0
					end
				end

				arg_166_1.text_.text = var_169_2
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011039", "story_v_out_123011.awb") ~= 0 then
					local var_169_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011039", "story_v_out_123011.awb") / 1000

					if var_169_5 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + 0
					end

					if var_169_1.prefab_name ~= "" and arg_166_1.actors_[var_169_1.prefab_name] ~= nil then
						local var_169_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_1.prefab_name].transform, "story_v_out_123011", "123011039", "story_v_out_123011.awb")

						arg_166_1:RecordAudio("123011039", var_169_6)
						arg_166_1:RecordAudio("123011039", var_169_6)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_123011", "123011039", "story_v_out_123011.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_123011", "123011039", "story_v_out_123011.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play123011040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 123011040
		arg_170_1.duration_ = 3.17

		local var_170_0 = {
			zh = 1.666,
			ja = 3.166
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play123011041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.125

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:GetWordFromCfg(123011040)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 5 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 5)

				if (5 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 5)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011040", "story_v_out_123011.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011040", "story_v_out_123011.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_out_123011", "123011040", "story_v_out_123011.awb")

						arg_170_1:RecordAudio("123011040", var_173_6)
						arg_170_1:RecordAudio("123011040", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_123011", "123011040", "story_v_out_123011.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_123011", "123011040", "story_v_out_123011.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play123011041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 123011041
		arg_174_1.duration_ = 17.17

		local var_174_0 = {
			zh = 11.133,
			ja = 17.166
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play123011042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.375

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:GetWordFromCfg(123011041)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 56 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 56)

				if (56 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 56)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011041", "story_v_out_123011.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011041", "story_v_out_123011.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_123011", "123011041", "story_v_out_123011.awb")

						arg_174_1:RecordAudio("123011041", var_177_6)
						arg_174_1:RecordAudio("123011041", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_123011", "123011041", "story_v_out_123011.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_123011", "123011041", "story_v_out_123011.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play123011042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 123011042
		arg_178_1.duration_ = 7.27

		local var_178_0 = {
			zh = 3.8,
			ja = 7.266
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
				arg_178_0:Play123011043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.35

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:GetWordFromCfg(123011042)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 14 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 14)

				if (14 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 14)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011042", "story_v_out_123011.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011042", "story_v_out_123011.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_123011", "123011042", "story_v_out_123011.awb")

						arg_178_1:RecordAudio("123011042", var_181_6)
						arg_178_1:RecordAudio("123011042", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_123011", "123011042", "story_v_out_123011.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_123011", "123011042", "story_v_out_123011.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play123011043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 123011043
		arg_182_1.duration_ = 9.1

		local var_182_0 = {
			zh = 5.9,
			ja = 9.1
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play123011044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.625

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(123011043)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 25 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 25)

				if (25 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 25)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011043", "story_v_out_123011.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011043", "story_v_out_123011.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_123011", "123011043", "story_v_out_123011.awb")

						arg_182_1:RecordAudio("123011043", var_185_6)
						arg_182_1:RecordAudio("123011043", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_123011", "123011043", "story_v_out_123011.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_123011", "123011043", "story_v_out_123011.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play123011044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 123011044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play123011045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.225

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(123011044).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 9 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 9)

				if (9 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 9)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play123011045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 123011045
		arg_190_1.duration_ = 9.2

		local var_190_0 = {
			zh = 6.3,
			ja = 9.2
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play123011046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.875

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:GetWordFromCfg(123011045)
				local var_193_2 = arg_190_1:FormatText(var_193_1.content)

				arg_190_1.text_.text = var_193_2

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 35 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 35)

				if (35 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 35)) > 0 and var_193_0 < var_193_4 then
					arg_190_1.talkMaxDuration = var_193_4

					if var_193_4 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_4 + 0
					end
				end

				arg_190_1.text_.text = var_193_2
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011045", "story_v_out_123011.awb") ~= 0 then
					local var_193_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011045", "story_v_out_123011.awb") / 1000

					if var_193_5 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + 0
					end

					if var_193_1.prefab_name ~= "" and arg_190_1.actors_[var_193_1.prefab_name] ~= nil then
						local var_193_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_1.prefab_name].transform, "story_v_out_123011", "123011045", "story_v_out_123011.awb")

						arg_190_1:RecordAudio("123011045", var_193_6)
						arg_190_1:RecordAudio("123011045", var_193_6)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_123011", "123011045", "story_v_out_123011.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_123011", "123011045", "story_v_out_123011.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play123011046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 123011046
		arg_194_1.duration_ = 1.5

		local var_194_0 = {
			zh = 1.266,
			ja = 1.5
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
				arg_194_0:Play123011047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.075

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:GetWordFromCfg(123011046)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 3 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 3)

				if (3 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 3)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011046", "story_v_out_123011.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011046", "story_v_out_123011.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_123011", "123011046", "story_v_out_123011.awb")

						arg_194_1:RecordAudio("123011046", var_197_6)
						arg_194_1:RecordAudio("123011046", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_123011", "123011046", "story_v_out_123011.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_123011", "123011046", "story_v_out_123011.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play123011047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 123011047
		arg_198_1.duration_ = 16.47

		local var_198_0 = {
			zh = 15.2,
			ja = 16.466
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play123011048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 1.975

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(123011047)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 79 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 79)

				if (79 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 79)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011047", "story_v_out_123011.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011047", "story_v_out_123011.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_123011", "123011047", "story_v_out_123011.awb")

						arg_198_1:RecordAudio("123011047", var_201_6)
						arg_198_1:RecordAudio("123011047", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_123011", "123011047", "story_v_out_123011.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_123011", "123011047", "story_v_out_123011.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play123011048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 123011048
		arg_202_1.duration_ = 6

		local var_202_0 = {
			zh = 4.833,
			ja = 6
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play123011049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.55

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:GetWordFromCfg(123011048)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 22 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 22)

				if (22 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 22)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011048", "story_v_out_123011.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011048", "story_v_out_123011.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_123011", "123011048", "story_v_out_123011.awb")

						arg_202_1:RecordAudio("123011048", var_205_6)
						arg_202_1:RecordAudio("123011048", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_123011", "123011048", "story_v_out_123011.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_123011", "123011048", "story_v_out_123011.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play123011049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 123011049
		arg_206_1.duration_ = 7.83

		local var_206_0 = {
			zh = 5.066,
			ja = 7.833
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play123011050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.525

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:GetWordFromCfg(123011049)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 21 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 21)

				if (21 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 21)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011049", "story_v_out_123011.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011049", "story_v_out_123011.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_123011", "123011049", "story_v_out_123011.awb")

						arg_206_1:RecordAudio("123011049", var_209_6)
						arg_206_1:RecordAudio("123011049", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_123011", "123011049", "story_v_out_123011.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_123011", "123011049", "story_v_out_123011.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play123011050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 123011050
		arg_210_1.duration_ = 4.07

		local var_210_0 = {
			zh = 3.833,
			ja = 4.066
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play123011051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.45

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:GetWordFromCfg(123011050)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 18 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 18)

				if (18 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 18)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011050", "story_v_out_123011.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011050", "story_v_out_123011.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_123011", "123011050", "story_v_out_123011.awb")

						arg_210_1:RecordAudio("123011050", var_213_6)
						arg_210_1:RecordAudio("123011050", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_123011", "123011050", "story_v_out_123011.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_123011", "123011050", "story_v_out_123011.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play123011051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 123011051
		arg_214_1.duration_ = 7.73

		local var_214_0 = {
			zh = 6.666,
			ja = 7.733
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
				arg_214_0:Play123011052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.85

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:GetWordFromCfg(123011051)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 34 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 34)

				if (34 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 34)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011051", "story_v_out_123011.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011051", "story_v_out_123011.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_123011", "123011051", "story_v_out_123011.awb")

						arg_214_1:RecordAudio("123011051", var_217_6)
						arg_214_1:RecordAudio("123011051", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_123011", "123011051", "story_v_out_123011.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_123011", "123011051", "story_v_out_123011.awb")
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
	Play123011052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 123011052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play123011053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.225

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(123011052).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 9 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 9)

				if (9 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 9)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play123011053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 123011053
		arg_222_1.duration_ = 5.97

		local var_222_0 = {
			zh = 5.966,
			ja = 4.866
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play123011054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.725

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(123011053)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 29 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 29)

				if (29 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 29)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011053", "story_v_out_123011.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011053", "story_v_out_123011.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_123011", "123011053", "story_v_out_123011.awb")

						arg_222_1:RecordAudio("123011053", var_225_6)
						arg_222_1:RecordAudio("123011053", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_123011", "123011053", "story_v_out_123011.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_123011", "123011053", "story_v_out_123011.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play123011054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 123011054
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play123011055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.3

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(123011054).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 52 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 52)

				if (52 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 52)) > 0 and var_229_0 < var_229_3 then
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
	Play123011055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 123011055
		arg_230_1.duration_ = 10.73

		local var_230_0 = {
			zh = 7.466,
			ja = 10.733
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play123011056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.875

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(123011055)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 35 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 35)

				if (35 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 35)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011055", "story_v_out_123011.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011055", "story_v_out_123011.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_123011", "123011055", "story_v_out_123011.awb")

						arg_230_1:RecordAudio("123011055", var_233_6)
						arg_230_1:RecordAudio("123011055", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_123011", "123011055", "story_v_out_123011.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_123011", "123011055", "story_v_out_123011.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play123011056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 123011056
		arg_234_1.duration_ = 5.9

		local var_234_0 = {
			zh = 3.7,
			ja = 5.9
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play123011057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:GetWordFromCfg(123011056)
				local var_237_2 = arg_234_1:FormatText(var_237_1.content)

				arg_234_1.text_.text = var_237_2

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 18 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 18)

				if (18 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_2) / 18)) > 0 and var_237_0 < var_237_4 then
					arg_234_1.talkMaxDuration = var_237_4

					if var_237_4 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_4 + 0
					end
				end

				arg_234_1.text_.text = var_237_2
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011056", "story_v_out_123011.awb") ~= 0 then
					local var_237_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011056", "story_v_out_123011.awb") / 1000

					if var_237_5 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + 0
					end

					if var_237_1.prefab_name ~= "" and arg_234_1.actors_[var_237_1.prefab_name] ~= nil then
						local var_237_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_1.prefab_name].transform, "story_v_out_123011", "123011056", "story_v_out_123011.awb")

						arg_234_1:RecordAudio("123011056", var_237_6)
						arg_234_1:RecordAudio("123011056", var_237_6)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_123011", "123011056", "story_v_out_123011.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_123011", "123011056", "story_v_out_123011.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play123011057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 123011057
		arg_238_1.duration_ = 11.53

		local var_238_0 = {
			zh = 11.366,
			ja = 11.533
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play123011058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.925

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:GetWordFromCfg(123011057)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 37 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 37)

				if (37 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 37)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011057", "story_v_out_123011.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011057", "story_v_out_123011.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_out_123011", "123011057", "story_v_out_123011.awb")

						arg_238_1:RecordAudio("123011057", var_241_6)
						arg_238_1:RecordAudio("123011057", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_123011", "123011057", "story_v_out_123011.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_123011", "123011057", "story_v_out_123011.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play123011058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 123011058
		arg_242_1.duration_ = 2.23

		local var_242_0 = {
			zh = 2,
			ja = 2.233
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play123011059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.225

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:GetWordFromCfg(123011058)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 9 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 9)

				if (9 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 9)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011058", "story_v_out_123011.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011058", "story_v_out_123011.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_123011", "123011058", "story_v_out_123011.awb")

						arg_242_1:RecordAudio("123011058", var_245_6)
						arg_242_1:RecordAudio("123011058", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_123011", "123011058", "story_v_out_123011.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_123011", "123011058", "story_v_out_123011.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play123011059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 123011059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play123011060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.5

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(123011059).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 60 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 60)

				if (60 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 60)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play123011060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 123011060
		arg_250_1.duration_ = 4.13

		local var_250_0 = {
			zh = 3.866,
			ja = 4.133
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play123011061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.275

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:GetWordFromCfg(123011060)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 11 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 11)

				if (11 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 11)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011060", "story_v_out_123011.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011060", "story_v_out_123011.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_123011", "123011060", "story_v_out_123011.awb")

						arg_250_1:RecordAudio("123011060", var_253_6)
						arg_250_1:RecordAudio("123011060", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_123011", "123011060", "story_v_out_123011.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_123011", "123011060", "story_v_out_123011.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play123011061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 123011061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play123011062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.725

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(123011061).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 29 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 29)

				if (29 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 29)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play123011062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 123011062
		arg_258_1.duration_ = 3.37

		local var_258_0 = {
			zh = 3.366,
			ja = 3.133
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
				arg_258_0:Play123011063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if arg_258_1.bgs_.BA0101a == nil then
				local var_261_0 = Object.Instantiate(arg_258_1.paintGo_)

				var_261_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "BA0101a")
				var_261_0.name = "BA0101a"
				var_261_0.transform.parent = arg_258_1.stage_.transform
				var_261_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.bgs_.BA0101a = var_261_0
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				local var_261_1 = arg_258_1.bgs_.BA0101a

				arg_258_1.bgs_.BA0101a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_261_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_2 = var_261_1:GetComponent("SpriteRenderer")

				if var_261_2 and var_261_2.sprite then
					local var_261_3 = 2 * (var_261_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_261_1.transform.localScale = Vector3.New(var_261_3 / var_261_2.sprite.bounds.size.y < var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x and var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x or var_261_3 / var_261_2.sprite.bounds.size.y, var_261_3 / var_261_2.sprite.bounds.size.y < var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x and var_261_3 * manager.ui.mainCameraCom_.aspect / var_261_2.sprite.bounds.size.x or var_261_3 / var_261_2.sprite.bounds.size.y, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "BA0101a" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_4 = 0

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_5 = 2

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_5 then
				local var_261_6 = Color.New(1, 1, 1)

				var_261_6.a = Mathf.Lerp(1, 0, (arg_258_1.time_ - var_261_4) / var_261_5)
				arg_258_1.mask_.color = var_261_6
			end

			if arg_258_1.time_ >= var_261_4 + var_261_5 and arg_258_1.time_ < var_261_4 + var_261_5 + arg_261_0 then
				local var_261_7 = Color.New(1, 1, 1)

				arg_258_1.mask_.enabled = false
				var_261_7.a = 0
				arg_258_1.mask_.color = var_261_7
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_8 = 2
			local var_261_9 = 0.125

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_10 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_10:setOnUpdate(LuaHelper.FloatAction(function(arg_262_0)
					arg_258_1.dialogCg_.alpha = arg_262_0
				end))
				var_261_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_11 = arg_258_1:GetWordFromCfg(123011062)
				local var_261_12 = arg_258_1:FormatText(var_261_11.content)

				arg_258_1.text_.text = var_261_12

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_14 = 5 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_12) / 5)

				if (5 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_12) / 5)) > 0 and var_261_9 < var_261_14 then
					arg_258_1.talkMaxDuration = var_261_14
					var_261_8 = var_261_8 + 0.3

					if var_261_14 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_12
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011062", "story_v_out_123011.awb") ~= 0 then
					local var_261_15 = manager.audio:GetVoiceLength("story_v_out_123011", "123011062", "story_v_out_123011.awb") / 1000

					if var_261_15 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_15 + var_261_8
					end

					if var_261_11.prefab_name ~= "" and arg_258_1.actors_[var_261_11.prefab_name] ~= nil then
						local var_261_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_11.prefab_name].transform, "story_v_out_123011", "123011062", "story_v_out_123011.awb")

						arg_258_1:RecordAudio("123011062", var_261_16)
						arg_258_1:RecordAudio("123011062", var_261_16)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_123011", "123011062", "story_v_out_123011.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_123011", "123011062", "story_v_out_123011.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_17 = var_261_8 + 0.3
			local var_261_18 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 + 0.3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_18 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_17) / var_261_18

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_17 + var_261_18 and arg_258_1.time_ < var_261_17 + var_261_18 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play123011063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 123011063
		arg_264_1.duration_ = 5.67

		local var_264_0 = {
			zh = 4.833,
			ja = 5.666
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
				arg_264_0:Play123011064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.6

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_1 = arg_264_1:GetWordFromCfg(123011063)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 24 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 24)

				if (24 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 24)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011063", "story_v_out_123011.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011063", "story_v_out_123011.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_123011", "123011063", "story_v_out_123011.awb")

						arg_264_1:RecordAudio("123011063", var_267_6)
						arg_264_1:RecordAudio("123011063", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_123011", "123011063", "story_v_out_123011.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_123011", "123011063", "story_v_out_123011.awb")
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
	Play123011064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 123011064
		arg_268_1.duration_ = 7.23

		local var_268_0 = {
			zh = 5.766,
			ja = 7.233
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play123011065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.375

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:GetWordFromCfg(123011064)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 15 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 15)

				if (15 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 15)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011064", "story_v_out_123011.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011064", "story_v_out_123011.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_123011", "123011064", "story_v_out_123011.awb")

						arg_268_1:RecordAudio("123011064", var_271_6)
						arg_268_1:RecordAudio("123011064", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_123011", "123011064", "story_v_out_123011.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_123011", "123011064", "story_v_out_123011.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play123011065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 123011065
		arg_272_1.duration_ = 5.07

		local var_272_0 = {
			zh = 2.466,
			ja = 5.066
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
				arg_272_0:Play123011066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.35

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:GetWordFromCfg(123011065)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 14 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 14)

				if (14 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 14)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011065", "story_v_out_123011.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011065", "story_v_out_123011.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_123011", "123011065", "story_v_out_123011.awb")

						arg_272_1:RecordAudio("123011065", var_275_6)
						arg_272_1:RecordAudio("123011065", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_123011", "123011065", "story_v_out_123011.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_123011", "123011065", "story_v_out_123011.awb")
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
	Play123011066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 123011066
		arg_276_1.duration_ = 11.9

		local var_276_0 = {
			zh = 10.333,
			ja = 11.9
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
				arg_276_0:Play123011067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.85

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:GetWordFromCfg(123011066)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 34 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 34)

				if (34 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 34)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011066", "story_v_out_123011.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011066", "story_v_out_123011.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_out_123011", "123011066", "story_v_out_123011.awb")

						arg_276_1:RecordAudio("123011066", var_279_6)
						arg_276_1:RecordAudio("123011066", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_123011", "123011066", "story_v_out_123011.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_123011", "123011066", "story_v_out_123011.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play123011067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 123011067
		arg_280_1.duration_ = 7.9

		local var_280_0 = {
			zh = 5.7,
			ja = 7.9
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
				arg_280_0:Play123011068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.65

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_1 = arg_280_1:GetWordFromCfg(123011067)
				local var_283_2 = arg_280_1:FormatText(var_283_1.content)

				arg_280_1.text_.text = var_283_2

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 26 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 26)

				if (26 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 26)) > 0 and var_283_0 < var_283_4 then
					arg_280_1.talkMaxDuration = var_283_4

					if var_283_4 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_4 + 0
					end
				end

				arg_280_1.text_.text = var_283_2
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011067", "story_v_out_123011.awb") ~= 0 then
					local var_283_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011067", "story_v_out_123011.awb") / 1000

					if var_283_5 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + 0
					end

					if var_283_1.prefab_name ~= "" and arg_280_1.actors_[var_283_1.prefab_name] ~= nil then
						local var_283_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_1.prefab_name].transform, "story_v_out_123011", "123011067", "story_v_out_123011.awb")

						arg_280_1:RecordAudio("123011067", var_283_6)
						arg_280_1:RecordAudio("123011067", var_283_6)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_123011", "123011067", "story_v_out_123011.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_123011", "123011067", "story_v_out_123011.awb")
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
	Play123011068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 123011068
		arg_284_1.duration_ = 2

		local var_284_0 = {
			zh = 1.533,
			ja = 2
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
				arg_284_0:Play123011069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.125

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:GetWordFromCfg(123011068)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 5 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 5)

				if (5 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 5)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011068", "story_v_out_123011.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011068", "story_v_out_123011.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_123011", "123011068", "story_v_out_123011.awb")

						arg_284_1:RecordAudio("123011068", var_287_6)
						arg_284_1:RecordAudio("123011068", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_123011", "123011068", "story_v_out_123011.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_123011", "123011068", "story_v_out_123011.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play123011069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 123011069
		arg_288_1.duration_ = 16.97

		local var_288_0 = {
			zh = 10.766,
			ja = 16.966
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
				arg_288_0:Play123011070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 1.375

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:GetWordFromCfg(123011069)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 55 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 55)

				if (55 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 55)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011069", "story_v_out_123011.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011069", "story_v_out_123011.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_123011", "123011069", "story_v_out_123011.awb")

						arg_288_1:RecordAudio("123011069", var_291_6)
						arg_288_1:RecordAudio("123011069", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_123011", "123011069", "story_v_out_123011.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_123011", "123011069", "story_v_out_123011.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play123011070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 123011070
		arg_292_1.duration_ = 4.17

		local var_292_0 = {
			zh = 3.833,
			ja = 4.166
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play123011071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.375

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:GetWordFromCfg(123011070)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 15 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 15)

				if (15 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 15)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011070", "story_v_out_123011.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011070", "story_v_out_123011.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_123011", "123011070", "story_v_out_123011.awb")

						arg_292_1:RecordAudio("123011070", var_295_6)
						arg_292_1:RecordAudio("123011070", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_123011", "123011070", "story_v_out_123011.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_123011", "123011070", "story_v_out_123011.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play123011071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 123011071
		arg_296_1.duration_ = 10.3

		local var_296_0 = {
			zh = 6.666,
			ja = 10.3
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
				arg_296_0:Play123011072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.65

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_1 = arg_296_1:GetWordFromCfg(123011071)
				local var_299_2 = arg_296_1:FormatText(var_299_1.content)

				arg_296_1.text_.text = var_299_2

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 26 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 26)

				if (26 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 26)) > 0 and var_299_0 < var_299_4 then
					arg_296_1.talkMaxDuration = var_299_4

					if var_299_4 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_4 + 0
					end
				end

				arg_296_1.text_.text = var_299_2
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011071", "story_v_out_123011.awb") ~= 0 then
					local var_299_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011071", "story_v_out_123011.awb") / 1000

					if var_299_5 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + 0
					end

					if var_299_1.prefab_name ~= "" and arg_296_1.actors_[var_299_1.prefab_name] ~= nil then
						local var_299_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_1.prefab_name].transform, "story_v_out_123011", "123011071", "story_v_out_123011.awb")

						arg_296_1:RecordAudio("123011071", var_299_6)
						arg_296_1:RecordAudio("123011071", var_299_6)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_123011", "123011071", "story_v_out_123011.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_123011", "123011071", "story_v_out_123011.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play123011072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 123011072
		arg_300_1.duration_ = 1.43

		local var_300_0 = {
			zh = 1.1,
			ja = 1.433
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
				arg_300_0:Play123011073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.075

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:GetWordFromCfg(123011072)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 3 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 3)

				if (3 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 3)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011072", "story_v_out_123011.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011072", "story_v_out_123011.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_out_123011", "123011072", "story_v_out_123011.awb")

						arg_300_1:RecordAudio("123011072", var_303_6)
						arg_300_1:RecordAudio("123011072", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_123011", "123011072", "story_v_out_123011.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_123011", "123011072", "story_v_out_123011.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play123011073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 123011073
		arg_304_1.duration_ = 15.7

		local var_304_0 = {
			zh = 14.066,
			ja = 15.7
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
				arg_304_0:Play123011074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.325

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(123011073)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 53 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 53)

				if (53 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 53)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011073", "story_v_out_123011.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011073", "story_v_out_123011.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_123011", "123011073", "story_v_out_123011.awb")

						arg_304_1:RecordAudio("123011073", var_307_6)
						arg_304_1:RecordAudio("123011073", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_123011", "123011073", "story_v_out_123011.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_123011", "123011073", "story_v_out_123011.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play123011074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 123011074
		arg_308_1.duration_ = 6.93

		local var_308_0 = {
			zh = 6.933,
			ja = 6.6
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play123011075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.4

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:GetWordFromCfg(123011074)
				local var_311_2 = arg_308_1:FormatText(var_311_1.content)

				arg_308_1.text_.text = var_311_2

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 16 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 16)

				if (16 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 16)) > 0 and var_311_0 < var_311_4 then
					arg_308_1.talkMaxDuration = var_311_4

					if var_311_4 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_4 + 0
					end
				end

				arg_308_1.text_.text = var_311_2
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011074", "story_v_out_123011.awb") ~= 0 then
					local var_311_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011074", "story_v_out_123011.awb") / 1000

					if var_311_5 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + 0
					end

					if var_311_1.prefab_name ~= "" and arg_308_1.actors_[var_311_1.prefab_name] ~= nil then
						local var_311_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_1.prefab_name].transform, "story_v_out_123011", "123011074", "story_v_out_123011.awb")

						arg_308_1:RecordAudio("123011074", var_311_6)
						arg_308_1:RecordAudio("123011074", var_311_6)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_123011", "123011074", "story_v_out_123011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_123011", "123011074", "story_v_out_123011.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play123011075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 123011075
		arg_312_1.duration_ = 9

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play123011076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 2 < arg_312_1.time_ and arg_312_1.time_ <= 2 + arg_315_0 then
				local var_315_0 = arg_312_1.bgs_.STblack

				arg_312_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_315_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_1 = var_315_0:GetComponent("SpriteRenderer")

				if var_315_1 and var_315_1.sprite then
					local var_315_2 = 2 * (var_315_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_315_0.transform.localScale = Vector3.New(var_315_2 / var_315_1.sprite.bounds.size.y < var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x and var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x or var_315_2 / var_315_1.sprite.bounds.size.y, var_315_2 / var_315_1.sprite.bounds.size.y < var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x and var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x or var_315_2 / var_315_1.sprite.bounds.size.y, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "STblack" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_3 = 0

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_4 = 2

			if var_315_3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_3 + var_315_4 then
				local var_315_5 = Color.New(0, 0, 0)

				var_315_5.a = Mathf.Lerp(0, 1, (arg_312_1.time_ - var_315_3) / var_315_4)
				arg_312_1.mask_.color = var_315_5
			end

			if arg_312_1.time_ >= var_315_3 + var_315_4 and arg_312_1.time_ < var_315_3 + var_315_4 + arg_315_0 then
				local var_315_6 = Color.New(0, 0, 0)

				var_315_6.a = 1
				arg_312_1.mask_.color = var_315_6
			end

			local var_315_7 = 2

			if 2 < arg_312_1.time_ and arg_312_1.time_ <= var_315_7 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_8 = 2

			if var_315_7 <= arg_312_1.time_ and arg_312_1.time_ < var_315_7 + var_315_8 then
				local var_315_9 = Color.New(0, 0, 0)

				var_315_9.a = Mathf.Lerp(1, 0, (arg_312_1.time_ - var_315_7) / var_315_8)
				arg_312_1.mask_.color = var_315_9
			end

			if arg_312_1.time_ >= var_315_7 + var_315_8 and arg_312_1.time_ < var_315_7 + var_315_8 + arg_315_0 then
				local var_315_10 = Color.New(0, 0, 0)

				arg_312_1.mask_.enabled = false
				var_315_10.a = 0
				arg_312_1.mask_.color = var_315_10
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_11 = 3.999999999999
			local var_315_12 = 0.675

			if 3.999999999999 < arg_312_1.time_ and arg_312_1.time_ <= var_315_11 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_13 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_13:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_14 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(123011075).content)

				arg_312_1.text_.text = var_315_14

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_16 = 27 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 27)

				if (27 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 27)) > 0 and var_315_12 < var_315_16 then
					arg_312_1.talkMaxDuration = var_315_16
					var_315_11 = var_315_11 + 0.3

					if var_315_16 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_16 + var_315_11
					end
				end

				arg_312_1.text_.text = var_315_14
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_17 = var_315_11 + 0.3
			local var_315_18 = math.max(var_315_12, arg_312_1.talkMaxDuration)

			if var_315_11 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_17 + var_315_18 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_17) / var_315_18

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_17 + var_315_18 and arg_312_1.time_ < var_315_17 + var_315_18 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play123011076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 123011076
		arg_318_1.duration_ = 7

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play123011077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if arg_318_1.bgs_.ST11a == nil then
				local var_321_0 = Object.Instantiate(arg_318_1.paintGo_)

				var_321_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST11a")
				var_321_0.name = "ST11a"
				var_321_0.transform.parent = arg_318_1.stage_.transform
				var_321_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_318_1.bgs_.ST11a = var_321_0
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				local var_321_1 = arg_318_1.bgs_.ST11a

				arg_318_1.bgs_.ST11a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_321_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_2 = var_321_1:GetComponent("SpriteRenderer")

				if var_321_2 and var_321_2.sprite then
					local var_321_3 = 2 * (var_321_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_321_1.transform.localScale = Vector3.New(var_321_3 / var_321_2.sprite.bounds.size.y < var_321_3 * manager.ui.mainCameraCom_.aspect / var_321_2.sprite.bounds.size.x and var_321_3 * manager.ui.mainCameraCom_.aspect / var_321_2.sprite.bounds.size.x or var_321_3 / var_321_2.sprite.bounds.size.y, var_321_3 / var_321_2.sprite.bounds.size.y < var_321_3 * manager.ui.mainCameraCom_.aspect / var_321_2.sprite.bounds.size.x and var_321_3 * manager.ui.mainCameraCom_.aspect / var_321_2.sprite.bounds.size.x or var_321_3 / var_321_2.sprite.bounds.size.y, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "ST11a" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

				var_321_6.a = Mathf.Lerp(1, 0, (arg_318_1.time_ - var_321_4) / var_321_5)
				arg_318_1.mask_.color = var_321_6
			end

			if arg_318_1.time_ >= var_321_4 + var_321_5 and arg_318_1.time_ < var_321_4 + var_321_5 + arg_321_0 then
				local var_321_7 = Color.New(0, 0, 0)

				arg_318_1.mask_.enabled = false
				var_321_7.a = 0
				arg_318_1.mask_.color = var_321_7
			end

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= 2 + arg_321_0 then
				arg_318_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_whoosh", "")
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_9 = 2
			local var_321_10 = 1.375

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_11 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_11:setOnUpdate(LuaHelper.FloatAction(function(arg_322_0)
					arg_318_1.dialogCg_.alpha = arg_322_0
				end))
				var_321_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_12 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(123011076).content)

				arg_318_1.text_.text = var_321_12

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_14 = 55 <= 0 and var_321_10 or var_321_10 * (utf8.len(var_321_12) / 55)

				if (55 <= 0 and var_321_10 or var_321_10 * (utf8.len(var_321_12) / 55)) > 0 and var_321_10 < var_321_14 then
					arg_318_1.talkMaxDuration = var_321_14
					var_321_9 = var_321_9 + 0.3

					if var_321_14 + var_321_9 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_9
					end
				end

				arg_318_1.text_.text = var_321_12
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_15 = var_321_9 + 0.3
			local var_321_16 = math.max(var_321_10, arg_318_1.talkMaxDuration)

			if var_321_9 + 0.3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_15 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_15) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_15 + var_321_16 and arg_318_1.time_ < var_321_15 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play123011077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 123011077
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play123011078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.7

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(123011077).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 28 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 28)

				if (28 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 28)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play123011078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 123011078
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play123011079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_331_1 = 0
			local var_331_2 = 0.475

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_3 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(123011078).content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 19 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 19)

				if (19 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 19)) > 0 and var_331_2 < var_331_5 then
					arg_328_1.talkMaxDuration = var_331_5

					if var_331_5 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + var_331_1
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_6 = math.max(var_331_2, arg_328_1.talkMaxDuration)

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_6 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_1) / var_331_6

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_1 + var_331_6 and arg_328_1.time_ < var_331_1 + var_331_6 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play123011079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 123011079
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play123011080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 1.05

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_1 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(123011079).content)

				arg_332_1.text_.text = var_335_1

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_3 = 42 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 42)

				if (42 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 42)) > 0 and var_335_0 < var_335_3 then
					arg_332_1.talkMaxDuration = var_335_3

					if var_335_3 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_3 + 0
					end
				end

				arg_332_1.text_.text = var_335_1
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_4 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_4

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play123011080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 123011080
		arg_336_1.duration_ = 11.97

		local var_336_0 = {
			zh = 8.133,
			ja = 11.966
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
				arg_336_0:Play123011081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if arg_336_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_339_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_336_1.stage_.transform)

				var_339_0.name = "1199ui_story"
				var_339_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_336_1.actors_["1199ui_story"] = var_339_0

				local var_339_1 = var_339_0:GetComponentInChildren(typeof(CharacterEffect))

				var_339_1.enabled = true

				local var_339_2 = GameObjectTools.GetOrAddComponent(var_339_0, typeof(DynamicBoneHelper))

				if var_339_2 then
					var_339_2:EnableDynamicBone(false)
				end

				arg_336_1:ShowWeapon(var_339_1.transform, false)

				arg_336_1.var_["1199ui_story" .. "Animator"] = var_339_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_336_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_336_1.var_["1199ui_story" .. "LipSync"] = var_339_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_339_3 = arg_336_1.actors_["1199ui_story"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1199ui_story = var_339_3.localPosition
			end

			local var_339_4 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				var_339_3.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_336_1.time_ - 0) / var_339_4)
				var_339_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_3.position).x, (manager.ui.mainCamera.transform.position - var_339_3.position).y, (manager.ui.mainCamera.transform.position - var_339_3.position).z)
				var_339_3.localEulerAngles.z = 0
				var_339_3.localEulerAngles.x = 0
				var_339_3.localEulerAngles = var_339_3.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				var_339_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_339_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_3.position).x, (manager.ui.mainCamera.transform.position - var_339_3.position).y, (manager.ui.mainCamera.transform.position - var_339_3.position).z)
				var_339_3.localEulerAngles.z = 0
				var_339_3.localEulerAngles.x = 0
				var_339_3.localEulerAngles = var_339_3.localEulerAngles
			end

			local var_339_5 = arg_336_1.actors_["1199ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.characterEffect1199ui_story == nil then
				arg_336_1.var_.characterEffect1199ui_story = var_339_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_6 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_6 and not isNil(var_339_5) then
				if arg_336_1.var_.characterEffect1199ui_story and not isNil(var_339_5) then
					arg_336_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_6 and arg_336_1.time_ < 0 + var_339_6 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.characterEffect1199ui_story then
				arg_336_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_339_8 = 0
			local var_339_9 = 0.975

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_10 = arg_336_1:GetWordFromCfg(123011080)
				local var_339_11 = arg_336_1:FormatText(var_339_10.content)

				arg_336_1.text_.text = var_339_11

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_13 = 39 <= 0 and var_339_9 or var_339_9 * (utf8.len(var_339_11) / 39)

				if (39 <= 0 and var_339_9 or var_339_9 * (utf8.len(var_339_11) / 39)) > 0 and var_339_9 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_8
					end
				end

				arg_336_1.text_.text = var_339_11
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011080", "story_v_out_123011.awb") ~= 0 then
					local var_339_14 = manager.audio:GetVoiceLength("story_v_out_123011", "123011080", "story_v_out_123011.awb") / 1000

					if var_339_14 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_8
					end

					if var_339_10.prefab_name ~= "" and arg_336_1.actors_[var_339_10.prefab_name] ~= nil then
						local var_339_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_10.prefab_name].transform, "story_v_out_123011", "123011080", "story_v_out_123011.awb")

						arg_336_1:RecordAudio("123011080", var_339_15)
						arg_336_1:RecordAudio("123011080", var_339_15)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_123011", "123011080", "story_v_out_123011.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_123011", "123011080", "story_v_out_123011.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_9, arg_336_1.talkMaxDuration)

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_8) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_8 + var_339_16 and arg_336_1.time_ < var_339_8 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play123011081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 123011081
		arg_340_1.duration_ = 2.9

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play123011082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.375

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:GetWordFromCfg(123011081)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 15 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 15)

				if (15 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 15)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011081", "story_v_out_123011.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011081", "story_v_out_123011.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_out_123011", "123011081", "story_v_out_123011.awb")

						arg_340_1:RecordAudio("123011081", var_343_6)
						arg_340_1:RecordAudio("123011081", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_123011", "123011081", "story_v_out_123011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_123011", "123011081", "story_v_out_123011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play123011082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 123011082
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play123011083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1199ui_story"]) and arg_344_1.var_.characterEffect1199ui_story == nil then
				arg_344_1.var_.characterEffect1199ui_story = arg_344_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1199ui_story"]) then
				if arg_344_1.var_.characterEffect1199ui_story and not isNil(arg_344_1.actors_["1199ui_story"]) then
					arg_344_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_0)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1199ui_story"]) and arg_344_1.var_.characterEffect1199ui_story then
				arg_344_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_347_1 = 0
			local var_347_2 = 0.825

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(123011082).content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 33 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 33)

				if (33 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 33)) > 0 and var_347_2 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_6 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_6 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_6

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_6 and arg_344_1.time_ < var_347_1 + var_347_6 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play123011083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 123011083
		arg_348_1.duration_ = 8.3

		local var_348_0 = {
			zh = 7.033,
			ja = 8.3
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play123011084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.8

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[478].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_1 = arg_348_1:GetWordFromCfg(123011083)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 32 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 32)

				if (32 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 32)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011083", "story_v_out_123011.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011083", "story_v_out_123011.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_123011", "123011083", "story_v_out_123011.awb")

						arg_348_1:RecordAudio("123011083", var_351_6)
						arg_348_1:RecordAudio("123011083", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_123011", "123011083", "story_v_out_123011.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_123011", "123011083", "story_v_out_123011.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play123011084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 123011084
		arg_352_1.duration_ = 2

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play123011085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1199ui_story"]) and arg_352_1.var_.characterEffect1199ui_story == nil then
				arg_352_1.var_.characterEffect1199ui_story = arg_352_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1199ui_story"]) then
				if arg_352_1.var_.characterEffect1199ui_story and not isNil(arg_352_1.actors_["1199ui_story"]) then
					arg_352_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1199ui_story"]) and arg_352_1.var_.characterEffect1199ui_story then
				arg_352_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_355_2 = 0
			local var_355_3 = 0.175

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_2 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_4 = arg_352_1:GetWordFromCfg(123011084)
				local var_355_5 = arg_352_1:FormatText(var_355_4.content)

				arg_352_1.text_.text = var_355_5

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_7 = 7 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 7)

				if (7 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 7)) > 0 and var_355_3 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_2
					end
				end

				arg_352_1.text_.text = var_355_5
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011084", "story_v_out_123011.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011084", "story_v_out_123011.awb") / 1000

					if var_355_8 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_2
					end

					if var_355_4.prefab_name ~= "" and arg_352_1.actors_[var_355_4.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_4.prefab_name].transform, "story_v_out_123011", "123011084", "story_v_out_123011.awb")

						arg_352_1:RecordAudio("123011084", var_355_9)
						arg_352_1:RecordAudio("123011084", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_123011", "123011084", "story_v_out_123011.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_123011", "123011084", "story_v_out_123011.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_3, arg_352_1.talkMaxDuration)

			if var_355_2 <= arg_352_1.time_ and arg_352_1.time_ < var_355_2 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_2) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_2 + var_355_10 and arg_352_1.time_ < var_355_2 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play123011085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 123011085
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play123011086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1199ui_story"]) and arg_356_1.var_.characterEffect1199ui_story == nil then
				arg_356_1.var_.characterEffect1199ui_story = arg_356_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1199ui_story"]) then
				if arg_356_1.var_.characterEffect1199ui_story and not isNil(arg_356_1.actors_["1199ui_story"]) then
					arg_356_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_356_1.time_ - 0) / var_359_0)
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1199ui_story"]) and arg_356_1.var_.characterEffect1199ui_story then
				arg_356_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_whoosh_draw", "")
			end

			local var_359_2 = 0
			local var_359_3 = 0.5

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(123011085).content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_6 = 20 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_4) / 20)

				if (20 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_4) / 20)) > 0 and var_359_3 < var_359_6 then
					arg_356_1.talkMaxDuration = var_359_6

					if var_359_6 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_6 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_7 and arg_356_1.time_ < var_359_2 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play123011086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 123011086
		arg_360_1.duration_ = 3.73

		local var_360_0 = {
			zh = 2.1,
			ja = 3.733
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play123011087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.275

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[478].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_1 = arg_360_1:GetWordFromCfg(123011086)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 11 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 11)

				if (11 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 11)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011086", "story_v_out_123011.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011086", "story_v_out_123011.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_out_123011", "123011086", "story_v_out_123011.awb")

						arg_360_1:RecordAudio("123011086", var_363_6)
						arg_360_1:RecordAudio("123011086", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_123011", "123011086", "story_v_out_123011.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_123011", "123011086", "story_v_out_123011.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play123011087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 123011087
		arg_364_1.duration_ = 2.03

		local var_364_0 = {
			zh = 2.033,
			ja = 1.999999999999
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play123011088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["1199ui_story"]) and arg_364_1.var_.characterEffect1199ui_story == nil then
				arg_364_1.var_.characterEffect1199ui_story = arg_364_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_0 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["1199ui_story"]) then
				if arg_364_1.var_.characterEffect1199ui_story and not isNil(arg_364_1.actors_["1199ui_story"]) then
					arg_364_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["1199ui_story"]) and arg_364_1.var_.characterEffect1199ui_story then
				arg_364_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action446")
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_367_2 = 0
			local var_367_3 = 0.3

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_2 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:GetWordFromCfg(123011087)
				local var_367_5 = arg_364_1:FormatText(var_367_4.content)

				arg_364_1.text_.text = var_367_5

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_7 = 12 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 12)

				if (12 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 12)) > 0 and var_367_3 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_2
					end
				end

				arg_364_1.text_.text = var_367_5
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011087", "story_v_out_123011.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011087", "story_v_out_123011.awb") / 1000

					if var_367_8 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_2
					end

					if var_367_4.prefab_name ~= "" and arg_364_1.actors_[var_367_4.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_4.prefab_name].transform, "story_v_out_123011", "123011087", "story_v_out_123011.awb")

						arg_364_1:RecordAudio("123011087", var_367_9)
						arg_364_1:RecordAudio("123011087", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_123011", "123011087", "story_v_out_123011.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_123011", "123011087", "story_v_out_123011.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_3, arg_364_1.talkMaxDuration)

			if var_367_2 <= arg_364_1.time_ and arg_364_1.time_ < var_367_2 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_2) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_2 + var_367_10 and arg_364_1.time_ < var_367_2 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play123011088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 123011088
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play123011089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["1199ui_story"]) and arg_368_1.var_.characterEffect1199ui_story == nil then
				arg_368_1.var_.characterEffect1199ui_story = arg_368_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_0 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["1199ui_story"]) then
				if arg_368_1.var_.characterEffect1199ui_story and not isNil(arg_368_1.actors_["1199ui_story"]) then
					arg_368_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_368_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_368_1.time_ - 0) / var_371_0)
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["1199ui_story"]) and arg_368_1.var_.characterEffect1199ui_story then
				arg_368_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_368_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_371_1 = 0
			local var_371_2 = 0.575

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(123011088).content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 23)

				if (23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 23)) > 0 and var_371_2 < var_371_5 then
					arg_368_1.talkMaxDuration = var_371_5

					if var_371_5 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_6 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_6 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_6

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_6 and arg_368_1.time_ < var_371_1 + var_371_6 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play123011089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 123011089
		arg_372_1.duration_ = 6.53

		local var_372_0 = {
			zh = 3.966,
			ja = 6.533
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play123011090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.45

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[478].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_1 = arg_372_1:GetWordFromCfg(123011089)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.text_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 18 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 18)

				if (18 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 18)) > 0 and var_375_0 < var_375_4 then
					arg_372_1.talkMaxDuration = var_375_4

					if var_375_4 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_4 + 0
					end
				end

				arg_372_1.text_.text = var_375_2
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011089", "story_v_out_123011.awb") ~= 0 then
					local var_375_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011089", "story_v_out_123011.awb") / 1000

					if var_375_5 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + 0
					end

					if var_375_1.prefab_name ~= "" and arg_372_1.actors_[var_375_1.prefab_name] ~= nil then
						local var_375_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_1.prefab_name].transform, "story_v_out_123011", "123011089", "story_v_out_123011.awb")

						arg_372_1:RecordAudio("123011089", var_375_6)
						arg_372_1:RecordAudio("123011089", var_375_6)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_123011", "123011089", "story_v_out_123011.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_123011", "123011089", "story_v_out_123011.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_7 and arg_372_1.time_ < 0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play123011090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 123011090
		arg_376_1.duration_ = 3.6

		local var_376_0 = {
			zh = 2.666,
			ja = 3.6
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play123011091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1199ui_story = arg_376_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1199ui_story"].transform.position).z)
				arg_376_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1199ui_story"].transform.localEulerAngles = arg_376_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_376_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1199ui_story"].transform.position).z)
				arg_376_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1199ui_story"].transform.localEulerAngles = arg_376_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_379_1 = arg_376_1.actors_["1199ui_story"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1199ui_story == nil then
				arg_376_1.var_.characterEffect1199ui_story = var_379_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_2 and not isNil(var_379_1) then
				if arg_376_1.var_.characterEffect1199ui_story and not isNil(var_379_1) then
					arg_376_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_2 and arg_376_1.time_ < 0 + var_379_2 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1199ui_story then
				arg_376_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_2")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_379_4 = 0
			local var_379_5 = 0.2

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_6 = arg_376_1:GetWordFromCfg(123011090)
				local var_379_7 = arg_376_1:FormatText(var_379_6.content)

				arg_376_1.text_.text = var_379_7

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_9 = 8 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 8)

				if (8 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 8)) > 0 and var_379_5 < var_379_9 then
					arg_376_1.talkMaxDuration = var_379_9

					if var_379_9 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_9 + var_379_4
					end
				end

				arg_376_1.text_.text = var_379_7
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011090", "story_v_out_123011.awb") ~= 0 then
					local var_379_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011090", "story_v_out_123011.awb") / 1000

					if var_379_10 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_4
					end

					if var_379_6.prefab_name ~= "" and arg_376_1.actors_[var_379_6.prefab_name] ~= nil then
						local var_379_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_6.prefab_name].transform, "story_v_out_123011", "123011090", "story_v_out_123011.awb")

						arg_376_1:RecordAudio("123011090", var_379_11)
						arg_376_1:RecordAudio("123011090", var_379_11)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_123011", "123011090", "story_v_out_123011.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_123011", "123011090", "story_v_out_123011.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_12 = math.max(var_379_5, arg_376_1.talkMaxDuration)

			if var_379_4 <= arg_376_1.time_ and arg_376_1.time_ < var_379_4 + var_379_12 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_4) / var_379_12

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_4 + var_379_12 and arg_376_1.time_ < var_379_4 + var_379_12 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play123011091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 123011091
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play123011092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1199ui_story"]) and arg_380_1.var_.characterEffect1199ui_story == nil then
				arg_380_1.var_.characterEffect1199ui_story = arg_380_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1199ui_story"]) then
				if arg_380_1.var_.characterEffect1199ui_story and not isNil(arg_380_1.actors_["1199ui_story"]) then
					arg_380_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1199ui_story"]) and arg_380_1.var_.characterEffect1199ui_story then
				arg_380_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_383_1 = arg_380_1.actors_["1199ui_story"].transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1199ui_story = var_383_1.localPosition
			end

			local var_383_2 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_2 then
				var_383_1.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_380_1.time_ - 0) / var_383_2)
				var_383_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_1.position).x, (manager.ui.mainCamera.transform.position - var_383_1.position).y, (manager.ui.mainCamera.transform.position - var_383_1.position).z)
				var_383_1.localEulerAngles.z = 0
				var_383_1.localEulerAngles.x = 0
				var_383_1.localEulerAngles = var_383_1.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_2 and arg_380_1.time_ < 0 + var_383_2 + arg_383_0 then
				var_383_1.localPosition = Vector3.New(0, 100, 0)
				var_383_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_1.position).x, (manager.ui.mainCamera.transform.position - var_383_1.position).y, (manager.ui.mainCamera.transform.position - var_383_1.position).z)
				var_383_1.localEulerAngles.z = 0
				var_383_1.localEulerAngles.x = 0
				var_383_1.localEulerAngles = var_383_1.localEulerAngles
			end

			local var_383_3 = manager.ui.mainCamera.transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.shakeOldPos = var_383_3.localPosition
			end

			local var_383_4 = 0.6

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				local var_383_5, var_383_6 = math.modf((arg_380_1.time_ - 0) / 0.066)

				var_383_3.localPosition = Vector3.New(var_383_6 * 0.13, var_383_6 * 0.13, var_383_6 * 0.13) + arg_380_1.var_.shakeOldPos
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				var_383_3.localPosition = arg_380_1.var_.shakeOldPos
			end

			local var_383_7 = 0

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_7 + arg_383_0 then
				arg_380_1.allBtn_.enabled = false
			end

			if arg_380_1.time_ >= var_383_7 + 0.6 and arg_380_1.time_ < var_383_7 + 0.6 + arg_383_0 then
				arg_380_1.allBtn_.enabled = true
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_crake", "")
			end

			local var_383_9 = 0
			local var_383_10 = 1.2

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_9 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_11 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(123011091).content)

				arg_380_1.text_.text = var_383_11

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_13 = 48 <= 0 and var_383_10 or var_383_10 * (utf8.len(var_383_11) / 48)

				if (48 <= 0 and var_383_10 or var_383_10 * (utf8.len(var_383_11) / 48)) > 0 and var_383_10 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_9 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_9
					end
				end

				arg_380_1.text_.text = var_383_11
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_14 = math.max(var_383_10, arg_380_1.talkMaxDuration)

			if var_383_9 <= arg_380_1.time_ and arg_380_1.time_ < var_383_9 + var_383_14 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_9) / var_383_14

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_9 + var_383_14 and arg_380_1.time_ < var_383_9 + var_383_14 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play123011092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 123011092
		arg_384_1.duration_ = 3.17

		local var_384_0 = {
			zh = 3.166,
			ja = 2.9
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play123011093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos1199ui_story = arg_384_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1199ui_story"].transform.position).z)
				arg_384_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1199ui_story"].transform.localEulerAngles = arg_384_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_384_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1199ui_story"].transform.position).z)
				arg_384_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1199ui_story"].transform.localEulerAngles = arg_384_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_387_1 = arg_384_1.actors_["1199ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1199ui_story == nil then
				arg_384_1.var_.characterEffect1199ui_story = var_387_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_2 and not isNil(var_387_1) then
				if arg_384_1.var_.characterEffect1199ui_story and not isNil(var_387_1) then
					arg_384_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_2 and arg_384_1.time_ < 0 + var_387_2 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1199ui_story then
				arg_384_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_387_4 = 0
			local var_387_5 = 0.25

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_6 = arg_384_1:GetWordFromCfg(123011092)
				local var_387_7 = arg_384_1:FormatText(var_387_6.content)

				arg_384_1.text_.text = var_387_7

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_9 = 10 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 10)

				if (10 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 10)) > 0 and var_387_5 < var_387_9 then
					arg_384_1.talkMaxDuration = var_387_9

					if var_387_9 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_9 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_7
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011092", "story_v_out_123011.awb") ~= 0 then
					local var_387_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011092", "story_v_out_123011.awb") / 1000

					if var_387_10 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_4
					end

					if var_387_6.prefab_name ~= "" and arg_384_1.actors_[var_387_6.prefab_name] ~= nil then
						local var_387_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_6.prefab_name].transform, "story_v_out_123011", "123011092", "story_v_out_123011.awb")

						arg_384_1:RecordAudio("123011092", var_387_11)
						arg_384_1:RecordAudio("123011092", var_387_11)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_123011", "123011092", "story_v_out_123011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_123011", "123011092", "story_v_out_123011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_12 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_12 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_12

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_12 and arg_384_1.time_ < var_387_4 + var_387_12 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play123011093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 123011093
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play123011094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1199ui_story"]) and arg_388_1.var_.characterEffect1199ui_story == nil then
				arg_388_1.var_.characterEffect1199ui_story = arg_388_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1199ui_story"]) then
				if arg_388_1.var_.characterEffect1199ui_story and not isNil(arg_388_1.actors_["1199ui_story"]) then
					arg_388_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_0)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1199ui_story"]) and arg_388_1.var_.characterEffect1199ui_story then
				arg_388_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_391_1 = 0
			local var_391_2 = 0.3

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_3 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(123011093).content)

				arg_388_1.text_.text = var_391_3

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 12 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 12)

				if (12 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 12)) > 0 and var_391_2 < var_391_5 then
					arg_388_1.talkMaxDuration = var_391_5

					if var_391_5 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + var_391_1
					end
				end

				arg_388_1.text_.text = var_391_3
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_6 = math.max(var_391_2, arg_388_1.talkMaxDuration)

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_6 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_1) / var_391_6

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_1 + var_391_6 and arg_388_1.time_ < var_391_1 + var_391_6 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play123011094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 123011094
		arg_392_1.duration_ = 12.3

		local var_392_0 = {
			zh = 6.633,
			ja = 12.3
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play123011095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1199ui_story"]) and arg_392_1.var_.characterEffect1199ui_story == nil then
				arg_392_1.var_.characterEffect1199ui_story = arg_392_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1199ui_story"]) then
				if arg_392_1.var_.characterEffect1199ui_story and not isNil(arg_392_1.actors_["1199ui_story"]) then
					arg_392_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1199ui_story"]) and arg_392_1.var_.characterEffect1199ui_story then
				arg_392_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_395_2 = 0
			local var_395_3 = 0.8

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_2 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_4 = arg_392_1:GetWordFromCfg(123011094)
				local var_395_5 = arg_392_1:FormatText(var_395_4.content)

				arg_392_1.text_.text = var_395_5

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_7 = 32 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_5) / 32)

				if (32 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_5) / 32)) > 0 and var_395_3 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_2 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_2
					end
				end

				arg_392_1.text_.text = var_395_5
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011094", "story_v_out_123011.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011094", "story_v_out_123011.awb") / 1000

					if var_395_8 + var_395_2 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_2
					end

					if var_395_4.prefab_name ~= "" and arg_392_1.actors_[var_395_4.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_4.prefab_name].transform, "story_v_out_123011", "123011094", "story_v_out_123011.awb")

						arg_392_1:RecordAudio("123011094", var_395_9)
						arg_392_1:RecordAudio("123011094", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_123011", "123011094", "story_v_out_123011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_123011", "123011094", "story_v_out_123011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_3, arg_392_1.talkMaxDuration)

			if var_395_2 <= arg_392_1.time_ and arg_392_1.time_ < var_395_2 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_2) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_2 + var_395_10 and arg_392_1.time_ < var_395_2 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play123011095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 123011095
		arg_396_1.duration_ = 8.47

		local var_396_0 = {
			zh = 8.2,
			ja = 8.466
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play123011096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if arg_396_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_399_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_396_1.stage_.transform)

				var_399_0.name = "1029ui_story"
				var_399_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_396_1.actors_["1029ui_story"] = var_399_0

				local var_399_1 = var_399_0:GetComponentInChildren(typeof(CharacterEffect))

				var_399_1.enabled = true

				local var_399_2 = GameObjectTools.GetOrAddComponent(var_399_0, typeof(DynamicBoneHelper))

				if var_399_2 then
					var_399_2:EnableDynamicBone(false)
				end

				arg_396_1:ShowWeapon(var_399_1.transform, false)

				arg_396_1.var_["1029ui_story" .. "Animator"] = var_399_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_396_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_396_1.var_["1029ui_story" .. "LipSync"] = var_399_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_399_3 = arg_396_1.actors_["1029ui_story"].transform

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos1029ui_story = var_399_3.localPosition
			end

			local var_399_4 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_4 then
				var_399_3.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_396_1.time_ - 0) / var_399_4)
				var_399_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_3.position).x, (manager.ui.mainCamera.transform.position - var_399_3.position).y, (manager.ui.mainCamera.transform.position - var_399_3.position).z)
				var_399_3.localEulerAngles.z = 0
				var_399_3.localEulerAngles.x = 0
				var_399_3.localEulerAngles = var_399_3.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_4 and arg_396_1.time_ < 0 + var_399_4 + arg_399_0 then
				var_399_3.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				var_399_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_3.position).x, (manager.ui.mainCamera.transform.position - var_399_3.position).y, (manager.ui.mainCamera.transform.position - var_399_3.position).z)
				var_399_3.localEulerAngles.z = 0
				var_399_3.localEulerAngles.x = 0
				var_399_3.localEulerAngles = var_399_3.localEulerAngles
			end

			local var_399_5 = arg_396_1.actors_["1029ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_5) and arg_396_1.var_.characterEffect1029ui_story == nil then
				arg_396_1.var_.characterEffect1029ui_story = var_399_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_6 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_6 and not isNil(var_399_5) then
				if arg_396_1.var_.characterEffect1029ui_story and not isNil(var_399_5) then
					arg_396_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= 0 + var_399_6 and arg_396_1.time_ < 0 + var_399_6 + arg_399_0 and not isNil(var_399_5) and arg_396_1.var_.characterEffect1029ui_story then
				arg_396_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_399_8 = arg_396_1.actors_["1199ui_story"].transform

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos1199ui_story = var_399_8.localPosition
			end

			local var_399_9 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_9 then
				var_399_8.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_396_1.time_ - 0) / var_399_9)
				var_399_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_8.position).x, (manager.ui.mainCamera.transform.position - var_399_8.position).y, (manager.ui.mainCamera.transform.position - var_399_8.position).z)
				var_399_8.localEulerAngles.z = 0
				var_399_8.localEulerAngles.x = 0
				var_399_8.localEulerAngles = var_399_8.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_9 and arg_396_1.time_ < 0 + var_399_9 + arg_399_0 then
				var_399_8.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_399_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_8.position).x, (manager.ui.mainCamera.transform.position - var_399_8.position).y, (manager.ui.mainCamera.transform.position - var_399_8.position).z)
				var_399_8.localEulerAngles.z = 0
				var_399_8.localEulerAngles.x = 0
				var_399_8.localEulerAngles = var_399_8.localEulerAngles
			end

			local var_399_10 = arg_396_1.actors_["1199ui_story"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_10) and arg_396_1.var_.characterEffect1199ui_story == nil then
				arg_396_1.var_.characterEffect1199ui_story = var_399_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_11 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_11 and not isNil(var_399_10) then
				if arg_396_1.var_.characterEffect1199ui_story and not isNil(var_399_10) then
					arg_396_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_11)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_11 and arg_396_1.time_ < 0 + var_399_11 + arg_399_0 and not isNil(var_399_10) and arg_396_1.var_.characterEffect1199ui_story then
				arg_396_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				if arg_396_1.var_.characterEffect1029ui_story == nil then
					arg_396_1.var_.characterEffect1029ui_story = arg_396_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_399_12 = arg_396_1.var_.characterEffect1029ui_story

				arg_396_1.var_.characterEffect1029ui_story.imageEffect:turnOff()

				var_399_12.interferenceEffect.enabled = true
				var_399_12.interferenceEffect.noise = 0.001
				var_399_12.interferenceEffect.simTimeScale = 1
				var_399_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				if arg_396_1.var_.characterEffect1029ui_story == nil then
					arg_396_1.var_.characterEffect1029ui_story = arg_396_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_396_1.var_.characterEffect1029ui_story.imageEffect:turnOn(false)
			end

			local var_399_14 = 0
			local var_399_15 = 0.825

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_14 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_16 = arg_396_1:GetWordFromCfg(123011095)
				local var_399_17 = arg_396_1:FormatText(var_399_16.content)

				arg_396_1.text_.text = var_399_17

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_19 = 33 <= 0 and var_399_15 or var_399_15 * (utf8.len(var_399_17) / 33)

				if (33 <= 0 and var_399_15 or var_399_15 * (utf8.len(var_399_17) / 33)) > 0 and var_399_15 < var_399_19 then
					arg_396_1.talkMaxDuration = var_399_19

					if var_399_19 + var_399_14 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_19 + var_399_14
					end
				end

				arg_396_1.text_.text = var_399_17
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011095", "story_v_out_123011.awb") ~= 0 then
					local var_399_20 = manager.audio:GetVoiceLength("story_v_out_123011", "123011095", "story_v_out_123011.awb") / 1000

					if var_399_20 + var_399_14 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_20 + var_399_14
					end

					if var_399_16.prefab_name ~= "" and arg_396_1.actors_[var_399_16.prefab_name] ~= nil then
						local var_399_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_16.prefab_name].transform, "story_v_out_123011", "123011095", "story_v_out_123011.awb")

						arg_396_1:RecordAudio("123011095", var_399_21)
						arg_396_1:RecordAudio("123011095", var_399_21)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_123011", "123011095", "story_v_out_123011.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_123011", "123011095", "story_v_out_123011.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_22 = math.max(var_399_15, arg_396_1.talkMaxDuration)

			if var_399_14 <= arg_396_1.time_ and arg_396_1.time_ < var_399_14 + var_399_22 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_14) / var_399_22

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_14 + var_399_22 and arg_396_1.time_ < var_399_14 + var_399_22 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play123011096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 123011096
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play123011097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["1029ui_story"]) and arg_400_1.var_.characterEffect1029ui_story == nil then
				arg_400_1.var_.characterEffect1029ui_story = arg_400_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["1029ui_story"]) then
				if arg_400_1.var_.characterEffect1029ui_story and not isNil(arg_400_1.actors_["1029ui_story"]) then
					arg_400_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 0) / var_403_0)
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["1029ui_story"]) and arg_400_1.var_.characterEffect1029ui_story then
				arg_400_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_403_2 = 0
			local var_403_3 = 0.55

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_4 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(123011096).content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_6 = 22 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_4) / 22)

				if (22 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_4) / 22)) > 0 and var_403_3 < var_403_6 then
					arg_400_1.talkMaxDuration = var_403_6

					if var_403_6 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_6 + var_403_2
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_3, arg_400_1.talkMaxDuration)

			if var_403_2 <= arg_400_1.time_ and arg_400_1.time_ < var_403_2 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_2) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_2 + var_403_7 and arg_400_1.time_ < var_403_2 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play123011097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 123011097
		arg_404_1.duration_ = 5.83

		local var_404_0 = {
			zh = 3.6,
			ja = 5.833
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
				arg_404_0:Play123011098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1029ui_story = arg_404_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1029ui_story"].transform.position).z)
				arg_404_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1029ui_story"].transform.localEulerAngles = arg_404_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				arg_404_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1029ui_story"].transform.position).z)
				arg_404_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1029ui_story"].transform.localEulerAngles = arg_404_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1029ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1029ui_story == nil then
				arg_404_1.var_.characterEffect1029ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1029ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_2)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1029ui_story then
				arg_404_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_407_3 = arg_404_1.actors_["1199ui_story"].transform

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1199ui_story = var_407_3.localPosition
			end

			local var_407_4 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_4 then
				var_407_3.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_404_1.time_ - 0) / var_407_4)
				var_407_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_3.position).x, (manager.ui.mainCamera.transform.position - var_407_3.position).y, (manager.ui.mainCamera.transform.position - var_407_3.position).z)
				var_407_3.localEulerAngles.z = 0
				var_407_3.localEulerAngles.x = 0
				var_407_3.localEulerAngles = var_407_3.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_4 and arg_404_1.time_ < 0 + var_407_4 + arg_407_0 then
				var_407_3.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_407_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_3.position).x, (manager.ui.mainCamera.transform.position - var_407_3.position).y, (manager.ui.mainCamera.transform.position - var_407_3.position).z)
				var_407_3.localEulerAngles.z = 0
				var_407_3.localEulerAngles.x = 0
				var_407_3.localEulerAngles = var_407_3.localEulerAngles
			end

			local var_407_5 = arg_404_1.actors_["1199ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_5) and arg_404_1.var_.characterEffect1199ui_story == nil then
				arg_404_1.var_.characterEffect1199ui_story = var_407_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_6 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_6 and not isNil(var_407_5) then
				if arg_404_1.var_.characterEffect1199ui_story and not isNil(var_407_5) then
					arg_404_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_6 and arg_404_1.time_ < 0 + var_407_6 + arg_407_0 and not isNil(var_407_5) and arg_404_1.var_.characterEffect1199ui_story then
				arg_404_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_407_8 = 0
			local var_407_9 = 0.425

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_8 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_10 = arg_404_1:GetWordFromCfg(123011097)
				local var_407_11 = arg_404_1:FormatText(var_407_10.content)

				arg_404_1.text_.text = var_407_11

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_13 = 17 <= 0 and var_407_9 or var_407_9 * (utf8.len(var_407_11) / 17)

				if (17 <= 0 and var_407_9 or var_407_9 * (utf8.len(var_407_11) / 17)) > 0 and var_407_9 < var_407_13 then
					arg_404_1.talkMaxDuration = var_407_13

					if var_407_13 + var_407_8 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_13 + var_407_8
					end
				end

				arg_404_1.text_.text = var_407_11
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011097", "story_v_out_123011.awb") ~= 0 then
					local var_407_14 = manager.audio:GetVoiceLength("story_v_out_123011", "123011097", "story_v_out_123011.awb") / 1000

					if var_407_14 + var_407_8 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_14 + var_407_8
					end

					if var_407_10.prefab_name ~= "" and arg_404_1.actors_[var_407_10.prefab_name] ~= nil then
						local var_407_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_10.prefab_name].transform, "story_v_out_123011", "123011097", "story_v_out_123011.awb")

						arg_404_1:RecordAudio("123011097", var_407_15)
						arg_404_1:RecordAudio("123011097", var_407_15)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_123011", "123011097", "story_v_out_123011.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_123011", "123011097", "story_v_out_123011.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_16 = math.max(var_407_9, arg_404_1.talkMaxDuration)

			if var_407_8 <= arg_404_1.time_ and arg_404_1.time_ < var_407_8 + var_407_16 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_8) / var_407_16

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_8 + var_407_16 and arg_404_1.time_ < var_407_8 + var_407_16 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play123011098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 123011098
		arg_408_1.duration_ = 8.97

		local var_408_0 = {
			zh = 8.966,
			ja = 7.366
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play123011099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["1199ui_story"]) and arg_408_1.var_.characterEffect1199ui_story == nil then
				arg_408_1.var_.characterEffect1199ui_story = arg_408_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_0 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["1199ui_story"]) then
				if arg_408_1.var_.characterEffect1199ui_story and not isNil(arg_408_1.actors_["1199ui_story"]) then
					arg_408_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_0)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["1199ui_story"]) and arg_408_1.var_.characterEffect1199ui_story then
				arg_408_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_411_1 = arg_408_1.actors_["1029ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1029ui_story == nil then
				arg_408_1.var_.characterEffect1029ui_story = var_411_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_2 and not isNil(var_411_1) then
				if arg_408_1.var_.characterEffect1029ui_story and not isNil(var_411_1) then
					arg_408_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= 0 + var_411_2 and arg_408_1.time_ < 0 + var_411_2 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect1029ui_story then
				arg_408_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_411_4 = 0
			local var_411_5 = 1.075

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_6 = arg_408_1:GetWordFromCfg(123011098)
				local var_411_7 = arg_408_1:FormatText(var_411_6.content)

				arg_408_1.text_.text = var_411_7

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_9 = 43 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 43)

				if (43 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 43)) > 0 and var_411_5 < var_411_9 then
					arg_408_1.talkMaxDuration = var_411_9

					if var_411_9 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_9 + var_411_4
					end
				end

				arg_408_1.text_.text = var_411_7
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011098", "story_v_out_123011.awb") ~= 0 then
					local var_411_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011098", "story_v_out_123011.awb") / 1000

					if var_411_10 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_4
					end

					if var_411_6.prefab_name ~= "" and arg_408_1.actors_[var_411_6.prefab_name] ~= nil then
						local var_411_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_6.prefab_name].transform, "story_v_out_123011", "123011098", "story_v_out_123011.awb")

						arg_408_1:RecordAudio("123011098", var_411_11)
						arg_408_1:RecordAudio("123011098", var_411_11)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_123011", "123011098", "story_v_out_123011.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_123011", "123011098", "story_v_out_123011.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_12 = math.max(var_411_5, arg_408_1.talkMaxDuration)

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_12 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_4) / var_411_12

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_4 + var_411_12 and arg_408_1.time_ < var_411_4 + var_411_12 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play123011099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 123011099
		arg_412_1.duration_ = 4.9

		local var_412_0 = {
			zh = 4.2,
			ja = 4.9
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play123011100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["1199ui_story"]) and arg_412_1.var_.characterEffect1199ui_story == nil then
				arg_412_1.var_.characterEffect1199ui_story = arg_412_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_0 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["1199ui_story"]) then
				if arg_412_1.var_.characterEffect1199ui_story and not isNil(arg_412_1.actors_["1199ui_story"]) then
					arg_412_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["1199ui_story"]) and arg_412_1.var_.characterEffect1199ui_story then
				arg_412_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_415_2 = arg_412_1.actors_["1029ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.characterEffect1029ui_story == nil then
				arg_412_1.var_.characterEffect1029ui_story = var_415_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_3 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_3 and not isNil(var_415_2) then
				if arg_412_1.var_.characterEffect1029ui_story and not isNil(var_415_2) then
					arg_412_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_412_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_412_1.time_ - 0) / var_415_3)
				end
			end

			if arg_412_1.time_ >= 0 + var_415_3 and arg_412_1.time_ < 0 + var_415_3 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.characterEffect1029ui_story then
				arg_412_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_412_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_415_4 = 0
			local var_415_5 = 0.475

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_4 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_6 = arg_412_1:GetWordFromCfg(123011099)
				local var_415_7 = arg_412_1:FormatText(var_415_6.content)

				arg_412_1.text_.text = var_415_7

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_9 = 19 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 19)

				if (19 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 19)) > 0 and var_415_5 < var_415_9 then
					arg_412_1.talkMaxDuration = var_415_9

					if var_415_9 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_9 + var_415_4
					end
				end

				arg_412_1.text_.text = var_415_7
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011099", "story_v_out_123011.awb") ~= 0 then
					local var_415_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011099", "story_v_out_123011.awb") / 1000

					if var_415_10 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_10 + var_415_4
					end

					if var_415_6.prefab_name ~= "" and arg_412_1.actors_[var_415_6.prefab_name] ~= nil then
						local var_415_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_6.prefab_name].transform, "story_v_out_123011", "123011099", "story_v_out_123011.awb")

						arg_412_1:RecordAudio("123011099", var_415_11)
						arg_412_1:RecordAudio("123011099", var_415_11)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_123011", "123011099", "story_v_out_123011.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_123011", "123011099", "story_v_out_123011.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_12 = math.max(var_415_5, arg_412_1.talkMaxDuration)

			if var_415_4 <= arg_412_1.time_ and arg_412_1.time_ < var_415_4 + var_415_12 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_4) / var_415_12

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_4 + var_415_12 and arg_412_1.time_ < var_415_4 + var_415_12 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play123011100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 123011100
		arg_416_1.duration_ = 4

		local var_416_0 = {
			zh = 4,
			ja = 2
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play123011101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["1199ui_story"]) and arg_416_1.var_.characterEffect1199ui_story == nil then
				arg_416_1.var_.characterEffect1199ui_story = arg_416_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_0 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["1199ui_story"]) then
				if arg_416_1.var_.characterEffect1199ui_story and not isNil(arg_416_1.actors_["1199ui_story"]) then
					arg_416_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_416_1.time_ - 0) / var_419_0)
				end
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["1199ui_story"]) and arg_416_1.var_.characterEffect1199ui_story then
				arg_416_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_419_1 = arg_416_1.actors_["1199ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1199ui_story == nil then
				arg_416_1.var_.characterEffect1199ui_story = var_419_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_2 and not isNil(var_419_1) then
				if arg_416_1.var_.characterEffect1199ui_story and not isNil(var_419_1) then
					arg_416_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_416_1.time_ - 0) / var_419_2)
				end
			end

			if arg_416_1.time_ >= 0 + var_419_2 and arg_416_1.time_ < 0 + var_419_2 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1199ui_story then
				arg_416_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_419_3 = 0
			local var_419_4 = 0.3

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_3 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_5 = arg_416_1:GetWordFromCfg(123011100)
				local var_419_6 = arg_416_1:FormatText(var_419_5.content)

				arg_416_1.text_.text = var_419_6

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_8 = 12 <= 0 and var_419_4 or var_419_4 * (utf8.len(var_419_6) / 12)

				if (12 <= 0 and var_419_4 or var_419_4 * (utf8.len(var_419_6) / 12)) > 0 and var_419_4 < var_419_8 then
					arg_416_1.talkMaxDuration = var_419_8

					if var_419_8 + var_419_3 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_3
					end
				end

				arg_416_1.text_.text = var_419_6
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011100", "story_v_out_123011.awb") ~= 0 then
					local var_419_9 = manager.audio:GetVoiceLength("story_v_out_123011", "123011100", "story_v_out_123011.awb") / 1000

					if var_419_9 + var_419_3 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_9 + var_419_3
					end

					if var_419_5.prefab_name ~= "" and arg_416_1.actors_[var_419_5.prefab_name] ~= nil then
						local var_419_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_5.prefab_name].transform, "story_v_out_123011", "123011100", "story_v_out_123011.awb")

						arg_416_1:RecordAudio("123011100", var_419_10)
						arg_416_1:RecordAudio("123011100", var_419_10)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_123011", "123011100", "story_v_out_123011.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_123011", "123011100", "story_v_out_123011.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_11 = math.max(var_419_4, arg_416_1.talkMaxDuration)

			if var_419_3 <= arg_416_1.time_ and arg_416_1.time_ < var_419_3 + var_419_11 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_3) / var_419_11

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_3 + var_419_11 and arg_416_1.time_ < var_419_3 + var_419_11 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play123011101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 123011101
		arg_420_1.duration_ = 12.83

		local var_420_0 = {
			zh = 12.366,
			ja = 12.833
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play123011102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 1.5

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:GetWordFromCfg(123011101)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 60 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 60)

				if (60 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 60)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011101", "story_v_out_123011.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011101", "story_v_out_123011.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_out_123011", "123011101", "story_v_out_123011.awb")

						arg_420_1:RecordAudio("123011101", var_423_6)
						arg_420_1:RecordAudio("123011101", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_123011", "123011101", "story_v_out_123011.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_123011", "123011101", "story_v_out_123011.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play123011102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 123011102
		arg_424_1.duration_ = 2.33

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play123011103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1029ui_story = arg_424_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1029ui_story"].transform.position).z)
				arg_424_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1029ui_story"].transform.localEulerAngles = arg_424_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				arg_424_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1029ui_story"].transform.position).z)
				arg_424_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1029ui_story"].transform.localEulerAngles = arg_424_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["1029ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1029ui_story == nil then
				arg_424_1.var_.characterEffect1029ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 and not isNil(var_427_1) then
				if arg_424_1.var_.characterEffect1029ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_2)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1029ui_story then
				arg_424_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_427_3 = arg_424_1.actors_["1199ui_story"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1199ui_story = var_427_3.localPosition
			end

			local var_427_4 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				var_427_3.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_424_1.time_ - 0) / var_427_4)
				var_427_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_3.position).x, (manager.ui.mainCamera.transform.position - var_427_3.position).y, (manager.ui.mainCamera.transform.position - var_427_3.position).z)
				var_427_3.localEulerAngles.z = 0
				var_427_3.localEulerAngles.x = 0
				var_427_3.localEulerAngles = var_427_3.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				var_427_3.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_427_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_3.position).x, (manager.ui.mainCamera.transform.position - var_427_3.position).y, (manager.ui.mainCamera.transform.position - var_427_3.position).z)
				var_427_3.localEulerAngles.z = 0
				var_427_3.localEulerAngles.x = 0
				var_427_3.localEulerAngles = var_427_3.localEulerAngles
			end

			local var_427_5 = arg_424_1.actors_["1199ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_5) and arg_424_1.var_.characterEffect1199ui_story == nil then
				arg_424_1.var_.characterEffect1199ui_story = var_427_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_6 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_6 and not isNil(var_427_5) then
				if arg_424_1.var_.characterEffect1199ui_story and not isNil(var_427_5) then
					arg_424_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_6 and arg_424_1.time_ < 0 + var_427_6 + arg_427_0 and not isNil(var_427_5) and arg_424_1.var_.characterEffect1199ui_story then
				arg_424_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action436")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_427_8 = 0
			local var_427_9 = 0.125

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_10 = arg_424_1:GetWordFromCfg(123011102)
				local var_427_11 = arg_424_1:FormatText(var_427_10.content)

				arg_424_1.text_.text = var_427_11

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_13 = 5 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 5)

				if (5 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 5)) > 0 and var_427_9 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_11
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011102", "story_v_out_123011.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_123011", "123011102", "story_v_out_123011.awb") / 1000

					if var_427_14 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_8
					end

					if var_427_10.prefab_name ~= "" and arg_424_1.actors_[var_427_10.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_10.prefab_name].transform, "story_v_out_123011", "123011102", "story_v_out_123011.awb")

						arg_424_1:RecordAudio("123011102", var_427_15)
						arg_424_1:RecordAudio("123011102", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_123011", "123011102", "story_v_out_123011.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_123011", "123011102", "story_v_out_123011.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_9, arg_424_1.talkMaxDuration)

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_8) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_8 + var_427_16 and arg_424_1.time_ < var_427_8 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play123011103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 123011103
		arg_428_1.duration_ = 7.7

		local var_428_0 = {
			zh = 7.166,
			ja = 7.7
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play123011104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["1199ui_story"]) and arg_428_1.var_.characterEffect1199ui_story == nil then
				arg_428_1.var_.characterEffect1199ui_story = arg_428_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_0 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["1199ui_story"]) then
				if arg_428_1.var_.characterEffect1199ui_story and not isNil(arg_428_1.actors_["1199ui_story"]) then
					arg_428_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_0)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["1199ui_story"]) and arg_428_1.var_.characterEffect1199ui_story then
				arg_428_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_431_1 = arg_428_1.actors_["1029ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1029ui_story == nil then
				arg_428_1.var_.characterEffect1029ui_story = var_431_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_2 and not isNil(var_431_1) then
				if arg_428_1.var_.characterEffect1029ui_story and not isNil(var_431_1) then
					arg_428_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_2 and arg_428_1.time_ < 0 + var_431_2 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1029ui_story then
				arg_428_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_431_4 = 0
			local var_431_5 = 0.9

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_6 = arg_428_1:GetWordFromCfg(123011103)
				local var_431_7 = arg_428_1:FormatText(var_431_6.content)

				arg_428_1.text_.text = var_431_7

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_9 = 36 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_7) / 36)

				if (36 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_7) / 36)) > 0 and var_431_5 < var_431_9 then
					arg_428_1.talkMaxDuration = var_431_9

					if var_431_9 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_9 + var_431_4
					end
				end

				arg_428_1.text_.text = var_431_7
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011103", "story_v_out_123011.awb") ~= 0 then
					local var_431_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011103", "story_v_out_123011.awb") / 1000

					if var_431_10 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_10 + var_431_4
					end

					if var_431_6.prefab_name ~= "" and arg_428_1.actors_[var_431_6.prefab_name] ~= nil then
						local var_431_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_6.prefab_name].transform, "story_v_out_123011", "123011103", "story_v_out_123011.awb")

						arg_428_1:RecordAudio("123011103", var_431_11)
						arg_428_1:RecordAudio("123011103", var_431_11)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_123011", "123011103", "story_v_out_123011.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_123011", "123011103", "story_v_out_123011.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_12 = math.max(var_431_5, arg_428_1.talkMaxDuration)

			if var_431_4 <= arg_428_1.time_ and arg_428_1.time_ < var_431_4 + var_431_12 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_4) / var_431_12

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_4 + var_431_12 and arg_428_1.time_ < var_431_4 + var_431_12 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play123011104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 123011104
		arg_432_1.duration_ = 1.87

		local var_432_0 = {
			zh = 1.333,
			ja = 1.866
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play123011105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1199ui_story"]) and arg_432_1.var_.characterEffect1199ui_story == nil then
				arg_432_1.var_.characterEffect1199ui_story = arg_432_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1199ui_story"]) then
				if arg_432_1.var_.characterEffect1199ui_story and not isNil(arg_432_1.actors_["1199ui_story"]) then
					arg_432_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1199ui_story"]) and arg_432_1.var_.characterEffect1199ui_story then
				arg_432_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_435_2 = arg_432_1.actors_["1029ui_story"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.characterEffect1029ui_story == nil then
				arg_432_1.var_.characterEffect1029ui_story = var_435_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_3 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_3 and not isNil(var_435_2) then
				if arg_432_1.var_.characterEffect1029ui_story and not isNil(var_435_2) then
					arg_432_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_3)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_3 and arg_432_1.time_ < 0 + var_435_3 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.characterEffect1029ui_story then
				arg_432_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_435_4 = 0
			local var_435_5 = 0.2

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_6 = arg_432_1:GetWordFromCfg(123011104)
				local var_435_7 = arg_432_1:FormatText(var_435_6.content)

				arg_432_1.text_.text = var_435_7

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_9 = 8 <= 0 and var_435_5 or var_435_5 * (utf8.len(var_435_7) / 8)

				if (8 <= 0 and var_435_5 or var_435_5 * (utf8.len(var_435_7) / 8)) > 0 and var_435_5 < var_435_9 then
					arg_432_1.talkMaxDuration = var_435_9

					if var_435_9 + var_435_4 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_9 + var_435_4
					end
				end

				arg_432_1.text_.text = var_435_7
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011104", "story_v_out_123011.awb") ~= 0 then
					local var_435_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011104", "story_v_out_123011.awb") / 1000

					if var_435_10 + var_435_4 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_10 + var_435_4
					end

					if var_435_6.prefab_name ~= "" and arg_432_1.actors_[var_435_6.prefab_name] ~= nil then
						local var_435_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_6.prefab_name].transform, "story_v_out_123011", "123011104", "story_v_out_123011.awb")

						arg_432_1:RecordAudio("123011104", var_435_11)
						arg_432_1:RecordAudio("123011104", var_435_11)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_123011", "123011104", "story_v_out_123011.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_123011", "123011104", "story_v_out_123011.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_12 = math.max(var_435_5, arg_432_1.talkMaxDuration)

			if var_435_4 <= arg_432_1.time_ and arg_432_1.time_ < var_435_4 + var_435_12 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_4) / var_435_12

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_4 + var_435_12 and arg_432_1.time_ < var_435_4 + var_435_12 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play123011105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 123011105
		arg_436_1.duration_ = 5.53

		local var_436_0 = {
			zh = 4.5,
			ja = 5.533
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play123011106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["1029ui_story"]) and arg_436_1.var_.characterEffect1029ui_story == nil then
				arg_436_1.var_.characterEffect1029ui_story = arg_436_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["1029ui_story"]) then
				if arg_436_1.var_.characterEffect1029ui_story and not isNil(arg_436_1.actors_["1029ui_story"]) then
					arg_436_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["1029ui_story"]) and arg_436_1.var_.characterEffect1029ui_story then
				arg_436_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_439_2 = arg_436_1.actors_["1199ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.characterEffect1199ui_story == nil then
				arg_436_1.var_.characterEffect1199ui_story = var_439_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_3 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_3 and not isNil(var_439_2) then
				if arg_436_1.var_.characterEffect1199ui_story and not isNil(var_439_2) then
					arg_436_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_436_1.time_ - 0) / var_439_3)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_3 and arg_436_1.time_ < 0 + var_439_3 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.characterEffect1199ui_story then
				arg_436_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_439_4 = 0
			local var_439_5 = 0.575

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_6 = arg_436_1:GetWordFromCfg(123011105)
				local var_439_7 = arg_436_1:FormatText(var_439_6.content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 23 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 23)

				if (23 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 23)) > 0 and var_439_5 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011105", "story_v_out_123011.awb") ~= 0 then
					local var_439_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011105", "story_v_out_123011.awb") / 1000

					if var_439_10 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_4
					end

					if var_439_6.prefab_name ~= "" and arg_436_1.actors_[var_439_6.prefab_name] ~= nil then
						local var_439_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_6.prefab_name].transform, "story_v_out_123011", "123011105", "story_v_out_123011.awb")

						arg_436_1:RecordAudio("123011105", var_439_11)
						arg_436_1:RecordAudio("123011105", var_439_11)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_123011", "123011105", "story_v_out_123011.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_123011", "123011105", "story_v_out_123011.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_12 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_12 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_12

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_12 and arg_436_1.time_ < var_439_4 + var_439_12 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play123011106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 123011106
		arg_440_1.duration_ = 2

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play123011107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["1029ui_story"]) and arg_440_1.var_.characterEffect1029ui_story == nil then
				arg_440_1.var_.characterEffect1029ui_story = arg_440_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_0 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["1029ui_story"]) then
				if arg_440_1.var_.characterEffect1029ui_story and not isNil(arg_440_1.actors_["1029ui_story"]) then
					arg_440_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_0)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["1029ui_story"]) and arg_440_1.var_.characterEffect1029ui_story then
				arg_440_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_443_1 = arg_440_1.actors_["1199ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1199ui_story == nil then
				arg_440_1.var_.characterEffect1199ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect1199ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1199ui_story then
				arg_440_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action463")
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_443_4 = 0
			local var_443_5 = 0.175

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_6 = arg_440_1:GetWordFromCfg(123011106)
				local var_443_7 = arg_440_1:FormatText(var_443_6.content)

				arg_440_1.text_.text = var_443_7

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 7 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 7)

				if (7 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 7)) > 0 and var_443_5 < var_443_9 then
					arg_440_1.talkMaxDuration = var_443_9

					if var_443_9 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_9 + var_443_4
					end
				end

				arg_440_1.text_.text = var_443_7
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011106", "story_v_out_123011.awb") ~= 0 then
					local var_443_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011106", "story_v_out_123011.awb") / 1000

					if var_443_10 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_10 + var_443_4
					end

					if var_443_6.prefab_name ~= "" and arg_440_1.actors_[var_443_6.prefab_name] ~= nil then
						local var_443_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_6.prefab_name].transform, "story_v_out_123011", "123011106", "story_v_out_123011.awb")

						arg_440_1:RecordAudio("123011106", var_443_11)
						arg_440_1:RecordAudio("123011106", var_443_11)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_123011", "123011106", "story_v_out_123011.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_123011", "123011106", "story_v_out_123011.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_12 = math.max(var_443_5, arg_440_1.talkMaxDuration)

			if var_443_4 <= arg_440_1.time_ and arg_440_1.time_ < var_443_4 + var_443_12 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_4) / var_443_12

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_4 + var_443_12 and arg_440_1.time_ < var_443_4 + var_443_12 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play123011107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 123011107
		arg_444_1.duration_ = 7.17

		local var_444_0 = {
			zh = 4.7,
			ja = 7.166
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play123011108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["1029ui_story"]) and arg_444_1.var_.characterEffect1029ui_story == nil then
				arg_444_1.var_.characterEffect1029ui_story = arg_444_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["1029ui_story"]) then
				if arg_444_1.var_.characterEffect1029ui_story and not isNil(arg_444_1.actors_["1029ui_story"]) then
					arg_444_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["1029ui_story"]) and arg_444_1.var_.characterEffect1029ui_story then
				arg_444_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_447_2 = arg_444_1.actors_["1199ui_story"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.characterEffect1199ui_story == nil then
				arg_444_1.var_.characterEffect1199ui_story = var_447_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_3 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_3 and not isNil(var_447_2) then
				if arg_444_1.var_.characterEffect1199ui_story and not isNil(var_447_2) then
					arg_444_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_3)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_3 and arg_444_1.time_ < 0 + var_447_3 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.characterEffect1199ui_story then
				arg_444_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_447_4 = 0
			local var_447_5 = 0.525

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_4 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_6 = arg_444_1:GetWordFromCfg(123011107)
				local var_447_7 = arg_444_1:FormatText(var_447_6.content)

				arg_444_1.text_.text = var_447_7

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_9 = 21 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 21)

				if (21 <= 0 and var_447_5 or var_447_5 * (utf8.len(var_447_7) / 21)) > 0 and var_447_5 < var_447_9 then
					arg_444_1.talkMaxDuration = var_447_9

					if var_447_9 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_9 + var_447_4
					end
				end

				arg_444_1.text_.text = var_447_7
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011107", "story_v_out_123011.awb") ~= 0 then
					local var_447_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011107", "story_v_out_123011.awb") / 1000

					if var_447_10 + var_447_4 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_10 + var_447_4
					end

					if var_447_6.prefab_name ~= "" and arg_444_1.actors_[var_447_6.prefab_name] ~= nil then
						local var_447_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_6.prefab_name].transform, "story_v_out_123011", "123011107", "story_v_out_123011.awb")

						arg_444_1:RecordAudio("123011107", var_447_11)
						arg_444_1:RecordAudio("123011107", var_447_11)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_123011", "123011107", "story_v_out_123011.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_123011", "123011107", "story_v_out_123011.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_12 = math.max(var_447_5, arg_444_1.talkMaxDuration)

			if var_447_4 <= arg_444_1.time_ and arg_444_1.time_ < var_447_4 + var_447_12 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_4) / var_447_12

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_4 + var_447_12 and arg_444_1.time_ < var_447_4 + var_447_12 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play123011108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 123011108
		arg_448_1.duration_ = 1.47

		local var_448_0 = {
			zh = 0.999999999999,
			ja = 1.466
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play123011109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["1029ui_story"]) and arg_448_1.var_.characterEffect1029ui_story == nil then
				arg_448_1.var_.characterEffect1029ui_story = arg_448_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["1029ui_story"]) then
				if arg_448_1.var_.characterEffect1029ui_story and not isNil(arg_448_1.actors_["1029ui_story"]) then
					arg_448_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_0)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["1029ui_story"]) and arg_448_1.var_.characterEffect1029ui_story then
				arg_448_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_451_1 = arg_448_1.actors_["1199ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1199ui_story == nil then
				arg_448_1.var_.characterEffect1199ui_story = var_451_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_2 and not isNil(var_451_1) then
				if arg_448_1.var_.characterEffect1199ui_story and not isNil(var_451_1) then
					arg_448_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_2 and arg_448_1.time_ < 0 + var_451_2 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1199ui_story then
				arg_448_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_451_4 = 0
			local var_451_5 = 0.075

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_6 = arg_448_1:GetWordFromCfg(123011108)
				local var_451_7 = arg_448_1:FormatText(var_451_6.content)

				arg_448_1.text_.text = var_451_7

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_9 = 3 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 3)

				if (3 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 3)) > 0 and var_451_5 < var_451_9 then
					arg_448_1.talkMaxDuration = var_451_9

					if var_451_9 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_9 + var_451_4
					end
				end

				arg_448_1.text_.text = var_451_7
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011108", "story_v_out_123011.awb") ~= 0 then
					local var_451_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011108", "story_v_out_123011.awb") / 1000

					if var_451_10 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_4
					end

					if var_451_6.prefab_name ~= "" and arg_448_1.actors_[var_451_6.prefab_name] ~= nil then
						local var_451_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_6.prefab_name].transform, "story_v_out_123011", "123011108", "story_v_out_123011.awb")

						arg_448_1:RecordAudio("123011108", var_451_11)
						arg_448_1:RecordAudio("123011108", var_451_11)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_123011", "123011108", "story_v_out_123011.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_123011", "123011108", "story_v_out_123011.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_12 = math.max(var_451_5, arg_448_1.talkMaxDuration)

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_12 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_4) / var_451_12

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_4 + var_451_12 and arg_448_1.time_ < var_451_4 + var_451_12 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play123011109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 123011109
		arg_452_1.duration_ = 5

		local var_452_0 = {
			zh = 5,
			ja = 3.533
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play123011110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["1199ui_story"]) and arg_452_1.var_.characterEffect1199ui_story == nil then
				arg_452_1.var_.characterEffect1199ui_story = arg_452_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_0 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["1199ui_story"]) then
				if arg_452_1.var_.characterEffect1199ui_story and not isNil(arg_452_1.actors_["1199ui_story"]) then
					arg_452_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_0)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["1199ui_story"]) and arg_452_1.var_.characterEffect1199ui_story then
				arg_452_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_455_1 = arg_452_1.actors_["1029ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1029ui_story == nil then
				arg_452_1.var_.characterEffect1029ui_story = var_455_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_2 and not isNil(var_455_1) then
				if arg_452_1.var_.characterEffect1029ui_story and not isNil(var_455_1) then
					arg_452_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= 0 + var_455_2 and arg_452_1.time_ < 0 + var_455_2 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1029ui_story then
				arg_452_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_455_4 = 0
			local var_455_5 = 0.4

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_4 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_6 = arg_452_1:GetWordFromCfg(123011109)
				local var_455_7 = arg_452_1:FormatText(var_455_6.content)

				arg_452_1.text_.text = var_455_7

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_9 = 16 <= 0 and var_455_5 or var_455_5 * (utf8.len(var_455_7) / 16)

				if (16 <= 0 and var_455_5 or var_455_5 * (utf8.len(var_455_7) / 16)) > 0 and var_455_5 < var_455_9 then
					arg_452_1.talkMaxDuration = var_455_9

					if var_455_9 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_9 + var_455_4
					end
				end

				arg_452_1.text_.text = var_455_7
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011109", "story_v_out_123011.awb") ~= 0 then
					local var_455_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011109", "story_v_out_123011.awb") / 1000

					if var_455_10 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_10 + var_455_4
					end

					if var_455_6.prefab_name ~= "" and arg_452_1.actors_[var_455_6.prefab_name] ~= nil then
						local var_455_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_6.prefab_name].transform, "story_v_out_123011", "123011109", "story_v_out_123011.awb")

						arg_452_1:RecordAudio("123011109", var_455_11)
						arg_452_1:RecordAudio("123011109", var_455_11)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_123011", "123011109", "story_v_out_123011.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_123011", "123011109", "story_v_out_123011.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_12 = math.max(var_455_5, arg_452_1.talkMaxDuration)

			if var_455_4 <= arg_452_1.time_ and arg_452_1.time_ < var_455_4 + var_455_12 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_4) / var_455_12

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_4 + var_455_12 and arg_452_1.time_ < var_455_4 + var_455_12 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play123011110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 123011110
		arg_456_1.duration_ = 12.1

		local var_456_0 = {
			zh = 10.833,
			ja = 12.1
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play123011111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_459_0 = 0
			local var_459_1 = 1.35

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_2 = arg_456_1:GetWordFromCfg(123011110)
				local var_459_3 = arg_456_1:FormatText(var_459_2.content)

				arg_456_1.text_.text = var_459_3

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 54 <= 0 and var_459_1 or var_459_1 * (utf8.len(var_459_3) / 54)

				if (54 <= 0 and var_459_1 or var_459_1 * (utf8.len(var_459_3) / 54)) > 0 and var_459_1 < var_459_5 then
					arg_456_1.talkMaxDuration = var_459_5

					if var_459_5 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_3
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011110", "story_v_out_123011.awb") ~= 0 then
					local var_459_6 = manager.audio:GetVoiceLength("story_v_out_123011", "123011110", "story_v_out_123011.awb") / 1000

					if var_459_6 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_6 + var_459_0
					end

					if var_459_2.prefab_name ~= "" and arg_456_1.actors_[var_459_2.prefab_name] ~= nil then
						local var_459_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_2.prefab_name].transform, "story_v_out_123011", "123011110", "story_v_out_123011.awb")

						arg_456_1:RecordAudio("123011110", var_459_7)
						arg_456_1:RecordAudio("123011110", var_459_7)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_123011", "123011110", "story_v_out_123011.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_123011", "123011110", "story_v_out_123011.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_8 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_8 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_8

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_8 and arg_456_1.time_ < var_459_0 + var_459_8 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play123011111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 123011111
		arg_460_1.duration_ = 3.27

		local var_460_0 = {
			zh = 2.466,
			ja = 3.266
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play123011112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["1029ui_story"]) and arg_460_1.var_.characterEffect1029ui_story == nil then
				arg_460_1.var_.characterEffect1029ui_story = arg_460_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_0 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["1029ui_story"]) then
				if arg_460_1.var_.characterEffect1029ui_story and not isNil(arg_460_1.actors_["1029ui_story"]) then
					arg_460_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_460_1.time_ - 0) / var_463_0)
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["1029ui_story"]) and arg_460_1.var_.characterEffect1029ui_story then
				arg_460_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_463_1 = arg_460_1.actors_["1199ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1199ui_story == nil then
				arg_460_1.var_.characterEffect1199ui_story = var_463_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_2 and not isNil(var_463_1) then
				if arg_460_1.var_.characterEffect1199ui_story and not isNil(var_463_1) then
					arg_460_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_2 and arg_460_1.time_ < 0 + var_463_2 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1199ui_story then
				arg_460_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_463_4 = 0
			local var_463_5 = 0.375

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_4 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_6 = arg_460_1:GetWordFromCfg(123011111)
				local var_463_7 = arg_460_1:FormatText(var_463_6.content)

				arg_460_1.text_.text = var_463_7

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_9 = 15 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 15)

				if (15 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 15)) > 0 and var_463_5 < var_463_9 then
					arg_460_1.talkMaxDuration = var_463_9

					if var_463_9 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_9 + var_463_4
					end
				end

				arg_460_1.text_.text = var_463_7
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011111", "story_v_out_123011.awb") ~= 0 then
					local var_463_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011111", "story_v_out_123011.awb") / 1000

					if var_463_10 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_10 + var_463_4
					end

					if var_463_6.prefab_name ~= "" and arg_460_1.actors_[var_463_6.prefab_name] ~= nil then
						local var_463_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_6.prefab_name].transform, "story_v_out_123011", "123011111", "story_v_out_123011.awb")

						arg_460_1:RecordAudio("123011111", var_463_11)
						arg_460_1:RecordAudio("123011111", var_463_11)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_123011", "123011111", "story_v_out_123011.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_123011", "123011111", "story_v_out_123011.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_12 = math.max(var_463_5, arg_460_1.talkMaxDuration)

			if var_463_4 <= arg_460_1.time_ and arg_460_1.time_ < var_463_4 + var_463_12 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_4) / var_463_12

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_4 + var_463_12 and arg_460_1.time_ < var_463_4 + var_463_12 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play123011112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 123011112
		arg_464_1.duration_ = 6.4

		local var_464_0 = {
			zh = 5.466,
			ja = 6.4
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play123011113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1029ui_story"]) and arg_464_1.var_.characterEffect1029ui_story == nil then
				arg_464_1.var_.characterEffect1029ui_story = arg_464_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1029ui_story"]) then
				if arg_464_1.var_.characterEffect1029ui_story and not isNil(arg_464_1.actors_["1029ui_story"]) then
					arg_464_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1029ui_story"]) and arg_464_1.var_.characterEffect1029ui_story then
				arg_464_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_467_2 = arg_464_1.actors_["1199ui_story"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_2) and arg_464_1.var_.characterEffect1199ui_story == nil then
				arg_464_1.var_.characterEffect1199ui_story = var_467_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_3 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_3 and not isNil(var_467_2) then
				if arg_464_1.var_.characterEffect1199ui_story and not isNil(var_467_2) then
					arg_464_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_3)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_3 and arg_464_1.time_ < 0 + var_467_3 + arg_467_0 and not isNil(var_467_2) and arg_464_1.var_.characterEffect1199ui_story then
				arg_464_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_467_4 = 0
			local var_467_5 = 0.725

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_4 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_6 = arg_464_1:GetWordFromCfg(123011112)
				local var_467_7 = arg_464_1:FormatText(var_467_6.content)

				arg_464_1.text_.text = var_467_7

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_9 = 29 <= 0 and var_467_5 or var_467_5 * (utf8.len(var_467_7) / 29)

				if (29 <= 0 and var_467_5 or var_467_5 * (utf8.len(var_467_7) / 29)) > 0 and var_467_5 < var_467_9 then
					arg_464_1.talkMaxDuration = var_467_9

					if var_467_9 + var_467_4 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_9 + var_467_4
					end
				end

				arg_464_1.text_.text = var_467_7
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011112", "story_v_out_123011.awb") ~= 0 then
					local var_467_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011112", "story_v_out_123011.awb") / 1000

					if var_467_10 + var_467_4 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_10 + var_467_4
					end

					if var_467_6.prefab_name ~= "" and arg_464_1.actors_[var_467_6.prefab_name] ~= nil then
						local var_467_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_6.prefab_name].transform, "story_v_out_123011", "123011112", "story_v_out_123011.awb")

						arg_464_1:RecordAudio("123011112", var_467_11)
						arg_464_1:RecordAudio("123011112", var_467_11)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_123011", "123011112", "story_v_out_123011.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_123011", "123011112", "story_v_out_123011.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_12 = math.max(var_467_5, arg_464_1.talkMaxDuration)

			if var_467_4 <= arg_464_1.time_ and arg_464_1.time_ < var_467_4 + var_467_12 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_4) / var_467_12

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_4 + var_467_12 and arg_464_1.time_ < var_467_4 + var_467_12 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play123011113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 123011113
		arg_468_1.duration_ = 4.07

		local var_468_0 = {
			zh = 1.8,
			ja = 4.066
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play123011114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["1029ui_story"]) and arg_468_1.var_.characterEffect1029ui_story == nil then
				arg_468_1.var_.characterEffect1029ui_story = arg_468_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_0 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["1029ui_story"]) then
				if arg_468_1.var_.characterEffect1029ui_story and not isNil(arg_468_1.actors_["1029ui_story"]) then
					arg_468_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_468_1.time_ - 0) / var_471_0)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["1029ui_story"]) and arg_468_1.var_.characterEffect1029ui_story then
				arg_468_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_471_1 = arg_468_1.actors_["1199ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1199ui_story == nil then
				arg_468_1.var_.characterEffect1199ui_story = var_471_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_2 and not isNil(var_471_1) then
				if arg_468_1.var_.characterEffect1199ui_story and not isNil(var_471_1) then
					arg_468_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_2 and arg_468_1.time_ < 0 + var_471_2 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1199ui_story then
				arg_468_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_471_4 = 0
			local var_471_5 = 0.275

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_6 = arg_468_1:GetWordFromCfg(123011113)
				local var_471_7 = arg_468_1:FormatText(var_471_6.content)

				arg_468_1.text_.text = var_471_7

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_9 = 11 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 11)

				if (11 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 11)) > 0 and var_471_5 < var_471_9 then
					arg_468_1.talkMaxDuration = var_471_9

					if var_471_9 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_9 + var_471_4
					end
				end

				arg_468_1.text_.text = var_471_7
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011113", "story_v_out_123011.awb") ~= 0 then
					local var_471_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011113", "story_v_out_123011.awb") / 1000

					if var_471_10 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_10 + var_471_4
					end

					if var_471_6.prefab_name ~= "" and arg_468_1.actors_[var_471_6.prefab_name] ~= nil then
						local var_471_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_6.prefab_name].transform, "story_v_out_123011", "123011113", "story_v_out_123011.awb")

						arg_468_1:RecordAudio("123011113", var_471_11)
						arg_468_1:RecordAudio("123011113", var_471_11)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_123011", "123011113", "story_v_out_123011.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_123011", "123011113", "story_v_out_123011.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_12 = math.max(var_471_5, arg_468_1.talkMaxDuration)

			if var_471_4 <= arg_468_1.time_ and arg_468_1.time_ < var_471_4 + var_471_12 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_4) / var_471_12

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_4 + var_471_12 and arg_468_1.time_ < var_471_4 + var_471_12 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play123011114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 123011114
		arg_472_1.duration_ = 7.5

		local var_472_0 = {
			zh = 6.733,
			ja = 7.5
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play123011115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(arg_472_1.actors_["1029ui_story"]) and arg_472_1.var_.characterEffect1029ui_story == nil then
				arg_472_1.var_.characterEffect1029ui_story = arg_472_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_0 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 and not isNil(arg_472_1.actors_["1029ui_story"]) then
				if arg_472_1.var_.characterEffect1029ui_story and not isNil(arg_472_1.actors_["1029ui_story"]) then
					arg_472_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 and not isNil(arg_472_1.actors_["1029ui_story"]) and arg_472_1.var_.characterEffect1029ui_story then
				arg_472_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_475_2 = arg_472_1.actors_["1199ui_story"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_2) and arg_472_1.var_.characterEffect1199ui_story == nil then
				arg_472_1.var_.characterEffect1199ui_story = var_475_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_3 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_3 and not isNil(var_475_2) then
				if arg_472_1.var_.characterEffect1199ui_story and not isNil(var_475_2) then
					arg_472_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_472_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_472_1.time_ - 0) / var_475_3)
				end
			end

			if arg_472_1.time_ >= 0 + var_475_3 and arg_472_1.time_ < 0 + var_475_3 + arg_475_0 and not isNil(var_475_2) and arg_472_1.var_.characterEffect1199ui_story then
				arg_472_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_472_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_475_4 = 0
			local var_475_5 = 0.675

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_4 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_6 = arg_472_1:GetWordFromCfg(123011114)
				local var_475_7 = arg_472_1:FormatText(var_475_6.content)

				arg_472_1.text_.text = var_475_7

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_9 = 27 <= 0 and var_475_5 or var_475_5 * (utf8.len(var_475_7) / 27)

				if (27 <= 0 and var_475_5 or var_475_5 * (utf8.len(var_475_7) / 27)) > 0 and var_475_5 < var_475_9 then
					arg_472_1.talkMaxDuration = var_475_9

					if var_475_9 + var_475_4 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_9 + var_475_4
					end
				end

				arg_472_1.text_.text = var_475_7
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011114", "story_v_out_123011.awb") ~= 0 then
					local var_475_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011114", "story_v_out_123011.awb") / 1000

					if var_475_10 + var_475_4 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_10 + var_475_4
					end

					if var_475_6.prefab_name ~= "" and arg_472_1.actors_[var_475_6.prefab_name] ~= nil then
						local var_475_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_6.prefab_name].transform, "story_v_out_123011", "123011114", "story_v_out_123011.awb")

						arg_472_1:RecordAudio("123011114", var_475_11)
						arg_472_1:RecordAudio("123011114", var_475_11)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_123011", "123011114", "story_v_out_123011.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_123011", "123011114", "story_v_out_123011.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_12 = math.max(var_475_5, arg_472_1.talkMaxDuration)

			if var_475_4 <= arg_472_1.time_ and arg_472_1.time_ < var_475_4 + var_475_12 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_4) / var_475_12

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_4 + var_475_12 and arg_472_1.time_ < var_475_4 + var_475_12 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play123011115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 123011115
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play123011116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["1029ui_story"]) and arg_476_1.var_.characterEffect1029ui_story == nil then
				arg_476_1.var_.characterEffect1029ui_story = arg_476_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["1029ui_story"]) then
				if arg_476_1.var_.characterEffect1029ui_story and not isNil(arg_476_1.actors_["1029ui_story"]) then
					arg_476_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_0)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["1029ui_story"]) and arg_476_1.var_.characterEffect1029ui_story then
				arg_476_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_479_1 = 0
			local var_479_2 = 1.05

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_3 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(123011115).content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 42 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 42)

				if (42 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 42)) > 0 and var_479_2 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_1 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_1
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_6 = math.max(var_479_2, arg_476_1.talkMaxDuration)

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_6 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_1) / var_479_6

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_1 + var_479_6 and arg_476_1.time_ < var_479_1 + var_479_6 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play123011116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 123011116
		arg_480_1.duration_ = 2.5

		local var_480_0 = {
			zh = 2.033,
			ja = 2.5
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play123011117(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos1029ui_story = arg_480_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_483_0 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 then
				arg_480_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_480_1.time_ - 0) / var_483_0)
				arg_480_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1029ui_story"].transform.position).z)
				arg_480_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1029ui_story"].transform.localEulerAngles = arg_480_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 then
				arg_480_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_480_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1029ui_story"].transform.position).z)
				arg_480_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1029ui_story"].transform.localEulerAngles = arg_480_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_483_1 = arg_480_1.actors_["1029ui_story"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect1029ui_story == nil then
				arg_480_1.var_.characterEffect1029ui_story = var_483_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_2 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_2 and not isNil(var_483_1) then
				if arg_480_1.var_.characterEffect1029ui_story and not isNil(var_483_1) then
					arg_480_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_480_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_480_1.time_ - 0) / var_483_2)
				end
			end

			if arg_480_1.time_ >= 0 + var_483_2 and arg_480_1.time_ < 0 + var_483_2 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect1029ui_story then
				arg_480_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_480_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_483_3 = arg_480_1.actors_["1199ui_story"].transform

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos1199ui_story = var_483_3.localPosition
			end

			local var_483_4 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				var_483_3.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_480_1.time_ - 0) / var_483_4)
				var_483_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_483_3.position).x, (manager.ui.mainCamera.transform.position - var_483_3.position).y, (manager.ui.mainCamera.transform.position - var_483_3.position).z)
				var_483_3.localEulerAngles.z = 0
				var_483_3.localEulerAngles.x = 0
				var_483_3.localEulerAngles = var_483_3.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				var_483_3.localPosition = Vector3.New(0, 100, 0)
				var_483_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_483_3.position).x, (manager.ui.mainCamera.transform.position - var_483_3.position).y, (manager.ui.mainCamera.transform.position - var_483_3.position).z)
				var_483_3.localEulerAngles.z = 0
				var_483_3.localEulerAngles.x = 0
				var_483_3.localEulerAngles = var_483_3.localEulerAngles
			end

			local var_483_5 = 0
			local var_483_6 = 0.2

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_5 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_7 = arg_480_1:GetWordFromCfg(123011116)
				local var_483_8 = arg_480_1:FormatText(var_483_7.content)

				arg_480_1.text_.text = var_483_8

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_10 = 8 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 8)

				if (8 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 8)) > 0 and var_483_6 < var_483_10 then
					arg_480_1.talkMaxDuration = var_483_10

					if var_483_10 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_5
					end
				end

				arg_480_1.text_.text = var_483_8
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011116", "story_v_out_123011.awb") ~= 0 then
					local var_483_11 = manager.audio:GetVoiceLength("story_v_out_123011", "123011116", "story_v_out_123011.awb") / 1000

					if var_483_11 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_11 + var_483_5
					end

					if var_483_7.prefab_name ~= "" and arg_480_1.actors_[var_483_7.prefab_name] ~= nil then
						local var_483_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_7.prefab_name].transform, "story_v_out_123011", "123011116", "story_v_out_123011.awb")

						arg_480_1:RecordAudio("123011116", var_483_12)
						arg_480_1:RecordAudio("123011116", var_483_12)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_123011", "123011116", "story_v_out_123011.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_123011", "123011116", "story_v_out_123011.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_13 = math.max(var_483_6, arg_480_1.talkMaxDuration)

			if var_483_5 <= arg_480_1.time_ and arg_480_1.time_ < var_483_5 + var_483_13 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_5) / var_483_13

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_5 + var_483_13 and arg_480_1.time_ < var_483_5 + var_483_13 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play123011117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 123011117
		arg_484_1.duration_ = 4.43

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play123011118(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 1.999999999999 < arg_484_1.time_ and arg_484_1.time_ <= 1.999999999999 + arg_487_0 then
				local var_487_0 = arg_484_1.bgs_.STblack

				arg_484_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_487_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_487_1 = var_487_0:GetComponent("SpriteRenderer")

				if var_487_1 and var_487_1.sprite then
					local var_487_2 = 2 * (var_487_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_487_0.transform.localScale = Vector3.New(var_487_2 / var_487_1.sprite.bounds.size.y < var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x and var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x or var_487_2 / var_487_1.sprite.bounds.size.y, var_487_2 / var_487_1.sprite.bounds.size.y < var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x and var_487_2 * manager.ui.mainCameraCom_.aspect / var_487_1.sprite.bounds.size.x or var_487_2 / var_487_1.sprite.bounds.size.y, 0)
				end

				for iter_487_0, iter_487_1 in pairs(arg_484_1.bgs_) do
					if iter_487_0 ~= "STblack" then
						iter_487_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_487_3 = 0

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_3 + arg_487_0 then
				arg_484_1.mask_.enabled = true
				arg_484_1.mask_.raycastTarget = true

				arg_484_1:SetGaussion(false)
			end

			local var_487_4 = 2

			if var_487_3 <= arg_484_1.time_ and arg_484_1.time_ < var_487_3 + var_487_4 then
				local var_487_5 = Color.New(0, 0, 0)

				var_487_5.a = Mathf.Lerp(0, 1, (arg_484_1.time_ - var_487_3) / var_487_4)
				arg_484_1.mask_.color = var_487_5
			end

			if arg_484_1.time_ >= var_487_3 + var_487_4 and arg_484_1.time_ < var_487_3 + var_487_4 + arg_487_0 then
				local var_487_6 = Color.New(0, 0, 0)

				var_487_6.a = 1
				arg_484_1.mask_.color = var_487_6
			end

			local var_487_7 = 2

			if 2 < arg_484_1.time_ and arg_484_1.time_ <= var_487_7 + arg_487_0 then
				arg_484_1.mask_.enabled = true
				arg_484_1.mask_.raycastTarget = true

				arg_484_1:SetGaussion(false)
			end

			local var_487_8 = 2

			if var_487_7 <= arg_484_1.time_ and arg_484_1.time_ < var_487_7 + var_487_8 then
				local var_487_9 = Color.New(0, 0, 0)

				var_487_9.a = Mathf.Lerp(1, 0, (arg_484_1.time_ - var_487_7) / var_487_8)
				arg_484_1.mask_.color = var_487_9
			end

			if arg_484_1.time_ >= var_487_7 + var_487_8 and arg_484_1.time_ < var_487_7 + var_487_8 + arg_487_0 then
				local var_487_10 = Color.New(0, 0, 0)

				arg_484_1.mask_.enabled = false
				var_487_10.a = 0
				arg_484_1.mask_.color = var_487_10
			end

			local var_487_11 = arg_484_1.actors_["1199ui_story"]

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(var_487_11) and arg_484_1.var_.characterEffect1199ui_story == nil then
				arg_484_1.var_.characterEffect1199ui_story = var_487_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_12 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_12 and not isNil(var_487_11) then
				if arg_484_1.var_.characterEffect1199ui_story and not isNil(var_487_11) then
					arg_484_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_484_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_484_1.time_ - 0) / var_487_12)
				end
			end

			if arg_484_1.time_ >= 0 + var_487_12 and arg_484_1.time_ < 0 + var_487_12 + arg_487_0 and not isNil(var_487_11) and arg_484_1.var_.characterEffect1199ui_story then
				arg_484_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_484_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 1.999999999999 < arg_484_1.time_ and arg_484_1.time_ <= 1.999999999999 + arg_487_0 then
				arg_484_1.fswbg_:SetActive(true)
				arg_484_1.dialog_:SetActive(false)

				arg_484_1.fswtw_.percent = 0
				arg_484_1.fswt_.text = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(123011117).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.fswt_)

				arg_484_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_484_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_484_1.fswtw_:SetDirty()

				arg_484_1.typewritterCharCountI18N = 0

				SetActive(arg_484_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_484_1:ShowNextGo(false)
			end

			local var_487_13 = 2.01666666666567

			if 2.01666666666567 < arg_484_1.time_ and arg_484_1.time_ <= var_487_13 + arg_487_0 then
				arg_484_1.var_.oldValueTypewriter = arg_484_1.fswtw_.percent

				SetActive(arg_484_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_484_1:ShowNextGo(false)
			end

			local var_487_14 = 22
			local var_487_15 = 1.46666666666667
			local var_487_16, var_487_17 = arg_484_1:GetPercentByPara(arg_484_1:FormatText(arg_484_1:GetWordFromCfg(123011117).content), 1)

			if var_487_13 < arg_484_1.time_ and arg_484_1.time_ <= var_487_13 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0

				local var_487_18 = var_487_14 <= 0 and var_487_15 or var_487_15 * ((var_487_17 - arg_484_1.typewritterCharCountI18N) / var_487_14)

				if (var_487_14 <= 0 and var_487_15 or var_487_15 * ((var_487_17 - arg_484_1.typewritterCharCountI18N) / var_487_14)) > 0 and var_487_15 < var_487_18 then
					arg_484_1.talkMaxDuration = var_487_18

					if var_487_18 + var_487_13 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_18 + var_487_13
					end
				end
			end

			local var_487_19 = math.max(1.46666666666667, arg_484_1.talkMaxDuration)

			if var_487_13 <= arg_484_1.time_ and arg_484_1.time_ < var_487_13 + var_487_19 then
				arg_484_1.fswtw_.percent = Mathf.Lerp(arg_484_1.var_.oldValueTypewriter, var_487_16, (arg_484_1.time_ - var_487_13) / var_487_19)
				arg_484_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_484_1.fswtw_:SetDirty()
			end

			if arg_484_1.time_ >= var_487_13 + var_487_19 and arg_484_1.time_ < var_487_13 + var_487_19 + arg_487_0 then
				arg_484_1.fswtw_.percent = var_487_16

				arg_484_1.fswtw_:SetDirty()
				arg_484_1:ShowNextGo(true)

				arg_484_1.typewritterCharCountI18N = var_487_17
			end

			if 1.999999999999 < arg_484_1.time_ and arg_484_1.time_ <= 1.999999999999 + arg_487_0 then
				local var_487_20 = arg_484_1.fswbg_.transform:Find("textbox/adapt/content") or arg_484_1.fswbg_.transform:Find("textbox/content")
				local var_487_21 = arg_484_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_487_22 = var_487_20:GetComponent("RectTransform")

				var_487_20:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_487_22.offsetMin = Vector2.New(0, 0)
				var_487_22.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_487_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_484_1.bgmTxt_.text ~= var_487_25 and arg_484_1.bgmTxt_.text ~= "" then
						if arg_484_1.bgmTxt2_.text ~= "" then
							arg_484_1.bgmTxt_.text = arg_484_1.bgmTxt2_.text
						end

						arg_484_1.bgmTxt2_.text = var_487_25

						arg_484_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_484_1.bgmTxt_.text = var_487_25
						arg_484_1.bgmTxt2_.text = var_487_25
					end

					if arg_484_1.bgmTimer then
						arg_484_1.bgmTimer:Stop()

						arg_484_1.bgmTimer = nil
					end

					if arg_484_1.settingData.show_music_name == 1 then
						arg_484_1.musicController:SetSelectedState("show")
						arg_484_1.musicAnimator_:Play("open", 0, 0)

						if arg_484_1.settingData.music_time ~= 0 then
							arg_484_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_484_1.settingData.music_time), function()
								if arg_484_1 == nil or isNil(arg_484_1.bgmTxt_) then
									return
								end

								arg_484_1.musicController:SetSelectedState("hide")
								arg_484_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play123011118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 123011118
		arg_489_1.duration_ = 7.4

		local var_489_0 = {
			zh = 6.399999999999,
			ja = 7.399999999999
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play123011119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if arg_489_1.bgs_.XH0509 == nil then
				local var_492_0 = Object.Instantiate(arg_489_1.paintGo_)

				var_492_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0509")
				var_492_0.name = "XH0509"
				var_492_0.transform.parent = arg_489_1.stage_.transform
				var_492_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.bgs_.XH0509 = var_492_0
			end

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= 2 + arg_492_0 then
				local var_492_1 = arg_489_1.bgs_.XH0509

				arg_489_1.bgs_.XH0509.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_492_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_2 = var_492_1:GetComponent("SpriteRenderer")

				if var_492_2 and var_492_2.sprite then
					local var_492_3 = 2 * (var_492_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_492_1.transform.localScale = Vector3.New(var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "XH0509" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_4 = 0

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_5 = 2

			if var_492_4 <= arg_489_1.time_ and arg_489_1.time_ < var_492_4 + var_492_5 then
				local var_492_6 = Color.New(0, 0, 0)

				var_492_6.a = Mathf.Lerp(0, 1, (arg_489_1.time_ - var_492_4) / var_492_5)
				arg_489_1.mask_.color = var_492_6
			end

			if arg_489_1.time_ >= var_492_4 + var_492_5 and arg_489_1.time_ < var_492_4 + var_492_5 + arg_492_0 then
				local var_492_7 = Color.New(0, 0, 0)

				var_492_7.a = 1
				arg_489_1.mask_.color = var_492_7
			end

			local var_492_8 = 2

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_8 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_9 = 2

			if var_492_8 <= arg_489_1.time_ and arg_489_1.time_ < var_492_8 + var_492_9 then
				local var_492_10 = Color.New(0, 0, 0)

				var_492_10.a = Mathf.Lerp(1, 0, (arg_489_1.time_ - var_492_8) / var_492_9)
				arg_489_1.mask_.color = var_492_10
			end

			if arg_489_1.time_ >= var_492_8 + var_492_9 and arg_489_1.time_ < var_492_8 + var_492_9 + arg_492_0 then
				local var_492_11 = Color.New(0, 0, 0)

				arg_489_1.mask_.enabled = false
				var_492_11.a = 0
				arg_489_1.mask_.color = var_492_11
			end

			if 1.98333333333333 < arg_489_1.time_ and arg_489_1.time_ <= 1.98333333333333 + arg_492_0 then
				arg_489_1.fswbg_:SetActive(false)
				arg_489_1.dialog_:SetActive(false)
				SetActive(arg_489_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_489_1:ShowNextGo(false)
			end

			local var_492_12 = 2

			arg_489_1.isInRecall_ = false

			if var_492_12 < arg_489_1.time_ and arg_489_1.time_ <= var_492_12 + arg_492_0 then
				arg_489_1.screenFilterGo_:SetActive(true)

				arg_489_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_492_2, iter_492_3 in pairs(arg_489_1.actors_) do
					for iter_492_4, iter_492_5 in ipairs((iter_492_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_492_5.color = iter_492_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_492_13 = 0.1

			if var_492_12 <= arg_489_1.time_ and arg_489_1.time_ < var_492_12 + var_492_13 then
				arg_489_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_489_1.time_ - var_492_12) / var_492_13)
			end

			if arg_489_1.time_ >= var_492_12 + var_492_13 and arg_489_1.time_ < var_492_12 + var_492_13 + arg_492_0 then
				arg_489_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_492_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_489_1.bgmTxt_.text ~= var_492_16 and arg_489_1.bgmTxt_.text ~= "" then
						if arg_489_1.bgmTxt2_.text ~= "" then
							arg_489_1.bgmTxt_.text = arg_489_1.bgmTxt2_.text
						end

						arg_489_1.bgmTxt2_.text = var_492_16

						arg_489_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_489_1.bgmTxt_.text = var_492_16
						arg_489_1.bgmTxt2_.text = var_492_16
					end

					if arg_489_1.bgmTimer then
						arg_489_1.bgmTimer:Stop()

						arg_489_1.bgmTimer = nil
					end

					if arg_489_1.settingData.show_music_name == 1 then
						arg_489_1.musicController:SetSelectedState("show")
						arg_489_1.musicAnimator_:Play("open", 0, 0)

						if arg_489_1.settingData.music_time ~= 0 then
							arg_489_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_489_1.settingData.music_time), function()
								if arg_489_1 == nil or isNil(arg_489_1.bgmTxt_) then
									return
								end

								arg_489_1.musicController:SetSelectedState("hide")
								arg_489_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.999999999999 < arg_489_1.time_ and arg_489_1.time_ <= 1.999999999999 + arg_492_0 then
				arg_489_1:AudioAction("play", "music", "bgm_activity_2_2_story_talk", "bgm_activity_2_2_story_talk", "bgm_activity_2_2_story_talk.awb")

				local var_492_19 = manager.audio:GetAudioName("bgm_activity_2_2_story_talk", "bgm_activity_2_2_story_talk")

				if "" ~= "" then
					if arg_489_1.bgmTxt_.text ~= var_492_19 and arg_489_1.bgmTxt_.text ~= "" then
						if arg_489_1.bgmTxt2_.text ~= "" then
							arg_489_1.bgmTxt_.text = arg_489_1.bgmTxt2_.text
						end

						arg_489_1.bgmTxt2_.text = var_492_19

						arg_489_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_489_1.bgmTxt_.text = var_492_19
						arg_489_1.bgmTxt2_.text = var_492_19
					end

					if arg_489_1.bgmTimer then
						arg_489_1.bgmTimer:Stop()

						arg_489_1.bgmTimer = nil
					end

					if arg_489_1.settingData.show_music_name == 1 then
						arg_489_1.musicController:SetSelectedState("show")
						arg_489_1.musicAnimator_:Play("open", 0, 0)

						if arg_489_1.settingData.music_time ~= 0 then
							arg_489_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_489_1.settingData.music_time), function()
								if arg_489_1 == nil or isNil(arg_489_1.bgmTxt_) then
									return
								end

								arg_489_1.musicController:SetSelectedState("hide")
								arg_489_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_20 = 3.999999999999
			local var_492_21 = 0.3

			if 3.999999999999 < arg_489_1.time_ and arg_489_1.time_ <= var_492_20 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_22 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_22:setOnUpdate(LuaHelper.FloatAction(function(arg_495_0)
					arg_489_1.dialogCg_.alpha = arg_495_0
				end))
				var_492_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_23 = arg_489_1:GetWordFromCfg(123011118)
				local var_492_24 = arg_489_1:FormatText(var_492_23.content)

				arg_489_1.text_.text = var_492_24

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_26 = 12 <= 0 and var_492_21 or var_492_21 * (utf8.len(var_492_24) / 12)

				if (12 <= 0 and var_492_21 or var_492_21 * (utf8.len(var_492_24) / 12)) > 0 and var_492_21 < var_492_26 then
					arg_489_1.talkMaxDuration = var_492_26
					var_492_20 = var_492_20 + 0.3

					if var_492_26 + var_492_20 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_26 + var_492_20
					end
				end

				arg_489_1.text_.text = var_492_24
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011118", "story_v_out_123011.awb") ~= 0 then
					local var_492_27 = manager.audio:GetVoiceLength("story_v_out_123011", "123011118", "story_v_out_123011.awb") / 1000

					if var_492_27 + var_492_20 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_27 + var_492_20
					end

					if var_492_23.prefab_name ~= "" and arg_489_1.actors_[var_492_23.prefab_name] ~= nil then
						local var_492_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_23.prefab_name].transform, "story_v_out_123011", "123011118", "story_v_out_123011.awb")

						arg_489_1:RecordAudio("123011118", var_492_28)
						arg_489_1:RecordAudio("123011118", var_492_28)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_123011", "123011118", "story_v_out_123011.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_123011", "123011118", "story_v_out_123011.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_29 = var_492_20 + 0.3
			local var_492_30 = math.max(var_492_21, arg_489_1.talkMaxDuration)

			if var_492_20 + 0.3 <= arg_489_1.time_ and arg_489_1.time_ < var_492_29 + var_492_30 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_29) / var_492_30

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_29 + var_492_30 and arg_489_1.time_ < var_492_29 + var_492_30 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play123011119 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 123011119
		arg_497_1.duration_ = 6.13

		local var_497_0 = {
			zh = 4,
			ja = 6.133
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play123011120(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.5

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_1 = arg_497_1:GetWordFromCfg(123011119)
				local var_500_2 = arg_497_1:FormatText(var_500_1.content)

				arg_497_1.text_.text = var_500_2

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 20 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 20)

				if (20 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 20)) > 0 and var_500_0 < var_500_4 then
					arg_497_1.talkMaxDuration = var_500_4

					if var_500_4 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_4 + 0
					end
				end

				arg_497_1.text_.text = var_500_2
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011119", "story_v_out_123011.awb") ~= 0 then
					local var_500_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011119", "story_v_out_123011.awb") / 1000

					if var_500_5 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + 0
					end

					if var_500_1.prefab_name ~= "" and arg_497_1.actors_[var_500_1.prefab_name] ~= nil then
						local var_500_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_1.prefab_name].transform, "story_v_out_123011", "123011119", "story_v_out_123011.awb")

						arg_497_1:RecordAudio("123011119", var_500_6)
						arg_497_1:RecordAudio("123011119", var_500_6)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_123011", "123011119", "story_v_out_123011.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_123011", "123011119", "story_v_out_123011.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_7 and arg_497_1.time_ < 0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play123011120 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 123011120
		arg_501_1.duration_ = 16.4

		local var_501_0 = {
			zh = 11.799999999999,
			ja = 16.399999999999
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play123011121(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if arg_501_1.bgs_.J12f == nil then
				local var_504_0 = Object.Instantiate(arg_501_1.paintGo_)

				var_504_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J12f")
				var_504_0.name = "J12f"
				var_504_0.transform.parent = arg_501_1.stage_.transform
				var_504_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_501_1.bgs_.J12f = var_504_0
			end

			if 1.999999999999 < arg_501_1.time_ and arg_501_1.time_ <= 1.999999999999 + arg_504_0 then
				local var_504_1 = arg_501_1.bgs_.J12f

				arg_501_1.bgs_.J12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_504_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_504_2 = var_504_1:GetComponent("SpriteRenderer")

				if var_504_2 and var_504_2.sprite then
					local var_504_3 = 2 * (var_504_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_504_1.transform.localScale = Vector3.New(var_504_3 / var_504_2.sprite.bounds.size.y < var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x and var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x or var_504_3 / var_504_2.sprite.bounds.size.y, var_504_3 / var_504_2.sprite.bounds.size.y < var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x and var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x or var_504_3 / var_504_2.sprite.bounds.size.y, 0)
				end

				for iter_504_0, iter_504_1 in pairs(arg_501_1.bgs_) do
					if iter_504_0 ~= "J12f" then
						iter_504_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_504_4 = 0

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_5 = 2

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_5 then
				local var_504_6 = Color.New(0, 0, 0)

				var_504_6.a = Mathf.Lerp(0, 1, (arg_501_1.time_ - var_504_4) / var_504_5)
				arg_501_1.mask_.color = var_504_6
			end

			if arg_501_1.time_ >= var_504_4 + var_504_5 and arg_501_1.time_ < var_504_4 + var_504_5 + arg_504_0 then
				local var_504_7 = Color.New(0, 0, 0)

				var_504_7.a = 1
				arg_501_1.mask_.color = var_504_7
			end

			local var_504_8 = 2

			if 2 < arg_501_1.time_ and arg_501_1.time_ <= var_504_8 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_9 = 2

			if var_504_8 <= arg_501_1.time_ and arg_501_1.time_ < var_504_8 + var_504_9 then
				local var_504_10 = Color.New(0, 0, 0)

				var_504_10.a = Mathf.Lerp(1, 0, (arg_501_1.time_ - var_504_8) / var_504_9)
				arg_501_1.mask_.color = var_504_10
			end

			if arg_501_1.time_ >= var_504_8 + var_504_9 and arg_501_1.time_ < var_504_8 + var_504_9 + arg_504_0 then
				local var_504_11 = Color.New(0, 0, 0)

				arg_501_1.mask_.enabled = false
				var_504_11.a = 0
				arg_501_1.mask_.color = var_504_11
			end

			local var_504_12 = arg_501_1.actors_["1029ui_story"].transform

			if 2 < arg_501_1.time_ and arg_501_1.time_ <= 2 + arg_504_0 then
				arg_501_1.var_.moveOldPos1029ui_story = var_504_12.localPosition
			end

			local var_504_13 = 0.001

			if 2 <= arg_501_1.time_ and arg_501_1.time_ < 2 + var_504_13 then
				var_504_12.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_501_1.time_ - 2) / var_504_13)
				var_504_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_12.position).x, (manager.ui.mainCamera.transform.position - var_504_12.position).y, (manager.ui.mainCamera.transform.position - var_504_12.position).z)
				var_504_12.localEulerAngles.z = 0
				var_504_12.localEulerAngles.x = 0
				var_504_12.localEulerAngles = var_504_12.localEulerAngles
			end

			if arg_501_1.time_ >= 2 + var_504_13 and arg_501_1.time_ < 2 + var_504_13 + arg_504_0 then
				var_504_12.localPosition = Vector3.New(0, -1.09, -6.2)
				var_504_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_12.position).x, (manager.ui.mainCamera.transform.position - var_504_12.position).y, (manager.ui.mainCamera.transform.position - var_504_12.position).z)
				var_504_12.localEulerAngles.z = 0
				var_504_12.localEulerAngles.x = 0
				var_504_12.localEulerAngles = var_504_12.localEulerAngles
			end

			local var_504_14 = arg_501_1.actors_["1029ui_story"]

			if 2 < arg_501_1.time_ and arg_501_1.time_ <= 2 + arg_504_0 and not isNil(var_504_14) and arg_501_1.var_.characterEffect1029ui_story == nil then
				arg_501_1.var_.characterEffect1029ui_story = var_504_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_15 = 0.200000002980232

			if 2 <= arg_501_1.time_ and arg_501_1.time_ < 2 + var_504_15 and not isNil(var_504_14) then
				if arg_501_1.var_.characterEffect1029ui_story and not isNil(var_504_14) then
					arg_501_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 2 + var_504_15 and arg_501_1.time_ < 2 + var_504_15 + arg_504_0 and not isNil(var_504_14) and arg_501_1.var_.characterEffect1029ui_story then
				arg_501_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 2 < arg_501_1.time_ and arg_501_1.time_ <= 2 + arg_504_0 then
				arg_501_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 2 < arg_501_1.time_ and arg_501_1.time_ <= 2 + arg_504_0 then
				arg_501_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_501_1.frameCnt_ <= 1 then
				arg_501_1.dialog_:SetActive(false)
			end

			local var_504_17 = 3.099999999999
			local var_504_18 = 0.9

			if 3.099999999999 < arg_501_1.time_ and arg_501_1.time_ <= var_504_17 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_19 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_19:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_20 = arg_501_1:GetWordFromCfg(123011120)
				local var_504_21 = arg_501_1:FormatText(var_504_20.content)

				arg_501_1.text_.text = var_504_21

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_23 = 36 <= 0 and var_504_18 or var_504_18 * (utf8.len(var_504_21) / 36)

				if (36 <= 0 and var_504_18 or var_504_18 * (utf8.len(var_504_21) / 36)) > 0 and var_504_18 < var_504_23 then
					arg_501_1.talkMaxDuration = var_504_23
					var_504_17 = var_504_17 + 0.3

					if var_504_23 + var_504_17 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_23 + var_504_17
					end
				end

				arg_501_1.text_.text = var_504_21
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011120", "story_v_out_123011.awb") ~= 0 then
					local var_504_24 = manager.audio:GetVoiceLength("story_v_out_123011", "123011120", "story_v_out_123011.awb") / 1000

					if var_504_24 + var_504_17 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_24 + var_504_17
					end

					if var_504_20.prefab_name ~= "" and arg_501_1.actors_[var_504_20.prefab_name] ~= nil then
						local var_504_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_20.prefab_name].transform, "story_v_out_123011", "123011120", "story_v_out_123011.awb")

						arg_501_1:RecordAudio("123011120", var_504_25)
						arg_501_1:RecordAudio("123011120", var_504_25)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_123011", "123011120", "story_v_out_123011.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_123011", "123011120", "story_v_out_123011.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_26 = var_504_17 + 0.3
			local var_504_27 = math.max(var_504_18, arg_501_1.talkMaxDuration)

			if var_504_17 + 0.3 <= arg_501_1.time_ and arg_501_1.time_ < var_504_26 + var_504_27 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_26) / var_504_27

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_26 + var_504_27 and arg_501_1.time_ < var_504_26 + var_504_27 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play123011121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 123011121
		arg_507_1.duration_ = 8.43

		local var_507_0 = {
			zh = 4.466,
			ja = 8.433
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play123011122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.375

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:GetWordFromCfg(123011121)
				local var_510_2 = arg_507_1:FormatText(var_510_1.content)

				arg_507_1.text_.text = var_510_2

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 15 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 15)

				if (15 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 15)) > 0 and var_510_0 < var_510_4 then
					arg_507_1.talkMaxDuration = var_510_4

					if var_510_4 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_4 + 0
					end
				end

				arg_507_1.text_.text = var_510_2
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011121", "story_v_out_123011.awb") ~= 0 then
					local var_510_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011121", "story_v_out_123011.awb") / 1000

					if var_510_5 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + 0
					end

					if var_510_1.prefab_name ~= "" and arg_507_1.actors_[var_510_1.prefab_name] ~= nil then
						local var_510_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_1.prefab_name].transform, "story_v_out_123011", "123011121", "story_v_out_123011.awb")

						arg_507_1:RecordAudio("123011121", var_510_6)
						arg_507_1:RecordAudio("123011121", var_510_6)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_123011", "123011121", "story_v_out_123011.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_123011", "123011121", "story_v_out_123011.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play123011122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 123011122
		arg_511_1.duration_ = 7

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play123011123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if arg_511_1.bgs_.STwhite == nil then
				local var_514_0 = Object.Instantiate(arg_511_1.paintGo_)

				var_514_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_514_0.name = "STwhite"
				var_514_0.transform.parent = arg_511_1.stage_.transform
				var_514_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_511_1.bgs_.STwhite = var_514_0
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				local var_514_1 = arg_511_1.bgs_.STwhite

				arg_511_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_514_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_514_2 = var_514_1:GetComponent("SpriteRenderer")

				if var_514_2 and var_514_2.sprite then
					local var_514_3 = 2 * (var_514_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_514_1.transform.localScale = Vector3.New(var_514_3 / var_514_2.sprite.bounds.size.y < var_514_3 * manager.ui.mainCameraCom_.aspect / var_514_2.sprite.bounds.size.x and var_514_3 * manager.ui.mainCameraCom_.aspect / var_514_2.sprite.bounds.size.x or var_514_3 / var_514_2.sprite.bounds.size.y, var_514_3 / var_514_2.sprite.bounds.size.y < var_514_3 * manager.ui.mainCameraCom_.aspect / var_514_2.sprite.bounds.size.x and var_514_3 * manager.ui.mainCameraCom_.aspect / var_514_2.sprite.bounds.size.x or var_514_3 / var_514_2.sprite.bounds.size.y, 0)
				end

				for iter_514_0, iter_514_1 in pairs(arg_511_1.bgs_) do
					if iter_514_0 ~= "STwhite" then
						iter_514_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_514_4 = 0

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = true

				arg_511_1:SetGaussion(false)
			end

			local var_514_5 = 2

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_5 then
				local var_514_6 = Color.New(1, 1, 1)

				var_514_6.a = Mathf.Lerp(1, 0, (arg_511_1.time_ - var_514_4) / var_514_5)
				arg_511_1.mask_.color = var_514_6
			end

			if arg_511_1.time_ >= var_514_4 + var_514_5 and arg_511_1.time_ < var_514_4 + var_514_5 + arg_514_0 then
				local var_514_7 = Color.New(1, 1, 1)

				arg_511_1.mask_.enabled = false
				var_514_7.a = 0
				arg_511_1.mask_.color = var_514_7
			end

			local var_514_8 = arg_511_1.actors_["1029ui_story"].transform

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos1029ui_story = var_514_8.localPosition
			end

			local var_514_9 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_9 then
				var_514_8.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_511_1.time_ - 0) / var_514_9)
				var_514_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_514_8.position).x, (manager.ui.mainCamera.transform.position - var_514_8.position).y, (manager.ui.mainCamera.transform.position - var_514_8.position).z)
				var_514_8.localEulerAngles.z = 0
				var_514_8.localEulerAngles.x = 0
				var_514_8.localEulerAngles = var_514_8.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_9 and arg_511_1.time_ < 0 + var_514_9 + arg_514_0 then
				var_514_8.localPosition = Vector3.New(0, 100, 0)
				var_514_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_514_8.position).x, (manager.ui.mainCamera.transform.position - var_514_8.position).y, (manager.ui.mainCamera.transform.position - var_514_8.position).z)
				var_514_8.localEulerAngles.z = 0
				var_514_8.localEulerAngles.x = 0
				var_514_8.localEulerAngles = var_514_8.localEulerAngles
			end

			local var_514_10 = arg_511_1.actors_["1029ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_10) and arg_511_1.var_.characterEffect1029ui_story == nil then
				arg_511_1.var_.characterEffect1029ui_story = var_514_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_11 and not isNil(var_514_10) then
				if arg_511_1.var_.characterEffect1029ui_story and not isNil(var_514_10) then
					arg_511_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_11)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_11 and arg_511_1.time_ < 0 + var_514_11 + arg_514_0 and not isNil(var_514_10) and arg_511_1.var_.characterEffect1029ui_story then
				arg_511_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_514_12 = 0

			arg_511_1.isInRecall_ = false

			if var_514_12 < arg_511_1.time_ and arg_511_1.time_ <= var_514_12 + arg_514_0 then
				arg_511_1.screenFilterGo_:SetActive(false)

				for iter_514_2, iter_514_3 in pairs(arg_511_1.actors_) do
					for iter_514_4, iter_514_5 in ipairs((iter_514_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_514_5.color = iter_514_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_514_13 = 0.1

			if var_514_12 <= arg_511_1.time_ and arg_511_1.time_ < var_514_12 + var_514_13 then
				arg_511_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_511_1.time_ - var_514_12) / var_514_13)
			end

			if arg_511_1.time_ >= var_514_12 + var_514_13 and arg_511_1.time_ < var_514_12 + var_514_13 + arg_514_0 then
				arg_511_1.screenFilterEffect_.weight = 0
			end

			if 2 < arg_511_1.time_ and arg_511_1.time_ <= 2 + arg_514_0 then
				arg_511_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_medical", "")
			end

			if arg_511_1.frameCnt_ <= 1 then
				arg_511_1.dialog_:SetActive(false)
			end

			local var_514_15 = 1.999999999999
			local var_514_16 = 1.075

			if 1.999999999999 < arg_511_1.time_ and arg_511_1.time_ <= var_514_15 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0

				arg_511_1.dialog_:SetActive(true)

				arg_511_1.dialogCg_.alpha = 0

				local var_514_17 = LeanTween.value(arg_511_1.dialog_, 0, 1, 0.3)

				var_514_17:setOnUpdate(LuaHelper.FloatAction(function(arg_515_0)
					arg_511_1.dialogCg_.alpha = arg_515_0
				end))
				var_514_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_511_1.dialog_)
					var_514_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_511_1.duration_ = arg_511_1.duration_ + 0.3

				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_18 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(123011122).content)

				arg_511_1.text_.text = var_514_18

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_20 = 43 <= 0 and var_514_16 or var_514_16 * (utf8.len(var_514_18) / 43)

				if (43 <= 0 and var_514_16 or var_514_16 * (utf8.len(var_514_18) / 43)) > 0 and var_514_16 < var_514_20 then
					arg_511_1.talkMaxDuration = var_514_20
					var_514_15 = var_514_15 + 0.3

					if var_514_20 + var_514_15 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_20 + var_514_15
					end
				end

				arg_511_1.text_.text = var_514_18
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_21 = var_514_15 + 0.3
			local var_514_22 = math.max(var_514_16, arg_511_1.talkMaxDuration)

			if var_514_15 + 0.3 <= arg_511_1.time_ and arg_511_1.time_ < var_514_21 + var_514_22 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_21) / var_514_22

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_21 + var_514_22 and arg_511_1.time_ < var_514_21 + var_514_22 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
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

		arg_511_1:InitPlayNodeList()
	end,
	Play123011123 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 123011123
		arg_517_1.duration_ = 9

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play123011124(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if arg_517_1.bgs_.I02 == nil then
				local var_520_0 = Object.Instantiate(arg_517_1.paintGo_)

				var_520_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I02")
				var_520_0.name = "I02"
				var_520_0.transform.parent = arg_517_1.stage_.transform
				var_520_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.bgs_.I02 = var_520_0
			end

			if 2 < arg_517_1.time_ and arg_517_1.time_ <= 2 + arg_520_0 then
				local var_520_1 = arg_517_1.bgs_.I02

				arg_517_1.bgs_.I02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_520_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_520_2 = var_520_1:GetComponent("SpriteRenderer")

				if var_520_2 and var_520_2.sprite then
					local var_520_3 = 2 * (var_520_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_520_1.transform.localScale = Vector3.New(var_520_3 / var_520_2.sprite.bounds.size.y < var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x and var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x or var_520_3 / var_520_2.sprite.bounds.size.y, var_520_3 / var_520_2.sprite.bounds.size.y < var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x and var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x or var_520_3 / var_520_2.sprite.bounds.size.y, 0)
				end

				for iter_520_0, iter_520_1 in pairs(arg_517_1.bgs_) do
					if iter_520_0 ~= "I02" then
						iter_520_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_520_4 = 0

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_4 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_5 = 2

			if var_520_4 <= arg_517_1.time_ and arg_517_1.time_ < var_520_4 + var_520_5 then
				local var_520_6 = Color.New(0, 0, 0)

				var_520_6.a = Mathf.Lerp(0, 1, (arg_517_1.time_ - var_520_4) / var_520_5)
				arg_517_1.mask_.color = var_520_6
			end

			if arg_517_1.time_ >= var_520_4 + var_520_5 and arg_517_1.time_ < var_520_4 + var_520_5 + arg_520_0 then
				local var_520_7 = Color.New(0, 0, 0)

				var_520_7.a = 1
				arg_517_1.mask_.color = var_520_7
			end

			local var_520_8 = 2

			if 2 < arg_517_1.time_ and arg_517_1.time_ <= var_520_8 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_9 = 2

			if var_520_8 <= arg_517_1.time_ and arg_517_1.time_ < var_520_8 + var_520_9 then
				local var_520_10 = Color.New(0, 0, 0)

				var_520_10.a = Mathf.Lerp(1, 0, (arg_517_1.time_ - var_520_8) / var_520_9)
				arg_517_1.mask_.color = var_520_10
			end

			if arg_517_1.time_ >= var_520_8 + var_520_9 and arg_517_1.time_ < var_520_8 + var_520_9 + arg_520_0 then
				local var_520_11 = Color.New(0, 0, 0)

				arg_517_1.mask_.enabled = false
				var_520_11.a = 0
				arg_517_1.mask_.color = var_520_11
			end

			if arg_517_1.frameCnt_ <= 1 then
				arg_517_1.dialog_:SetActive(false)
			end

			local var_520_12 = 4
			local var_520_13 = 0.875

			if 4 < arg_517_1.time_ and arg_517_1.time_ <= var_520_12 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0

				arg_517_1.dialog_:SetActive(true)

				arg_517_1.dialogCg_.alpha = 0

				local var_520_14 = LeanTween.value(arg_517_1.dialog_, 0, 1, 0.3)

				var_520_14:setOnUpdate(LuaHelper.FloatAction(function(arg_521_0)
					arg_517_1.dialogCg_.alpha = arg_521_0
				end))
				var_520_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_517_1.dialog_)
					var_520_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_517_1.duration_ = arg_517_1.duration_ + 0.3

				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_15 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(123011123).content)

				arg_517_1.text_.text = var_520_15

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_17 = 35 <= 0 and var_520_13 or var_520_13 * (utf8.len(var_520_15) / 35)

				if (35 <= 0 and var_520_13 or var_520_13 * (utf8.len(var_520_15) / 35)) > 0 and var_520_13 < var_520_17 then
					arg_517_1.talkMaxDuration = var_520_17
					var_520_12 = var_520_12 + 0.3

					if var_520_17 + var_520_12 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_17 + var_520_12
					end
				end

				arg_517_1.text_.text = var_520_15
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_18 = var_520_12 + 0.3
			local var_520_19 = math.max(var_520_13, arg_517_1.talkMaxDuration)

			if var_520_12 + 0.3 <= arg_517_1.time_ and arg_517_1.time_ < var_520_18 + var_520_19 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_18) / var_520_19

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_18 + var_520_19 and arg_517_1.time_ < var_520_18 + var_520_19 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play123011124 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 123011124
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play123011125(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.525

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(123011124).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 21 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 21)

				if (21 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 21)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play123011125 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 123011125
		arg_527_1.duration_ = 5.03

		local var_527_0 = {
			zh = 5.033,
			ja = 4.5
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play123011126(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if arg_527_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_530_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_527_1.stage_.transform)

				var_530_0.name = "1019ui_story"
				var_530_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_527_1.actors_["1019ui_story"] = var_530_0

				local var_530_1 = var_530_0:GetComponentInChildren(typeof(CharacterEffect))

				var_530_1.enabled = true

				local var_530_2 = GameObjectTools.GetOrAddComponent(var_530_0, typeof(DynamicBoneHelper))

				if var_530_2 then
					var_530_2:EnableDynamicBone(false)
				end

				arg_527_1:ShowWeapon(var_530_1.transform, false)

				arg_527_1.var_["1019ui_story" .. "Animator"] = var_530_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_527_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_527_1.var_["1019ui_story" .. "LipSync"] = var_530_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_530_3 = arg_527_1.actors_["1019ui_story"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1019ui_story = var_530_3.localPosition
			end

			local var_530_4 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				var_530_3.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_527_1.time_ - 0) / var_530_4)
				var_530_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_3.position).x, (manager.ui.mainCamera.transform.position - var_530_3.position).y, (manager.ui.mainCamera.transform.position - var_530_3.position).z)
				var_530_3.localEulerAngles.z = 0
				var_530_3.localEulerAngles.x = 0
				var_530_3.localEulerAngles = var_530_3.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				var_530_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_530_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_3.position).x, (manager.ui.mainCamera.transform.position - var_530_3.position).y, (manager.ui.mainCamera.transform.position - var_530_3.position).z)
				var_530_3.localEulerAngles.z = 0
				var_530_3.localEulerAngles.x = 0
				var_530_3.localEulerAngles = var_530_3.localEulerAngles
			end

			local var_530_5 = arg_527_1.actors_["1019ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_5) and arg_527_1.var_.characterEffect1019ui_story == nil then
				arg_527_1.var_.characterEffect1019ui_story = var_530_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_6 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_6 and not isNil(var_530_5) then
				if arg_527_1.var_.characterEffect1019ui_story and not isNil(var_530_5) then
					arg_527_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_6 and arg_527_1.time_ < 0 + var_530_6 + arg_530_0 and not isNil(var_530_5) and arg_527_1.var_.characterEffect1019ui_story then
				arg_527_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_530_8 = 0
			local var_530_9 = 0.65

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_8 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_10 = arg_527_1:GetWordFromCfg(123011125)
				local var_530_11 = arg_527_1:FormatText(var_530_10.content)

				arg_527_1.text_.text = var_530_11

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_13 = 26 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 26)

				if (26 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 26)) > 0 and var_530_9 < var_530_13 then
					arg_527_1.talkMaxDuration = var_530_13

					if var_530_13 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_8
					end
				end

				arg_527_1.text_.text = var_530_11
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011125", "story_v_out_123011.awb") ~= 0 then
					local var_530_14 = manager.audio:GetVoiceLength("story_v_out_123011", "123011125", "story_v_out_123011.awb") / 1000

					if var_530_14 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_14 + var_530_8
					end

					if var_530_10.prefab_name ~= "" and arg_527_1.actors_[var_530_10.prefab_name] ~= nil then
						local var_530_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_10.prefab_name].transform, "story_v_out_123011", "123011125", "story_v_out_123011.awb")

						arg_527_1:RecordAudio("123011125", var_530_15)
						arg_527_1:RecordAudio("123011125", var_530_15)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_123011", "123011125", "story_v_out_123011.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_123011", "123011125", "story_v_out_123011.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_16 = math.max(var_530_9, arg_527_1.talkMaxDuration)

			if var_530_8 <= arg_527_1.time_ and arg_527_1.time_ < var_530_8 + var_530_16 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_8) / var_530_16

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_8 + var_530_16 and arg_527_1.time_ < var_530_8 + var_530_16 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
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

		arg_527_1:InitPlayNodeList()
	end,
	Play123011126 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 123011126
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play123011127(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1019ui_story"]) and arg_531_1.var_.characterEffect1019ui_story == nil then
				arg_531_1.var_.characterEffect1019ui_story = arg_531_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1019ui_story"]) then
				if arg_531_1.var_.characterEffect1019ui_story and not isNil(arg_531_1.actors_["1019ui_story"]) then
					arg_531_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_0)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1019ui_story"]) and arg_531_1.var_.characterEffect1019ui_story then
				arg_531_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_534_1 = 0
			local var_534_2 = 1.225

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_3 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(123011126).content)

				arg_531_1.text_.text = var_534_3

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 49 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 49)

				if (49 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 49)) > 0 and var_534_2 < var_534_5 then
					arg_531_1.talkMaxDuration = var_534_5

					if var_534_5 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + var_534_1
					end
				end

				arg_531_1.text_.text = var_534_3
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_6 = math.max(var_534_2, arg_531_1.talkMaxDuration)

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_6 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_1) / var_534_6

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_1 + var_534_6 and arg_531_1.time_ < var_534_1 + var_534_6 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play123011127 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 123011127
		arg_535_1.duration_ = 7.67

		local var_535_0 = {
			zh = 7.666,
			ja = 6.166
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
				arg_535_0:Play123011128(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1019ui_story"]) and arg_535_1.var_.characterEffect1019ui_story == nil then
				arg_535_1.var_.characterEffect1019ui_story = arg_535_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1019ui_story"]) then
				if arg_535_1.var_.characterEffect1019ui_story and not isNil(arg_535_1.actors_["1019ui_story"]) then
					arg_535_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1019ui_story"]) and arg_535_1.var_.characterEffect1019ui_story then
				arg_535_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_538_2 = 0
			local var_538_3 = 0.925

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_2 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_4 = arg_535_1:GetWordFromCfg(123011127)
				local var_538_5 = arg_535_1:FormatText(var_538_4.content)

				arg_535_1.text_.text = var_538_5

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_7 = 37 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_5) / 37)

				if (37 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_5) / 37)) > 0 and var_538_3 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_2 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_2
					end
				end

				arg_535_1.text_.text = var_538_5
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011127", "story_v_out_123011.awb") ~= 0 then
					local var_538_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011127", "story_v_out_123011.awb") / 1000

					if var_538_8 + var_538_2 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_8 + var_538_2
					end

					if var_538_4.prefab_name ~= "" and arg_535_1.actors_[var_538_4.prefab_name] ~= nil then
						local var_538_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_4.prefab_name].transform, "story_v_out_123011", "123011127", "story_v_out_123011.awb")

						arg_535_1:RecordAudio("123011127", var_538_9)
						arg_535_1:RecordAudio("123011127", var_538_9)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_123011", "123011127", "story_v_out_123011.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_123011", "123011127", "story_v_out_123011.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_10 = math.max(var_538_3, arg_535_1.talkMaxDuration)

			if var_538_2 <= arg_535_1.time_ and arg_535_1.time_ < var_538_2 + var_538_10 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_2) / var_538_10

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_2 + var_538_10 and arg_535_1.time_ < var_538_2 + var_538_10 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play123011128 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 123011128
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play123011129(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["1019ui_story"]) and arg_539_1.var_.characterEffect1019ui_story == nil then
				arg_539_1.var_.characterEffect1019ui_story = arg_539_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["1019ui_story"]) then
				if arg_539_1.var_.characterEffect1019ui_story and not isNil(arg_539_1.actors_["1019ui_story"]) then
					arg_539_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_0)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["1019ui_story"]) and arg_539_1.var_.characterEffect1019ui_story then
				arg_539_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_542_1 = 0
			local var_542_2 = 0.325

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(123011128).content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 13 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 13)

				if (13 <= 0 and var_542_2 or var_542_2 * (utf8.len(var_542_3) / 13)) > 0 and var_542_2 < var_542_5 then
					arg_539_1.talkMaxDuration = var_542_5

					if var_542_5 + var_542_1 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + var_542_1
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_6 = math.max(var_542_2, arg_539_1.talkMaxDuration)

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_6 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_1) / var_542_6

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_1 + var_542_6 and arg_539_1.time_ < var_542_1 + var_542_6 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play123011129 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 123011129
		arg_543_1.duration_ = 12.13

		local var_543_0 = {
			zh = 12.133,
			ja = 10
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
				arg_543_0:Play123011130(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1019ui_story"]) and arg_543_1.var_.characterEffect1019ui_story == nil then
				arg_543_1.var_.characterEffect1019ui_story = arg_543_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1019ui_story"]) then
				if arg_543_1.var_.characterEffect1019ui_story and not isNil(arg_543_1.actors_["1019ui_story"]) then
					arg_543_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1019ui_story"]) and arg_543_1.var_.characterEffect1019ui_story then
				arg_543_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_546_2 = 0
			local var_546_3 = 1.4

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_2 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_4 = arg_543_1:GetWordFromCfg(123011129)
				local var_546_5 = arg_543_1:FormatText(var_546_4.content)

				arg_543_1.text_.text = var_546_5

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_7 = 56 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_5) / 56)

				if (56 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_5) / 56)) > 0 and var_546_3 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_2 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_2
					end
				end

				arg_543_1.text_.text = var_546_5
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011129", "story_v_out_123011.awb") ~= 0 then
					local var_546_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011129", "story_v_out_123011.awb") / 1000

					if var_546_8 + var_546_2 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_2
					end

					if var_546_4.prefab_name ~= "" and arg_543_1.actors_[var_546_4.prefab_name] ~= nil then
						local var_546_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_4.prefab_name].transform, "story_v_out_123011", "123011129", "story_v_out_123011.awb")

						arg_543_1:RecordAudio("123011129", var_546_9)
						arg_543_1:RecordAudio("123011129", var_546_9)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_123011", "123011129", "story_v_out_123011.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_123011", "123011129", "story_v_out_123011.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_10 = math.max(var_546_3, arg_543_1.talkMaxDuration)

			if var_546_2 <= arg_543_1.time_ and arg_543_1.time_ < var_546_2 + var_546_10 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_2) / var_546_10

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_2 + var_546_10 and arg_543_1.time_ < var_546_2 + var_546_10 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play123011130 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 123011130
		arg_547_1.duration_ = 8.97

		local var_547_0 = {
			zh = 8.5,
			ja = 8.966
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play123011131(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_550_0 = 0
			local var_550_1 = 0.975

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_2 = arg_547_1:GetWordFromCfg(123011130)
				local var_550_3 = arg_547_1:FormatText(var_550_2.content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 39 <= 0 and var_550_1 or var_550_1 * (utf8.len(var_550_3) / 39)

				if (39 <= 0 and var_550_1 or var_550_1 * (utf8.len(var_550_3) / 39)) > 0 and var_550_1 < var_550_5 then
					arg_547_1.talkMaxDuration = var_550_5

					if var_550_5 + var_550_0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + var_550_0
					end
				end

				arg_547_1.text_.text = var_550_3
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011130", "story_v_out_123011.awb") ~= 0 then
					local var_550_6 = manager.audio:GetVoiceLength("story_v_out_123011", "123011130", "story_v_out_123011.awb") / 1000

					if var_550_6 + var_550_0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_6 + var_550_0
					end

					if var_550_2.prefab_name ~= "" and arg_547_1.actors_[var_550_2.prefab_name] ~= nil then
						local var_550_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_2.prefab_name].transform, "story_v_out_123011", "123011130", "story_v_out_123011.awb")

						arg_547_1:RecordAudio("123011130", var_550_7)
						arg_547_1:RecordAudio("123011130", var_550_7)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_123011", "123011130", "story_v_out_123011.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_123011", "123011130", "story_v_out_123011.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_8 = math.max(var_550_1, arg_547_1.talkMaxDuration)

			if var_550_0 <= arg_547_1.time_ and arg_547_1.time_ < var_550_0 + var_550_8 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_0) / var_550_8

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_0 + var_550_8 and arg_547_1.time_ < var_550_0 + var_550_8 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play123011131 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 123011131
		arg_551_1.duration_ = 9.43

		local var_551_0 = {
			zh = 8.266,
			ja = 9.433
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play123011132(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 1.05

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:GetWordFromCfg(123011131)
				local var_554_2 = arg_551_1:FormatText(var_554_1.content)

				arg_551_1.text_.text = var_554_2

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_4 = 42 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 42)

				if (42 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 42)) > 0 and var_554_0 < var_554_4 then
					arg_551_1.talkMaxDuration = var_554_4

					if var_554_4 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_4 + 0
					end
				end

				arg_551_1.text_.text = var_554_2
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011131", "story_v_out_123011.awb") ~= 0 then
					local var_554_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011131", "story_v_out_123011.awb") / 1000

					if var_554_5 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + 0
					end

					if var_554_1.prefab_name ~= "" and arg_551_1.actors_[var_554_1.prefab_name] ~= nil then
						local var_554_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_1.prefab_name].transform, "story_v_out_123011", "123011131", "story_v_out_123011.awb")

						arg_551_1:RecordAudio("123011131", var_554_6)
						arg_551_1:RecordAudio("123011131", var_554_6)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_123011", "123011131", "story_v_out_123011.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_123011", "123011131", "story_v_out_123011.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_7 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_7 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_7

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_7 and arg_551_1.time_ < 0 + var_554_7 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play123011132 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 123011132
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play123011133(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["1019ui_story"]) and arg_555_1.var_.characterEffect1019ui_story == nil then
				arg_555_1.var_.characterEffect1019ui_story = arg_555_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_0 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["1019ui_story"]) then
				if arg_555_1.var_.characterEffect1019ui_story and not isNil(arg_555_1.actors_["1019ui_story"]) then
					arg_555_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_555_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_555_1.time_ - 0) / var_558_0)
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["1019ui_story"]) and arg_555_1.var_.characterEffect1019ui_story then
				arg_555_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_555_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_558_1 = 0
			local var_558_2 = 0.05

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_3 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(123011132).content)

				arg_555_1.text_.text = var_558_3

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_5 = 2 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_3) / 2)

				if (2 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_3) / 2)) > 0 and var_558_2 < var_558_5 then
					arg_555_1.talkMaxDuration = var_558_5

					if var_558_5 + var_558_1 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_5 + var_558_1
					end
				end

				arg_555_1.text_.text = var_558_3
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_6 = math.max(var_558_2, arg_555_1.talkMaxDuration)

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_6 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_1) / var_558_6

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_1 + var_558_6 and arg_555_1.time_ < var_558_1 + var_558_6 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play123011133 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 123011133
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play123011134(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 1.375

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(123011133).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 55 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 55)

				if (55 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 55)) > 0 and var_562_0 < var_562_3 then
					arg_559_1.talkMaxDuration = var_562_3

					if var_562_3 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_3 + 0
					end
				end

				arg_559_1.text_.text = var_562_1
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_4 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_4 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_4

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_4 and arg_559_1.time_ < 0 + var_562_4 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play123011134 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 123011134
		arg_563_1.duration_ = 4.57

		local var_563_0 = {
			zh = 3.8,
			ja = 4.566
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play123011135(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(arg_563_1.actors_["1019ui_story"]) and arg_563_1.var_.characterEffect1019ui_story == nil then
				arg_563_1.var_.characterEffect1019ui_story = arg_563_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_0 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 and not isNil(arg_563_1.actors_["1019ui_story"]) then
				if arg_563_1.var_.characterEffect1019ui_story and not isNil(arg_563_1.actors_["1019ui_story"]) then
					arg_563_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 and not isNil(arg_563_1.actors_["1019ui_story"]) and arg_563_1.var_.characterEffect1019ui_story then
				arg_563_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_566_2 = 0
			local var_566_3 = 0.425

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_2 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_4 = arg_563_1:GetWordFromCfg(123011134)
				local var_566_5 = arg_563_1:FormatText(var_566_4.content)

				arg_563_1.text_.text = var_566_5

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_7 = 17 <= 0 and var_566_3 or var_566_3 * (utf8.len(var_566_5) / 17)

				if (17 <= 0 and var_566_3 or var_566_3 * (utf8.len(var_566_5) / 17)) > 0 and var_566_3 < var_566_7 then
					arg_563_1.talkMaxDuration = var_566_7

					if var_566_7 + var_566_2 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_7 + var_566_2
					end
				end

				arg_563_1.text_.text = var_566_5
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011134", "story_v_out_123011.awb") ~= 0 then
					local var_566_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011134", "story_v_out_123011.awb") / 1000

					if var_566_8 + var_566_2 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_8 + var_566_2
					end

					if var_566_4.prefab_name ~= "" and arg_563_1.actors_[var_566_4.prefab_name] ~= nil then
						local var_566_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_4.prefab_name].transform, "story_v_out_123011", "123011134", "story_v_out_123011.awb")

						arg_563_1:RecordAudio("123011134", var_566_9)
						arg_563_1:RecordAudio("123011134", var_566_9)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_123011", "123011134", "story_v_out_123011.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_123011", "123011134", "story_v_out_123011.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_10 = math.max(var_566_3, arg_563_1.talkMaxDuration)

			if var_566_2 <= arg_563_1.time_ and arg_563_1.time_ < var_566_2 + var_566_10 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_2) / var_566_10

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_2 + var_566_10 and arg_563_1.time_ < var_566_2 + var_566_10 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play123011135 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 123011135
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play123011136(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1019ui_story"]) and arg_567_1.var_.characterEffect1019ui_story == nil then
				arg_567_1.var_.characterEffect1019ui_story = arg_567_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1019ui_story"]) then
				if arg_567_1.var_.characterEffect1019ui_story and not isNil(arg_567_1.actors_["1019ui_story"]) then
					arg_567_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_567_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_567_1.time_ - 0) / var_570_0)
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1019ui_story"]) and arg_567_1.var_.characterEffect1019ui_story then
				arg_567_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_567_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_570_1 = 0
			local var_570_2 = 1.25

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_3 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(123011135).content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 50 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 50)

				if (50 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 50)) > 0 and var_570_2 < var_570_5 then
					arg_567_1.talkMaxDuration = var_570_5

					if var_570_5 + var_570_1 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + var_570_1
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_6 = math.max(var_570_2, arg_567_1.talkMaxDuration)

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_6 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_1) / var_570_6

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_1 + var_570_6 and arg_567_1.time_ < var_570_1 + var_570_6 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play123011136 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 123011136
		arg_571_1.duration_ = 5.33

		local var_571_0 = {
			zh = 5.333,
			ja = 4.766
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
				arg_571_0:Play123011137(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) and arg_571_1.var_.characterEffect1019ui_story == nil then
				arg_571_1.var_.characterEffect1019ui_story = arg_571_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) then
				if arg_571_1.var_.characterEffect1019ui_story and not isNil(arg_571_1.actors_["1019ui_story"]) then
					arg_571_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1019ui_story"]) and arg_571_1.var_.characterEffect1019ui_story then
				arg_571_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_574_2 = 0
			local var_574_3 = 0.55

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_4 = arg_571_1:GetWordFromCfg(123011136)
				local var_574_5 = arg_571_1:FormatText(var_574_4.content)

				arg_571_1.text_.text = var_574_5

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_7 = 22 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 22)

				if (22 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 22)) > 0 and var_574_3 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_2
					end
				end

				arg_571_1.text_.text = var_574_5
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011136", "story_v_out_123011.awb") ~= 0 then
					local var_574_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011136", "story_v_out_123011.awb") / 1000

					if var_574_8 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_8 + var_574_2
					end

					if var_574_4.prefab_name ~= "" and arg_571_1.actors_[var_574_4.prefab_name] ~= nil then
						local var_574_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_4.prefab_name].transform, "story_v_out_123011", "123011136", "story_v_out_123011.awb")

						arg_571_1:RecordAudio("123011136", var_574_9)
						arg_571_1:RecordAudio("123011136", var_574_9)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_123011", "123011136", "story_v_out_123011.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_123011", "123011136", "story_v_out_123011.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_10 = math.max(var_574_3, arg_571_1.talkMaxDuration)

			if var_574_2 <= arg_571_1.time_ and arg_571_1.time_ < var_574_2 + var_574_10 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_2) / var_574_10

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_2 + var_574_10 and arg_571_1.time_ < var_574_2 + var_574_10 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play123011137 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 123011137
		arg_575_1.duration_ = 15.23

		local var_575_0 = {
			zh = 14.066,
			ja = 15.233
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
				arg_575_0:Play123011138(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 1.375

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_1 = arg_575_1:GetWordFromCfg(123011137)
				local var_578_2 = arg_575_1:FormatText(var_578_1.content)

				arg_575_1.text_.text = var_578_2

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 55 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 55)

				if (55 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 55)) > 0 and var_578_0 < var_578_4 then
					arg_575_1.talkMaxDuration = var_578_4

					if var_578_4 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_4 + 0
					end
				end

				arg_575_1.text_.text = var_578_2
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011137", "story_v_out_123011.awb") ~= 0 then
					local var_578_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011137", "story_v_out_123011.awb") / 1000

					if var_578_5 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + 0
					end

					if var_578_1.prefab_name ~= "" and arg_575_1.actors_[var_578_1.prefab_name] ~= nil then
						local var_578_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_1.prefab_name].transform, "story_v_out_123011", "123011137", "story_v_out_123011.awb")

						arg_575_1:RecordAudio("123011137", var_578_6)
						arg_575_1:RecordAudio("123011137", var_578_6)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_123011", "123011137", "story_v_out_123011.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_123011", "123011137", "story_v_out_123011.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_7 and arg_575_1.time_ < 0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play123011138 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 123011138
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play123011139(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1019ui_story"]) and arg_579_1.var_.characterEffect1019ui_story == nil then
				arg_579_1.var_.characterEffect1019ui_story = arg_579_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1019ui_story"]) then
				if arg_579_1.var_.characterEffect1019ui_story and not isNil(arg_579_1.actors_["1019ui_story"]) then
					arg_579_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_579_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_579_1.time_ - 0) / var_582_0)
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1019ui_story"]) and arg_579_1.var_.characterEffect1019ui_story then
				arg_579_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_579_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_582_1 = 0
			local var_582_2 = 0.725

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_3 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(123011138).content)

				arg_579_1.text_.text = var_582_3

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 29 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_3) / 29)

				if (29 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_3) / 29)) > 0 and var_582_2 < var_582_5 then
					arg_579_1.talkMaxDuration = var_582_5

					if var_582_5 + var_582_1 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + var_582_1
					end
				end

				arg_579_1.text_.text = var_582_3
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_6 = math.max(var_582_2, arg_579_1.talkMaxDuration)

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_6 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_1) / var_582_6

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_1 + var_582_6 and arg_579_1.time_ < var_582_1 + var_582_6 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play123011139 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 123011139
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play123011140(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.8

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_1 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(123011139).content)

				arg_583_1.text_.text = var_586_1

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_3 = 32 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 32)

				if (32 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 32)) > 0 and var_586_0 < var_586_3 then
					arg_583_1.talkMaxDuration = var_586_3

					if var_586_3 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_3 + 0
					end
				end

				arg_583_1.text_.text = var_586_1
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_4 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_4 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_4

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_4 and arg_583_1.time_ < 0 + var_586_4 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play123011140 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 123011140
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play123011141(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0.15

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_1 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(123011140).content)

				arg_587_1.text_.text = var_590_1

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_3 = 6 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 6)

				if (6 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 6)) > 0 and var_590_0 < var_590_3 then
					arg_587_1.talkMaxDuration = var_590_3

					if var_590_3 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_3 + 0
					end
				end

				arg_587_1.text_.text = var_590_1
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_4 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_4 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_4

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_4 and arg_587_1.time_ < 0 + var_590_4 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play123011141 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 123011141
		arg_591_1.duration_ = 4.67

		local var_591_0 = {
			zh = 4.1,
			ja = 4.666
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play123011142(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(arg_591_1.actors_["1019ui_story"]) and arg_591_1.var_.characterEffect1019ui_story == nil then
				arg_591_1.var_.characterEffect1019ui_story = arg_591_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_0 = 0.200000002980232

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_0 and not isNil(arg_591_1.actors_["1019ui_story"]) then
				if arg_591_1.var_.characterEffect1019ui_story and not isNil(arg_591_1.actors_["1019ui_story"]) then
					arg_591_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_591_1.time_ >= 0 + var_594_0 and arg_591_1.time_ < 0 + var_594_0 + arg_594_0 and not isNil(arg_591_1.actors_["1019ui_story"]) and arg_591_1.var_.characterEffect1019ui_story then
				arg_591_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_594_2 = 0
			local var_594_3 = 0.425

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_2 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_4 = arg_591_1:GetWordFromCfg(123011141)
				local var_594_5 = arg_591_1:FormatText(var_594_4.content)

				arg_591_1.text_.text = var_594_5

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_7 = 17 <= 0 and var_594_3 or var_594_3 * (utf8.len(var_594_5) / 17)

				if (17 <= 0 and var_594_3 or var_594_3 * (utf8.len(var_594_5) / 17)) > 0 and var_594_3 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_2 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_2
					end
				end

				arg_591_1.text_.text = var_594_5
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011141", "story_v_out_123011.awb") ~= 0 then
					local var_594_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011141", "story_v_out_123011.awb") / 1000

					if var_594_8 + var_594_2 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_8 + var_594_2
					end

					if var_594_4.prefab_name ~= "" and arg_591_1.actors_[var_594_4.prefab_name] ~= nil then
						local var_594_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_4.prefab_name].transform, "story_v_out_123011", "123011141", "story_v_out_123011.awb")

						arg_591_1:RecordAudio("123011141", var_594_9)
						arg_591_1:RecordAudio("123011141", var_594_9)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_123011", "123011141", "story_v_out_123011.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_123011", "123011141", "story_v_out_123011.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_10 = math.max(var_594_3, arg_591_1.talkMaxDuration)

			if var_594_2 <= arg_591_1.time_ and arg_591_1.time_ < var_594_2 + var_594_10 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_2) / var_594_10

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_2 + var_594_10 and arg_591_1.time_ < var_594_2 + var_594_10 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play123011142 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 123011142
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play123011143(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(arg_595_1.actors_["1019ui_story"]) and arg_595_1.var_.characterEffect1019ui_story == nil then
				arg_595_1.var_.characterEffect1019ui_story = arg_595_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_0 = 0.200000002980232

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 and not isNil(arg_595_1.actors_["1019ui_story"]) then
				if arg_595_1.var_.characterEffect1019ui_story and not isNil(arg_595_1.actors_["1019ui_story"]) then
					arg_595_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_595_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_595_1.time_ - 0) / var_598_0)
				end
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 and not isNil(arg_595_1.actors_["1019ui_story"]) and arg_595_1.var_.characterEffect1019ui_story then
				arg_595_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_595_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_598_1 = 0
			local var_598_2 = 0.1

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_1 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(123011142).content)

				arg_595_1.text_.text = var_598_3

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 4 <= 0 and var_598_2 or var_598_2 * (utf8.len(var_598_3) / 4)

				if (4 <= 0 and var_598_2 or var_598_2 * (utf8.len(var_598_3) / 4)) > 0 and var_598_2 < var_598_5 then
					arg_595_1.talkMaxDuration = var_598_5

					if var_598_5 + var_598_1 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + var_598_1
					end
				end

				arg_595_1.text_.text = var_598_3
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_6 = math.max(var_598_2, arg_595_1.talkMaxDuration)

			if var_598_1 <= arg_595_1.time_ and arg_595_1.time_ < var_598_1 + var_598_6 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_1) / var_598_6

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_1 + var_598_6 and arg_595_1.time_ < var_598_1 + var_598_6 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play123011143 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 123011143
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play123011144(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.var_.moveOldPos1019ui_story = arg_599_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_602_0 = 0.001

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 then
				arg_599_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_599_1.time_ - 0) / var_602_0)
				arg_599_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_599_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1019ui_story"].transform.position).z)
				arg_599_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_599_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_599_1.actors_["1019ui_story"].transform.localEulerAngles = arg_599_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 then
				arg_599_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_599_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_599_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1019ui_story"].transform.position).z)
				arg_599_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_599_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_599_1.actors_["1019ui_story"].transform.localEulerAngles = arg_599_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_602_1 = arg_599_1.actors_["1019ui_story"]

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(var_602_1) and arg_599_1.var_.characterEffect1019ui_story == nil then
				arg_599_1.var_.characterEffect1019ui_story = var_602_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_2 = 0.200000002980232

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_2 and not isNil(var_602_1) then
				if arg_599_1.var_.characterEffect1019ui_story and not isNil(var_602_1) then
					arg_599_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_599_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_599_1.time_ - 0) / var_602_2)
				end
			end

			if arg_599_1.time_ >= 0 + var_602_2 and arg_599_1.time_ < 0 + var_602_2 + arg_602_0 and not isNil(var_602_1) and arg_599_1.var_.characterEffect1019ui_story then
				arg_599_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_599_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_602_3 = 0
			local var_602_4 = 0.475

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_3 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, false)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_5 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(123011143).content)

				arg_599_1.text_.text = var_602_5

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_7 = 19 <= 0 and var_602_4 or var_602_4 * (utf8.len(var_602_5) / 19)

				if (19 <= 0 and var_602_4 or var_602_4 * (utf8.len(var_602_5) / 19)) > 0 and var_602_4 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_3 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_3
					end
				end

				arg_599_1.text_.text = var_602_5
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_8 = math.max(var_602_4, arg_599_1.talkMaxDuration)

			if var_602_3 <= arg_599_1.time_ and arg_599_1.time_ < var_602_3 + var_602_8 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_3) / var_602_8

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_3 + var_602_8 and arg_599_1.time_ < var_602_3 + var_602_8 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
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

		arg_599_1:InitPlayNodeList()
	end,
	Play123011144 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 123011144
		arg_603_1.duration_ = 0.5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"

			SetActive(arg_603_1.choicesGo_, true)

			for iter_604_0, iter_604_1 in ipairs(arg_603_1.choices_) do
				SetActive(iter_604_1.go, iter_604_0 <= 2)
			end

			arg_603_1.choices_[1].txt.text = arg_603_1:FormatText(StoryChoiceCfg[495].name)
			arg_603_1.choices_[2].txt.text = arg_603_1:FormatText(StoryChoiceCfg[496].name)
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play123011145(arg_603_1)
			end

			if arg_605_0 == 2 then
				arg_603_0:Play123011149(arg_603_1)
			end

			arg_603_1:RecordChoiceLog(123011144, 495, 496)
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.allBtn_.enabled = false
			end

			if arg_603_1.time_ >= 0 + 0.5 and arg_603_1.time_ < 0 + 0.5 + arg_606_0 then
				arg_603_1.allBtn_.enabled = true
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play123011145 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 123011145
		arg_607_1.duration_ = 4.53

		local var_607_0 = {
			zh = 3.333,
			ja = 4.533
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play123011146(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.var_.moveOldPos1019ui_story = arg_607_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_610_0 = 0.001

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 then
				arg_607_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_607_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_607_1.time_ - 0) / var_610_0)
				arg_607_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_607_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1019ui_story"].transform.position).z)
				arg_607_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_607_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_607_1.actors_["1019ui_story"].transform.localEulerAngles = arg_607_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 then
				arg_607_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_607_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_607_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1019ui_story"].transform.position).z)
				arg_607_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_607_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_607_1.actors_["1019ui_story"].transform.localEulerAngles = arg_607_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_610_1 = arg_607_1.actors_["1019ui_story"]

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(var_610_1) and arg_607_1.var_.characterEffect1019ui_story == nil then
				arg_607_1.var_.characterEffect1019ui_story = var_610_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_2 = 0.200000002980232

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_2 and not isNil(var_610_1) then
				if arg_607_1.var_.characterEffect1019ui_story and not isNil(var_610_1) then
					arg_607_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= 0 + var_610_2 and arg_607_1.time_ < 0 + var_610_2 + arg_610_0 and not isNil(var_610_1) and arg_607_1.var_.characterEffect1019ui_story then
				arg_607_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_610_4 = 0
			local var_610_5 = 0.45

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_4 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_6 = arg_607_1:GetWordFromCfg(123011145)
				local var_610_7 = arg_607_1:FormatText(var_610_6.content)

				arg_607_1.text_.text = var_610_7

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_9 = 18 <= 0 and var_610_5 or var_610_5 * (utf8.len(var_610_7) / 18)

				if (18 <= 0 and var_610_5 or var_610_5 * (utf8.len(var_610_7) / 18)) > 0 and var_610_5 < var_610_9 then
					arg_607_1.talkMaxDuration = var_610_9

					if var_610_9 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_9 + var_610_4
					end
				end

				arg_607_1.text_.text = var_610_7
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011145", "story_v_out_123011.awb") ~= 0 then
					local var_610_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011145", "story_v_out_123011.awb") / 1000

					if var_610_10 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_10 + var_610_4
					end

					if var_610_6.prefab_name ~= "" and arg_607_1.actors_[var_610_6.prefab_name] ~= nil then
						local var_610_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_6.prefab_name].transform, "story_v_out_123011", "123011145", "story_v_out_123011.awb")

						arg_607_1:RecordAudio("123011145", var_610_11)
						arg_607_1:RecordAudio("123011145", var_610_11)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_123011", "123011145", "story_v_out_123011.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_123011", "123011145", "story_v_out_123011.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_12 = math.max(var_610_5, arg_607_1.talkMaxDuration)

			if var_610_4 <= arg_607_1.time_ and arg_607_1.time_ < var_610_4 + var_610_12 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_4) / var_610_12

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_4 + var_610_12 and arg_607_1.time_ < var_610_4 + var_610_12 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {
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

		arg_607_1:InitPlayNodeList()
	end,
	Play123011146 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 123011146
		arg_611_1.duration_ = 7.6

		local var_611_0 = {
			zh = 5.766,
			ja = 7.6
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play123011147(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = 0.625

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_1 = arg_611_1:GetWordFromCfg(123011146)
				local var_614_2 = arg_611_1:FormatText(var_614_1.content)

				arg_611_1.text_.text = var_614_2

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_4 = 25 <= 0 and var_614_0 or var_614_0 * (utf8.len(var_614_2) / 25)

				if (25 <= 0 and var_614_0 or var_614_0 * (utf8.len(var_614_2) / 25)) > 0 and var_614_0 < var_614_4 then
					arg_611_1.talkMaxDuration = var_614_4

					if var_614_4 + 0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_4 + 0
					end
				end

				arg_611_1.text_.text = var_614_2
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011146", "story_v_out_123011.awb") ~= 0 then
					local var_614_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011146", "story_v_out_123011.awb") / 1000

					if var_614_5 + 0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_5 + 0
					end

					if var_614_1.prefab_name ~= "" and arg_611_1.actors_[var_614_1.prefab_name] ~= nil then
						local var_614_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_1.prefab_name].transform, "story_v_out_123011", "123011146", "story_v_out_123011.awb")

						arg_611_1:RecordAudio("123011146", var_614_6)
						arg_611_1:RecordAudio("123011146", var_614_6)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_out_123011", "123011146", "story_v_out_123011.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_out_123011", "123011146", "story_v_out_123011.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_7 = math.max(var_614_0, arg_611_1.talkMaxDuration)

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_7 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - 0) / var_614_7

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= 0 + var_614_7 and arg_611_1.time_ < 0 + var_614_7 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play123011147 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 123011147
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play123011148(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(arg_615_1.actors_["1019ui_story"]) and arg_615_1.var_.characterEffect1019ui_story == nil then
				arg_615_1.var_.characterEffect1019ui_story = arg_615_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_0 = 0.200000002980232

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 and not isNil(arg_615_1.actors_["1019ui_story"]) then
				if arg_615_1.var_.characterEffect1019ui_story and not isNil(arg_615_1.actors_["1019ui_story"]) then
					arg_615_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_615_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_615_1.time_ - 0) / var_618_0)
				end
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 and not isNil(arg_615_1.actors_["1019ui_story"]) and arg_615_1.var_.characterEffect1019ui_story then
				arg_615_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_615_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_618_1 = 0
			local var_618_2 = 0.55

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_3 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(123011147).content)

				arg_615_1.text_.text = var_618_3

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 22 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 22)

				if (22 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 22)) > 0 and var_618_2 < var_618_5 then
					arg_615_1.talkMaxDuration = var_618_5

					if var_618_5 + var_618_1 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_5 + var_618_1
					end
				end

				arg_615_1.text_.text = var_618_3
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_6 = math.max(var_618_2, arg_615_1.talkMaxDuration)

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_6 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_1) / var_618_6

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_1 + var_618_6 and arg_615_1.time_ < var_618_1 + var_618_6 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play123011148 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 123011148
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play123011149(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0.15

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_1 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(123011148).content)

				arg_619_1.text_.text = var_622_1

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_3 = 6 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 6)

				if (6 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 6)) > 0 and var_622_0 < var_622_3 then
					arg_619_1.talkMaxDuration = var_622_3

					if var_622_3 + 0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_3 + 0
					end
				end

				arg_619_1.text_.text = var_622_1
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_4 = math.max(var_622_0, arg_619_1.talkMaxDuration)

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_4 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - 0) / var_622_4

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= 0 + var_622_4 and arg_619_1.time_ < 0 + var_622_4 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play123011149 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 123011149
		arg_623_1.duration_ = 7.03

		local var_623_0 = {
			zh = 5.7,
			ja = 7.033
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play123011150(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["1019ui_story"]) and arg_623_1.var_.characterEffect1019ui_story == nil then
				arg_623_1.var_.characterEffect1019ui_story = arg_623_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_0 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["1019ui_story"]) then
				if arg_623_1.var_.characterEffect1019ui_story and not isNil(arg_623_1.actors_["1019ui_story"]) then
					arg_623_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["1019ui_story"]) and arg_623_1.var_.characterEffect1019ui_story then
				arg_623_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_626_2 = "1019ui_story"

			if arg_623_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_626_3 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_623_1.stage_.transform)

				var_626_3.name = var_626_2
				var_626_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_623_1.actors_[var_626_2] = var_626_3

				local var_626_4 = var_626_3:GetComponentInChildren(typeof(CharacterEffect))

				var_626_4.enabled = true

				local var_626_5 = GameObjectTools.GetOrAddComponent(var_626_3, typeof(DynamicBoneHelper))

				if var_626_5 then
					var_626_5:EnableDynamicBone(false)
				end

				arg_623_1:ShowWeapon(var_626_4.transform, false)

				arg_623_1.var_[var_626_2 .. "Animator"] = var_626_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_623_1.var_[var_626_2 .. "Animator"].applyRootMotion = true
				arg_623_1.var_[var_626_2 .. "LipSync"] = var_626_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_626_6 = "1019ui_story"

			if arg_623_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_626_7 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_623_1.stage_.transform)

				var_626_7.name = var_626_6
				var_626_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_623_1.actors_[var_626_6] = var_626_7

				local var_626_8 = var_626_7:GetComponentInChildren(typeof(CharacterEffect))

				var_626_8.enabled = true

				local var_626_9 = GameObjectTools.GetOrAddComponent(var_626_7, typeof(DynamicBoneHelper))

				if var_626_9 then
					var_626_9:EnableDynamicBone(false)
				end

				arg_623_1:ShowWeapon(var_626_8.transform, false)

				arg_623_1.var_[var_626_6 .. "Animator"] = var_626_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_623_1.var_[var_626_6 .. "Animator"].applyRootMotion = true
				arg_623_1.var_[var_626_6 .. "LipSync"] = var_626_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_626_10 = arg_623_1.actors_["1019ui_story"].transform

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1019ui_story = var_626_10.localPosition
			end

			local var_626_11 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_11 then
				var_626_10.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_623_1.time_ - 0) / var_626_11)
				var_626_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_10.position).x, (manager.ui.mainCamera.transform.position - var_626_10.position).y, (manager.ui.mainCamera.transform.position - var_626_10.position).z)
				var_626_10.localEulerAngles.z = 0
				var_626_10.localEulerAngles.x = 0
				var_626_10.localEulerAngles = var_626_10.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_11 and arg_623_1.time_ < 0 + var_626_11 + arg_626_0 then
				var_626_10.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_626_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_10.position).x, (manager.ui.mainCamera.transform.position - var_626_10.position).y, (manager.ui.mainCamera.transform.position - var_626_10.position).z)
				var_626_10.localEulerAngles.z = 0
				var_626_10.localEulerAngles.x = 0
				var_626_10.localEulerAngles = var_626_10.localEulerAngles
			end

			local var_626_12 = 0
			local var_626_13 = 0.775

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_12 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_14 = arg_623_1:GetWordFromCfg(123011149)
				local var_626_15 = arg_623_1:FormatText(var_626_14.content)

				arg_623_1.text_.text = var_626_15

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_17 = 31 <= 0 and var_626_13 or var_626_13 * (utf8.len(var_626_15) / 31)

				if (31 <= 0 and var_626_13 or var_626_13 * (utf8.len(var_626_15) / 31)) > 0 and var_626_13 < var_626_17 then
					arg_623_1.talkMaxDuration = var_626_17

					if var_626_17 + var_626_12 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_17 + var_626_12
					end
				end

				arg_623_1.text_.text = var_626_15
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011149", "story_v_out_123011.awb") ~= 0 then
					local var_626_18 = manager.audio:GetVoiceLength("story_v_out_123011", "123011149", "story_v_out_123011.awb") / 1000

					if var_626_18 + var_626_12 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_18 + var_626_12
					end

					if var_626_14.prefab_name ~= "" and arg_623_1.actors_[var_626_14.prefab_name] ~= nil then
						local var_626_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_14.prefab_name].transform, "story_v_out_123011", "123011149", "story_v_out_123011.awb")

						arg_623_1:RecordAudio("123011149", var_626_19)
						arg_623_1:RecordAudio("123011149", var_626_19)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_123011", "123011149", "story_v_out_123011.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_123011", "123011149", "story_v_out_123011.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_20 = math.max(var_626_13, arg_623_1.talkMaxDuration)

			if var_626_12 <= arg_623_1.time_ and arg_623_1.time_ < var_626_12 + var_626_20 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_12) / var_626_20

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_12 + var_626_20 and arg_623_1.time_ < var_626_12 + var_626_20 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
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

		arg_623_1:InitPlayNodeList()
	end,
	Play123011150 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 123011150
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play123011151(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1019ui_story"]) and arg_627_1.var_.characterEffect1019ui_story == nil then
				arg_627_1.var_.characterEffect1019ui_story = arg_627_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.200000002980232

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1019ui_story"]) then
				if arg_627_1.var_.characterEffect1019ui_story and not isNil(arg_627_1.actors_["1019ui_story"]) then
					arg_627_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_627_1.time_ - 0) / var_630_0)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1019ui_story"]) and arg_627_1.var_.characterEffect1019ui_story then
				arg_627_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_630_1 = 0
			local var_630_2 = 0.15

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_3 = arg_627_1:FormatText(arg_627_1:GetWordFromCfg(123011150).content)

				arg_627_1.text_.text = var_630_3

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_5 = 6 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_3) / 6)

				if (6 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_3) / 6)) > 0 and var_630_2 < var_630_5 then
					arg_627_1.talkMaxDuration = var_630_5

					if var_630_5 + var_630_1 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_5 + var_630_1
					end
				end

				arg_627_1.text_.text = var_630_3
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_6 = math.max(var_630_2, arg_627_1.talkMaxDuration)

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_6 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_1) / var_630_6

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_1 + var_630_6 and arg_627_1.time_ < var_630_1 + var_630_6 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play123011151 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 123011151
		arg_631_1.duration_ = 9.23

		local var_631_0 = {
			zh = 4.166,
			ja = 9.233
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play123011152(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1019ui_story"]) and arg_631_1.var_.characterEffect1019ui_story == nil then
				arg_631_1.var_.characterEffect1019ui_story = arg_631_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1019ui_story"]) then
				if arg_631_1.var_.characterEffect1019ui_story and not isNil(arg_631_1.actors_["1019ui_story"]) then
					arg_631_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1019ui_story"]) and arg_631_1.var_.characterEffect1019ui_story then
				arg_631_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_634_2 = 0
			local var_634_3 = 0.525

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_2 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_4 = arg_631_1:GetWordFromCfg(123011151)
				local var_634_5 = arg_631_1:FormatText(var_634_4.content)

				arg_631_1.text_.text = var_634_5

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_7 = 21 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_5) / 21)

				if (21 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_5) / 21)) > 0 and var_634_3 < var_634_7 then
					arg_631_1.talkMaxDuration = var_634_7

					if var_634_7 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_7 + var_634_2
					end
				end

				arg_631_1.text_.text = var_634_5
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011151", "story_v_out_123011.awb") ~= 0 then
					local var_634_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011151", "story_v_out_123011.awb") / 1000

					if var_634_8 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_8 + var_634_2
					end

					if var_634_4.prefab_name ~= "" and arg_631_1.actors_[var_634_4.prefab_name] ~= nil then
						local var_634_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_4.prefab_name].transform, "story_v_out_123011", "123011151", "story_v_out_123011.awb")

						arg_631_1:RecordAudio("123011151", var_634_9)
						arg_631_1:RecordAudio("123011151", var_634_9)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_out_123011", "123011151", "story_v_out_123011.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_out_123011", "123011151", "story_v_out_123011.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_10 = math.max(var_634_3, arg_631_1.talkMaxDuration)

			if var_634_2 <= arg_631_1.time_ and arg_631_1.time_ < var_634_2 + var_634_10 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_2) / var_634_10

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_2 + var_634_10 and arg_631_1.time_ < var_634_2 + var_634_10 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play123011152 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 123011152
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play123011153(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(arg_635_1.actors_["1019ui_story"]) and arg_635_1.var_.characterEffect1019ui_story == nil then
				arg_635_1.var_.characterEffect1019ui_story = arg_635_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_0 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 and not isNil(arg_635_1.actors_["1019ui_story"]) then
				if arg_635_1.var_.characterEffect1019ui_story and not isNil(arg_635_1.actors_["1019ui_story"]) then
					arg_635_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_635_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_635_1.time_ - 0) / var_638_0)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 and not isNil(arg_635_1.actors_["1019ui_story"]) and arg_635_1.var_.characterEffect1019ui_story then
				arg_635_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_635_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_638_1 = 0
			local var_638_2 = 0.25

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_3 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(123011152).content)

				arg_635_1.text_.text = var_638_3

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 10 <= 0 and var_638_2 or var_638_2 * (utf8.len(var_638_3) / 10)

				if (10 <= 0 and var_638_2 or var_638_2 * (utf8.len(var_638_3) / 10)) > 0 and var_638_2 < var_638_5 then
					arg_635_1.talkMaxDuration = var_638_5

					if var_638_5 + var_638_1 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_5 + var_638_1
					end
				end

				arg_635_1.text_.text = var_638_3
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_6 = math.max(var_638_2, arg_635_1.talkMaxDuration)

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_6 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_1) / var_638_6

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_1 + var_638_6 and arg_635_1.time_ < var_638_1 + var_638_6 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play123011153 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 123011153
		arg_639_1.duration_ = 9

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play123011154(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 1.999999999999 < arg_639_1.time_ and arg_639_1.time_ <= 1.999999999999 + arg_642_0 then
				local var_642_0 = arg_639_1.bgs_.STblack

				arg_639_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_642_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_642_1 = var_642_0:GetComponent("SpriteRenderer")

				if var_642_1 and var_642_1.sprite then
					local var_642_2 = 2 * (var_642_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_642_0.transform.localScale = Vector3.New(var_642_2 / var_642_1.sprite.bounds.size.y < var_642_2 * manager.ui.mainCameraCom_.aspect / var_642_1.sprite.bounds.size.x and var_642_2 * manager.ui.mainCameraCom_.aspect / var_642_1.sprite.bounds.size.x or var_642_2 / var_642_1.sprite.bounds.size.y, var_642_2 / var_642_1.sprite.bounds.size.y < var_642_2 * manager.ui.mainCameraCom_.aspect / var_642_1.sprite.bounds.size.x and var_642_2 * manager.ui.mainCameraCom_.aspect / var_642_1.sprite.bounds.size.x or var_642_2 / var_642_1.sprite.bounds.size.y, 0)
				end

				for iter_642_0, iter_642_1 in pairs(arg_639_1.bgs_) do
					if iter_642_0 ~= "STblack" then
						iter_642_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_642_3 = 0

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_3 + arg_642_0 then
				arg_639_1.mask_.enabled = true
				arg_639_1.mask_.raycastTarget = true

				arg_639_1:SetGaussion(false)
			end

			local var_642_4 = 2

			if var_642_3 <= arg_639_1.time_ and arg_639_1.time_ < var_642_3 + var_642_4 then
				local var_642_5 = Color.New(0, 0, 0)

				var_642_5.a = Mathf.Lerp(0, 1, (arg_639_1.time_ - var_642_3) / var_642_4)
				arg_639_1.mask_.color = var_642_5
			end

			if arg_639_1.time_ >= var_642_3 + var_642_4 and arg_639_1.time_ < var_642_3 + var_642_4 + arg_642_0 then
				local var_642_6 = Color.New(0, 0, 0)

				var_642_6.a = 1
				arg_639_1.mask_.color = var_642_6
			end

			local var_642_7 = 2

			if 2 < arg_639_1.time_ and arg_639_1.time_ <= var_642_7 + arg_642_0 then
				arg_639_1.mask_.enabled = true
				arg_639_1.mask_.raycastTarget = true

				arg_639_1:SetGaussion(false)
			end

			local var_642_8 = 2

			if var_642_7 <= arg_639_1.time_ and arg_639_1.time_ < var_642_7 + var_642_8 then
				local var_642_9 = Color.New(0, 0, 0)

				var_642_9.a = Mathf.Lerp(1, 0, (arg_639_1.time_ - var_642_7) / var_642_8)
				arg_639_1.mask_.color = var_642_9
			end

			if arg_639_1.time_ >= var_642_7 + var_642_8 and arg_639_1.time_ < var_642_7 + var_642_8 + arg_642_0 then
				local var_642_10 = Color.New(0, 0, 0)

				arg_639_1.mask_.enabled = false
				var_642_10.a = 0
				arg_639_1.mask_.color = var_642_10
			end

			local var_642_11 = arg_639_1.actors_["1019ui_story"].transform

			if 1.966 < arg_639_1.time_ and arg_639_1.time_ <= 1.966 + arg_642_0 then
				arg_639_1.var_.moveOldPos1019ui_story = var_642_11.localPosition
			end

			local var_642_12 = 0.001

			if 1.966 <= arg_639_1.time_ and arg_639_1.time_ < 1.966 + var_642_12 then
				var_642_11.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_639_1.time_ - 1.966) / var_642_12)
				var_642_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_642_11.position).x, (manager.ui.mainCamera.transform.position - var_642_11.position).y, (manager.ui.mainCamera.transform.position - var_642_11.position).z)
				var_642_11.localEulerAngles.z = 0
				var_642_11.localEulerAngles.x = 0
				var_642_11.localEulerAngles = var_642_11.localEulerAngles
			end

			if arg_639_1.time_ >= 1.966 + var_642_12 and arg_639_1.time_ < 1.966 + var_642_12 + arg_642_0 then
				var_642_11.localPosition = Vector3.New(0, 100, 0)
				var_642_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_642_11.position).x, (manager.ui.mainCamera.transform.position - var_642_11.position).y, (manager.ui.mainCamera.transform.position - var_642_11.position).z)
				var_642_11.localEulerAngles.z = 0
				var_642_11.localEulerAngles.x = 0
				var_642_11.localEulerAngles = var_642_11.localEulerAngles
			end

			if arg_639_1.frameCnt_ <= 1 then
				arg_639_1.dialog_:SetActive(false)
			end

			local var_642_13 = 3.999999999999
			local var_642_14 = 0.45

			if 3.999999999999 < arg_639_1.time_ and arg_639_1.time_ <= var_642_13 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0

				arg_639_1.dialog_:SetActive(true)

				arg_639_1.dialogCg_.alpha = 0

				local var_642_15 = LeanTween.value(arg_639_1.dialog_, 0, 1, 0.3)

				var_642_15:setOnUpdate(LuaHelper.FloatAction(function(arg_643_0)
					arg_639_1.dialogCg_.alpha = arg_643_0
				end))
				var_642_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_639_1.dialog_)
					var_642_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_639_1.duration_ = arg_639_1.duration_ + 0.3

				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_16 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(123011153).content)

				arg_639_1.text_.text = var_642_16

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_18 = 18 <= 0 and var_642_14 or var_642_14 * (utf8.len(var_642_16) / 18)

				if (18 <= 0 and var_642_14 or var_642_14 * (utf8.len(var_642_16) / 18)) > 0 and var_642_14 < var_642_18 then
					arg_639_1.talkMaxDuration = var_642_18
					var_642_13 = var_642_13 + 0.3

					if var_642_18 + var_642_13 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_18 + var_642_13
					end
				end

				arg_639_1.text_.text = var_642_16
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_19 = var_642_13 + 0.3
			local var_642_20 = math.max(var_642_14, arg_639_1.talkMaxDuration)

			if var_642_13 + 0.3 <= arg_639_1.time_ and arg_639_1.time_ < var_642_19 + var_642_20 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_19) / var_642_20

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_19 + var_642_20 and arg_639_1.time_ < var_642_19 + var_642_20 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play123011154 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 123011154
		arg_645_1.duration_ = 7

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play123011155(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if arg_645_1.bgs_.XH0607 == nil then
				local var_648_0 = Object.Instantiate(arg_645_1.paintGo_)

				var_648_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0607")
				var_648_0.name = "XH0607"
				var_648_0.transform.parent = arg_645_1.stage_.transform
				var_648_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_645_1.bgs_.XH0607 = var_648_0
			end

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				local var_648_1 = arg_645_1.bgs_.XH0607

				arg_645_1.bgs_.XH0607.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_648_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_648_2 = var_648_1:GetComponent("SpriteRenderer")

				if var_648_2 and var_648_2.sprite then
					local var_648_3 = 2 * (var_648_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_648_1.transform.localScale = Vector3.New(var_648_3 / var_648_2.sprite.bounds.size.y < var_648_3 * manager.ui.mainCameraCom_.aspect / var_648_2.sprite.bounds.size.x and var_648_3 * manager.ui.mainCameraCom_.aspect / var_648_2.sprite.bounds.size.x or var_648_3 / var_648_2.sprite.bounds.size.y, var_648_3 / var_648_2.sprite.bounds.size.y < var_648_3 * manager.ui.mainCameraCom_.aspect / var_648_2.sprite.bounds.size.x and var_648_3 * manager.ui.mainCameraCom_.aspect / var_648_2.sprite.bounds.size.x or var_648_3 / var_648_2.sprite.bounds.size.y, 0)
				end

				for iter_648_0, iter_648_1 in pairs(arg_645_1.bgs_) do
					if iter_648_0 ~= "XH0607" then
						iter_648_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_648_4 = 0

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_4 + arg_648_0 then
				arg_645_1.mask_.enabled = true
				arg_645_1.mask_.raycastTarget = true

				arg_645_1:SetGaussion(false)
			end

			local var_648_5 = 2

			if var_648_4 <= arg_645_1.time_ and arg_645_1.time_ < var_648_4 + var_648_5 then
				local var_648_6 = Color.New(0, 0, 0)

				var_648_6.a = Mathf.Lerp(1, 0, (arg_645_1.time_ - var_648_4) / var_648_5)
				arg_645_1.mask_.color = var_648_6
			end

			if arg_645_1.time_ >= var_648_4 + var_648_5 and arg_645_1.time_ < var_648_4 + var_648_5 + arg_648_0 then
				local var_648_7 = Color.New(0, 0, 0)

				arg_645_1.mask_.enabled = false
				var_648_7.a = 0
				arg_645_1.mask_.color = var_648_7
			end

			local var_648_8 = arg_645_1.bgs_.XH0607.transform

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.var_.moveOldPosXH0607 = var_648_8.localPosition
			end

			local var_648_9 = 0.001

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_9 then
				var_648_8.localPosition = Vector3.Lerp(arg_645_1.var_.moveOldPosXH0607, Vector3.New(-1.5, 0, 0), (arg_645_1.time_ - 0) / var_648_9)
			end

			if arg_645_1.time_ >= 0 + var_648_9 and arg_645_1.time_ < 0 + var_648_9 + arg_648_0 then
				var_648_8.localPosition = Vector3.New(-1.5, 0, 0)
			end

			local var_648_10 = arg_645_1.bgs_.XH0607.transform

			if 0.0166666666666667 < arg_645_1.time_ and arg_645_1.time_ <= 0.0166666666666667 + arg_648_0 then
				arg_645_1.var_.moveOldPosXH0607 = var_648_10.localPosition
			end

			local var_648_11 = 4.033331

			if 0.0166666666666667 <= arg_645_1.time_ and arg_645_1.time_ < 0.0166666666666667 + var_648_11 then
				var_648_10.localPosition = Vector3.Lerp(arg_645_1.var_.moveOldPosXH0607, Vector3.New(-1.5, -0.5, 0), (arg_645_1.time_ - 0.0166666666666667) / var_648_11)
			end

			if arg_645_1.time_ >= 0.0166666666666667 + var_648_11 and arg_645_1.time_ < 0.0166666666666667 + var_648_11 + arg_648_0 then
				var_648_10.localPosition = Vector3.New(-1.5, -0.5, 0)
			end

			local var_648_12 = 2

			if 2 < arg_645_1.time_ and arg_645_1.time_ <= var_648_12 + arg_648_0 then
				arg_645_1.allBtn_.enabled = false
			end

			if arg_645_1.time_ >= var_648_12 + 2.04999766666667 and arg_645_1.time_ < var_648_12 + 2.04999766666667 + arg_648_0 then
				arg_645_1.allBtn_.enabled = true
			end

			local var_648_13 = 2
			local var_648_14 = 0.675

			if 2 < arg_645_1.time_ and arg_645_1.time_ <= var_648_13 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_15 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(123011154).content)

				arg_645_1.text_.text = var_648_15

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_17 = 27 <= 0 and var_648_14 or var_648_14 * (utf8.len(var_648_15) / 27)

				if (27 <= 0 and var_648_14 or var_648_14 * (utf8.len(var_648_15) / 27)) > 0 and var_648_14 < var_648_17 then
					arg_645_1.talkMaxDuration = var_648_17

					if var_648_17 + var_648_13 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_17 + var_648_13
					end
				end

				arg_645_1.text_.text = var_648_15
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_18 = math.max(var_648_14, arg_645_1.talkMaxDuration)

			if var_648_13 <= arg_645_1.time_ and arg_645_1.time_ < var_648_13 + var_648_18 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_13) / var_648_18

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_13 + var_648_18 and arg_645_1.time_ < var_648_13 + var_648_18 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0607",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0607",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.033331,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_645_1:InitPlayNodeList()
	end,
	Play123011155 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 123011155
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play123011156(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_652_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_649_1.bgmTxt_.text ~= var_652_2 and arg_649_1.bgmTxt_.text ~= "" then
						if arg_649_1.bgmTxt2_.text ~= "" then
							arg_649_1.bgmTxt_.text = arg_649_1.bgmTxt2_.text
						end

						arg_649_1.bgmTxt2_.text = var_652_2

						arg_649_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_649_1.bgmTxt_.text = var_652_2
						arg_649_1.bgmTxt2_.text = var_652_2
					end

					if arg_649_1.bgmTimer then
						arg_649_1.bgmTimer:Stop()

						arg_649_1.bgmTimer = nil
					end

					if arg_649_1.settingData.show_music_name == 1 then
						arg_649_1.musicController:SetSelectedState("show")
						arg_649_1.musicAnimator_:Play("open", 0, 0)

						if arg_649_1.settingData.music_time ~= 0 then
							arg_649_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_649_1.settingData.music_time), function()
								if arg_649_1 == nil or isNil(arg_649_1.bgmTxt_) then
									return
								end

								arg_649_1.musicController:SetSelectedState("hide")
								arg_649_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1:AudioAction("stop", "effect", "se_story_123_01", "se_story_123_01_medical", "")
			end

			local var_652_4 = 0
			local var_652_5 = 0.95

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_4 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_6 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(123011155).content)

				arg_649_1.text_.text = var_652_6

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_8 = 38 <= 0 and var_652_5 or var_652_5 * (utf8.len(var_652_6) / 38)

				if (38 <= 0 and var_652_5 or var_652_5 * (utf8.len(var_652_6) / 38)) > 0 and var_652_5 < var_652_8 then
					arg_649_1.talkMaxDuration = var_652_8

					if var_652_8 + var_652_4 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_8 + var_652_4
					end
				end

				arg_649_1.text_.text = var_652_6
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_9 = math.max(var_652_5, arg_649_1.talkMaxDuration)

			if var_652_4 <= arg_649_1.time_ and arg_649_1.time_ < var_652_4 + var_652_9 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_4) / var_652_9

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_4 + var_652_9 and arg_649_1.time_ < var_652_4 + var_652_9 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play123011156 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 123011156
		arg_654_1.duration_ = 9

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play123011157(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			if arg_654_1.bgs_.ST12 == nil then
				local var_657_0 = Object.Instantiate(arg_654_1.paintGo_)

				var_657_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_657_0.name = "ST12"
				var_657_0.transform.parent = arg_654_1.stage_.transform
				var_657_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_654_1.bgs_.ST12 = var_657_0
			end

			if 1.999999999999 < arg_654_1.time_ and arg_654_1.time_ <= 1.999999999999 + arg_657_0 then
				local var_657_1 = arg_654_1.bgs_.ST12

				arg_654_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_657_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_657_2 = var_657_1:GetComponent("SpriteRenderer")

				if var_657_2 and var_657_2.sprite then
					local var_657_3 = 2 * (var_657_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_657_1.transform.localScale = Vector3.New(var_657_3 / var_657_2.sprite.bounds.size.y < var_657_3 * manager.ui.mainCameraCom_.aspect / var_657_2.sprite.bounds.size.x and var_657_3 * manager.ui.mainCameraCom_.aspect / var_657_2.sprite.bounds.size.x or var_657_3 / var_657_2.sprite.bounds.size.y, var_657_3 / var_657_2.sprite.bounds.size.y < var_657_3 * manager.ui.mainCameraCom_.aspect / var_657_2.sprite.bounds.size.x and var_657_3 * manager.ui.mainCameraCom_.aspect / var_657_2.sprite.bounds.size.x or var_657_3 / var_657_2.sprite.bounds.size.y, 0)
				end

				for iter_657_0, iter_657_1 in pairs(arg_654_1.bgs_) do
					if iter_657_0 ~= "ST12" then
						iter_657_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_657_4 = 0

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_4 + arg_657_0 then
				arg_654_1.mask_.enabled = true
				arg_654_1.mask_.raycastTarget = true

				arg_654_1:SetGaussion(false)
			end

			local var_657_5 = 2

			if var_657_4 <= arg_654_1.time_ and arg_654_1.time_ < var_657_4 + var_657_5 then
				local var_657_6 = Color.New(0, 0, 0)

				var_657_6.a = Mathf.Lerp(0, 1, (arg_654_1.time_ - var_657_4) / var_657_5)
				arg_654_1.mask_.color = var_657_6
			end

			if arg_654_1.time_ >= var_657_4 + var_657_5 and arg_654_1.time_ < var_657_4 + var_657_5 + arg_657_0 then
				local var_657_7 = Color.New(0, 0, 0)

				var_657_7.a = 1
				arg_654_1.mask_.color = var_657_7
			end

			local var_657_8 = 2

			if 2 < arg_654_1.time_ and arg_654_1.time_ <= var_657_8 + arg_657_0 then
				arg_654_1.mask_.enabled = true
				arg_654_1.mask_.raycastTarget = true

				arg_654_1:SetGaussion(false)
			end

			local var_657_9 = 2

			if var_657_8 <= arg_654_1.time_ and arg_654_1.time_ < var_657_8 + var_657_9 then
				local var_657_10 = Color.New(0, 0, 0)

				var_657_10.a = Mathf.Lerp(1, 0, (arg_654_1.time_ - var_657_8) / var_657_9)
				arg_654_1.mask_.color = var_657_10
			end

			if arg_654_1.time_ >= var_657_8 + var_657_9 and arg_654_1.time_ < var_657_8 + var_657_9 + arg_657_0 then
				local var_657_11 = Color.New(0, 0, 0)

				arg_654_1.mask_.enabled = false
				var_657_11.a = 0
				arg_654_1.mask_.color = var_657_11
			end

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_657_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_654_1.bgmTxt_.text ~= var_657_14 and arg_654_1.bgmTxt_.text ~= "" then
						if arg_654_1.bgmTxt2_.text ~= "" then
							arg_654_1.bgmTxt_.text = arg_654_1.bgmTxt2_.text
						end

						arg_654_1.bgmTxt2_.text = var_657_14

						arg_654_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_654_1.bgmTxt_.text = var_657_14
						arg_654_1.bgmTxt2_.text = var_657_14
					end

					if arg_654_1.bgmTimer then
						arg_654_1.bgmTimer:Stop()

						arg_654_1.bgmTimer = nil
					end

					if arg_654_1.settingData.show_music_name == 1 then
						arg_654_1.musicController:SetSelectedState("show")
						arg_654_1.musicAnimator_:Play("open", 0, 0)

						if arg_654_1.settingData.music_time ~= 0 then
							arg_654_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_654_1.settingData.music_time), function()
								if arg_654_1 == nil or isNil(arg_654_1.bgmTxt_) then
									return
								end

								arg_654_1.musicController:SetSelectedState("hide")
								arg_654_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.76666666666667 < arg_654_1.time_ and arg_654_1.time_ <= 3.76666666666667 + arg_657_0 then
				arg_654_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_657_17 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_654_1.bgmTxt_.text ~= var_657_17 and arg_654_1.bgmTxt_.text ~= "" then
						if arg_654_1.bgmTxt2_.text ~= "" then
							arg_654_1.bgmTxt_.text = arg_654_1.bgmTxt2_.text
						end

						arg_654_1.bgmTxt2_.text = var_657_17

						arg_654_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_654_1.bgmTxt_.text = var_657_17
						arg_654_1.bgmTxt2_.text = var_657_17
					end

					if arg_654_1.bgmTimer then
						arg_654_1.bgmTimer:Stop()

						arg_654_1.bgmTimer = nil
					end

					if arg_654_1.settingData.show_music_name == 1 then
						arg_654_1.musicController:SetSelectedState("show")
						arg_654_1.musicAnimator_:Play("open", 0, 0)

						if arg_654_1.settingData.music_time ~= 0 then
							arg_654_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_654_1.settingData.music_time), function()
								if arg_654_1 == nil or isNil(arg_654_1.bgmTxt_) then
									return
								end

								arg_654_1.musicController:SetSelectedState("hide")
								arg_654_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_654_1.frameCnt_ <= 1 then
				arg_654_1.dialog_:SetActive(false)
			end

			local var_657_18 = 3.999999999999
			local var_657_19 = 1.1

			if 3.999999999999 < arg_654_1.time_ and arg_654_1.time_ <= var_657_18 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0

				arg_654_1.dialog_:SetActive(true)

				arg_654_1.dialogCg_.alpha = 0

				local var_657_20 = LeanTween.value(arg_654_1.dialog_, 0, 1, 0.3)

				var_657_20:setOnUpdate(LuaHelper.FloatAction(function(arg_660_0)
					arg_654_1.dialogCg_.alpha = arg_660_0
				end))
				var_657_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_654_1.dialog_)
					var_657_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_654_1.duration_ = arg_654_1.duration_ + 0.3

				SetActive(arg_654_1.leftNameGo_, false)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_654_1.iconTrs_.gameObject, false)
				arg_654_1.callingController_:SetSelectedState("normal")

				local var_657_21 = arg_654_1:FormatText(arg_654_1:GetWordFromCfg(123011156).content)

				arg_654_1.text_.text = var_657_21

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_23 = 44 <= 0 and var_657_19 or var_657_19 * (utf8.len(var_657_21) / 44)

				if (44 <= 0 and var_657_19 or var_657_19 * (utf8.len(var_657_21) / 44)) > 0 and var_657_19 < var_657_23 then
					arg_654_1.talkMaxDuration = var_657_23
					var_657_18 = var_657_18 + 0.3

					if var_657_23 + var_657_18 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_23 + var_657_18
					end
				end

				arg_654_1.text_.text = var_657_21
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_24 = var_657_18 + 0.3
			local var_657_25 = math.max(var_657_19, arg_654_1.talkMaxDuration)

			if var_657_18 + 0.3 <= arg_654_1.time_ and arg_654_1.time_ < var_657_24 + var_657_25 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_24) / var_657_25

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_24 + var_657_25 and arg_654_1.time_ < var_657_24 + var_657_25 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play123011157 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 123011157
		arg_662_1.duration_ = 15.9

		local var_662_0 = {
			zh = 12.6,
			ja = 15.9
		}
		local var_662_1 = manager.audio:GetLocalizationFlag()

		if var_662_0[var_662_1] ~= nil then
			arg_662_1.duration_ = var_662_0[var_662_1]
		end

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play123011158(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			if arg_662_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_665_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_662_1.stage_.transform)

				var_665_0.name = "1033ui_story"
				var_665_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_662_1.actors_["1033ui_story"] = var_665_0

				local var_665_1 = var_665_0:GetComponentInChildren(typeof(CharacterEffect))

				var_665_1.enabled = true

				local var_665_2 = GameObjectTools.GetOrAddComponent(var_665_0, typeof(DynamicBoneHelper))

				if var_665_2 then
					var_665_2:EnableDynamicBone(false)
				end

				arg_662_1:ShowWeapon(var_665_1.transform, false)

				arg_662_1.var_["1033ui_story" .. "Animator"] = var_665_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_662_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_662_1.var_["1033ui_story" .. "LipSync"] = var_665_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_665_3 = arg_662_1.actors_["1033ui_story"].transform

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				arg_662_1.var_.moveOldPos1033ui_story = var_665_3.localPosition
			end

			local var_665_4 = 0.001

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_4 then
				var_665_3.localPosition = Vector3.Lerp(arg_662_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_662_1.time_ - 0) / var_665_4)
				var_665_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_665_3.position).x, (manager.ui.mainCamera.transform.position - var_665_3.position).y, (manager.ui.mainCamera.transform.position - var_665_3.position).z)
				var_665_3.localEulerAngles.z = 0
				var_665_3.localEulerAngles.x = 0
				var_665_3.localEulerAngles = var_665_3.localEulerAngles
			end

			if arg_662_1.time_ >= 0 + var_665_4 and arg_662_1.time_ < 0 + var_665_4 + arg_665_0 then
				var_665_3.localPosition = Vector3.New(0, -1.01, -6.13)
				var_665_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_665_3.position).x, (manager.ui.mainCamera.transform.position - var_665_3.position).y, (manager.ui.mainCamera.transform.position - var_665_3.position).z)
				var_665_3.localEulerAngles.z = 0
				var_665_3.localEulerAngles.x = 0
				var_665_3.localEulerAngles = var_665_3.localEulerAngles
			end

			local var_665_5 = arg_662_1.actors_["1033ui_story"]

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 and not isNil(var_665_5) and arg_662_1.var_.characterEffect1033ui_story == nil then
				arg_662_1.var_.characterEffect1033ui_story = var_665_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_6 = 0.200000002980232

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_6 and not isNil(var_665_5) then
				if arg_662_1.var_.characterEffect1033ui_story and not isNil(var_665_5) then
					arg_662_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_662_1.time_ >= 0 + var_665_6 and arg_662_1.time_ < 0 + var_665_6 + arg_665_0 and not isNil(var_665_5) and arg_662_1.var_.characterEffect1033ui_story then
				arg_662_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				arg_662_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				arg_662_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_665_8 = 0
			local var_665_9 = 1.675

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_8 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_10 = arg_662_1:GetWordFromCfg(123011157)
				local var_665_11 = arg_662_1:FormatText(var_665_10.content)

				arg_662_1.text_.text = var_665_11

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_13 = 67 <= 0 and var_665_9 or var_665_9 * (utf8.len(var_665_11) / 67)

				if (67 <= 0 and var_665_9 or var_665_9 * (utf8.len(var_665_11) / 67)) > 0 and var_665_9 < var_665_13 then
					arg_662_1.talkMaxDuration = var_665_13

					if var_665_13 + var_665_8 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_13 + var_665_8
					end
				end

				arg_662_1.text_.text = var_665_11
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011157", "story_v_out_123011.awb") ~= 0 then
					local var_665_14 = manager.audio:GetVoiceLength("story_v_out_123011", "123011157", "story_v_out_123011.awb") / 1000

					if var_665_14 + var_665_8 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_14 + var_665_8
					end

					if var_665_10.prefab_name ~= "" and arg_662_1.actors_[var_665_10.prefab_name] ~= nil then
						local var_665_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_10.prefab_name].transform, "story_v_out_123011", "123011157", "story_v_out_123011.awb")

						arg_662_1:RecordAudio("123011157", var_665_15)
						arg_662_1:RecordAudio("123011157", var_665_15)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_out_123011", "123011157", "story_v_out_123011.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_out_123011", "123011157", "story_v_out_123011.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_16 = math.max(var_665_9, arg_662_1.talkMaxDuration)

			if var_665_8 <= arg_662_1.time_ and arg_662_1.time_ < var_665_8 + var_665_16 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_8) / var_665_16

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_8 + var_665_16 and arg_662_1.time_ < var_665_8 + var_665_16 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_662_1:InitPlayNodeList()
	end,
	Play123011158 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 123011158
		arg_666_1.duration_ = 15.17

		local var_666_0 = {
			zh = 10.666,
			ja = 15.166
		}
		local var_666_1 = manager.audio:GetLocalizationFlag()

		if var_666_0[var_666_1] ~= nil then
			arg_666_1.duration_ = var_666_0[var_666_1]
		end

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play123011159(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = 1.25

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, true)

				arg_666_1.leftNameTxt_.text = arg_666_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_666_1.leftNameTxt_.transform)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1.leftNameTxt_.text)
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_1 = arg_666_1:GetWordFromCfg(123011158)
				local var_669_2 = arg_666_1:FormatText(var_669_1.content)

				arg_666_1.text_.text = var_669_2

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_4 = 50 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_2) / 50)

				if (50 <= 0 and var_669_0 or var_669_0 * (utf8.len(var_669_2) / 50)) > 0 and var_669_0 < var_669_4 then
					arg_666_1.talkMaxDuration = var_669_4

					if var_669_4 + 0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_4 + 0
					end
				end

				arg_666_1.text_.text = var_669_2
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011158", "story_v_out_123011.awb") ~= 0 then
					local var_669_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011158", "story_v_out_123011.awb") / 1000

					if var_669_5 + 0 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_5 + 0
					end

					if var_669_1.prefab_name ~= "" and arg_666_1.actors_[var_669_1.prefab_name] ~= nil then
						local var_669_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_666_1.actors_[var_669_1.prefab_name].transform, "story_v_out_123011", "123011158", "story_v_out_123011.awb")

						arg_666_1:RecordAudio("123011158", var_669_6)
						arg_666_1:RecordAudio("123011158", var_669_6)
					else
						arg_666_1:AudioAction("play", "voice", "story_v_out_123011", "123011158", "story_v_out_123011.awb")
					end

					arg_666_1:RecordHistoryTalkVoice("story_v_out_123011", "123011158", "story_v_out_123011.awb")
				end

				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_7 = math.max(var_669_0, arg_666_1.talkMaxDuration)

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_7 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - 0) / var_669_7

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= 0 + var_669_7 and arg_666_1.time_ < 0 + var_669_7 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play123011159 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 123011159
		arg_670_1.duration_ = 5

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play123011160(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 and not isNil(arg_670_1.actors_["1033ui_story"]) and arg_670_1.var_.characterEffect1033ui_story == nil then
				arg_670_1.var_.characterEffect1033ui_story = arg_670_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_673_0 = 0.200000002980232

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_0 and not isNil(arg_670_1.actors_["1033ui_story"]) then
				if arg_670_1.var_.characterEffect1033ui_story and not isNil(arg_670_1.actors_["1033ui_story"]) then
					arg_670_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_670_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_670_1.time_ - 0) / var_673_0)
				end
			end

			if arg_670_1.time_ >= 0 + var_673_0 and arg_670_1.time_ < 0 + var_673_0 + arg_673_0 and not isNil(arg_670_1.actors_["1033ui_story"]) and arg_670_1.var_.characterEffect1033ui_story then
				arg_670_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_670_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_673_1 = 0
			local var_673_2 = 0.325

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= var_673_1 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, true)

				arg_670_1.leftNameTxt_.text = arg_670_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_670_1.leftNameTxt_.transform)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1.leftNameTxt_.text)
				SetActive(arg_670_1.iconTrs_.gameObject, true)
				arg_670_1.iconController_:SetSelectedState("hero")

				arg_670_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_670_1.callingController_:SetSelectedState("normal")

				arg_670_1.keyicon_.color = Color.New(1, 1, 1)
				arg_670_1.icon_.color = Color.New(1, 1, 1)

				local var_673_3 = arg_670_1:FormatText(arg_670_1:GetWordFromCfg(123011159).content)

				arg_670_1.text_.text = var_673_3

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_5 = 13 <= 0 and var_673_2 or var_673_2 * (utf8.len(var_673_3) / 13)

				if (13 <= 0 and var_673_2 or var_673_2 * (utf8.len(var_673_3) / 13)) > 0 and var_673_2 < var_673_5 then
					arg_670_1.talkMaxDuration = var_673_5

					if var_673_5 + var_673_1 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_5 + var_673_1
					end
				end

				arg_670_1.text_.text = var_673_3
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)
				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_6 = math.max(var_673_2, arg_670_1.talkMaxDuration)

			if var_673_1 <= arg_670_1.time_ and arg_670_1.time_ < var_673_1 + var_673_6 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_1) / var_673_6

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_1 + var_673_6 and arg_670_1.time_ < var_673_1 + var_673_6 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play123011160 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 123011160
		arg_674_1.duration_ = 16

		local var_674_0 = {
			zh = 10.566,
			ja = 16
		}
		local var_674_1 = manager.audio:GetLocalizationFlag()

		if var_674_0[var_674_1] ~= nil then
			arg_674_1.duration_ = var_674_0[var_674_1]
		end

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play123011161(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 and not isNil(arg_674_1.actors_["1033ui_story"]) and arg_674_1.var_.characterEffect1033ui_story == nil then
				arg_674_1.var_.characterEffect1033ui_story = arg_674_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_677_0 = 0.200000002980232

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_0 and not isNil(arg_674_1.actors_["1033ui_story"]) then
				if arg_674_1.var_.characterEffect1033ui_story and not isNil(arg_674_1.actors_["1033ui_story"]) then
					arg_674_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_674_1.time_ >= 0 + var_677_0 and arg_674_1.time_ < 0 + var_677_0 + arg_677_0 and not isNil(arg_674_1.actors_["1033ui_story"]) and arg_674_1.var_.characterEffect1033ui_story then
				arg_674_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_677_2 = 0
			local var_677_3 = 1.2

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= var_677_2 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				arg_674_1.leftNameTxt_.text = arg_674_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_4 = arg_674_1:GetWordFromCfg(123011160)
				local var_677_5 = arg_674_1:FormatText(var_677_4.content)

				arg_674_1.text_.text = var_677_5

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_7 = 48 <= 0 and var_677_3 or var_677_3 * (utf8.len(var_677_5) / 48)

				if (48 <= 0 and var_677_3 or var_677_3 * (utf8.len(var_677_5) / 48)) > 0 and var_677_3 < var_677_7 then
					arg_674_1.talkMaxDuration = var_677_7

					if var_677_7 + var_677_2 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_7 + var_677_2
					end
				end

				arg_674_1.text_.text = var_677_5
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011160", "story_v_out_123011.awb") ~= 0 then
					local var_677_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011160", "story_v_out_123011.awb") / 1000

					if var_677_8 + var_677_2 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_8 + var_677_2
					end

					if var_677_4.prefab_name ~= "" and arg_674_1.actors_[var_677_4.prefab_name] ~= nil then
						local var_677_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_4.prefab_name].transform, "story_v_out_123011", "123011160", "story_v_out_123011.awb")

						arg_674_1:RecordAudio("123011160", var_677_9)
						arg_674_1:RecordAudio("123011160", var_677_9)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_out_123011", "123011160", "story_v_out_123011.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_out_123011", "123011160", "story_v_out_123011.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_10 = math.max(var_677_3, arg_674_1.talkMaxDuration)

			if var_677_2 <= arg_674_1.time_ and arg_674_1.time_ < var_677_2 + var_677_10 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_2) / var_677_10

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_2 + var_677_10 and arg_674_1.time_ < var_677_2 + var_677_10 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {}

		arg_674_1:InitPlayNodeList()
	end,
	Play123011161 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 123011161
		arg_678_1.duration_ = 5

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play123011162(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 and not isNil(arg_678_1.actors_["1033ui_story"]) and arg_678_1.var_.characterEffect1033ui_story == nil then
				arg_678_1.var_.characterEffect1033ui_story = arg_678_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_681_0 = 0.200000002980232

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_0 and not isNil(arg_678_1.actors_["1033ui_story"]) then
				if arg_678_1.var_.characterEffect1033ui_story and not isNil(arg_678_1.actors_["1033ui_story"]) then
					arg_678_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_678_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_678_1.time_ - 0) / var_681_0)
				end
			end

			if arg_678_1.time_ >= 0 + var_681_0 and arg_678_1.time_ < 0 + var_681_0 + arg_681_0 and not isNil(arg_678_1.actors_["1033ui_story"]) and arg_678_1.var_.characterEffect1033ui_story then
				arg_678_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_678_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_681_1 = 0
			local var_681_2 = 0.275

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= var_681_1 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				arg_678_1.leftNameTxt_.text = arg_678_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, true)
				arg_678_1.iconController_:SetSelectedState("hero")

				arg_678_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_678_1.callingController_:SetSelectedState("normal")

				arg_678_1.keyicon_.color = Color.New(1, 1, 1)
				arg_678_1.icon_.color = Color.New(1, 1, 1)

				local var_681_3 = arg_678_1:FormatText(arg_678_1:GetWordFromCfg(123011161).content)

				arg_678_1.text_.text = var_681_3

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_5 = 11 <= 0 and var_681_2 or var_681_2 * (utf8.len(var_681_3) / 11)

				if (11 <= 0 and var_681_2 or var_681_2 * (utf8.len(var_681_3) / 11)) > 0 and var_681_2 < var_681_5 then
					arg_678_1.talkMaxDuration = var_681_5

					if var_681_5 + var_681_1 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_5 + var_681_1
					end
				end

				arg_678_1.text_.text = var_681_3
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_6 = math.max(var_681_2, arg_678_1.talkMaxDuration)

			if var_681_1 <= arg_678_1.time_ and arg_678_1.time_ < var_681_1 + var_681_6 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_1) / var_681_6

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_1 + var_681_6 and arg_678_1.time_ < var_681_1 + var_681_6 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play123011162 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 123011162
		arg_682_1.duration_ = 8.73

		local var_682_0 = {
			zh = 6.366,
			ja = 8.733
		}
		local var_682_1 = manager.audio:GetLocalizationFlag()

		if var_682_0[var_682_1] ~= nil then
			arg_682_1.duration_ = var_682_0[var_682_1]
		end

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play123011163(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1.var_.moveOldPos1033ui_story = arg_682_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_685_0 = 0.001

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_0 then
				arg_682_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_682_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_682_1.time_ - 0) / var_685_0)
				arg_682_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_682_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["1033ui_story"].transform.position).z)
				arg_682_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_682_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_682_1.actors_["1033ui_story"].transform.localEulerAngles = arg_682_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_682_1.time_ >= 0 + var_685_0 and arg_682_1.time_ < 0 + var_685_0 + arg_685_0 then
				arg_682_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_682_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_682_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["1033ui_story"].transform.position).z)
				arg_682_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_682_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_682_1.actors_["1033ui_story"].transform.localEulerAngles = arg_682_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_685_1 = arg_682_1.actors_["1033ui_story"]

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 and not isNil(var_685_1) and arg_682_1.var_.characterEffect1033ui_story == nil then
				arg_682_1.var_.characterEffect1033ui_story = var_685_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_685_2 = 0.200000002980232

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_2 and not isNil(var_685_1) then
				if arg_682_1.var_.characterEffect1033ui_story and not isNil(var_685_1) then
					arg_682_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_682_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_682_1.time_ - 0) / var_685_2)
				end
			end

			if arg_682_1.time_ >= 0 + var_685_2 and arg_682_1.time_ < 0 + var_685_2 + arg_685_0 and not isNil(var_685_1) and arg_682_1.var_.characterEffect1033ui_story then
				arg_682_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_682_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_685_3 = arg_682_1.actors_["1019ui_story"].transform

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1.var_.moveOldPos1019ui_story = var_685_3.localPosition
			end

			local var_685_4 = 0.001

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_4 then
				var_685_3.localPosition = Vector3.Lerp(arg_682_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_682_1.time_ - 0) / var_685_4)
				var_685_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_685_3.position).x, (manager.ui.mainCamera.transform.position - var_685_3.position).y, (manager.ui.mainCamera.transform.position - var_685_3.position).z)
				var_685_3.localEulerAngles.z = 0
				var_685_3.localEulerAngles.x = 0
				var_685_3.localEulerAngles = var_685_3.localEulerAngles
			end

			if arg_682_1.time_ >= 0 + var_685_4 and arg_682_1.time_ < 0 + var_685_4 + arg_685_0 then
				var_685_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_685_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_685_3.position).x, (manager.ui.mainCamera.transform.position - var_685_3.position).y, (manager.ui.mainCamera.transform.position - var_685_3.position).z)
				var_685_3.localEulerAngles.z = 0
				var_685_3.localEulerAngles.x = 0
				var_685_3.localEulerAngles = var_685_3.localEulerAngles
			end

			local var_685_5 = arg_682_1.actors_["1019ui_story"]

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 and not isNil(var_685_5) and arg_682_1.var_.characterEffect1019ui_story == nil then
				arg_682_1.var_.characterEffect1019ui_story = var_685_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_685_6 = 0.200000002980232

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_6 and not isNil(var_685_5) then
				if arg_682_1.var_.characterEffect1019ui_story and not isNil(var_685_5) then
					arg_682_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_682_1.time_ >= 0 + var_685_6 and arg_682_1.time_ < 0 + var_685_6 + arg_685_0 and not isNil(var_685_5) and arg_682_1.var_.characterEffect1019ui_story then
				arg_682_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_685_8 = 0
			local var_685_9 = 0.75

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_8 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				arg_682_1.leftNameTxt_.text = arg_682_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_10 = arg_682_1:GetWordFromCfg(123011162)
				local var_685_11 = arg_682_1:FormatText(var_685_10.content)

				arg_682_1.text_.text = var_685_11

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_13 = 30 <= 0 and var_685_9 or var_685_9 * (utf8.len(var_685_11) / 30)

				if (30 <= 0 and var_685_9 or var_685_9 * (utf8.len(var_685_11) / 30)) > 0 and var_685_9 < var_685_13 then
					arg_682_1.talkMaxDuration = var_685_13

					if var_685_13 + var_685_8 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_13 + var_685_8
					end
				end

				arg_682_1.text_.text = var_685_11
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011162", "story_v_out_123011.awb") ~= 0 then
					local var_685_14 = manager.audio:GetVoiceLength("story_v_out_123011", "123011162", "story_v_out_123011.awb") / 1000

					if var_685_14 + var_685_8 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_14 + var_685_8
					end

					if var_685_10.prefab_name ~= "" and arg_682_1.actors_[var_685_10.prefab_name] ~= nil then
						local var_685_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_682_1.actors_[var_685_10.prefab_name].transform, "story_v_out_123011", "123011162", "story_v_out_123011.awb")

						arg_682_1:RecordAudio("123011162", var_685_15)
						arg_682_1:RecordAudio("123011162", var_685_15)
					else
						arg_682_1:AudioAction("play", "voice", "story_v_out_123011", "123011162", "story_v_out_123011.awb")
					end

					arg_682_1:RecordHistoryTalkVoice("story_v_out_123011", "123011162", "story_v_out_123011.awb")
				end

				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_16 = math.max(var_685_9, arg_682_1.talkMaxDuration)

			if var_685_8 <= arg_682_1.time_ and arg_682_1.time_ < var_685_8 + var_685_16 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_8) / var_685_16

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_8 + var_685_16 and arg_682_1.time_ < var_685_8 + var_685_16 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
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

		arg_682_1:InitPlayNodeList()
	end,
	Play123011163 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 123011163
		arg_686_1.duration_ = 5

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play123011164(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			if 0 < arg_686_1.time_ and arg_686_1.time_ <= 0 + arg_689_0 and not isNil(arg_686_1.actors_["1019ui_story"]) and arg_686_1.var_.characterEffect1019ui_story == nil then
				arg_686_1.var_.characterEffect1019ui_story = arg_686_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_689_0 = 0.200000002980232

			if 0 <= arg_686_1.time_ and arg_686_1.time_ < 0 + var_689_0 and not isNil(arg_686_1.actors_["1019ui_story"]) then
				if arg_686_1.var_.characterEffect1019ui_story and not isNil(arg_686_1.actors_["1019ui_story"]) then
					arg_686_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_686_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_686_1.time_ - 0) / var_689_0)
				end
			end

			if arg_686_1.time_ >= 0 + var_689_0 and arg_686_1.time_ < 0 + var_689_0 + arg_689_0 and not isNil(arg_686_1.actors_["1019ui_story"]) and arg_686_1.var_.characterEffect1019ui_story then
				arg_686_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_686_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_689_1 = 0
			local var_689_2 = 0.575

			if 0 < arg_686_1.time_ and arg_686_1.time_ <= var_689_1 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0
				arg_686_1.dialogCg_.alpha = 1

				arg_686_1.dialog_:SetActive(true)
				SetActive(arg_686_1.leftNameGo_, false)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_686_1.iconTrs_.gameObject, false)
				arg_686_1.callingController_:SetSelectedState("normal")

				local var_689_3 = arg_686_1:FormatText(arg_686_1:GetWordFromCfg(123011163).content)

				arg_686_1.text_.text = var_689_3

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_5 = 23 <= 0 and var_689_2 or var_689_2 * (utf8.len(var_689_3) / 23)

				if (23 <= 0 and var_689_2 or var_689_2 * (utf8.len(var_689_3) / 23)) > 0 and var_689_2 < var_689_5 then
					arg_686_1.talkMaxDuration = var_689_5

					if var_689_5 + var_689_1 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_5 + var_689_1
					end
				end

				arg_686_1.text_.text = var_689_3
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)
				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_6 = math.max(var_689_2, arg_686_1.talkMaxDuration)

			if var_689_1 <= arg_686_1.time_ and arg_686_1.time_ < var_689_1 + var_689_6 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - var_689_1) / var_689_6

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= var_689_1 + var_689_6 and arg_686_1.time_ < var_689_1 + var_689_6 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play123011164 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 123011164
		arg_690_1.duration_ = 8.67

		local var_690_0 = {
			zh = 6.366,
			ja = 8.666
		}
		local var_690_1 = manager.audio:GetLocalizationFlag()

		if var_690_0[var_690_1] ~= nil then
			arg_690_1.duration_ = var_690_0[var_690_1]
		end

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play123011165(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 and not isNil(arg_690_1.actors_["1019ui_story"]) and arg_690_1.var_.characterEffect1019ui_story == nil then
				arg_690_1.var_.characterEffect1019ui_story = arg_690_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_693_0 = 0.200000002980232

			if 0 <= arg_690_1.time_ and arg_690_1.time_ < 0 + var_693_0 and not isNil(arg_690_1.actors_["1019ui_story"]) then
				if arg_690_1.var_.characterEffect1019ui_story and not isNil(arg_690_1.actors_["1019ui_story"]) then
					arg_690_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_690_1.time_ >= 0 + var_693_0 and arg_690_1.time_ < 0 + var_693_0 + arg_693_0 and not isNil(arg_690_1.actors_["1019ui_story"]) and arg_690_1.var_.characterEffect1019ui_story then
				arg_690_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_693_2 = 0
			local var_693_3 = 0.875

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= var_693_2 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, true)

				arg_690_1.leftNameTxt_.text = arg_690_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_690_1.leftNameTxt_.transform)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1.leftNameTxt_.text)
				SetActive(arg_690_1.iconTrs_.gameObject, false)
				arg_690_1.callingController_:SetSelectedState("normal")

				local var_693_4 = arg_690_1:GetWordFromCfg(123011164)
				local var_693_5 = arg_690_1:FormatText(var_693_4.content)

				arg_690_1.text_.text = var_693_5

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_7 = 35 <= 0 and var_693_3 or var_693_3 * (utf8.len(var_693_5) / 35)

				if (35 <= 0 and var_693_3 or var_693_3 * (utf8.len(var_693_5) / 35)) > 0 and var_693_3 < var_693_7 then
					arg_690_1.talkMaxDuration = var_693_7

					if var_693_7 + var_693_2 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_7 + var_693_2
					end
				end

				arg_690_1.text_.text = var_693_5
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011164", "story_v_out_123011.awb") ~= 0 then
					local var_693_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011164", "story_v_out_123011.awb") / 1000

					if var_693_8 + var_693_2 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_8 + var_693_2
					end

					if var_693_4.prefab_name ~= "" and arg_690_1.actors_[var_693_4.prefab_name] ~= nil then
						local var_693_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_690_1.actors_[var_693_4.prefab_name].transform, "story_v_out_123011", "123011164", "story_v_out_123011.awb")

						arg_690_1:RecordAudio("123011164", var_693_9)
						arg_690_1:RecordAudio("123011164", var_693_9)
					else
						arg_690_1:AudioAction("play", "voice", "story_v_out_123011", "123011164", "story_v_out_123011.awb")
					end

					arg_690_1:RecordHistoryTalkVoice("story_v_out_123011", "123011164", "story_v_out_123011.awb")
				end

				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_10 = math.max(var_693_3, arg_690_1.talkMaxDuration)

			if var_693_2 <= arg_690_1.time_ and arg_690_1.time_ < var_693_2 + var_693_10 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - var_693_2) / var_693_10

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= var_693_2 + var_693_10 and arg_690_1.time_ < var_693_2 + var_693_10 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play123011165 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 123011165
		arg_694_1.duration_ = 5

		SetActive(arg_694_1.tipsGo_, false)

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				arg_694_0:Play123011166(arg_694_1)
			end
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 and not isNil(arg_694_1.actors_["1019ui_story"]) and arg_694_1.var_.characterEffect1019ui_story == nil then
				arg_694_1.var_.characterEffect1019ui_story = arg_694_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_697_0 = 0.200000002980232

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_0 and not isNil(arg_694_1.actors_["1019ui_story"]) then
				if arg_694_1.var_.characterEffect1019ui_story and not isNil(arg_694_1.actors_["1019ui_story"]) then
					arg_694_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_694_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_694_1.time_ - 0) / var_697_0)
				end
			end

			if arg_694_1.time_ >= 0 + var_697_0 and arg_694_1.time_ < 0 + var_697_0 + arg_697_0 and not isNil(arg_694_1.actors_["1019ui_story"]) and arg_694_1.var_.characterEffect1019ui_story then
				arg_694_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_694_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_697_1 = 0
			local var_697_2 = 0.7

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= var_697_1 + arg_697_0 then
				arg_694_1.talkMaxDuration = 0
				arg_694_1.dialogCg_.alpha = 1

				arg_694_1.dialog_:SetActive(true)
				SetActive(arg_694_1.leftNameGo_, true)

				arg_694_1.leftNameTxt_.text = arg_694_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_694_1.leftNameTxt_.transform)

				arg_694_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_694_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_694_1:RecordName(arg_694_1.leftNameTxt_.text)
				SetActive(arg_694_1.iconTrs_.gameObject, true)
				arg_694_1.iconController_:SetSelectedState("hero")

				arg_694_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_694_1.callingController_:SetSelectedState("normal")

				arg_694_1.keyicon_.color = Color.New(1, 1, 1)
				arg_694_1.icon_.color = Color.New(1, 1, 1)

				local var_697_3 = arg_694_1:FormatText(arg_694_1:GetWordFromCfg(123011165).content)

				arg_694_1.text_.text = var_697_3

				LuaForUtil.ClearLinePrefixSymbol(arg_694_1.text_)

				local var_697_5 = 28 <= 0 and var_697_2 or var_697_2 * (utf8.len(var_697_3) / 28)

				if (28 <= 0 and var_697_2 or var_697_2 * (utf8.len(var_697_3) / 28)) > 0 and var_697_2 < var_697_5 then
					arg_694_1.talkMaxDuration = var_697_5

					if var_697_5 + var_697_1 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_5 + var_697_1
					end
				end

				arg_694_1.text_.text = var_697_3
				arg_694_1.typewritter.percent = 0

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(false)
				arg_694_1:RecordContent(arg_694_1.text_.text)
			end

			local var_697_6 = math.max(var_697_2, arg_694_1.talkMaxDuration)

			if var_697_1 <= arg_694_1.time_ and arg_694_1.time_ < var_697_1 + var_697_6 then
				arg_694_1.typewritter.percent = (arg_694_1.time_ - var_697_1) / var_697_6

				arg_694_1.typewritter:SetDirty()
			end

			if arg_694_1.time_ >= var_697_1 + var_697_6 and arg_694_1.time_ < var_697_1 + var_697_6 + arg_697_0 then
				arg_694_1.typewritter.percent = 1

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(true)
			end
		end

		arg_694_1.nodeConfigList_ = {}

		arg_694_1:InitPlayNodeList()
	end,
	Play123011166 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 123011166
		arg_698_1.duration_ = 6.87

		local var_698_0 = {
			zh = 4.4,
			ja = 6.866
		}
		local var_698_1 = manager.audio:GetLocalizationFlag()

		if var_698_0[var_698_1] ~= nil then
			arg_698_1.duration_ = var_698_0[var_698_1]
		end

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play123011167(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			if 0 < arg_698_1.time_ and arg_698_1.time_ <= 0 + arg_701_0 and not isNil(arg_698_1.actors_["1019ui_story"]) and arg_698_1.var_.characterEffect1019ui_story == nil then
				arg_698_1.var_.characterEffect1019ui_story = arg_698_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_701_0 = 0.200000002980232

			if 0 <= arg_698_1.time_ and arg_698_1.time_ < 0 + var_701_0 and not isNil(arg_698_1.actors_["1019ui_story"]) then
				if arg_698_1.var_.characterEffect1019ui_story and not isNil(arg_698_1.actors_["1019ui_story"]) then
					arg_698_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_698_1.time_ >= 0 + var_701_0 and arg_698_1.time_ < 0 + var_701_0 + arg_701_0 and not isNil(arg_698_1.actors_["1019ui_story"]) and arg_698_1.var_.characterEffect1019ui_story then
				arg_698_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= 0 + arg_701_0 then
				arg_698_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= 0 + arg_701_0 then
				arg_698_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_701_2 = 0
			local var_701_3 = 0.625

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= var_701_2 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0
				arg_698_1.dialogCg_.alpha = 1

				arg_698_1.dialog_:SetActive(true)
				SetActive(arg_698_1.leftNameGo_, true)

				arg_698_1.leftNameTxt_.text = arg_698_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_698_1.leftNameTxt_.transform)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1.leftNameTxt_.text)
				SetActive(arg_698_1.iconTrs_.gameObject, false)
				arg_698_1.callingController_:SetSelectedState("normal")

				local var_701_4 = arg_698_1:GetWordFromCfg(123011166)
				local var_701_5 = arg_698_1:FormatText(var_701_4.content)

				arg_698_1.text_.text = var_701_5

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_7 = 25 <= 0 and var_701_3 or var_701_3 * (utf8.len(var_701_5) / 25)

				if (25 <= 0 and var_701_3 or var_701_3 * (utf8.len(var_701_5) / 25)) > 0 and var_701_3 < var_701_7 then
					arg_698_1.talkMaxDuration = var_701_7

					if var_701_7 + var_701_2 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_7 + var_701_2
					end
				end

				arg_698_1.text_.text = var_701_5
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011166", "story_v_out_123011.awb") ~= 0 then
					local var_701_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011166", "story_v_out_123011.awb") / 1000

					if var_701_8 + var_701_2 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_8 + var_701_2
					end

					if var_701_4.prefab_name ~= "" and arg_698_1.actors_[var_701_4.prefab_name] ~= nil then
						local var_701_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_698_1.actors_[var_701_4.prefab_name].transform, "story_v_out_123011", "123011166", "story_v_out_123011.awb")

						arg_698_1:RecordAudio("123011166", var_701_9)
						arg_698_1:RecordAudio("123011166", var_701_9)
					else
						arg_698_1:AudioAction("play", "voice", "story_v_out_123011", "123011166", "story_v_out_123011.awb")
					end

					arg_698_1:RecordHistoryTalkVoice("story_v_out_123011", "123011166", "story_v_out_123011.awb")
				end

				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_10 = math.max(var_701_3, arg_698_1.talkMaxDuration)

			if var_701_2 <= arg_698_1.time_ and arg_698_1.time_ < var_701_2 + var_701_10 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - var_701_2) / var_701_10

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= var_701_2 + var_701_10 and arg_698_1.time_ < var_701_2 + var_701_10 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {}

		arg_698_1:InitPlayNodeList()
	end,
	Play123011167 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 123011167
		arg_702_1.duration_ = 11.27

		local var_702_0 = {
			zh = 9.4,
			ja = 11.266
		}
		local var_702_1 = manager.audio:GetLocalizationFlag()

		if var_702_0[var_702_1] ~= nil then
			arg_702_1.duration_ = var_702_0[var_702_1]
		end

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play123011168(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			local var_705_0 = 1.25

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0
				arg_702_1.dialogCg_.alpha = 1

				arg_702_1.dialog_:SetActive(true)
				SetActive(arg_702_1.leftNameGo_, true)

				arg_702_1.leftNameTxt_.text = arg_702_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, false)
				arg_702_1.callingController_:SetSelectedState("normal")

				local var_705_1 = arg_702_1:GetWordFromCfg(123011167)
				local var_705_2 = arg_702_1:FormatText(var_705_1.content)

				arg_702_1.text_.text = var_705_2

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_4 = 50 <= 0 and var_705_0 or var_705_0 * (utf8.len(var_705_2) / 50)

				if (50 <= 0 and var_705_0 or var_705_0 * (utf8.len(var_705_2) / 50)) > 0 and var_705_0 < var_705_4 then
					arg_702_1.talkMaxDuration = var_705_4

					if var_705_4 + 0 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_4 + 0
					end
				end

				arg_702_1.text_.text = var_705_2
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011167", "story_v_out_123011.awb") ~= 0 then
					local var_705_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011167", "story_v_out_123011.awb") / 1000

					if var_705_5 + 0 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_5 + 0
					end

					if var_705_1.prefab_name ~= "" and arg_702_1.actors_[var_705_1.prefab_name] ~= nil then
						local var_705_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_702_1.actors_[var_705_1.prefab_name].transform, "story_v_out_123011", "123011167", "story_v_out_123011.awb")

						arg_702_1:RecordAudio("123011167", var_705_6)
						arg_702_1:RecordAudio("123011167", var_705_6)
					else
						arg_702_1:AudioAction("play", "voice", "story_v_out_123011", "123011167", "story_v_out_123011.awb")
					end

					arg_702_1:RecordHistoryTalkVoice("story_v_out_123011", "123011167", "story_v_out_123011.awb")
				end

				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_7 = math.max(var_705_0, arg_702_1.talkMaxDuration)

			if 0 <= arg_702_1.time_ and arg_702_1.time_ < 0 + var_705_7 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - 0) / var_705_7

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= 0 + var_705_7 and arg_702_1.time_ < 0 + var_705_7 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {}

		arg_702_1:InitPlayNodeList()
	end,
	Play123011168 = function(arg_706_0, arg_706_1)
		arg_706_1.time_ = 0
		arg_706_1.frameCnt_ = 0
		arg_706_1.state_ = "playing"
		arg_706_1.curTalkId_ = 123011168
		arg_706_1.duration_ = 17.2

		local var_706_0 = {
			zh = 12.866,
			ja = 17.2
		}
		local var_706_1 = manager.audio:GetLocalizationFlag()

		if var_706_0[var_706_1] ~= nil then
			arg_706_1.duration_ = var_706_0[var_706_1]
		end

		SetActive(arg_706_1.tipsGo_, false)

		function arg_706_1.onSingleLineFinish_()
			arg_706_1.onSingleLineUpdate_ = nil
			arg_706_1.onSingleLineFinish_ = nil
			arg_706_1.state_ = "waiting"
		end

		function arg_706_1.playNext_(arg_708_0)
			if arg_708_0 == 1 then
				arg_706_0:Play123011169(arg_706_1)
			end
		end

		function arg_706_1.onSingleLineUpdate_(arg_709_0)
			local var_709_0 = 1.65

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= 0 + arg_709_0 then
				arg_706_1.talkMaxDuration = 0
				arg_706_1.dialogCg_.alpha = 1

				arg_706_1.dialog_:SetActive(true)
				SetActive(arg_706_1.leftNameGo_, true)

				arg_706_1.leftNameTxt_.text = arg_706_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_706_1.leftNameTxt_.transform)

				arg_706_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_706_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_706_1:RecordName(arg_706_1.leftNameTxt_.text)
				SetActive(arg_706_1.iconTrs_.gameObject, false)
				arg_706_1.callingController_:SetSelectedState("normal")

				local var_709_1 = arg_706_1:GetWordFromCfg(123011168)
				local var_709_2 = arg_706_1:FormatText(var_709_1.content)

				arg_706_1.text_.text = var_709_2

				LuaForUtil.ClearLinePrefixSymbol(arg_706_1.text_)

				local var_709_4 = 66 <= 0 and var_709_0 or var_709_0 * (utf8.len(var_709_2) / 66)

				if (66 <= 0 and var_709_0 or var_709_0 * (utf8.len(var_709_2) / 66)) > 0 and var_709_0 < var_709_4 then
					arg_706_1.talkMaxDuration = var_709_4

					if var_709_4 + 0 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_4 + 0
					end
				end

				arg_706_1.text_.text = var_709_2
				arg_706_1.typewritter.percent = 0

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011168", "story_v_out_123011.awb") ~= 0 then
					local var_709_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011168", "story_v_out_123011.awb") / 1000

					if var_709_5 + 0 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_5 + 0
					end

					if var_709_1.prefab_name ~= "" and arg_706_1.actors_[var_709_1.prefab_name] ~= nil then
						local var_709_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_706_1.actors_[var_709_1.prefab_name].transform, "story_v_out_123011", "123011168", "story_v_out_123011.awb")

						arg_706_1:RecordAudio("123011168", var_709_6)
						arg_706_1:RecordAudio("123011168", var_709_6)
					else
						arg_706_1:AudioAction("play", "voice", "story_v_out_123011", "123011168", "story_v_out_123011.awb")
					end

					arg_706_1:RecordHistoryTalkVoice("story_v_out_123011", "123011168", "story_v_out_123011.awb")
				end

				arg_706_1:RecordContent(arg_706_1.text_.text)
			end

			local var_709_7 = math.max(var_709_0, arg_706_1.talkMaxDuration)

			if 0 <= arg_706_1.time_ and arg_706_1.time_ < 0 + var_709_7 then
				arg_706_1.typewritter.percent = (arg_706_1.time_ - 0) / var_709_7

				arg_706_1.typewritter:SetDirty()
			end

			if arg_706_1.time_ >= 0 + var_709_7 and arg_706_1.time_ < 0 + var_709_7 + arg_709_0 then
				arg_706_1.typewritter.percent = 1

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(true)
			end
		end

		arg_706_1.nodeConfigList_ = {}

		arg_706_1:InitPlayNodeList()
	end,
	Play123011169 = function(arg_710_0, arg_710_1)
		arg_710_1.time_ = 0
		arg_710_1.frameCnt_ = 0
		arg_710_1.state_ = "playing"
		arg_710_1.curTalkId_ = 123011169
		arg_710_1.duration_ = 5

		SetActive(arg_710_1.tipsGo_, false)

		function arg_710_1.onSingleLineFinish_()
			arg_710_1.onSingleLineUpdate_ = nil
			arg_710_1.onSingleLineFinish_ = nil
			arg_710_1.state_ = "waiting"
		end

		function arg_710_1.playNext_(arg_712_0)
			if arg_712_0 == 1 then
				arg_710_0:Play123011170(arg_710_1)
			end
		end

		function arg_710_1.onSingleLineUpdate_(arg_713_0)
			if 0 < arg_710_1.time_ and arg_710_1.time_ <= 0 + arg_713_0 and not isNil(arg_710_1.actors_["1019ui_story"]) and arg_710_1.var_.characterEffect1019ui_story == nil then
				arg_710_1.var_.characterEffect1019ui_story = arg_710_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_713_0 = 0.200000002980232

			if 0 <= arg_710_1.time_ and arg_710_1.time_ < 0 + var_713_0 and not isNil(arg_710_1.actors_["1019ui_story"]) then
				if arg_710_1.var_.characterEffect1019ui_story and not isNil(arg_710_1.actors_["1019ui_story"]) then
					arg_710_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_710_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_710_1.time_ - 0) / var_713_0)
				end
			end

			if arg_710_1.time_ >= 0 + var_713_0 and arg_710_1.time_ < 0 + var_713_0 + arg_713_0 and not isNil(arg_710_1.actors_["1019ui_story"]) and arg_710_1.var_.characterEffect1019ui_story then
				arg_710_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_710_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_713_1 = 0
			local var_713_2 = 0.275

			if 0 < arg_710_1.time_ and arg_710_1.time_ <= var_713_1 + arg_713_0 then
				arg_710_1.talkMaxDuration = 0
				arg_710_1.dialogCg_.alpha = 1

				arg_710_1.dialog_:SetActive(true)
				SetActive(arg_710_1.leftNameGo_, true)

				arg_710_1.leftNameTxt_.text = arg_710_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_710_1.leftNameTxt_.transform)

				arg_710_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_710_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_710_1:RecordName(arg_710_1.leftNameTxt_.text)
				SetActive(arg_710_1.iconTrs_.gameObject, true)
				arg_710_1.iconController_:SetSelectedState("hero")

				arg_710_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_710_1.callingController_:SetSelectedState("normal")

				arg_710_1.keyicon_.color = Color.New(1, 1, 1)
				arg_710_1.icon_.color = Color.New(1, 1, 1)

				local var_713_3 = arg_710_1:FormatText(arg_710_1:GetWordFromCfg(123011169).content)

				arg_710_1.text_.text = var_713_3

				LuaForUtil.ClearLinePrefixSymbol(arg_710_1.text_)

				local var_713_5 = 11 <= 0 and var_713_2 or var_713_2 * (utf8.len(var_713_3) / 11)

				if (11 <= 0 and var_713_2 or var_713_2 * (utf8.len(var_713_3) / 11)) > 0 and var_713_2 < var_713_5 then
					arg_710_1.talkMaxDuration = var_713_5

					if var_713_5 + var_713_1 > arg_710_1.duration_ then
						arg_710_1.duration_ = var_713_5 + var_713_1
					end
				end

				arg_710_1.text_.text = var_713_3
				arg_710_1.typewritter.percent = 0

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(false)
				arg_710_1:RecordContent(arg_710_1.text_.text)
			end

			local var_713_6 = math.max(var_713_2, arg_710_1.talkMaxDuration)

			if var_713_1 <= arg_710_1.time_ and arg_710_1.time_ < var_713_1 + var_713_6 then
				arg_710_1.typewritter.percent = (arg_710_1.time_ - var_713_1) / var_713_6

				arg_710_1.typewritter:SetDirty()
			end

			if arg_710_1.time_ >= var_713_1 + var_713_6 and arg_710_1.time_ < var_713_1 + var_713_6 + arg_713_0 then
				arg_710_1.typewritter.percent = 1

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(true)
			end
		end

		arg_710_1.nodeConfigList_ = {}

		arg_710_1:InitPlayNodeList()
	end,
	Play123011170 = function(arg_714_0, arg_714_1)
		arg_714_1.time_ = 0
		arg_714_1.frameCnt_ = 0
		arg_714_1.state_ = "playing"
		arg_714_1.curTalkId_ = 123011170
		arg_714_1.duration_ = 9.47

		local var_714_0 = {
			zh = 6.233,
			ja = 9.466
		}
		local var_714_1 = manager.audio:GetLocalizationFlag()

		if var_714_0[var_714_1] ~= nil then
			arg_714_1.duration_ = var_714_0[var_714_1]
		end

		SetActive(arg_714_1.tipsGo_, false)

		function arg_714_1.onSingleLineFinish_()
			arg_714_1.onSingleLineUpdate_ = nil
			arg_714_1.onSingleLineFinish_ = nil
			arg_714_1.state_ = "waiting"
		end

		function arg_714_1.playNext_(arg_716_0)
			if arg_716_0 == 1 then
				arg_714_0:Play123011171(arg_714_1)
			end
		end

		function arg_714_1.onSingleLineUpdate_(arg_717_0)
			if 0 < arg_714_1.time_ and arg_714_1.time_ <= 0 + arg_717_0 and not isNil(arg_714_1.actors_["1019ui_story"]) and arg_714_1.var_.characterEffect1019ui_story == nil then
				arg_714_1.var_.characterEffect1019ui_story = arg_714_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_717_0 = 0.200000002980232

			if 0 <= arg_714_1.time_ and arg_714_1.time_ < 0 + var_717_0 and not isNil(arg_714_1.actors_["1019ui_story"]) then
				if arg_714_1.var_.characterEffect1019ui_story and not isNil(arg_714_1.actors_["1019ui_story"]) then
					arg_714_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_714_1.time_ >= 0 + var_717_0 and arg_714_1.time_ < 0 + var_717_0 + arg_717_0 and not isNil(arg_714_1.actors_["1019ui_story"]) and arg_714_1.var_.characterEffect1019ui_story then
				arg_714_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_714_1.time_ and arg_714_1.time_ <= 0 + arg_717_0 then
				arg_714_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_717_2 = 0
			local var_717_3 = 0.775

			if 0 < arg_714_1.time_ and arg_714_1.time_ <= var_717_2 + arg_717_0 then
				arg_714_1.talkMaxDuration = 0
				arg_714_1.dialogCg_.alpha = 1

				arg_714_1.dialog_:SetActive(true)
				SetActive(arg_714_1.leftNameGo_, true)

				arg_714_1.leftNameTxt_.text = arg_714_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_714_1.leftNameTxt_.transform)

				arg_714_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_714_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_714_1:RecordName(arg_714_1.leftNameTxt_.text)
				SetActive(arg_714_1.iconTrs_.gameObject, false)
				arg_714_1.callingController_:SetSelectedState("normal")

				local var_717_4 = arg_714_1:GetWordFromCfg(123011170)
				local var_717_5 = arg_714_1:FormatText(var_717_4.content)

				arg_714_1.text_.text = var_717_5

				LuaForUtil.ClearLinePrefixSymbol(arg_714_1.text_)

				local var_717_7 = 31 <= 0 and var_717_3 or var_717_3 * (utf8.len(var_717_5) / 31)

				if (31 <= 0 and var_717_3 or var_717_3 * (utf8.len(var_717_5) / 31)) > 0 and var_717_3 < var_717_7 then
					arg_714_1.talkMaxDuration = var_717_7

					if var_717_7 + var_717_2 > arg_714_1.duration_ then
						arg_714_1.duration_ = var_717_7 + var_717_2
					end
				end

				arg_714_1.text_.text = var_717_5
				arg_714_1.typewritter.percent = 0

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011170", "story_v_out_123011.awb") ~= 0 then
					local var_717_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011170", "story_v_out_123011.awb") / 1000

					if var_717_8 + var_717_2 > arg_714_1.duration_ then
						arg_714_1.duration_ = var_717_8 + var_717_2
					end

					if var_717_4.prefab_name ~= "" and arg_714_1.actors_[var_717_4.prefab_name] ~= nil then
						local var_717_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_714_1.actors_[var_717_4.prefab_name].transform, "story_v_out_123011", "123011170", "story_v_out_123011.awb")

						arg_714_1:RecordAudio("123011170", var_717_9)
						arg_714_1:RecordAudio("123011170", var_717_9)
					else
						arg_714_1:AudioAction("play", "voice", "story_v_out_123011", "123011170", "story_v_out_123011.awb")
					end

					arg_714_1:RecordHistoryTalkVoice("story_v_out_123011", "123011170", "story_v_out_123011.awb")
				end

				arg_714_1:RecordContent(arg_714_1.text_.text)
			end

			local var_717_10 = math.max(var_717_3, arg_714_1.talkMaxDuration)

			if var_717_2 <= arg_714_1.time_ and arg_714_1.time_ < var_717_2 + var_717_10 then
				arg_714_1.typewritter.percent = (arg_714_1.time_ - var_717_2) / var_717_10

				arg_714_1.typewritter:SetDirty()
			end

			if arg_714_1.time_ >= var_717_2 + var_717_10 and arg_714_1.time_ < var_717_2 + var_717_10 + arg_717_0 then
				arg_714_1.typewritter.percent = 1

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(true)
			end
		end

		arg_714_1.nodeConfigList_ = {}

		arg_714_1:InitPlayNodeList()
	end,
	Play123011171 = function(arg_718_0, arg_718_1)
		arg_718_1.time_ = 0
		arg_718_1.frameCnt_ = 0
		arg_718_1.state_ = "playing"
		arg_718_1.curTalkId_ = 123011171
		arg_718_1.duration_ = 5

		SetActive(arg_718_1.tipsGo_, false)

		function arg_718_1.onSingleLineFinish_()
			arg_718_1.onSingleLineUpdate_ = nil
			arg_718_1.onSingleLineFinish_ = nil
			arg_718_1.state_ = "waiting"
		end

		function arg_718_1.playNext_(arg_720_0)
			if arg_720_0 == 1 then
				arg_718_0:Play123011172(arg_718_1)
			end
		end

		function arg_718_1.onSingleLineUpdate_(arg_721_0)
			if 0 < arg_718_1.time_ and arg_718_1.time_ <= 0 + arg_721_0 and not isNil(arg_718_1.actors_["1019ui_story"]) and arg_718_1.var_.characterEffect1019ui_story == nil then
				arg_718_1.var_.characterEffect1019ui_story = arg_718_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_721_0 = 0.200000002980232

			if 0 <= arg_718_1.time_ and arg_718_1.time_ < 0 + var_721_0 and not isNil(arg_718_1.actors_["1019ui_story"]) then
				if arg_718_1.var_.characterEffect1019ui_story and not isNil(arg_718_1.actors_["1019ui_story"]) then
					arg_718_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_718_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_718_1.time_ - 0) / var_721_0)
				end
			end

			if arg_718_1.time_ >= 0 + var_721_0 and arg_718_1.time_ < 0 + var_721_0 + arg_721_0 and not isNil(arg_718_1.actors_["1019ui_story"]) and arg_718_1.var_.characterEffect1019ui_story then
				arg_718_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_718_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_721_1 = 0
			local var_721_2 = 0.5

			if 0 < arg_718_1.time_ and arg_718_1.time_ <= var_721_1 + arg_721_0 then
				arg_718_1.talkMaxDuration = 0
				arg_718_1.dialogCg_.alpha = 1

				arg_718_1.dialog_:SetActive(true)
				SetActive(arg_718_1.leftNameGo_, true)

				arg_718_1.leftNameTxt_.text = arg_718_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_718_1.leftNameTxt_.transform)

				arg_718_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_718_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_718_1:RecordName(arg_718_1.leftNameTxt_.text)
				SetActive(arg_718_1.iconTrs_.gameObject, true)
				arg_718_1.iconController_:SetSelectedState("hero")

				arg_718_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_718_1.callingController_:SetSelectedState("normal")

				arg_718_1.keyicon_.color = Color.New(1, 1, 1)
				arg_718_1.icon_.color = Color.New(1, 1, 1)

				local var_721_3 = arg_718_1:FormatText(arg_718_1:GetWordFromCfg(123011171).content)

				arg_718_1.text_.text = var_721_3

				LuaForUtil.ClearLinePrefixSymbol(arg_718_1.text_)

				local var_721_5 = 20 <= 0 and var_721_2 or var_721_2 * (utf8.len(var_721_3) / 20)

				if (20 <= 0 and var_721_2 or var_721_2 * (utf8.len(var_721_3) / 20)) > 0 and var_721_2 < var_721_5 then
					arg_718_1.talkMaxDuration = var_721_5

					if var_721_5 + var_721_1 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_5 + var_721_1
					end
				end

				arg_718_1.text_.text = var_721_3
				arg_718_1.typewritter.percent = 0

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(false)
				arg_718_1:RecordContent(arg_718_1.text_.text)
			end

			local var_721_6 = math.max(var_721_2, arg_718_1.talkMaxDuration)

			if var_721_1 <= arg_718_1.time_ and arg_718_1.time_ < var_721_1 + var_721_6 then
				arg_718_1.typewritter.percent = (arg_718_1.time_ - var_721_1) / var_721_6

				arg_718_1.typewritter:SetDirty()
			end

			if arg_718_1.time_ >= var_721_1 + var_721_6 and arg_718_1.time_ < var_721_1 + var_721_6 + arg_721_0 then
				arg_718_1.typewritter.percent = 1

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(true)
			end
		end

		arg_718_1.nodeConfigList_ = {}

		arg_718_1:InitPlayNodeList()
	end,
	Play123011172 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 123011172
		arg_722_1.duration_ = 5.17

		local var_722_0 = {
			zh = 4.333,
			ja = 5.166
		}
		local var_722_1 = manager.audio:GetLocalizationFlag()

		if var_722_0[var_722_1] ~= nil then
			arg_722_1.duration_ = var_722_0[var_722_1]
		end

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play123011173(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 and not isNil(arg_722_1.actors_["1019ui_story"]) and arg_722_1.var_.characterEffect1019ui_story == nil then
				arg_722_1.var_.characterEffect1019ui_story = arg_722_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_725_0 = 0.200000002980232

			if 0 <= arg_722_1.time_ and arg_722_1.time_ < 0 + var_725_0 and not isNil(arg_722_1.actors_["1019ui_story"]) then
				if arg_722_1.var_.characterEffect1019ui_story and not isNil(arg_722_1.actors_["1019ui_story"]) then
					arg_722_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_722_1.time_ >= 0 + var_725_0 and arg_722_1.time_ < 0 + var_725_0 + arg_725_0 and not isNil(arg_722_1.actors_["1019ui_story"]) and arg_722_1.var_.characterEffect1019ui_story then
				arg_722_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 then
				arg_722_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 then
				arg_722_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_725_2 = 0
			local var_725_3 = 0.425

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= var_725_2 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				arg_722_1.leftNameTxt_.text = arg_722_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, false)
				arg_722_1.callingController_:SetSelectedState("normal")

				local var_725_4 = arg_722_1:GetWordFromCfg(123011172)
				local var_725_5 = arg_722_1:FormatText(var_725_4.content)

				arg_722_1.text_.text = var_725_5

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_7 = 17 <= 0 and var_725_3 or var_725_3 * (utf8.len(var_725_5) / 17)

				if (17 <= 0 and var_725_3 or var_725_3 * (utf8.len(var_725_5) / 17)) > 0 and var_725_3 < var_725_7 then
					arg_722_1.talkMaxDuration = var_725_7

					if var_725_7 + var_725_2 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_7 + var_725_2
					end
				end

				arg_722_1.text_.text = var_725_5
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011172", "story_v_out_123011.awb") ~= 0 then
					local var_725_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011172", "story_v_out_123011.awb") / 1000

					if var_725_8 + var_725_2 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_8 + var_725_2
					end

					if var_725_4.prefab_name ~= "" and arg_722_1.actors_[var_725_4.prefab_name] ~= nil then
						local var_725_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_722_1.actors_[var_725_4.prefab_name].transform, "story_v_out_123011", "123011172", "story_v_out_123011.awb")

						arg_722_1:RecordAudio("123011172", var_725_9)
						arg_722_1:RecordAudio("123011172", var_725_9)
					else
						arg_722_1:AudioAction("play", "voice", "story_v_out_123011", "123011172", "story_v_out_123011.awb")
					end

					arg_722_1:RecordHistoryTalkVoice("story_v_out_123011", "123011172", "story_v_out_123011.awb")
				end

				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_10 = math.max(var_725_3, arg_722_1.talkMaxDuration)

			if var_725_2 <= arg_722_1.time_ and arg_722_1.time_ < var_725_2 + var_725_10 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - var_725_2) / var_725_10

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= var_725_2 + var_725_10 and arg_722_1.time_ < var_725_2 + var_725_10 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {}

		arg_722_1:InitPlayNodeList()
	end,
	Play123011173 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 123011173
		arg_726_1.duration_ = 5

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play123011174(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 and not isNil(arg_726_1.actors_["1019ui_story"]) and arg_726_1.var_.characterEffect1019ui_story == nil then
				arg_726_1.var_.characterEffect1019ui_story = arg_726_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_729_0 = 0.200000002980232

			if 0 <= arg_726_1.time_ and arg_726_1.time_ < 0 + var_729_0 and not isNil(arg_726_1.actors_["1019ui_story"]) then
				if arg_726_1.var_.characterEffect1019ui_story and not isNil(arg_726_1.actors_["1019ui_story"]) then
					arg_726_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_726_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_726_1.time_ - 0) / var_729_0)
				end
			end

			if arg_726_1.time_ >= 0 + var_729_0 and arg_726_1.time_ < 0 + var_729_0 + arg_729_0 and not isNil(arg_726_1.actors_["1019ui_story"]) and arg_726_1.var_.characterEffect1019ui_story then
				arg_726_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_726_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_729_1 = 0
			local var_729_2 = 0.6

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= var_729_1 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				arg_726_1.leftNameTxt_.text = arg_726_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, true)
				arg_726_1.iconController_:SetSelectedState("hero")

				arg_726_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_726_1.callingController_:SetSelectedState("normal")

				arg_726_1.keyicon_.color = Color.New(1, 1, 1)
				arg_726_1.icon_.color = Color.New(1, 1, 1)

				local var_729_3 = arg_726_1:FormatText(arg_726_1:GetWordFromCfg(123011173).content)

				arg_726_1.text_.text = var_729_3

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_5 = 24 <= 0 and var_729_2 or var_729_2 * (utf8.len(var_729_3) / 24)

				if (24 <= 0 and var_729_2 or var_729_2 * (utf8.len(var_729_3) / 24)) > 0 and var_729_2 < var_729_5 then
					arg_726_1.talkMaxDuration = var_729_5

					if var_729_5 + var_729_1 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_5 + var_729_1
					end
				end

				arg_726_1.text_.text = var_729_3
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)
				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_6 = math.max(var_729_2, arg_726_1.talkMaxDuration)

			if var_729_1 <= arg_726_1.time_ and arg_726_1.time_ < var_729_1 + var_729_6 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - var_729_1) / var_729_6

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= var_729_1 + var_729_6 and arg_726_1.time_ < var_729_1 + var_729_6 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {}

		arg_726_1:InitPlayNodeList()
	end,
	Play123011174 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 123011174
		arg_730_1.duration_ = 2.5

		local var_730_0 = {
			zh = 2.5,
			ja = 1.999999999999
		}
		local var_730_1 = manager.audio:GetLocalizationFlag()

		if var_730_0[var_730_1] ~= nil then
			arg_730_1.duration_ = var_730_0[var_730_1]
		end

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play123011175(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			if 0 < arg_730_1.time_ and arg_730_1.time_ <= 0 + arg_733_0 and not isNil(arg_730_1.actors_["1019ui_story"]) and arg_730_1.var_.characterEffect1019ui_story == nil then
				arg_730_1.var_.characterEffect1019ui_story = arg_730_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_733_0 = 0.200000002980232

			if 0 <= arg_730_1.time_ and arg_730_1.time_ < 0 + var_733_0 and not isNil(arg_730_1.actors_["1019ui_story"]) then
				if arg_730_1.var_.characterEffect1019ui_story and not isNil(arg_730_1.actors_["1019ui_story"]) then
					arg_730_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_730_1.time_ >= 0 + var_733_0 and arg_730_1.time_ < 0 + var_733_0 + arg_733_0 and not isNil(arg_730_1.actors_["1019ui_story"]) and arg_730_1.var_.characterEffect1019ui_story then
				arg_730_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_730_1.time_ and arg_730_1.time_ <= 0 + arg_733_0 then
				arg_730_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_733_2 = 0
			local var_733_3 = 0.15

			if 0 < arg_730_1.time_ and arg_730_1.time_ <= var_733_2 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				arg_730_1.leftNameTxt_.text = arg_730_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, false)
				arg_730_1.callingController_:SetSelectedState("normal")

				local var_733_4 = arg_730_1:GetWordFromCfg(123011174)
				local var_733_5 = arg_730_1:FormatText(var_733_4.content)

				arg_730_1.text_.text = var_733_5

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_7 = 6 <= 0 and var_733_3 or var_733_3 * (utf8.len(var_733_5) / 6)

				if (6 <= 0 and var_733_3 or var_733_3 * (utf8.len(var_733_5) / 6)) > 0 and var_733_3 < var_733_7 then
					arg_730_1.talkMaxDuration = var_733_7

					if var_733_7 + var_733_2 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_7 + var_733_2
					end
				end

				arg_730_1.text_.text = var_733_5
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011174", "story_v_out_123011.awb") ~= 0 then
					local var_733_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011174", "story_v_out_123011.awb") / 1000

					if var_733_8 + var_733_2 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_8 + var_733_2
					end

					if var_733_4.prefab_name ~= "" and arg_730_1.actors_[var_733_4.prefab_name] ~= nil then
						local var_733_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_730_1.actors_[var_733_4.prefab_name].transform, "story_v_out_123011", "123011174", "story_v_out_123011.awb")

						arg_730_1:RecordAudio("123011174", var_733_9)
						arg_730_1:RecordAudio("123011174", var_733_9)
					else
						arg_730_1:AudioAction("play", "voice", "story_v_out_123011", "123011174", "story_v_out_123011.awb")
					end

					arg_730_1:RecordHistoryTalkVoice("story_v_out_123011", "123011174", "story_v_out_123011.awb")
				end

				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_10 = math.max(var_733_3, arg_730_1.talkMaxDuration)

			if var_733_2 <= arg_730_1.time_ and arg_730_1.time_ < var_733_2 + var_733_10 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - var_733_2) / var_733_10

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= var_733_2 + var_733_10 and arg_730_1.time_ < var_733_2 + var_733_10 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {}

		arg_730_1:InitPlayNodeList()
	end,
	Play123011175 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 123011175
		arg_734_1.duration_ = 5

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play123011176(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 and not isNil(arg_734_1.actors_["1019ui_story"]) and arg_734_1.var_.characterEffect1019ui_story == nil then
				arg_734_1.var_.characterEffect1019ui_story = arg_734_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_737_0 = 0.200000002980232

			if 0 <= arg_734_1.time_ and arg_734_1.time_ < 0 + var_737_0 and not isNil(arg_734_1.actors_["1019ui_story"]) then
				if arg_734_1.var_.characterEffect1019ui_story and not isNil(arg_734_1.actors_["1019ui_story"]) then
					arg_734_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_734_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_734_1.time_ - 0) / var_737_0)
				end
			end

			if arg_734_1.time_ >= 0 + var_737_0 and arg_734_1.time_ < 0 + var_737_0 + arg_737_0 and not isNil(arg_734_1.actors_["1019ui_story"]) and arg_734_1.var_.characterEffect1019ui_story then
				arg_734_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_734_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_737_1 = 0
			local var_737_2 = 0.075

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= var_737_1 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				arg_734_1.leftNameTxt_.text = arg_734_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, true)
				arg_734_1.iconController_:SetSelectedState("hero")

				arg_734_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_734_1.callingController_:SetSelectedState("normal")

				arg_734_1.keyicon_.color = Color.New(1, 1, 1)
				arg_734_1.icon_.color = Color.New(1, 1, 1)

				local var_737_3 = arg_734_1:FormatText(arg_734_1:GetWordFromCfg(123011175).content)

				arg_734_1.text_.text = var_737_3

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_5 = 3 <= 0 and var_737_2 or var_737_2 * (utf8.len(var_737_3) / 3)

				if (3 <= 0 and var_737_2 or var_737_2 * (utf8.len(var_737_3) / 3)) > 0 and var_737_2 < var_737_5 then
					arg_734_1.talkMaxDuration = var_737_5

					if var_737_5 + var_737_1 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_5 + var_737_1
					end
				end

				arg_734_1.text_.text = var_737_3
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)
				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_6 = math.max(var_737_2, arg_734_1.talkMaxDuration)

			if var_737_1 <= arg_734_1.time_ and arg_734_1.time_ < var_737_1 + var_737_6 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - var_737_1) / var_737_6

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= var_737_1 + var_737_6 and arg_734_1.time_ < var_737_1 + var_737_6 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play123011176 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 123011176
		arg_738_1.duration_ = 9

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play123011177(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			if 2 < arg_738_1.time_ and arg_738_1.time_ <= 2 + arg_741_0 then
				local var_741_0 = arg_738_1.bgs_.STblack

				arg_738_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_741_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_741_1 = var_741_0:GetComponent("SpriteRenderer")

				if var_741_1 and var_741_1.sprite then
					local var_741_2 = 2 * (var_741_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_741_0.transform.localScale = Vector3.New(var_741_2 / var_741_1.sprite.bounds.size.y < var_741_2 * manager.ui.mainCameraCom_.aspect / var_741_1.sprite.bounds.size.x and var_741_2 * manager.ui.mainCameraCom_.aspect / var_741_1.sprite.bounds.size.x or var_741_2 / var_741_1.sprite.bounds.size.y, var_741_2 / var_741_1.sprite.bounds.size.y < var_741_2 * manager.ui.mainCameraCom_.aspect / var_741_1.sprite.bounds.size.x and var_741_2 * manager.ui.mainCameraCom_.aspect / var_741_1.sprite.bounds.size.x or var_741_2 / var_741_1.sprite.bounds.size.y, 0)
				end

				for iter_741_0, iter_741_1 in pairs(arg_738_1.bgs_) do
					if iter_741_0 ~= "STblack" then
						iter_741_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_741_3 = 0

			if 0 < arg_738_1.time_ and arg_738_1.time_ <= var_741_3 + arg_741_0 then
				arg_738_1.mask_.enabled = true
				arg_738_1.mask_.raycastTarget = true

				arg_738_1:SetGaussion(false)
			end

			local var_741_4 = 2

			if var_741_3 <= arg_738_1.time_ and arg_738_1.time_ < var_741_3 + var_741_4 then
				local var_741_5 = Color.New(0, 0, 0)

				var_741_5.a = Mathf.Lerp(0, 1, (arg_738_1.time_ - var_741_3) / var_741_4)
				arg_738_1.mask_.color = var_741_5
			end

			if arg_738_1.time_ >= var_741_3 + var_741_4 and arg_738_1.time_ < var_741_3 + var_741_4 + arg_741_0 then
				local var_741_6 = Color.New(0, 0, 0)

				var_741_6.a = 1
				arg_738_1.mask_.color = var_741_6
			end

			local var_741_7 = 2

			if 2 < arg_738_1.time_ and arg_738_1.time_ <= var_741_7 + arg_741_0 then
				arg_738_1.mask_.enabled = true
				arg_738_1.mask_.raycastTarget = true

				arg_738_1:SetGaussion(false)
			end

			local var_741_8 = 2

			if var_741_7 <= arg_738_1.time_ and arg_738_1.time_ < var_741_7 + var_741_8 then
				local var_741_9 = Color.New(0, 0, 0)

				var_741_9.a = Mathf.Lerp(1, 0, (arg_738_1.time_ - var_741_7) / var_741_8)
				arg_738_1.mask_.color = var_741_9
			end

			if arg_738_1.time_ >= var_741_7 + var_741_8 and arg_738_1.time_ < var_741_7 + var_741_8 + arg_741_0 then
				local var_741_10 = Color.New(0, 0, 0)

				arg_738_1.mask_.enabled = false
				var_741_10.a = 0
				arg_738_1.mask_.color = var_741_10
			end

			local var_741_11 = arg_738_1.actors_["1019ui_story"].transform

			if 1.96599999815226 < arg_738_1.time_ and arg_738_1.time_ <= 1.96599999815226 + arg_741_0 then
				arg_738_1.var_.moveOldPos1019ui_story = var_741_11.localPosition
			end

			local var_741_12 = 0.001

			if 1.96599999815226 <= arg_738_1.time_ and arg_738_1.time_ < 1.96599999815226 + var_741_12 then
				var_741_11.localPosition = Vector3.Lerp(arg_738_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_738_1.time_ - 1.96599999815226) / var_741_12)
				var_741_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_741_11.position).x, (manager.ui.mainCamera.transform.position - var_741_11.position).y, (manager.ui.mainCamera.transform.position - var_741_11.position).z)
				var_741_11.localEulerAngles.z = 0
				var_741_11.localEulerAngles.x = 0
				var_741_11.localEulerAngles = var_741_11.localEulerAngles
			end

			if arg_738_1.time_ >= 1.96599999815226 + var_741_12 and arg_738_1.time_ < 1.96599999815226 + var_741_12 + arg_741_0 then
				var_741_11.localPosition = Vector3.New(0, 100, 0)
				var_741_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_741_11.position).x, (manager.ui.mainCamera.transform.position - var_741_11.position).y, (manager.ui.mainCamera.transform.position - var_741_11.position).z)
				var_741_11.localEulerAngles.z = 0
				var_741_11.localEulerAngles.x = 0
				var_741_11.localEulerAngles = var_741_11.localEulerAngles
			end

			local var_741_13 = arg_738_1.actors_["1019ui_story"]

			if 1.96599999815226 < arg_738_1.time_ and arg_738_1.time_ <= 1.96599999815226 + arg_741_0 and not isNil(var_741_13) and arg_738_1.var_.characterEffect1019ui_story == nil then
				arg_738_1.var_.characterEffect1019ui_story = var_741_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_741_14 = 0.034000001847744

			if 1.96599999815226 <= arg_738_1.time_ and arg_738_1.time_ < 1.96599999815226 + var_741_14 and not isNil(var_741_13) then
				if arg_738_1.var_.characterEffect1019ui_story and not isNil(var_741_13) then
					arg_738_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_738_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_738_1.time_ - 1.96599999815226) / var_741_14)
				end
			end

			if arg_738_1.time_ >= 1.96599999815226 + var_741_14 and arg_738_1.time_ < 1.96599999815226 + var_741_14 + arg_741_0 and not isNil(var_741_13) and arg_738_1.var_.characterEffect1019ui_story then
				arg_738_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_738_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if arg_738_1.frameCnt_ <= 1 then
				arg_738_1.dialog_:SetActive(false)
			end

			local var_741_15 = 4
			local var_741_16 = 0.75

			if 4 < arg_738_1.time_ and arg_738_1.time_ <= var_741_15 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0

				arg_738_1.dialog_:SetActive(true)

				arg_738_1.dialogCg_.alpha = 0

				local var_741_17 = LeanTween.value(arg_738_1.dialog_, 0, 1, 0.3)

				var_741_17:setOnUpdate(LuaHelper.FloatAction(function(arg_742_0)
					arg_738_1.dialogCg_.alpha = arg_742_0
				end))
				var_741_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_738_1.dialog_)
					var_741_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_738_1.duration_ = arg_738_1.duration_ + 0.3

				SetActive(arg_738_1.leftNameGo_, false)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_738_1.iconTrs_.gameObject, false)
				arg_738_1.callingController_:SetSelectedState("normal")

				local var_741_18 = arg_738_1:FormatText(arg_738_1:GetWordFromCfg(123011176).content)

				arg_738_1.text_.text = var_741_18

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_20 = 30 <= 0 and var_741_16 or var_741_16 * (utf8.len(var_741_18) / 30)

				if (30 <= 0 and var_741_16 or var_741_16 * (utf8.len(var_741_18) / 30)) > 0 and var_741_16 < var_741_20 then
					arg_738_1.talkMaxDuration = var_741_20
					var_741_15 = var_741_15 + 0.3

					if var_741_20 + var_741_15 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_20 + var_741_15
					end
				end

				arg_738_1.text_.text = var_741_18
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_21 = var_741_15 + 0.3
			local var_741_22 = math.max(var_741_16, arg_738_1.talkMaxDuration)

			if var_741_15 + 0.3 <= arg_738_1.time_ and arg_738_1.time_ < var_741_21 + var_741_22 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_21) / var_741_22

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_21 + var_741_22 and arg_738_1.time_ < var_741_21 + var_741_22 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_738_1:InitPlayNodeList()
	end,
	Play123011177 = function(arg_744_0, arg_744_1)
		arg_744_1.time_ = 0
		arg_744_1.frameCnt_ = 0
		arg_744_1.state_ = "playing"
		arg_744_1.curTalkId_ = 123011177
		arg_744_1.duration_ = 7

		SetActive(arg_744_1.tipsGo_, false)

		function arg_744_1.onSingleLineFinish_()
			arg_744_1.onSingleLineUpdate_ = nil
			arg_744_1.onSingleLineFinish_ = nil
			arg_744_1.state_ = "waiting"
		end

		function arg_744_1.playNext_(arg_746_0)
			if arg_746_0 == 1 then
				arg_744_0:Play123011178(arg_744_1)
			end
		end

		function arg_744_1.onSingleLineUpdate_(arg_747_0)
			if arg_744_1.bgs_.BA0102 == nil then
				local var_747_0 = Object.Instantiate(arg_744_1.paintGo_)

				var_747_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "BA0102")
				var_747_0.name = "BA0102"
				var_747_0.transform.parent = arg_744_1.stage_.transform
				var_747_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_744_1.bgs_.BA0102 = var_747_0
			end

			if 0 < arg_744_1.time_ and arg_744_1.time_ <= 0 + arg_747_0 then
				local var_747_1 = arg_744_1.bgs_.BA0102

				arg_744_1.bgs_.BA0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_747_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_747_2 = var_747_1:GetComponent("SpriteRenderer")

				if var_747_2 and var_747_2.sprite then
					local var_747_3 = 2 * (var_747_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_747_1.transform.localScale = Vector3.New(var_747_3 / var_747_2.sprite.bounds.size.y < var_747_3 * manager.ui.mainCameraCom_.aspect / var_747_2.sprite.bounds.size.x and var_747_3 * manager.ui.mainCameraCom_.aspect / var_747_2.sprite.bounds.size.x or var_747_3 / var_747_2.sprite.bounds.size.y, var_747_3 / var_747_2.sprite.bounds.size.y < var_747_3 * manager.ui.mainCameraCom_.aspect / var_747_2.sprite.bounds.size.x and var_747_3 * manager.ui.mainCameraCom_.aspect / var_747_2.sprite.bounds.size.x or var_747_3 / var_747_2.sprite.bounds.size.y, 0)
				end

				for iter_747_0, iter_747_1 in pairs(arg_744_1.bgs_) do
					if iter_747_0 ~= "BA0102" then
						iter_747_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_747_4 = 0

			if 0 < arg_744_1.time_ and arg_744_1.time_ <= var_747_4 + arg_747_0 then
				arg_744_1.mask_.enabled = true
				arg_744_1.mask_.raycastTarget = true

				arg_744_1:SetGaussion(false)
			end

			local var_747_5 = 2

			if var_747_4 <= arg_744_1.time_ and arg_744_1.time_ < var_747_4 + var_747_5 then
				local var_747_6 = Color.New(0, 0, 0)

				var_747_6.a = Mathf.Lerp(1, 0, (arg_744_1.time_ - var_747_4) / var_747_5)
				arg_744_1.mask_.color = var_747_6
			end

			if arg_744_1.time_ >= var_747_4 + var_747_5 and arg_744_1.time_ < var_747_4 + var_747_5 + arg_747_0 then
				local var_747_7 = Color.New(0, 0, 0)

				arg_744_1.mask_.enabled = false
				var_747_7.a = 0
				arg_744_1.mask_.color = var_747_7
			end

			if arg_744_1.frameCnt_ <= 1 then
				arg_744_1.dialog_:SetActive(false)
			end

			local var_747_8 = 1.999999999999
			local var_747_9 = 1.55

			if 1.999999999999 < arg_744_1.time_ and arg_744_1.time_ <= var_747_8 + arg_747_0 then
				arg_744_1.talkMaxDuration = 0

				arg_744_1.dialog_:SetActive(true)

				arg_744_1.dialogCg_.alpha = 0

				local var_747_10 = LeanTween.value(arg_744_1.dialog_, 0, 1, 0.3)

				var_747_10:setOnUpdate(LuaHelper.FloatAction(function(arg_748_0)
					arg_744_1.dialogCg_.alpha = arg_748_0
				end))
				var_747_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_744_1.dialog_)
					var_747_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_744_1.duration_ = arg_744_1.duration_ + 0.3

				SetActive(arg_744_1.leftNameGo_, false)

				arg_744_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_744_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_744_1:RecordName(arg_744_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_744_1.iconTrs_.gameObject, false)
				arg_744_1.callingController_:SetSelectedState("normal")

				local var_747_11 = arg_744_1:FormatText(arg_744_1:GetWordFromCfg(123011177).content)

				arg_744_1.text_.text = var_747_11

				LuaForUtil.ClearLinePrefixSymbol(arg_744_1.text_)

				local var_747_13 = 62 <= 0 and var_747_9 or var_747_9 * (utf8.len(var_747_11) / 62)

				if (62 <= 0 and var_747_9 or var_747_9 * (utf8.len(var_747_11) / 62)) > 0 and var_747_9 < var_747_13 then
					arg_744_1.talkMaxDuration = var_747_13
					var_747_8 = var_747_8 + 0.3

					if var_747_13 + var_747_8 > arg_744_1.duration_ then
						arg_744_1.duration_ = var_747_13 + var_747_8
					end
				end

				arg_744_1.text_.text = var_747_11
				arg_744_1.typewritter.percent = 0

				arg_744_1.typewritter:SetDirty()
				arg_744_1:ShowNextGo(false)
				arg_744_1:RecordContent(arg_744_1.text_.text)
			end

			local var_747_14 = var_747_8 + 0.3
			local var_747_15 = math.max(var_747_9, arg_744_1.talkMaxDuration)

			if var_747_8 + 0.3 <= arg_744_1.time_ and arg_744_1.time_ < var_747_14 + var_747_15 then
				arg_744_1.typewritter.percent = (arg_744_1.time_ - var_747_14) / var_747_15

				arg_744_1.typewritter:SetDirty()
			end

			if arg_744_1.time_ >= var_747_14 + var_747_15 and arg_744_1.time_ < var_747_14 + var_747_15 + arg_747_0 then
				arg_744_1.typewritter.percent = 1

				arg_744_1.typewritter:SetDirty()
				arg_744_1:ShowNextGo(true)
			end
		end

		arg_744_1.nodeConfigList_ = {}

		arg_744_1:InitPlayNodeList()
	end,
	Play123011178 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 123011178
		arg_750_1.duration_ = 4.97

		local var_750_0 = {
			zh = 3.133,
			ja = 4.966
		}
		local var_750_1 = manager.audio:GetLocalizationFlag()

		if var_750_0[var_750_1] ~= nil then
			arg_750_1.duration_ = var_750_0[var_750_1]
		end

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play123011179(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			local var_753_0 = 0.375

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, true)

				arg_750_1.leftNameTxt_.text = arg_750_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_750_1.leftNameTxt_.transform)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1.leftNameTxt_.text)
				SetActive(arg_750_1.iconTrs_.gameObject, true)
				arg_750_1.iconController_:SetSelectedState("hero")

				arg_750_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_750_1.callingController_:SetSelectedState("normal")

				arg_750_1.keyicon_.color = Color.New(1, 1, 1)
				arg_750_1.icon_.color = Color.New(1, 1, 1)

				local var_753_1 = arg_750_1:GetWordFromCfg(123011178)
				local var_753_2 = arg_750_1:FormatText(var_753_1.content)

				arg_750_1.text_.text = var_753_2

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_4 = 15 <= 0 and var_753_0 or var_753_0 * (utf8.len(var_753_2) / 15)

				if (15 <= 0 and var_753_0 or var_753_0 * (utf8.len(var_753_2) / 15)) > 0 and var_753_0 < var_753_4 then
					arg_750_1.talkMaxDuration = var_753_4

					if var_753_4 + 0 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_4 + 0
					end
				end

				arg_750_1.text_.text = var_753_2
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011178", "story_v_out_123011.awb") ~= 0 then
					local var_753_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011178", "story_v_out_123011.awb") / 1000

					if var_753_5 + 0 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_5 + 0
					end

					if var_753_1.prefab_name ~= "" and arg_750_1.actors_[var_753_1.prefab_name] ~= nil then
						local var_753_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_750_1.actors_[var_753_1.prefab_name].transform, "story_v_out_123011", "123011178", "story_v_out_123011.awb")

						arg_750_1:RecordAudio("123011178", var_753_6)
						arg_750_1:RecordAudio("123011178", var_753_6)
					else
						arg_750_1:AudioAction("play", "voice", "story_v_out_123011", "123011178", "story_v_out_123011.awb")
					end

					arg_750_1:RecordHistoryTalkVoice("story_v_out_123011", "123011178", "story_v_out_123011.awb")
				end

				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_7 = math.max(var_753_0, arg_750_1.talkMaxDuration)

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_7 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - 0) / var_753_7

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= 0 + var_753_7 and arg_750_1.time_ < 0 + var_753_7 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {}

		arg_750_1:InitPlayNodeList()
	end,
	Play123011179 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 123011179
		arg_754_1.duration_ = 2

		local var_754_0 = {
			zh = 1.1,
			ja = 2
		}
		local var_754_1 = manager.audio:GetLocalizationFlag()

		if var_754_0[var_754_1] ~= nil then
			arg_754_1.duration_ = var_754_0[var_754_1]
		end

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
		end

		function arg_754_1.playNext_(arg_756_0)
			if arg_756_0 == 1 then
				arg_754_0:Play123011180(arg_754_1)
			end
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			local var_757_0 = 0.125

			if 0 < arg_754_1.time_ and arg_754_1.time_ <= 0 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				arg_754_1.leftNameTxt_.text = arg_754_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, true)
				arg_754_1.iconController_:SetSelectedState("hero")

				arg_754_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_754_1.callingController_:SetSelectedState("normal")

				arg_754_1.keyicon_.color = Color.New(1, 1, 1)
				arg_754_1.icon_.color = Color.New(1, 1, 1)

				local var_757_1 = arg_754_1:GetWordFromCfg(123011179)
				local var_757_2 = arg_754_1:FormatText(var_757_1.content)

				arg_754_1.text_.text = var_757_2

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_4 = 5 <= 0 and var_757_0 or var_757_0 * (utf8.len(var_757_2) / 5)

				if (5 <= 0 and var_757_0 or var_757_0 * (utf8.len(var_757_2) / 5)) > 0 and var_757_0 < var_757_4 then
					arg_754_1.talkMaxDuration = var_757_4

					if var_757_4 + 0 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_4 + 0
					end
				end

				arg_754_1.text_.text = var_757_2
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011179", "story_v_out_123011.awb") ~= 0 then
					local var_757_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011179", "story_v_out_123011.awb") / 1000

					if var_757_5 + 0 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_5 + 0
					end

					if var_757_1.prefab_name ~= "" and arg_754_1.actors_[var_757_1.prefab_name] ~= nil then
						local var_757_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_754_1.actors_[var_757_1.prefab_name].transform, "story_v_out_123011", "123011179", "story_v_out_123011.awb")

						arg_754_1:RecordAudio("123011179", var_757_6)
						arg_754_1:RecordAudio("123011179", var_757_6)
					else
						arg_754_1:AudioAction("play", "voice", "story_v_out_123011", "123011179", "story_v_out_123011.awb")
					end

					arg_754_1:RecordHistoryTalkVoice("story_v_out_123011", "123011179", "story_v_out_123011.awb")
				end

				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_7 = math.max(var_757_0, arg_754_1.talkMaxDuration)

			if 0 <= arg_754_1.time_ and arg_754_1.time_ < 0 + var_757_7 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - 0) / var_757_7

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= 0 + var_757_7 and arg_754_1.time_ < 0 + var_757_7 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	Play123011180 = function(arg_758_0, arg_758_1)
		arg_758_1.time_ = 0
		arg_758_1.frameCnt_ = 0
		arg_758_1.state_ = "playing"
		arg_758_1.curTalkId_ = 123011180
		arg_758_1.duration_ = 2.07

		local var_758_0 = {
			zh = 1.666,
			ja = 2.066
		}
		local var_758_1 = manager.audio:GetLocalizationFlag()

		if var_758_0[var_758_1] ~= nil then
			arg_758_1.duration_ = var_758_0[var_758_1]
		end

		SetActive(arg_758_1.tipsGo_, false)

		function arg_758_1.onSingleLineFinish_()
			arg_758_1.onSingleLineUpdate_ = nil
			arg_758_1.onSingleLineFinish_ = nil
			arg_758_1.state_ = "waiting"
		end

		function arg_758_1.playNext_(arg_760_0)
			if arg_760_0 == 1 then
				arg_758_0:Play123011181(arg_758_1)
			end
		end

		function arg_758_1.onSingleLineUpdate_(arg_761_0)
			local var_761_0 = 0.225

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 then
				arg_758_1.talkMaxDuration = 0
				arg_758_1.dialogCg_.alpha = 1

				arg_758_1.dialog_:SetActive(true)
				SetActive(arg_758_1.leftNameGo_, true)

				arg_758_1.leftNameTxt_.text = arg_758_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_758_1.leftNameTxt_.transform)

				arg_758_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_758_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_758_1:RecordName(arg_758_1.leftNameTxt_.text)
				SetActive(arg_758_1.iconTrs_.gameObject, false)
				arg_758_1.callingController_:SetSelectedState("normal")

				local var_761_1 = arg_758_1:GetWordFromCfg(123011180)
				local var_761_2 = arg_758_1:FormatText(var_761_1.content)

				arg_758_1.text_.text = var_761_2

				LuaForUtil.ClearLinePrefixSymbol(arg_758_1.text_)

				local var_761_4 = 9 <= 0 and var_761_0 or var_761_0 * (utf8.len(var_761_2) / 9)

				if (9 <= 0 and var_761_0 or var_761_0 * (utf8.len(var_761_2) / 9)) > 0 and var_761_0 < var_761_4 then
					arg_758_1.talkMaxDuration = var_761_4

					if var_761_4 + 0 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_4 + 0
					end
				end

				arg_758_1.text_.text = var_761_2
				arg_758_1.typewritter.percent = 0

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011180", "story_v_out_123011.awb") ~= 0 then
					local var_761_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011180", "story_v_out_123011.awb") / 1000

					if var_761_5 + 0 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_5 + 0
					end

					if var_761_1.prefab_name ~= "" and arg_758_1.actors_[var_761_1.prefab_name] ~= nil then
						local var_761_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_758_1.actors_[var_761_1.prefab_name].transform, "story_v_out_123011", "123011180", "story_v_out_123011.awb")

						arg_758_1:RecordAudio("123011180", var_761_6)
						arg_758_1:RecordAudio("123011180", var_761_6)
					else
						arg_758_1:AudioAction("play", "voice", "story_v_out_123011", "123011180", "story_v_out_123011.awb")
					end

					arg_758_1:RecordHistoryTalkVoice("story_v_out_123011", "123011180", "story_v_out_123011.awb")
				end

				arg_758_1:RecordContent(arg_758_1.text_.text)
			end

			local var_761_7 = math.max(var_761_0, arg_758_1.talkMaxDuration)

			if 0 <= arg_758_1.time_ and arg_758_1.time_ < 0 + var_761_7 then
				arg_758_1.typewritter.percent = (arg_758_1.time_ - 0) / var_761_7

				arg_758_1.typewritter:SetDirty()
			end

			if arg_758_1.time_ >= 0 + var_761_7 and arg_758_1.time_ < 0 + var_761_7 + arg_761_0 then
				arg_758_1.typewritter.percent = 1

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(true)
			end
		end

		arg_758_1.nodeConfigList_ = {}

		arg_758_1:InitPlayNodeList()
	end,
	Play123011181 = function(arg_762_0, arg_762_1)
		arg_762_1.time_ = 0
		arg_762_1.frameCnt_ = 0
		arg_762_1.state_ = "playing"
		arg_762_1.curTalkId_ = 123011181
		arg_762_1.duration_ = 5

		SetActive(arg_762_1.tipsGo_, false)

		function arg_762_1.onSingleLineFinish_()
			arg_762_1.onSingleLineUpdate_ = nil
			arg_762_1.onSingleLineFinish_ = nil
			arg_762_1.state_ = "waiting"
		end

		function arg_762_1.playNext_(arg_764_0)
			if arg_764_0 == 1 then
				arg_762_0:Play123011182(arg_762_1)
			end
		end

		function arg_762_1.onSingleLineUpdate_(arg_765_0)
			local var_765_0 = 0.125

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 then
				arg_762_1.talkMaxDuration = 0
				arg_762_1.dialogCg_.alpha = 1

				arg_762_1.dialog_:SetActive(true)
				SetActive(arg_762_1.leftNameGo_, true)

				arg_762_1.leftNameTxt_.text = arg_762_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_762_1.leftNameTxt_.transform)

				arg_762_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_762_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_762_1:RecordName(arg_762_1.leftNameTxt_.text)
				SetActive(arg_762_1.iconTrs_.gameObject, true)
				arg_762_1.iconController_:SetSelectedState("hero")

				arg_762_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_762_1.callingController_:SetSelectedState("normal")

				arg_762_1.keyicon_.color = Color.New(1, 1, 1)
				arg_762_1.icon_.color = Color.New(1, 1, 1)

				local var_765_1 = arg_762_1:FormatText(arg_762_1:GetWordFromCfg(123011181).content)

				arg_762_1.text_.text = var_765_1

				LuaForUtil.ClearLinePrefixSymbol(arg_762_1.text_)

				local var_765_3 = 5 <= 0 and var_765_0 or var_765_0 * (utf8.len(var_765_1) / 5)

				if (5 <= 0 and var_765_0 or var_765_0 * (utf8.len(var_765_1) / 5)) > 0 and var_765_0 < var_765_3 then
					arg_762_1.talkMaxDuration = var_765_3

					if var_765_3 + 0 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_3 + 0
					end
				end

				arg_762_1.text_.text = var_765_1
				arg_762_1.typewritter.percent = 0

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(false)
				arg_762_1:RecordContent(arg_762_1.text_.text)
			end

			local var_765_4 = math.max(var_765_0, arg_762_1.talkMaxDuration)

			if 0 <= arg_762_1.time_ and arg_762_1.time_ < 0 + var_765_4 then
				arg_762_1.typewritter.percent = (arg_762_1.time_ - 0) / var_765_4

				arg_762_1.typewritter:SetDirty()
			end

			if arg_762_1.time_ >= 0 + var_765_4 and arg_762_1.time_ < 0 + var_765_4 + arg_765_0 then
				arg_762_1.typewritter.percent = 1

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(true)
			end
		end

		arg_762_1.nodeConfigList_ = {}

		arg_762_1:InitPlayNodeList()
	end,
	Play123011182 = function(arg_766_0, arg_766_1)
		arg_766_1.time_ = 0
		arg_766_1.frameCnt_ = 0
		arg_766_1.state_ = "playing"
		arg_766_1.curTalkId_ = 123011182
		arg_766_1.duration_ = 5.53

		local var_766_0 = {
			zh = 5.533,
			ja = 4.5
		}
		local var_766_1 = manager.audio:GetLocalizationFlag()

		if var_766_0[var_766_1] ~= nil then
			arg_766_1.duration_ = var_766_0[var_766_1]
		end

		SetActive(arg_766_1.tipsGo_, false)

		function arg_766_1.onSingleLineFinish_()
			arg_766_1.onSingleLineUpdate_ = nil
			arg_766_1.onSingleLineFinish_ = nil
			arg_766_1.state_ = "waiting"
		end

		function arg_766_1.playNext_(arg_768_0)
			if arg_768_0 == 1 then
				arg_766_0:Play123011183(arg_766_1)
			end
		end

		function arg_766_1.onSingleLineUpdate_(arg_769_0)
			local var_769_0 = 0.725

			if 0 < arg_766_1.time_ and arg_766_1.time_ <= 0 + arg_769_0 then
				arg_766_1.talkMaxDuration = 0
				arg_766_1.dialogCg_.alpha = 1

				arg_766_1.dialog_:SetActive(true)
				SetActive(arg_766_1.leftNameGo_, true)

				arg_766_1.leftNameTxt_.text = arg_766_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_766_1.leftNameTxt_.transform)

				arg_766_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_766_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_766_1:RecordName(arg_766_1.leftNameTxt_.text)
				SetActive(arg_766_1.iconTrs_.gameObject, false)
				arg_766_1.callingController_:SetSelectedState("normal")

				local var_769_1 = arg_766_1:GetWordFromCfg(123011182)
				local var_769_2 = arg_766_1:FormatText(var_769_1.content)

				arg_766_1.text_.text = var_769_2

				LuaForUtil.ClearLinePrefixSymbol(arg_766_1.text_)

				local var_769_4 = 29 <= 0 and var_769_0 or var_769_0 * (utf8.len(var_769_2) / 29)

				if (29 <= 0 and var_769_0 or var_769_0 * (utf8.len(var_769_2) / 29)) > 0 and var_769_0 < var_769_4 then
					arg_766_1.talkMaxDuration = var_769_4

					if var_769_4 + 0 > arg_766_1.duration_ then
						arg_766_1.duration_ = var_769_4 + 0
					end
				end

				arg_766_1.text_.text = var_769_2
				arg_766_1.typewritter.percent = 0

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011182", "story_v_out_123011.awb") ~= 0 then
					local var_769_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011182", "story_v_out_123011.awb") / 1000

					if var_769_5 + 0 > arg_766_1.duration_ then
						arg_766_1.duration_ = var_769_5 + 0
					end

					if var_769_1.prefab_name ~= "" and arg_766_1.actors_[var_769_1.prefab_name] ~= nil then
						local var_769_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_766_1.actors_[var_769_1.prefab_name].transform, "story_v_out_123011", "123011182", "story_v_out_123011.awb")

						arg_766_1:RecordAudio("123011182", var_769_6)
						arg_766_1:RecordAudio("123011182", var_769_6)
					else
						arg_766_1:AudioAction("play", "voice", "story_v_out_123011", "123011182", "story_v_out_123011.awb")
					end

					arg_766_1:RecordHistoryTalkVoice("story_v_out_123011", "123011182", "story_v_out_123011.awb")
				end

				arg_766_1:RecordContent(arg_766_1.text_.text)
			end

			local var_769_7 = math.max(var_769_0, arg_766_1.talkMaxDuration)

			if 0 <= arg_766_1.time_ and arg_766_1.time_ < 0 + var_769_7 then
				arg_766_1.typewritter.percent = (arg_766_1.time_ - 0) / var_769_7

				arg_766_1.typewritter:SetDirty()
			end

			if arg_766_1.time_ >= 0 + var_769_7 and arg_766_1.time_ < 0 + var_769_7 + arg_769_0 then
				arg_766_1.typewritter.percent = 1

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(true)
			end
		end

		arg_766_1.nodeConfigList_ = {}

		arg_766_1:InitPlayNodeList()
	end,
	Play123011183 = function(arg_770_0, arg_770_1)
		arg_770_1.time_ = 0
		arg_770_1.frameCnt_ = 0
		arg_770_1.state_ = "playing"
		arg_770_1.curTalkId_ = 123011183
		arg_770_1.duration_ = 5

		SetActive(arg_770_1.tipsGo_, false)

		function arg_770_1.onSingleLineFinish_()
			arg_770_1.onSingleLineUpdate_ = nil
			arg_770_1.onSingleLineFinish_ = nil
			arg_770_1.state_ = "waiting"
		end

		function arg_770_1.playNext_(arg_772_0)
			if arg_772_0 == 1 then
				arg_770_0:Play123011184(arg_770_1)
			end
		end

		function arg_770_1.onSingleLineUpdate_(arg_773_0)
			local var_773_0 = 0.075

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= 0 + arg_773_0 then
				arg_770_1.talkMaxDuration = 0
				arg_770_1.dialogCg_.alpha = 1

				arg_770_1.dialog_:SetActive(true)
				SetActive(arg_770_1.leftNameGo_, true)

				arg_770_1.leftNameTxt_.text = arg_770_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_770_1.leftNameTxt_.transform)

				arg_770_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_770_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_770_1:RecordName(arg_770_1.leftNameTxt_.text)
				SetActive(arg_770_1.iconTrs_.gameObject, true)
				arg_770_1.iconController_:SetSelectedState("hero")

				arg_770_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_770_1.callingController_:SetSelectedState("normal")

				arg_770_1.keyicon_.color = Color.New(1, 1, 1)
				arg_770_1.icon_.color = Color.New(1, 1, 1)

				local var_773_1 = arg_770_1:FormatText(arg_770_1:GetWordFromCfg(123011183).content)

				arg_770_1.text_.text = var_773_1

				LuaForUtil.ClearLinePrefixSymbol(arg_770_1.text_)

				local var_773_3 = 3 <= 0 and var_773_0 or var_773_0 * (utf8.len(var_773_1) / 3)

				if (3 <= 0 and var_773_0 or var_773_0 * (utf8.len(var_773_1) / 3)) > 0 and var_773_0 < var_773_3 then
					arg_770_1.talkMaxDuration = var_773_3

					if var_773_3 + 0 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_3 + 0
					end
				end

				arg_770_1.text_.text = var_773_1
				arg_770_1.typewritter.percent = 0

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(false)
				arg_770_1:RecordContent(arg_770_1.text_.text)
			end

			local var_773_4 = math.max(var_773_0, arg_770_1.talkMaxDuration)

			if 0 <= arg_770_1.time_ and arg_770_1.time_ < 0 + var_773_4 then
				arg_770_1.typewritter.percent = (arg_770_1.time_ - 0) / var_773_4

				arg_770_1.typewritter:SetDirty()
			end

			if arg_770_1.time_ >= 0 + var_773_4 and arg_770_1.time_ < 0 + var_773_4 + arg_773_0 then
				arg_770_1.typewritter.percent = 1

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(true)
			end
		end

		arg_770_1.nodeConfigList_ = {}

		arg_770_1:InitPlayNodeList()
	end,
	Play123011184 = function(arg_774_0, arg_774_1)
		arg_774_1.time_ = 0
		arg_774_1.frameCnt_ = 0
		arg_774_1.state_ = "playing"
		arg_774_1.curTalkId_ = 123011184
		arg_774_1.duration_ = 11

		local var_774_0 = {
			zh = 11,
			ja = 9.6
		}
		local var_774_1 = manager.audio:GetLocalizationFlag()

		if var_774_0[var_774_1] ~= nil then
			arg_774_1.duration_ = var_774_0[var_774_1]
		end

		SetActive(arg_774_1.tipsGo_, false)

		function arg_774_1.onSingleLineFinish_()
			arg_774_1.onSingleLineUpdate_ = nil
			arg_774_1.onSingleLineFinish_ = nil
			arg_774_1.state_ = "waiting"
		end

		function arg_774_1.playNext_(arg_776_0)
			if arg_776_0 == 1 then
				arg_774_0:Play123011185(arg_774_1)
			end
		end

		function arg_774_1.onSingleLineUpdate_(arg_777_0)
			local var_777_0 = 1.35

			if 0 < arg_774_1.time_ and arg_774_1.time_ <= 0 + arg_777_0 then
				arg_774_1.talkMaxDuration = 0
				arg_774_1.dialogCg_.alpha = 1

				arg_774_1.dialog_:SetActive(true)
				SetActive(arg_774_1.leftNameGo_, true)

				arg_774_1.leftNameTxt_.text = arg_774_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_774_1.leftNameTxt_.transform)

				arg_774_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_774_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_774_1:RecordName(arg_774_1.leftNameTxt_.text)
				SetActive(arg_774_1.iconTrs_.gameObject, false)
				arg_774_1.callingController_:SetSelectedState("normal")

				local var_777_1 = arg_774_1:GetWordFromCfg(123011184)
				local var_777_2 = arg_774_1:FormatText(var_777_1.content)

				arg_774_1.text_.text = var_777_2

				LuaForUtil.ClearLinePrefixSymbol(arg_774_1.text_)

				local var_777_4 = 54 <= 0 and var_777_0 or var_777_0 * (utf8.len(var_777_2) / 54)

				if (54 <= 0 and var_777_0 or var_777_0 * (utf8.len(var_777_2) / 54)) > 0 and var_777_0 < var_777_4 then
					arg_774_1.talkMaxDuration = var_777_4

					if var_777_4 + 0 > arg_774_1.duration_ then
						arg_774_1.duration_ = var_777_4 + 0
					end
				end

				arg_774_1.text_.text = var_777_2
				arg_774_1.typewritter.percent = 0

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011184", "story_v_out_123011.awb") ~= 0 then
					local var_777_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011184", "story_v_out_123011.awb") / 1000

					if var_777_5 + 0 > arg_774_1.duration_ then
						arg_774_1.duration_ = var_777_5 + 0
					end

					if var_777_1.prefab_name ~= "" and arg_774_1.actors_[var_777_1.prefab_name] ~= nil then
						local var_777_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_774_1.actors_[var_777_1.prefab_name].transform, "story_v_out_123011", "123011184", "story_v_out_123011.awb")

						arg_774_1:RecordAudio("123011184", var_777_6)
						arg_774_1:RecordAudio("123011184", var_777_6)
					else
						arg_774_1:AudioAction("play", "voice", "story_v_out_123011", "123011184", "story_v_out_123011.awb")
					end

					arg_774_1:RecordHistoryTalkVoice("story_v_out_123011", "123011184", "story_v_out_123011.awb")
				end

				arg_774_1:RecordContent(arg_774_1.text_.text)
			end

			local var_777_7 = math.max(var_777_0, arg_774_1.talkMaxDuration)

			if 0 <= arg_774_1.time_ and arg_774_1.time_ < 0 + var_777_7 then
				arg_774_1.typewritter.percent = (arg_774_1.time_ - 0) / var_777_7

				arg_774_1.typewritter:SetDirty()
			end

			if arg_774_1.time_ >= 0 + var_777_7 and arg_774_1.time_ < 0 + var_777_7 + arg_777_0 then
				arg_774_1.typewritter.percent = 1

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(true)
			end
		end

		arg_774_1.nodeConfigList_ = {}

		arg_774_1:InitPlayNodeList()
	end,
	Play123011185 = function(arg_778_0, arg_778_1)
		arg_778_1.time_ = 0
		arg_778_1.frameCnt_ = 0
		arg_778_1.state_ = "playing"
		arg_778_1.curTalkId_ = 123011185
		arg_778_1.duration_ = 5

		SetActive(arg_778_1.tipsGo_, false)

		function arg_778_1.onSingleLineFinish_()
			arg_778_1.onSingleLineUpdate_ = nil
			arg_778_1.onSingleLineFinish_ = nil
			arg_778_1.state_ = "waiting"
		end

		function arg_778_1.playNext_(arg_780_0)
			if arg_780_0 == 1 then
				arg_778_0:Play123011186(arg_778_1)
			end
		end

		function arg_778_1.onSingleLineUpdate_(arg_781_0)
			local var_781_0 = 0.225

			if 0 < arg_778_1.time_ and arg_778_1.time_ <= 0 + arg_781_0 then
				arg_778_1.talkMaxDuration = 0
				arg_778_1.dialogCg_.alpha = 1

				arg_778_1.dialog_:SetActive(true)
				SetActive(arg_778_1.leftNameGo_, true)

				arg_778_1.leftNameTxt_.text = arg_778_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_778_1.leftNameTxt_.transform)

				arg_778_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_778_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_778_1:RecordName(arg_778_1.leftNameTxt_.text)
				SetActive(arg_778_1.iconTrs_.gameObject, true)
				arg_778_1.iconController_:SetSelectedState("hero")

				arg_778_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_778_1.callingController_:SetSelectedState("normal")

				arg_778_1.keyicon_.color = Color.New(1, 1, 1)
				arg_778_1.icon_.color = Color.New(1, 1, 1)

				local var_781_1 = arg_778_1:FormatText(arg_778_1:GetWordFromCfg(123011185).content)

				arg_778_1.text_.text = var_781_1

				LuaForUtil.ClearLinePrefixSymbol(arg_778_1.text_)

				local var_781_3 = 9 <= 0 and var_781_0 or var_781_0 * (utf8.len(var_781_1) / 9)

				if (9 <= 0 and var_781_0 or var_781_0 * (utf8.len(var_781_1) / 9)) > 0 and var_781_0 < var_781_3 then
					arg_778_1.talkMaxDuration = var_781_3

					if var_781_3 + 0 > arg_778_1.duration_ then
						arg_778_1.duration_ = var_781_3 + 0
					end
				end

				arg_778_1.text_.text = var_781_1
				arg_778_1.typewritter.percent = 0

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(false)
				arg_778_1:RecordContent(arg_778_1.text_.text)
			end

			local var_781_4 = math.max(var_781_0, arg_778_1.talkMaxDuration)

			if 0 <= arg_778_1.time_ and arg_778_1.time_ < 0 + var_781_4 then
				arg_778_1.typewritter.percent = (arg_778_1.time_ - 0) / var_781_4

				arg_778_1.typewritter:SetDirty()
			end

			if arg_778_1.time_ >= 0 + var_781_4 and arg_778_1.time_ < 0 + var_781_4 + arg_781_0 then
				arg_778_1.typewritter.percent = 1

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(true)
			end
		end

		arg_778_1.nodeConfigList_ = {}

		arg_778_1:InitPlayNodeList()
	end,
	Play123011186 = function(arg_782_0, arg_782_1)
		arg_782_1.time_ = 0
		arg_782_1.frameCnt_ = 0
		arg_782_1.state_ = "playing"
		arg_782_1.curTalkId_ = 123011186
		arg_782_1.duration_ = 4.73

		local var_782_0 = {
			zh = 4.733,
			ja = 3.933
		}
		local var_782_1 = manager.audio:GetLocalizationFlag()

		if var_782_0[var_782_1] ~= nil then
			arg_782_1.duration_ = var_782_0[var_782_1]
		end

		SetActive(arg_782_1.tipsGo_, false)

		function arg_782_1.onSingleLineFinish_()
			arg_782_1.onSingleLineUpdate_ = nil
			arg_782_1.onSingleLineFinish_ = nil
			arg_782_1.state_ = "waiting"
		end

		function arg_782_1.playNext_(arg_784_0)
			if arg_784_0 == 1 then
				arg_782_0:Play123011187(arg_782_1)
			end
		end

		function arg_782_1.onSingleLineUpdate_(arg_785_0)
			local var_785_0 = 0.45

			if 0 < arg_782_1.time_ and arg_782_1.time_ <= 0 + arg_785_0 then
				arg_782_1.talkMaxDuration = 0
				arg_782_1.dialogCg_.alpha = 1

				arg_782_1.dialog_:SetActive(true)
				SetActive(arg_782_1.leftNameGo_, true)

				arg_782_1.leftNameTxt_.text = arg_782_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_782_1.leftNameTxt_.transform)

				arg_782_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_782_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_782_1:RecordName(arg_782_1.leftNameTxt_.text)
				SetActive(arg_782_1.iconTrs_.gameObject, true)
				arg_782_1.iconController_:SetSelectedState("hero")

				arg_782_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")

				arg_782_1.callingController_:SetSelectedState("normal")

				arg_782_1.keyicon_.color = Color.New(1, 1, 1)
				arg_782_1.icon_.color = Color.New(1, 1, 1)

				local var_785_1 = arg_782_1:GetWordFromCfg(123011186)
				local var_785_2 = arg_782_1:FormatText(var_785_1.content)

				arg_782_1.text_.text = var_785_2

				LuaForUtil.ClearLinePrefixSymbol(arg_782_1.text_)

				local var_785_4 = 18 <= 0 and var_785_0 or var_785_0 * (utf8.len(var_785_2) / 18)

				if (18 <= 0 and var_785_0 or var_785_0 * (utf8.len(var_785_2) / 18)) > 0 and var_785_0 < var_785_4 then
					arg_782_1.talkMaxDuration = var_785_4

					if var_785_4 + 0 > arg_782_1.duration_ then
						arg_782_1.duration_ = var_785_4 + 0
					end
				end

				arg_782_1.text_.text = var_785_2
				arg_782_1.typewritter.percent = 0

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011186", "story_v_out_123011.awb") ~= 0 then
					local var_785_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011186", "story_v_out_123011.awb") / 1000

					if var_785_5 + 0 > arg_782_1.duration_ then
						arg_782_1.duration_ = var_785_5 + 0
					end

					if var_785_1.prefab_name ~= "" and arg_782_1.actors_[var_785_1.prefab_name] ~= nil then
						local var_785_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_782_1.actors_[var_785_1.prefab_name].transform, "story_v_out_123011", "123011186", "story_v_out_123011.awb")

						arg_782_1:RecordAudio("123011186", var_785_6)
						arg_782_1:RecordAudio("123011186", var_785_6)
					else
						arg_782_1:AudioAction("play", "voice", "story_v_out_123011", "123011186", "story_v_out_123011.awb")
					end

					arg_782_1:RecordHistoryTalkVoice("story_v_out_123011", "123011186", "story_v_out_123011.awb")
				end

				arg_782_1:RecordContent(arg_782_1.text_.text)
			end

			local var_785_7 = math.max(var_785_0, arg_782_1.talkMaxDuration)

			if 0 <= arg_782_1.time_ and arg_782_1.time_ < 0 + var_785_7 then
				arg_782_1.typewritter.percent = (arg_782_1.time_ - 0) / var_785_7

				arg_782_1.typewritter:SetDirty()
			end

			if arg_782_1.time_ >= 0 + var_785_7 and arg_782_1.time_ < 0 + var_785_7 + arg_785_0 then
				arg_782_1.typewritter.percent = 1

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(true)
			end
		end

		arg_782_1.nodeConfigList_ = {}

		arg_782_1:InitPlayNodeList()
	end,
	Play123011187 = function(arg_786_0, arg_786_1)
		arg_786_1.time_ = 0
		arg_786_1.frameCnt_ = 0
		arg_786_1.state_ = "playing"
		arg_786_1.curTalkId_ = 123011187
		arg_786_1.duration_ = 5.87

		local var_786_0 = {
			zh = 5.566,
			ja = 5.866
		}
		local var_786_1 = manager.audio:GetLocalizationFlag()

		if var_786_0[var_786_1] ~= nil then
			arg_786_1.duration_ = var_786_0[var_786_1]
		end

		SetActive(arg_786_1.tipsGo_, false)

		function arg_786_1.onSingleLineFinish_()
			arg_786_1.onSingleLineUpdate_ = nil
			arg_786_1.onSingleLineFinish_ = nil
			arg_786_1.state_ = "waiting"
		end

		function arg_786_1.playNext_(arg_788_0)
			if arg_788_0 == 1 then
				arg_786_0:Play123011188(arg_786_1)
			end
		end

		function arg_786_1.onSingleLineUpdate_(arg_789_0)
			local var_789_0 = 0.675

			if 0 < arg_786_1.time_ and arg_786_1.time_ <= 0 + arg_789_0 then
				arg_786_1.talkMaxDuration = 0
				arg_786_1.dialogCg_.alpha = 1

				arg_786_1.dialog_:SetActive(true)
				SetActive(arg_786_1.leftNameGo_, true)

				arg_786_1.leftNameTxt_.text = arg_786_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_786_1.leftNameTxt_.transform)

				arg_786_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_786_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_786_1:RecordName(arg_786_1.leftNameTxt_.text)
				SetActive(arg_786_1.iconTrs_.gameObject, false)
				arg_786_1.callingController_:SetSelectedState("normal")

				local var_789_1 = arg_786_1:GetWordFromCfg(123011187)
				local var_789_2 = arg_786_1:FormatText(var_789_1.content)

				arg_786_1.text_.text = var_789_2

				LuaForUtil.ClearLinePrefixSymbol(arg_786_1.text_)

				local var_789_4 = 27 <= 0 and var_789_0 or var_789_0 * (utf8.len(var_789_2) / 27)

				if (27 <= 0 and var_789_0 or var_789_0 * (utf8.len(var_789_2) / 27)) > 0 and var_789_0 < var_789_4 then
					arg_786_1.talkMaxDuration = var_789_4

					if var_789_4 + 0 > arg_786_1.duration_ then
						arg_786_1.duration_ = var_789_4 + 0
					end
				end

				arg_786_1.text_.text = var_789_2
				arg_786_1.typewritter.percent = 0

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011187", "story_v_out_123011.awb") ~= 0 then
					local var_789_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011187", "story_v_out_123011.awb") / 1000

					if var_789_5 + 0 > arg_786_1.duration_ then
						arg_786_1.duration_ = var_789_5 + 0
					end

					if var_789_1.prefab_name ~= "" and arg_786_1.actors_[var_789_1.prefab_name] ~= nil then
						local var_789_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_786_1.actors_[var_789_1.prefab_name].transform, "story_v_out_123011", "123011187", "story_v_out_123011.awb")

						arg_786_1:RecordAudio("123011187", var_789_6)
						arg_786_1:RecordAudio("123011187", var_789_6)
					else
						arg_786_1:AudioAction("play", "voice", "story_v_out_123011", "123011187", "story_v_out_123011.awb")
					end

					arg_786_1:RecordHistoryTalkVoice("story_v_out_123011", "123011187", "story_v_out_123011.awb")
				end

				arg_786_1:RecordContent(arg_786_1.text_.text)
			end

			local var_789_7 = math.max(var_789_0, arg_786_1.talkMaxDuration)

			if 0 <= arg_786_1.time_ and arg_786_1.time_ < 0 + var_789_7 then
				arg_786_1.typewritter.percent = (arg_786_1.time_ - 0) / var_789_7

				arg_786_1.typewritter:SetDirty()
			end

			if arg_786_1.time_ >= 0 + var_789_7 and arg_786_1.time_ < 0 + var_789_7 + arg_789_0 then
				arg_786_1.typewritter.percent = 1

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(true)
			end
		end

		arg_786_1.nodeConfigList_ = {}

		arg_786_1:InitPlayNodeList()
	end,
	Play123011188 = function(arg_790_0, arg_790_1)
		arg_790_1.time_ = 0
		arg_790_1.frameCnt_ = 0
		arg_790_1.state_ = "playing"
		arg_790_1.curTalkId_ = 123011188
		arg_790_1.duration_ = 9

		local var_790_0 = {
			zh = 8.333,
			ja = 9
		}
		local var_790_1 = manager.audio:GetLocalizationFlag()

		if var_790_0[var_790_1] ~= nil then
			arg_790_1.duration_ = var_790_0[var_790_1]
		end

		SetActive(arg_790_1.tipsGo_, false)

		function arg_790_1.onSingleLineFinish_()
			arg_790_1.onSingleLineUpdate_ = nil
			arg_790_1.onSingleLineFinish_ = nil
			arg_790_1.state_ = "waiting"
		end

		function arg_790_1.playNext_(arg_792_0)
			if arg_792_0 == 1 then
				arg_790_0:Play123011189(arg_790_1)
			end
		end

		function arg_790_1.onSingleLineUpdate_(arg_793_0)
			local var_793_0 = 1.1

			if 0 < arg_790_1.time_ and arg_790_1.time_ <= 0 + arg_793_0 then
				arg_790_1.talkMaxDuration = 0
				arg_790_1.dialogCg_.alpha = 1

				arg_790_1.dialog_:SetActive(true)
				SetActive(arg_790_1.leftNameGo_, true)

				arg_790_1.leftNameTxt_.text = arg_790_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_790_1.leftNameTxt_.transform)

				arg_790_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_790_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_790_1:RecordName(arg_790_1.leftNameTxt_.text)
				SetActive(arg_790_1.iconTrs_.gameObject, true)
				arg_790_1.iconController_:SetSelectedState("hero")

				arg_790_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_790_1.callingController_:SetSelectedState("normal")

				arg_790_1.keyicon_.color = Color.New(1, 1, 1)
				arg_790_1.icon_.color = Color.New(1, 1, 1)

				local var_793_1 = arg_790_1:GetWordFromCfg(123011188)
				local var_793_2 = arg_790_1:FormatText(var_793_1.content)

				arg_790_1.text_.text = var_793_2

				LuaForUtil.ClearLinePrefixSymbol(arg_790_1.text_)

				local var_793_4 = 44 <= 0 and var_793_0 or var_793_0 * (utf8.len(var_793_2) / 44)

				if (44 <= 0 and var_793_0 or var_793_0 * (utf8.len(var_793_2) / 44)) > 0 and var_793_0 < var_793_4 then
					arg_790_1.talkMaxDuration = var_793_4

					if var_793_4 + 0 > arg_790_1.duration_ then
						arg_790_1.duration_ = var_793_4 + 0
					end
				end

				arg_790_1.text_.text = var_793_2
				arg_790_1.typewritter.percent = 0

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011188", "story_v_out_123011.awb") ~= 0 then
					local var_793_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011188", "story_v_out_123011.awb") / 1000

					if var_793_5 + 0 > arg_790_1.duration_ then
						arg_790_1.duration_ = var_793_5 + 0
					end

					if var_793_1.prefab_name ~= "" and arg_790_1.actors_[var_793_1.prefab_name] ~= nil then
						local var_793_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_790_1.actors_[var_793_1.prefab_name].transform, "story_v_out_123011", "123011188", "story_v_out_123011.awb")

						arg_790_1:RecordAudio("123011188", var_793_6)
						arg_790_1:RecordAudio("123011188", var_793_6)
					else
						arg_790_1:AudioAction("play", "voice", "story_v_out_123011", "123011188", "story_v_out_123011.awb")
					end

					arg_790_1:RecordHistoryTalkVoice("story_v_out_123011", "123011188", "story_v_out_123011.awb")
				end

				arg_790_1:RecordContent(arg_790_1.text_.text)
			end

			local var_793_7 = math.max(var_793_0, arg_790_1.talkMaxDuration)

			if 0 <= arg_790_1.time_ and arg_790_1.time_ < 0 + var_793_7 then
				arg_790_1.typewritter.percent = (arg_790_1.time_ - 0) / var_793_7

				arg_790_1.typewritter:SetDirty()
			end

			if arg_790_1.time_ >= 0 + var_793_7 and arg_790_1.time_ < 0 + var_793_7 + arg_793_0 then
				arg_790_1.typewritter.percent = 1

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(true)
			end
		end

		arg_790_1.nodeConfigList_ = {}

		arg_790_1:InitPlayNodeList()
	end,
	Play123011189 = function(arg_794_0, arg_794_1)
		arg_794_1.time_ = 0
		arg_794_1.frameCnt_ = 0
		arg_794_1.state_ = "playing"
		arg_794_1.curTalkId_ = 123011189
		arg_794_1.duration_ = 9.17

		local var_794_0 = {
			zh = 7.7,
			ja = 9.166
		}
		local var_794_1 = manager.audio:GetLocalizationFlag()

		if var_794_0[var_794_1] ~= nil then
			arg_794_1.duration_ = var_794_0[var_794_1]
		end

		SetActive(arg_794_1.tipsGo_, false)

		function arg_794_1.onSingleLineFinish_()
			arg_794_1.onSingleLineUpdate_ = nil
			arg_794_1.onSingleLineFinish_ = nil
			arg_794_1.state_ = "waiting"
		end

		function arg_794_1.playNext_(arg_796_0)
			if arg_796_0 == 1 then
				arg_794_0:Play123011190(arg_794_1)
			end
		end

		function arg_794_1.onSingleLineUpdate_(arg_797_0)
			local var_797_0 = 1.025

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1.talkMaxDuration = 0
				arg_794_1.dialogCg_.alpha = 1

				arg_794_1.dialog_:SetActive(true)
				SetActive(arg_794_1.leftNameGo_, true)

				arg_794_1.leftNameTxt_.text = arg_794_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_794_1.leftNameTxt_.transform)

				arg_794_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_794_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_794_1:RecordName(arg_794_1.leftNameTxt_.text)
				SetActive(arg_794_1.iconTrs_.gameObject, false)
				arg_794_1.callingController_:SetSelectedState("normal")

				local var_797_1 = arg_794_1:GetWordFromCfg(123011189)
				local var_797_2 = arg_794_1:FormatText(var_797_1.content)

				arg_794_1.text_.text = var_797_2

				LuaForUtil.ClearLinePrefixSymbol(arg_794_1.text_)

				local var_797_4 = 41 <= 0 and var_797_0 or var_797_0 * (utf8.len(var_797_2) / 41)

				if (41 <= 0 and var_797_0 or var_797_0 * (utf8.len(var_797_2) / 41)) > 0 and var_797_0 < var_797_4 then
					arg_794_1.talkMaxDuration = var_797_4

					if var_797_4 + 0 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_4 + 0
					end
				end

				arg_794_1.text_.text = var_797_2
				arg_794_1.typewritter.percent = 0

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011189", "story_v_out_123011.awb") ~= 0 then
					local var_797_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011189", "story_v_out_123011.awb") / 1000

					if var_797_5 + 0 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_5 + 0
					end

					if var_797_1.prefab_name ~= "" and arg_794_1.actors_[var_797_1.prefab_name] ~= nil then
						local var_797_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_794_1.actors_[var_797_1.prefab_name].transform, "story_v_out_123011", "123011189", "story_v_out_123011.awb")

						arg_794_1:RecordAudio("123011189", var_797_6)
						arg_794_1:RecordAudio("123011189", var_797_6)
					else
						arg_794_1:AudioAction("play", "voice", "story_v_out_123011", "123011189", "story_v_out_123011.awb")
					end

					arg_794_1:RecordHistoryTalkVoice("story_v_out_123011", "123011189", "story_v_out_123011.awb")
				end

				arg_794_1:RecordContent(arg_794_1.text_.text)
			end

			local var_797_7 = math.max(var_797_0, arg_794_1.talkMaxDuration)

			if 0 <= arg_794_1.time_ and arg_794_1.time_ < 0 + var_797_7 then
				arg_794_1.typewritter.percent = (arg_794_1.time_ - 0) / var_797_7

				arg_794_1.typewritter:SetDirty()
			end

			if arg_794_1.time_ >= 0 + var_797_7 and arg_794_1.time_ < 0 + var_797_7 + arg_797_0 then
				arg_794_1.typewritter.percent = 1

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(true)
			end
		end

		arg_794_1.nodeConfigList_ = {}

		arg_794_1:InitPlayNodeList()
	end,
	Play123011190 = function(arg_798_0, arg_798_1)
		arg_798_1.time_ = 0
		arg_798_1.frameCnt_ = 0
		arg_798_1.state_ = "playing"
		arg_798_1.curTalkId_ = 123011190
		arg_798_1.duration_ = 5

		SetActive(arg_798_1.tipsGo_, false)

		function arg_798_1.onSingleLineFinish_()
			arg_798_1.onSingleLineUpdate_ = nil
			arg_798_1.onSingleLineFinish_ = nil
			arg_798_1.state_ = "waiting"
		end

		function arg_798_1.playNext_(arg_800_0)
			if arg_800_0 == 1 then
				arg_798_0:Play123011191(arg_798_1)
			end
		end

		function arg_798_1.onSingleLineUpdate_(arg_801_0)
			local var_801_0 = 0.95

			if 0 < arg_798_1.time_ and arg_798_1.time_ <= 0 + arg_801_0 then
				arg_798_1.talkMaxDuration = 0
				arg_798_1.dialogCg_.alpha = 1

				arg_798_1.dialog_:SetActive(true)
				SetActive(arg_798_1.leftNameGo_, false)

				arg_798_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_798_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_798_1:RecordName(arg_798_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_798_1.iconTrs_.gameObject, false)
				arg_798_1.callingController_:SetSelectedState("normal")

				local var_801_1 = arg_798_1:FormatText(arg_798_1:GetWordFromCfg(123011190).content)

				arg_798_1.text_.text = var_801_1

				LuaForUtil.ClearLinePrefixSymbol(arg_798_1.text_)

				local var_801_3 = 38 <= 0 and var_801_0 or var_801_0 * (utf8.len(var_801_1) / 38)

				if (38 <= 0 and var_801_0 or var_801_0 * (utf8.len(var_801_1) / 38)) > 0 and var_801_0 < var_801_3 then
					arg_798_1.talkMaxDuration = var_801_3

					if var_801_3 + 0 > arg_798_1.duration_ then
						arg_798_1.duration_ = var_801_3 + 0
					end
				end

				arg_798_1.text_.text = var_801_1
				arg_798_1.typewritter.percent = 0

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(false)
				arg_798_1:RecordContent(arg_798_1.text_.text)
			end

			local var_801_4 = math.max(var_801_0, arg_798_1.talkMaxDuration)

			if 0 <= arg_798_1.time_ and arg_798_1.time_ < 0 + var_801_4 then
				arg_798_1.typewritter.percent = (arg_798_1.time_ - 0) / var_801_4

				arg_798_1.typewritter:SetDirty()
			end

			if arg_798_1.time_ >= 0 + var_801_4 and arg_798_1.time_ < 0 + var_801_4 + arg_801_0 then
				arg_798_1.typewritter.percent = 1

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(true)
			end
		end

		arg_798_1.nodeConfigList_ = {}

		arg_798_1:InitPlayNodeList()
	end,
	Play123011191 = function(arg_802_0, arg_802_1)
		arg_802_1.time_ = 0
		arg_802_1.frameCnt_ = 0
		arg_802_1.state_ = "playing"
		arg_802_1.curTalkId_ = 123011191
		arg_802_1.duration_ = 5.9

		local var_802_0 = {
			zh = 4.9,
			ja = 5.9
		}
		local var_802_1 = manager.audio:GetLocalizationFlag()

		if var_802_0[var_802_1] ~= nil then
			arg_802_1.duration_ = var_802_0[var_802_1]
		end

		SetActive(arg_802_1.tipsGo_, false)

		function arg_802_1.onSingleLineFinish_()
			arg_802_1.onSingleLineUpdate_ = nil
			arg_802_1.onSingleLineFinish_ = nil
			arg_802_1.state_ = "waiting"
		end

		function arg_802_1.playNext_(arg_804_0)
			if arg_804_0 == 1 then
				arg_802_0:Play123011192(arg_802_1)
			end
		end

		function arg_802_1.onSingleLineUpdate_(arg_805_0)
			local var_805_0 = 0.575

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 then
				arg_802_1.talkMaxDuration = 0
				arg_802_1.dialogCg_.alpha = 1

				arg_802_1.dialog_:SetActive(true)
				SetActive(arg_802_1.leftNameGo_, true)

				arg_802_1.leftNameTxt_.text = arg_802_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_802_1.leftNameTxt_.transform)

				arg_802_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_802_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_802_1:RecordName(arg_802_1.leftNameTxt_.text)
				SetActive(arg_802_1.iconTrs_.gameObject, true)
				arg_802_1.iconController_:SetSelectedState("hero")

				arg_802_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")

				arg_802_1.callingController_:SetSelectedState("normal")

				arg_802_1.keyicon_.color = Color.New(1, 1, 1)
				arg_802_1.icon_.color = Color.New(1, 1, 1)

				local var_805_1 = arg_802_1:GetWordFromCfg(123011191)
				local var_805_2 = arg_802_1:FormatText(var_805_1.content)

				arg_802_1.text_.text = var_805_2

				LuaForUtil.ClearLinePrefixSymbol(arg_802_1.text_)

				local var_805_4 = 23 <= 0 and var_805_0 or var_805_0 * (utf8.len(var_805_2) / 23)

				if (23 <= 0 and var_805_0 or var_805_0 * (utf8.len(var_805_2) / 23)) > 0 and var_805_0 < var_805_4 then
					arg_802_1.talkMaxDuration = var_805_4

					if var_805_4 + 0 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_4 + 0
					end
				end

				arg_802_1.text_.text = var_805_2
				arg_802_1.typewritter.percent = 0

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011191", "story_v_out_123011.awb") ~= 0 then
					local var_805_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011191", "story_v_out_123011.awb") / 1000

					if var_805_5 + 0 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_5 + 0
					end

					if var_805_1.prefab_name ~= "" and arg_802_1.actors_[var_805_1.prefab_name] ~= nil then
						local var_805_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_802_1.actors_[var_805_1.prefab_name].transform, "story_v_out_123011", "123011191", "story_v_out_123011.awb")

						arg_802_1:RecordAudio("123011191", var_805_6)
						arg_802_1:RecordAudio("123011191", var_805_6)
					else
						arg_802_1:AudioAction("play", "voice", "story_v_out_123011", "123011191", "story_v_out_123011.awb")
					end

					arg_802_1:RecordHistoryTalkVoice("story_v_out_123011", "123011191", "story_v_out_123011.awb")
				end

				arg_802_1:RecordContent(arg_802_1.text_.text)
			end

			local var_805_7 = math.max(var_805_0, arg_802_1.talkMaxDuration)

			if 0 <= arg_802_1.time_ and arg_802_1.time_ < 0 + var_805_7 then
				arg_802_1.typewritter.percent = (arg_802_1.time_ - 0) / var_805_7

				arg_802_1.typewritter:SetDirty()
			end

			if arg_802_1.time_ >= 0 + var_805_7 and arg_802_1.time_ < 0 + var_805_7 + arg_805_0 then
				arg_802_1.typewritter.percent = 1

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(true)
			end
		end

		arg_802_1.nodeConfigList_ = {}

		arg_802_1:InitPlayNodeList()
	end,
	Play123011192 = function(arg_806_0, arg_806_1)
		arg_806_1.time_ = 0
		arg_806_1.frameCnt_ = 0
		arg_806_1.state_ = "playing"
		arg_806_1.curTalkId_ = 123011192
		arg_806_1.duration_ = 12.73

		local var_806_0 = {
			zh = 5.4,
			ja = 12.733
		}
		local var_806_1 = manager.audio:GetLocalizationFlag()

		if var_806_0[var_806_1] ~= nil then
			arg_806_1.duration_ = var_806_0[var_806_1]
		end

		SetActive(arg_806_1.tipsGo_, false)

		function arg_806_1.onSingleLineFinish_()
			arg_806_1.onSingleLineUpdate_ = nil
			arg_806_1.onSingleLineFinish_ = nil
			arg_806_1.state_ = "waiting"
		end

		function arg_806_1.playNext_(arg_808_0)
			if arg_808_0 == 1 then
				arg_806_0:Play123011193(arg_806_1)
			end
		end

		function arg_806_1.onSingleLineUpdate_(arg_809_0)
			local var_809_0 = 0.675

			if 0 < arg_806_1.time_ and arg_806_1.time_ <= 0 + arg_809_0 then
				arg_806_1.talkMaxDuration = 0
				arg_806_1.dialogCg_.alpha = 1

				arg_806_1.dialog_:SetActive(true)
				SetActive(arg_806_1.leftNameGo_, true)

				arg_806_1.leftNameTxt_.text = arg_806_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_806_1.leftNameTxt_.transform)

				arg_806_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_806_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_806_1:RecordName(arg_806_1.leftNameTxt_.text)
				SetActive(arg_806_1.iconTrs_.gameObject, false)
				arg_806_1.callingController_:SetSelectedState("normal")

				local var_809_1 = arg_806_1:GetWordFromCfg(123011192)
				local var_809_2 = arg_806_1:FormatText(var_809_1.content)

				arg_806_1.text_.text = var_809_2

				LuaForUtil.ClearLinePrefixSymbol(arg_806_1.text_)

				local var_809_4 = 27 <= 0 and var_809_0 or var_809_0 * (utf8.len(var_809_2) / 27)

				if (27 <= 0 and var_809_0 or var_809_0 * (utf8.len(var_809_2) / 27)) > 0 and var_809_0 < var_809_4 then
					arg_806_1.talkMaxDuration = var_809_4

					if var_809_4 + 0 > arg_806_1.duration_ then
						arg_806_1.duration_ = var_809_4 + 0
					end
				end

				arg_806_1.text_.text = var_809_2
				arg_806_1.typewritter.percent = 0

				arg_806_1.typewritter:SetDirty()
				arg_806_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011192", "story_v_out_123011.awb") ~= 0 then
					local var_809_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011192", "story_v_out_123011.awb") / 1000

					if var_809_5 + 0 > arg_806_1.duration_ then
						arg_806_1.duration_ = var_809_5 + 0
					end

					if var_809_1.prefab_name ~= "" and arg_806_1.actors_[var_809_1.prefab_name] ~= nil then
						local var_809_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_806_1.actors_[var_809_1.prefab_name].transform, "story_v_out_123011", "123011192", "story_v_out_123011.awb")

						arg_806_1:RecordAudio("123011192", var_809_6)
						arg_806_1:RecordAudio("123011192", var_809_6)
					else
						arg_806_1:AudioAction("play", "voice", "story_v_out_123011", "123011192", "story_v_out_123011.awb")
					end

					arg_806_1:RecordHistoryTalkVoice("story_v_out_123011", "123011192", "story_v_out_123011.awb")
				end

				arg_806_1:RecordContent(arg_806_1.text_.text)
			end

			local var_809_7 = math.max(var_809_0, arg_806_1.talkMaxDuration)

			if 0 <= arg_806_1.time_ and arg_806_1.time_ < 0 + var_809_7 then
				arg_806_1.typewritter.percent = (arg_806_1.time_ - 0) / var_809_7

				arg_806_1.typewritter:SetDirty()
			end

			if arg_806_1.time_ >= 0 + var_809_7 and arg_806_1.time_ < 0 + var_809_7 + arg_809_0 then
				arg_806_1.typewritter.percent = 1

				arg_806_1.typewritter:SetDirty()
				arg_806_1:ShowNextGo(true)
			end
		end

		arg_806_1.nodeConfigList_ = {}

		arg_806_1:InitPlayNodeList()
	end,
	Play123011193 = function(arg_810_0, arg_810_1)
		arg_810_1.time_ = 0
		arg_810_1.frameCnt_ = 0
		arg_810_1.state_ = "playing"
		arg_810_1.curTalkId_ = 123011193
		arg_810_1.duration_ = 13.47

		local var_810_0 = {
			zh = 10.266,
			ja = 13.466
		}
		local var_810_1 = manager.audio:GetLocalizationFlag()

		if var_810_0[var_810_1] ~= nil then
			arg_810_1.duration_ = var_810_0[var_810_1]
		end

		SetActive(arg_810_1.tipsGo_, false)

		function arg_810_1.onSingleLineFinish_()
			arg_810_1.onSingleLineUpdate_ = nil
			arg_810_1.onSingleLineFinish_ = nil
			arg_810_1.state_ = "waiting"
		end

		function arg_810_1.playNext_(arg_812_0)
			if arg_812_0 == 1 then
				arg_810_0:Play123011194(arg_810_1)
			end
		end

		function arg_810_1.onSingleLineUpdate_(arg_813_0)
			local var_813_0 = 1.2

			if 0 < arg_810_1.time_ and arg_810_1.time_ <= 0 + arg_813_0 then
				arg_810_1.talkMaxDuration = 0
				arg_810_1.dialogCg_.alpha = 1

				arg_810_1.dialog_:SetActive(true)
				SetActive(arg_810_1.leftNameGo_, true)

				arg_810_1.leftNameTxt_.text = arg_810_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_810_1.leftNameTxt_.transform)

				arg_810_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_810_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_810_1:RecordName(arg_810_1.leftNameTxt_.text)
				SetActive(arg_810_1.iconTrs_.gameObject, true)
				arg_810_1.iconController_:SetSelectedState("hero")

				arg_810_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")

				arg_810_1.callingController_:SetSelectedState("normal")

				arg_810_1.keyicon_.color = Color.New(1, 1, 1)
				arg_810_1.icon_.color = Color.New(1, 1, 1)

				local var_813_1 = arg_810_1:GetWordFromCfg(123011193)
				local var_813_2 = arg_810_1:FormatText(var_813_1.content)

				arg_810_1.text_.text = var_813_2

				LuaForUtil.ClearLinePrefixSymbol(arg_810_1.text_)

				local var_813_4 = 48 <= 0 and var_813_0 or var_813_0 * (utf8.len(var_813_2) / 48)

				if (48 <= 0 and var_813_0 or var_813_0 * (utf8.len(var_813_2) / 48)) > 0 and var_813_0 < var_813_4 then
					arg_810_1.talkMaxDuration = var_813_4

					if var_813_4 + 0 > arg_810_1.duration_ then
						arg_810_1.duration_ = var_813_4 + 0
					end
				end

				arg_810_1.text_.text = var_813_2
				arg_810_1.typewritter.percent = 0

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011193", "story_v_out_123011.awb") ~= 0 then
					local var_813_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011193", "story_v_out_123011.awb") / 1000

					if var_813_5 + 0 > arg_810_1.duration_ then
						arg_810_1.duration_ = var_813_5 + 0
					end

					if var_813_1.prefab_name ~= "" and arg_810_1.actors_[var_813_1.prefab_name] ~= nil then
						local var_813_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_810_1.actors_[var_813_1.prefab_name].transform, "story_v_out_123011", "123011193", "story_v_out_123011.awb")

						arg_810_1:RecordAudio("123011193", var_813_6)
						arg_810_1:RecordAudio("123011193", var_813_6)
					else
						arg_810_1:AudioAction("play", "voice", "story_v_out_123011", "123011193", "story_v_out_123011.awb")
					end

					arg_810_1:RecordHistoryTalkVoice("story_v_out_123011", "123011193", "story_v_out_123011.awb")
				end

				arg_810_1:RecordContent(arg_810_1.text_.text)
			end

			local var_813_7 = math.max(var_813_0, arg_810_1.talkMaxDuration)

			if 0 <= arg_810_1.time_ and arg_810_1.time_ < 0 + var_813_7 then
				arg_810_1.typewritter.percent = (arg_810_1.time_ - 0) / var_813_7

				arg_810_1.typewritter:SetDirty()
			end

			if arg_810_1.time_ >= 0 + var_813_7 and arg_810_1.time_ < 0 + var_813_7 + arg_813_0 then
				arg_810_1.typewritter.percent = 1

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(true)
			end
		end

		arg_810_1.nodeConfigList_ = {}

		arg_810_1:InitPlayNodeList()
	end,
	Play123011194 = function(arg_814_0, arg_814_1)
		arg_814_1.time_ = 0
		arg_814_1.frameCnt_ = 0
		arg_814_1.state_ = "playing"
		arg_814_1.curTalkId_ = 123011194
		arg_814_1.duration_ = 10.67

		local var_814_0 = {
			zh = 9.433,
			ja = 10.666
		}
		local var_814_1 = manager.audio:GetLocalizationFlag()

		if var_814_0[var_814_1] ~= nil then
			arg_814_1.duration_ = var_814_0[var_814_1]
		end

		SetActive(arg_814_1.tipsGo_, false)

		function arg_814_1.onSingleLineFinish_()
			arg_814_1.onSingleLineUpdate_ = nil
			arg_814_1.onSingleLineFinish_ = nil
			arg_814_1.state_ = "waiting"
		end

		function arg_814_1.playNext_(arg_816_0)
			if arg_816_0 == 1 then
				arg_814_0:Play123011195(arg_814_1)
			end
		end

		function arg_814_1.onSingleLineUpdate_(arg_817_0)
			local var_817_0 = 1.175

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 then
				arg_814_1.talkMaxDuration = 0
				arg_814_1.dialogCg_.alpha = 1

				arg_814_1.dialog_:SetActive(true)
				SetActive(arg_814_1.leftNameGo_, true)

				arg_814_1.leftNameTxt_.text = arg_814_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_814_1.leftNameTxt_.transform)

				arg_814_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_814_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_814_1:RecordName(arg_814_1.leftNameTxt_.text)
				SetActive(arg_814_1.iconTrs_.gameObject, false)
				arg_814_1.callingController_:SetSelectedState("normal")

				local var_817_1 = arg_814_1:GetWordFromCfg(123011194)
				local var_817_2 = arg_814_1:FormatText(var_817_1.content)

				arg_814_1.text_.text = var_817_2

				LuaForUtil.ClearLinePrefixSymbol(arg_814_1.text_)

				local var_817_4 = 47 <= 0 and var_817_0 or var_817_0 * (utf8.len(var_817_2) / 47)

				if (47 <= 0 and var_817_0 or var_817_0 * (utf8.len(var_817_2) / 47)) > 0 and var_817_0 < var_817_4 then
					arg_814_1.talkMaxDuration = var_817_4

					if var_817_4 + 0 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_4 + 0
					end
				end

				arg_814_1.text_.text = var_817_2
				arg_814_1.typewritter.percent = 0

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011194", "story_v_out_123011.awb") ~= 0 then
					local var_817_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011194", "story_v_out_123011.awb") / 1000

					if var_817_5 + 0 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_5 + 0
					end

					if var_817_1.prefab_name ~= "" and arg_814_1.actors_[var_817_1.prefab_name] ~= nil then
						local var_817_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_814_1.actors_[var_817_1.prefab_name].transform, "story_v_out_123011", "123011194", "story_v_out_123011.awb")

						arg_814_1:RecordAudio("123011194", var_817_6)
						arg_814_1:RecordAudio("123011194", var_817_6)
					else
						arg_814_1:AudioAction("play", "voice", "story_v_out_123011", "123011194", "story_v_out_123011.awb")
					end

					arg_814_1:RecordHistoryTalkVoice("story_v_out_123011", "123011194", "story_v_out_123011.awb")
				end

				arg_814_1:RecordContent(arg_814_1.text_.text)
			end

			local var_817_7 = math.max(var_817_0, arg_814_1.talkMaxDuration)

			if 0 <= arg_814_1.time_ and arg_814_1.time_ < 0 + var_817_7 then
				arg_814_1.typewritter.percent = (arg_814_1.time_ - 0) / var_817_7

				arg_814_1.typewritter:SetDirty()
			end

			if arg_814_1.time_ >= 0 + var_817_7 and arg_814_1.time_ < 0 + var_817_7 + arg_817_0 then
				arg_814_1.typewritter.percent = 1

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(true)
			end
		end

		arg_814_1.nodeConfigList_ = {}

		arg_814_1:InitPlayNodeList()
	end,
	Play123011195 = function(arg_818_0, arg_818_1)
		arg_818_1.time_ = 0
		arg_818_1.frameCnt_ = 0
		arg_818_1.state_ = "playing"
		arg_818_1.curTalkId_ = 123011195
		arg_818_1.duration_ = 5

		SetActive(arg_818_1.tipsGo_, false)

		function arg_818_1.onSingleLineFinish_()
			arg_818_1.onSingleLineUpdate_ = nil
			arg_818_1.onSingleLineFinish_ = nil
			arg_818_1.state_ = "waiting"
		end

		function arg_818_1.playNext_(arg_820_0)
			if arg_820_0 == 1 then
				arg_818_0:Play123011196(arg_818_1)
			end
		end

		function arg_818_1.onSingleLineUpdate_(arg_821_0)
			local var_821_0 = 0.075

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 then
				arg_818_1.talkMaxDuration = 0
				arg_818_1.dialogCg_.alpha = 1

				arg_818_1.dialog_:SetActive(true)
				SetActive(arg_818_1.leftNameGo_, true)

				arg_818_1.leftNameTxt_.text = arg_818_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_818_1.leftNameTxt_.transform)

				arg_818_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_818_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_818_1:RecordName(arg_818_1.leftNameTxt_.text)
				SetActive(arg_818_1.iconTrs_.gameObject, true)
				arg_818_1.iconController_:SetSelectedState("hero")

				arg_818_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_818_1.callingController_:SetSelectedState("normal")

				arg_818_1.keyicon_.color = Color.New(1, 1, 1)
				arg_818_1.icon_.color = Color.New(1, 1, 1)

				local var_821_1 = arg_818_1:FormatText(arg_818_1:GetWordFromCfg(123011195).content)

				arg_818_1.text_.text = var_821_1

				LuaForUtil.ClearLinePrefixSymbol(arg_818_1.text_)

				local var_821_3 = 3 <= 0 and var_821_0 or var_821_0 * (utf8.len(var_821_1) / 3)

				if (3 <= 0 and var_821_0 or var_821_0 * (utf8.len(var_821_1) / 3)) > 0 and var_821_0 < var_821_3 then
					arg_818_1.talkMaxDuration = var_821_3

					if var_821_3 + 0 > arg_818_1.duration_ then
						arg_818_1.duration_ = var_821_3 + 0
					end
				end

				arg_818_1.text_.text = var_821_1
				arg_818_1.typewritter.percent = 0

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(false)
				arg_818_1:RecordContent(arg_818_1.text_.text)
			end

			local var_821_4 = math.max(var_821_0, arg_818_1.talkMaxDuration)

			if 0 <= arg_818_1.time_ and arg_818_1.time_ < 0 + var_821_4 then
				arg_818_1.typewritter.percent = (arg_818_1.time_ - 0) / var_821_4

				arg_818_1.typewritter:SetDirty()
			end

			if arg_818_1.time_ >= 0 + var_821_4 and arg_818_1.time_ < 0 + var_821_4 + arg_821_0 then
				arg_818_1.typewritter.percent = 1

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(true)
			end
		end

		arg_818_1.nodeConfigList_ = {}

		arg_818_1:InitPlayNodeList()
	end,
	Play123011196 = function(arg_822_0, arg_822_1)
		arg_822_1.time_ = 0
		arg_822_1.frameCnt_ = 0
		arg_822_1.state_ = "playing"
		arg_822_1.curTalkId_ = 123011196
		arg_822_1.duration_ = 14.1

		local var_822_0 = {
			zh = 11,
			ja = 14.1
		}
		local var_822_1 = manager.audio:GetLocalizationFlag()

		if var_822_0[var_822_1] ~= nil then
			arg_822_1.duration_ = var_822_0[var_822_1]
		end

		SetActive(arg_822_1.tipsGo_, false)

		function arg_822_1.onSingleLineFinish_()
			arg_822_1.onSingleLineUpdate_ = nil
			arg_822_1.onSingleLineFinish_ = nil
			arg_822_1.state_ = "waiting"
		end

		function arg_822_1.playNext_(arg_824_0)
			if arg_824_0 == 1 then
				arg_822_0:Play123011197(arg_822_1)
			end
		end

		function arg_822_1.onSingleLineUpdate_(arg_825_0)
			local var_825_0 = 1.475

			if 0 < arg_822_1.time_ and arg_822_1.time_ <= 0 + arg_825_0 then
				arg_822_1.talkMaxDuration = 0
				arg_822_1.dialogCg_.alpha = 1

				arg_822_1.dialog_:SetActive(true)
				SetActive(arg_822_1.leftNameGo_, true)

				arg_822_1.leftNameTxt_.text = arg_822_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_822_1.leftNameTxt_.transform)

				arg_822_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_822_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_822_1:RecordName(arg_822_1.leftNameTxt_.text)
				SetActive(arg_822_1.iconTrs_.gameObject, false)
				arg_822_1.callingController_:SetSelectedState("normal")

				local var_825_1 = arg_822_1:GetWordFromCfg(123011196)
				local var_825_2 = arg_822_1:FormatText(var_825_1.content)

				arg_822_1.text_.text = var_825_2

				LuaForUtil.ClearLinePrefixSymbol(arg_822_1.text_)

				local var_825_4 = 59 <= 0 and var_825_0 or var_825_0 * (utf8.len(var_825_2) / 59)

				if (59 <= 0 and var_825_0 or var_825_0 * (utf8.len(var_825_2) / 59)) > 0 and var_825_0 < var_825_4 then
					arg_822_1.talkMaxDuration = var_825_4

					if var_825_4 + 0 > arg_822_1.duration_ then
						arg_822_1.duration_ = var_825_4 + 0
					end
				end

				arg_822_1.text_.text = var_825_2
				arg_822_1.typewritter.percent = 0

				arg_822_1.typewritter:SetDirty()
				arg_822_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011196", "story_v_out_123011.awb") ~= 0 then
					local var_825_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011196", "story_v_out_123011.awb") / 1000

					if var_825_5 + 0 > arg_822_1.duration_ then
						arg_822_1.duration_ = var_825_5 + 0
					end

					if var_825_1.prefab_name ~= "" and arg_822_1.actors_[var_825_1.prefab_name] ~= nil then
						local var_825_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_822_1.actors_[var_825_1.prefab_name].transform, "story_v_out_123011", "123011196", "story_v_out_123011.awb")

						arg_822_1:RecordAudio("123011196", var_825_6)
						arg_822_1:RecordAudio("123011196", var_825_6)
					else
						arg_822_1:AudioAction("play", "voice", "story_v_out_123011", "123011196", "story_v_out_123011.awb")
					end

					arg_822_1:RecordHistoryTalkVoice("story_v_out_123011", "123011196", "story_v_out_123011.awb")
				end

				arg_822_1:RecordContent(arg_822_1.text_.text)
			end

			local var_825_7 = math.max(var_825_0, arg_822_1.talkMaxDuration)

			if 0 <= arg_822_1.time_ and arg_822_1.time_ < 0 + var_825_7 then
				arg_822_1.typewritter.percent = (arg_822_1.time_ - 0) / var_825_7

				arg_822_1.typewritter:SetDirty()
			end

			if arg_822_1.time_ >= 0 + var_825_7 and arg_822_1.time_ < 0 + var_825_7 + arg_825_0 then
				arg_822_1.typewritter.percent = 1

				arg_822_1.typewritter:SetDirty()
				arg_822_1:ShowNextGo(true)
			end
		end

		arg_822_1.nodeConfigList_ = {}

		arg_822_1:InitPlayNodeList()
	end,
	Play123011197 = function(arg_826_0, arg_826_1)
		arg_826_1.time_ = 0
		arg_826_1.frameCnt_ = 0
		arg_826_1.state_ = "playing"
		arg_826_1.curTalkId_ = 123011197
		arg_826_1.duration_ = 5

		SetActive(arg_826_1.tipsGo_, false)

		function arg_826_1.onSingleLineFinish_()
			arg_826_1.onSingleLineUpdate_ = nil
			arg_826_1.onSingleLineFinish_ = nil
			arg_826_1.state_ = "waiting"
		end

		function arg_826_1.playNext_(arg_828_0)
			if arg_828_0 == 1 then
				arg_826_0:Play123011198(arg_826_1)
			end
		end

		function arg_826_1.onSingleLineUpdate_(arg_829_0)
			local var_829_0 = 0.075

			if 0 < arg_826_1.time_ and arg_826_1.time_ <= 0 + arg_829_0 then
				arg_826_1.talkMaxDuration = 0
				arg_826_1.dialogCg_.alpha = 1

				arg_826_1.dialog_:SetActive(true)
				SetActive(arg_826_1.leftNameGo_, true)

				arg_826_1.leftNameTxt_.text = arg_826_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_826_1.leftNameTxt_.transform)

				arg_826_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_826_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_826_1:RecordName(arg_826_1.leftNameTxt_.text)
				SetActive(arg_826_1.iconTrs_.gameObject, true)
				arg_826_1.iconController_:SetSelectedState("hero")

				arg_826_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_826_1.callingController_:SetSelectedState("normal")

				arg_826_1.keyicon_.color = Color.New(1, 1, 1)
				arg_826_1.icon_.color = Color.New(1, 1, 1)

				local var_829_1 = arg_826_1:FormatText(arg_826_1:GetWordFromCfg(123011197).content)

				arg_826_1.text_.text = var_829_1

				LuaForUtil.ClearLinePrefixSymbol(arg_826_1.text_)

				local var_829_3 = 3 <= 0 and var_829_0 or var_829_0 * (utf8.len(var_829_1) / 3)

				if (3 <= 0 and var_829_0 or var_829_0 * (utf8.len(var_829_1) / 3)) > 0 and var_829_0 < var_829_3 then
					arg_826_1.talkMaxDuration = var_829_3

					if var_829_3 + 0 > arg_826_1.duration_ then
						arg_826_1.duration_ = var_829_3 + 0
					end
				end

				arg_826_1.text_.text = var_829_1
				arg_826_1.typewritter.percent = 0

				arg_826_1.typewritter:SetDirty()
				arg_826_1:ShowNextGo(false)
				arg_826_1:RecordContent(arg_826_1.text_.text)
			end

			local var_829_4 = math.max(var_829_0, arg_826_1.talkMaxDuration)

			if 0 <= arg_826_1.time_ and arg_826_1.time_ < 0 + var_829_4 then
				arg_826_1.typewritter.percent = (arg_826_1.time_ - 0) / var_829_4

				arg_826_1.typewritter:SetDirty()
			end

			if arg_826_1.time_ >= 0 + var_829_4 and arg_826_1.time_ < 0 + var_829_4 + arg_829_0 then
				arg_826_1.typewritter.percent = 1

				arg_826_1.typewritter:SetDirty()
				arg_826_1:ShowNextGo(true)
			end
		end

		arg_826_1.nodeConfigList_ = {}

		arg_826_1:InitPlayNodeList()
	end,
	Play123011198 = function(arg_830_0, arg_830_1)
		arg_830_1.time_ = 0
		arg_830_1.frameCnt_ = 0
		arg_830_1.state_ = "playing"
		arg_830_1.curTalkId_ = 123011198
		arg_830_1.duration_ = 7.6

		local var_830_0 = {
			zh = 7.266,
			ja = 7.6
		}
		local var_830_1 = manager.audio:GetLocalizationFlag()

		if var_830_0[var_830_1] ~= nil then
			arg_830_1.duration_ = var_830_0[var_830_1]
		end

		SetActive(arg_830_1.tipsGo_, false)

		function arg_830_1.onSingleLineFinish_()
			arg_830_1.onSingleLineUpdate_ = nil
			arg_830_1.onSingleLineFinish_ = nil
			arg_830_1.state_ = "waiting"
		end

		function arg_830_1.playNext_(arg_832_0)
			if arg_832_0 == 1 then
				arg_830_0:Play123011199(arg_830_1)
			end
		end

		function arg_830_1.onSingleLineUpdate_(arg_833_0)
			local var_833_0 = 0.85

			if 0 < arg_830_1.time_ and arg_830_1.time_ <= 0 + arg_833_0 then
				arg_830_1.talkMaxDuration = 0
				arg_830_1.dialogCg_.alpha = 1

				arg_830_1.dialog_:SetActive(true)
				SetActive(arg_830_1.leftNameGo_, true)

				arg_830_1.leftNameTxt_.text = arg_830_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_830_1.leftNameTxt_.transform)

				arg_830_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_830_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_830_1:RecordName(arg_830_1.leftNameTxt_.text)
				SetActive(arg_830_1.iconTrs_.gameObject, true)
				arg_830_1.iconController_:SetSelectedState("hero")

				arg_830_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_830_1.callingController_:SetSelectedState("normal")

				arg_830_1.keyicon_.color = Color.New(1, 1, 1)
				arg_830_1.icon_.color = Color.New(1, 1, 1)

				local var_833_1 = arg_830_1:GetWordFromCfg(123011198)
				local var_833_2 = arg_830_1:FormatText(var_833_1.content)

				arg_830_1.text_.text = var_833_2

				LuaForUtil.ClearLinePrefixSymbol(arg_830_1.text_)

				local var_833_4 = 34 <= 0 and var_833_0 or var_833_0 * (utf8.len(var_833_2) / 34)

				if (34 <= 0 and var_833_0 or var_833_0 * (utf8.len(var_833_2) / 34)) > 0 and var_833_0 < var_833_4 then
					arg_830_1.talkMaxDuration = var_833_4

					if var_833_4 + 0 > arg_830_1.duration_ then
						arg_830_1.duration_ = var_833_4 + 0
					end
				end

				arg_830_1.text_.text = var_833_2
				arg_830_1.typewritter.percent = 0

				arg_830_1.typewritter:SetDirty()
				arg_830_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011198", "story_v_out_123011.awb") ~= 0 then
					local var_833_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011198", "story_v_out_123011.awb") / 1000

					if var_833_5 + 0 > arg_830_1.duration_ then
						arg_830_1.duration_ = var_833_5 + 0
					end

					if var_833_1.prefab_name ~= "" and arg_830_1.actors_[var_833_1.prefab_name] ~= nil then
						local var_833_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_830_1.actors_[var_833_1.prefab_name].transform, "story_v_out_123011", "123011198", "story_v_out_123011.awb")

						arg_830_1:RecordAudio("123011198", var_833_6)
						arg_830_1:RecordAudio("123011198", var_833_6)
					else
						arg_830_1:AudioAction("play", "voice", "story_v_out_123011", "123011198", "story_v_out_123011.awb")
					end

					arg_830_1:RecordHistoryTalkVoice("story_v_out_123011", "123011198", "story_v_out_123011.awb")
				end

				arg_830_1:RecordContent(arg_830_1.text_.text)
			end

			local var_833_7 = math.max(var_833_0, arg_830_1.talkMaxDuration)

			if 0 <= arg_830_1.time_ and arg_830_1.time_ < 0 + var_833_7 then
				arg_830_1.typewritter.percent = (arg_830_1.time_ - 0) / var_833_7

				arg_830_1.typewritter:SetDirty()
			end

			if arg_830_1.time_ >= 0 + var_833_7 and arg_830_1.time_ < 0 + var_833_7 + arg_833_0 then
				arg_830_1.typewritter.percent = 1

				arg_830_1.typewritter:SetDirty()
				arg_830_1:ShowNextGo(true)
			end
		end

		arg_830_1.nodeConfigList_ = {}

		arg_830_1:InitPlayNodeList()
	end,
	Play123011199 = function(arg_834_0, arg_834_1)
		arg_834_1.time_ = 0
		arg_834_1.frameCnt_ = 0
		arg_834_1.state_ = "playing"
		arg_834_1.curTalkId_ = 123011199
		arg_834_1.duration_ = 5.7

		local var_834_0 = {
			zh = 5.7,
			ja = 5.4
		}
		local var_834_1 = manager.audio:GetLocalizationFlag()

		if var_834_0[var_834_1] ~= nil then
			arg_834_1.duration_ = var_834_0[var_834_1]
		end

		SetActive(arg_834_1.tipsGo_, false)

		function arg_834_1.onSingleLineFinish_()
			arg_834_1.onSingleLineUpdate_ = nil
			arg_834_1.onSingleLineFinish_ = nil
			arg_834_1.state_ = "waiting"
		end

		function arg_834_1.playNext_(arg_836_0)
			if arg_836_0 == 1 then
				arg_834_0:Play123011200(arg_834_1)
			end
		end

		function arg_834_1.onSingleLineUpdate_(arg_837_0)
			local var_837_0 = 0.65

			if 0 < arg_834_1.time_ and arg_834_1.time_ <= 0 + arg_837_0 then
				arg_834_1.talkMaxDuration = 0
				arg_834_1.dialogCg_.alpha = 1

				arg_834_1.dialog_:SetActive(true)
				SetActive(arg_834_1.leftNameGo_, true)

				arg_834_1.leftNameTxt_.text = arg_834_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_834_1.leftNameTxt_.transform)

				arg_834_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_834_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_834_1:RecordName(arg_834_1.leftNameTxt_.text)
				SetActive(arg_834_1.iconTrs_.gameObject, false)
				arg_834_1.callingController_:SetSelectedState("normal")

				local var_837_1 = arg_834_1:GetWordFromCfg(123011199)
				local var_837_2 = arg_834_1:FormatText(var_837_1.content)

				arg_834_1.text_.text = var_837_2

				LuaForUtil.ClearLinePrefixSymbol(arg_834_1.text_)

				local var_837_4 = 26 <= 0 and var_837_0 or var_837_0 * (utf8.len(var_837_2) / 26)

				if (26 <= 0 and var_837_0 or var_837_0 * (utf8.len(var_837_2) / 26)) > 0 and var_837_0 < var_837_4 then
					arg_834_1.talkMaxDuration = var_837_4

					if var_837_4 + 0 > arg_834_1.duration_ then
						arg_834_1.duration_ = var_837_4 + 0
					end
				end

				arg_834_1.text_.text = var_837_2
				arg_834_1.typewritter.percent = 0

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011199", "story_v_out_123011.awb") ~= 0 then
					local var_837_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011199", "story_v_out_123011.awb") / 1000

					if var_837_5 + 0 > arg_834_1.duration_ then
						arg_834_1.duration_ = var_837_5 + 0
					end

					if var_837_1.prefab_name ~= "" and arg_834_1.actors_[var_837_1.prefab_name] ~= nil then
						local var_837_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_834_1.actors_[var_837_1.prefab_name].transform, "story_v_out_123011", "123011199", "story_v_out_123011.awb")

						arg_834_1:RecordAudio("123011199", var_837_6)
						arg_834_1:RecordAudio("123011199", var_837_6)
					else
						arg_834_1:AudioAction("play", "voice", "story_v_out_123011", "123011199", "story_v_out_123011.awb")
					end

					arg_834_1:RecordHistoryTalkVoice("story_v_out_123011", "123011199", "story_v_out_123011.awb")
				end

				arg_834_1:RecordContent(arg_834_1.text_.text)
			end

			local var_837_7 = math.max(var_837_0, arg_834_1.talkMaxDuration)

			if 0 <= arg_834_1.time_ and arg_834_1.time_ < 0 + var_837_7 then
				arg_834_1.typewritter.percent = (arg_834_1.time_ - 0) / var_837_7

				arg_834_1.typewritter:SetDirty()
			end

			if arg_834_1.time_ >= 0 + var_837_7 and arg_834_1.time_ < 0 + var_837_7 + arg_837_0 then
				arg_834_1.typewritter.percent = 1

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(true)
			end
		end

		arg_834_1.nodeConfigList_ = {}

		arg_834_1:InitPlayNodeList()
	end,
	Play123011200 = function(arg_838_0, arg_838_1)
		arg_838_1.time_ = 0
		arg_838_1.frameCnt_ = 0
		arg_838_1.state_ = "playing"
		arg_838_1.curTalkId_ = 123011200
		arg_838_1.duration_ = 7.13

		local var_838_0 = {
			zh = 5.5,
			ja = 7.133
		}
		local var_838_1 = manager.audio:GetLocalizationFlag()

		if var_838_0[var_838_1] ~= nil then
			arg_838_1.duration_ = var_838_0[var_838_1]
		end

		SetActive(arg_838_1.tipsGo_, false)

		function arg_838_1.onSingleLineFinish_()
			arg_838_1.onSingleLineUpdate_ = nil
			arg_838_1.onSingleLineFinish_ = nil
			arg_838_1.state_ = "waiting"
		end

		function arg_838_1.playNext_(arg_840_0)
			if arg_840_0 == 1 then
				arg_838_0:Play123011201(arg_838_1)
			end
		end

		function arg_838_1.onSingleLineUpdate_(arg_841_0)
			local var_841_0 = 0.725

			if 0 < arg_838_1.time_ and arg_838_1.time_ <= 0 + arg_841_0 then
				arg_838_1.talkMaxDuration = 0
				arg_838_1.dialogCg_.alpha = 1

				arg_838_1.dialog_:SetActive(true)
				SetActive(arg_838_1.leftNameGo_, true)

				arg_838_1.leftNameTxt_.text = arg_838_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_838_1.leftNameTxt_.transform)

				arg_838_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_838_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_838_1:RecordName(arg_838_1.leftNameTxt_.text)
				SetActive(arg_838_1.iconTrs_.gameObject, true)
				arg_838_1.iconController_:SetSelectedState("hero")

				arg_838_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")

				arg_838_1.callingController_:SetSelectedState("normal")

				arg_838_1.keyicon_.color = Color.New(1, 1, 1)
				arg_838_1.icon_.color = Color.New(1, 1, 1)

				local var_841_1 = arg_838_1:GetWordFromCfg(123011200)
				local var_841_2 = arg_838_1:FormatText(var_841_1.content)

				arg_838_1.text_.text = var_841_2

				LuaForUtil.ClearLinePrefixSymbol(arg_838_1.text_)

				local var_841_4 = 29 <= 0 and var_841_0 or var_841_0 * (utf8.len(var_841_2) / 29)

				if (29 <= 0 and var_841_0 or var_841_0 * (utf8.len(var_841_2) / 29)) > 0 and var_841_0 < var_841_4 then
					arg_838_1.talkMaxDuration = var_841_4

					if var_841_4 + 0 > arg_838_1.duration_ then
						arg_838_1.duration_ = var_841_4 + 0
					end
				end

				arg_838_1.text_.text = var_841_2
				arg_838_1.typewritter.percent = 0

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011200", "story_v_out_123011.awb") ~= 0 then
					local var_841_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011200", "story_v_out_123011.awb") / 1000

					if var_841_5 + 0 > arg_838_1.duration_ then
						arg_838_1.duration_ = var_841_5 + 0
					end

					if var_841_1.prefab_name ~= "" and arg_838_1.actors_[var_841_1.prefab_name] ~= nil then
						local var_841_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_838_1.actors_[var_841_1.prefab_name].transform, "story_v_out_123011", "123011200", "story_v_out_123011.awb")

						arg_838_1:RecordAudio("123011200", var_841_6)
						arg_838_1:RecordAudio("123011200", var_841_6)
					else
						arg_838_1:AudioAction("play", "voice", "story_v_out_123011", "123011200", "story_v_out_123011.awb")
					end

					arg_838_1:RecordHistoryTalkVoice("story_v_out_123011", "123011200", "story_v_out_123011.awb")
				end

				arg_838_1:RecordContent(arg_838_1.text_.text)
			end

			local var_841_7 = math.max(var_841_0, arg_838_1.talkMaxDuration)

			if 0 <= arg_838_1.time_ and arg_838_1.time_ < 0 + var_841_7 then
				arg_838_1.typewritter.percent = (arg_838_1.time_ - 0) / var_841_7

				arg_838_1.typewritter:SetDirty()
			end

			if arg_838_1.time_ >= 0 + var_841_7 and arg_838_1.time_ < 0 + var_841_7 + arg_841_0 then
				arg_838_1.typewritter.percent = 1

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(true)
			end
		end

		arg_838_1.nodeConfigList_ = {}

		arg_838_1:InitPlayNodeList()
	end,
	Play123011201 = function(arg_842_0, arg_842_1)
		arg_842_1.time_ = 0
		arg_842_1.frameCnt_ = 0
		arg_842_1.state_ = "playing"
		arg_842_1.curTalkId_ = 123011201
		arg_842_1.duration_ = 13.87

		local var_842_0 = {
			zh = 10.7,
			ja = 13.866
		}
		local var_842_1 = manager.audio:GetLocalizationFlag()

		if var_842_0[var_842_1] ~= nil then
			arg_842_1.duration_ = var_842_0[var_842_1]
		end

		SetActive(arg_842_1.tipsGo_, false)

		function arg_842_1.onSingleLineFinish_()
			arg_842_1.onSingleLineUpdate_ = nil
			arg_842_1.onSingleLineFinish_ = nil
			arg_842_1.state_ = "waiting"
		end

		function arg_842_1.playNext_(arg_844_0)
			if arg_844_0 == 1 then
				arg_842_0:Play123011202(arg_842_1)
			end
		end

		function arg_842_1.onSingleLineUpdate_(arg_845_0)
			local var_845_0 = 1.3

			if 0 < arg_842_1.time_ and arg_842_1.time_ <= 0 + arg_845_0 then
				arg_842_1.talkMaxDuration = 0
				arg_842_1.dialogCg_.alpha = 1

				arg_842_1.dialog_:SetActive(true)
				SetActive(arg_842_1.leftNameGo_, true)

				arg_842_1.leftNameTxt_.text = arg_842_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_842_1.leftNameTxt_.transform)

				arg_842_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_842_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_842_1:RecordName(arg_842_1.leftNameTxt_.text)
				SetActive(arg_842_1.iconTrs_.gameObject, true)
				arg_842_1.iconController_:SetSelectedState("hero")

				arg_842_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")

				arg_842_1.callingController_:SetSelectedState("normal")

				arg_842_1.keyicon_.color = Color.New(1, 1, 1)
				arg_842_1.icon_.color = Color.New(1, 1, 1)

				local var_845_1 = arg_842_1:GetWordFromCfg(123011201)
				local var_845_2 = arg_842_1:FormatText(var_845_1.content)

				arg_842_1.text_.text = var_845_2

				LuaForUtil.ClearLinePrefixSymbol(arg_842_1.text_)

				local var_845_4 = 52 <= 0 and var_845_0 or var_845_0 * (utf8.len(var_845_2) / 52)

				if (52 <= 0 and var_845_0 or var_845_0 * (utf8.len(var_845_2) / 52)) > 0 and var_845_0 < var_845_4 then
					arg_842_1.talkMaxDuration = var_845_4

					if var_845_4 + 0 > arg_842_1.duration_ then
						arg_842_1.duration_ = var_845_4 + 0
					end
				end

				arg_842_1.text_.text = var_845_2
				arg_842_1.typewritter.percent = 0

				arg_842_1.typewritter:SetDirty()
				arg_842_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011201", "story_v_out_123011.awb") ~= 0 then
					local var_845_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011201", "story_v_out_123011.awb") / 1000

					if var_845_5 + 0 > arg_842_1.duration_ then
						arg_842_1.duration_ = var_845_5 + 0
					end

					if var_845_1.prefab_name ~= "" and arg_842_1.actors_[var_845_1.prefab_name] ~= nil then
						local var_845_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_842_1.actors_[var_845_1.prefab_name].transform, "story_v_out_123011", "123011201", "story_v_out_123011.awb")

						arg_842_1:RecordAudio("123011201", var_845_6)
						arg_842_1:RecordAudio("123011201", var_845_6)
					else
						arg_842_1:AudioAction("play", "voice", "story_v_out_123011", "123011201", "story_v_out_123011.awb")
					end

					arg_842_1:RecordHistoryTalkVoice("story_v_out_123011", "123011201", "story_v_out_123011.awb")
				end

				arg_842_1:RecordContent(arg_842_1.text_.text)
			end

			local var_845_7 = math.max(var_845_0, arg_842_1.talkMaxDuration)

			if 0 <= arg_842_1.time_ and arg_842_1.time_ < 0 + var_845_7 then
				arg_842_1.typewritter.percent = (arg_842_1.time_ - 0) / var_845_7

				arg_842_1.typewritter:SetDirty()
			end

			if arg_842_1.time_ >= 0 + var_845_7 and arg_842_1.time_ < 0 + var_845_7 + arg_845_0 then
				arg_842_1.typewritter.percent = 1

				arg_842_1.typewritter:SetDirty()
				arg_842_1:ShowNextGo(true)
			end
		end

		arg_842_1.nodeConfigList_ = {}

		arg_842_1:InitPlayNodeList()
	end,
	Play123011202 = function(arg_846_0, arg_846_1)
		arg_846_1.time_ = 0
		arg_846_1.frameCnt_ = 0
		arg_846_1.state_ = "playing"
		arg_846_1.curTalkId_ = 123011202
		arg_846_1.duration_ = 6.27

		local var_846_0 = {
			zh = 4.4,
			ja = 6.266
		}
		local var_846_1 = manager.audio:GetLocalizationFlag()

		if var_846_0[var_846_1] ~= nil then
			arg_846_1.duration_ = var_846_0[var_846_1]
		end

		SetActive(arg_846_1.tipsGo_, false)

		function arg_846_1.onSingleLineFinish_()
			arg_846_1.onSingleLineUpdate_ = nil
			arg_846_1.onSingleLineFinish_ = nil
			arg_846_1.state_ = "waiting"
		end

		function arg_846_1.playNext_(arg_848_0)
			if arg_848_0 == 1 then
				arg_846_0:Play123011203(arg_846_1)
			end
		end

		function arg_846_1.onSingleLineUpdate_(arg_849_0)
			local var_849_0 = 0.5

			if 0 < arg_846_1.time_ and arg_846_1.time_ <= 0 + arg_849_0 then
				arg_846_1.talkMaxDuration = 0
				arg_846_1.dialogCg_.alpha = 1

				arg_846_1.dialog_:SetActive(true)
				SetActive(arg_846_1.leftNameGo_, true)

				arg_846_1.leftNameTxt_.text = arg_846_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_846_1.leftNameTxt_.transform)

				arg_846_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_846_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_846_1:RecordName(arg_846_1.leftNameTxt_.text)
				SetActive(arg_846_1.iconTrs_.gameObject, false)
				arg_846_1.callingController_:SetSelectedState("normal")

				local var_849_1 = arg_846_1:GetWordFromCfg(123011202)
				local var_849_2 = arg_846_1:FormatText(var_849_1.content)

				arg_846_1.text_.text = var_849_2

				LuaForUtil.ClearLinePrefixSymbol(arg_846_1.text_)

				local var_849_4 = 20 <= 0 and var_849_0 or var_849_0 * (utf8.len(var_849_2) / 20)

				if (20 <= 0 and var_849_0 or var_849_0 * (utf8.len(var_849_2) / 20)) > 0 and var_849_0 < var_849_4 then
					arg_846_1.talkMaxDuration = var_849_4

					if var_849_4 + 0 > arg_846_1.duration_ then
						arg_846_1.duration_ = var_849_4 + 0
					end
				end

				arg_846_1.text_.text = var_849_2
				arg_846_1.typewritter.percent = 0

				arg_846_1.typewritter:SetDirty()
				arg_846_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011202", "story_v_out_123011.awb") ~= 0 then
					local var_849_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011202", "story_v_out_123011.awb") / 1000

					if var_849_5 + 0 > arg_846_1.duration_ then
						arg_846_1.duration_ = var_849_5 + 0
					end

					if var_849_1.prefab_name ~= "" and arg_846_1.actors_[var_849_1.prefab_name] ~= nil then
						local var_849_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_846_1.actors_[var_849_1.prefab_name].transform, "story_v_out_123011", "123011202", "story_v_out_123011.awb")

						arg_846_1:RecordAudio("123011202", var_849_6)
						arg_846_1:RecordAudio("123011202", var_849_6)
					else
						arg_846_1:AudioAction("play", "voice", "story_v_out_123011", "123011202", "story_v_out_123011.awb")
					end

					arg_846_1:RecordHistoryTalkVoice("story_v_out_123011", "123011202", "story_v_out_123011.awb")
				end

				arg_846_1:RecordContent(arg_846_1.text_.text)
			end

			local var_849_7 = math.max(var_849_0, arg_846_1.talkMaxDuration)

			if 0 <= arg_846_1.time_ and arg_846_1.time_ < 0 + var_849_7 then
				arg_846_1.typewritter.percent = (arg_846_1.time_ - 0) / var_849_7

				arg_846_1.typewritter:SetDirty()
			end

			if arg_846_1.time_ >= 0 + var_849_7 and arg_846_1.time_ < 0 + var_849_7 + arg_849_0 then
				arg_846_1.typewritter.percent = 1

				arg_846_1.typewritter:SetDirty()
				arg_846_1:ShowNextGo(true)
			end
		end

		arg_846_1.nodeConfigList_ = {}

		arg_846_1:InitPlayNodeList()
	end,
	Play123011203 = function(arg_850_0, arg_850_1)
		arg_850_1.time_ = 0
		arg_850_1.frameCnt_ = 0
		arg_850_1.state_ = "playing"
		arg_850_1.curTalkId_ = 123011203
		arg_850_1.duration_ = 4.27

		local var_850_0 = {
			zh = 3.1,
			ja = 4.266
		}
		local var_850_1 = manager.audio:GetLocalizationFlag()

		if var_850_0[var_850_1] ~= nil then
			arg_850_1.duration_ = var_850_0[var_850_1]
		end

		SetActive(arg_850_1.tipsGo_, false)

		function arg_850_1.onSingleLineFinish_()
			arg_850_1.onSingleLineUpdate_ = nil
			arg_850_1.onSingleLineFinish_ = nil
			arg_850_1.state_ = "waiting"
		end

		function arg_850_1.playNext_(arg_852_0)
			if arg_852_0 == 1 then
				arg_850_0:Play123011204(arg_850_1)
			end
		end

		function arg_850_1.onSingleLineUpdate_(arg_853_0)
			local var_853_0 = 0.475

			if 0 < arg_850_1.time_ and arg_850_1.time_ <= 0 + arg_853_0 then
				arg_850_1.talkMaxDuration = 0
				arg_850_1.dialogCg_.alpha = 1

				arg_850_1.dialog_:SetActive(true)
				SetActive(arg_850_1.leftNameGo_, true)

				arg_850_1.leftNameTxt_.text = arg_850_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_850_1.leftNameTxt_.transform)

				arg_850_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_850_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_850_1:RecordName(arg_850_1.leftNameTxt_.text)
				SetActive(arg_850_1.iconTrs_.gameObject, true)
				arg_850_1.iconController_:SetSelectedState("hero")

				arg_850_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")

				arg_850_1.callingController_:SetSelectedState("normal")

				arg_850_1.keyicon_.color = Color.New(1, 1, 1)
				arg_850_1.icon_.color = Color.New(1, 1, 1)

				local var_853_1 = arg_850_1:GetWordFromCfg(123011203)
				local var_853_2 = arg_850_1:FormatText(var_853_1.content)

				arg_850_1.text_.text = var_853_2

				LuaForUtil.ClearLinePrefixSymbol(arg_850_1.text_)

				local var_853_4 = 19 <= 0 and var_853_0 or var_853_0 * (utf8.len(var_853_2) / 19)

				if (19 <= 0 and var_853_0 or var_853_0 * (utf8.len(var_853_2) / 19)) > 0 and var_853_0 < var_853_4 then
					arg_850_1.talkMaxDuration = var_853_4

					if var_853_4 + 0 > arg_850_1.duration_ then
						arg_850_1.duration_ = var_853_4 + 0
					end
				end

				arg_850_1.text_.text = var_853_2
				arg_850_1.typewritter.percent = 0

				arg_850_1.typewritter:SetDirty()
				arg_850_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011203", "story_v_out_123011.awb") ~= 0 then
					local var_853_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011203", "story_v_out_123011.awb") / 1000

					if var_853_5 + 0 > arg_850_1.duration_ then
						arg_850_1.duration_ = var_853_5 + 0
					end

					if var_853_1.prefab_name ~= "" and arg_850_1.actors_[var_853_1.prefab_name] ~= nil then
						local var_853_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_850_1.actors_[var_853_1.prefab_name].transform, "story_v_out_123011", "123011203", "story_v_out_123011.awb")

						arg_850_1:RecordAudio("123011203", var_853_6)
						arg_850_1:RecordAudio("123011203", var_853_6)
					else
						arg_850_1:AudioAction("play", "voice", "story_v_out_123011", "123011203", "story_v_out_123011.awb")
					end

					arg_850_1:RecordHistoryTalkVoice("story_v_out_123011", "123011203", "story_v_out_123011.awb")
				end

				arg_850_1:RecordContent(arg_850_1.text_.text)
			end

			local var_853_7 = math.max(var_853_0, arg_850_1.talkMaxDuration)

			if 0 <= arg_850_1.time_ and arg_850_1.time_ < 0 + var_853_7 then
				arg_850_1.typewritter.percent = (arg_850_1.time_ - 0) / var_853_7

				arg_850_1.typewritter:SetDirty()
			end

			if arg_850_1.time_ >= 0 + var_853_7 and arg_850_1.time_ < 0 + var_853_7 + arg_853_0 then
				arg_850_1.typewritter.percent = 1

				arg_850_1.typewritter:SetDirty()
				arg_850_1:ShowNextGo(true)
			end
		end

		arg_850_1.nodeConfigList_ = {}

		arg_850_1:InitPlayNodeList()
	end,
	Play123011204 = function(arg_854_0, arg_854_1)
		arg_854_1.time_ = 0
		arg_854_1.frameCnt_ = 0
		arg_854_1.state_ = "playing"
		arg_854_1.curTalkId_ = 123011204
		arg_854_1.duration_ = 9

		SetActive(arg_854_1.tipsGo_, false)

		function arg_854_1.onSingleLineFinish_()
			arg_854_1.onSingleLineUpdate_ = nil
			arg_854_1.onSingleLineFinish_ = nil
			arg_854_1.state_ = "waiting"
		end

		function arg_854_1.playNext_(arg_856_0)
			if arg_856_0 == 1 then
				arg_854_0:Play123011205(arg_854_1)
			end
		end

		function arg_854_1.onSingleLineUpdate_(arg_857_0)
			if arg_854_1.bgs_.B13 == nil then
				local var_857_0 = Object.Instantiate(arg_854_1.paintGo_)

				var_857_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_857_0.name = "B13"
				var_857_0.transform.parent = arg_854_1.stage_.transform
				var_857_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_854_1.bgs_.B13 = var_857_0
			end

			if 2 < arg_854_1.time_ and arg_854_1.time_ <= 2 + arg_857_0 then
				local var_857_1 = arg_854_1.bgs_.B13

				arg_854_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_857_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_857_2 = var_857_1:GetComponent("SpriteRenderer")

				if var_857_2 and var_857_2.sprite then
					local var_857_3 = 2 * (var_857_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_857_1.transform.localScale = Vector3.New(var_857_3 / var_857_2.sprite.bounds.size.y < var_857_3 * manager.ui.mainCameraCom_.aspect / var_857_2.sprite.bounds.size.x and var_857_3 * manager.ui.mainCameraCom_.aspect / var_857_2.sprite.bounds.size.x or var_857_3 / var_857_2.sprite.bounds.size.y, var_857_3 / var_857_2.sprite.bounds.size.y < var_857_3 * manager.ui.mainCameraCom_.aspect / var_857_2.sprite.bounds.size.x and var_857_3 * manager.ui.mainCameraCom_.aspect / var_857_2.sprite.bounds.size.x or var_857_3 / var_857_2.sprite.bounds.size.y, 0)
				end

				for iter_857_0, iter_857_1 in pairs(arg_854_1.bgs_) do
					if iter_857_0 ~= "B13" then
						iter_857_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_857_4 = 0

			if 0 < arg_854_1.time_ and arg_854_1.time_ <= var_857_4 + arg_857_0 then
				arg_854_1.mask_.enabled = true
				arg_854_1.mask_.raycastTarget = true

				arg_854_1:SetGaussion(false)
			end

			local var_857_5 = 2

			if var_857_4 <= arg_854_1.time_ and arg_854_1.time_ < var_857_4 + var_857_5 then
				local var_857_6 = Color.New(0, 0, 0)

				var_857_6.a = Mathf.Lerp(0, 1, (arg_854_1.time_ - var_857_4) / var_857_5)
				arg_854_1.mask_.color = var_857_6
			end

			if arg_854_1.time_ >= var_857_4 + var_857_5 and arg_854_1.time_ < var_857_4 + var_857_5 + arg_857_0 then
				local var_857_7 = Color.New(0, 0, 0)

				var_857_7.a = 1
				arg_854_1.mask_.color = var_857_7
			end

			local var_857_8 = 2

			if 2 < arg_854_1.time_ and arg_854_1.time_ <= var_857_8 + arg_857_0 then
				arg_854_1.mask_.enabled = true
				arg_854_1.mask_.raycastTarget = true

				arg_854_1:SetGaussion(false)
			end

			local var_857_9 = 2

			if var_857_8 <= arg_854_1.time_ and arg_854_1.time_ < var_857_8 + var_857_9 then
				local var_857_10 = Color.New(0, 0, 0)

				var_857_10.a = Mathf.Lerp(1, 0, (arg_854_1.time_ - var_857_8) / var_857_9)
				arg_854_1.mask_.color = var_857_10
			end

			if arg_854_1.time_ >= var_857_8 + var_857_9 and arg_854_1.time_ < var_857_8 + var_857_9 + arg_857_0 then
				local var_857_11 = Color.New(0, 0, 0)

				arg_854_1.mask_.enabled = false
				var_857_11.a = 0
				arg_854_1.mask_.color = var_857_11
			end

			if arg_854_1.frameCnt_ <= 1 then
				arg_854_1.dialog_:SetActive(false)
			end

			local var_857_12 = 4
			local var_857_13 = 0.575

			if 4 < arg_854_1.time_ and arg_854_1.time_ <= var_857_12 + arg_857_0 then
				arg_854_1.talkMaxDuration = 0

				arg_854_1.dialog_:SetActive(true)

				arg_854_1.dialogCg_.alpha = 0

				local var_857_14 = LeanTween.value(arg_854_1.dialog_, 0, 1, 0.3)

				var_857_14:setOnUpdate(LuaHelper.FloatAction(function(arg_858_0)
					arg_854_1.dialogCg_.alpha = arg_858_0
				end))
				var_857_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_854_1.dialog_)
					var_857_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_854_1.duration_ = arg_854_1.duration_ + 0.3

				SetActive(arg_854_1.leftNameGo_, false)

				arg_854_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_854_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_854_1:RecordName(arg_854_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_854_1.iconTrs_.gameObject, false)
				arg_854_1.callingController_:SetSelectedState("normal")

				local var_857_15 = arg_854_1:FormatText(arg_854_1:GetWordFromCfg(123011204).content)

				arg_854_1.text_.text = var_857_15

				LuaForUtil.ClearLinePrefixSymbol(arg_854_1.text_)

				local var_857_17 = 23 <= 0 and var_857_13 or var_857_13 * (utf8.len(var_857_15) / 23)

				if (23 <= 0 and var_857_13 or var_857_13 * (utf8.len(var_857_15) / 23)) > 0 and var_857_13 < var_857_17 then
					arg_854_1.talkMaxDuration = var_857_17
					var_857_12 = var_857_12 + 0.3

					if var_857_17 + var_857_12 > arg_854_1.duration_ then
						arg_854_1.duration_ = var_857_17 + var_857_12
					end
				end

				arg_854_1.text_.text = var_857_15
				arg_854_1.typewritter.percent = 0

				arg_854_1.typewritter:SetDirty()
				arg_854_1:ShowNextGo(false)
				arg_854_1:RecordContent(arg_854_1.text_.text)
			end

			local var_857_18 = var_857_12 + 0.3
			local var_857_19 = math.max(var_857_13, arg_854_1.talkMaxDuration)

			if var_857_12 + 0.3 <= arg_854_1.time_ and arg_854_1.time_ < var_857_18 + var_857_19 then
				arg_854_1.typewritter.percent = (arg_854_1.time_ - var_857_18) / var_857_19

				arg_854_1.typewritter:SetDirty()
			end

			if arg_854_1.time_ >= var_857_18 + var_857_19 and arg_854_1.time_ < var_857_18 + var_857_19 + arg_857_0 then
				arg_854_1.typewritter.percent = 1

				arg_854_1.typewritter:SetDirty()
				arg_854_1:ShowNextGo(true)
			end
		end

		arg_854_1.nodeConfigList_ = {}

		arg_854_1:InitPlayNodeList()
	end,
	Play123011205 = function(arg_860_0, arg_860_1)
		arg_860_1.time_ = 0
		arg_860_1.frameCnt_ = 0
		arg_860_1.state_ = "playing"
		arg_860_1.curTalkId_ = 123011205
		arg_860_1.duration_ = 7.97

		local var_860_0 = {
			zh = 5.066,
			ja = 7.966
		}
		local var_860_1 = manager.audio:GetLocalizationFlag()

		if var_860_0[var_860_1] ~= nil then
			arg_860_1.duration_ = var_860_0[var_860_1]
		end

		SetActive(arg_860_1.tipsGo_, false)

		function arg_860_1.onSingleLineFinish_()
			arg_860_1.onSingleLineUpdate_ = nil
			arg_860_1.onSingleLineFinish_ = nil
			arg_860_1.state_ = "waiting"
		end

		function arg_860_1.playNext_(arg_862_0)
			if arg_862_0 == 1 then
				arg_860_0:Play123011206(arg_860_1)
			end
		end

		function arg_860_1.onSingleLineUpdate_(arg_863_0)
			if 0 < arg_860_1.time_ and arg_860_1.time_ <= 0 + arg_863_0 then
				arg_860_1.var_.moveOldPos1019ui_story = arg_860_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_863_0 = 0.001

			if 0 <= arg_860_1.time_ and arg_860_1.time_ < 0 + var_863_0 then
				arg_860_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_860_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_860_1.time_ - 0) / var_863_0)
				arg_860_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_860_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_860_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_860_1.actors_["1019ui_story"].transform.position).z)
				arg_860_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_860_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_860_1.actors_["1019ui_story"].transform.localEulerAngles = arg_860_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_860_1.time_ >= 0 + var_863_0 and arg_860_1.time_ < 0 + var_863_0 + arg_863_0 then
				arg_860_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_860_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_860_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_860_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_860_1.actors_["1019ui_story"].transform.position).z)
				arg_860_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_860_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_860_1.actors_["1019ui_story"].transform.localEulerAngles = arg_860_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_863_1 = arg_860_1.actors_["1019ui_story"]

			if 0 < arg_860_1.time_ and arg_860_1.time_ <= 0 + arg_863_0 and not isNil(var_863_1) and arg_860_1.var_.characterEffect1019ui_story == nil then
				arg_860_1.var_.characterEffect1019ui_story = var_863_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_863_2 = 0.200000002980232

			if 0 <= arg_860_1.time_ and arg_860_1.time_ < 0 + var_863_2 and not isNil(var_863_1) then
				if arg_860_1.var_.characterEffect1019ui_story and not isNil(var_863_1) then
					arg_860_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_860_1.time_ >= 0 + var_863_2 and arg_860_1.time_ < 0 + var_863_2 + arg_863_0 and not isNil(var_863_1) and arg_860_1.var_.characterEffect1019ui_story then
				arg_860_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_860_1.time_ and arg_860_1.time_ <= 0 + arg_863_0 then
				arg_860_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_860_1.time_ and arg_860_1.time_ <= 0 + arg_863_0 then
				arg_860_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_863_4 = 0
			local var_863_5 = 0.6

			if 0 < arg_860_1.time_ and arg_860_1.time_ <= var_863_4 + arg_863_0 then
				arg_860_1.talkMaxDuration = 0
				arg_860_1.dialogCg_.alpha = 1

				arg_860_1.dialog_:SetActive(true)
				SetActive(arg_860_1.leftNameGo_, true)

				arg_860_1.leftNameTxt_.text = arg_860_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_860_1.leftNameTxt_.transform)

				arg_860_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_860_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_860_1:RecordName(arg_860_1.leftNameTxt_.text)
				SetActive(arg_860_1.iconTrs_.gameObject, false)
				arg_860_1.callingController_:SetSelectedState("normal")

				local var_863_6 = arg_860_1:GetWordFromCfg(123011205)
				local var_863_7 = arg_860_1:FormatText(var_863_6.content)

				arg_860_1.text_.text = var_863_7

				LuaForUtil.ClearLinePrefixSymbol(arg_860_1.text_)

				local var_863_9 = 24 <= 0 and var_863_5 or var_863_5 * (utf8.len(var_863_7) / 24)

				if (24 <= 0 and var_863_5 or var_863_5 * (utf8.len(var_863_7) / 24)) > 0 and var_863_5 < var_863_9 then
					arg_860_1.talkMaxDuration = var_863_9

					if var_863_9 + var_863_4 > arg_860_1.duration_ then
						arg_860_1.duration_ = var_863_9 + var_863_4
					end
				end

				arg_860_1.text_.text = var_863_7
				arg_860_1.typewritter.percent = 0

				arg_860_1.typewritter:SetDirty()
				arg_860_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011205", "story_v_out_123011.awb") ~= 0 then
					local var_863_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011205", "story_v_out_123011.awb") / 1000

					if var_863_10 + var_863_4 > arg_860_1.duration_ then
						arg_860_1.duration_ = var_863_10 + var_863_4
					end

					if var_863_6.prefab_name ~= "" and arg_860_1.actors_[var_863_6.prefab_name] ~= nil then
						local var_863_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_860_1.actors_[var_863_6.prefab_name].transform, "story_v_out_123011", "123011205", "story_v_out_123011.awb")

						arg_860_1:RecordAudio("123011205", var_863_11)
						arg_860_1:RecordAudio("123011205", var_863_11)
					else
						arg_860_1:AudioAction("play", "voice", "story_v_out_123011", "123011205", "story_v_out_123011.awb")
					end

					arg_860_1:RecordHistoryTalkVoice("story_v_out_123011", "123011205", "story_v_out_123011.awb")
				end

				arg_860_1:RecordContent(arg_860_1.text_.text)
			end

			local var_863_12 = math.max(var_863_5, arg_860_1.talkMaxDuration)

			if var_863_4 <= arg_860_1.time_ and arg_860_1.time_ < var_863_4 + var_863_12 then
				arg_860_1.typewritter.percent = (arg_860_1.time_ - var_863_4) / var_863_12

				arg_860_1.typewritter:SetDirty()
			end

			if arg_860_1.time_ >= var_863_4 + var_863_12 and arg_860_1.time_ < var_863_4 + var_863_12 + arg_863_0 then
				arg_860_1.typewritter.percent = 1

				arg_860_1.typewritter:SetDirty()
				arg_860_1:ShowNextGo(true)
			end
		end

		arg_860_1.nodeConfigList_ = {
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

		arg_860_1:InitPlayNodeList()
	end,
	Play123011206 = function(arg_864_0, arg_864_1)
		arg_864_1.time_ = 0
		arg_864_1.frameCnt_ = 0
		arg_864_1.state_ = "playing"
		arg_864_1.curTalkId_ = 123011206
		arg_864_1.duration_ = 5

		SetActive(arg_864_1.tipsGo_, false)

		function arg_864_1.onSingleLineFinish_()
			arg_864_1.onSingleLineUpdate_ = nil
			arg_864_1.onSingleLineFinish_ = nil
			arg_864_1.state_ = "waiting"
		end

		function arg_864_1.playNext_(arg_866_0)
			if arg_866_0 == 1 then
				arg_864_0:Play123011207(arg_864_1)
			end
		end

		function arg_864_1.onSingleLineUpdate_(arg_867_0)
			if 0 < arg_864_1.time_ and arg_864_1.time_ <= 0 + arg_867_0 and not isNil(arg_864_1.actors_["1019ui_story"]) and arg_864_1.var_.characterEffect1019ui_story == nil then
				arg_864_1.var_.characterEffect1019ui_story = arg_864_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_867_0 = 0.200000002980232

			if 0 <= arg_864_1.time_ and arg_864_1.time_ < 0 + var_867_0 and not isNil(arg_864_1.actors_["1019ui_story"]) then
				if arg_864_1.var_.characterEffect1019ui_story and not isNil(arg_864_1.actors_["1019ui_story"]) then
					arg_864_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_864_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_864_1.time_ - 0) / var_867_0)
				end
			end

			if arg_864_1.time_ >= 0 + var_867_0 and arg_864_1.time_ < 0 + var_867_0 + arg_867_0 and not isNil(arg_864_1.actors_["1019ui_story"]) and arg_864_1.var_.characterEffect1019ui_story then
				arg_864_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_864_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_867_1 = 0
			local var_867_2 = 0.45

			if 0 < arg_864_1.time_ and arg_864_1.time_ <= var_867_1 + arg_867_0 then
				arg_864_1.talkMaxDuration = 0
				arg_864_1.dialogCg_.alpha = 1

				arg_864_1.dialog_:SetActive(true)
				SetActive(arg_864_1.leftNameGo_, true)

				arg_864_1.leftNameTxt_.text = arg_864_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_864_1.leftNameTxt_.transform)

				arg_864_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_864_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_864_1:RecordName(arg_864_1.leftNameTxt_.text)
				SetActive(arg_864_1.iconTrs_.gameObject, true)
				arg_864_1.iconController_:SetSelectedState("hero")

				arg_864_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_864_1.callingController_:SetSelectedState("normal")

				arg_864_1.keyicon_.color = Color.New(1, 1, 1)
				arg_864_1.icon_.color = Color.New(1, 1, 1)

				local var_867_3 = arg_864_1:FormatText(arg_864_1:GetWordFromCfg(123011206).content)

				arg_864_1.text_.text = var_867_3

				LuaForUtil.ClearLinePrefixSymbol(arg_864_1.text_)

				local var_867_5 = 18 <= 0 and var_867_2 or var_867_2 * (utf8.len(var_867_3) / 18)

				if (18 <= 0 and var_867_2 or var_867_2 * (utf8.len(var_867_3) / 18)) > 0 and var_867_2 < var_867_5 then
					arg_864_1.talkMaxDuration = var_867_5

					if var_867_5 + var_867_1 > arg_864_1.duration_ then
						arg_864_1.duration_ = var_867_5 + var_867_1
					end
				end

				arg_864_1.text_.text = var_867_3
				arg_864_1.typewritter.percent = 0

				arg_864_1.typewritter:SetDirty()
				arg_864_1:ShowNextGo(false)
				arg_864_1:RecordContent(arg_864_1.text_.text)
			end

			local var_867_6 = math.max(var_867_2, arg_864_1.talkMaxDuration)

			if var_867_1 <= arg_864_1.time_ and arg_864_1.time_ < var_867_1 + var_867_6 then
				arg_864_1.typewritter.percent = (arg_864_1.time_ - var_867_1) / var_867_6

				arg_864_1.typewritter:SetDirty()
			end

			if arg_864_1.time_ >= var_867_1 + var_867_6 and arg_864_1.time_ < var_867_1 + var_867_6 + arg_867_0 then
				arg_864_1.typewritter.percent = 1

				arg_864_1.typewritter:SetDirty()
				arg_864_1:ShowNextGo(true)
			end
		end

		arg_864_1.nodeConfigList_ = {}

		arg_864_1:InitPlayNodeList()
	end,
	Play123011207 = function(arg_868_0, arg_868_1)
		arg_868_1.time_ = 0
		arg_868_1.frameCnt_ = 0
		arg_868_1.state_ = "playing"
		arg_868_1.curTalkId_ = 123011207
		arg_868_1.duration_ = 11.6

		local var_868_0 = {
			zh = 8.1,
			ja = 11.6
		}
		local var_868_1 = manager.audio:GetLocalizationFlag()

		if var_868_0[var_868_1] ~= nil then
			arg_868_1.duration_ = var_868_0[var_868_1]
		end

		SetActive(arg_868_1.tipsGo_, false)

		function arg_868_1.onSingleLineFinish_()
			arg_868_1.onSingleLineUpdate_ = nil
			arg_868_1.onSingleLineFinish_ = nil
			arg_868_1.state_ = "waiting"
		end

		function arg_868_1.playNext_(arg_870_0)
			if arg_870_0 == 1 then
				arg_868_0:Play123011208(arg_868_1)
			end
		end

		function arg_868_1.onSingleLineUpdate_(arg_871_0)
			if 0 < arg_868_1.time_ and arg_868_1.time_ <= 0 + arg_871_0 and not isNil(arg_868_1.actors_["1019ui_story"]) and arg_868_1.var_.characterEffect1019ui_story == nil then
				arg_868_1.var_.characterEffect1019ui_story = arg_868_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_871_0 = 0.200000002980232

			if 0 <= arg_868_1.time_ and arg_868_1.time_ < 0 + var_871_0 and not isNil(arg_868_1.actors_["1019ui_story"]) then
				if arg_868_1.var_.characterEffect1019ui_story and not isNil(arg_868_1.actors_["1019ui_story"]) then
					arg_868_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_868_1.time_ >= 0 + var_871_0 and arg_868_1.time_ < 0 + var_871_0 + arg_871_0 and not isNil(arg_868_1.actors_["1019ui_story"]) and arg_868_1.var_.characterEffect1019ui_story then
				arg_868_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_868_1.time_ and arg_868_1.time_ <= 0 + arg_871_0 then
				arg_868_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_868_1.time_ and arg_868_1.time_ <= 0 + arg_871_0 then
				arg_868_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_871_2 = 0
			local var_871_3 = 1.025

			if 0 < arg_868_1.time_ and arg_868_1.time_ <= var_871_2 + arg_871_0 then
				arg_868_1.talkMaxDuration = 0
				arg_868_1.dialogCg_.alpha = 1

				arg_868_1.dialog_:SetActive(true)
				SetActive(arg_868_1.leftNameGo_, true)

				arg_868_1.leftNameTxt_.text = arg_868_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_868_1.leftNameTxt_.transform)

				arg_868_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_868_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_868_1:RecordName(arg_868_1.leftNameTxt_.text)
				SetActive(arg_868_1.iconTrs_.gameObject, false)
				arg_868_1.callingController_:SetSelectedState("normal")

				local var_871_4 = arg_868_1:GetWordFromCfg(123011207)
				local var_871_5 = arg_868_1:FormatText(var_871_4.content)

				arg_868_1.text_.text = var_871_5

				LuaForUtil.ClearLinePrefixSymbol(arg_868_1.text_)

				local var_871_7 = 41 <= 0 and var_871_3 or var_871_3 * (utf8.len(var_871_5) / 41)

				if (41 <= 0 and var_871_3 or var_871_3 * (utf8.len(var_871_5) / 41)) > 0 and var_871_3 < var_871_7 then
					arg_868_1.talkMaxDuration = var_871_7

					if var_871_7 + var_871_2 > arg_868_1.duration_ then
						arg_868_1.duration_ = var_871_7 + var_871_2
					end
				end

				arg_868_1.text_.text = var_871_5
				arg_868_1.typewritter.percent = 0

				arg_868_1.typewritter:SetDirty()
				arg_868_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011207", "story_v_out_123011.awb") ~= 0 then
					local var_871_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011207", "story_v_out_123011.awb") / 1000

					if var_871_8 + var_871_2 > arg_868_1.duration_ then
						arg_868_1.duration_ = var_871_8 + var_871_2
					end

					if var_871_4.prefab_name ~= "" and arg_868_1.actors_[var_871_4.prefab_name] ~= nil then
						local var_871_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_868_1.actors_[var_871_4.prefab_name].transform, "story_v_out_123011", "123011207", "story_v_out_123011.awb")

						arg_868_1:RecordAudio("123011207", var_871_9)
						arg_868_1:RecordAudio("123011207", var_871_9)
					else
						arg_868_1:AudioAction("play", "voice", "story_v_out_123011", "123011207", "story_v_out_123011.awb")
					end

					arg_868_1:RecordHistoryTalkVoice("story_v_out_123011", "123011207", "story_v_out_123011.awb")
				end

				arg_868_1:RecordContent(arg_868_1.text_.text)
			end

			local var_871_10 = math.max(var_871_3, arg_868_1.talkMaxDuration)

			if var_871_2 <= arg_868_1.time_ and arg_868_1.time_ < var_871_2 + var_871_10 then
				arg_868_1.typewritter.percent = (arg_868_1.time_ - var_871_2) / var_871_10

				arg_868_1.typewritter:SetDirty()
			end

			if arg_868_1.time_ >= var_871_2 + var_871_10 and arg_868_1.time_ < var_871_2 + var_871_10 + arg_871_0 then
				arg_868_1.typewritter.percent = 1

				arg_868_1.typewritter:SetDirty()
				arg_868_1:ShowNextGo(true)
			end
		end

		arg_868_1.nodeConfigList_ = {}

		arg_868_1:InitPlayNodeList()
	end,
	Play123011208 = function(arg_872_0, arg_872_1)
		arg_872_1.time_ = 0
		arg_872_1.frameCnt_ = 0
		arg_872_1.state_ = "playing"
		arg_872_1.curTalkId_ = 123011208
		arg_872_1.duration_ = 11.47

		local var_872_0 = {
			zh = 7.6,
			ja = 11.466
		}
		local var_872_1 = manager.audio:GetLocalizationFlag()

		if var_872_0[var_872_1] ~= nil then
			arg_872_1.duration_ = var_872_0[var_872_1]
		end

		SetActive(arg_872_1.tipsGo_, false)

		function arg_872_1.onSingleLineFinish_()
			arg_872_1.onSingleLineUpdate_ = nil
			arg_872_1.onSingleLineFinish_ = nil
			arg_872_1.state_ = "waiting"
		end

		function arg_872_1.playNext_(arg_874_0)
			if arg_874_0 == 1 then
				arg_872_0:Play123011209(arg_872_1)
			end
		end

		function arg_872_1.onSingleLineUpdate_(arg_875_0)
			local var_875_0 = 0.95

			if 0 < arg_872_1.time_ and arg_872_1.time_ <= 0 + arg_875_0 then
				arg_872_1.talkMaxDuration = 0
				arg_872_1.dialogCg_.alpha = 1

				arg_872_1.dialog_:SetActive(true)
				SetActive(arg_872_1.leftNameGo_, true)

				arg_872_1.leftNameTxt_.text = arg_872_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_872_1.leftNameTxt_.transform)

				arg_872_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_872_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_872_1:RecordName(arg_872_1.leftNameTxt_.text)
				SetActive(arg_872_1.iconTrs_.gameObject, false)
				arg_872_1.callingController_:SetSelectedState("normal")

				local var_875_1 = arg_872_1:GetWordFromCfg(123011208)
				local var_875_2 = arg_872_1:FormatText(var_875_1.content)

				arg_872_1.text_.text = var_875_2

				LuaForUtil.ClearLinePrefixSymbol(arg_872_1.text_)

				local var_875_4 = 38 <= 0 and var_875_0 or var_875_0 * (utf8.len(var_875_2) / 38)

				if (38 <= 0 and var_875_0 or var_875_0 * (utf8.len(var_875_2) / 38)) > 0 and var_875_0 < var_875_4 then
					arg_872_1.talkMaxDuration = var_875_4

					if var_875_4 + 0 > arg_872_1.duration_ then
						arg_872_1.duration_ = var_875_4 + 0
					end
				end

				arg_872_1.text_.text = var_875_2
				arg_872_1.typewritter.percent = 0

				arg_872_1.typewritter:SetDirty()
				arg_872_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011208", "story_v_out_123011.awb") ~= 0 then
					local var_875_5 = manager.audio:GetVoiceLength("story_v_out_123011", "123011208", "story_v_out_123011.awb") / 1000

					if var_875_5 + 0 > arg_872_1.duration_ then
						arg_872_1.duration_ = var_875_5 + 0
					end

					if var_875_1.prefab_name ~= "" and arg_872_1.actors_[var_875_1.prefab_name] ~= nil then
						local var_875_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_872_1.actors_[var_875_1.prefab_name].transform, "story_v_out_123011", "123011208", "story_v_out_123011.awb")

						arg_872_1:RecordAudio("123011208", var_875_6)
						arg_872_1:RecordAudio("123011208", var_875_6)
					else
						arg_872_1:AudioAction("play", "voice", "story_v_out_123011", "123011208", "story_v_out_123011.awb")
					end

					arg_872_1:RecordHistoryTalkVoice("story_v_out_123011", "123011208", "story_v_out_123011.awb")
				end

				arg_872_1:RecordContent(arg_872_1.text_.text)
			end

			local var_875_7 = math.max(var_875_0, arg_872_1.talkMaxDuration)

			if 0 <= arg_872_1.time_ and arg_872_1.time_ < 0 + var_875_7 then
				arg_872_1.typewritter.percent = (arg_872_1.time_ - 0) / var_875_7

				arg_872_1.typewritter:SetDirty()
			end

			if arg_872_1.time_ >= 0 + var_875_7 and arg_872_1.time_ < 0 + var_875_7 + arg_875_0 then
				arg_872_1.typewritter.percent = 1

				arg_872_1.typewritter:SetDirty()
				arg_872_1:ShowNextGo(true)
			end
		end

		arg_872_1.nodeConfigList_ = {}

		arg_872_1:InitPlayNodeList()
	end,
	Play123011209 = function(arg_876_0, arg_876_1)
		arg_876_1.time_ = 0
		arg_876_1.frameCnt_ = 0
		arg_876_1.state_ = "playing"
		arg_876_1.curTalkId_ = 123011209
		arg_876_1.duration_ = 5

		SetActive(arg_876_1.tipsGo_, false)

		function arg_876_1.onSingleLineFinish_()
			arg_876_1.onSingleLineUpdate_ = nil
			arg_876_1.onSingleLineFinish_ = nil
			arg_876_1.state_ = "waiting"
		end

		function arg_876_1.playNext_(arg_878_0)
			if arg_878_0 == 1 then
				arg_876_0:Play123011210(arg_876_1)
			end
		end

		function arg_876_1.onSingleLineUpdate_(arg_879_0)
			if 0 < arg_876_1.time_ and arg_876_1.time_ <= 0 + arg_879_0 and not isNil(arg_876_1.actors_["1019ui_story"]) and arg_876_1.var_.characterEffect1019ui_story == nil then
				arg_876_1.var_.characterEffect1019ui_story = arg_876_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_879_0 = 0.200000002980232

			if 0 <= arg_876_1.time_ and arg_876_1.time_ < 0 + var_879_0 and not isNil(arg_876_1.actors_["1019ui_story"]) then
				if arg_876_1.var_.characterEffect1019ui_story and not isNil(arg_876_1.actors_["1019ui_story"]) then
					arg_876_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_876_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_876_1.time_ - 0) / var_879_0)
				end
			end

			if arg_876_1.time_ >= 0 + var_879_0 and arg_876_1.time_ < 0 + var_879_0 + arg_879_0 and not isNil(arg_876_1.actors_["1019ui_story"]) and arg_876_1.var_.characterEffect1019ui_story then
				arg_876_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_876_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_879_1 = 0
			local var_879_2 = 1.525

			if 0 < arg_876_1.time_ and arg_876_1.time_ <= var_879_1 + arg_879_0 then
				arg_876_1.talkMaxDuration = 0
				arg_876_1.dialogCg_.alpha = 1

				arg_876_1.dialog_:SetActive(true)
				SetActive(arg_876_1.leftNameGo_, true)

				arg_876_1.leftNameTxt_.text = arg_876_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_876_1.leftNameTxt_.transform)

				arg_876_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_876_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_876_1:RecordName(arg_876_1.leftNameTxt_.text)
				SetActive(arg_876_1.iconTrs_.gameObject, true)
				arg_876_1.iconController_:SetSelectedState("hero")

				arg_876_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_876_1.callingController_:SetSelectedState("normal")

				arg_876_1.keyicon_.color = Color.New(1, 1, 1)
				arg_876_1.icon_.color = Color.New(1, 1, 1)

				local var_879_3 = arg_876_1:FormatText(arg_876_1:GetWordFromCfg(123011209).content)

				arg_876_1.text_.text = var_879_3

				LuaForUtil.ClearLinePrefixSymbol(arg_876_1.text_)

				local var_879_5 = 61 <= 0 and var_879_2 or var_879_2 * (utf8.len(var_879_3) / 61)

				if (61 <= 0 and var_879_2 or var_879_2 * (utf8.len(var_879_3) / 61)) > 0 and var_879_2 < var_879_5 then
					arg_876_1.talkMaxDuration = var_879_5

					if var_879_5 + var_879_1 > arg_876_1.duration_ then
						arg_876_1.duration_ = var_879_5 + var_879_1
					end
				end

				arg_876_1.text_.text = var_879_3
				arg_876_1.typewritter.percent = 0

				arg_876_1.typewritter:SetDirty()
				arg_876_1:ShowNextGo(false)
				arg_876_1:RecordContent(arg_876_1.text_.text)
			end

			local var_879_6 = math.max(var_879_2, arg_876_1.talkMaxDuration)

			if var_879_1 <= arg_876_1.time_ and arg_876_1.time_ < var_879_1 + var_879_6 then
				arg_876_1.typewritter.percent = (arg_876_1.time_ - var_879_1) / var_879_6

				arg_876_1.typewritter:SetDirty()
			end

			if arg_876_1.time_ >= var_879_1 + var_879_6 and arg_876_1.time_ < var_879_1 + var_879_6 + arg_879_0 then
				arg_876_1.typewritter.percent = 1

				arg_876_1.typewritter:SetDirty()
				arg_876_1:ShowNextGo(true)
			end
		end

		arg_876_1.nodeConfigList_ = {}

		arg_876_1:InitPlayNodeList()
	end,
	Play123011210 = function(arg_880_0, arg_880_1)
		arg_880_1.time_ = 0
		arg_880_1.frameCnt_ = 0
		arg_880_1.state_ = "playing"
		arg_880_1.curTalkId_ = 123011210
		arg_880_1.duration_ = 2.33

		local var_880_0 = {
			zh = 2.333,
			ja = 2.266
		}
		local var_880_1 = manager.audio:GetLocalizationFlag()

		if var_880_0[var_880_1] ~= nil then
			arg_880_1.duration_ = var_880_0[var_880_1]
		end

		SetActive(arg_880_1.tipsGo_, false)

		function arg_880_1.onSingleLineFinish_()
			arg_880_1.onSingleLineUpdate_ = nil
			arg_880_1.onSingleLineFinish_ = nil
			arg_880_1.state_ = "waiting"
		end

		function arg_880_1.playNext_(arg_882_0)
			if arg_882_0 == 1 then
				arg_880_0:Play123011211(arg_880_1)
			end
		end

		function arg_880_1.onSingleLineUpdate_(arg_883_0)
			if 0 < arg_880_1.time_ and arg_880_1.time_ <= 0 + arg_883_0 and not isNil(arg_880_1.actors_["1019ui_story"]) and arg_880_1.var_.characterEffect1019ui_story == nil then
				arg_880_1.var_.characterEffect1019ui_story = arg_880_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_883_0 = 0.200000002980232

			if 0 <= arg_880_1.time_ and arg_880_1.time_ < 0 + var_883_0 and not isNil(arg_880_1.actors_["1019ui_story"]) then
				if arg_880_1.var_.characterEffect1019ui_story and not isNil(arg_880_1.actors_["1019ui_story"]) then
					arg_880_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_880_1.time_ >= 0 + var_883_0 and arg_880_1.time_ < 0 + var_883_0 + arg_883_0 and not isNil(arg_880_1.actors_["1019ui_story"]) and arg_880_1.var_.characterEffect1019ui_story then
				arg_880_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_880_1.time_ and arg_880_1.time_ <= 0 + arg_883_0 then
				arg_880_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			if 0 < arg_880_1.time_ and arg_880_1.time_ <= 0 + arg_883_0 then
				arg_880_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_883_2 = 0
			local var_883_3 = 0.35

			if 0 < arg_880_1.time_ and arg_880_1.time_ <= var_883_2 + arg_883_0 then
				arg_880_1.talkMaxDuration = 0
				arg_880_1.dialogCg_.alpha = 1

				arg_880_1.dialog_:SetActive(true)
				SetActive(arg_880_1.leftNameGo_, true)

				arg_880_1.leftNameTxt_.text = arg_880_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_880_1.leftNameTxt_.transform)

				arg_880_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_880_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_880_1:RecordName(arg_880_1.leftNameTxt_.text)
				SetActive(arg_880_1.iconTrs_.gameObject, false)
				arg_880_1.callingController_:SetSelectedState("normal")

				local var_883_4 = arg_880_1:GetWordFromCfg(123011210)
				local var_883_5 = arg_880_1:FormatText(var_883_4.content)

				arg_880_1.text_.text = var_883_5

				LuaForUtil.ClearLinePrefixSymbol(arg_880_1.text_)

				local var_883_7 = 14 <= 0 and var_883_3 or var_883_3 * (utf8.len(var_883_5) / 14)

				if (14 <= 0 and var_883_3 or var_883_3 * (utf8.len(var_883_5) / 14)) > 0 and var_883_3 < var_883_7 then
					arg_880_1.talkMaxDuration = var_883_7

					if var_883_7 + var_883_2 > arg_880_1.duration_ then
						arg_880_1.duration_ = var_883_7 + var_883_2
					end
				end

				arg_880_1.text_.text = var_883_5
				arg_880_1.typewritter.percent = 0

				arg_880_1.typewritter:SetDirty()
				arg_880_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011210", "story_v_out_123011.awb") ~= 0 then
					local var_883_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011210", "story_v_out_123011.awb") / 1000

					if var_883_8 + var_883_2 > arg_880_1.duration_ then
						arg_880_1.duration_ = var_883_8 + var_883_2
					end

					if var_883_4.prefab_name ~= "" and arg_880_1.actors_[var_883_4.prefab_name] ~= nil then
						local var_883_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_880_1.actors_[var_883_4.prefab_name].transform, "story_v_out_123011", "123011210", "story_v_out_123011.awb")

						arg_880_1:RecordAudio("123011210", var_883_9)
						arg_880_1:RecordAudio("123011210", var_883_9)
					else
						arg_880_1:AudioAction("play", "voice", "story_v_out_123011", "123011210", "story_v_out_123011.awb")
					end

					arg_880_1:RecordHistoryTalkVoice("story_v_out_123011", "123011210", "story_v_out_123011.awb")
				end

				arg_880_1:RecordContent(arg_880_1.text_.text)
			end

			local var_883_10 = math.max(var_883_3, arg_880_1.talkMaxDuration)

			if var_883_2 <= arg_880_1.time_ and arg_880_1.time_ < var_883_2 + var_883_10 then
				arg_880_1.typewritter.percent = (arg_880_1.time_ - var_883_2) / var_883_10

				arg_880_1.typewritter:SetDirty()
			end

			if arg_880_1.time_ >= var_883_2 + var_883_10 and arg_880_1.time_ < var_883_2 + var_883_10 + arg_883_0 then
				arg_880_1.typewritter.percent = 1

				arg_880_1.typewritter:SetDirty()
				arg_880_1:ShowNextGo(true)
			end
		end

		arg_880_1.nodeConfigList_ = {}

		arg_880_1:InitPlayNodeList()
	end,
	Play123011211 = function(arg_884_0, arg_884_1)
		arg_884_1.time_ = 0
		arg_884_1.frameCnt_ = 0
		arg_884_1.state_ = "playing"
		arg_884_1.curTalkId_ = 123011211
		arg_884_1.duration_ = 5

		SetActive(arg_884_1.tipsGo_, false)

		function arg_884_1.onSingleLineFinish_()
			arg_884_1.onSingleLineUpdate_ = nil
			arg_884_1.onSingleLineFinish_ = nil
			arg_884_1.state_ = "waiting"
		end

		function arg_884_1.playNext_(arg_886_0)
			if arg_886_0 == 1 then
				arg_884_0:Play123011212(arg_884_1)
			end
		end

		function arg_884_1.onSingleLineUpdate_(arg_887_0)
			if 0 < arg_884_1.time_ and arg_884_1.time_ <= 0 + arg_887_0 and not isNil(arg_884_1.actors_["1019ui_story"]) and arg_884_1.var_.characterEffect1019ui_story == nil then
				arg_884_1.var_.characterEffect1019ui_story = arg_884_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_887_0 = 0.200000002980232

			if 0 <= arg_884_1.time_ and arg_884_1.time_ < 0 + var_887_0 and not isNil(arg_884_1.actors_["1019ui_story"]) then
				if arg_884_1.var_.characterEffect1019ui_story and not isNil(arg_884_1.actors_["1019ui_story"]) then
					arg_884_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_884_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_884_1.time_ - 0) / var_887_0)
				end
			end

			if arg_884_1.time_ >= 0 + var_887_0 and arg_884_1.time_ < 0 + var_887_0 + arg_887_0 and not isNil(arg_884_1.actors_["1019ui_story"]) and arg_884_1.var_.characterEffect1019ui_story then
				arg_884_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_884_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_887_1 = 0
			local var_887_2 = 0.525

			if 0 < arg_884_1.time_ and arg_884_1.time_ <= var_887_1 + arg_887_0 then
				arg_884_1.talkMaxDuration = 0
				arg_884_1.dialogCg_.alpha = 1

				arg_884_1.dialog_:SetActive(true)
				SetActive(arg_884_1.leftNameGo_, true)

				arg_884_1.leftNameTxt_.text = arg_884_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_884_1.leftNameTxt_.transform)

				arg_884_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_884_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_884_1:RecordName(arg_884_1.leftNameTxt_.text)
				SetActive(arg_884_1.iconTrs_.gameObject, true)
				arg_884_1.iconController_:SetSelectedState("hero")

				arg_884_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_884_1.callingController_:SetSelectedState("normal")

				arg_884_1.keyicon_.color = Color.New(1, 1, 1)
				arg_884_1.icon_.color = Color.New(1, 1, 1)

				local var_887_3 = arg_884_1:FormatText(arg_884_1:GetWordFromCfg(123011211).content)

				arg_884_1.text_.text = var_887_3

				LuaForUtil.ClearLinePrefixSymbol(arg_884_1.text_)

				local var_887_5 = 21 <= 0 and var_887_2 or var_887_2 * (utf8.len(var_887_3) / 21)

				if (21 <= 0 and var_887_2 or var_887_2 * (utf8.len(var_887_3) / 21)) > 0 and var_887_2 < var_887_5 then
					arg_884_1.talkMaxDuration = var_887_5

					if var_887_5 + var_887_1 > arg_884_1.duration_ then
						arg_884_1.duration_ = var_887_5 + var_887_1
					end
				end

				arg_884_1.text_.text = var_887_3
				arg_884_1.typewritter.percent = 0

				arg_884_1.typewritter:SetDirty()
				arg_884_1:ShowNextGo(false)
				arg_884_1:RecordContent(arg_884_1.text_.text)
			end

			local var_887_6 = math.max(var_887_2, arg_884_1.talkMaxDuration)

			if var_887_1 <= arg_884_1.time_ and arg_884_1.time_ < var_887_1 + var_887_6 then
				arg_884_1.typewritter.percent = (arg_884_1.time_ - var_887_1) / var_887_6

				arg_884_1.typewritter:SetDirty()
			end

			if arg_884_1.time_ >= var_887_1 + var_887_6 and arg_884_1.time_ < var_887_1 + var_887_6 + arg_887_0 then
				arg_884_1.typewritter.percent = 1

				arg_884_1.typewritter:SetDirty()
				arg_884_1:ShowNextGo(true)
			end
		end

		arg_884_1.nodeConfigList_ = {}

		arg_884_1:InitPlayNodeList()
	end,
	Play123011212 = function(arg_888_0, arg_888_1)
		arg_888_1.time_ = 0
		arg_888_1.frameCnt_ = 0
		arg_888_1.state_ = "playing"
		arg_888_1.curTalkId_ = 123011212
		arg_888_1.duration_ = 5

		SetActive(arg_888_1.tipsGo_, false)

		function arg_888_1.onSingleLineFinish_()
			arg_888_1.onSingleLineUpdate_ = nil
			arg_888_1.onSingleLineFinish_ = nil
			arg_888_1.state_ = "waiting"
		end

		function arg_888_1.playNext_(arg_890_0)
			if arg_890_0 == 1 then
				arg_888_0:Play123011213(arg_888_1)
			end
		end

		function arg_888_1.onSingleLineUpdate_(arg_891_0)
			if 0 < arg_888_1.time_ and arg_888_1.time_ <= 0 + arg_891_0 then
				arg_888_1.var_.moveOldPos1019ui_story = arg_888_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_891_0 = 0.001

			if 0 <= arg_888_1.time_ and arg_888_1.time_ < 0 + var_891_0 then
				arg_888_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_888_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_888_1.time_ - 0) / var_891_0)
				arg_888_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_888_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1019ui_story"].transform.position).z)
				arg_888_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_888_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_888_1.actors_["1019ui_story"].transform.localEulerAngles = arg_888_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_888_1.time_ >= 0 + var_891_0 and arg_888_1.time_ < 0 + var_891_0 + arg_891_0 then
				arg_888_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_888_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_888_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_888_1.actors_["1019ui_story"].transform.position).z)
				arg_888_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_888_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_888_1.actors_["1019ui_story"].transform.localEulerAngles = arg_888_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_891_1 = arg_888_1.actors_["1019ui_story"]

			if 0 < arg_888_1.time_ and arg_888_1.time_ <= 0 + arg_891_0 and not isNil(var_891_1) and arg_888_1.var_.characterEffect1019ui_story == nil then
				arg_888_1.var_.characterEffect1019ui_story = var_891_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_891_2 = 0.200000002980232

			if 0 <= arg_888_1.time_ and arg_888_1.time_ < 0 + var_891_2 and not isNil(var_891_1) then
				if arg_888_1.var_.characterEffect1019ui_story and not isNil(var_891_1) then
					arg_888_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_888_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_888_1.time_ - 0) / var_891_2)
				end
			end

			if arg_888_1.time_ >= 0 + var_891_2 and arg_888_1.time_ < 0 + var_891_2 + arg_891_0 and not isNil(var_891_1) and arg_888_1.var_.characterEffect1019ui_story then
				arg_888_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_888_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_891_3 = 0
			local var_891_4 = 0.375

			if 0 < arg_888_1.time_ and arg_888_1.time_ <= var_891_3 + arg_891_0 then
				arg_888_1.talkMaxDuration = 0
				arg_888_1.dialogCg_.alpha = 1

				arg_888_1.dialog_:SetActive(true)
				SetActive(arg_888_1.leftNameGo_, false)

				arg_888_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_888_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_888_1:RecordName(arg_888_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_888_1.iconTrs_.gameObject, false)
				arg_888_1.callingController_:SetSelectedState("normal")

				local var_891_5 = arg_888_1:FormatText(arg_888_1:GetWordFromCfg(123011212).content)

				arg_888_1.text_.text = var_891_5

				LuaForUtil.ClearLinePrefixSymbol(arg_888_1.text_)

				local var_891_7 = 15 <= 0 and var_891_4 or var_891_4 * (utf8.len(var_891_5) / 15)

				if (15 <= 0 and var_891_4 or var_891_4 * (utf8.len(var_891_5) / 15)) > 0 and var_891_4 < var_891_7 then
					arg_888_1.talkMaxDuration = var_891_7

					if var_891_7 + var_891_3 > arg_888_1.duration_ then
						arg_888_1.duration_ = var_891_7 + var_891_3
					end
				end

				arg_888_1.text_.text = var_891_5
				arg_888_1.typewritter.percent = 0

				arg_888_1.typewritter:SetDirty()
				arg_888_1:ShowNextGo(false)
				arg_888_1:RecordContent(arg_888_1.text_.text)
			end

			local var_891_8 = math.max(var_891_4, arg_888_1.talkMaxDuration)

			if var_891_3 <= arg_888_1.time_ and arg_888_1.time_ < var_891_3 + var_891_8 then
				arg_888_1.typewritter.percent = (arg_888_1.time_ - var_891_3) / var_891_8

				arg_888_1.typewritter:SetDirty()
			end

			if arg_888_1.time_ >= var_891_3 + var_891_8 and arg_888_1.time_ < var_891_3 + var_891_8 + arg_891_0 then
				arg_888_1.typewritter.percent = 1

				arg_888_1.typewritter:SetDirty()
				arg_888_1:ShowNextGo(true)
			end
		end

		arg_888_1.nodeConfigList_ = {
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

		arg_888_1:InitPlayNodeList()
	end,
	Play123011213 = function(arg_892_0, arg_892_1)
		arg_892_1.time_ = 0
		arg_892_1.frameCnt_ = 0
		arg_892_1.state_ = "playing"
		arg_892_1.curTalkId_ = 123011213
		arg_892_1.duration_ = 12.9

		local var_892_0 = {
			zh = 12.9,
			ja = 11.533
		}
		local var_892_1 = manager.audio:GetLocalizationFlag()

		if var_892_0[var_892_1] ~= nil then
			arg_892_1.duration_ = var_892_0[var_892_1]
		end

		SetActive(arg_892_1.tipsGo_, false)

		function arg_892_1.onSingleLineFinish_()
			arg_892_1.onSingleLineUpdate_ = nil
			arg_892_1.onSingleLineFinish_ = nil
			arg_892_1.state_ = "waiting"
		end

		function arg_892_1.playNext_(arg_894_0)
			if arg_894_0 == 1 then
				arg_892_0:Play123011214(arg_892_1)
			end
		end

		function arg_892_1.onSingleLineUpdate_(arg_895_0)
			if 0 < arg_892_1.time_ and arg_892_1.time_ <= 0 + arg_895_0 then
				arg_892_1.var_.moveOldPos1019ui_story = arg_892_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_895_0 = 0.001

			if 0 <= arg_892_1.time_ and arg_892_1.time_ < 0 + var_895_0 then
				arg_892_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_892_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_892_1.time_ - 0) / var_895_0)
				arg_892_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_892_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_892_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_892_1.actors_["1019ui_story"].transform.position).z)
				arg_892_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_892_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_892_1.actors_["1019ui_story"].transform.localEulerAngles = arg_892_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_892_1.time_ >= 0 + var_895_0 and arg_892_1.time_ < 0 + var_895_0 + arg_895_0 then
				arg_892_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_892_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_892_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_892_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_892_1.actors_["1019ui_story"].transform.position).z)
				arg_892_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_892_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_892_1.actors_["1019ui_story"].transform.localEulerAngles = arg_892_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_895_1 = arg_892_1.actors_["1019ui_story"]

			if 0 < arg_892_1.time_ and arg_892_1.time_ <= 0 + arg_895_0 and not isNil(var_895_1) and arg_892_1.var_.characterEffect1019ui_story == nil then
				arg_892_1.var_.characterEffect1019ui_story = var_895_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_895_2 = 0.200000002980232

			if 0 <= arg_892_1.time_ and arg_892_1.time_ < 0 + var_895_2 and not isNil(var_895_1) then
				if arg_892_1.var_.characterEffect1019ui_story and not isNil(var_895_1) then
					arg_892_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_892_1.time_ >= 0 + var_895_2 and arg_892_1.time_ < 0 + var_895_2 + arg_895_0 and not isNil(var_895_1) and arg_892_1.var_.characterEffect1019ui_story then
				arg_892_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_892_1.time_ and arg_892_1.time_ <= 0 + arg_895_0 then
				arg_892_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_892_1.time_ and arg_892_1.time_ <= 0 + arg_895_0 then
				arg_892_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_895_4 = 0
			local var_895_5 = 1.575

			if 0 < arg_892_1.time_ and arg_892_1.time_ <= var_895_4 + arg_895_0 then
				arg_892_1.talkMaxDuration = 0
				arg_892_1.dialogCg_.alpha = 1

				arg_892_1.dialog_:SetActive(true)
				SetActive(arg_892_1.leftNameGo_, true)

				arg_892_1.leftNameTxt_.text = arg_892_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_892_1.leftNameTxt_.transform)

				arg_892_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_892_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_892_1:RecordName(arg_892_1.leftNameTxt_.text)
				SetActive(arg_892_1.iconTrs_.gameObject, false)
				arg_892_1.callingController_:SetSelectedState("normal")

				local var_895_6 = arg_892_1:GetWordFromCfg(123011213)
				local var_895_7 = arg_892_1:FormatText(var_895_6.content)

				arg_892_1.text_.text = var_895_7

				LuaForUtil.ClearLinePrefixSymbol(arg_892_1.text_)

				local var_895_9 = 63 <= 0 and var_895_5 or var_895_5 * (utf8.len(var_895_7) / 63)

				if (63 <= 0 and var_895_5 or var_895_5 * (utf8.len(var_895_7) / 63)) > 0 and var_895_5 < var_895_9 then
					arg_892_1.talkMaxDuration = var_895_9

					if var_895_9 + var_895_4 > arg_892_1.duration_ then
						arg_892_1.duration_ = var_895_9 + var_895_4
					end
				end

				arg_892_1.text_.text = var_895_7
				arg_892_1.typewritter.percent = 0

				arg_892_1.typewritter:SetDirty()
				arg_892_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011213", "story_v_out_123011.awb") ~= 0 then
					local var_895_10 = manager.audio:GetVoiceLength("story_v_out_123011", "123011213", "story_v_out_123011.awb") / 1000

					if var_895_10 + var_895_4 > arg_892_1.duration_ then
						arg_892_1.duration_ = var_895_10 + var_895_4
					end

					if var_895_6.prefab_name ~= "" and arg_892_1.actors_[var_895_6.prefab_name] ~= nil then
						local var_895_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_892_1.actors_[var_895_6.prefab_name].transform, "story_v_out_123011", "123011213", "story_v_out_123011.awb")

						arg_892_1:RecordAudio("123011213", var_895_11)
						arg_892_1:RecordAudio("123011213", var_895_11)
					else
						arg_892_1:AudioAction("play", "voice", "story_v_out_123011", "123011213", "story_v_out_123011.awb")
					end

					arg_892_1:RecordHistoryTalkVoice("story_v_out_123011", "123011213", "story_v_out_123011.awb")
				end

				arg_892_1:RecordContent(arg_892_1.text_.text)
			end

			local var_895_12 = math.max(var_895_5, arg_892_1.talkMaxDuration)

			if var_895_4 <= arg_892_1.time_ and arg_892_1.time_ < var_895_4 + var_895_12 then
				arg_892_1.typewritter.percent = (arg_892_1.time_ - var_895_4) / var_895_12

				arg_892_1.typewritter:SetDirty()
			end

			if arg_892_1.time_ >= var_895_4 + var_895_12 and arg_892_1.time_ < var_895_4 + var_895_12 + arg_895_0 then
				arg_892_1.typewritter.percent = 1

				arg_892_1.typewritter:SetDirty()
				arg_892_1:ShowNextGo(true)
			end
		end

		arg_892_1.nodeConfigList_ = {
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

		arg_892_1:InitPlayNodeList()
	end,
	Play123011214 = function(arg_896_0, arg_896_1)
		arg_896_1.time_ = 0
		arg_896_1.frameCnt_ = 0
		arg_896_1.state_ = "playing"
		arg_896_1.curTalkId_ = 123011214
		arg_896_1.duration_ = 5

		SetActive(arg_896_1.tipsGo_, false)

		function arg_896_1.onSingleLineFinish_()
			arg_896_1.onSingleLineUpdate_ = nil
			arg_896_1.onSingleLineFinish_ = nil
			arg_896_1.state_ = "waiting"
		end

		function arg_896_1.playNext_(arg_898_0)
			if arg_898_0 == 1 then
				arg_896_0:Play123011215(arg_896_1)
			end
		end

		function arg_896_1.onSingleLineUpdate_(arg_899_0)
			if 0 < arg_896_1.time_ and arg_896_1.time_ <= 0 + arg_899_0 and not isNil(arg_896_1.actors_["1019ui_story"]) and arg_896_1.var_.characterEffect1019ui_story == nil then
				arg_896_1.var_.characterEffect1019ui_story = arg_896_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_899_0 = 0.200000002980232

			if 0 <= arg_896_1.time_ and arg_896_1.time_ < 0 + var_899_0 and not isNil(arg_896_1.actors_["1019ui_story"]) then
				if arg_896_1.var_.characterEffect1019ui_story and not isNil(arg_896_1.actors_["1019ui_story"]) then
					arg_896_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_896_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_896_1.time_ - 0) / var_899_0)
				end
			end

			if arg_896_1.time_ >= 0 + var_899_0 and arg_896_1.time_ < 0 + var_899_0 + arg_899_0 and not isNil(arg_896_1.actors_["1019ui_story"]) and arg_896_1.var_.characterEffect1019ui_story then
				arg_896_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_896_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_899_1 = 0
			local var_899_2 = 0.55

			if 0 < arg_896_1.time_ and arg_896_1.time_ <= var_899_1 + arg_899_0 then
				arg_896_1.talkMaxDuration = 0
				arg_896_1.dialogCg_.alpha = 1

				arg_896_1.dialog_:SetActive(true)
				SetActive(arg_896_1.leftNameGo_, false)

				arg_896_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_896_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_896_1:RecordName(arg_896_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_896_1.iconTrs_.gameObject, false)
				arg_896_1.callingController_:SetSelectedState("normal")

				local var_899_3 = arg_896_1:FormatText(arg_896_1:GetWordFromCfg(123011214).content)

				arg_896_1.text_.text = var_899_3

				LuaForUtil.ClearLinePrefixSymbol(arg_896_1.text_)

				local var_899_5 = 22 <= 0 and var_899_2 or var_899_2 * (utf8.len(var_899_3) / 22)

				if (22 <= 0 and var_899_2 or var_899_2 * (utf8.len(var_899_3) / 22)) > 0 and var_899_2 < var_899_5 then
					arg_896_1.talkMaxDuration = var_899_5

					if var_899_5 + var_899_1 > arg_896_1.duration_ then
						arg_896_1.duration_ = var_899_5 + var_899_1
					end
				end

				arg_896_1.text_.text = var_899_3
				arg_896_1.typewritter.percent = 0

				arg_896_1.typewritter:SetDirty()
				arg_896_1:ShowNextGo(false)
				arg_896_1:RecordContent(arg_896_1.text_.text)
			end

			local var_899_6 = math.max(var_899_2, arg_896_1.talkMaxDuration)

			if var_899_1 <= arg_896_1.time_ and arg_896_1.time_ < var_899_1 + var_899_6 then
				arg_896_1.typewritter.percent = (arg_896_1.time_ - var_899_1) / var_899_6

				arg_896_1.typewritter:SetDirty()
			end

			if arg_896_1.time_ >= var_899_1 + var_899_6 and arg_896_1.time_ < var_899_1 + var_899_6 + arg_899_0 then
				arg_896_1.typewritter.percent = 1

				arg_896_1.typewritter:SetDirty()
				arg_896_1:ShowNextGo(true)
			end
		end

		arg_896_1.nodeConfigList_ = {}

		arg_896_1:InitPlayNodeList()
	end,
	Play123011215 = function(arg_900_0, arg_900_1)
		arg_900_1.time_ = 0
		arg_900_1.frameCnt_ = 0
		arg_900_1.state_ = "playing"
		arg_900_1.curTalkId_ = 123011215
		arg_900_1.duration_ = 6.23

		local var_900_0 = {
			zh = 4.8,
			ja = 6.233
		}
		local var_900_1 = manager.audio:GetLocalizationFlag()

		if var_900_0[var_900_1] ~= nil then
			arg_900_1.duration_ = var_900_0[var_900_1]
		end

		SetActive(arg_900_1.tipsGo_, false)

		function arg_900_1.onSingleLineFinish_()
			arg_900_1.onSingleLineUpdate_ = nil
			arg_900_1.onSingleLineFinish_ = nil
			arg_900_1.state_ = "waiting"
		end

		function arg_900_1.playNext_(arg_902_0)
			if arg_902_0 == 1 then
				arg_900_0:Play123011216(arg_900_1)
			end
		end

		function arg_900_1.onSingleLineUpdate_(arg_903_0)
			if 0 < arg_900_1.time_ and arg_900_1.time_ <= 0 + arg_903_0 and not isNil(arg_900_1.actors_["1019ui_story"]) and arg_900_1.var_.characterEffect1019ui_story == nil then
				arg_900_1.var_.characterEffect1019ui_story = arg_900_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_903_0 = 0.200000002980232

			if 0 <= arg_900_1.time_ and arg_900_1.time_ < 0 + var_903_0 and not isNil(arg_900_1.actors_["1019ui_story"]) then
				if arg_900_1.var_.characterEffect1019ui_story and not isNil(arg_900_1.actors_["1019ui_story"]) then
					arg_900_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_900_1.time_ >= 0 + var_903_0 and arg_900_1.time_ < 0 + var_903_0 + arg_903_0 and not isNil(arg_900_1.actors_["1019ui_story"]) and arg_900_1.var_.characterEffect1019ui_story then
				arg_900_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_903_2 = 0
			local var_903_3 = 0.475

			if 0 < arg_900_1.time_ and arg_900_1.time_ <= var_903_2 + arg_903_0 then
				arg_900_1.talkMaxDuration = 0
				arg_900_1.dialogCg_.alpha = 1

				arg_900_1.dialog_:SetActive(true)
				SetActive(arg_900_1.leftNameGo_, true)

				arg_900_1.leftNameTxt_.text = arg_900_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_900_1.leftNameTxt_.transform)

				arg_900_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_900_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_900_1:RecordName(arg_900_1.leftNameTxt_.text)
				SetActive(arg_900_1.iconTrs_.gameObject, false)
				arg_900_1.callingController_:SetSelectedState("normal")

				local var_903_4 = arg_900_1:GetWordFromCfg(123011215)
				local var_903_5 = arg_900_1:FormatText(var_903_4.content)

				arg_900_1.text_.text = var_903_5

				LuaForUtil.ClearLinePrefixSymbol(arg_900_1.text_)

				local var_903_7 = 19 <= 0 and var_903_3 or var_903_3 * (utf8.len(var_903_5) / 19)

				if (19 <= 0 and var_903_3 or var_903_3 * (utf8.len(var_903_5) / 19)) > 0 and var_903_3 < var_903_7 then
					arg_900_1.talkMaxDuration = var_903_7

					if var_903_7 + var_903_2 > arg_900_1.duration_ then
						arg_900_1.duration_ = var_903_7 + var_903_2
					end
				end

				arg_900_1.text_.text = var_903_5
				arg_900_1.typewritter.percent = 0

				arg_900_1.typewritter:SetDirty()
				arg_900_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123011", "123011215", "story_v_out_123011.awb") ~= 0 then
					local var_903_8 = manager.audio:GetVoiceLength("story_v_out_123011", "123011215", "story_v_out_123011.awb") / 1000

					if var_903_8 + var_903_2 > arg_900_1.duration_ then
						arg_900_1.duration_ = var_903_8 + var_903_2
					end

					if var_903_4.prefab_name ~= "" and arg_900_1.actors_[var_903_4.prefab_name] ~= nil then
						local var_903_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_900_1.actors_[var_903_4.prefab_name].transform, "story_v_out_123011", "123011215", "story_v_out_123011.awb")

						arg_900_1:RecordAudio("123011215", var_903_9)
						arg_900_1:RecordAudio("123011215", var_903_9)
					else
						arg_900_1:AudioAction("play", "voice", "story_v_out_123011", "123011215", "story_v_out_123011.awb")
					end

					arg_900_1:RecordHistoryTalkVoice("story_v_out_123011", "123011215", "story_v_out_123011.awb")
				end

				arg_900_1:RecordContent(arg_900_1.text_.text)
			end

			local var_903_10 = math.max(var_903_3, arg_900_1.talkMaxDuration)

			if var_903_2 <= arg_900_1.time_ and arg_900_1.time_ < var_903_2 + var_903_10 then
				arg_900_1.typewritter.percent = (arg_900_1.time_ - var_903_2) / var_903_10

				arg_900_1.typewritter:SetDirty()
			end

			if arg_900_1.time_ >= var_903_2 + var_903_10 and arg_900_1.time_ < var_903_2 + var_903_10 + arg_903_0 then
				arg_900_1.typewritter.percent = 1

				arg_900_1.typewritter:SetDirty()
				arg_900_1:ShowNextGo(true)
			end
		end

		arg_900_1.nodeConfigList_ = {}

		arg_900_1:InitPlayNodeList()
	end,
	Play123011216 = function(arg_904_0, arg_904_1)
		arg_904_1.time_ = 0
		arg_904_1.frameCnt_ = 0
		arg_904_1.state_ = "playing"
		arg_904_1.curTalkId_ = 123011216
		arg_904_1.duration_ = 5

		SetActive(arg_904_1.tipsGo_, false)

		function arg_904_1.onSingleLineFinish_()
			arg_904_1.onSingleLineUpdate_ = nil
			arg_904_1.onSingleLineFinish_ = nil
			arg_904_1.state_ = "waiting"
			arg_904_1.auto_ = false
		end

		function arg_904_1.playNext_(arg_906_0)
			arg_904_1.onStoryFinished_()
		end

		function arg_904_1.onSingleLineUpdate_(arg_907_0)
			local var_907_0 = 0.075

			if 0 < arg_904_1.time_ and arg_904_1.time_ <= 0 + arg_907_0 then
				arg_904_1.talkMaxDuration = 0
				arg_904_1.dialogCg_.alpha = 1

				arg_904_1.dialog_:SetActive(true)
				SetActive(arg_904_1.leftNameGo_, true)

				arg_904_1.leftNameTxt_.text = arg_904_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_904_1.leftNameTxt_.transform)

				arg_904_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_904_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_904_1:RecordName(arg_904_1.leftNameTxt_.text)
				SetActive(arg_904_1.iconTrs_.gameObject, true)
				arg_904_1.iconController_:SetSelectedState("hero")

				arg_904_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_904_1.callingController_:SetSelectedState("normal")

				arg_904_1.keyicon_.color = Color.New(1, 1, 1)
				arg_904_1.icon_.color = Color.New(1, 1, 1)

				local var_907_1 = arg_904_1:FormatText(arg_904_1:GetWordFromCfg(123011216).content)

				arg_904_1.text_.text = var_907_1

				LuaForUtil.ClearLinePrefixSymbol(arg_904_1.text_)

				local var_907_3 = 3 <= 0 and var_907_0 or var_907_0 * (utf8.len(var_907_1) / 3)

				if (3 <= 0 and var_907_0 or var_907_0 * (utf8.len(var_907_1) / 3)) > 0 and var_907_0 < var_907_3 then
					arg_904_1.talkMaxDuration = var_907_3

					if var_907_3 + 0 > arg_904_1.duration_ then
						arg_904_1.duration_ = var_907_3 + 0
					end
				end

				arg_904_1.text_.text = var_907_1
				arg_904_1.typewritter.percent = 0

				arg_904_1.typewritter:SetDirty()
				arg_904_1:ShowNextGo(false)
				arg_904_1:RecordContent(arg_904_1.text_.text)
			end

			local var_907_4 = math.max(var_907_0, arg_904_1.talkMaxDuration)

			if 0 <= arg_904_1.time_ and arg_904_1.time_ < 0 + var_907_4 then
				arg_904_1.typewritter.percent = (arg_904_1.time_ - 0) / var_907_4

				arg_904_1.typewritter:SetDirty()
			end

			if arg_904_1.time_ >= 0 + var_907_4 and arg_904_1.time_ < 0 + var_907_4 + arg_907_0 then
				arg_904_1.typewritter.percent = 1

				arg_904_1.typewritter:SetDirty()
				arg_904_1:ShowNextGo(true)
			end
		end

		arg_904_1.nodeConfigList_ = {}

		arg_904_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/BA0105",
		"TextureConfig/Background/BA0101",
		"TextureConfig/Background/BA0101a",
		"TextureConfig/Background/ST11a",
		"TextureConfig/Background/XH0509",
		"TextureConfig/Background/J12f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I02",
		"TextureConfig/Background/XH0607",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/BA0102",
		"TextureConfig/Background/B13"
	},
	voices = {
		"story_v_out_123011.awb"
	}
}
