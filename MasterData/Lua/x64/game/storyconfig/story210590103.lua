return {
	Play105903001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105903001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play105903002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_mood_daily", "bgm_story_mood_daily", "bgm_story_mood_daily")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_mood_daily", "bgm_story_mood_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "ST03"

			if arg_1_1.bgs_.ST03 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.ST03

				arg_1_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_8 = 0
			local var_4_9 = 1.45

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_10 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_10:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(105903001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 59 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 59)

				if (59 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 59)) > 0 and var_4_9 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13
					var_4_8 = var_4_8 + 0.3

					if var_4_13 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_8
					end
				end

				arg_1_1.text_.text = var_4_11
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_14 = var_4_8 + 0.3
			local var_4_15 = math.max(var_4_9, arg_1_1.talkMaxDuration)

			if var_4_8 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_15

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play105903002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105903002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play105903003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.975

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(105903002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 39 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 39)

				if (39 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 39)) > 0 and var_11_0 < var_11_3 then
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
	Play105903003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105903003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play105903004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.725

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(105903003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 29 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 29)

				if (29 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 29)) > 0 and var_15_0 < var_15_3 then
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
	Play105903004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105903004
		arg_16_1.duration_ = 6.8

		local var_16_0 = {
			ja = 5.266,
			ko = 6.8
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
				arg_16_0:Play105903005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.8

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(105903004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 30 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 30)

				if (30 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 30)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903004", "story_v_side_old_105903.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903004", "story_v_side_old_105903.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_side_old_105903", "105903004", "story_v_side_old_105903.awb")

						arg_16_1:RecordAudio("105903004", var_19_6)
						arg_16_1:RecordAudio("105903004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903004", "story_v_side_old_105903.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903004", "story_v_side_old_105903.awb")
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
	Play105903005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105903005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play105903006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(105903005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 17)

				if (17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 17)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play105903006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105903006
		arg_24_1.duration_ = 8.67

		local var_24_0 = {
			ja = 6.033,
			ko = 8.666
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
				arg_24_0:Play105903007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.825

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(105903006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 32 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 32)

				if (32 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 32)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903006", "story_v_side_old_105903.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903006", "story_v_side_old_105903.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_side_old_105903", "105903006", "story_v_side_old_105903.awb")

						arg_24_1:RecordAudio("105903006", var_27_6)
						arg_24_1:RecordAudio("105903006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903006", "story_v_side_old_105903.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903006", "story_v_side_old_105903.awb")
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
	Play105903007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105903007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105903008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(105903007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 16 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 16)

				if (16 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 16)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play105903008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105903008
		arg_32_1.duration_ = 2.97

		local var_32_0 = {
			ja = 2.966,
			ko = 2.066
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
				arg_32_0:Play105903009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.175

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(105903008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 7 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 7)

				if (7 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 7)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903008", "story_v_side_old_105903.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903008", "story_v_side_old_105903.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_side_old_105903", "105903008", "story_v_side_old_105903.awb")

						arg_32_1:RecordAudio("105903008", var_35_6)
						arg_32_1:RecordAudio("105903008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903008", "story_v_side_old_105903.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903008", "story_v_side_old_105903.awb")
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
	Play105903009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 105903009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play105903010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.225

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(105903009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 49 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 49)

				if (49 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 49)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play105903010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 105903010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play105903011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 1.225

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(105903010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 49 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 49)

				if (49 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 49)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play105903011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105903011
		arg_44_1.duration_ = 5.1

		local var_44_0 = {
			ja = 5.1,
			ko = 3.266
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
				arg_44_0:Play105903012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_47_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_44_1.stage_.transform)

				var_47_0.name = "1148ui_story"
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1148ui_story"] = var_47_0

				local var_47_1 = var_47_0:GetComponentInChildren(typeof(CharacterEffect))

				var_47_1.enabled = true

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_1.transform, false)

				arg_44_1.var_["1148ui_story" .. "Animator"] = var_47_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_44_1.var_["1148ui_story" .. "LipSync"] = var_47_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_3 = arg_44_1.actors_["1148ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1148ui_story == nil then
				arg_44_1.var_.characterEffect1148ui_story = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect1148ui_story and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1148ui_story then
				arg_44_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_47_6 = 0
			local var_47_7 = 0.2

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(105903011)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 8 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 8)

				if (8 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 8)) > 0 and var_47_7 < var_47_11 then
					arg_44_1.talkMaxDuration = var_47_11

					if var_47_11 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903011", "story_v_side_old_105903.awb") ~= 0 then
					local var_47_12 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903011", "story_v_side_old_105903.awb") / 1000

					if var_47_12 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_6
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_side_old_105903", "105903011", "story_v_side_old_105903.awb")

						arg_44_1:RecordAudio("105903011", var_47_13)
						arg_44_1:RecordAudio("105903011", var_47_13)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903011", "story_v_side_old_105903.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903011", "story_v_side_old_105903.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play105903012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105903012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play105903013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1148ui_story"]) and arg_48_1.var_.characterEffect1148ui_story == nil then
				arg_48_1.var_.characterEffect1148ui_story = arg_48_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1148ui_story"]) then
				if arg_48_1.var_.characterEffect1148ui_story and not isNil(arg_48_1.actors_["1148ui_story"]) then
					arg_48_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1148ui_story"]) and arg_48_1.var_.characterEffect1148ui_story then
				arg_48_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 1.45

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(105903012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 58 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 58)

				if (58 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 58)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play105903013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105903013
		arg_52_1.duration_ = 4.5

		local var_52_0 = {
			ja = 4.5,
			ko = 3.333
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
				arg_52_0:Play105903014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPosST03 = arg_52_1.bgs_.ST03.transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.bgs_.ST03.transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosST03, Vector3.New(0, -100, 10), (arg_52_1.time_ - 0) / var_55_0)
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.bgs_.ST03.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_55_1 = "D04a"

			if arg_52_1.bgs_.D04a == nil then
				local var_55_2 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_1)
				var_55_2.name = var_55_1
				var_55_2.transform.parent = arg_52_1.stage_.transform
				var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_1] = var_55_2
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_3 = arg_52_1.bgs_.D04a

				arg_52_1.bgs_.D04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_4 = var_55_3:GetComponent("SpriteRenderer")

				if var_55_4 and var_55_4.sprite then
					local var_55_5 = 2 * (var_55_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_3.transform.localScale = Vector3.New(var_55_5 / var_55_4.sprite.bounds.size.y < var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x and var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x or var_55_5 / var_55_4.sprite.bounds.size.y, var_55_5 / var_55_4.sprite.bounds.size.y < var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x and var_55_5 * manager.ui.mainCameraCom_.aspect / var_55_4.sprite.bounds.size.x or var_55_5 / var_55_4.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "D04a" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_6 = arg_52_1.actors_["1148ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1148ui_story = var_55_6.localPosition
			end

			local var_55_7 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				var_55_6.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_52_1.time_ - 0) / var_55_7)
				var_55_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_6.position).x, (manager.ui.mainCamera.transform.position - var_55_6.position).y, (manager.ui.mainCamera.transform.position - var_55_6.position).z)
				var_55_6.localEulerAngles.z = 0
				var_55_6.localEulerAngles.x = 0
				var_55_6.localEulerAngles = var_55_6.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				var_55_6.localPosition = Vector3.New(10, -0.85, -5.6)
				var_55_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_6.position).x, (manager.ui.mainCamera.transform.position - var_55_6.position).y, (manager.ui.mainCamera.transform.position - var_55_6.position).z)
				var_55_6.localEulerAngles.z = 0
				var_55_6.localEulerAngles.x = 0
				var_55_6.localEulerAngles = var_55_6.localEulerAngles
			end

			local var_55_8 = 0
			local var_55_9 = 0.3

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_10 = arg_52_1:GetWordFromCfg(105903013)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 12 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 12)

				if (12 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 12)) > 0 and var_55_9 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903013", "story_v_side_old_105903.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903013", "story_v_side_old_105903.awb") / 1000

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end

					if var_55_10.prefab_name ~= "" and arg_52_1.actors_[var_55_10.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_10.prefab_name].transform, "story_v_side_old_105903", "105903013", "story_v_side_old_105903.awb")

						arg_52_1:RecordAudio("105903013", var_55_15)
						arg_52_1:RecordAudio("105903013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903013", "story_v_side_old_105903.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903013", "story_v_side_old_105903.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_16 and arg_52_1.time_ < var_55_8 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play105903014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105903014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play105903015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.225

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

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(105903014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 49 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 49)

				if (49 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 49)) > 0 and var_59_0 < var_59_3 then
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
	Play105903015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 105903015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play105903016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.425

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(105903015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 17 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 17)

				if (17 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 17)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play105903016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 105903016
		arg_64_1.duration_ = 8.2

		local var_64_0 = {
			ja = 8.2,
			ko = 4.366
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
				arg_64_0:Play105903017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.55

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(105903016)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 22 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 22)

				if (22 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 22)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903016", "story_v_side_old_105903.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903016", "story_v_side_old_105903.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_side_old_105903", "105903016", "story_v_side_old_105903.awb")

						arg_64_1:RecordAudio("105903016", var_67_6)
						arg_64_1:RecordAudio("105903016", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903016", "story_v_side_old_105903.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903016", "story_v_side_old_105903.awb")
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
	Play105903017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 105903017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play105903018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.05

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(105903017).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 2 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 2)

				if (2 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 2)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play105903018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 105903018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play105903019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.45

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(105903018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 58 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 58)

				if (58 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 58)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play105903019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 105903019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play105903020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.225

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(105903019).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 9 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 9)

				if (9 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 9)) > 0 and var_79_0 < var_79_3 then
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
	Play105903020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 105903020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play105903021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.475

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(105903020).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 19 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 19)

				if (19 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 19)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play105903021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 105903021
		arg_84_1.duration_ = 6.63

		local var_84_0 = {
			ja = 5.7,
			ko = 6.633
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
				arg_84_0:Play105903022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.6

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(105903021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 24 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 24)

				if (24 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 24)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903021", "story_v_side_old_105903.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903021", "story_v_side_old_105903.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_side_old_105903", "105903021", "story_v_side_old_105903.awb")

						arg_84_1:RecordAudio("105903021", var_87_6)
						arg_84_1:RecordAudio("105903021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903021", "story_v_side_old_105903.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903021", "story_v_side_old_105903.awb")
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
	Play105903022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 105903022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play105903023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.675

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(105903022).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 27 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 27)

				if (27 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 27)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play105903023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 105903023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play105903024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.45

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(105903023).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 18 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 18)

				if (18 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 18)) > 0 and var_95_0 < var_95_3 then
					arg_92_1.talkMaxDuration = var_95_3

					if var_95_3 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_3 + 0
					end
				end

				arg_92_1.text_.text = var_95_1
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_4 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_4

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play105903024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 105903024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play105903025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 1.375

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(105903024).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 55 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 55)

				if (55 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 55)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play105903025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 105903025
		arg_100_1.duration_ = 11.33

		local var_100_0 = {
			ja = 9.266,
			ko = 11.333
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
				arg_100_0:Play105903026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) and arg_100_1.var_.characterEffect1148ui_story == nil then
				arg_100_1.var_.characterEffect1148ui_story = arg_100_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) then
				if arg_100_1.var_.characterEffect1148ui_story and not isNil(arg_100_1.actors_["1148ui_story"]) then
					arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) and arg_100_1.var_.characterEffect1148ui_story then
				arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.bgs_.D04a.transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPosD04a = var_103_2.localPosition
			end

			local var_103_3 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPosD04a, Vector3.New(0, -100, 10), (arg_100_1.time_ - 0) / var_103_3)
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(0, -100, 10)
			end

			local var_103_4 = "B13"

			if arg_100_1.bgs_.B13 == nil then
				local var_103_5 = Object.Instantiate(arg_100_1.paintGo_)

				var_103_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_103_4)
				var_103_5.name = var_103_4
				var_103_5.transform.parent = arg_100_1.stage_.transform
				var_103_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.bgs_[var_103_4] = var_103_5
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				local var_103_6 = arg_100_1.bgs_.B13

				arg_100_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_103_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_103_7 = var_103_6:GetComponent("SpriteRenderer")

				if var_103_7 and var_103_7.sprite then
					local var_103_8 = 2 * (var_103_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_103_6.transform.localScale = Vector3.New(var_103_8 / var_103_7.sprite.bounds.size.y < var_103_8 * manager.ui.mainCameraCom_.aspect / var_103_7.sprite.bounds.size.x and var_103_8 * manager.ui.mainCameraCom_.aspect / var_103_7.sprite.bounds.size.x or var_103_8 / var_103_7.sprite.bounds.size.y, var_103_8 / var_103_7.sprite.bounds.size.y < var_103_8 * manager.ui.mainCameraCom_.aspect / var_103_7.sprite.bounds.size.x and var_103_8 * manager.ui.mainCameraCom_.aspect / var_103_7.sprite.bounds.size.x or var_103_8 / var_103_7.sprite.bounds.size.y, 0)
				end

				for iter_103_0, iter_103_1 in pairs(arg_100_1.bgs_) do
					if iter_103_0 ~= "B13" then
						iter_103_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_103_9 = arg_100_1.actors_["1148ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1148ui_story = var_103_9.localPosition
			end

			local var_103_10 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_10 then
				var_103_9.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.85, -5.6), (arg_100_1.time_ - 0) / var_103_10)
				var_103_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_9.position).x, (manager.ui.mainCamera.transform.position - var_103_9.position).y, (manager.ui.mainCamera.transform.position - var_103_9.position).z)
				var_103_9.localEulerAngles.z = 0
				var_103_9.localEulerAngles.x = 0
				var_103_9.localEulerAngles = var_103_9.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_10 and arg_100_1.time_ < 0 + var_103_10 + arg_103_0 then
				var_103_9.localPosition = Vector3.New(0, -0.85, -5.6)
				var_103_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_9.position).x, (manager.ui.mainCamera.transform.position - var_103_9.position).y, (manager.ui.mainCamera.transform.position - var_103_9.position).z)
				var_103_9.localEulerAngles.z = 0
				var_103_9.localEulerAngles.x = 0
				var_103_9.localEulerAngles = var_103_9.localEulerAngles
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_103_11 = "1048ui_story"

			if arg_100_1.actors_["1048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1048ui_story"))) then
				local var_103_12 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_100_1.stage_.transform)

				var_103_12.name = var_103_11
				var_103_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_[var_103_11] = var_103_12

				local var_103_13 = var_103_12:GetComponentInChildren(typeof(CharacterEffect))

				var_103_13.enabled = true

				local var_103_14 = GameObjectTools.GetOrAddComponent(var_103_12, typeof(DynamicBoneHelper))

				if var_103_14 then
					var_103_14:EnableDynamicBone(false)
				end

				arg_100_1:ShowWeapon(var_103_13.transform, false)

				arg_100_1.var_[var_103_11 .. "Animator"] = var_103_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_100_1.var_[var_103_11 .. "Animator"].applyRootMotion = true
				arg_100_1.var_[var_103_11 .. "LipSync"] = var_103_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_103_15 = 0
			local var_103_16 = 0.875

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_17 = arg_100_1:GetWordFromCfg(105903025)
				local var_103_18 = arg_100_1:FormatText(var_103_17.content)

				arg_100_1.text_.text = var_103_18

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 35 <= 0 and var_103_16 or var_103_16 * (utf8.len(var_103_18) / 35)

				if (35 <= 0 and var_103_16 or var_103_16 * (utf8.len(var_103_18) / 35)) > 0 and var_103_16 < var_103_20 then
					arg_100_1.talkMaxDuration = var_103_20

					if var_103_20 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_15
					end
				end

				arg_100_1.text_.text = var_103_18
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903025", "story_v_side_old_105903.awb") ~= 0 then
					local var_103_21 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903025", "story_v_side_old_105903.awb") / 1000

					if var_103_21 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_21 + var_103_15
					end

					if var_103_17.prefab_name ~= "" and arg_100_1.actors_[var_103_17.prefab_name] ~= nil then
						local var_103_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_17.prefab_name].transform, "story_v_side_old_105903", "105903025", "story_v_side_old_105903.awb")

						arg_100_1:RecordAudio("105903025", var_103_22)
						arg_100_1:RecordAudio("105903025", var_103_22)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903025", "story_v_side_old_105903.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903025", "story_v_side_old_105903.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_23 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_23 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_23

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_23 and arg_100_1.time_ < var_103_15 + var_103_23 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D04a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play105903026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 105903026
		arg_104_1.duration_ = 6.23

		local var_104_0 = {
			ja = 6.233,
			ko = 5.933
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
				arg_104_0:Play105903027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_107_0 = 0
			local var_107_1 = 0.75

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(105903026)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 30 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 30)

				if (30 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 30)) > 0 and var_107_1 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903026", "story_v_side_old_105903.awb") ~= 0 then
					local var_107_6 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903026", "story_v_side_old_105903.awb") / 1000

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end

					if var_107_2.prefab_name ~= "" and arg_104_1.actors_[var_107_2.prefab_name] ~= nil then
						local var_107_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_2.prefab_name].transform, "story_v_side_old_105903", "105903026", "story_v_side_old_105903.awb")

						arg_104_1:RecordAudio("105903026", var_107_7)
						arg_104_1:RecordAudio("105903026", var_107_7)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903026", "story_v_side_old_105903.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903026", "story_v_side_old_105903.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play105903027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 105903027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play105903028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story == nil then
				arg_108_1.var_.characterEffect1148ui_story = arg_108_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) then
				if arg_108_1.var_.characterEffect1148ui_story and not isNil(arg_108_1.actors_["1148ui_story"]) then
					arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story then
				arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_111_1 = arg_108_1.actors_["1148ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1148ui_story = var_111_1.localPosition
			end

			local var_111_2 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 then
				var_111_1.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_108_1.time_ - 0) / var_111_2)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 then
				var_111_1.localPosition = Vector3.New(10, -0.85, -5.6)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			local var_111_3 = 0
			local var_111_4 = 0.65

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_3 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_5 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(105903027).content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 26 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_5) / 26)

				if (26 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_5) / 26)) > 0 and var_111_4 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_3 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_3
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_4, arg_108_1.talkMaxDuration)

			if var_111_3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_3 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_3) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_3 + var_111_8 and arg_108_1.time_ < var_111_3 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play105903028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 105903028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play105903029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.625

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(105903028).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 25 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 25)

				if (25 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 25)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play105903029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 105903029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play105903030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPosB13 = arg_116_1.bgs_.B13.transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.bgs_.B13.transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPosB13, Vector3.New(0, -100, 10), (arg_116_1.time_ - 0) / var_119_0)
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.bgs_.B13.transform.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				local var_119_1 = arg_116_1.bgs_.D04a

				arg_116_1.bgs_.D04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_119_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_2 = var_119_1:GetComponent("SpriteRenderer")

				if var_119_2 and var_119_2.sprite then
					local var_119_3 = 2 * (var_119_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_119_1.transform.localScale = Vector3.New(var_119_3 / var_119_2.sprite.bounds.size.y < var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x and var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x or var_119_3 / var_119_2.sprite.bounds.size.y, var_119_3 / var_119_2.sprite.bounds.size.y < var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x and var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x or var_119_3 / var_119_2.sprite.bounds.size.y, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "D04a" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_119_4 = arg_116_1.actors_["1148ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1148ui_story = var_119_4.localPosition
			end

			local var_119_5 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_5 then
				var_119_4.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_116_1.time_ - 0) / var_119_5)
				var_119_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_4.position).x, (manager.ui.mainCamera.transform.position - var_119_4.position).y, (manager.ui.mainCamera.transform.position - var_119_4.position).z)
				var_119_4.localEulerAngles.z = 0
				var_119_4.localEulerAngles.x = 0
				var_119_4.localEulerAngles = var_119_4.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_5 and arg_116_1.time_ < 0 + var_119_5 + arg_119_0 then
				var_119_4.localPosition = Vector3.New(10, -0.85, -5.6)
				var_119_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_4.position).x, (manager.ui.mainCamera.transform.position - var_119_4.position).y, (manager.ui.mainCamera.transform.position - var_119_4.position).z)
				var_119_4.localEulerAngles.z = 0
				var_119_4.localEulerAngles.x = 0
				var_119_4.localEulerAngles = var_119_4.localEulerAngles
			end

			local var_119_6 = 0
			local var_119_7 = 0.8

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(105903029).content)

				arg_116_1.text_.text = var_119_8

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 32 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_8) / 32)

				if (32 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_8) / 32)) > 0 and var_119_7 < var_119_10 then
					arg_116_1.talkMaxDuration = var_119_10

					if var_119_10 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_8
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_11 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_11 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_11

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_11 and arg_116_1.time_ < var_119_6 + var_119_11 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play105903030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 105903030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play105903031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.15

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(105903030).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 46 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 46)

				if (46 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 46)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play105903031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 105903031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play105903032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.475

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(105903031).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 19 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 19)

				if (19 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 19)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play105903032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 105903032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play105903033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.7

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(105903032).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 28 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 28)

				if (28 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 28)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play105903033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 105903033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play105903034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.35

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(105903033).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 14 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 14)

				if (14 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 14)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play105903034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 105903034
		arg_136_1.duration_ = 7.2

		local var_136_0 = {
			ja = 7.2,
			ko = 5.6
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
				arg_136_0:Play105903035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.5

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(105903034)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 20 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 20)

				if (20 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 20)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903034", "story_v_side_old_105903.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903034", "story_v_side_old_105903.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_side_old_105903", "105903034", "story_v_side_old_105903.awb")

						arg_136_1:RecordAudio("105903034", var_139_6)
						arg_136_1:RecordAudio("105903034", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903034", "story_v_side_old_105903.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903034", "story_v_side_old_105903.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play105903035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 105903035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play105903036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.425

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(105903035).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 17 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 17)

				if (17 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 17)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play105903036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 105903036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play105903037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.125

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(105903036).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 5 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 5)

				if (5 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 5)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play105903037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 105903037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play105903038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.8

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(105903037).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 32 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 32)

				if (32 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 32)) > 0 and var_151_0 < var_151_3 then
					arg_148_1.talkMaxDuration = var_151_3

					if var_151_3 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_3 + 0
					end
				end

				arg_148_1.text_.text = var_151_1
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_4 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_4

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play105903038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 105903038
		arg_152_1.duration_ = 2.67

		local var_152_0 = {
			ja = 2.666,
			ko = 1.999999999999
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
				arg_152_0:Play105903039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1148ui_story"]) and arg_152_1.var_.characterEffect1148ui_story == nil then
				arg_152_1.var_.characterEffect1148ui_story = arg_152_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1148ui_story"]) then
				if arg_152_1.var_.characterEffect1148ui_story and not isNil(arg_152_1.actors_["1148ui_story"]) then
					arg_152_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1148ui_story"]) and arg_152_1.var_.characterEffect1148ui_story then
				arg_152_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_155_2 = arg_152_1.bgs_.D04a.transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPosD04a = var_155_2.localPosition
			end

			local var_155_3 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPosD04a, Vector3.New(0, -100, 10), (arg_152_1.time_ - 0) / var_155_3)
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				local var_155_4 = arg_152_1.bgs_.B13

				arg_152_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_155_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_155_5 = var_155_4:GetComponent("SpriteRenderer")

				if var_155_5 and var_155_5.sprite then
					local var_155_6 = 2 * (var_155_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_155_4.transform.localScale = Vector3.New(var_155_6 / var_155_5.sprite.bounds.size.y < var_155_6 * manager.ui.mainCameraCom_.aspect / var_155_5.sprite.bounds.size.x and var_155_6 * manager.ui.mainCameraCom_.aspect / var_155_5.sprite.bounds.size.x or var_155_6 / var_155_5.sprite.bounds.size.y, var_155_6 / var_155_5.sprite.bounds.size.y < var_155_6 * manager.ui.mainCameraCom_.aspect / var_155_5.sprite.bounds.size.x and var_155_6 * manager.ui.mainCameraCom_.aspect / var_155_5.sprite.bounds.size.x or var_155_6 / var_155_5.sprite.bounds.size.y, 0)
				end

				for iter_155_0, iter_155_1 in pairs(arg_152_1.bgs_) do
					if iter_155_0 ~= "B13" then
						iter_155_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_155_7 = arg_152_1.actors_["1148ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1148ui_story = var_155_7.localPosition
			end

			local var_155_8 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_8 then
				var_155_7.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.85, -5.6), (arg_152_1.time_ - 0) / var_155_8)
				var_155_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_7.position).x, (manager.ui.mainCamera.transform.position - var_155_7.position).y, (manager.ui.mainCamera.transform.position - var_155_7.position).z)
				var_155_7.localEulerAngles.z = 0
				var_155_7.localEulerAngles.x = 0
				var_155_7.localEulerAngles = var_155_7.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_8 and arg_152_1.time_ < 0 + var_155_8 + arg_155_0 then
				var_155_7.localPosition = Vector3.New(0, -0.85, -5.6)
				var_155_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_7.position).x, (manager.ui.mainCamera.transform.position - var_155_7.position).y, (manager.ui.mainCamera.transform.position - var_155_7.position).z)
				var_155_7.localEulerAngles.z = 0
				var_155_7.localEulerAngles.x = 0
				var_155_7.localEulerAngles = var_155_7.localEulerAngles
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_155_9 = 0
			local var_155_10 = 0.05

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[103].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_11 = arg_152_1:GetWordFromCfg(105903038)
				local var_155_12 = arg_152_1:FormatText(var_155_11.content)

				arg_152_1.text_.text = var_155_12

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_14 = 2 <= 0 and var_155_10 or var_155_10 * (utf8.len(var_155_12) / 2)

				if (2 <= 0 and var_155_10 or var_155_10 * (utf8.len(var_155_12) / 2)) > 0 and var_155_10 < var_155_14 then
					arg_152_1.talkMaxDuration = var_155_14

					if var_155_14 + var_155_9 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_9
					end
				end

				arg_152_1.text_.text = var_155_12
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903038", "story_v_side_old_105903.awb") ~= 0 then
					local var_155_15 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903038", "story_v_side_old_105903.awb") / 1000

					if var_155_15 + var_155_9 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_15 + var_155_9
					end

					if var_155_11.prefab_name ~= "" and arg_152_1.actors_[var_155_11.prefab_name] ~= nil then
						local var_155_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_11.prefab_name].transform, "story_v_side_old_105903", "105903038", "story_v_side_old_105903.awb")

						arg_152_1:RecordAudio("105903038", var_155_16)
						arg_152_1:RecordAudio("105903038", var_155_16)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903038", "story_v_side_old_105903.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903038", "story_v_side_old_105903.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_17 = math.max(var_155_10, arg_152_1.talkMaxDuration)

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_17 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_9) / var_155_17

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_9 + var_155_17 and arg_152_1.time_ < var_155_9 + var_155_17 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D04a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play105903039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 105903039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play105903040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1148ui_story"]) and arg_156_1.var_.characterEffect1148ui_story == nil then
				arg_156_1.var_.characterEffect1148ui_story = arg_156_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.1

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1148ui_story"]) then
				if arg_156_1.var_.characterEffect1148ui_story and not isNil(arg_156_1.actors_["1148ui_story"]) then
					arg_156_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1148ui_story"]) and arg_156_1.var_.characterEffect1148ui_story then
				arg_156_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.25

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(105903039).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 10 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 10)

				if (10 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 10)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play105903040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 105903040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play105903041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 1.4

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(105903040).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 56 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 56)

				if (56 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 56)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play105903041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 105903041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play105903042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.375

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(105903041).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 15 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 15)

				if (15 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 15)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play105903042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 105903042
		arg_168_1.duration_ = 3.7

		local var_168_0 = {
			ja = 3.633,
			ko = 3.7
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
				arg_168_0:Play105903043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1148ui_story"]) and arg_168_1.var_.characterEffect1148ui_story == nil then
				arg_168_1.var_.characterEffect1148ui_story = arg_168_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.1

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1148ui_story"]) then
				if arg_168_1.var_.characterEffect1148ui_story and not isNil(arg_168_1.actors_["1148ui_story"]) then
					arg_168_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1148ui_story"]) and arg_168_1.var_.characterEffect1148ui_story then
				arg_168_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action493")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_171_2 = 0
			local var_171_3 = 0.3

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(105903042)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 12 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 12)

				if (12 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 12)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903042", "story_v_side_old_105903.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903042", "story_v_side_old_105903.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_side_old_105903", "105903042", "story_v_side_old_105903.awb")

						arg_168_1:RecordAudio("105903042", var_171_9)
						arg_168_1:RecordAudio("105903042", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903042", "story_v_side_old_105903.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903042", "story_v_side_old_105903.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play105903043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 105903043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play105903044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1148ui_story"]) and arg_172_1.var_.characterEffect1148ui_story == nil then
				arg_172_1.var_.characterEffect1148ui_story = arg_172_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.1

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1148ui_story"]) then
				if arg_172_1.var_.characterEffect1148ui_story and not isNil(arg_172_1.actors_["1148ui_story"]) then
					arg_172_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1148ui_story"]) and arg_172_1.var_.characterEffect1148ui_story then
				arg_172_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_175_1 = arg_172_1.bgs_.B13.transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPosB13 = var_175_1.localPosition
			end

			local var_175_2 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 then
				var_175_1.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPosB13, Vector3.New(0, -100, 10), (arg_172_1.time_ - 0) / var_175_2)
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 then
				var_175_1.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				local var_175_3 = arg_172_1.bgs_.D04a

				arg_172_1.bgs_.D04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_175_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_4 = var_175_3:GetComponent("SpriteRenderer")

				if var_175_4 and var_175_4.sprite then
					local var_175_5 = 2 * (var_175_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_175_3.transform.localScale = Vector3.New(var_175_5 / var_175_4.sprite.bounds.size.y < var_175_5 * manager.ui.mainCameraCom_.aspect / var_175_4.sprite.bounds.size.x and var_175_5 * manager.ui.mainCameraCom_.aspect / var_175_4.sprite.bounds.size.x or var_175_5 / var_175_4.sprite.bounds.size.y, var_175_5 / var_175_4.sprite.bounds.size.y < var_175_5 * manager.ui.mainCameraCom_.aspect / var_175_4.sprite.bounds.size.x and var_175_5 * manager.ui.mainCameraCom_.aspect / var_175_4.sprite.bounds.size.x or var_175_5 / var_175_4.sprite.bounds.size.y, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "D04a" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_6 = arg_172_1.actors_["1148ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1148ui_story = var_175_6.localPosition
			end

			local var_175_7 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				var_175_6.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_172_1.time_ - 0) / var_175_7)
				var_175_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_6.position).x, (manager.ui.mainCamera.transform.position - var_175_6.position).y, (manager.ui.mainCamera.transform.position - var_175_6.position).z)
				var_175_6.localEulerAngles.z = 0
				var_175_6.localEulerAngles.x = 0
				var_175_6.localEulerAngles = var_175_6.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				var_175_6.localPosition = Vector3.New(10, -0.85, -5.6)
				var_175_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_6.position).x, (manager.ui.mainCamera.transform.position - var_175_6.position).y, (manager.ui.mainCamera.transform.position - var_175_6.position).z)
				var_175_6.localEulerAngles.z = 0
				var_175_6.localEulerAngles.x = 0
				var_175_6.localEulerAngles = var_175_6.localEulerAngles
			end

			local var_175_8 = 0
			local var_175_9 = 0.425

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_10 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(105903043).content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_12 = 17 <= 0 and var_175_9 or var_175_9 * (utf8.len(var_175_10) / 17)

				if (17 <= 0 and var_175_9 or var_175_9 * (utf8.len(var_175_10) / 17)) > 0 and var_175_9 < var_175_12 then
					arg_172_1.talkMaxDuration = var_175_12

					if var_175_12 + var_175_8 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_8
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_9, arg_172_1.talkMaxDuration)

			if var_175_8 <= arg_172_1.time_ and arg_172_1.time_ < var_175_8 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_8) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_8 + var_175_13 and arg_172_1.time_ < var_175_8 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play105903044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 105903044
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play105903045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.2

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(105903044).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 48 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 48)

				if (48 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 48)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play105903045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 105903045
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play105903046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 1.15

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(105903045).content)

				arg_180_1.text_.text = var_183_1

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_3 = 46 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 46)

				if (46 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 46)) > 0 and var_183_0 < var_183_3 then
					arg_180_1.talkMaxDuration = var_183_3

					if var_183_3 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_3 + 0
					end
				end

				arg_180_1.text_.text = var_183_1
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_4 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_4

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play105903046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 105903046
		arg_184_1.duration_ = 7.7

		local var_184_0 = {
			ja = 7.7,
			ko = 6.833
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
				arg_184_0:Play105903047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1148ui_story"]) and arg_184_1.var_.characterEffect1148ui_story == nil then
				arg_184_1.var_.characterEffect1148ui_story = arg_184_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.1

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1148ui_story"]) then
				if arg_184_1.var_.characterEffect1148ui_story and not isNil(arg_184_1.actors_["1148ui_story"]) then
					arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1148ui_story"]) and arg_184_1.var_.characterEffect1148ui_story then
				arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action496")
			end

			local var_187_2 = 0
			local var_187_3 = 0.6

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(105903046)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 24 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 24)

				if (24 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 24)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903046", "story_v_side_old_105903.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903046", "story_v_side_old_105903.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_side_old_105903", "105903046", "story_v_side_old_105903.awb")

						arg_184_1:RecordAudio("105903046", var_187_9)
						arg_184_1:RecordAudio("105903046", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903046", "story_v_side_old_105903.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903046", "story_v_side_old_105903.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play105903047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 105903047
		arg_188_1.duration_ = 11.5

		local var_188_0 = {
			ja = 7.5,
			ko = 11.5
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play105903048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if arg_188_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_191_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_188_1.stage_.transform)

				var_191_0.name = "1059ui_story"
				var_191_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.actors_["1059ui_story"] = var_191_0

				local var_191_1 = var_191_0:GetComponentInChildren(typeof(CharacterEffect))

				var_191_1.enabled = true

				local var_191_2 = GameObjectTools.GetOrAddComponent(var_191_0, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(false)
				end

				arg_188_1:ShowWeapon(var_191_1.transform, false)

				arg_188_1.var_["1059ui_story" .. "Animator"] = var_191_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_188_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_188_1.var_["1059ui_story" .. "LipSync"] = var_191_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_191_3 = arg_188_1.actors_["1059ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect1059ui_story == nil then
				arg_188_1.var_.characterEffect1059ui_story = var_191_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_4 = 0.1

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 and not isNil(var_191_3) then
				if arg_188_1.var_.characterEffect1059ui_story and not isNil(var_191_3) then
					arg_188_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect1059ui_story then
				arg_188_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_191_6 = arg_188_1.actors_["1148ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_6) and arg_188_1.var_.characterEffect1148ui_story == nil then
				arg_188_1.var_.characterEffect1148ui_story = var_191_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_7 = 0.1

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 and not isNil(var_191_6) then
				if arg_188_1.var_.characterEffect1148ui_story and not isNil(var_191_6) then
					arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_7)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 and not isNil(var_191_6) and arg_188_1.var_.characterEffect1148ui_story then
				arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_191_8 = arg_188_1.actors_["1059ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1059ui_story = var_191_8.localPosition
			end

			local var_191_9 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_9 then
				var_191_8.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1059ui_story, Vector3.New(-1, -1.1, -5.4), (arg_188_1.time_ - 0) / var_191_9)
				var_191_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_8.position).x, (manager.ui.mainCamera.transform.position - var_191_8.position).y, (manager.ui.mainCamera.transform.position - var_191_8.position).z)
				var_191_8.localEulerAngles.z = 0
				var_191_8.localEulerAngles.x = 0
				var_191_8.localEulerAngles = var_191_8.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_9 and arg_188_1.time_ < 0 + var_191_9 + arg_191_0 then
				var_191_8.localPosition = Vector3.New(-1, -1.1, -5.4)
				var_191_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_8.position).x, (manager.ui.mainCamera.transform.position - var_191_8.position).y, (manager.ui.mainCamera.transform.position - var_191_8.position).z)
				var_191_8.localEulerAngles.z = 0
				var_191_8.localEulerAngles.x = 0
				var_191_8.localEulerAngles = var_191_8.localEulerAngles
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_191_10 = 0
			local var_191_11 = 1.325

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_12 = arg_188_1:GetWordFromCfg(105903047)
				local var_191_13 = arg_188_1:FormatText(var_191_12.content)

				arg_188_1.text_.text = var_191_13

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_15 = 53 <= 0 and var_191_11 or var_191_11 * (utf8.len(var_191_13) / 53)

				if (53 <= 0 and var_191_11 or var_191_11 * (utf8.len(var_191_13) / 53)) > 0 and var_191_11 < var_191_15 then
					arg_188_1.talkMaxDuration = var_191_15

					if var_191_15 + var_191_10 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_15 + var_191_10
					end
				end

				arg_188_1.text_.text = var_191_13
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903047", "story_v_side_old_105903.awb") ~= 0 then
					local var_191_16 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903047", "story_v_side_old_105903.awb") / 1000

					if var_191_16 + var_191_10 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_16 + var_191_10
					end

					if var_191_12.prefab_name ~= "" and arg_188_1.actors_[var_191_12.prefab_name] ~= nil then
						local var_191_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_12.prefab_name].transform, "story_v_side_old_105903", "105903047", "story_v_side_old_105903.awb")

						arg_188_1:RecordAudio("105903047", var_191_17)
						arg_188_1:RecordAudio("105903047", var_191_17)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903047", "story_v_side_old_105903.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903047", "story_v_side_old_105903.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_18 = math.max(var_191_11, arg_188_1.talkMaxDuration)

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_18 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_10) / var_191_18

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_10 + var_191_18 and arg_188_1.time_ < var_191_10 + var_191_18 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play105903048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 105903048
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play105903049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1059ui_story"]) and arg_192_1.var_.characterEffect1059ui_story == nil then
				arg_192_1.var_.characterEffect1059ui_story = arg_192_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.1

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1059ui_story"]) then
				if arg_192_1.var_.characterEffect1059ui_story and not isNil(arg_192_1.actors_["1059ui_story"]) then
					arg_192_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_0)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1059ui_story"]) and arg_192_1.var_.characterEffect1059ui_story then
				arg_192_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_195_1 = 0
			local var_195_2 = 0.925

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(105903048).content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 37 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 37)

				if (37 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 37)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_6 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_6 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_6

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_6 and arg_192_1.time_ < var_195_1 + var_195_6 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play105903049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 105903049
		arg_196_1.duration_ = 10.8

		local var_196_0 = {
			ja = 5.666,
			ko = 10.8
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
				arg_196_0:Play105903050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1059ui_story"]) and arg_196_1.var_.characterEffect1059ui_story == nil then
				arg_196_1.var_.characterEffect1059ui_story = arg_196_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.1

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1059ui_story"]) then
				if arg_196_1.var_.characterEffect1059ui_story and not isNil(arg_196_1.actors_["1059ui_story"]) then
					arg_196_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1059ui_story"]) and arg_196_1.var_.characterEffect1059ui_story then
				arg_196_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action443")
			end

			local var_199_2 = arg_196_1.actors_["1148ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1148ui_story = var_199_2.localPosition
			end

			local var_199_3 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 then
				var_199_2.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (arg_196_1.time_ - 0) / var_199_3)
				var_199_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_2.position).x, (manager.ui.mainCamera.transform.position - var_199_2.position).y, (manager.ui.mainCamera.transform.position - var_199_2.position).z)
				var_199_2.localEulerAngles.z = 0
				var_199_2.localEulerAngles.x = 0
				var_199_2.localEulerAngles = var_199_2.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 then
				var_199_2.localPosition = Vector3.New(10, -0.85, -5.6)
				var_199_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_2.position).x, (manager.ui.mainCamera.transform.position - var_199_2.position).y, (manager.ui.mainCamera.transform.position - var_199_2.position).z)
				var_199_2.localEulerAngles.z = 0
				var_199_2.localEulerAngles.x = 0
				var_199_2.localEulerAngles = var_199_2.localEulerAngles
			end

			local var_199_4 = arg_196_1.actors_["1059ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1059ui_story = var_199_4.localPosition
			end

			local var_199_5 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_5 then
				var_199_4.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1059ui_story, Vector3.New(-1, -1.1, -5.4), (arg_196_1.time_ - 0) / var_199_5)
				var_199_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_4.position).x, (manager.ui.mainCamera.transform.position - var_199_4.position).y, (manager.ui.mainCamera.transform.position - var_199_4.position).z)
				var_199_4.localEulerAngles.z = 0
				var_199_4.localEulerAngles.x = 0
				var_199_4.localEulerAngles = var_199_4.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_5 and arg_196_1.time_ < 0 + var_199_5 + arg_199_0 then
				var_199_4.localPosition = Vector3.New(-1, -1.1, -5.4)
				var_199_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_4.position).x, (manager.ui.mainCamera.transform.position - var_199_4.position).y, (manager.ui.mainCamera.transform.position - var_199_4.position).z)
				var_199_4.localEulerAngles.z = 0
				var_199_4.localEulerAngles.x = 0
				var_199_4.localEulerAngles = var_199_4.localEulerAngles
			end

			local var_199_6 = arg_196_1.actors_["1059ui_story"].transform

			if 0.033 < arg_196_1.time_ and arg_196_1.time_ <= 0.033 + arg_199_0 then
				arg_196_1.var_.moveOldPos1059ui_story = var_199_6.localPosition
			end

			local var_199_7 = 0.5

			if 0.033 <= arg_196_1.time_ and arg_196_1.time_ < 0.033 + var_199_7 then
				var_199_6.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.1, -5.4), (arg_196_1.time_ - 0.033) / var_199_7)
				var_199_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_6.position).x, (manager.ui.mainCamera.transform.position - var_199_6.position).y, (manager.ui.mainCamera.transform.position - var_199_6.position).z)
				var_199_6.localEulerAngles.z = 0
				var_199_6.localEulerAngles.x = 0
				var_199_6.localEulerAngles = var_199_6.localEulerAngles
			end

			if arg_196_1.time_ >= 0.033 + var_199_7 and arg_196_1.time_ < 0.033 + var_199_7 + arg_199_0 then
				var_199_6.localPosition = Vector3.New(0, -1.1, -5.4)
				var_199_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_6.position).x, (manager.ui.mainCamera.transform.position - var_199_6.position).y, (manager.ui.mainCamera.transform.position - var_199_6.position).z)
				var_199_6.localEulerAngles.z = 0
				var_199_6.localEulerAngles.x = 0
				var_199_6.localEulerAngles = var_199_6.localEulerAngles
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_199_8 = 0
			local var_199_9 = 1.375

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:GetWordFromCfg(105903049)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_13 = 55 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 55)

				if (55 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 55)) > 0 and var_199_9 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_8
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903049", "story_v_side_old_105903.awb") ~= 0 then
					local var_199_14 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903049", "story_v_side_old_105903.awb") / 1000

					if var_199_14 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_8
					end

					if var_199_10.prefab_name ~= "" and arg_196_1.actors_[var_199_10.prefab_name] ~= nil then
						local var_199_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_10.prefab_name].transform, "story_v_side_old_105903", "105903049", "story_v_side_old_105903.awb")

						arg_196_1:RecordAudio("105903049", var_199_15)
						arg_196_1:RecordAudio("105903049", var_199_15)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903049", "story_v_side_old_105903.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903049", "story_v_side_old_105903.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_16 = math.max(var_199_9, arg_196_1.talkMaxDuration)

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_16 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_8) / var_199_16

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_8 + var_199_16 and arg_196_1.time_ < var_199_8 + var_199_16 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play105903050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 105903050
		arg_200_1.duration_ = 5.9

		local var_200_0 = {
			ja = 4.9,
			ko = 5.9
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
				arg_200_0:Play105903051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_203_0 = 0
			local var_203_1 = 0.625

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(105903050)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 25 <= 0 and var_203_1 or var_203_1 * (utf8.len(var_203_3) / 25)

				if (25 <= 0 and var_203_1 or var_203_1 * (utf8.len(var_203_3) / 25)) > 0 and var_203_1 < var_203_5 then
					arg_200_1.talkMaxDuration = var_203_5

					if var_203_5 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903050", "story_v_side_old_105903.awb") ~= 0 then
					local var_203_6 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903050", "story_v_side_old_105903.awb") / 1000

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end

					if var_203_2.prefab_name ~= "" and arg_200_1.actors_[var_203_2.prefab_name] ~= nil then
						local var_203_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_2.prefab_name].transform, "story_v_side_old_105903", "105903050", "story_v_side_old_105903.awb")

						arg_200_1:RecordAudio("105903050", var_203_7)
						arg_200_1:RecordAudio("105903050", var_203_7)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903050", "story_v_side_old_105903.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903050", "story_v_side_old_105903.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_8 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_8 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_8

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_8 and arg_200_1.time_ < var_203_0 + var_203_8 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play105903051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 105903051
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play105903052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1059ui_story"]) and arg_204_1.var_.characterEffect1059ui_story == nil then
				arg_204_1.var_.characterEffect1059ui_story = arg_204_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.1

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1059ui_story"]) then
				if arg_204_1.var_.characterEffect1059ui_story and not isNil(arg_204_1.actors_["1059ui_story"]) then
					arg_204_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_0)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1059ui_story"]) and arg_204_1.var_.characterEffect1059ui_story then
				arg_204_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_207_1 = 0
			local var_207_2 = 0.65

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(105903051).content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 26 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_3) / 26)

				if (26 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_3) / 26)) > 0 and var_207_2 < var_207_5 then
					arg_204_1.talkMaxDuration = var_207_5

					if var_207_5 + var_207_1 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + var_207_1
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_6 = math.max(var_207_2, arg_204_1.talkMaxDuration)

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_6 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_1) / var_207_6

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_1 + var_207_6 and arg_204_1.time_ < var_207_1 + var_207_6 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play105903052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 105903052
		arg_208_1.duration_ = 7.9

		local var_208_0 = {
			ja = 6.4,
			ko = 7.9
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
				arg_208_0:Play105903053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1059ui_story"]) and arg_208_1.var_.characterEffect1059ui_story == nil then
				arg_208_1.var_.characterEffect1059ui_story = arg_208_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.1

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1059ui_story"]) then
				if arg_208_1.var_.characterEffect1059ui_story and not isNil(arg_208_1.actors_["1059ui_story"]) then
					arg_208_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1059ui_story"]) and arg_208_1.var_.characterEffect1059ui_story then
				arg_208_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action437")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_211_2 = 0
			local var_211_3 = 0.85

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_4 = arg_208_1:GetWordFromCfg(105903052)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 34 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 34)

				if (34 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 34)) > 0 and var_211_3 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_2
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903052", "story_v_side_old_105903.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903052", "story_v_side_old_105903.awb") / 1000

					if var_211_8 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_2
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_side_old_105903", "105903052", "story_v_side_old_105903.awb")

						arg_208_1:RecordAudio("105903052", var_211_9)
						arg_208_1:RecordAudio("105903052", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903052", "story_v_side_old_105903.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903052", "story_v_side_old_105903.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_3, arg_208_1.talkMaxDuration)

			if var_211_2 <= arg_208_1.time_ and arg_208_1.time_ < var_211_2 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_2) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_2 + var_211_10 and arg_208_1.time_ < var_211_2 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play105903053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 105903053
		arg_212_1.duration_ = 5.37

		local var_212_0 = {
			ja = 4.466,
			ko = 5.366
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
			arg_212_1.auto_ = false
		end

		function arg_212_1.playNext_(arg_214_0)
			arg_212_1.onStoryFinished_()
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_215_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_212_1.bgmTxt_.text ~= var_215_2 and arg_212_1.bgmTxt_.text ~= "" then
						if arg_212_1.bgmTxt2_.text ~= "" then
							arg_212_1.bgmTxt_.text = arg_212_1.bgmTxt2_.text
						end

						arg_212_1.bgmTxt2_.text = var_215_2

						arg_212_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_212_1.bgmTxt_.text = var_215_2
						arg_212_1.bgmTxt2_.text = var_215_2
					end

					if arg_212_1.bgmTimer then
						arg_212_1.bgmTimer:Stop()

						arg_212_1.bgmTimer = nil
					end

					if arg_212_1.settingData.show_music_name == 1 then
						arg_212_1.musicController:SetSelectedState("show")
						arg_212_1.musicAnimator_:Play("open", 0, 0)

						if arg_212_1.settingData.music_time ~= 0 then
							arg_212_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_212_1.settingData.music_time), function()
								if arg_212_1 == nil or isNil(arg_212_1.bgmTxt_) then
									return
								end

								arg_212_1.musicController:SetSelectedState("hide")
								arg_212_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_215_3 = 0
			local var_215_4 = 0.425

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_3 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_5 = arg_212_1:GetWordFromCfg(105903053)
				local var_215_6 = arg_212_1:FormatText(var_215_5.content)

				arg_212_1.text_.text = var_215_6

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_8 = 17 <= 0 and var_215_4 or var_215_4 * (utf8.len(var_215_6) / 17)

				if (17 <= 0 and var_215_4 or var_215_4 * (utf8.len(var_215_6) / 17)) > 0 and var_215_4 < var_215_8 then
					arg_212_1.talkMaxDuration = var_215_8

					if var_215_8 + var_215_3 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_3
					end
				end

				arg_212_1.text_.text = var_215_6
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_105903", "105903053", "story_v_side_old_105903.awb") ~= 0 then
					local var_215_9 = manager.audio:GetVoiceLength("story_v_side_old_105903", "105903053", "story_v_side_old_105903.awb") / 1000

					if var_215_9 + var_215_3 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_3
					end

					if var_215_5.prefab_name ~= "" and arg_212_1.actors_[var_215_5.prefab_name] ~= nil then
						local var_215_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_5.prefab_name].transform, "story_v_side_old_105903", "105903053", "story_v_side_old_105903.awb")

						arg_212_1:RecordAudio("105903053", var_215_10)
						arg_212_1:RecordAudio("105903053", var_215_10)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_old_105903", "105903053", "story_v_side_old_105903.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_old_105903", "105903053", "story_v_side_old_105903.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_11 = math.max(var_215_4, arg_212_1.talkMaxDuration)

			if var_215_3 <= arg_212_1.time_ and arg_212_1.time_ < var_215_3 + var_215_11 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_3) / var_215_11

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_3 + var_215_11 and arg_212_1.time_ < var_215_3 + var_215_11 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/D04a",
		"TextureConfig/Background/B13"
	},
	voices = {
		"story_v_side_old_105903.awb"
	}
}
