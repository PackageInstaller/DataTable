return {
	Play421081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L08h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08h")
				var_4_0.name = "L08h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L08h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L08h

				arg_1_1.bgs_.L08h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L08h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.5 and arg_1_1.time_ < var_4_4 + 0.5 + arg_4_0 then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if 2.1 < arg_1_1.time_ and arg_1_1.time_ <= 2.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_chain", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(421081001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 53 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 53)

				if (53 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 53)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play421081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 421081002
		arg_8_1.duration_ = 13.2

		local var_8_0 = {
			zh = 7.4,
			ja = 13.2
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play421081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.8

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(421081002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 32 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 32)

				if (32 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 32)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081002", "story_v_out_421081.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081002", "story_v_out_421081.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_421081", "421081002", "story_v_out_421081.awb")

						arg_8_1:RecordAudio("421081002", var_11_6)
						arg_8_1:RecordAudio("421081002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_421081", "421081002", "story_v_out_421081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_421081", "421081002", "story_v_out_421081.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play421081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 421081003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play421081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.2

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(421081003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 48 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 48)

				if (48 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 48)) > 0 and var_15_0 < var_15_3 then
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
	Play421081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 421081004
		arg_16_1.duration_ = 1.87

		local var_16_0 = {
			zh = 1.866,
			ja = 1.8
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
				arg_16_0:Play421081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.175

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1322].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(421081004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 7 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 7)

				if (7 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 7)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081004", "story_v_out_421081.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081004", "story_v_out_421081.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_421081", "421081004", "story_v_out_421081.awb")

						arg_16_1:RecordAudio("421081004", var_19_6)
						arg_16_1:RecordAudio("421081004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_421081", "421081004", "story_v_out_421081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_421081", "421081004", "story_v_out_421081.awb")
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
	Play421081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 421081005
		arg_20_1.duration_ = 4.8

		local var_20_0 = {
			zh = 4.8,
			ja = 3.566
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
				arg_20_0:Play421081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.4

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(421081005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 16 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 16)

				if (16 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 16)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081005", "story_v_out_421081.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081005", "story_v_out_421081.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_421081", "421081005", "story_v_out_421081.awb")

						arg_20_1:RecordAudio("421081005", var_23_6)
						arg_20_1:RecordAudio("421081005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_421081", "421081005", "story_v_out_421081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_421081", "421081005", "story_v_out_421081.awb")
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
	Play421081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 421081006
		arg_24_1.duration_ = 5.67

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play421081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_9002
			local var_27_9001
			local var_27_9000

			if 0.1 < arg_24_1.time_ and arg_24_1.time_ <= 0.1 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ravana_attack04", "")
			end

			local var_27_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_24_1.time_ and arg_24_1.time_ <= 0.1 + arg_27_0 then
				arg_24_1.var_.shakeOldPos = var_27_1.localPosition
			end

			local var_27_2 = 1

			if 0.1 <= arg_24_1.time_ and arg_24_1.time_ < 0.1 + var_27_2 then
				local var_27_3, var_27_4 = math.modf((arg_24_1.time_ - 0.1) / 0.066)

				var_27_1.localPosition = Vector3.New(var_27_4 * 0.13, var_27_4 * 0.13, var_27_4 * 0.13) + arg_24_1.var_.shakeOldPos
			end

			if arg_24_1.time_ >= 0.1 + var_27_2 and arg_24_1.time_ < 0.1 + var_27_2 + arg_27_0 then
				var_27_1.localPosition = arg_24_1.var_.shakeOldPos
			end

			local var_27_5 = manager.ui.mainCamera.transform

			if 0.2 < arg_24_1.time_ and arg_24_1.time_ <= 0.2 + arg_27_0 then
				arg_24_1.var_.shakeOldPos = var_27_5.localPosition
			end

			local var_27_6 = 0.9

			if 0.2 <= arg_24_1.time_ and arg_24_1.time_ < 0.2 + var_27_6 then
				local var_27_7, var_27_8 = math.modf((arg_24_1.time_ - 0.2) / 0.066)

				var_27_5.localPosition = Vector3.New(var_27_8 * 0.13, var_27_8 * 0.13, var_27_8 * 0.13) + arg_24_1.var_.shakeOldPos
			end

			if arg_24_1.time_ >= 0.2 + var_27_6 and arg_24_1.time_ < 0.2 + var_27_6 + arg_27_0 then
				var_27_5.localPosition = arg_24_1.var_.shakeOldPos
			end

			local var_27_9 = manager.ui.mainCamera.transform

			if 0.333333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 0.333333333333333 + arg_27_0 then
				arg_24_1.var_.shakeOldPos = var_27_9.localPosition
			end

			local var_27_10 = 1.9

			if 0.333333333333333 <= arg_24_1.time_ and arg_24_1.time_ < 0.333333333333333 + var_27_10 then
				local var_27_11, var_27_12 = math.modf((arg_24_1.time_ - 0.333333333333333) / 0.066)

				var_27_9.localPosition = Vector3.New(var_27_12 * 0.13, var_27_12 * 0.13, var_27_12 * 0.13) + arg_24_1.var_.shakeOldPos
			end

			if arg_24_1.time_ >= 0.333333333333333 + var_27_10 and arg_24_1.time_ < 0.333333333333333 + var_27_10 + arg_27_0 then
				var_27_9.localPosition = arg_24_1.var_.shakeOldPos
			end

			if 0.1 < arg_24_1.time_ and arg_24_1.time_ <= 0.1 + arg_27_0 then
				local var_27_13 = arg_24_1.var_.effect10061

				if not arg_24_1.var_.effect10061 then
					var_27_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_27_13.name = "10061"
					arg_24_1.var_.effect10061 = var_27_13
				else
					var_27_13.transform:SetParent(var_27_9002)
				end

				var_27_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_27_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.23333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 3.23333333333333 + arg_27_0 then
				if arg_24_1.var_.effect10061 then
					Object.Destroy(arg_24_1.var_.effect10061)

					arg_24_1.var_.effect10061 = nil
				end
			end

			if 0.2 < arg_24_1.time_ and arg_24_1.time_ <= 0.2 + arg_27_0 then
				local var_27_16 = arg_24_1.var_.effect10062

				if not arg_24_1.var_.effect10062 then
					var_27_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_27_16.name = "10062"
					arg_24_1.var_.effect10062 = var_27_16
				else
					var_27_16.transform:SetParent(var_27_9001)
				end

				var_27_16.transform.localPosition = Vector3.New(0, 0.12, -0.01)
				var_27_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.23333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 3.23333333333333 + arg_27_0 then
				if arg_24_1.var_.effect10062 then
					Object.Destroy(arg_24_1.var_.effect10062)

					arg_24_1.var_.effect10062 = nil
				end
			end

			if 0.333333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 0.333333333333333 + arg_27_0 then
				local var_27_19 = arg_24_1.var_.effect10063

				if not arg_24_1.var_.effect10063 then
					var_27_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_27_19.name = "10063"
					arg_24_1.var_.effect10063 = var_27_19
				else
					var_27_19.transform:SetParent(var_27_9000)
				end

				var_27_19.transform.localPosition = Vector3.New(0.32, 0, 0)
				var_27_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.36666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 3.36666666666667 + arg_27_0 then
				if arg_24_1.var_.effect10063 then
					Object.Destroy(arg_24_1.var_.effect10063)

					arg_24_1.var_.effect10063 = nil
				end
			end

			local var_27_22 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			if arg_24_1.time_ >= var_27_22 + 4.03333333333333 and arg_24_1.time_ < var_27_22 + 4.03333333333333 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_23 = 0
			local var_27_24 = 1.525

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_25 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(421081006).content)

				arg_24_1.text_.text = var_27_25

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_27 = 61 <= 0 and var_27_24 or var_27_24 * (utf8.len(var_27_25) / 61)

				if (61 <= 0 and var_27_24 or var_27_24 * (utf8.len(var_27_25) / 61)) > 0 and var_27_24 < var_27_27 then
					arg_24_1.talkMaxDuration = var_27_27

					if var_27_27 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_27 + var_27_23
					end
				end

				arg_24_1.text_.text = var_27_25
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_28 = math.max(var_27_24, arg_24_1.talkMaxDuration)

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_28 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_23) / var_27_28

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_23 + var_27_28 and arg_24_1.time_ < var_27_23 + var_27_28 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play421081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 421081007
		arg_28_1.duration_ = 5.07

		local var_28_0 = {
			zh = 4.1,
			ja = 5.066
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
				arg_28_0:Play421081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(421081007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 15 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 15)

				if (15 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 15)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081007", "story_v_out_421081.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081007", "story_v_out_421081.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_421081", "421081007", "story_v_out_421081.awb")

						arg_28_1:RecordAudio("421081007", var_31_6)
						arg_28_1:RecordAudio("421081007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_421081", "421081007", "story_v_out_421081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_421081", "421081007", "story_v_out_421081.awb")
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
	Play421081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 421081008
		arg_32_1.duration_ = 14.1

		local var_32_0 = {
			zh = 12.866,
			ja = 14.1
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
				arg_32_0:Play421081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 2 < arg_32_1.time_ and arg_32_1.time_ <= 2 + arg_35_0 then
				local var_35_0 = arg_32_1.bgs_.L08h

				arg_32_1.bgs_.L08h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_1 = var_35_0:GetComponent("SpriteRenderer")

				if var_35_1 and var_35_1.sprite then
					local var_35_2 = 2 * (var_35_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_0.transform.localScale = Vector3.New(var_35_2 / var_35_1.sprite.bounds.size.y < var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x and var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x or var_35_2 / var_35_1.sprite.bounds.size.y, var_35_2 / var_35_1.sprite.bounds.size.y < var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x and var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x or var_35_2 / var_35_1.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "L08h" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_3 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_4 = 2

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_4 then
				local var_35_5 = Color.New(0, 0, 0)

				var_35_5.a = Mathf.Lerp(0, 1, (arg_32_1.time_ - var_35_3) / var_35_4)
				arg_32_1.mask_.color = var_35_5
			end

			if arg_32_1.time_ >= var_35_3 + var_35_4 and arg_32_1.time_ < var_35_3 + var_35_4 + arg_35_0 then
				local var_35_6 = Color.New(0, 0, 0)

				var_35_6.a = 1
				arg_32_1.mask_.color = var_35_6
			end

			local var_35_7 = 2

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_8 = 2

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 then
				local var_35_9 = Color.New(0, 0, 0)

				var_35_9.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_7) / var_35_8)
				arg_32_1.mask_.color = var_35_9
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 then
				local var_35_10 = Color.New(0, 0, 0)

				arg_32_1.mask_.enabled = false
				var_35_10.a = 0
				arg_32_1.mask_.color = var_35_10
			end

			local var_35_11 = 2

			arg_32_1.isInRecall_ = false

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.screenFilterGo_:SetActive(true)

				arg_32_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")

				for iter_35_2, iter_35_3 in pairs(arg_32_1.actors_) do
					for iter_35_4, iter_35_5 in ipairs((iter_35_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_35_5.color = iter_35_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_35_12 = 2

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_12 then
				arg_32_1.screenFilterEffect_.weight = Mathf.Lerp(0, 0.702, (arg_32_1.time_ - var_35_11) / var_35_12)
			end

			if arg_32_1.time_ >= var_35_11 + var_35_12 and arg_32_1.time_ < var_35_11 + var_35_12 + arg_35_0 then
				arg_32_1.screenFilterEffect_.weight = 0.702
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_13 = 4
			local var_35_14 = 0.45

			if 4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_15 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_15:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1322].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_32_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_35_16 = arg_32_1:GetWordFromCfg(421081008)
				local var_35_17 = arg_32_1:FormatText(var_35_16.content)

				arg_32_1.text_.text = var_35_17

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_19 = 18 <= 0 and var_35_14 or var_35_14 * (utf8.len(var_35_17) / 18)

				if (18 <= 0 and var_35_14 or var_35_14 * (utf8.len(var_35_17) / 18)) > 0 and var_35_14 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19
					var_35_13 = var_35_13 + 0.3

					if var_35_19 + var_35_13 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_13
					end
				end

				arg_32_1.text_.text = var_35_17
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081008", "story_v_out_421081.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_421081", "421081008", "story_v_out_421081.awb") / 1000

					if var_35_20 + var_35_13 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_13
					end

					if var_35_16.prefab_name ~= "" and arg_32_1.actors_[var_35_16.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_16.prefab_name].transform, "story_v_out_421081", "421081008", "story_v_out_421081.awb")

						arg_32_1:RecordAudio("421081008", var_35_21)
						arg_32_1:RecordAudio("421081008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_421081", "421081008", "story_v_out_421081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_421081", "421081008", "story_v_out_421081.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = var_35_13 + 0.3
			local var_35_23 = math.max(var_35_14, arg_32_1.talkMaxDuration)

			if var_35_13 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_22 + var_35_23 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_22) / var_35_23

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_22 + var_35_23 and arg_32_1.time_ < var_35_22 + var_35_23 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play421081009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 421081009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play421081010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 1.3

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

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(421081009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 52 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 52)

				if (52 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 52)) > 0 and var_41_0 < var_41_3 then
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
	Play421081010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 421081010
		arg_42_1.duration_ = 6.77

		local var_42_0 = {
			zh = 6.766,
			ja = 5.6
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
				arg_42_0:Play421081011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.525

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1322].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_42_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_45_1 = arg_42_1:GetWordFromCfg(421081010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 21 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 21)

				if (21 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 21)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081010", "story_v_out_421081.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081010", "story_v_out_421081.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_421081", "421081010", "story_v_out_421081.awb")

						arg_42_1:RecordAudio("421081010", var_45_6)
						arg_42_1:RecordAudio("421081010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_421081", "421081010", "story_v_out_421081.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_421081", "421081010", "story_v_out_421081.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play421081011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 421081011
		arg_46_1.duration_ = 7

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play421081012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 1 < arg_46_1.time_ and arg_46_1.time_ <= 1 + arg_49_0 then
				local var_49_0 = arg_46_1.bgs_.L08h

				arg_46_1.bgs_.L08h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_49_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_49_1 = var_49_0:GetComponent("SpriteRenderer")

				if var_49_1 and var_49_1.sprite then
					local var_49_2 = 2 * (var_49_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_49_0.transform.localScale = Vector3.New(var_49_2 / var_49_1.sprite.bounds.size.y < var_49_2 * manager.ui.mainCameraCom_.aspect / var_49_1.sprite.bounds.size.x and var_49_2 * manager.ui.mainCameraCom_.aspect / var_49_1.sprite.bounds.size.x or var_49_2 / var_49_1.sprite.bounds.size.y, var_49_2 / var_49_1.sprite.bounds.size.y < var_49_2 * manager.ui.mainCameraCom_.aspect / var_49_1.sprite.bounds.size.x and var_49_2 * manager.ui.mainCameraCom_.aspect / var_49_1.sprite.bounds.size.x or var_49_2 / var_49_1.sprite.bounds.size.y, 0)
				end

				for iter_49_0, iter_49_1 in pairs(arg_46_1.bgs_) do
					if iter_49_0 ~= "L08h" then
						iter_49_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_49_3 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_3 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_4 = 1

			if var_49_3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_3 + var_49_4 then
				local var_49_5 = Color.New(0, 0, 0)

				var_49_5.a = Mathf.Lerp(0, 1, (arg_46_1.time_ - var_49_3) / var_49_4)
				arg_46_1.mask_.color = var_49_5
			end

			if arg_46_1.time_ >= var_49_3 + var_49_4 and arg_46_1.time_ < var_49_3 + var_49_4 + arg_49_0 then
				local var_49_6 = Color.New(0, 0, 0)

				var_49_6.a = 1
				arg_46_1.mask_.color = var_49_6
			end

			local var_49_7 = 1

			if 1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_7 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_8 = 1

			if var_49_7 <= arg_46_1.time_ and arg_46_1.time_ < var_49_7 + var_49_8 then
				local var_49_9 = Color.New(0, 0, 0)

				var_49_9.a = Mathf.Lerp(1, 0, (arg_46_1.time_ - var_49_7) / var_49_8)
				arg_46_1.mask_.color = var_49_9
			end

			if arg_46_1.time_ >= var_49_7 + var_49_8 and arg_46_1.time_ < var_49_7 + var_49_8 + arg_49_0 then
				local var_49_10 = Color.New(0, 0, 0)

				arg_46_1.mask_.enabled = false
				var_49_10.a = 0
				arg_46_1.mask_.color = var_49_10
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_11 = 2
			local var_49_12 = 1.575

			if 2 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_13 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_13:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_14 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(421081011).content)

				arg_46_1.text_.text = var_49_14

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_16 = 63 <= 0 and var_49_12 or var_49_12 * (utf8.len(var_49_14) / 63)

				if (63 <= 0 and var_49_12 or var_49_12 * (utf8.len(var_49_14) / 63)) > 0 and var_49_12 < var_49_16 then
					arg_46_1.talkMaxDuration = var_49_16
					var_49_11 = var_49_11 + 0.3

					if var_49_16 + var_49_11 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_16 + var_49_11
					end
				end

				arg_46_1.text_.text = var_49_14
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_17 = var_49_11 + 0.3
			local var_49_18 = math.max(var_49_12, arg_46_1.talkMaxDuration)

			if var_49_11 + 0.3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_17 + var_49_18 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_17) / var_49_18

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_17 + var_49_18 and arg_46_1.time_ < var_49_17 + var_49_18 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play421081012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 421081012
		arg_52_1.duration_ = 3.9

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play421081013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.3

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1322].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_52_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_55_1 = arg_52_1:GetWordFromCfg(421081012)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 12 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 12)

				if (12 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 12)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081012", "story_v_out_421081.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081012", "story_v_out_421081.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_421081", "421081012", "story_v_out_421081.awb")

						arg_52_1:RecordAudio("421081012", var_55_6)
						arg_52_1:RecordAudio("421081012", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_421081", "421081012", "story_v_out_421081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_421081", "421081012", "story_v_out_421081.awb")
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
	Play421081013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 421081013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play421081014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_59_0 then
					var_59_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_59_0.radialBlurScale = 0
					var_59_0.radialBlurGradient = 1
					var_59_0.radialBlurIntensity = 1

					if nil then
						var_59_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_59_1 = 1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				local var_59_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_59_2 then
					var_59_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_59_2.radialBlurScale = Mathf.Lerp(0, 1, (arg_56_1.time_ - 0) / var_59_1)
					var_59_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_56_1.time_ - 0) / var_59_1)
					var_59_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_56_1.time_ - 0) / var_59_1)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				local var_59_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_59_3 then
					var_59_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_59_3.radialBlurScale = 1
					var_59_3.radialBlurGradient = 1
					var_59_3.radialBlurIntensity = 1
				end
			end

			local var_59_4 = 0
			local var_59_5 = 1.575

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(421081013).content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_8 = 63 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_6) / 63)

				if (63 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_6) / 63)) > 0 and var_59_5 < var_59_8 then
					arg_56_1.talkMaxDuration = var_59_8

					if var_59_8 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_9 and arg_56_1.time_ < var_59_4 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play421081014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 421081014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play421081015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0.566666666666667 < arg_60_1.time_ and arg_60_1.time_ <= 0.566666666666667 + arg_63_0 then
				local var_63_0 = arg_60_1.var_.effect1015

				if not arg_60_1.var_.effect1015 then
					var_63_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_in_keep"), manager.ui.mainCamera.transform)
					var_63_0.name = "1015"
					arg_60_1.var_.effect1015 = var_63_0
				else
					var_63_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_63_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_63_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.1 < arg_60_1.time_ and arg_60_1.time_ <= 0.1 + arg_63_0 then
				arg_60_1:AudioAction("play", "effect", "se_story_136", "se_story_136_gun", "")
			end

			if 0.46809366332988 < arg_60_1.time_ and arg_60_1.time_ <= 0.46809366332988 + arg_63_0 then
				arg_60_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_63_4 = manager.ui.mainCamera.transform

			if 0.46809366332988 < arg_60_1.time_ and arg_60_1.time_ <= 0.46809366332988 + arg_63_0 then
				arg_60_1.var_.shakeOldPos = var_63_4.localPosition
			end

			local var_63_5 = 0.88190633667012

			if 0.46809366332988 <= arg_60_1.time_ and arg_60_1.time_ < 0.46809366332988 + var_63_5 then
				local var_63_6, var_63_7 = math.modf((arg_60_1.time_ - 0.46809366332988) / 0.066)

				var_63_4.localPosition = Vector3.New(var_63_7 * 0.13, var_63_7 * 0.13, var_63_7 * 0.13) + arg_60_1.var_.shakeOldPos
			end

			if arg_60_1.time_ >= 0.46809366332988 + var_63_5 and arg_60_1.time_ < 0.46809366332988 + var_63_5 + arg_63_0 then
				var_63_4.localPosition = arg_60_1.var_.shakeOldPos
			end

			local var_63_8 = 0.118093663329879

			if 0.118093663329879 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.var_.shakeOldPos = var_63_4.localPosition
			end

			local var_63_9 = 1.23190633667012

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_9 then
				local var_63_10, var_63_11 = math.modf((arg_60_1.time_ - var_63_8) / 0.066)

				var_63_4.localPosition = Vector3.New(var_63_11 * 0.13, var_63_11 * 0.13, var_63_11 * 0.13) + arg_60_1.var_.shakeOldPos
			end

			if arg_60_1.time_ >= var_63_8 + var_63_9 and arg_60_1.time_ < var_63_8 + var_63_9 + arg_63_0 then
				var_63_4.localPosition = arg_60_1.var_.shakeOldPos
			end

			local var_63_12 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_12 + 1.8 and arg_60_1.time_ < var_63_12 + 1.8 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_13 = 0
			local var_63_14 = 1.35

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(421081014).content)

				arg_60_1.text_.text = var_63_15

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 54 <= 0 and var_63_14 or var_63_14 * (utf8.len(var_63_15) / 54)

				if (54 <= 0 and var_63_14 or var_63_14 * (utf8.len(var_63_15) / 54)) > 0 and var_63_14 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_13 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_13
					end
				end

				arg_60_1.text_.text = var_63_15
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_18 = math.max(var_63_14, arg_60_1.talkMaxDuration)

			if var_63_13 <= arg_60_1.time_ and arg_60_1.time_ < var_63_13 + var_63_18 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_13) / var_63_18

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_13 + var_63_18 and arg_60_1.time_ < var_63_13 + var_63_18 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play421081015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 421081015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play421081016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 1.725

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(421081015).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 69 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 69)

				if (69 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 69)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play421081016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 421081016
		arg_68_1.duration_ = 6.37

		local var_68_0 = {
			zh = 6.366,
			ja = 3.4
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
				arg_68_0:Play421081017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.225

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1322].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_68_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_71_1 = arg_68_1:GetWordFromCfg(421081016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 9 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 9)

				if (9 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 9)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081016", "story_v_out_421081.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081016", "story_v_out_421081.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_421081", "421081016", "story_v_out_421081.awb")

						arg_68_1:RecordAudio("421081016", var_71_6)
						arg_68_1:RecordAudio("421081016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_421081", "421081016", "story_v_out_421081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_421081", "421081016", "story_v_out_421081.awb")
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
	Play421081017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 421081017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play421081018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0.866666666666667 < arg_72_1.time_ and arg_72_1.time_ <= 0.866666666666667 + arg_75_0 then
				local var_75_0 = arg_72_1.var_.effect10187

				if not arg_72_1.var_.effect10187 then
					var_75_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_75_0.name = "10187"
					arg_72_1.var_.effect10187 = var_75_0
				else
					var_75_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_75_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_75_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.8 < arg_72_1.time_ and arg_72_1.time_ <= 1.8 + arg_75_0 then
				if arg_72_1.var_.effect10187 then
					Object.Destroy(arg_72_1.var_.effect10187)

					arg_72_1.var_.effect10187 = nil
				end
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:AudioAction("play", "effect", "se_story_143", "se_story_143_chain", "")
			end

			local var_75_4 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_4 + 1.23333333333333 and arg_72_1.time_ < var_75_4 + 1.23333333333333 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_5 = 0
			local var_75_6 = 1.1

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_7 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(421081017).content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 44 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_7) / 44)

				if (44 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_7) / 44)) > 0 and var_75_6 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_5 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_5
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_6, arg_72_1.talkMaxDuration)

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_5) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_5 + var_75_10 and arg_72_1.time_ < var_75_5 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play421081018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 421081018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play421081019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.275

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

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(421081018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 11 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 11)

				if (11 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 11)) > 0 and var_79_0 < var_79_3 then
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
	Play421081019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 421081019
		arg_80_1.duration_ = 13.83

		local var_80_0 = {
			zh = 12.665999999999,
			ja = 13.832999999999
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
				arg_80_0:Play421081020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if arg_80_1.bgs_.ST34a == nil then
				local var_83_0 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST34a")
				var_83_0.name = "ST34a"
				var_83_0.transform.parent = arg_80_1.stage_.transform
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_.ST34a = var_83_0
			end

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= 2 + arg_83_0 then
				local var_83_1 = arg_80_1.bgs_.ST34a

				arg_80_1.bgs_.ST34a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_83_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_2 = var_83_1:GetComponent("SpriteRenderer")

				if var_83_2 and var_83_2.sprite then
					local var_83_3 = 2 * (var_83_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_83_1.transform.localScale = Vector3.New(var_83_3 / var_83_2.sprite.bounds.size.y < var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x and var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x or var_83_3 / var_83_2.sprite.bounds.size.y, var_83_3 / var_83_2.sprite.bounds.size.y < var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x and var_83_3 * manager.ui.mainCameraCom_.aspect / var_83_2.sprite.bounds.size.x or var_83_3 / var_83_2.sprite.bounds.size.y, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "ST34a" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_4 = 4

			if 4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_4 + 0.3 and arg_80_1.time_ < var_83_4 + 0.3 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_5 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_6 = 2

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 then
				local var_83_7 = Color.New(0, 0, 0)

				var_83_7.a = Mathf.Lerp(0, 1, (arg_80_1.time_ - var_83_5) / var_83_6)
				arg_80_1.mask_.color = var_83_7
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 then
				local var_83_8 = Color.New(0, 0, 0)

				var_83_8.a = 1
				arg_80_1.mask_.color = var_83_8
			end

			local var_83_9 = 2

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_10 = 2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 then
				local var_83_11 = Color.New(0, 0, 0)

				var_83_11.a = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_9) / var_83_10)
				arg_80_1.mask_.color = var_83_11
			end

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 then
				local var_83_12 = Color.New(0, 0, 0)

				arg_80_1.mask_.enabled = false
				var_83_12.a = 0
				arg_80_1.mask_.color = var_83_12
			end

			local var_83_13 = "10145ui_story"

			if arg_80_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_83_14 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_80_1.stage_.transform)

				var_83_14.name = var_83_13
				var_83_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_[var_83_13] = var_83_14

				local var_83_15 = var_83_14:GetComponentInChildren(typeof(CharacterEffect))

				var_83_15.enabled = true

				local var_83_16 = GameObjectTools.GetOrAddComponent(var_83_14, typeof(DynamicBoneHelper))

				if var_83_16 then
					var_83_16:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_15.transform, false)

				arg_80_1.var_[var_83_13 .. "Animator"] = var_83_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_[var_83_13 .. "Animator"].applyRootMotion = true
				arg_80_1.var_[var_83_13 .. "LipSync"] = var_83_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_17 = arg_80_1.actors_["10145ui_story"].transform

			if 3.83333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 3.83333333333333 + arg_83_0 then
				arg_80_1.var_.moveOldPos10145ui_story = var_83_17.localPosition
			end

			local var_83_18 = 0.001

			if 3.83333333333333 <= arg_80_1.time_ and arg_80_1.time_ < 3.83333333333333 + var_83_18 then
				var_83_17.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_80_1.time_ - 3.83333333333333) / var_83_18)
				var_83_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_17.position).x, (manager.ui.mainCamera.transform.position - var_83_17.position).y, (manager.ui.mainCamera.transform.position - var_83_17.position).z)
				var_83_17.localEulerAngles.z = 0
				var_83_17.localEulerAngles.x = 0
				var_83_17.localEulerAngles = var_83_17.localEulerAngles
			end

			if arg_80_1.time_ >= 3.83333333333333 + var_83_18 and arg_80_1.time_ < 3.83333333333333 + var_83_18 + arg_83_0 then
				var_83_17.localPosition = Vector3.New(0, -1, -6.2)
				var_83_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_17.position).x, (manager.ui.mainCamera.transform.position - var_83_17.position).y, (manager.ui.mainCamera.transform.position - var_83_17.position).z)
				var_83_17.localEulerAngles.z = 0
				var_83_17.localEulerAngles.x = 0
				var_83_17.localEulerAngles = var_83_17.localEulerAngles
			end

			local var_83_19 = arg_80_1.actors_["10145ui_story"]

			if 3.83333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 3.83333333333333 + arg_83_0 and not isNil(var_83_19) and arg_80_1.var_.characterEffect10145ui_story == nil then
				arg_80_1.var_.characterEffect10145ui_story = var_83_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_20 = 0.200000002980232

			if 3.83333333333333 <= arg_80_1.time_ and arg_80_1.time_ < 3.83333333333333 + var_83_20 and not isNil(var_83_19) then
				if arg_80_1.var_.characterEffect10145ui_story and not isNil(var_83_19) then
					arg_80_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 3.83333333333333 + var_83_20 and arg_80_1.time_ < 3.83333333333333 + var_83_20 + arg_83_0 and not isNil(var_83_19) and arg_80_1.var_.characterEffect10145ui_story then
				arg_80_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 3.83333333333333 + arg_83_0 then
				arg_80_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 3.83333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 3.83333333333333 + arg_83_0 then
				arg_80_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_83_22

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= 2 + arg_83_0 then
				local var_83_23 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_83_23 then
					var_83_23.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_83_23.radialBlurScale = 0
					var_83_23.radialBlurGradient = 1
					var_83_23.radialBlurIntensity = 1

					if var_83_22 then
						var_83_23.radialBlurTarget = var_83_22.transform
					end
				end
			end

			local var_83_24 = 0.0166666666666667

			if 2 <= arg_80_1.time_ and arg_80_1.time_ < 2 + var_83_24 then
				local var_83_25 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_83_25 then
					var_83_25.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_83_25.radialBlurScale = Mathf.Lerp(0, 0, (arg_80_1.time_ - 2) / var_83_24)
					var_83_25.radialBlurGradient = Mathf.Lerp(1, 1, (arg_80_1.time_ - 2) / var_83_24)
					var_83_25.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_80_1.time_ - 2) / var_83_24)
				end
			end

			if arg_80_1.time_ >= 2 + var_83_24 and arg_80_1.time_ < 2 + var_83_24 + arg_83_0 then
				local var_83_26 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_83_26 then
					var_83_26.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_83_26.radialBlurScale = 0
					var_83_26.radialBlurGradient = 1
					var_83_26.radialBlurIntensity = 1
				end
			end

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= 2 + arg_83_0 then
				if arg_80_1.var_.effect1015 then
					Object.Destroy(arg_80_1.var_.effect1015)

					arg_80_1.var_.effect1015 = nil
				end
			end

			local var_83_28 = 2

			arg_80_1.isInRecall_ = false

			if var_83_28 < arg_80_1.time_ and arg_80_1.time_ <= var_83_28 + arg_83_0 then
				arg_80_1.screenFilterGo_:SetActive(false)

				for iter_83_2, iter_83_3 in pairs(arg_80_1.actors_) do
					for iter_83_4, iter_83_5 in ipairs((iter_83_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_83_5.color = iter_83_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_83_29 = 0.0166666666666667

			if var_83_28 <= arg_80_1.time_ and arg_80_1.time_ < var_83_28 + var_83_29 then
				arg_80_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_28) / var_83_29)
			end

			if arg_80_1.time_ >= var_83_28 + var_83_29 and arg_80_1.time_ < var_83_28 + var_83_29 + arg_83_0 then
				arg_80_1.screenFilterEffect_.weight = 0
			end

			if 0.1 < arg_80_1.time_ and arg_80_1.time_ <= 0.1 + arg_83_0 then
				arg_80_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if 1.6 < arg_80_1.time_ and arg_80_1.time_ <= 1.6 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_lift", "")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_83_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_34 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_34

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_34
						arg_80_1.bgmTxt2_.text = var_83_34
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_80_1.time_ and arg_80_1.time_ <= 0.4 + arg_83_0 then
				arg_80_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_83_37 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_37 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_37

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_37
						arg_80_1.bgmTxt2_.text = var_83_37
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_38 = 3.999999999999
			local var_83_39 = 1.025

			if 3.999999999999 < arg_80_1.time_ and arg_80_1.time_ <= var_83_38 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_40 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_40:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_80_1.dialogCg_.alpha = arg_86_0
				end))
				var_83_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_41 = arg_80_1:GetWordFromCfg(421081019)
				local var_83_42 = arg_80_1:FormatText(var_83_41.content)

				arg_80_1.text_.text = var_83_42

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_44 = 41 <= 0 and var_83_39 or var_83_39 * (utf8.len(var_83_42) / 41)

				if (41 <= 0 and var_83_39 or var_83_39 * (utf8.len(var_83_42) / 41)) > 0 and var_83_39 < var_83_44 then
					arg_80_1.talkMaxDuration = var_83_44
					var_83_38 = var_83_38 + 0.3

					if var_83_44 + var_83_38 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_44 + var_83_38
					end
				end

				arg_80_1.text_.text = var_83_42
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081019", "story_v_out_421081.awb") ~= 0 then
					local var_83_45 = manager.audio:GetVoiceLength("story_v_out_421081", "421081019", "story_v_out_421081.awb") / 1000

					if var_83_45 + var_83_38 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_45 + var_83_38
					end

					if var_83_41.prefab_name ~= "" and arg_80_1.actors_[var_83_41.prefab_name] ~= nil then
						local var_83_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_41.prefab_name].transform, "story_v_out_421081", "421081019", "story_v_out_421081.awb")

						arg_80_1:RecordAudio("421081019", var_83_46)
						arg_80_1:RecordAudio("421081019", var_83_46)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_421081", "421081019", "story_v_out_421081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_421081", "421081019", "story_v_out_421081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_47 = var_83_38 + 0.3
			local var_83_48 = math.max(var_83_39, arg_80_1.talkMaxDuration)

			if var_83_38 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_47 + var_83_48 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_47) / var_83_48

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_47 + var_83_48 and arg_80_1.time_ < var_83_47 + var_83_48 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play421081020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 421081020
		arg_88_1.duration_ = 9.4

		local var_88_0 = {
			zh = 7.7,
			ja = 9.4
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
				arg_88_0:Play421081021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_91_0 = 0
			local var_91_1 = 0.85

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(421081020)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 34 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 34)

				if (34 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 34)) > 0 and var_91_1 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081020", "story_v_out_421081.awb") ~= 0 then
					local var_91_6 = manager.audio:GetVoiceLength("story_v_out_421081", "421081020", "story_v_out_421081.awb") / 1000

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end

					if var_91_2.prefab_name ~= "" and arg_88_1.actors_[var_91_2.prefab_name] ~= nil then
						local var_91_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_2.prefab_name].transform, "story_v_out_421081", "421081020", "story_v_out_421081.awb")

						arg_88_1:RecordAudio("421081020", var_91_7)
						arg_88_1:RecordAudio("421081020", var_91_7)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_421081", "421081020", "story_v_out_421081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_421081", "421081020", "story_v_out_421081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play421081021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 421081021
		arg_92_1.duration_ = 4.33

		local var_92_0 = {
			zh = 3.933,
			ja = 4.333
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
				arg_92_0:Play421081022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_95_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_92_1.stage_.transform)

				var_95_0.name = "1047ui_story"
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1047ui_story"] = var_95_0

				local var_95_1 = var_95_0:GetComponentInChildren(typeof(CharacterEffect))

				var_95_1.enabled = true

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(var_95_1.transform, false)

				arg_92_1.var_["1047ui_story" .. "Animator"] = var_95_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_92_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_92_1.var_["1047ui_story" .. "LipSync"] = var_95_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_95_3 = arg_92_1.actors_["1047ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1047ui_story = var_95_3.localPosition
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_92_1.time_ - 0) / var_95_4)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0.74, -1.13, -6.2)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			local var_95_5 = arg_92_1.actors_["10145ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10145ui_story = var_95_5.localPosition
			end

			local var_95_6 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 then
				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_92_1.time_ - 0) / var_95_6)
				var_95_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_5.position).x, (manager.ui.mainCamera.transform.position - var_95_5.position).y, (manager.ui.mainCamera.transform.position - var_95_5.position).z)
				var_95_5.localEulerAngles.z = 0
				var_95_5.localEulerAngles.x = 0
				var_95_5.localEulerAngles = var_95_5.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_95_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_5.position).x, (manager.ui.mainCamera.transform.position - var_95_5.position).y, (manager.ui.mainCamera.transform.position - var_95_5.position).z)
				var_95_5.localEulerAngles.z = 0
				var_95_5.localEulerAngles.x = 0
				var_95_5.localEulerAngles = var_95_5.localEulerAngles
			end

			local var_95_7 = arg_92_1.actors_["1047ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_7) and arg_92_1.var_.characterEffect1047ui_story == nil then
				arg_92_1.var_.characterEffect1047ui_story = var_95_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_8 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_8 and not isNil(var_95_7) then
				if arg_92_1.var_.characterEffect1047ui_story and not isNil(var_95_7) then
					arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_8 and arg_92_1.time_ < 0 + var_95_8 + arg_95_0 and not isNil(var_95_7) and arg_92_1.var_.characterEffect1047ui_story then
				arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_95_10 = arg_92_1.actors_["10145ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_10) and arg_92_1.var_.characterEffect10145ui_story == nil then
				arg_92_1.var_.characterEffect10145ui_story = var_95_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_11 and not isNil(var_95_10) then
				if arg_92_1.var_.characterEffect10145ui_story and not isNil(var_95_10) then
					arg_92_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_11)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_11 and arg_92_1.time_ < 0 + var_95_11 + arg_95_0 and not isNil(var_95_10) and arg_92_1.var_.characterEffect10145ui_story then
				arg_92_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_95_12 = 0
			local var_95_13 = 0.4

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_14 = arg_92_1:GetWordFromCfg(421081021)
				local var_95_15 = arg_92_1:FormatText(var_95_14.content)

				arg_92_1.text_.text = var_95_15

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_17 = 16 <= 0 and var_95_13 or var_95_13 * (utf8.len(var_95_15) / 16)

				if (16 <= 0 and var_95_13 or var_95_13 * (utf8.len(var_95_15) / 16)) > 0 and var_95_13 < var_95_17 then
					arg_92_1.talkMaxDuration = var_95_17

					if var_95_17 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_17 + var_95_12
					end
				end

				arg_92_1.text_.text = var_95_15
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081021", "story_v_out_421081.awb") ~= 0 then
					local var_95_18 = manager.audio:GetVoiceLength("story_v_out_421081", "421081021", "story_v_out_421081.awb") / 1000

					if var_95_18 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_12
					end

					if var_95_14.prefab_name ~= "" and arg_92_1.actors_[var_95_14.prefab_name] ~= nil then
						local var_95_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_14.prefab_name].transform, "story_v_out_421081", "421081021", "story_v_out_421081.awb")

						arg_92_1:RecordAudio("421081021", var_95_19)
						arg_92_1:RecordAudio("421081021", var_95_19)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_421081", "421081021", "story_v_out_421081.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_421081", "421081021", "story_v_out_421081.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_20 = math.max(var_95_13, arg_92_1.talkMaxDuration)

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_20 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_12) / var_95_20

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_12 + var_95_20 and arg_92_1.time_ < var_95_12 + var_95_20 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421081022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 421081022
		arg_96_1.duration_ = 3.97

		local var_96_0 = {
			zh = 1.999999999999,
			ja = 3.966
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
				arg_96_0:Play421081023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10145ui_story = arg_96_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10145ui_story"].transform.position).z)
				arg_96_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10145ui_story"].transform.localEulerAngles = arg_96_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_96_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10145ui_story"].transform.position).z)
				arg_96_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10145ui_story"].transform.localEulerAngles = arg_96_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["10145ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect10145ui_story == nil then
				arg_96_1.var_.characterEffect10145ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect10145ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect10145ui_story then
				arg_96_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1047ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1047ui_story == nil then
				arg_96_1.var_.characterEffect1047ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_5 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_5 and not isNil(var_99_4) then
				if arg_96_1.var_.characterEffect1047ui_story and not isNil(var_99_4) then
					arg_96_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_5)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_5 and arg_96_1.time_ < 0 + var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1047ui_story then
				arg_96_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			local var_99_6 = 0
			local var_99_7 = 0.275

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(421081022)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 11 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_9) / 11)

				if (11 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_9) / 11)) > 0 and var_99_7 < var_99_11 then
					arg_96_1.talkMaxDuration = var_99_11

					if var_99_11 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081022", "story_v_out_421081.awb") ~= 0 then
					local var_99_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081022", "story_v_out_421081.awb") / 1000

					if var_99_12 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_6
					end

					if var_99_8.prefab_name ~= "" and arg_96_1.actors_[var_99_8.prefab_name] ~= nil then
						local var_99_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_8.prefab_name].transform, "story_v_out_421081", "421081022", "story_v_out_421081.awb")

						arg_96_1:RecordAudio("421081022", var_99_13)
						arg_96_1:RecordAudio("421081022", var_99_13)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_421081", "421081022", "story_v_out_421081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_421081", "421081022", "story_v_out_421081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421081023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 421081023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play421081024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10145ui_story = arg_100_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10145ui_story"].transform.position).z)
				arg_100_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["10145ui_story"].transform.localEulerAngles = arg_100_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10145ui_story"].transform.position).z)
				arg_100_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["10145ui_story"].transform.localEulerAngles = arg_100_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1047ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1047ui_story = var_103_1.localPosition
			end

			local var_103_2 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 then
				var_103_1.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_2)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 then
				var_103_1.localPosition = Vector3.New(0, 100, 0)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			local var_103_3 = 0
			local var_103_4 = 0.475

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(421081023).content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 19 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 19)

				if (19 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 19)) > 0 and var_103_4 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_8 and arg_100_1.time_ < var_103_3 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 421081024
		arg_104_1.duration_ = 9

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play421081025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if arg_104_1.bgs_.I11i == nil then
				local var_107_0 = Object.Instantiate(arg_104_1.paintGo_)

				var_107_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11i")
				var_107_0.name = "I11i"
				var_107_0.transform.parent = arg_104_1.stage_.transform
				var_107_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.bgs_.I11i = var_107_0
			end

			if 2 < arg_104_1.time_ and arg_104_1.time_ <= 2 + arg_107_0 then
				local var_107_1 = arg_104_1.bgs_.I11i

				arg_104_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_107_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_2 = var_107_1:GetComponent("SpriteRenderer")

				if var_107_2 and var_107_2.sprite then
					local var_107_3 = 2 * (var_107_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_107_1.transform.localScale = Vector3.New(var_107_3 / var_107_2.sprite.bounds.size.y < var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x and var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x or var_107_3 / var_107_2.sprite.bounds.size.y, var_107_3 / var_107_2.sprite.bounds.size.y < var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x and var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x or var_107_3 / var_107_2.sprite.bounds.size.y, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "I11i" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_107_4 = 4

			if 4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.allBtn_.enabled = false
			end

			if arg_104_1.time_ >= var_107_4 + 0.3 and arg_104_1.time_ < var_107_4 + 0.3 + arg_107_0 then
				arg_104_1.allBtn_.enabled = true
			end

			local var_107_5 = 0

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_6 = 2

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 then
				local var_107_7 = Color.New(0, 0, 0)

				var_107_7.a = Mathf.Lerp(0, 1, (arg_104_1.time_ - var_107_5) / var_107_6)
				arg_104_1.mask_.color = var_107_7
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 then
				local var_107_8 = Color.New(0, 0, 0)

				var_107_8.a = 1
				arg_104_1.mask_.color = var_107_8
			end

			local var_107_9 = 2

			if 2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_10 = 2

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 then
				local var_107_11 = Color.New(0, 0, 0)

				var_107_11.a = Mathf.Lerp(1, 0, (arg_104_1.time_ - var_107_9) / var_107_10)
				arg_104_1.mask_.color = var_107_11
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 then
				local var_107_12 = Color.New(0, 0, 0)

				arg_104_1.mask_.enabled = false
				var_107_12.a = 0
				arg_104_1.mask_.color = var_107_12
			end

			local var_107_13 = 2

			arg_104_1.isInRecall_ = false

			if var_107_13 < arg_104_1.time_ and arg_104_1.time_ <= var_107_13 + arg_107_0 then
				arg_104_1.screenFilterGo_:SetActive(true)

				arg_104_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_107_2, iter_107_3 in pairs(arg_104_1.actors_) do
					for iter_107_4, iter_107_5 in ipairs((iter_107_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_107_5.color = iter_107_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_107_14 = 0.2

			if var_107_13 <= arg_104_1.time_ and arg_104_1.time_ < var_107_13 + var_107_14 then
				arg_104_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_104_1.time_ - var_107_13) / var_107_14)
			end

			if arg_104_1.time_ >= var_107_13 + var_107_14 and arg_104_1.time_ < var_107_13 + var_107_14 + arg_107_0 then
				arg_104_1.screenFilterEffect_.weight = 1
			end

			if 0.1 < arg_104_1.time_ and arg_104_1.time_ <= 0.1 + arg_107_0 then
				arg_104_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_lift", "")
			end

			if 1.6 < arg_104_1.time_ and arg_104_1.time_ <= 1.6 + arg_107_0 then
				arg_104_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_17 = 4
			local var_107_18 = 0.35

			if 4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_19 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_19:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_104_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_107_20 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(421081024).content)

				arg_104_1.text_.text = var_107_20

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_22 = 14 <= 0 and var_107_18 or var_107_18 * (utf8.len(var_107_20) / 14)

				if (14 <= 0 and var_107_18 or var_107_18 * (utf8.len(var_107_20) / 14)) > 0 and var_107_18 < var_107_22 then
					arg_104_1.talkMaxDuration = var_107_22
					var_107_17 = var_107_17 + 0.3

					if var_107_22 + var_107_17 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_17
					end
				end

				arg_104_1.text_.text = var_107_20
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_23 = var_107_17 + 0.3
			local var_107_24 = math.max(var_107_18, arg_104_1.talkMaxDuration)

			if var_107_17 + 0.3 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_24 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_23) / var_107_24

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_23 + var_107_24 and arg_104_1.time_ < var_107_23 + var_107_24 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play421081025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 421081025
		arg_110_1.duration_ = 12.3

		local var_110_0 = {
			zh = 11.133,
			ja = 12.3
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
				arg_110_0:Play421081026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_0 = arg_110_1.bgs_.ST34a

				arg_110_1.bgs_.ST34a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_1 = var_113_0:GetComponent("SpriteRenderer")

				if var_113_1 and var_113_1.sprite then
					local var_113_2 = 2 * (var_113_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_0.transform.localScale = Vector3.New(var_113_2 / var_113_1.sprite.bounds.size.y < var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x and var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x or var_113_2 / var_113_1.sprite.bounds.size.y, var_113_2 / var_113_1.sprite.bounds.size.y < var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x and var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x or var_113_2 / var_113_1.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "ST34a" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_3 = 4

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_3 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_3 + 0.3 and arg_110_1.time_ < var_113_3 + 0.3 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_4 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_5 = 2

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_5 then
				local var_113_6 = Color.New(0, 0, 0)

				var_113_6.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_4) / var_113_5)
				arg_110_1.mask_.color = var_113_6
			end

			if arg_110_1.time_ >= var_113_4 + var_113_5 and arg_110_1.time_ < var_113_4 + var_113_5 + arg_113_0 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = 1
				arg_110_1.mask_.color = var_113_7
			end

			local var_113_8 = 2

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_9 = 2

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_9 then
				local var_113_10 = Color.New(0, 0, 0)

				var_113_10.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_8) / var_113_9)
				arg_110_1.mask_.color = var_113_10
			end

			if arg_110_1.time_ >= var_113_8 + var_113_9 and arg_110_1.time_ < var_113_8 + var_113_9 + arg_113_0 then
				local var_113_11 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_11.a = 0
				arg_110_1.mask_.color = var_113_11
			end

			local var_113_12 = arg_110_1.actors_["1047ui_story"].transform

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 then
				arg_110_1.var_.moveOldPos1047ui_story = var_113_12.localPosition

				arg_110_1:ShowWeapon(arg_110_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_113_13 = 0.001

			if 3.8 <= arg_110_1.time_ and arg_110_1.time_ < 3.8 + var_113_13 then
				var_113_12.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_110_1.time_ - 3.8) / var_113_13)
				var_113_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_12.position).x, (manager.ui.mainCamera.transform.position - var_113_12.position).y, (manager.ui.mainCamera.transform.position - var_113_12.position).z)
				var_113_12.localEulerAngles.z = 0
				var_113_12.localEulerAngles.x = 0
				var_113_12.localEulerAngles = var_113_12.localEulerAngles
			end

			if arg_110_1.time_ >= 3.8 + var_113_13 and arg_110_1.time_ < 3.8 + var_113_13 + arg_113_0 then
				var_113_12.localPosition = Vector3.New(0, -1.13, -6.2)
				var_113_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_12.position).x, (manager.ui.mainCamera.transform.position - var_113_12.position).y, (manager.ui.mainCamera.transform.position - var_113_12.position).z)
				var_113_12.localEulerAngles.z = 0
				var_113_12.localEulerAngles.x = 0
				var_113_12.localEulerAngles = var_113_12.localEulerAngles
			end

			local var_113_14 = arg_110_1.actors_["1047ui_story"]

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 and not isNil(var_113_14) and arg_110_1.var_.characterEffect1047ui_story == nil then
				arg_110_1.var_.characterEffect1047ui_story = var_113_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_15 = 0.200000002980232

			if 3.8 <= arg_110_1.time_ and arg_110_1.time_ < 3.8 + var_113_15 and not isNil(var_113_14) then
				if arg_110_1.var_.characterEffect1047ui_story and not isNil(var_113_14) then
					arg_110_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 3.8 + var_113_15 and arg_110_1.time_ < 3.8 + var_113_15 + arg_113_0 and not isNil(var_113_14) and arg_110_1.var_.characterEffect1047ui_story then
				arg_110_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 then
				arg_110_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 then
				arg_110_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_113_17 = 2

			arg_110_1.isInRecall_ = false

			if var_113_17 < arg_110_1.time_ and arg_110_1.time_ <= var_113_17 + arg_113_0 then
				arg_110_1.screenFilterGo_:SetActive(false)

				for iter_113_2, iter_113_3 in pairs(arg_110_1.actors_) do
					for iter_113_4, iter_113_5 in ipairs((iter_113_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_113_5.color = iter_113_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_113_18 = 0.0166666666666666

			if var_113_17 <= arg_110_1.time_ and arg_110_1.time_ < var_113_17 + var_113_18 then
				arg_110_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_17) / var_113_18)
			end

			if arg_110_1.time_ >= var_113_17 + var_113_18 and arg_110_1.time_ < var_113_17 + var_113_18 + arg_113_0 then
				arg_110_1.screenFilterEffect_.weight = 0
			end

			if 0.1 < arg_110_1.time_ and arg_110_1.time_ <= 0.1 + arg_113_0 then
				arg_110_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 1.53333333333333 < arg_110_1.time_ and arg_110_1.time_ <= 1.53333333333333 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_lift", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_21 = 4
			local var_113_22 = 0.65

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_23 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_23:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_24 = arg_110_1:GetWordFromCfg(421081025)
				local var_113_25 = arg_110_1:FormatText(var_113_24.content)

				arg_110_1.text_.text = var_113_25

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_27 = 26 <= 0 and var_113_22 or var_113_22 * (utf8.len(var_113_25) / 26)

				if (26 <= 0 and var_113_22 or var_113_22 * (utf8.len(var_113_25) / 26)) > 0 and var_113_22 < var_113_27 then
					arg_110_1.talkMaxDuration = var_113_27
					var_113_21 = var_113_21 + 0.3

					if var_113_27 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_27 + var_113_21
					end
				end

				arg_110_1.text_.text = var_113_25
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081025", "story_v_out_421081.awb") ~= 0 then
					local var_113_28 = manager.audio:GetVoiceLength("story_v_out_421081", "421081025", "story_v_out_421081.awb") / 1000

					if var_113_28 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_28 + var_113_21
					end

					if var_113_24.prefab_name ~= "" and arg_110_1.actors_[var_113_24.prefab_name] ~= nil then
						local var_113_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_24.prefab_name].transform, "story_v_out_421081", "421081025", "story_v_out_421081.awb")

						arg_110_1:RecordAudio("421081025", var_113_29)
						arg_110_1:RecordAudio("421081025", var_113_29)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_421081", "421081025", "story_v_out_421081.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_421081", "421081025", "story_v_out_421081.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_30 = var_113_21 + 0.3
			local var_113_31 = math.max(var_113_22, arg_110_1.talkMaxDuration)

			if var_113_21 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_30 + var_113_31 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_30) / var_113_31

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_30 + var_113_31 and arg_110_1.time_ < var_113_30 + var_113_31 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play421081026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 421081026
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play421081027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047ui_story = arg_116_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).z)
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles = arg_116_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).z)
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles = arg_116_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_119_1 = 0
			local var_119_2 = 0.825

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(421081026).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 33 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 33)

				if (33 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 33)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 421081027
		arg_120_1.duration_ = 2

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play421081028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos10145ui_story = arg_120_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10145ui_story"].transform.position).z)
				arg_120_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["10145ui_story"].transform.localEulerAngles = arg_120_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_120_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10145ui_story"].transform.position).z)
				arg_120_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["10145ui_story"].transform.localEulerAngles = arg_120_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["10145ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect10145ui_story == nil then
				arg_120_1.var_.characterEffect10145ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect10145ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect10145ui_story then
				arg_120_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_123_4 = 0
			local var_123_5 = 0.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(421081027)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 4 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 4)

				if (4 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 4)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081027", "story_v_out_421081.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081027", "story_v_out_421081.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_421081", "421081027", "story_v_out_421081.awb")

						arg_120_1:RecordAudio("421081027", var_123_11)
						arg_120_1:RecordAudio("421081027", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_421081", "421081027", "story_v_out_421081.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_421081", "421081027", "story_v_out_421081.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421081028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 421081028
		arg_124_1.duration_ = 9.17

		local var_124_0 = {
			zh = 8.566,
			ja = 9.166
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
				arg_124_0:Play421081029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1047ui_story = arg_124_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1047ui_story"].transform.position).z)
				arg_124_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1047ui_story"].transform.localEulerAngles = arg_124_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_124_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1047ui_story"].transform.position).z)
				arg_124_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1047ui_story"].transform.localEulerAngles = arg_124_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_127_1 = arg_124_1.actors_["1047ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1047ui_story == nil then
				arg_124_1.var_.characterEffect1047ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect1047ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1047ui_story then
				arg_124_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["10145ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect10145ui_story == nil then
				arg_124_1.var_.characterEffect10145ui_story = var_127_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_5 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_5 and not isNil(var_127_4) then
				if arg_124_1.var_.characterEffect10145ui_story and not isNil(var_127_4) then
					arg_124_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_5)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_5 and arg_124_1.time_ < 0 + var_127_5 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect10145ui_story then
				arg_124_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_127_6 = 0
			local var_127_7 = 0.85

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(421081028)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 34 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 34)

				if (34 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 34)) > 0 and var_127_7 < var_127_11 then
					arg_124_1.talkMaxDuration = var_127_11

					if var_127_11 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081028", "story_v_out_421081.awb") ~= 0 then
					local var_127_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081028", "story_v_out_421081.awb") / 1000

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_421081", "421081028", "story_v_out_421081.awb")

						arg_124_1:RecordAudio("421081028", var_127_13)
						arg_124_1:RecordAudio("421081028", var_127_13)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_421081", "421081028", "story_v_out_421081.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_421081", "421081028", "story_v_out_421081.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 421081029
		arg_128_1.duration_ = 11.1

		local var_128_0 = {
			zh = 9.3,
			ja = 11.1
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
				arg_128_0:Play421081030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1047ui_story = arg_128_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).z)
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles = arg_128_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_128_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).z)
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles = arg_128_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_131_1 = 0
			local var_131_2 = 1.05

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(421081029)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_6 = 42 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_4) / 42)

				if (42 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_4) / 42)) > 0 and var_131_2 < var_131_6 then
					arg_128_1.talkMaxDuration = var_131_6

					if var_131_6 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081029", "story_v_out_421081.awb") ~= 0 then
					local var_131_7 = manager.audio:GetVoiceLength("story_v_out_421081", "421081029", "story_v_out_421081.awb") / 1000

					if var_131_7 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_1
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_421081", "421081029", "story_v_out_421081.awb")

						arg_128_1:RecordAudio("421081029", var_131_8)
						arg_128_1:RecordAudio("421081029", var_131_8)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_421081", "421081029", "story_v_out_421081.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_421081", "421081029", "story_v_out_421081.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_9 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_9 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_9

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_9 and arg_128_1.time_ < var_131_1 + var_131_9 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 421081030
		arg_132_1.duration_ = 2

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play421081031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10145ui_story = arg_132_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10145ui_story"].transform.position).z)
				arg_132_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10145ui_story"].transform.localEulerAngles = arg_132_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_132_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10145ui_story"].transform.position).z)
				arg_132_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10145ui_story"].transform.localEulerAngles = arg_132_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["10145ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect10145ui_story == nil then
				arg_132_1.var_.characterEffect10145ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect10145ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect10145ui_story then
				arg_132_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["1047ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1047ui_story == nil then
				arg_132_1.var_.characterEffect1047ui_story = var_135_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_5 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_5 and not isNil(var_135_4) then
				if arg_132_1.var_.characterEffect1047ui_story and not isNil(var_135_4) then
					arg_132_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_5)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_5 and arg_132_1.time_ < 0 + var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1047ui_story then
				arg_132_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_2")
			end

			local var_135_6 = 0
			local var_135_7 = 0.125

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_8 = arg_132_1:GetWordFromCfg(421081030)
				local var_135_9 = arg_132_1:FormatText(var_135_8.content)

				arg_132_1.text_.text = var_135_9

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 5 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 5)

				if (5 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 5)) > 0 and var_135_7 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_9
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081030", "story_v_out_421081.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081030", "story_v_out_421081.awb") / 1000

					if var_135_12 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_6
					end

					if var_135_8.prefab_name ~= "" and arg_132_1.actors_[var_135_8.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_8.prefab_name].transform, "story_v_out_421081", "421081030", "story_v_out_421081.awb")

						arg_132_1:RecordAudio("421081030", var_135_13)
						arg_132_1:RecordAudio("421081030", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_421081", "421081030", "story_v_out_421081.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_421081", "421081030", "story_v_out_421081.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play421081031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 421081031
		arg_136_1.duration_ = 8.03

		local var_136_0 = {
			zh = 6.6,
			ja = 8.033
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
				arg_136_0:Play421081032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1047ui_story = arg_136_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).z)
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles = arg_136_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_136_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).z)
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles = arg_136_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1047ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1047ui_story == nil then
				arg_136_1.var_.characterEffect1047ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect1047ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1047ui_story then
				arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["10145ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect10145ui_story == nil then
				arg_136_1.var_.characterEffect10145ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_5 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 and not isNil(var_139_4) then
				if arg_136_1.var_.characterEffect10145ui_story and not isNil(var_139_4) then
					arg_136_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_5)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect10145ui_story then
				arg_136_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_139_6 = 0
			local var_139_7 = 0.625

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(421081031)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 25 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 25)

				if (25 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 25)) > 0 and var_139_7 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081031", "story_v_out_421081.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081031", "story_v_out_421081.awb") / 1000

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end

					if var_139_8.prefab_name ~= "" and arg_136_1.actors_[var_139_8.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_8.prefab_name].transform, "story_v_out_421081", "421081031", "story_v_out_421081.awb")

						arg_136_1:RecordAudio("421081031", var_139_13)
						arg_136_1:RecordAudio("421081031", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_421081", "421081031", "story_v_out_421081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_421081", "421081031", "story_v_out_421081.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 421081032
		arg_140_1.duration_ = 2

		local var_140_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_140_0:Play421081033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos10145ui_story = arg_140_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10145ui_story"].transform.position).z)
				arg_140_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["10145ui_story"].transform.localEulerAngles = arg_140_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_140_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10145ui_story"].transform.position).z)
				arg_140_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["10145ui_story"].transform.localEulerAngles = arg_140_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["10145ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect10145ui_story == nil then
				arg_140_1.var_.characterEffect10145ui_story = var_143_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 and not isNil(var_143_1) then
				if arg_140_1.var_.characterEffect10145ui_story and not isNil(var_143_1) then
					arg_140_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect10145ui_story then
				arg_140_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["1047ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1047ui_story == nil then
				arg_140_1.var_.characterEffect1047ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_5 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_5 and not isNil(var_143_4) then
				if arg_140_1.var_.characterEffect1047ui_story and not isNil(var_143_4) then
					arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_5)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_5 and arg_140_1.time_ < 0 + var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1047ui_story then
				arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_143_6 = 0
			local var_143_7 = 0.15

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(421081032)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 6 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 6)

				if (6 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 6)) > 0 and var_143_7 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081032", "story_v_out_421081.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081032", "story_v_out_421081.awb") / 1000

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_out_421081", "421081032", "story_v_out_421081.awb")

						arg_140_1:RecordAudio("421081032", var_143_13)
						arg_140_1:RecordAudio("421081032", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_421081", "421081032", "story_v_out_421081.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_421081", "421081032", "story_v_out_421081.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421081033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 421081033
		arg_144_1.duration_ = 11

		local var_144_0 = {
			zh = 6.266,
			ja = 11
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
				arg_144_0:Play421081034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1047ui_story = arg_144_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_147_0 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				arg_144_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1047ui_story"].transform.position).z)
				arg_144_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1047ui_story"].transform.localEulerAngles = arg_144_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				arg_144_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_144_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1047ui_story"].transform.position).z)
				arg_144_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1047ui_story"].transform.localEulerAngles = arg_144_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_147_1 = arg_144_1.actors_["1047ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1047ui_story == nil then
				arg_144_1.var_.characterEffect1047ui_story = var_147_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 and not isNil(var_147_1) then
				if arg_144_1.var_.characterEffect1047ui_story and not isNil(var_147_1) then
					arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1047ui_story then
				arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["10145ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect10145ui_story == nil then
				arg_144_1.var_.characterEffect10145ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_5 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_5 and not isNil(var_147_4) then
				if arg_144_1.var_.characterEffect10145ui_story and not isNil(var_147_4) then
					arg_144_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_144_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_5)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_5 and arg_144_1.time_ < 0 + var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect10145ui_story then
				arg_144_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_144_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			local var_147_6 = 0
			local var_147_7 = 0.75

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_8 = arg_144_1:GetWordFromCfg(421081033)
				local var_147_9 = arg_144_1:FormatText(var_147_8.content)

				arg_144_1.text_.text = var_147_9

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 30 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 30)

				if (30 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 30)) > 0 and var_147_7 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_9
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081033", "story_v_out_421081.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081033", "story_v_out_421081.awb") / 1000

					if var_147_12 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_6
					end

					if var_147_8.prefab_name ~= "" and arg_144_1.actors_[var_147_8.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_8.prefab_name].transform, "story_v_out_421081", "421081033", "story_v_out_421081.awb")

						arg_144_1:RecordAudio("421081033", var_147_13)
						arg_144_1:RecordAudio("421081033", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_421081", "421081033", "story_v_out_421081.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_421081", "421081033", "story_v_out_421081.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_14 and arg_144_1.time_ < var_147_6 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 421081034
		arg_148_1.duration_ = 3.3

		local var_148_0 = {
			zh = 3.3,
			ja = 2.766
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
				arg_148_0:Play421081035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos10145ui_story = arg_148_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10145ui_story"].transform.position).z)
				arg_148_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["10145ui_story"].transform.localEulerAngles = arg_148_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_148_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["10145ui_story"].transform.position).z)
				arg_148_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["10145ui_story"].transform.localEulerAngles = arg_148_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["10145ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect10145ui_story == nil then
				arg_148_1.var_.characterEffect10145ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect10145ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect10145ui_story then
				arg_148_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["1047ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1047ui_story == nil then
				arg_148_1.var_.characterEffect1047ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_5 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 and not isNil(var_151_4) then
				if arg_148_1.var_.characterEffect1047ui_story and not isNil(var_151_4) then
					arg_148_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_5)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1047ui_story then
				arg_148_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_151_6 = 0
			local var_151_7 = 0.25

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_8 = arg_148_1:GetWordFromCfg(421081034)
				local var_151_9 = arg_148_1:FormatText(var_151_8.content)

				arg_148_1.text_.text = var_151_9

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 10 <= 0 and var_151_7 or var_151_7 * (utf8.len(var_151_9) / 10)

				if (10 <= 0 and var_151_7 or var_151_7 * (utf8.len(var_151_9) / 10)) > 0 and var_151_7 < var_151_11 then
					arg_148_1.talkMaxDuration = var_151_11

					if var_151_11 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_9
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081034", "story_v_out_421081.awb") ~= 0 then
					local var_151_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081034", "story_v_out_421081.awb") / 1000

					if var_151_12 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_12 + var_151_6
					end

					if var_151_8.prefab_name ~= "" and arg_148_1.actors_[var_151_8.prefab_name] ~= nil then
						local var_151_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_8.prefab_name].transform, "story_v_out_421081", "421081034", "story_v_out_421081.awb")

						arg_148_1:RecordAudio("421081034", var_151_13)
						arg_148_1:RecordAudio("421081034", var_151_13)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_421081", "421081034", "story_v_out_421081.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_421081", "421081034", "story_v_out_421081.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_14 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_14 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_14

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_14 and arg_148_1.time_ < var_151_6 + var_151_14 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421081035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 421081035
		arg_152_1.duration_ = 5.73

		local var_152_0 = {
			zh = 3.8,
			ja = 5.733
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
				arg_152_0:Play421081036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1047ui_story = arg_152_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1047ui_story"].transform.position).z)
				arg_152_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1047ui_story"].transform.localEulerAngles = arg_152_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_152_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1047ui_story"].transform.position).z)
				arg_152_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1047ui_story"].transform.localEulerAngles = arg_152_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["1047ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1047ui_story == nil then
				arg_152_1.var_.characterEffect1047ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1047ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1047ui_story then
				arg_152_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["10145ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect10145ui_story == nil then
				arg_152_1.var_.characterEffect10145ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_5 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 and not isNil(var_155_4) then
				if arg_152_1.var_.characterEffect10145ui_story and not isNil(var_155_4) then
					arg_152_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_5)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect10145ui_story then
				arg_152_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_155_6 = 0
			local var_155_7 = 0.325

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:GetWordFromCfg(421081035)
				local var_155_9 = arg_152_1:FormatText(var_155_8.content)

				arg_152_1.text_.text = var_155_9

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 13 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 13)

				if (13 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 13)) > 0 and var_155_7 < var_155_11 then
					arg_152_1.talkMaxDuration = var_155_11

					if var_155_11 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_9
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081035", "story_v_out_421081.awb") ~= 0 then
					local var_155_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081035", "story_v_out_421081.awb") / 1000

					if var_155_12 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_6
					end

					if var_155_8.prefab_name ~= "" and arg_152_1.actors_[var_155_8.prefab_name] ~= nil then
						local var_155_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_8.prefab_name].transform, "story_v_out_421081", "421081035", "story_v_out_421081.awb")

						arg_152_1:RecordAudio("421081035", var_155_13)
						arg_152_1:RecordAudio("421081035", var_155_13)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_421081", "421081035", "story_v_out_421081.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_421081", "421081035", "story_v_out_421081.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 421081036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play421081037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10145ui_story = arg_156_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10145ui_story"].transform.position).z)
				arg_156_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10145ui_story"].transform.localEulerAngles = arg_156_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10145ui_story"].transform.position).z)
				arg_156_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10145ui_story"].transform.localEulerAngles = arg_156_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1047ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1047ui_story = var_159_1.localPosition
			end

			local var_159_2 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 then
				var_159_1.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_2)
				var_159_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_1.position).x, (manager.ui.mainCamera.transform.position - var_159_1.position).y, (manager.ui.mainCamera.transform.position - var_159_1.position).z)
				var_159_1.localEulerAngles.z = 0
				var_159_1.localEulerAngles.x = 0
				var_159_1.localEulerAngles = var_159_1.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 then
				var_159_1.localPosition = Vector3.New(0, 100, 0)
				var_159_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_1.position).x, (manager.ui.mainCamera.transform.position - var_159_1.position).y, (manager.ui.mainCamera.transform.position - var_159_1.position).z)
				var_159_1.localEulerAngles.z = 0
				var_159_1.localEulerAngles.x = 0
				var_159_1.localEulerAngles = var_159_1.localEulerAngles
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_143", "se_story_143_elevator_door", "")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_lift", "")
			end

			local var_159_5 = 0
			local var_159_6 = 1.025

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(421081036).content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 41 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 41)

				if (41 <= 0 and var_159_6 or var_159_6 * (utf8.len(var_159_7) / 41)) > 0 and var_159_6 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_10 and arg_156_1.time_ < var_159_5 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 421081037
		arg_160_1.duration_ = 9

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play421081038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.bgs_.I08a == nil then
				local var_163_0 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I08a")
				var_163_0.name = "I08a"
				var_163_0.transform.parent = arg_160_1.stage_.transform
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_.I08a = var_163_0
			end

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_1 = arg_160_1.bgs_.I08a

				arg_160_1.bgs_.I08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_2 = var_163_1:GetComponent("SpriteRenderer")

				if var_163_2 and var_163_2.sprite then
					local var_163_3 = 2 * (var_163_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_1.transform.localScale = Vector3.New(var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "I08a" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_4 = 4

			if 4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_4 + 0.4 and arg_160_1.time_ < var_163_4 + 0.4 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_5 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_6 = 2

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 then
				local var_163_7 = Color.New(0, 0, 0)

				var_163_7.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_5) / var_163_6)
				arg_160_1.mask_.color = var_163_7
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 then
				local var_163_8 = Color.New(0, 0, 0)

				var_163_8.a = 1
				arg_160_1.mask_.color = var_163_8
			end

			local var_163_9 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_10 = 2

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_10 then
				local var_163_11 = Color.New(0, 0, 0)

				var_163_11.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_9) / var_163_10)
				arg_160_1.mask_.color = var_163_11
			end

			if arg_160_1.time_ >= var_163_9 + var_163_10 and arg_160_1.time_ < var_163_9 + var_163_10 + arg_163_0 then
				local var_163_12 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_12.a = 0
				arg_160_1.mask_.color = var_163_12
			end

			if 1.63333333333333 < arg_160_1.time_ and arg_160_1.time_ <= 1.63333333333333 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain_p2", "")
			end

			if 4.03333333333333 < arg_160_1.time_ and arg_160_1.time_ <= 4.03333333333333 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_143", "se_story_143_walk09", "")
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_15 = 4
			local var_163_16 = 0.9

			if 4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_17 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_17:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_18 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(421081037).content)

				arg_160_1.text_.text = var_163_18

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_20 = 36 <= 0 and var_163_16 or var_163_16 * (utf8.len(var_163_18) / 36)

				if (36 <= 0 and var_163_16 or var_163_16 * (utf8.len(var_163_18) / 36)) > 0 and var_163_16 < var_163_20 then
					arg_160_1.talkMaxDuration = var_163_20
					var_163_15 = var_163_15 + 0.3

					if var_163_20 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_20 + var_163_15
					end
				end

				arg_160_1.text_.text = var_163_18
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_21 = var_163_15 + 0.3
			local var_163_22 = math.max(var_163_16, arg_160_1.talkMaxDuration)

			if var_163_15 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_22 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_21) / var_163_22

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_21 + var_163_22 and arg_160_1.time_ < var_163_21 + var_163_22 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play421081038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 421081038
		arg_166_1.duration_ = 4.87

		local var_166_0 = {
			zh = 3.966,
			ja = 4.866
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play421081039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.425

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_1 = arg_166_1:GetWordFromCfg(421081038)
				local var_169_2 = arg_166_1:FormatText(var_169_1.content)

				arg_166_1.text_.text = var_169_2

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 17 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 17)

				if (17 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 17)) > 0 and var_169_0 < var_169_4 then
					arg_166_1.talkMaxDuration = var_169_4

					if var_169_4 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_4 + 0
					end
				end

				arg_166_1.text_.text = var_169_2
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081038", "story_v_out_421081.awb") ~= 0 then
					local var_169_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081038", "story_v_out_421081.awb") / 1000

					if var_169_5 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + 0
					end

					if var_169_1.prefab_name ~= "" and arg_166_1.actors_[var_169_1.prefab_name] ~= nil then
						local var_169_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_1.prefab_name].transform, "story_v_out_421081", "421081038", "story_v_out_421081.awb")

						arg_166_1:RecordAudio("421081038", var_169_6)
						arg_166_1:RecordAudio("421081038", var_169_6)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_421081", "421081038", "story_v_out_421081.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_421081", "421081038", "story_v_out_421081.awb")
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
	Play421081039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 421081039
		arg_170_1.duration_ = 11.37

		local var_170_0 = {
			zh = 8.7,
			ja = 11.366
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
				arg_170_0:Play421081040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.875

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_1 = arg_170_1:GetWordFromCfg(421081039)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 35 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 35)

				if (35 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 35)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081039", "story_v_out_421081.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081039", "story_v_out_421081.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_out_421081", "421081039", "story_v_out_421081.awb")

						arg_170_1:RecordAudio("421081039", var_173_6)
						arg_170_1:RecordAudio("421081039", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_421081", "421081039", "story_v_out_421081.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_421081", "421081039", "story_v_out_421081.awb")
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
	Play421081040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 421081040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play421081041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.775

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(421081040).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 31 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 31)

				if (31 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 31)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play421081041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 421081041
		arg_178_1.duration_ = 8.83

		local var_178_0 = {
			zh = 8.833,
			ja = 8
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
				arg_178_0:Play421081042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if arg_178_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_181_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_178_1.stage_.transform)

				var_181_0.name = "10102ui_story"
				var_181_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.actors_["10102ui_story"] = var_181_0

				local var_181_1 = var_181_0:GetComponentInChildren(typeof(CharacterEffect))

				var_181_1.enabled = true

				local var_181_2 = GameObjectTools.GetOrAddComponent(var_181_0, typeof(DynamicBoneHelper))

				if var_181_2 then
					var_181_2:EnableDynamicBone(false)
				end

				arg_178_1:ShowWeapon(var_181_1.transform, false)

				arg_178_1.var_["10102ui_story" .. "Animator"] = var_181_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_178_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_178_1.var_["10102ui_story" .. "LipSync"] = var_181_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_181_3 = arg_178_1.actors_["10102ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10102ui_story = var_181_3.localPosition
			end

			local var_181_4 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				var_181_3.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_178_1.time_ - 0) / var_181_4)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				var_181_3.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_181_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_3.position).x, (manager.ui.mainCamera.transform.position - var_181_3.position).y, (manager.ui.mainCamera.transform.position - var_181_3.position).z)
				var_181_3.localEulerAngles.z = 0
				var_181_3.localEulerAngles.x = 0
				var_181_3.localEulerAngles = var_181_3.localEulerAngles
			end

			local var_181_5 = arg_178_1.actors_["10102ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.characterEffect10102ui_story == nil then
				arg_178_1.var_.characterEffect10102ui_story = var_181_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_6 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_6 and not isNil(var_181_5) then
				if arg_178_1.var_.characterEffect10102ui_story and not isNil(var_181_5) then
					arg_178_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_6 and arg_178_1.time_ < 0 + var_181_6 + arg_181_0 and not isNil(var_181_5) and arg_178_1.var_.characterEffect10102ui_story then
				arg_178_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_181_8 = 0
			local var_181_9 = 1.125

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_10 = arg_178_1:GetWordFromCfg(421081041)
				local var_181_11 = arg_178_1:FormatText(var_181_10.content)

				arg_178_1.text_.text = var_181_11

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_13 = 45 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 45)

				if (45 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 45)) > 0 and var_181_9 < var_181_13 then
					arg_178_1.talkMaxDuration = var_181_13

					if var_181_13 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_13 + var_181_8
					end
				end

				arg_178_1.text_.text = var_181_11
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081041", "story_v_out_421081.awb") ~= 0 then
					local var_181_14 = manager.audio:GetVoiceLength("story_v_out_421081", "421081041", "story_v_out_421081.awb") / 1000

					if var_181_14 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_8
					end

					if var_181_10.prefab_name ~= "" and arg_178_1.actors_[var_181_10.prefab_name] ~= nil then
						local var_181_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_10.prefab_name].transform, "story_v_out_421081", "421081041", "story_v_out_421081.awb")

						arg_178_1:RecordAudio("421081041", var_181_15)
						arg_178_1:RecordAudio("421081041", var_181_15)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_421081", "421081041", "story_v_out_421081.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_421081", "421081041", "story_v_out_421081.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_16 = math.max(var_181_9, arg_178_1.talkMaxDuration)

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_16 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_8) / var_181_16

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_8 + var_181_16 and arg_178_1.time_ < var_181_8 + var_181_16 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play421081042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 421081042
		arg_182_1.duration_ = 9

		local var_182_0 = {
			zh = 6.233,
			ja = 9
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
				arg_182_0:Play421081043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1047ui_story = arg_182_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).z)
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles = arg_182_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_182_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).z)
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles = arg_182_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1047ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1047ui_story == nil then
				arg_182_1.var_.characterEffect1047ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1047ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1047ui_story then
				arg_182_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_185_4 = arg_182_1.actors_["10102ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect10102ui_story == nil then
				arg_182_1.var_.characterEffect10102ui_story = var_185_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_5 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_5 and not isNil(var_185_4) then
				if arg_182_1.var_.characterEffect10102ui_story and not isNil(var_185_4) then
					arg_182_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_182_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_5)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_5 and arg_182_1.time_ < 0 + var_185_5 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect10102ui_story then
				arg_182_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_182_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_185_6 = 0
			local var_185_7 = 0.75

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_8 = arg_182_1:GetWordFromCfg(421081042)
				local var_185_9 = arg_182_1:FormatText(var_185_8.content)

				arg_182_1.text_.text = var_185_9

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 30 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_9) / 30)

				if (30 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_9) / 30)) > 0 and var_185_7 < var_185_11 then
					arg_182_1.talkMaxDuration = var_185_11

					if var_185_11 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_9
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081042", "story_v_out_421081.awb") ~= 0 then
					local var_185_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081042", "story_v_out_421081.awb") / 1000

					if var_185_12 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_12 + var_185_6
					end

					if var_185_8.prefab_name ~= "" and arg_182_1.actors_[var_185_8.prefab_name] ~= nil then
						local var_185_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_8.prefab_name].transform, "story_v_out_421081", "421081042", "story_v_out_421081.awb")

						arg_182_1:RecordAudio("421081042", var_185_13)
						arg_182_1:RecordAudio("421081042", var_185_13)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_421081", "421081042", "story_v_out_421081.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_421081", "421081042", "story_v_out_421081.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_14 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_14 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_14

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_14 and arg_182_1.time_ < var_185_6 + var_185_14 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play421081043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 421081043
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play421081044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1047ui_story"]) and arg_186_1.var_.characterEffect1047ui_story == nil then
				arg_186_1.var_.characterEffect1047ui_story = arg_186_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1047ui_story"]) then
				if arg_186_1.var_.characterEffect1047ui_story and not isNil(arg_186_1.actors_["1047ui_story"]) then
					arg_186_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1047ui_story"]) and arg_186_1.var_.characterEffect1047ui_story then
				arg_186_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.275

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(421081043).content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 11 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 11)

				if (11 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 11)) > 0 and var_189_2 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_6 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_6 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_6

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_6 and arg_186_1.time_ < var_189_1 + var_189_6 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play421081044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 421081044
		arg_190_1.duration_ = 4.77

		local var_190_0 = {
			zh = 3.433,
			ja = 4.766
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
				arg_190_0:Play421081045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1047ui_story = arg_190_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1047ui_story"].transform.position).z)
				arg_190_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1047ui_story"].transform.localEulerAngles = arg_190_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_190_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1047ui_story"].transform.position).z)
				arg_190_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1047ui_story"].transform.localEulerAngles = arg_190_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1047ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1047ui_story == nil then
				arg_190_1.var_.characterEffect1047ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1047ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1047ui_story then
				arg_190_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_193_4 = 0
			local var_193_5 = 0.425

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(421081044)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 17 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 17)

				if (17 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 17)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081044", "story_v_out_421081.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081044", "story_v_out_421081.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_421081", "421081044", "story_v_out_421081.awb")

						arg_190_1:RecordAudio("421081044", var_193_11)
						arg_190_1:RecordAudio("421081044", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_421081", "421081044", "story_v_out_421081.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_421081", "421081044", "story_v_out_421081.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play421081045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 421081045
		arg_194_1.duration_ = 6.57

		local var_194_0 = {
			zh = 6.566,
			ja = 6.266
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
				arg_194_0:Play421081046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1047ui_story"]) and arg_194_1.var_.characterEffect1047ui_story == nil then
				arg_194_1.var_.characterEffect1047ui_story = arg_194_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1047ui_story"]) then
				if arg_194_1.var_.characterEffect1047ui_story and not isNil(arg_194_1.actors_["1047ui_story"]) then
					arg_194_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1047ui_story"]) and arg_194_1.var_.characterEffect1047ui_story then
				arg_194_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.575

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(421081045)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_6 = 23 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_4) / 23)

				if (23 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_4) / 23)) > 0 and var_197_2 < var_197_6 then
					arg_194_1.talkMaxDuration = var_197_6

					if var_197_6 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_6 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081045", "story_v_out_421081.awb") ~= 0 then
					local var_197_7 = manager.audio:GetVoiceLength("story_v_out_421081", "421081045", "story_v_out_421081.awb") / 1000

					if var_197_7 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_1
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_421081", "421081045", "story_v_out_421081.awb")

						arg_194_1:RecordAudio("421081045", var_197_8)
						arg_194_1:RecordAudio("421081045", var_197_8)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_421081", "421081045", "story_v_out_421081.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_421081", "421081045", "story_v_out_421081.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_9 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_9 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_9

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_9 and arg_194_1.time_ < var_197_1 + var_197_9 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play421081046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 421081046
		arg_198_1.duration_ = 4.97

		local var_198_0 = {
			zh = 3.7,
			ja = 4.966
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
				arg_198_0:Play421081047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1047ui_story = arg_198_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).z)
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles = arg_198_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_198_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).z)
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles = arg_198_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1047ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1047ui_story == nil then
				arg_198_1.var_.characterEffect1047ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect1047ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1047ui_story then
				arg_198_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_201_4 = 0
			local var_201_5 = 0.4

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(421081046)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 16 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 16)

				if (16 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 16)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081046", "story_v_out_421081.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081046", "story_v_out_421081.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_out_421081", "421081046", "story_v_out_421081.awb")

						arg_198_1:RecordAudio("421081046", var_201_11)
						arg_198_1:RecordAudio("421081046", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_421081", "421081046", "story_v_out_421081.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_421081", "421081046", "story_v_out_421081.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play421081047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 421081047
		arg_202_1.duration_ = 5.7

		local var_202_0 = {
			zh = 3.933,
			ja = 5.7
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
				arg_202_0:Play421081048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10102ui_story = arg_202_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10102ui_story"].transform.position).z)
				arg_202_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["10102ui_story"].transform.localEulerAngles = arg_202_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_202_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10102ui_story"].transform.position).z)
				arg_202_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["10102ui_story"].transform.localEulerAngles = arg_202_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["10102ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect10102ui_story == nil then
				arg_202_1.var_.characterEffect10102ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect10102ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect10102ui_story then
				arg_202_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_205_4 = arg_202_1.actors_["1047ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1047ui_story == nil then
				arg_202_1.var_.characterEffect1047ui_story = var_205_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_5 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_5 and not isNil(var_205_4) then
				if arg_202_1.var_.characterEffect1047ui_story and not isNil(var_205_4) then
					arg_202_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_5)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_5 and arg_202_1.time_ < 0 + var_205_5 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect1047ui_story then
				arg_202_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_205_6 = 0
			local var_205_7 = 0.6

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_8 = arg_202_1:GetWordFromCfg(421081047)
				local var_205_9 = arg_202_1:FormatText(var_205_8.content)

				arg_202_1.text_.text = var_205_9

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 24 <= 0 and var_205_7 or var_205_7 * (utf8.len(var_205_9) / 24)

				if (24 <= 0 and var_205_7 or var_205_7 * (utf8.len(var_205_9) / 24)) > 0 and var_205_7 < var_205_11 then
					arg_202_1.talkMaxDuration = var_205_11

					if var_205_11 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_11 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_9
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081047", "story_v_out_421081.awb") ~= 0 then
					local var_205_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081047", "story_v_out_421081.awb") / 1000

					if var_205_12 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_12 + var_205_6
					end

					if var_205_8.prefab_name ~= "" and arg_202_1.actors_[var_205_8.prefab_name] ~= nil then
						local var_205_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_8.prefab_name].transform, "story_v_out_421081", "421081047", "story_v_out_421081.awb")

						arg_202_1:RecordAudio("421081047", var_205_13)
						arg_202_1:RecordAudio("421081047", var_205_13)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_421081", "421081047", "story_v_out_421081.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_421081", "421081047", "story_v_out_421081.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_14 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_14 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_14

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_14 and arg_202_1.time_ < var_205_6 + var_205_14 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play421081048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 421081048
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play421081049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["10102ui_story"]) and arg_206_1.var_.characterEffect10102ui_story == nil then
				arg_206_1.var_.characterEffect10102ui_story = arg_206_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["10102ui_story"]) then
				if arg_206_1.var_.characterEffect10102ui_story and not isNil(arg_206_1.actors_["10102ui_story"]) then
					arg_206_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_206_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_0)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10102ui_story"]) and arg_206_1.var_.characterEffect10102ui_story then
				arg_206_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_206_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_209_1 = 0
			local var_209_2 = 0.2

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(421081048).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 8 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 8)

				if (8 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 8)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play421081049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 421081049
		arg_210_1.duration_ = 9.23

		local var_210_0 = {
			zh = 7.333,
			ja = 9.233
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
				arg_210_0:Play421081050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10102ui_story = arg_210_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10102ui_story"].transform.position).z)
				arg_210_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10102ui_story"].transform.localEulerAngles = arg_210_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_210_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10102ui_story"].transform.position).z)
				arg_210_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10102ui_story"].transform.localEulerAngles = arg_210_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1047ui_story"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1047ui_story = var_213_1.localPosition
			end

			local var_213_2 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 then
				var_213_1.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_2)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 then
				var_213_1.localPosition = Vector3.New(0, 100, 0)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			local var_213_3 = 0
			local var_213_4 = 0.875

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_3 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_5 = arg_210_1:GetWordFromCfg(421081049)
				local var_213_6 = arg_210_1:FormatText(var_213_5.content)

				arg_210_1.text_.text = var_213_6

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_8 = 35 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_6) / 35)

				if (35 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_6) / 35)) > 0 and var_213_4 < var_213_8 then
					arg_210_1.talkMaxDuration = var_213_8

					if var_213_8 + var_213_3 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_3
					end
				end

				arg_210_1.text_.text = var_213_6
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081049", "story_v_out_421081.awb") ~= 0 then
					local var_213_9 = manager.audio:GetVoiceLength("story_v_out_421081", "421081049", "story_v_out_421081.awb") / 1000

					if var_213_9 + var_213_3 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_3
					end

					if var_213_5.prefab_name ~= "" and arg_210_1.actors_[var_213_5.prefab_name] ~= nil then
						local var_213_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_5.prefab_name].transform, "story_v_out_421081", "421081049", "story_v_out_421081.awb")

						arg_210_1:RecordAudio("421081049", var_213_10)
						arg_210_1:RecordAudio("421081049", var_213_10)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_421081", "421081049", "story_v_out_421081.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_421081", "421081049", "story_v_out_421081.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_11 = math.max(var_213_4, arg_210_1.talkMaxDuration)

			if var_213_3 <= arg_210_1.time_ and arg_210_1.time_ < var_213_3 + var_213_11 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_3) / var_213_11

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_3 + var_213_11 and arg_210_1.time_ < var_213_3 + var_213_11 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 421081050
		arg_214_1.duration_ = 6.5

		local var_214_0 = {
			zh = 5.466,
			ja = 6.5
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
				arg_214_0:Play421081051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.525

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(421081050)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 21 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 21)

				if (21 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 21)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081050", "story_v_out_421081.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081050", "story_v_out_421081.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_421081", "421081050", "story_v_out_421081.awb")

						arg_214_1:RecordAudio("421081050", var_217_6)
						arg_214_1:RecordAudio("421081050", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_421081", "421081050", "story_v_out_421081.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_421081", "421081050", "story_v_out_421081.awb")
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
	Play421081051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 421081051
		arg_218_1.duration_ = 5.13

		local var_218_0 = {
			zh = 4.366,
			ja = 5.133
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
				arg_218_0:Play421081052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.425

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:GetWordFromCfg(421081051)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 17 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 17)

				if (17 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 17)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081051", "story_v_out_421081.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081051", "story_v_out_421081.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_421081", "421081051", "story_v_out_421081.awb")

						arg_218_1:RecordAudio("421081051", var_221_6)
						arg_218_1:RecordAudio("421081051", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_421081", "421081051", "story_v_out_421081.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_421081", "421081051", "story_v_out_421081.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play421081052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 421081052
		arg_222_1.duration_ = 9.23

		local var_222_0 = {
			zh = 9.233,
			ja = 8.766
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
				arg_222_0:Play421081053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.85

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:GetWordFromCfg(421081052)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 34 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 34)

				if (34 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 34)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081052", "story_v_out_421081.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081052", "story_v_out_421081.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_421081", "421081052", "story_v_out_421081.awb")

						arg_222_1:RecordAudio("421081052", var_225_6)
						arg_222_1:RecordAudio("421081052", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_421081", "421081052", "story_v_out_421081.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_421081", "421081052", "story_v_out_421081.awb")
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
	Play421081053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 421081053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play421081054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.625

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

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(421081053).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 25 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 25)

				if (25 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 25)) > 0 and var_229_0 < var_229_3 then
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
	Play421081054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 421081054
		arg_230_1.duration_ = 11.53

		local var_230_0 = {
			zh = 9.066,
			ja = 11.533
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
				arg_230_0:Play421081055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.025

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:GetWordFromCfg(421081054)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 41 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 41)

				if (41 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 41)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081054", "story_v_out_421081.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081054", "story_v_out_421081.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_421081", "421081054", "story_v_out_421081.awb")

						arg_230_1:RecordAudio("421081054", var_233_6)
						arg_230_1:RecordAudio("421081054", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_421081", "421081054", "story_v_out_421081.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_421081", "421081054", "story_v_out_421081.awb")
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
	Play421081055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 421081055
		arg_234_1.duration_ = 3.53

		local var_234_0 = {
			zh = 3.533,
			ja = 3.466
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
				arg_234_0:Play421081056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1047ui_story = arg_234_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1047ui_story"].transform.position).z)
				arg_234_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1047ui_story"].transform.localEulerAngles = arg_234_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_234_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1047ui_story"].transform.position).z)
				arg_234_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1047ui_story"].transform.localEulerAngles = arg_234_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1047ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1047ui_story == nil then
				arg_234_1.var_.characterEffect1047ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect1047ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1047ui_story then
				arg_234_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_237_4 = 0
			local var_237_5 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(421081055)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 18 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 18)

				if (18 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 18)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081055", "story_v_out_421081.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081055", "story_v_out_421081.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_out_421081", "421081055", "story_v_out_421081.awb")

						arg_234_1:RecordAudio("421081055", var_237_11)
						arg_234_1:RecordAudio("421081055", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_421081", "421081055", "story_v_out_421081.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_421081", "421081055", "story_v_out_421081.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play421081056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 421081056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play421081057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1047ui_story"]) and arg_238_1.var_.characterEffect1047ui_story == nil then
				arg_238_1.var_.characterEffect1047ui_story = arg_238_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1047ui_story"]) then
				if arg_238_1.var_.characterEffect1047ui_story and not isNil(arg_238_1.actors_["1047ui_story"]) then
					arg_238_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1047ui_story"]) and arg_238_1.var_.characterEffect1047ui_story then
				arg_238_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.15

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(421081056).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 6 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 6)

				if (6 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 6)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play421081057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 421081057
		arg_242_1.duration_ = 5.97

		local var_242_0 = {
			zh = 5.033,
			ja = 5.966
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
				arg_242_0:Play421081058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 1 < arg_242_1.time_ and arg_242_1.time_ <= 1 + arg_245_0 then
				local var_245_0 = arg_242_1.bgs_.I08a

				arg_242_1.bgs_.I08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_1 = var_245_0:GetComponent("SpriteRenderer")

				if var_245_1 and var_245_1.sprite then
					local var_245_2 = 2 * (var_245_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_0.transform.localScale = Vector3.New(var_245_2 / var_245_1.sprite.bounds.size.y < var_245_2 * manager.ui.mainCameraCom_.aspect / var_245_1.sprite.bounds.size.x and var_245_2 * manager.ui.mainCameraCom_.aspect / var_245_1.sprite.bounds.size.x or var_245_2 / var_245_1.sprite.bounds.size.y, var_245_2 / var_245_1.sprite.bounds.size.y < var_245_2 * manager.ui.mainCameraCom_.aspect / var_245_1.sprite.bounds.size.x and var_245_2 * manager.ui.mainCameraCom_.aspect / var_245_1.sprite.bounds.size.x or var_245_2 / var_245_1.sprite.bounds.size.y, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "I08a" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_3 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_3 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_4 = 1

			if var_245_3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_3 + var_245_4 then
				local var_245_5 = Color.New(0, 0, 0)

				var_245_5.a = Mathf.Lerp(0, 1, (arg_242_1.time_ - var_245_3) / var_245_4)
				arg_242_1.mask_.color = var_245_5
			end

			if arg_242_1.time_ >= var_245_3 + var_245_4 and arg_242_1.time_ < var_245_3 + var_245_4 + arg_245_0 then
				local var_245_6 = Color.New(0, 0, 0)

				var_245_6.a = 1
				arg_242_1.mask_.color = var_245_6
			end

			local var_245_7 = 1

			if 1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_7 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_8 = 1

			if var_245_7 <= arg_242_1.time_ and arg_242_1.time_ < var_245_7 + var_245_8 then
				local var_245_9 = Color.New(0, 0, 0)

				var_245_9.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_7) / var_245_8)
				arg_242_1.mask_.color = var_245_9
			end

			if arg_242_1.time_ >= var_245_7 + var_245_8 and arg_242_1.time_ < var_245_7 + var_245_8 + arg_245_0 then
				local var_245_10 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_10.a = 0
				arg_242_1.mask_.color = var_245_10
			end

			local var_245_11 = arg_242_1.actors_["1047ui_story"].transform

			if 0.965999998152257 < arg_242_1.time_ and arg_242_1.time_ <= 0.965999998152257 + arg_245_0 then
				arg_242_1.var_.moveOldPos1047ui_story = var_245_11.localPosition
			end

			local var_245_12 = 0.001

			if 0.965999998152257 <= arg_242_1.time_ and arg_242_1.time_ < 0.965999998152257 + var_245_12 then
				var_245_11.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0.965999998152257) / var_245_12)
				var_245_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_11.position).x, (manager.ui.mainCamera.transform.position - var_245_11.position).y, (manager.ui.mainCamera.transform.position - var_245_11.position).z)
				var_245_11.localEulerAngles.z = 0
				var_245_11.localEulerAngles.x = 0
				var_245_11.localEulerAngles = var_245_11.localEulerAngles
			end

			if arg_242_1.time_ >= 0.965999998152257 + var_245_12 and arg_242_1.time_ < 0.965999998152257 + var_245_12 + arg_245_0 then
				var_245_11.localPosition = Vector3.New(0, 100, 0)
				var_245_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_11.position).x, (manager.ui.mainCamera.transform.position - var_245_11.position).y, (manager.ui.mainCamera.transform.position - var_245_11.position).z)
				var_245_11.localEulerAngles.z = 0
				var_245_11.localEulerAngles.x = 0
				var_245_11.localEulerAngles = var_245_11.localEulerAngles
			end

			local var_245_13 = arg_242_1.actors_["10102ui_story"].transform

			if 1.73333333333334 < arg_242_1.time_ and arg_242_1.time_ <= 1.73333333333334 + arg_245_0 then
				arg_242_1.var_.moveOldPos10102ui_story = var_245_13.localPosition
			end

			local var_245_14 = 0.001

			if 1.73333333333334 <= arg_242_1.time_ and arg_242_1.time_ < 1.73333333333334 + var_245_14 then
				var_245_13.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_242_1.time_ - 1.73333333333334) / var_245_14)
				var_245_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_13.position).x, (manager.ui.mainCamera.transform.position - var_245_13.position).y, (manager.ui.mainCamera.transform.position - var_245_13.position).z)
				var_245_13.localEulerAngles.z = 0
				var_245_13.localEulerAngles.x = 0
				var_245_13.localEulerAngles = var_245_13.localEulerAngles
			end

			if arg_242_1.time_ >= 1.73333333333334 + var_245_14 and arg_242_1.time_ < 1.73333333333334 + var_245_14 + arg_245_0 then
				var_245_13.localPosition = Vector3.New(0, -0.985, -6.275)
				var_245_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_13.position).x, (manager.ui.mainCamera.transform.position - var_245_13.position).y, (manager.ui.mainCamera.transform.position - var_245_13.position).z)
				var_245_13.localEulerAngles.z = 0
				var_245_13.localEulerAngles.x = 0
				var_245_13.localEulerAngles = var_245_13.localEulerAngles
			end

			local var_245_15 = arg_242_1.actors_["10102ui_story"]

			if 1.73333333333334 < arg_242_1.time_ and arg_242_1.time_ <= 1.73333333333334 + arg_245_0 and not isNil(var_245_15) and arg_242_1.var_.characterEffect10102ui_story == nil then
				arg_242_1.var_.characterEffect10102ui_story = var_245_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_16 = 0.200000002980232

			if 1.73333333333334 <= arg_242_1.time_ and arg_242_1.time_ < 1.73333333333334 + var_245_16 and not isNil(var_245_15) then
				if arg_242_1.var_.characterEffect10102ui_story and not isNil(var_245_15) then
					arg_242_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 1.73333333333334 + var_245_16 and arg_242_1.time_ < 1.73333333333334 + var_245_16 + arg_245_0 and not isNil(var_245_15) and arg_242_1.var_.characterEffect10102ui_story then
				arg_242_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 1.73333333333334 < arg_242_1.time_ and arg_242_1.time_ <= 1.73333333333334 + arg_245_0 then
				arg_242_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 1.73333333333334 < arg_242_1.time_ and arg_242_1.time_ <= 1.73333333333334 + arg_245_0 then
				arg_242_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_18 = 2
			local var_245_19 = 0.375

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_18 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_20 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_20:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_242_1.dialogCg_.alpha = arg_246_0
				end))
				var_245_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_21 = arg_242_1:GetWordFromCfg(421081057)
				local var_245_22 = arg_242_1:FormatText(var_245_21.content)

				arg_242_1.text_.text = var_245_22

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_24 = 15 <= 0 and var_245_19 or var_245_19 * (utf8.len(var_245_22) / 15)

				if (15 <= 0 and var_245_19 or var_245_19 * (utf8.len(var_245_22) / 15)) > 0 and var_245_19 < var_245_24 then
					arg_242_1.talkMaxDuration = var_245_24
					var_245_18 = var_245_18 + 0.3

					if var_245_24 + var_245_18 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_24 + var_245_18
					end
				end

				arg_242_1.text_.text = var_245_22
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081057", "story_v_out_421081.awb") ~= 0 then
					local var_245_25 = manager.audio:GetVoiceLength("story_v_out_421081", "421081057", "story_v_out_421081.awb") / 1000

					if var_245_25 + var_245_18 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_25 + var_245_18
					end

					if var_245_21.prefab_name ~= "" and arg_242_1.actors_[var_245_21.prefab_name] ~= nil then
						local var_245_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_21.prefab_name].transform, "story_v_out_421081", "421081057", "story_v_out_421081.awb")

						arg_242_1:RecordAudio("421081057", var_245_26)
						arg_242_1:RecordAudio("421081057", var_245_26)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_421081", "421081057", "story_v_out_421081.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_421081", "421081057", "story_v_out_421081.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_27 = var_245_18 + 0.3
			local var_245_28 = math.max(var_245_19, arg_242_1.talkMaxDuration)

			if var_245_18 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_27 + var_245_28 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_27) / var_245_28

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_27 + var_245_28 and arg_242_1.time_ < var_245_27 + var_245_28 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152257,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333334,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play421081058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 421081058
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play421081059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["10102ui_story"]) and arg_248_1.var_.characterEffect10102ui_story == nil then
				arg_248_1.var_.characterEffect10102ui_story = arg_248_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["10102ui_story"]) then
				if arg_248_1.var_.characterEffect10102ui_story and not isNil(arg_248_1.actors_["10102ui_story"]) then
					arg_248_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_0)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["10102ui_story"]) and arg_248_1.var_.characterEffect10102ui_story then
				arg_248_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_251_1 = 0
			local var_251_2 = 0.275

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(421081058).content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 11 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 11)

				if (11 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 11)) > 0 and var_251_2 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_6 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_6 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_6

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_6 and arg_248_1.time_ < var_251_1 + var_251_6 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play421081059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 421081059
		arg_252_1.duration_ = 6.8

		local var_252_0 = {
			zh = 5.7,
			ja = 6.8
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play421081060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1047ui_story = arg_252_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1047ui_story"].transform.position).z)
				arg_252_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1047ui_story"].transform.localEulerAngles = arg_252_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_252_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1047ui_story"].transform.position).z)
				arg_252_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1047ui_story"].transform.localEulerAngles = arg_252_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_255_1 = arg_252_1.actors_["10102ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10102ui_story = var_255_1.localPosition
			end

			local var_255_2 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 then
				var_255_1.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_252_1.time_ - 0) / var_255_2)
				var_255_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_1.position).x, (manager.ui.mainCamera.transform.position - var_255_1.position).y, (manager.ui.mainCamera.transform.position - var_255_1.position).z)
				var_255_1.localEulerAngles.z = 0
				var_255_1.localEulerAngles.x = 0
				var_255_1.localEulerAngles = var_255_1.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 then
				var_255_1.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_255_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_1.position).x, (manager.ui.mainCamera.transform.position - var_255_1.position).y, (manager.ui.mainCamera.transform.position - var_255_1.position).z)
				var_255_1.localEulerAngles.z = 0
				var_255_1.localEulerAngles.x = 0
				var_255_1.localEulerAngles = var_255_1.localEulerAngles
			end

			local var_255_3 = arg_252_1.actors_["1047ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect1047ui_story == nil then
				arg_252_1.var_.characterEffect1047ui_story = var_255_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_4 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 and not isNil(var_255_3) then
				if arg_252_1.var_.characterEffect1047ui_story and not isNil(var_255_3) then
					arg_252_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect1047ui_story then
				arg_252_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_255_6 = 0
			local var_255_7 = 0.575

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:GetWordFromCfg(421081059)
				local var_255_9 = arg_252_1:FormatText(var_255_8.content)

				arg_252_1.text_.text = var_255_9

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 23 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 23)

				if (23 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 23)) > 0 and var_255_7 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_9
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081059", "story_v_out_421081.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081059", "story_v_out_421081.awb") / 1000

					if var_255_12 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_6
					end

					if var_255_8.prefab_name ~= "" and arg_252_1.actors_[var_255_8.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_8.prefab_name].transform, "story_v_out_421081", "421081059", "story_v_out_421081.awb")

						arg_252_1:RecordAudio("421081059", var_255_13)
						arg_252_1:RecordAudio("421081059", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_421081", "421081059", "story_v_out_421081.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_421081", "421081059", "story_v_out_421081.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421081060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 421081060
		arg_256_1.duration_ = 2.73

		local var_256_0 = {
			zh = 2.133,
			ja = 2.733
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
				arg_256_0:Play421081061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos10102ui_story = arg_256_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_259_0 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				arg_256_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10102ui_story"].transform.position).z)
				arg_256_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["10102ui_story"].transform.localEulerAngles = arg_256_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				arg_256_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_256_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10102ui_story"].transform.position).z)
				arg_256_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["10102ui_story"].transform.localEulerAngles = arg_256_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_259_1 = arg_256_1.actors_["10102ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect10102ui_story == nil then
				arg_256_1.var_.characterEffect10102ui_story = var_259_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_2 and not isNil(var_259_1) then
				if arg_256_1.var_.characterEffect10102ui_story and not isNil(var_259_1) then
					arg_256_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_2 and arg_256_1.time_ < 0 + var_259_2 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect10102ui_story then
				arg_256_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_259_4 = arg_256_1.actors_["1047ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect1047ui_story == nil then
				arg_256_1.var_.characterEffect1047ui_story = var_259_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_5 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_5 and not isNil(var_259_4) then
				if arg_256_1.var_.characterEffect1047ui_story and not isNil(var_259_4) then
					arg_256_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_5)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_5 and arg_256_1.time_ < 0 + var_259_5 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect1047ui_story then
				arg_256_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_259_6 = 0
			local var_259_7 = 0.2

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_8 = arg_256_1:GetWordFromCfg(421081060)
				local var_259_9 = arg_256_1:FormatText(var_259_8.content)

				arg_256_1.text_.text = var_259_9

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 8 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_9) / 8)

				if (8 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_9) / 8)) > 0 and var_259_7 < var_259_11 then
					arg_256_1.talkMaxDuration = var_259_11

					if var_259_11 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_11 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_9
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081060", "story_v_out_421081.awb") ~= 0 then
					local var_259_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081060", "story_v_out_421081.awb") / 1000

					if var_259_12 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_12 + var_259_6
					end

					if var_259_8.prefab_name ~= "" and arg_256_1.actors_[var_259_8.prefab_name] ~= nil then
						local var_259_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_8.prefab_name].transform, "story_v_out_421081", "421081060", "story_v_out_421081.awb")

						arg_256_1:RecordAudio("421081060", var_259_13)
						arg_256_1:RecordAudio("421081060", var_259_13)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_421081", "421081060", "story_v_out_421081.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_421081", "421081060", "story_v_out_421081.awb")
				end

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

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421081061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 421081061
		arg_260_1.duration_ = 2.3

		local var_260_0 = {
			zh = 1.933,
			ja = 2.3
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
				arg_260_0:Play421081062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1047ui_story = arg_260_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1047ui_story"].transform.position).z)
				arg_260_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1047ui_story"].transform.localEulerAngles = arg_260_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_260_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1047ui_story"].transform.position).z)
				arg_260_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1047ui_story"].transform.localEulerAngles = arg_260_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["1047ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1047ui_story == nil then
				arg_260_1.var_.characterEffect1047ui_story = var_263_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 and not isNil(var_263_1) then
				if arg_260_1.var_.characterEffect1047ui_story and not isNil(var_263_1) then
					arg_260_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1047ui_story then
				arg_260_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_263_4 = arg_260_1.actors_["10102ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_4) and arg_260_1.var_.characterEffect10102ui_story == nil then
				arg_260_1.var_.characterEffect10102ui_story = var_263_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_5 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_5 and not isNil(var_263_4) then
				if arg_260_1.var_.characterEffect10102ui_story and not isNil(var_263_4) then
					arg_260_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_5)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_5 and arg_260_1.time_ < 0 + var_263_5 + arg_263_0 and not isNil(var_263_4) and arg_260_1.var_.characterEffect10102ui_story then
				arg_260_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_263_6 = 0
			local var_263_7 = 0.15

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_8 = arg_260_1:GetWordFromCfg(421081061)
				local var_263_9 = arg_260_1:FormatText(var_263_8.content)

				arg_260_1.text_.text = var_263_9

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 6 <= 0 and var_263_7 or var_263_7 * (utf8.len(var_263_9) / 6)

				if (6 <= 0 and var_263_7 or var_263_7 * (utf8.len(var_263_9) / 6)) > 0 and var_263_7 < var_263_11 then
					arg_260_1.talkMaxDuration = var_263_11

					if var_263_11 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_11 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_9
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081061", "story_v_out_421081.awb") ~= 0 then
					local var_263_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081061", "story_v_out_421081.awb") / 1000

					if var_263_12 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_12 + var_263_6
					end

					if var_263_8.prefab_name ~= "" and arg_260_1.actors_[var_263_8.prefab_name] ~= nil then
						local var_263_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_8.prefab_name].transform, "story_v_out_421081", "421081061", "story_v_out_421081.awb")

						arg_260_1:RecordAudio("421081061", var_263_13)
						arg_260_1:RecordAudio("421081061", var_263_13)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_421081", "421081061", "story_v_out_421081.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_421081", "421081061", "story_v_out_421081.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_14 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_14 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_14

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_14 and arg_260_1.time_ < var_263_6 + var_263_14 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421081062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 421081062
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play421081063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1047ui_story"]) and arg_264_1.var_.characterEffect1047ui_story == nil then
				arg_264_1.var_.characterEffect1047ui_story = arg_264_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1047ui_story"]) then
				if arg_264_1.var_.characterEffect1047ui_story and not isNil(arg_264_1.actors_["1047ui_story"]) then
					arg_264_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_0)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1047ui_story"]) and arg_264_1.var_.characterEffect1047ui_story then
				arg_264_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_267_1 = 0
			local var_267_2 = 0.175

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(421081062).content)

				arg_264_1.text_.text = var_267_3

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 7 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 7)

				if (7 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 7)) > 0 and var_267_2 < var_267_5 then
					arg_264_1.talkMaxDuration = var_267_5

					if var_267_5 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + var_267_1
					end
				end

				arg_264_1.text_.text = var_267_3
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_6 = math.max(var_267_2, arg_264_1.talkMaxDuration)

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_6 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_1) / var_267_6

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_1 + var_267_6 and arg_264_1.time_ < var_267_1 + var_267_6 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play421081063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 421081063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play421081064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_9000

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1047ui_story = arg_268_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_271_0 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 then
				arg_268_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_268_1.time_ - 0) / var_271_0)
				arg_268_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1047ui_story"].transform.position).z)
				arg_268_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1047ui_story"].transform.localEulerAngles = arg_268_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 then
				arg_268_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_268_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1047ui_story"].transform.position).z)
				arg_268_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1047ui_story"].transform.localEulerAngles = arg_268_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_271_1 = arg_268_1.actors_["10102ui_story"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10102ui_story = var_271_1.localPosition
			end

			local var_271_2 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_2 then
				var_271_1.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_268_1.time_ - 0) / var_271_2)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_2 and arg_268_1.time_ < 0 + var_271_2 + arg_271_0 then
				var_271_1.localPosition = Vector3.New(0, 100, 0)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:AudioAction("play", "effect", "se_story_140", "se_story_140_gun01", "")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_271_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_268_1.bgmTxt_.text ~= var_271_6 and arg_268_1.bgmTxt_.text ~= "" then
						if arg_268_1.bgmTxt2_.text ~= "" then
							arg_268_1.bgmTxt_.text = arg_268_1.bgmTxt2_.text
						end

						arg_268_1.bgmTxt2_.text = var_271_6

						arg_268_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_268_1.bgmTxt_.text = var_271_6
						arg_268_1.bgmTxt2_.text = var_271_6
					end

					if arg_268_1.bgmTimer then
						arg_268_1.bgmTimer:Stop()

						arg_268_1.bgmTimer = nil
					end

					if arg_268_1.settingData.show_music_name == 1 then
						arg_268_1.musicController:SetSelectedState("show")
						arg_268_1.musicAnimator_:Play("open", 0, 0)

						if arg_268_1.settingData.music_time ~= 0 then
							arg_268_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_268_1.settingData.music_time), function()
								if arg_268_1 == nil or isNil(arg_268_1.bgmTxt_) then
									return
								end

								arg_268_1.musicController:SetSelectedState("hide")
								arg_268_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				local var_271_7 = arg_268_1.var_.effect10631

				if not arg_268_1.var_.effect10631 then
					var_271_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_271_7.name = "10631"
					arg_268_1.var_.effect10631 = var_271_7
				else
					var_271_7.transform:SetParent(var_271_9000)
				end

				var_271_7.transform.localPosition = Vector3.New(0, 0, 3.76)
				var_271_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.33333333333333 < arg_268_1.time_ and arg_268_1.time_ <= 1.33333333333333 + arg_271_0 then
				if arg_268_1.var_.effect10631 then
					Object.Destroy(arg_268_1.var_.effect10631)

					arg_268_1.var_.effect10631 = nil
				end
			end

			local var_271_10 = 0
			local var_271_11 = 0.6

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_12 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(421081063).content)

				arg_268_1.text_.text = var_271_12

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_14 = 24 <= 0 and var_271_11 or var_271_11 * (utf8.len(var_271_12) / 24)

				if (24 <= 0 and var_271_11 or var_271_11 * (utf8.len(var_271_12) / 24)) > 0 and var_271_11 < var_271_14 then
					arg_268_1.talkMaxDuration = var_271_14

					if var_271_14 + var_271_10 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_14 + var_271_10
					end
				end

				arg_268_1.text_.text = var_271_12
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_15 = math.max(var_271_11, arg_268_1.talkMaxDuration)

			if var_271_10 <= arg_268_1.time_ and arg_268_1.time_ < var_271_10 + var_271_15 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_10) / var_271_15

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_10 + var_271_15 and arg_268_1.time_ < var_271_10 + var_271_15 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421081064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 421081064
		arg_273_1.duration_ = 2

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play421081065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1047ui_story = arg_273_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1047ui_story"].transform.position).z)
				arg_273_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1047ui_story"].transform.localEulerAngles = arg_273_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_273_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1047ui_story"].transform.position).z)
				arg_273_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1047ui_story"].transform.localEulerAngles = arg_273_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1047ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1047ui_story == nil then
				arg_273_1.var_.characterEffect1047ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1047ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1047ui_story then
				arg_273_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_276_4 = 0
			local var_276_5 = 0.075

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(421081064)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 3 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 3)

				if (3 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 3)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081064", "story_v_out_421081.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081064", "story_v_out_421081.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_421081", "421081064", "story_v_out_421081.awb")

						arg_273_1:RecordAudio("421081064", var_276_11)
						arg_273_1:RecordAudio("421081064", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_421081", "421081064", "story_v_out_421081.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_421081", "421081064", "story_v_out_421081.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play421081065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 421081065
		arg_277_1.duration_ = 7

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play421081066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0.965999998152257 < arg_277_1.time_ and arg_277_1.time_ <= 0.965999998152257 + arg_280_0 then
				arg_277_1.var_.moveOldPos1047ui_story = arg_277_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0.965999998152257 <= arg_277_1.time_ and arg_277_1.time_ < 0.965999998152257 + var_280_0 then
				arg_277_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_277_1.time_ - 0.965999998152257) / var_280_0)
				arg_277_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).z)
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles = arg_277_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0.965999998152257 + var_280_0 and arg_277_1.time_ < 0.965999998152257 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1047ui_story"].transform.position).z)
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1047ui_story"].transform.localEulerAngles = arg_277_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 1 < arg_277_1.time_ and arg_277_1.time_ <= 1 + arg_280_0 then
				local var_280_1 = arg_277_1.bgs_.I08a

				arg_277_1.bgs_.I08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_280_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_280_2 = var_280_1:GetComponent("SpriteRenderer")

				if var_280_2 and var_280_2.sprite then
					local var_280_3 = 2 * (var_280_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_280_1.transform.localScale = Vector3.New(var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, 0)
				end

				for iter_280_0, iter_280_1 in pairs(arg_277_1.bgs_) do
					if iter_280_0 ~= "I08a" then
						iter_280_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_280_4 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_5 = 1

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_5 then
				local var_280_6 = Color.New(0, 0, 0)

				var_280_6.a = Mathf.Lerp(0, 1, (arg_277_1.time_ - var_280_4) / var_280_5)
				arg_277_1.mask_.color = var_280_6
			end

			if arg_277_1.time_ >= var_280_4 + var_280_5 and arg_277_1.time_ < var_280_4 + var_280_5 + arg_280_0 then
				local var_280_7 = Color.New(0, 0, 0)

				var_280_7.a = 1
				arg_277_1.mask_.color = var_280_7
			end

			local var_280_8 = 1

			if 1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_9 = 1

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 then
				local var_280_10 = Color.New(0, 0, 0)

				var_280_10.a = Mathf.Lerp(1, 0, (arg_277_1.time_ - var_280_8) / var_280_9)
				arg_277_1.mask_.color = var_280_10
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 then
				local var_280_11 = Color.New(0, 0, 0)

				arg_277_1.mask_.enabled = false
				var_280_11.a = 0
				arg_277_1.mask_.color = var_280_11
			end

			if 2.4 < arg_277_1.time_ and arg_277_1.time_ <= 2.4 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_side_1028_door", "")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_280_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_277_1.bgmTxt_.text ~= var_280_15 and arg_277_1.bgmTxt_.text ~= "" then
						if arg_277_1.bgmTxt2_.text ~= "" then
							arg_277_1.bgmTxt_.text = arg_277_1.bgmTxt2_.text
						end

						arg_277_1.bgmTxt2_.text = var_280_15

						arg_277_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_277_1.bgmTxt_.text = var_280_15
						arg_277_1.bgmTxt2_.text = var_280_15
					end

					if arg_277_1.bgmTimer then
						arg_277_1.bgmTimer:Stop()

						arg_277_1.bgmTimer = nil
					end

					if arg_277_1.settingData.show_music_name == 1 then
						arg_277_1.musicController:SetSelectedState("show")
						arg_277_1.musicAnimator_:Play("open", 0, 0)

						if arg_277_1.settingData.music_time ~= 0 then
							arg_277_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_277_1.settingData.music_time), function()
								if arg_277_1 == nil or isNil(arg_277_1.bgmTxt_) then
									return
								end

								arg_277_1.musicController:SetSelectedState("hide")
								arg_277_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_277_1.time_ and arg_277_1.time_ <= 0.433333333333333 + arg_280_0 then
				arg_277_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_280_18 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_277_1.bgmTxt_.text ~= var_280_18 and arg_277_1.bgmTxt_.text ~= "" then
						if arg_277_1.bgmTxt2_.text ~= "" then
							arg_277_1.bgmTxt_.text = arg_277_1.bgmTxt2_.text
						end

						arg_277_1.bgmTxt2_.text = var_280_18

						arg_277_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_277_1.bgmTxt_.text = var_280_18
						arg_277_1.bgmTxt2_.text = var_280_18
					end

					if arg_277_1.bgmTimer then
						arg_277_1.bgmTimer:Stop()

						arg_277_1.bgmTimer = nil
					end

					if arg_277_1.settingData.show_music_name == 1 then
						arg_277_1.musicController:SetSelectedState("show")
						arg_277_1.musicAnimator_:Play("open", 0, 0)

						if arg_277_1.settingData.music_time ~= 0 then
							arg_277_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_277_1.settingData.music_time), function()
								if arg_277_1 == nil or isNil(arg_277_1.bgmTxt_) then
									return
								end

								arg_277_1.musicController:SetSelectedState("hide")
								arg_277_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_277_1.frameCnt_ <= 1 then
				arg_277_1.dialog_:SetActive(false)
			end

			local var_280_19 = 2
			local var_280_20 = 0.7

			if 2 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_21 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_21:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_277_1.dialogCg_.alpha = arg_283_0
				end))
				var_280_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_22 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(421081065).content)

				arg_277_1.text_.text = var_280_22

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_24 = 28 <= 0 and var_280_20 or var_280_20 * (utf8.len(var_280_22) / 28)

				if (28 <= 0 and var_280_20 or var_280_20 * (utf8.len(var_280_22) / 28)) > 0 and var_280_20 < var_280_24 then
					arg_277_1.talkMaxDuration = var_280_24
					var_280_19 = var_280_19 + 0.3

					if var_280_24 + var_280_19 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_19
					end
				end

				arg_277_1.text_.text = var_280_22
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = var_280_19 + 0.3
			local var_280_26 = math.max(var_280_20, arg_277_1.talkMaxDuration)

			if var_280_19 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_25 + var_280_26 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_25) / var_280_26

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_25 + var_280_26 and arg_277_1.time_ < var_280_25 + var_280_26 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152257,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play421081066 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 421081066
		arg_285_1.duration_ = 3.97

		local var_285_0 = {
			zh = 3.966,
			ja = 3.6
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
				arg_285_0:Play421081067(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.3

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:GetWordFromCfg(421081066)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 12 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 12)

				if (12 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 12)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081066", "story_v_out_421081.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081066", "story_v_out_421081.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_421081", "421081066", "story_v_out_421081.awb")

						arg_285_1:RecordAudio("421081066", var_288_6)
						arg_285_1:RecordAudio("421081066", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_421081", "421081066", "story_v_out_421081.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_421081", "421081066", "story_v_out_421081.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play421081067 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 421081067
		arg_289_1.duration_ = 10.4

		local var_289_0 = {
			zh = 6.966,
			ja = 10.4
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play421081068(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.7

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:GetWordFromCfg(421081067)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 28 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 28)

				if (28 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 28)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081067", "story_v_out_421081.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081067", "story_v_out_421081.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_421081", "421081067", "story_v_out_421081.awb")

						arg_289_1:RecordAudio("421081067", var_292_6)
						arg_289_1:RecordAudio("421081067", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_421081", "421081067", "story_v_out_421081.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_421081", "421081067", "story_v_out_421081.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play421081068 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 421081068
		arg_293_1.duration_ = 5.8

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play421081069(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_9002
			local var_296_9001
			local var_296_9000

			if 0.566666666666667 < arg_293_1.time_ and arg_293_1.time_ <= 0.566666666666667 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_141", "se_story_141_explosion", "")
			end

			if 0.566666666666667 < arg_293_1.time_ and arg_293_1.time_ <= 0.566666666666667 + arg_296_0 then
				local var_296_1 = arg_293_1.var_.effect10141

				if not arg_293_1.var_.effect10141 then
					var_296_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui"), manager.ui.mainCamera.transform)
					var_296_1.name = "10141"
					arg_293_1.var_.effect10141 = var_296_1
				else
					var_296_1.transform:SetParent(var_296_9002)
				end

				var_296_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_296_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.53333333333333 < arg_293_1.time_ and arg_293_1.time_ <= 4.53333333333333 + arg_296_0 then
				if arg_293_1.var_.effect10141 then
					Object.Destroy(arg_293_1.var_.effect10141)

					arg_293_1.var_.effect10141 = nil
				end
			end

			if 0.566666666666667 < arg_293_1.time_ and arg_293_1.time_ <= 0.566666666666667 + arg_296_0 then
				local var_296_4 = arg_293_1.var_.effect10168

				if not arg_293_1.var_.effect10168 then
					var_296_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), manager.ui.mainCamera.transform)
					var_296_4.name = "10168"
					arg_293_1.var_.effect10168 = var_296_4
				else
					var_296_4.transform:SetParent(var_296_9001)
				end

				var_296_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_296_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.53333333333333 < arg_293_1.time_ and arg_293_1.time_ <= 4.53333333333333 + arg_296_0 then
				if arg_293_1.var_.effect10168 then
					Object.Destroy(arg_293_1.var_.effect10168)

					arg_293_1.var_.effect10168 = nil
				end
			end

			local var_296_7 = manager.ui.mainCamera.transform

			if 0.566666666666667 < arg_293_1.time_ and arg_293_1.time_ <= 0.566666666666667 + arg_296_0 then
				arg_293_1.var_.shakeOldPos = var_296_7.localPosition
			end

			local var_296_8 = 1.43333333333333

			if 0.566666666666667 <= arg_293_1.time_ and arg_293_1.time_ < 0.566666666666667 + var_296_8 then
				local var_296_9, var_296_10 = math.modf((arg_293_1.time_ - 0.566666666666667) / 0.066)

				var_296_7.localPosition = Vector3.New(var_296_10 * 0.13, var_296_10 * 0.13, var_296_10 * 0.13) + arg_293_1.var_.shakeOldPos
			end

			if arg_293_1.time_ >= 0.566666666666667 + var_296_8 and arg_293_1.time_ < 0.566666666666667 + var_296_8 + arg_296_0 then
				var_296_7.localPosition = arg_293_1.var_.shakeOldPos
			end

			if 0.8 < arg_293_1.time_ and arg_293_1.time_ <= 0.8 + arg_296_0 then
				local var_296_11 = arg_293_1.var_.effect1068

				if not arg_293_1.var_.effect1068 then
					var_296_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_296_11.name = "1068"
					arg_293_1.var_.effect1068 = var_296_11
				else
					var_296_11.transform:SetParent(var_296_9000)
				end

				var_296_11.transform.localPosition = Vector3.New(0, 0, -9.61)
				var_296_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_296_13 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_13 + 1.83190633667012 and arg_293_1.time_ < var_296_13 + 1.83190633667012 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_14 = 0
			local var_296_15 = 1.475

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_16 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(421081068).content)

				arg_293_1.text_.text = var_296_16

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_18 = 59 <= 0 and var_296_15 or var_296_15 * (utf8.len(var_296_16) / 59)

				if (59 <= 0 and var_296_15 or var_296_15 * (utf8.len(var_296_16) / 59)) > 0 and var_296_15 < var_296_18 then
					arg_293_1.talkMaxDuration = var_296_18

					if var_296_18 + var_296_14 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_18 + var_296_14
					end
				end

				arg_293_1.text_.text = var_296_16
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_19 = math.max(var_296_15, arg_293_1.talkMaxDuration)

			if var_296_14 <= arg_293_1.time_ and arg_293_1.time_ < var_296_14 + var_296_19 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_14) / var_296_19

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_14 + var_296_19 and arg_293_1.time_ < var_296_14 + var_296_19 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play421081069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 421081069
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play421081070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.075

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(421081069).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 3 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 3)

				if (3 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 3)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play421081070 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 421081070
		arg_301_1.duration_ = 7

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play421081071(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if arg_301_1.bgs_.STblack == nil then
				local var_304_0 = Object.Instantiate(arg_301_1.paintGo_)

				var_304_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_304_0.name = "STblack"
				var_304_0.transform.parent = arg_301_1.stage_.transform
				var_304_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.bgs_.STblack = var_304_0
			end

			if 1 < arg_301_1.time_ and arg_301_1.time_ <= 1 + arg_304_0 then
				local var_304_1 = arg_301_1.bgs_.STblack

				arg_301_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_304_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_304_2 = var_304_1:GetComponent("SpriteRenderer")

				if var_304_2 and var_304_2.sprite then
					local var_304_3 = 2 * (var_304_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_304_1.transform.localScale = Vector3.New(var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, 0)
				end

				for iter_304_0, iter_304_1 in pairs(arg_301_1.bgs_) do
					if iter_304_0 ~= "STblack" then
						iter_304_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_304_4 = 2

			if 2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			if arg_301_1.time_ >= var_304_4 + 0.566666666666667 and arg_301_1.time_ < var_304_4 + 0.566666666666667 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			local var_304_5 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_6 = 1

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_6 then
				local var_304_7 = Color.New(0, 0, 0)

				var_304_7.a = Mathf.Lerp(0, 1, (arg_301_1.time_ - var_304_5) / var_304_6)
				arg_301_1.mask_.color = var_304_7
			end

			if arg_301_1.time_ >= var_304_5 + var_304_6 and arg_301_1.time_ < var_304_5 + var_304_6 + arg_304_0 then
				local var_304_8 = Color.New(0, 0, 0)

				var_304_8.a = 1
				arg_301_1.mask_.color = var_304_8
			end

			local var_304_9 = 1

			if 1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_10 = 1

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_10 then
				local var_304_11 = Color.New(0, 0, 0)

				var_304_11.a = Mathf.Lerp(1, 0, (arg_301_1.time_ - var_304_9) / var_304_10)
				arg_301_1.mask_.color = var_304_11
			end

			if arg_301_1.time_ >= var_304_9 + var_304_10 and arg_301_1.time_ < var_304_9 + var_304_10 + arg_304_0 then
				local var_304_12 = Color.New(0, 0, 0)

				arg_301_1.mask_.enabled = false
				var_304_12.a = 0
				arg_301_1.mask_.color = var_304_12
			end

			if 0.166666666666667 < arg_301_1.time_ and arg_301_1.time_ <= 0.166666666666667 + arg_304_0 then
				arg_301_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_304_14 = manager.ui.mainCamera.transform

			if 0.166666666666667 < arg_301_1.time_ and arg_301_1.time_ <= 0.166666666666667 + arg_304_0 then
				arg_301_1.var_.shakeOldPos = var_304_14.localPosition
			end

			local var_304_15 = 0.833333333333335

			if 0.166666666666667 <= arg_301_1.time_ and arg_301_1.time_ < 0.166666666666667 + var_304_15 then
				local var_304_16, var_304_17 = math.modf((arg_301_1.time_ - 0.166666666666667) / 0.066)

				var_304_14.localPosition = Vector3.New(var_304_17 * 0.13, var_304_17 * 0.13, var_304_17 * 0.13) + arg_301_1.var_.shakeOldPos
			end

			if arg_301_1.time_ >= 0.166666666666667 + var_304_15 and arg_301_1.time_ < 0.166666666666667 + var_304_15 + arg_304_0 then
				var_304_14.localPosition = arg_301_1.var_.shakeOldPos
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_18 = 2
			local var_304_19 = 1.175

			if 2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_18 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_20 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_20:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_301_1.dialogCg_.alpha = arg_305_0
				end))
				var_304_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_21 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(421081070).content)

				arg_301_1.text_.text = var_304_21

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_23 = 47 <= 0 and var_304_19 or var_304_19 * (utf8.len(var_304_21) / 47)

				if (47 <= 0 and var_304_19 or var_304_19 * (utf8.len(var_304_21) / 47)) > 0 and var_304_19 < var_304_23 then
					arg_301_1.talkMaxDuration = var_304_23
					var_304_18 = var_304_18 + 0.3

					if var_304_23 + var_304_18 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_18
					end
				end

				arg_301_1.text_.text = var_304_21
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_24 = var_304_18 + 0.3
			local var_304_25 = math.max(var_304_19, arg_301_1.talkMaxDuration)

			if var_304_18 + 0.3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_24 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_24) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_24 + var_304_25 and arg_301_1.time_ < var_304_24 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play421081071 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 421081071
		arg_307_1.duration_ = 8

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play421081072(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_9001
			local var_310_9000

			if arg_307_1.bgs_.I08 == nil then
				local var_310_0 = Object.Instantiate(arg_307_1.paintGo_)

				var_310_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I08")
				var_310_0.name = "I08"
				var_310_0.transform.parent = arg_307_1.stage_.transform
				var_310_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.bgs_.I08 = var_310_0
			end

			if 1 < arg_307_1.time_ and arg_307_1.time_ <= 1 + arg_310_0 then
				local var_310_1 = arg_307_1.bgs_.I08

				arg_307_1.bgs_.I08.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_310_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_310_2 = var_310_1:GetComponent("SpriteRenderer")

				if var_310_2 and var_310_2.sprite then
					local var_310_3 = 2 * (var_310_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_310_1.transform.localScale = Vector3.New(var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, 0)
				end

				for iter_310_0, iter_310_1 in pairs(arg_307_1.bgs_) do
					if iter_310_0 ~= "I08" then
						iter_310_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_310_4 = 3

			if 3 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_4 + 0.133333333333334 and arg_307_1.time_ < var_310_4 + 0.133333333333334 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_5 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_6 = 1

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_6 then
				local var_310_7 = Color.New(0, 0, 0)

				var_310_7.a = Mathf.Lerp(1, 0, (arg_307_1.time_ - var_310_5) / var_310_6)
				arg_307_1.mask_.color = var_310_7
			end

			if arg_307_1.time_ >= var_310_5 + var_310_6 and arg_307_1.time_ < var_310_5 + var_310_6 + arg_310_0 then
				local var_310_8 = Color.New(0, 0, 0)

				arg_307_1.mask_.enabled = false
				var_310_8.a = 0
				arg_307_1.mask_.color = var_310_8
			end

			local var_310_9 = 1

			if 1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_10 = 2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 then
				local var_310_11 = Color.New(0, 0, 0)

				var_310_11.a = Mathf.Lerp(1, 0, (arg_307_1.time_ - var_310_9) / var_310_10)
				arg_307_1.mask_.color = var_310_11
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 then
				local var_310_12 = Color.New(0, 0, 0)

				arg_307_1.mask_.enabled = false
				var_310_12.a = 0
				arg_307_1.mask_.color = var_310_12
			end

			if 1 < arg_307_1.time_ and arg_307_1.time_ <= 1 + arg_310_0 then
				local var_310_13 = arg_307_1.var_.effect1071

				if not arg_307_1.var_.effect1071 then
					var_310_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_310_13.name = "1071"
					arg_307_1.var_.effect1071 = var_310_13
				else
					var_310_13.transform:SetParent(var_310_9001)
				end

				var_310_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_310_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_307_1.time_ and arg_307_1.time_ <= 1 + arg_310_0 then
				local var_310_15 = arg_307_1.var_.effect1072

				if not arg_307_1.var_.effect1072 then
					var_310_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning"), manager.ui.mainCamera.transform)
					var_310_15.name = "1072"
					arg_307_1.var_.effect1072 = var_310_15
				else
					var_310_15.transform:SetParent(var_310_9000)
				end

				var_310_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_310_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drain_p2", "")
			end

			if 0.533333333333333 < arg_307_1.time_ and arg_307_1.time_ <= 0.533333333333333 + arg_310_0 then
				arg_307_1:AudioAction("play", "effect", "se_story_9", "se_story_9_fire_environment_loop", "")
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_19 = 3
			local var_310_20 = 0.225

			if 3 < arg_307_1.time_ and arg_307_1.time_ <= var_310_19 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_21 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_21:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_22 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(421081071).content)

				arg_307_1.text_.text = var_310_22

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_24 = 9 <= 0 and var_310_20 or var_310_20 * (utf8.len(var_310_22) / 9)

				if (9 <= 0 and var_310_20 or var_310_20 * (utf8.len(var_310_22) / 9)) > 0 and var_310_20 < var_310_24 then
					arg_307_1.talkMaxDuration = var_310_24
					var_310_19 = var_310_19 + 0.3

					if var_310_24 + var_310_19 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_24 + var_310_19
					end
				end

				arg_307_1.text_.text = var_310_22
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_25 = var_310_19 + 0.3
			local var_310_26 = math.max(var_310_20, arg_307_1.talkMaxDuration)

			if var_310_19 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_25 + var_310_26 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_25) / var_310_26

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_25 + var_310_26 and arg_307_1.time_ < var_310_25 + var_310_26 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play421081072 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 421081072
		arg_313_1.duration_ = 3.03

		local var_313_0 = {
			zh = 2.333,
			ja = 3.033
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
				arg_313_0:Play421081073(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.325

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_1 = arg_313_1:GetWordFromCfg(421081072)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 13 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 13)

				if (13 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 13)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081072", "story_v_out_421081.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_421081", "421081072", "story_v_out_421081.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_421081", "421081072", "story_v_out_421081.awb")

						arg_313_1:RecordAudio("421081072", var_316_6)
						arg_313_1:RecordAudio("421081072", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_421081", "421081072", "story_v_out_421081.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_421081", "421081072", "story_v_out_421081.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play421081073 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 421081073
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play421081074(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(421081073).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 44 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 44)

				if (44 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 44)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play421081074 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 421081074
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play421081075(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.2

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(421081074).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 8 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 8)

				if (8 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 8)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play421081075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 421081075
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play421081076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "se_story_7", "se_story_7_fire", "")
			end

			if 1.38777878078145e-16 < arg_325_1.time_ and arg_325_1.time_ <= 1.38777878078145e-16 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crash", "")
			end

			local var_328_2 = 0
			local var_328_3 = 1.075

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(421081075).content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 43 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 43)

				if (43 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 43)) > 0 and var_328_3 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_7 and arg_325_1.time_ < var_328_2 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play421081076 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 421081076
		arg_329_1.duration_ = 2

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play421081077(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1047ui_story = arg_329_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).z)
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles = arg_329_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_329_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).z)
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles = arg_329_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1047ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1047ui_story == nil then
				arg_329_1.var_.characterEffect1047ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1047ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1047ui_story then
				arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_332_4 = 0
			local var_332_5 = 0.15

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(421081076)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 6 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 6)

				if (6 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 6)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081076", "story_v_out_421081.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081076", "story_v_out_421081.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_out_421081", "421081076", "story_v_out_421081.awb")

						arg_329_1:RecordAudio("421081076", var_332_11)
						arg_329_1:RecordAudio("421081076", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_421081", "421081076", "story_v_out_421081.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_421081", "421081076", "story_v_out_421081.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play421081077 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 421081077
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play421081078(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1047ui_story = arg_333_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).z)
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles = arg_333_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_333_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1047ui_story"].transform.position).z)
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1047ui_story"].transform.localEulerAngles = arg_333_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_336_1 = 0
			local var_336_2 = 0.6

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(421081077).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 24 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 24)

				if (24 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 24)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play421081078 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 421081078
		arg_337_1.duration_ = 2.9

		local var_337_0 = {
			zh = 2.9,
			ja = 1.999999999999
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play421081079(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10102ui_story = arg_337_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).z)
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles = arg_337_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_337_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).z)
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles = arg_337_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["10102ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect10102ui_story == nil then
				arg_337_1.var_.characterEffect10102ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect10102ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect10102ui_story then
				arg_337_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_340_4 = 0
			local var_340_5 = 0.25

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(421081078)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 10 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 10)

				if (10 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 10)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081078", "story_v_out_421081.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081078", "story_v_out_421081.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_out_421081", "421081078", "story_v_out_421081.awb")

						arg_337_1:RecordAudio("421081078", var_340_11)
						arg_337_1:RecordAudio("421081078", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_421081", "421081078", "story_v_out_421081.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_421081", "421081078", "story_v_out_421081.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play421081079 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 421081079
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play421081080(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0.1 < arg_341_1.time_ and arg_341_1.time_ <= 0.1 + arg_344_0 then
				arg_341_1:AudioAction("play", "effect", "se_story_143", "se_story_143_sword", "")
			end

			local var_344_1 = arg_341_1.actors_["10102ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10102ui_story = var_344_1.localPosition
			end

			local var_344_2 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 then
				var_344_1.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_2)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 then
				var_344_1.localPosition = Vector3.New(0, 100, 0)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			local var_344_3 = 0
			local var_344_4 = 1.3

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_5 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(421081079).content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 52 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 52)

				if (52 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 52)) > 0 and var_344_4 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_3
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_4, arg_341_1.talkMaxDuration)

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_3) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_3 + var_344_8 and arg_341_1.time_ < var_344_3 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play421081080 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 421081080
		arg_345_1.duration_ = 4.3

		local var_345_0 = {
			zh = 4.233,
			ja = 4.3
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play421081081(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1047ui_story = arg_345_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1047ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1047ui_story == nil then
				arg_345_1.var_.characterEffect1047ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1047ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1047ui_story then
				arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_348_4 = 0
			local var_348_5 = 0.45

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(421081080)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 18 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 18)

				if (18 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 18)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081080", "story_v_out_421081.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081080", "story_v_out_421081.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_out_421081", "421081080", "story_v_out_421081.awb")

						arg_345_1:RecordAudio("421081080", var_348_11)
						arg_345_1:RecordAudio("421081080", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_421081", "421081080", "story_v_out_421081.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_421081", "421081080", "story_v_out_421081.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_12 and arg_345_1.time_ < var_348_4 + var_348_12 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play421081081 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 421081081
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play421081082(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1047ui_story = arg_349_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1047ui_story"].transform.position).z)
				arg_349_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1047ui_story"].transform.localEulerAngles = arg_349_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1047ui_story"].transform.position).z)
				arg_349_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1047ui_story"].transform.localEulerAngles = arg_349_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_349_1.time_ and arg_349_1.time_ <= 0.1 + arg_352_0 then
				arg_349_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_metal02", "")
			end

			local var_352_2 = 0
			local var_352_3 = 0.9

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(421081081).content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_6 = 36 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_4) / 36)

				if (36 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_4) / 36)) > 0 and var_352_3 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_7 and arg_349_1.time_ < var_352_2 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play421081082 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 421081082
		arg_353_1.duration_ = 4.4

		local var_353_0 = {
			zh = 3.1,
			ja = 4.4
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play421081083(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10102ui_story = arg_353_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10102ui_story"].transform.position).z)
				arg_353_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["10102ui_story"].transform.localEulerAngles = arg_353_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_353_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10102ui_story"].transform.position).z)
				arg_353_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["10102ui_story"].transform.localEulerAngles = arg_353_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["10102ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect10102ui_story == nil then
				arg_353_1.var_.characterEffect10102ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect10102ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect10102ui_story then
				arg_353_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_356_4 = 0
			local var_356_5 = 0.475

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(421081082)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 19 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 19)

				if (19 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 19)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081082", "story_v_out_421081.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081082", "story_v_out_421081.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_out_421081", "421081082", "story_v_out_421081.awb")

						arg_353_1:RecordAudio("421081082", var_356_11)
						arg_353_1:RecordAudio("421081082", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_421081", "421081082", "story_v_out_421081.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_421081", "421081082", "story_v_out_421081.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play421081083 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 421081083
		arg_357_1.duration_ = 5.83

		local var_357_0 = {
			zh = 5.133,
			ja = 5.833
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play421081084(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1047ui_story = arg_357_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).z)
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles = arg_357_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_357_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).z)
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles = arg_357_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1047ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1047ui_story == nil then
				arg_357_1.var_.characterEffect1047ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1047ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1047ui_story then
				arg_357_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_360_4 = arg_357_1.actors_["10102ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect10102ui_story == nil then
				arg_357_1.var_.characterEffect10102ui_story = var_360_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_5 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_5 and not isNil(var_360_4) then
				if arg_357_1.var_.characterEffect10102ui_story and not isNil(var_360_4) then
					arg_357_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_5)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_5 and arg_357_1.time_ < 0 + var_360_5 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect10102ui_story then
				arg_357_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_360_6 = 0
			local var_360_7 = 0.6

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_8 = arg_357_1:GetWordFromCfg(421081083)
				local var_360_9 = arg_357_1:FormatText(var_360_8.content)

				arg_357_1.text_.text = var_360_9

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 24 <= 0 and var_360_7 or var_360_7 * (utf8.len(var_360_9) / 24)

				if (24 <= 0 and var_360_7 or var_360_7 * (utf8.len(var_360_9) / 24)) > 0 and var_360_7 < var_360_11 then
					arg_357_1.talkMaxDuration = var_360_11

					if var_360_11 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_9
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081083", "story_v_out_421081.awb") ~= 0 then
					local var_360_12 = manager.audio:GetVoiceLength("story_v_out_421081", "421081083", "story_v_out_421081.awb") / 1000

					if var_360_12 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_12 + var_360_6
					end

					if var_360_8.prefab_name ~= "" and arg_357_1.actors_[var_360_8.prefab_name] ~= nil then
						local var_360_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_8.prefab_name].transform, "story_v_out_421081", "421081083", "story_v_out_421081.awb")

						arg_357_1:RecordAudio("421081083", var_360_13)
						arg_357_1:RecordAudio("421081083", var_360_13)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_421081", "421081083", "story_v_out_421081.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_421081", "421081083", "story_v_out_421081.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_14 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_14 and arg_357_1.time_ < var_360_6 + var_360_14 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play421081084 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 421081084
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play421081085(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1047ui_story"]) and arg_361_1.var_.characterEffect1047ui_story == nil then
				arg_361_1.var_.characterEffect1047ui_story = arg_361_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1047ui_story"]) then
				if arg_361_1.var_.characterEffect1047ui_story and not isNil(arg_361_1.actors_["1047ui_story"]) then
					arg_361_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1047ui_story"]) and arg_361_1.var_.characterEffect1047ui_story then
				arg_361_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.1

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(421081084).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 4 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 4)

				if (4 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 4)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play421081085 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 421081085
		arg_365_1.duration_ = 1

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"

			SetActive(arg_365_1.choicesGo_, true)

			for iter_366_0, iter_366_1 in ipairs(arg_365_1.choices_) do
				SetActive(iter_366_1.go, iter_366_0 <= 1)
			end

			arg_365_1.choices_[1].txt.text = arg_365_1:FormatText(StoryChoiceCfg[1352].name)
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play421081086(arg_365_1)
			end

			arg_365_1:RecordChoiceLog(421081085, 1352)
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			return
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play421081086 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 421081086
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play421081087(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.5

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(421081086).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 20 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 20)

				if (20 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 20)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play421081087 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 421081087
		arg_373_1.duration_ = 2.67

		local var_373_0 = {
			zh = 2.666,
			ja = 1.766
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play421081088(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10102ui_story = arg_373_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10102ui_story"].transform.position).z)
				arg_373_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10102ui_story"].transform.localEulerAngles = arg_373_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_373_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10102ui_story"].transform.position).z)
				arg_373_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10102ui_story"].transform.localEulerAngles = arg_373_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["10102ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10102ui_story == nil then
				arg_373_1.var_.characterEffect10102ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect10102ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10102ui_story then
				arg_373_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_376_4 = 0
			local var_376_5 = 0.1

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_6 = arg_373_1:GetWordFromCfg(421081087)
				local var_376_7 = arg_373_1:FormatText(var_376_6.content)

				arg_373_1.text_.text = var_376_7

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_9 = 4 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 4)

				if (4 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 4)) > 0 and var_376_5 < var_376_9 then
					arg_373_1.talkMaxDuration = var_376_9

					if var_376_9 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_9 + var_376_4
					end
				end

				arg_373_1.text_.text = var_376_7
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081087", "story_v_out_421081.awb") ~= 0 then
					local var_376_10 = manager.audio:GetVoiceLength("story_v_out_421081", "421081087", "story_v_out_421081.awb") / 1000

					if var_376_10 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_4
					end

					if var_376_6.prefab_name ~= "" and arg_373_1.actors_[var_376_6.prefab_name] ~= nil then
						local var_376_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_6.prefab_name].transform, "story_v_out_421081", "421081087", "story_v_out_421081.awb")

						arg_373_1:RecordAudio("421081087", var_376_11)
						arg_373_1:RecordAudio("421081087", var_376_11)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_421081", "421081087", "story_v_out_421081.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_421081", "421081087", "story_v_out_421081.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_12 = math.max(var_376_5, arg_373_1.talkMaxDuration)

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_12 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_4) / var_376_12

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_4 + var_376_12 and arg_373_1.time_ < var_376_4 + var_376_12 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play421081088 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 421081088
		arg_377_1.duration_ = 6

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
			arg_377_1.auto_ = false
		end

		function arg_377_1.playNext_(arg_379_0)
			arg_377_1.onStoryFinished_()
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1047ui_story = arg_377_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1047ui_story"].transform.position).z)
				arg_377_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1047ui_story"].transform.localEulerAngles = arg_377_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_377_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1047ui_story"].transform.position).z)
				arg_377_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1047ui_story"].transform.localEulerAngles = arg_377_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1047ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1047ui_story == nil then
				arg_377_1.var_.characterEffect1047ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1047ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1047ui_story then
				arg_377_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_380_4 = arg_377_1.actors_["10102ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_4) and arg_377_1.var_.characterEffect10102ui_story == nil then
				arg_377_1.var_.characterEffect10102ui_story = var_380_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_5 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_5 and not isNil(var_380_4) then
				if arg_377_1.var_.characterEffect10102ui_story and not isNil(var_380_4) then
					arg_377_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_377_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_5)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_5 and arg_377_1.time_ < 0 + var_380_5 + arg_380_0 and not isNil(var_380_4) and arg_377_1.var_.characterEffect10102ui_story then
				arg_377_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_377_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 5.86666666666667 < arg_377_1.time_ and arg_377_1.time_ <= 5.86666666666667 + arg_380_0 then
				if arg_377_1.var_.effect1071 then
					Object.Destroy(arg_377_1.var_.effect1071)

					arg_377_1.var_.effect1071 = nil
				end
			end

			if 5.86666666666667 < arg_377_1.time_ and arg_377_1.time_ <= 5.86666666666667 + arg_380_0 then
				if arg_377_1.var_.effect1072 then
					Object.Destroy(arg_377_1.var_.effect1072)

					arg_377_1.var_.effect1072 = nil
				end
			end

			local var_380_8 = 0
			local var_380_9 = 0.2

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_10 = arg_377_1:GetWordFromCfg(421081088)
				local var_380_11 = arg_377_1:FormatText(var_380_10.content)

				arg_377_1.text_.text = var_380_11

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_13 = 8 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 8)

				if (8 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 8)) > 0 and var_380_9 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_8
					end
				end

				arg_377_1.text_.text = var_380_11
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421081", "421081088", "story_v_out_421081.awb") ~= 0 then
					local var_380_14 = manager.audio:GetVoiceLength("story_v_out_421081", "421081088", "story_v_out_421081.awb") / 1000

					if var_380_14 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_14 + var_380_8
					end

					if var_380_10.prefab_name ~= "" and arg_377_1.actors_[var_380_10.prefab_name] ~= nil then
						local var_380_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_10.prefab_name].transform, "story_v_out_421081", "421081088", "story_v_out_421081.awb")

						arg_377_1:RecordAudio("421081088", var_380_15)
						arg_377_1:RecordAudio("421081088", var_380_15)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_421081", "421081088", "story_v_out_421081.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_421081", "421081088", "story_v_out_421081.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_9, arg_377_1.talkMaxDuration)

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_8) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_8 + var_380_16 and arg_377_1.time_ < var_380_8 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L08h",
		"TextureConfig/Background/ST34a",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/I08a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I08"
	},
	voices = {
		"story_v_out_421081.awb"
	}
}
