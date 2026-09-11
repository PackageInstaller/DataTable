return {
	Play109111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play109111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C06b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C06b")
				var_4_0.name = "C06b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C06b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C06b

				arg_1_1.bgs_.C06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C06b:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC06b = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC06b = var_4_4
				end

				arg_1_1.var_.alphaOldValueC06b = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC06b then
					arg_1_1.var_.alphaMatValueC06b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC06b, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC06b.color = arg_1_1.var_.alphaMatValueC06b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC06b then
				arg_1_1.var_.alphaMatValueC06b.color.a = 1
				arg_1_1.var_.alphaMatValueC06b.color = arg_1_1.var_.alphaMatValueC06b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 2 and arg_1_1.time_ < var_4_9 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 2
			local var_4_11 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(109111001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 15 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 15)

				if (15 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 15)) > 0 and var_4_11 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15
					var_4_10 = var_4_10 + 0.3

					if var_4_15 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_13
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_16 = var_4_10 + 0.3
			local var_4_17 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_17

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109111002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.725

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(109111002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 29)

				if (29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 29)) > 0 and var_11_0 < var_11_3 then
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
	Play109111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109111003
		arg_12_1.duration_ = 5.2

		local var_12_0 = {
			ja = 5,
			ko = 4.066,
			zh = 5.2,
			en = 3.766
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
				arg_12_0:Play109111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(109111003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 13 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 13)

				if (13 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 13)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111003", "story_v_out_109111.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111003", "story_v_out_109111.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_109111", "109111003", "story_v_out_109111.awb")

						arg_12_1:RecordAudio("109111003", var_15_6)
						arg_12_1:RecordAudio("109111003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109111", "109111003", "story_v_out_109111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109111", "109111003", "story_v_out_109111.awb")
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
	Play109111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109111004
		arg_16_1.duration_ = 4.03

		local var_16_0 = {
			ja = 4.033,
			ko = 2.9,
			zh = 2.066,
			en = 2.166
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
				arg_16_0:Play109111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.25

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(109111004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 10 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 10)

				if (10 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 10)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111004", "story_v_out_109111.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111004", "story_v_out_109111.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_109111", "109111004", "story_v_out_109111.awb")

						arg_16_1:RecordAudio("109111004", var_19_6)
						arg_16_1:RecordAudio("109111004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109111", "109111004", "story_v_out_109111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109111", "109111004", "story_v_out_109111.awb")
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
	Play109111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109111005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1058ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1058ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1058ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1058ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1058ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1058ui_story == nil then
				arg_20_1.var_.characterEffect1058ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect1058ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_4)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1058ui_story then
				arg_20_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_23_5 = 0
			local var_23_6 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_7 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(109111005).content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 17 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 17)

				if (17 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 17)) > 0 and var_23_6 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_10 and arg_20_1.time_ < var_23_5 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109111006
		arg_24_1.duration_ = 11.57

		local var_24_0 = {
			ja = 11.566,
			ko = 6.566,
			zh = 8.8,
			en = 9.766
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
				arg_24_0:Play109111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.7

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(109111006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 28 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 28)

				if (28 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 28)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111006", "story_v_out_109111.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111006", "story_v_out_109111.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_109111", "109111006", "story_v_out_109111.awb")

						arg_24_1:RecordAudio("109111006", var_27_6)
						arg_24_1:RecordAudio("109111006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109111", "109111006", "story_v_out_109111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109111", "109111006", "story_v_out_109111.awb")
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
	Play109111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109111007
		arg_28_1.duration_ = 13.03

		local var_28_0 = {
			ja = 13.033,
			ko = 4.2,
			zh = 6.8,
			en = 9.7
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
				arg_28_0:Play109111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.425

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(109111007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 17 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 17)

				if (17 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 17)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111007", "story_v_out_109111.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111007", "story_v_out_109111.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_109111", "109111007", "story_v_out_109111.awb")

						arg_28_1:RecordAudio("109111007", var_31_6)
						arg_28_1:RecordAudio("109111007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109111", "109111007", "story_v_out_109111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109111", "109111007", "story_v_out_109111.awb")
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
	Play109111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109111008
		arg_32_1.duration_ = 7.17

		local var_32_0 = {
			ja = 4.866,
			ko = 6.766,
			zh = 5.233,
			en = 7.166
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
				arg_32_0:Play109111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1058ui_story"]) and arg_32_1.var_.characterEffect1058ui_story == nil then
				arg_32_1.var_.characterEffect1058ui_story = arg_32_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1058ui_story"]) then
				if arg_32_1.var_.characterEffect1058ui_story and not isNil(arg_32_1.actors_["1058ui_story"]) then
					arg_32_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1058ui_story"]) and arg_32_1.var_.characterEffect1058ui_story then
				arg_32_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_35_2 = arg_32_1.actors_["1058ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1058ui_story = var_35_2.localPosition
			end

			local var_35_3 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 then
				var_35_2.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_32_1.time_ - 0) / var_35_3)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 then
				var_35_2.localPosition = Vector3.New(0, -0.95, -5.88)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles
			end

			local var_35_4 = 0
			local var_35_5 = 0.725

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(109111008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 29 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 29)

				if (29 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 29)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111008", "story_v_out_109111.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_109111", "109111008", "story_v_out_109111.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_109111", "109111008", "story_v_out_109111.awb")

						arg_32_1:RecordAudio("109111008", var_35_11)
						arg_32_1:RecordAudio("109111008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109111", "109111008", "story_v_out_109111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109111", "109111008", "story_v_out_109111.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play109111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109111009
		arg_36_1.duration_ = 2.8

		local var_36_0 = {
			ja = 2.8,
			ko = 1.766,
			zh = 2.733,
			en = 1.5
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
				arg_36_0:Play109111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1058ui_story"]) and arg_36_1.var_.characterEffect1058ui_story == nil then
				arg_36_1.var_.characterEffect1058ui_story = arg_36_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1058ui_story"]) then
				if arg_36_1.var_.characterEffect1058ui_story and not isNil(arg_36_1.actors_["1058ui_story"]) then
					arg_36_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1058ui_story"]) and arg_36_1.var_.characterEffect1058ui_story then
				arg_36_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.125

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(109111009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 5 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 5)

				if (5 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 5)) > 0 and var_39_2 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111009", "story_v_out_109111.awb") ~= 0 then
					local var_39_7 = manager.audio:GetVoiceLength("story_v_out_109111", "109111009", "story_v_out_109111.awb") / 1000

					if var_39_7 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_1
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_109111", "109111009", "story_v_out_109111.awb")

						arg_36_1:RecordAudio("109111009", var_39_8)
						arg_36_1:RecordAudio("109111009", var_39_8)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109111", "109111009", "story_v_out_109111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109111", "109111009", "story_v_out_109111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_9 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_9 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_9

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_9 and arg_36_1.time_ < var_39_1 + var_39_9 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play109111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109111010
		arg_40_1.duration_ = 6.87

		local var_40_0 = {
			ja = 6.866,
			ko = 4.5,
			zh = 5.9,
			en = 4.966
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
				arg_40_0:Play109111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.7

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(109111010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 28 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 28)

				if (28 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 28)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111010", "story_v_out_109111.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111010", "story_v_out_109111.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_109111", "109111010", "story_v_out_109111.awb")

						arg_40_1:RecordAudio("109111010", var_43_6)
						arg_40_1:RecordAudio("109111010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109111", "109111010", "story_v_out_109111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109111", "109111010", "story_v_out_109111.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play109111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109111011
		arg_44_1.duration_ = 6.07

		local var_44_0 = {
			ja = 5.7,
			ko = 5.6,
			zh = 4.366,
			en = 6.066
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
				arg_44_0:Play109111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1058ui_story"]) and arg_44_1.var_.characterEffect1058ui_story == nil then
				arg_44_1.var_.characterEffect1058ui_story = arg_44_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1058ui_story"]) then
				if arg_44_1.var_.characterEffect1058ui_story and not isNil(arg_44_1.actors_["1058ui_story"]) then
					arg_44_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1058ui_story"]) and arg_44_1.var_.characterEffect1058ui_story then
				arg_44_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action424")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_47_2 = 0
			local var_47_3 = 0.575

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(109111011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 23 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 23)

				if (23 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 23)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111011", "story_v_out_109111.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_109111", "109111011", "story_v_out_109111.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_109111", "109111011", "story_v_out_109111.awb")

						arg_44_1:RecordAudio("109111011", var_47_9)
						arg_44_1:RecordAudio("109111011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109111", "109111011", "story_v_out_109111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109111", "109111011", "story_v_out_109111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109111012
		arg_48_1.duration_ = 18.33

		local var_48_0 = {
			ja = 17.6,
			ko = 13.266,
			zh = 9.733,
			en = 18.333
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
				arg_48_0:Play109111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_0 = 0
			local var_51_1 = 1.3

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(109111012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 53 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 53)

				if (53 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 53)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111012", "story_v_out_109111.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_109111", "109111012", "story_v_out_109111.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_109111", "109111012", "story_v_out_109111.awb")

						arg_48_1:RecordAudio("109111012", var_51_7)
						arg_48_1:RecordAudio("109111012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109111", "109111012", "story_v_out_109111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109111", "109111012", "story_v_out_109111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109111013
		arg_52_1.duration_ = 12.13

		local var_52_0 = {
			ja = 12.133,
			ko = 7.7,
			zh = 6.566,
			en = 6.966
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
				arg_52_0:Play109111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_55_0 = 0
			local var_55_1 = 0.9

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(109111013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 35 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 35)

				if (35 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 35)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111013", "story_v_out_109111.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_109111", "109111013", "story_v_out_109111.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_109111", "109111013", "story_v_out_109111.awb")

						arg_52_1:RecordAudio("109111013", var_55_7)
						arg_52_1:RecordAudio("109111013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_109111", "109111013", "story_v_out_109111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_109111", "109111013", "story_v_out_109111.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play109111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109111014
		arg_56_1.duration_ = 6.5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play109111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if arg_56_1.bgs_.S0609 == nil then
				local var_59_0 = Object.Instantiate(arg_56_1.paintGo_)

				var_59_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0609")
				var_59_0.name = "S0609"
				var_59_0.transform.parent = arg_56_1.stage_.transform
				var_59_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.bgs_.S0609 = var_59_0
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				local var_59_1 = arg_56_1.bgs_.S0609

				arg_56_1.bgs_.S0609.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_59_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_2 = var_59_1:GetComponent("SpriteRenderer")

				if var_59_2 and var_59_2.sprite then
					local var_59_3 = 2 * (var_59_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_59_1.transform.localScale = Vector3.New(var_59_3 / var_59_2.sprite.bounds.size.y < var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x and var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x or var_59_3 / var_59_2.sprite.bounds.size.y, var_59_3 / var_59_2.sprite.bounds.size.y < var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x and var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x or var_59_3 / var_59_2.sprite.bounds.size.y, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "S0609" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_4 = arg_56_1.actors_["1058ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1058ui_story = var_59_4.localPosition
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_4.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_5)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_4.localPosition = Vector3.New(0, 100, 0)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				local var_59_6 = arg_56_1.bgs_.S0609:GetComponent("SpriteRenderer")

				if var_59_6 then
					arg_56_1.var_.alphaOldValueS0609 = var_59_6.color.a
					arg_56_1.var_.alphaMatValueS0609 = var_59_6
				end

				arg_56_1.var_.alphaOldValueS0609 = 0
			end

			local var_59_7 = 1.5

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_7 then
				if arg_56_1.var_.alphaMatValueS0609 then
					arg_56_1.var_.alphaMatValueS0609.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueS0609, 1, (arg_56_1.time_ - 1.5) / var_59_7)
					arg_56_1.var_.alphaMatValueS0609.color = arg_56_1.var_.alphaMatValueS0609.color
				end
			end

			if arg_56_1.time_ >= 1.5 + var_59_7 and arg_56_1.time_ < 1.5 + var_59_7 + arg_59_0 and arg_56_1.var_.alphaMatValueS0609 then
				arg_56_1.var_.alphaMatValueS0609.color.a = 1
				arg_56_1.var_.alphaMatValueS0609.color = arg_56_1.var_.alphaMatValueS0609.color
			end

			local var_59_8 = arg_56_1.bgs_.S0609.transform

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				arg_56_1.var_.moveOldPosS0609 = var_59_8.localPosition
			end

			local var_59_9 = 2

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_9 then
				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosS0609, Vector3.New(0, 1, 9.5), (arg_56_1.time_ - 1.5) / var_59_9)
			end

			if arg_56_1.time_ >= 1.5 + var_59_9 and arg_56_1.time_ < 1.5 + var_59_9 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_10 = arg_56_1.bgs_.C06b:GetComponent("SpriteRenderer")

				if var_59_10 then
					arg_56_1.var_.alphaOldValueC06b = var_59_10.color.a
					arg_56_1.var_.alphaMatValueC06b = var_59_10
				end

				arg_56_1.var_.alphaOldValueC06b = 1
			end

			local var_59_11 = 1.5

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_11 then
				if arg_56_1.var_.alphaMatValueC06b then
					arg_56_1.var_.alphaMatValueC06b.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueC06b, 0, (arg_56_1.time_ - 0) / var_59_11)
					arg_56_1.var_.alphaMatValueC06b.color = arg_56_1.var_.alphaMatValueC06b.color
				end
			end

			if arg_56_1.time_ >= 0 + var_59_11 and arg_56_1.time_ < 0 + var_59_11 + arg_59_0 and arg_56_1.var_.alphaMatValueC06b then
				arg_56_1.var_.alphaMatValueC06b.color.a = 0
				arg_56_1.var_.alphaMatValueC06b.color = arg_56_1.var_.alphaMatValueC06b.color
			end

			local var_59_12 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_12 + 1.5 and arg_56_1.time_ < var_59_12 + 1.5 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_13 = 1.5
			local var_59_14 = 1.425

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_15 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_15:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_16 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(109111014).content)

				arg_56_1.text_.text = var_59_16

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_18 = 57 <= 0 and var_59_14 or var_59_14 * (utf8.len(var_59_16) / 57)

				if (57 <= 0 and var_59_14 or var_59_14 * (utf8.len(var_59_16) / 57)) > 0 and var_59_14 < var_59_18 then
					arg_56_1.talkMaxDuration = var_59_18
					var_59_13 = var_59_13 + 0.3

					if var_59_18 + var_59_13 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_13
					end
				end

				arg_56_1.text_.text = var_59_16
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_19 = var_59_13 + 0.3
			local var_59_20 = math.max(var_59_14, arg_56_1.talkMaxDuration)

			if var_59_13 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_19 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_19) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_19 + var_59_20 and arg_56_1.time_ < var_59_19 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "S0609",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play109111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 109111015
		arg_62_1.duration_ = 9.47

		local var_62_0 = {
			ja = 7.966,
			ko = 6.533,
			zh = 9.466,
			en = 8.733
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play109111016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.65

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(109111015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 26 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 26)

				if (26 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 26)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111015", "story_v_out_109111.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111015", "story_v_out_109111.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_109111", "109111015", "story_v_out_109111.awb")

						arg_62_1:RecordAudio("109111015", var_65_6)
						arg_62_1:RecordAudio("109111015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_109111", "109111015", "story_v_out_109111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_109111", "109111015", "story_v_out_109111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play109111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 109111016
		arg_66_1.duration_ = 11.63

		local var_66_0 = {
			ja = 8.566,
			ko = 6.366,
			zh = 9.166,
			en = 11.633
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play109111017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.825

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(109111016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 33 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 33)

				if (33 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 33)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111016", "story_v_out_109111.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111016", "story_v_out_109111.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_109111", "109111016", "story_v_out_109111.awb")

						arg_66_1:RecordAudio("109111016", var_69_6)
						arg_66_1:RecordAudio("109111016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_109111", "109111016", "story_v_out_109111.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_109111", "109111016", "story_v_out_109111.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play109111017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 109111017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play109111018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.225

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(109111017).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 49 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 49)

				if (49 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 49)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play109111018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 109111018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play109111019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.95

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(109111018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 38 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 38)

				if (38 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 38)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play109111019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 109111019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play109111020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.8

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(109111019).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 32 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 32)

				if (32 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 32)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play109111020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 109111020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play109111021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0.85 < arg_82_1.time_ and arg_82_1.time_ <= 0.85 + arg_85_0 then
				arg_82_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_85_0 = 0.1

			if 0.85 <= arg_82_1.time_ and arg_82_1.time_ < 0.85 + var_85_0 then
				local var_85_1, var_85_2 = math.modf((arg_82_1.time_ - 0.85) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_85_2 * 0.13, var_85_2 * 0.13, var_85_2 * 0.13) + arg_82_1.var_.shakeOldPos
			end

			if arg_82_1.time_ >= 0.85 + var_85_0 and arg_82_1.time_ < 0.85 + var_85_0 + arg_85_0 then
				manager.ui.mainCamera.transform.localPosition = arg_82_1.var_.shakeOldPos
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:AudioAction("play", "effect", "se_story_9", "se_story_9_tearing", "")
			end

			local var_85_4 = 0
			local var_85_5 = 0.925

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(109111020).content)

				arg_82_1.text_.text = var_85_6

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_8 = 37 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_6) / 37)

				if (37 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_6) / 37)) > 0 and var_85_5 < var_85_8 then
					arg_82_1.talkMaxDuration = var_85_8

					if var_85_8 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_6
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_9 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_9 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_9

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_9 and arg_82_1.time_ < var_85_4 + var_85_9 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play109111021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 109111021
		arg_86_1.duration_ = 1.9

		local var_86_0 = {
			ja = 1.9,
			ko = 1.466,
			zh = 1.033,
			en = 1.633
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
				arg_86_0:Play109111022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.125

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(109111021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 5 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 5)

				if (5 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 5)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111021", "story_v_out_109111.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111021", "story_v_out_109111.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_109111", "109111021", "story_v_out_109111.awb")

						arg_86_1:RecordAudio("109111021", var_89_6)
						arg_86_1:RecordAudio("109111021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_109111", "109111021", "story_v_out_109111.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_109111", "109111021", "story_v_out_109111.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play109111022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 109111022
		arg_90_1.duration_ = 7.27

		local var_90_0 = {
			ja = 4.7,
			ko = 4.3,
			zh = 7.266,
			en = 7.1
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
				arg_90_0:Play109111023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.35

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(109111022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 13 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 13)

				if (13 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 13)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111022", "story_v_out_109111.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111022", "story_v_out_109111.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_109111", "109111022", "story_v_out_109111.awb")

						arg_90_1:RecordAudio("109111022", var_93_6)
						arg_90_1:RecordAudio("109111022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_109111", "109111022", "story_v_out_109111.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_109111", "109111022", "story_v_out_109111.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play109111023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 109111023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play109111024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.575

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

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(109111023).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 23)

				if (23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 23)) > 0 and var_97_0 < var_97_3 then
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
	Play109111024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 109111024
		arg_98_1.duration_ = 8.7

		local var_98_0 = {
			ja = 8.7,
			ko = 5.766,
			zh = 5.7,
			en = 5.933
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
				arg_98_0:Play109111025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.525

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(109111024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 22 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 22)

				if (22 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 22)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111024", "story_v_out_109111.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111024", "story_v_out_109111.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_109111", "109111024", "story_v_out_109111.awb")

						arg_98_1:RecordAudio("109111024", var_101_6)
						arg_98_1:RecordAudio("109111024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_109111", "109111024", "story_v_out_109111.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_109111", "109111024", "story_v_out_109111.awb")
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
	Play109111025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 109111025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play109111026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.575

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(109111025).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 23 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 23)

				if (23 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 23)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play109111026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 109111026
		arg_106_1.duration_ = 2.43

		local var_106_0 = {
			ja = 2.433,
			ko = 1.233,
			zh = 1.7,
			en = 2.266
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
				arg_106_0:Play109111027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.1

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(109111026)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 4 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 4)

				if (4 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 4)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111026", "story_v_out_109111.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111026", "story_v_out_109111.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_109111", "109111026", "story_v_out_109111.awb")

						arg_106_1:RecordAudio("109111026", var_109_6)
						arg_106_1:RecordAudio("109111026", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_109111", "109111026", "story_v_out_109111.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_109111", "109111026", "story_v_out_109111.awb")
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
	Play109111027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 109111027
		arg_110_1.duration_ = 12

		local var_110_0 = {
			ja = 12,
			ko = 4.833,
			zh = 9.1,
			en = 10.1
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
				arg_110_0:Play109111028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.475

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(109111027)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 19 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 19)

				if (19 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 19)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111027", "story_v_out_109111.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111027", "story_v_out_109111.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_109111", "109111027", "story_v_out_109111.awb")

						arg_110_1:RecordAudio("109111027", var_113_6)
						arg_110_1:RecordAudio("109111027", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_109111", "109111027", "story_v_out_109111.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_109111", "109111027", "story_v_out_109111.awb")
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
	Play109111028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 109111028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play109111029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.375

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(109111028).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 15 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 15)

				if (15 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 15)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play109111029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 109111029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play109111030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 1.775

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(109111029).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 68 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 68)

				if (68 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 68)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play109111030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 109111030
		arg_122_1.duration_ = 4.3

		local var_122_0 = {
			ja = 4.3,
			ko = 2.033,
			zh = 1.7,
			en = 3.166
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
				arg_122_0:Play109111031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.175

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_1 = arg_122_1:GetWordFromCfg(109111030)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 7 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 7)

				if (7 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 7)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111030", "story_v_out_109111.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111030", "story_v_out_109111.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_109111", "109111030", "story_v_out_109111.awb")

						arg_122_1:RecordAudio("109111030", var_125_6)
						arg_122_1:RecordAudio("109111030", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_109111", "109111030", "story_v_out_109111.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_109111", "109111030", "story_v_out_109111.awb")
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
	Play109111031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 109111031
		arg_126_1.duration_ = 9.8

		local var_126_0 = {
			ja = 9.8,
			ko = 6.2,
			zh = 7.8,
			en = 9.8
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
				arg_126_0:Play109111032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.675

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(109111031)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 27 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 27)

				if (27 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 27)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111031", "story_v_out_109111.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111031", "story_v_out_109111.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_109111", "109111031", "story_v_out_109111.awb")

						arg_126_1:RecordAudio("109111031", var_129_6)
						arg_126_1:RecordAudio("109111031", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_109111", "109111031", "story_v_out_109111.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_109111", "109111031", "story_v_out_109111.awb")
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
	Play109111032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 109111032
		arg_130_1.duration_ = 3.97

		local var_130_0 = {
			ja = 3.933,
			ko = 2.9,
			zh = 2.466,
			en = 3.966
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
				arg_130_0:Play109111033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.3

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_1 = arg_130_1:GetWordFromCfg(109111032)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 12 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 12)

				if (12 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 12)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111032", "story_v_out_109111.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111032", "story_v_out_109111.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_109111", "109111032", "story_v_out_109111.awb")

						arg_130_1:RecordAudio("109111032", var_133_6)
						arg_130_1:RecordAudio("109111032", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_109111", "109111032", "story_v_out_109111.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_109111", "109111032", "story_v_out_109111.awb")
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
	Play109111033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 109111033
		arg_134_1.duration_ = 3.43

		local var_134_0 = {
			ja = 2.066,
			ko = 2.2,
			zh = 3.433,
			en = 2.266
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
				arg_134_0:Play109111034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.225

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:GetWordFromCfg(109111033)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 9 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 9)

				if (9 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 9)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111033", "story_v_out_109111.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111033", "story_v_out_109111.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_109111", "109111033", "story_v_out_109111.awb")

						arg_134_1:RecordAudio("109111033", var_137_6)
						arg_134_1:RecordAudio("109111033", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_109111", "109111033", "story_v_out_109111.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_109111", "109111033", "story_v_out_109111.awb")
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
	Play109111034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 109111034
		arg_138_1.duration_ = 9.27

		local var_138_0 = {
			ja = 8.666,
			ko = 9.266,
			zh = 8.6,
			en = 9.166
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
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 1.15

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:GetWordFromCfg(109111034)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 46 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 46)

				if (46 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 46)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109111", "109111034", "story_v_out_109111.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_out_109111", "109111034", "story_v_out_109111.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_out_109111", "109111034", "story_v_out_109111.awb")

						arg_138_1:RecordAudio("109111034", var_141_6)
						arg_138_1:RecordAudio("109111034", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_109111", "109111034", "story_v_out_109111.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_109111", "109111034", "story_v_out_109111.awb")
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
	assets = {
		"TextureConfig/Background/C06b",
		"TextureConfig/Background/S0609"
	},
	voices = {
		"story_v_out_109111.awb"
	}
}
