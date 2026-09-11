return {
	Play317142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317142001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.YA0106 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0106")
				var_4_0.name = "YA0106"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.YA0106 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.YA0106

				arg_1_1.bgs_.YA0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "YA0106" then
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

			if 0.533333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.533333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

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

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317142001).content)

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
	Play317142002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317142002
		arg_9_1.duration_ = 8.77

		local var_9_0 = {
			zh = 7.8,
			ja = 8.766
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317142003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.725

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(317142002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 29 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 29)

				if (29 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 29)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142002", "story_v_out_317142.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142002", "story_v_out_317142.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_317142", "317142002", "story_v_out_317142.awb")

						arg_9_1:RecordAudio("317142002", var_12_6)
						arg_9_1:RecordAudio("317142002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317142", "317142002", "story_v_out_317142.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317142", "317142002", "story_v_out_317142.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play317142003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317142003
		arg_13_1.duration_ = 6

		local var_13_0 = {
			zh = 6,
			ja = 3.666
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317142004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(317142003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 31)

				if (31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 31)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142003", "story_v_out_317142.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142003", "story_v_out_317142.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_317142", "317142003", "story_v_out_317142.awb")

						arg_13_1:RecordAudio("317142003", var_16_6)
						arg_13_1:RecordAudio("317142003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317142", "317142003", "story_v_out_317142.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317142", "317142003", "story_v_out_317142.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play317142004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317142004
		arg_17_1.duration_ = 15.43

		local var_17_0 = {
			zh = 15.433,
			ja = 14.733
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
				arg_17_0:Play317142005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(317142004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 68 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 68)

				if (68 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 68)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142004", "story_v_out_317142.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142004", "story_v_out_317142.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_317142", "317142004", "story_v_out_317142.awb")

						arg_17_1:RecordAudio("317142004", var_20_6)
						arg_17_1:RecordAudio("317142004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317142", "317142004", "story_v_out_317142.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317142", "317142004", "story_v_out_317142.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play317142005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317142005
		arg_21_1.duration_ = 7.63

		local var_21_0 = {
			zh = 7.633,
			ja = 7.166
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
				arg_21_0:Play317142006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.75

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(317142005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 30 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 30)

				if (30 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 30)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142005", "story_v_out_317142.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142005", "story_v_out_317142.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_317142", "317142005", "story_v_out_317142.awb")

						arg_21_1:RecordAudio("317142005", var_24_6)
						arg_21_1:RecordAudio("317142005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317142", "317142005", "story_v_out_317142.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317142", "317142005", "story_v_out_317142.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play317142006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317142006
		arg_25_1.duration_ = 13.53

		local var_25_0 = {
			zh = 9.066,
			ja = 13.533
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317142007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(317142006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 51 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 51)

				if (51 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 51)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142006", "story_v_out_317142.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142006", "story_v_out_317142.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_317142", "317142006", "story_v_out_317142.awb")

						arg_25_1:RecordAudio("317142006", var_28_6)
						arg_25_1:RecordAudio("317142006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317142", "317142006", "story_v_out_317142.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317142", "317142006", "story_v_out_317142.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play317142007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317142007
		arg_29_1.duration_ = 6.03

		local var_29_0 = {
			zh = 3.633,
			ja = 6.033
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play317142008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(317142007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 15 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 15)

				if (15 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 15)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142007", "story_v_out_317142.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142007", "story_v_out_317142.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_317142", "317142007", "story_v_out_317142.awb")

						arg_29_1:RecordAudio("317142007", var_32_6)
						arg_29_1:RecordAudio("317142007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317142", "317142007", "story_v_out_317142.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317142", "317142007", "story_v_out_317142.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play317142008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317142008
		arg_33_1.duration_ = 14.9

		local var_33_0 = {
			zh = 14.9,
			ja = 14.4
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317142009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.7

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(317142008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 68 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 68)

				if (68 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 68)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142008", "story_v_out_317142.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142008", "story_v_out_317142.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_317142", "317142008", "story_v_out_317142.awb")

						arg_33_1:RecordAudio("317142008", var_36_6)
						arg_33_1:RecordAudio("317142008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317142", "317142008", "story_v_out_317142.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317142", "317142008", "story_v_out_317142.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play317142009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317142009
		arg_37_1.duration_ = 1.3

		local var_37_0 = {
			zh = 1.3,
			ja = 1.066
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play317142010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(317142009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 4 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 4)

				if (4 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 4)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142009", "story_v_out_317142.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142009", "story_v_out_317142.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_317142", "317142009", "story_v_out_317142.awb")

						arg_37_1:RecordAudio("317142009", var_40_6)
						arg_37_1:RecordAudio("317142009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317142", "317142009", "story_v_out_317142.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317142", "317142009", "story_v_out_317142.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play317142010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317142010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317142011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(317142010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 17 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 17)

				if (17 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 17)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317142011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317142011
		arg_45_1.duration_ = 6.4

		local var_45_0 = {
			zh = 5,
			ja = 6.4
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317142012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.625

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(317142011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 25 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 25)

				if (25 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 25)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142011", "story_v_out_317142.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142011", "story_v_out_317142.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_317142", "317142011", "story_v_out_317142.awb")

						arg_45_1:RecordAudio("317142011", var_48_6)
						arg_45_1:RecordAudio("317142011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317142", "317142011", "story_v_out_317142.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317142", "317142011", "story_v_out_317142.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play317142012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317142012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play317142013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_52_1 = 0
			local var_52_2 = 1.225

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(317142012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 49 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 49)

				if (49 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 49)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play317142013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317142013
		arg_53_1.duration_ = 2.3

		local var_53_0 = {
			zh = 2.233,
			ja = 2.3
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play317142014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(317142013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 12 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 12)

				if (12 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 12)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142013", "story_v_out_317142.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142013", "story_v_out_317142.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_317142", "317142013", "story_v_out_317142.awb")

						arg_53_1:RecordAudio("317142013", var_56_6)
						arg_53_1:RecordAudio("317142013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317142", "317142013", "story_v_out_317142.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317142", "317142013", "story_v_out_317142.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play317142014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317142014
		arg_57_1.duration_ = 2.03

		local var_57_0 = {
			zh = 2.033,
			ja = 1.133
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play317142015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.175

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(317142014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 7 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 7)

				if (7 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 7)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142014", "story_v_out_317142.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142014", "story_v_out_317142.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_317142", "317142014", "story_v_out_317142.awb")

						arg_57_1:RecordAudio("317142014", var_60_6)
						arg_57_1:RecordAudio("317142014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317142", "317142014", "story_v_out_317142.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317142", "317142014", "story_v_out_317142.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play317142015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317142015
		arg_61_1.duration_ = 2.87

		local var_61_0 = {
			zh = 1.5,
			ja = 2.866
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317142016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.175

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(317142015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 7 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 7)

				if (7 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 7)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142015", "story_v_out_317142.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142015", "story_v_out_317142.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_317142", "317142015", "story_v_out_317142.awb")

						arg_61_1:RecordAudio("317142015", var_64_6)
						arg_61_1:RecordAudio("317142015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317142", "317142015", "story_v_out_317142.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317142", "317142015", "story_v_out_317142.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play317142016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317142016
		arg_65_1.duration_ = 2.83

		local var_65_0 = {
			zh = 2.833,
			ja = 2.466
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317142017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.225

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(317142016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 9 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 9)

				if (9 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 9)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142016", "story_v_out_317142.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142016", "story_v_out_317142.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_317142", "317142016", "story_v_out_317142.awb")

						arg_65_1:RecordAudio("317142016", var_68_6)
						arg_65_1:RecordAudio("317142016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317142", "317142016", "story_v_out_317142.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317142", "317142016", "story_v_out_317142.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play317142017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317142017
		arg_69_1.duration_ = 4.5

		local var_69_0 = {
			zh = 3.7,
			ja = 4.5
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317142018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(317142017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 17 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 17)

				if (17 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 17)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142017", "story_v_out_317142.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142017", "story_v_out_317142.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_317142", "317142017", "story_v_out_317142.awb")

						arg_69_1:RecordAudio("317142017", var_72_6)
						arg_69_1:RecordAudio("317142017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317142", "317142017", "story_v_out_317142.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317142", "317142017", "story_v_out_317142.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play317142018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317142018
		arg_73_1.duration_ = 4.93

		local var_73_0 = {
			zh = 4.933,
			ja = 4.233
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317142019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.625

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(317142018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 25 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 25)

				if (25 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 25)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142018", "story_v_out_317142.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142018", "story_v_out_317142.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_317142", "317142018", "story_v_out_317142.awb")

						arg_73_1:RecordAudio("317142018", var_76_6)
						arg_73_1:RecordAudio("317142018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317142", "317142018", "story_v_out_317142.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317142", "317142018", "story_v_out_317142.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play317142019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317142019
		arg_77_1.duration_ = 8

		local var_77_0 = {
			zh = 8,
			ja = 4.9
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play317142020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(317142019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 45 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 45)

				if (45 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 45)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142019", "story_v_out_317142.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142019", "story_v_out_317142.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_317142", "317142019", "story_v_out_317142.awb")

						arg_77_1:RecordAudio("317142019", var_80_6)
						arg_77_1:RecordAudio("317142019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317142", "317142019", "story_v_out_317142.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317142", "317142019", "story_v_out_317142.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play317142020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317142020
		arg_81_1.duration_ = 1.57

		local var_81_0 = {
			zh = 1.566,
			ja = 0.999999999999
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317142021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.075

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(317142020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 3 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 3)

				if (3 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 3)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142020", "story_v_out_317142.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142020", "story_v_out_317142.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_317142", "317142020", "story_v_out_317142.awb")

						arg_81_1:RecordAudio("317142020", var_84_6)
						arg_81_1:RecordAudio("317142020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_317142", "317142020", "story_v_out_317142.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_317142", "317142020", "story_v_out_317142.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play317142021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317142021
		arg_85_1.duration_ = 3.97

		local var_85_0 = {
			zh = 3.3,
			ja = 3.966
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play317142022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(317142021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 17 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 17)

				if (17 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 17)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142021", "story_v_out_317142.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142021", "story_v_out_317142.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_317142", "317142021", "story_v_out_317142.awb")

						arg_85_1:RecordAudio("317142021", var_88_6)
						arg_85_1:RecordAudio("317142021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317142", "317142021", "story_v_out_317142.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317142", "317142021", "story_v_out_317142.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play317142022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317142022
		arg_89_1.duration_ = 10.77

		local var_89_0 = {
			zh = 10.766,
			ja = 8.033
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317142023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.3

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(317142022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 52 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 52)

				if (52 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 52)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142022", "story_v_out_317142.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142022", "story_v_out_317142.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_317142", "317142022", "story_v_out_317142.awb")

						arg_89_1:RecordAudio("317142022", var_92_6)
						arg_89_1:RecordAudio("317142022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_317142", "317142022", "story_v_out_317142.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_317142", "317142022", "story_v_out_317142.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play317142023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317142023
		arg_93_1.duration_ = 8.03

		local var_93_0 = {
			zh = 8.033,
			ja = 6.266
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play317142024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.9

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(317142023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 36 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 36)

				if (36 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 36)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142023", "story_v_out_317142.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142023", "story_v_out_317142.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_317142", "317142023", "story_v_out_317142.awb")

						arg_93_1:RecordAudio("317142023", var_96_6)
						arg_93_1:RecordAudio("317142023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_317142", "317142023", "story_v_out_317142.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_317142", "317142023", "story_v_out_317142.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play317142024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317142024
		arg_97_1.duration_ = 3.13

		local var_97_0 = {
			zh = 2.7,
			ja = 3.133
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play317142025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(317142024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 12 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 12)

				if (12 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 12)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142024", "story_v_out_317142.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142024", "story_v_out_317142.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_317142", "317142024", "story_v_out_317142.awb")

						arg_97_1:RecordAudio("317142024", var_100_6)
						arg_97_1:RecordAudio("317142024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_317142", "317142024", "story_v_out_317142.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_317142", "317142024", "story_v_out_317142.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play317142025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317142025
		arg_101_1.duration_ = 13.1

		local var_101_0 = {
			zh = 13.1,
			ja = 8.9
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play317142026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.675

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(317142025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 67 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 67)

				if (67 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 67)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142025", "story_v_out_317142.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142025", "story_v_out_317142.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_317142", "317142025", "story_v_out_317142.awb")

						arg_101_1:RecordAudio("317142025", var_104_6)
						arg_101_1:RecordAudio("317142025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_317142", "317142025", "story_v_out_317142.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_317142", "317142025", "story_v_out_317142.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play317142026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317142026
		arg_105_1.duration_ = 12.97

		local var_105_0 = {
			zh = 12.433,
			ja = 12.966
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play317142027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(317142026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 67 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 67)

				if (67 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 67)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142026", "story_v_out_317142.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142026", "story_v_out_317142.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_317142", "317142026", "story_v_out_317142.awb")

						arg_105_1:RecordAudio("317142026", var_108_6)
						arg_105_1:RecordAudio("317142026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317142", "317142026", "story_v_out_317142.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317142", "317142026", "story_v_out_317142.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play317142027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317142027
		arg_109_1.duration_ = 3.1

		local var_109_0 = {
			zh = 1.6,
			ja = 3.1
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play317142028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.25

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(317142027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 10 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 10)

				if (10 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 10)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142027", "story_v_out_317142.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142027", "story_v_out_317142.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_317142", "317142027", "story_v_out_317142.awb")

						arg_109_1:RecordAudio("317142027", var_112_6)
						arg_109_1:RecordAudio("317142027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_317142", "317142027", "story_v_out_317142.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_317142", "317142027", "story_v_out_317142.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play317142028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317142028
		arg_113_1.duration_ = 10.63

		local var_113_0 = {
			zh = 7.466,
			ja = 10.633
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play317142029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.125

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(317142028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 45 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 45)

				if (45 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 45)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142028", "story_v_out_317142.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142028", "story_v_out_317142.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_317142", "317142028", "story_v_out_317142.awb")

						arg_113_1:RecordAudio("317142028", var_116_6)
						arg_113_1:RecordAudio("317142028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_317142", "317142028", "story_v_out_317142.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_317142", "317142028", "story_v_out_317142.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play317142029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317142029
		arg_117_1.duration_ = 8.17

		local var_117_0 = {
			zh = 8.166,
			ja = 7.466
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play317142030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(317142029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 49 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 49)

				if (49 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 49)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142029", "story_v_out_317142.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142029", "story_v_out_317142.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_317142", "317142029", "story_v_out_317142.awb")

						arg_117_1:RecordAudio("317142029", var_120_6)
						arg_117_1:RecordAudio("317142029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_317142", "317142029", "story_v_out_317142.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_317142", "317142029", "story_v_out_317142.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play317142030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317142030
		arg_121_1.duration_ = 4.8

		local var_121_0 = {
			zh = 2.3,
			ja = 4.8
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play317142031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.3

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(317142030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 12 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 12)

				if (12 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 12)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142030", "story_v_out_317142.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142030", "story_v_out_317142.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_317142", "317142030", "story_v_out_317142.awb")

						arg_121_1:RecordAudio("317142030", var_124_6)
						arg_121_1:RecordAudio("317142030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_317142", "317142030", "story_v_out_317142.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_317142", "317142030", "story_v_out_317142.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play317142031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317142031
		arg_125_1.duration_ = 1

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317142032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.075

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(317142031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 3 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 3)

				if (3 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 3)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142031", "story_v_out_317142.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142031", "story_v_out_317142.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_317142", "317142031", "story_v_out_317142.awb")

						arg_125_1:RecordAudio("317142031", var_128_6)
						arg_125_1:RecordAudio("317142031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_317142", "317142031", "story_v_out_317142.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_317142", "317142031", "story_v_out_317142.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play317142032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 317142032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play317142033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.825

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(317142032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 33 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 33)

				if (33 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 33)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play317142033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 317142033
		arg_133_1.duration_ = 6.1

		local var_133_0 = {
			zh = 4.833,
			ja = 6.1
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play317142034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.525

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(317142033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 21 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 21)

				if (21 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 21)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142033", "story_v_out_317142.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142033", "story_v_out_317142.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_317142", "317142033", "story_v_out_317142.awb")

						arg_133_1:RecordAudio("317142033", var_136_6)
						arg_133_1:RecordAudio("317142033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_317142", "317142033", "story_v_out_317142.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_317142", "317142033", "story_v_out_317142.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play317142034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 317142034
		arg_137_1.duration_ = 6.37

		local var_137_0 = {
			zh = 3.066,
			ja = 6.366
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
				arg_137_0:Play317142035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(317142034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 15 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 15)

				if (15 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 15)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142034", "story_v_out_317142.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142034", "story_v_out_317142.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_317142", "317142034", "story_v_out_317142.awb")

						arg_137_1:RecordAudio("317142034", var_140_6)
						arg_137_1:RecordAudio("317142034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_317142", "317142034", "story_v_out_317142.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_317142", "317142034", "story_v_out_317142.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play317142035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 317142035
		arg_141_1.duration_ = 9.77

		local var_141_0 = {
			zh = 8,
			ja = 9.766
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
				arg_141_0:Play317142036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.95

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(317142035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 38 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 38)

				if (38 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 38)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142035", "story_v_out_317142.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142035", "story_v_out_317142.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_317142", "317142035", "story_v_out_317142.awb")

						arg_141_1:RecordAudio("317142035", var_144_6)
						arg_141_1:RecordAudio("317142035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_317142", "317142035", "story_v_out_317142.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_317142", "317142035", "story_v_out_317142.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play317142036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 317142036
		arg_145_1.duration_ = 8.27

		local var_145_0 = {
			zh = 8.266,
			ja = 5.6
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
				arg_145_0:Play317142037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.075

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(317142036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 43 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 43)

				if (43 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 43)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142036", "story_v_out_317142.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142036", "story_v_out_317142.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_317142", "317142036", "story_v_out_317142.awb")

						arg_145_1:RecordAudio("317142036", var_148_6)
						arg_145_1:RecordAudio("317142036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_317142", "317142036", "story_v_out_317142.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_317142", "317142036", "story_v_out_317142.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play317142037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 317142037
		arg_149_1.duration_ = 9.47

		local var_149_0 = {
			zh = 8.2,
			ja = 9.466
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
				arg_149_0:Play317142038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.975

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(317142037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 39 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 39)

				if (39 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 39)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142037", "story_v_out_317142.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142037", "story_v_out_317142.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_317142", "317142037", "story_v_out_317142.awb")

						arg_149_1:RecordAudio("317142037", var_152_6)
						arg_149_1:RecordAudio("317142037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_317142", "317142037", "story_v_out_317142.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_317142", "317142037", "story_v_out_317142.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play317142038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 317142038
		arg_153_1.duration_ = 10.5

		local var_153_0 = {
			zh = 7.4,
			ja = 10.5
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
				arg_153_0:Play317142039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.65

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(317142038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 26 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 26)

				if (26 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 26)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142038", "story_v_out_317142.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142038", "story_v_out_317142.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_317142", "317142038", "story_v_out_317142.awb")

						arg_153_1:RecordAudio("317142038", var_156_6)
						arg_153_1:RecordAudio("317142038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_317142", "317142038", "story_v_out_317142.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_317142", "317142038", "story_v_out_317142.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play317142039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 317142039
		arg_157_1.duration_ = 9

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play317142040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.bgs_.YA0106a == nil then
				local var_160_0 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0106a")
				var_160_0.name = "YA0106a"
				var_160_0.transform.parent = arg_157_1.stage_.transform
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_.YA0106a = var_160_0
			end

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				local var_160_1 = arg_157_1.bgs_.YA0106a

				arg_157_1.bgs_.YA0106a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_2 = var_160_1:GetComponent("SpriteRenderer")

				if var_160_2 and var_160_2.sprite then
					local var_160_3 = 2 * (var_160_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_1.transform.localScale = Vector3.New(var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "YA0106a" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_4 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_5 = 2

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_5 then
				local var_160_6 = Color.New(0, 0, 0)

				var_160_6.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_4) / var_160_5)
				arg_157_1.mask_.color = var_160_6
			end

			if arg_157_1.time_ >= var_160_4 + var_160_5 and arg_157_1.time_ < var_160_4 + var_160_5 + arg_160_0 then
				local var_160_7 = Color.New(0, 0, 0)

				var_160_7.a = 1
				arg_157_1.mask_.color = var_160_7
			end

			local var_160_8 = 2

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_9 = 2

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 then
				local var_160_10 = Color.New(0, 0, 0)

				var_160_10.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_8) / var_160_9)
				arg_157_1.mask_.color = var_160_10
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 then
				local var_160_11 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_11.a = 0
				arg_157_1.mask_.color = var_160_11
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_12 = 4
			local var_160_13 = 0.775

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_14 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_14:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(317142039).content)

				arg_157_1.text_.text = var_160_15

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 31 <= 0 and var_160_13 or var_160_13 * (utf8.len(var_160_15) / 31)

				if (31 <= 0 and var_160_13 or var_160_13 * (utf8.len(var_160_15) / 31)) > 0 and var_160_13 < var_160_17 then
					arg_157_1.talkMaxDuration = var_160_17
					var_160_12 = var_160_12 + 0.3

					if var_160_17 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_17 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_15
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_18 = var_160_12 + 0.3
			local var_160_19 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_18 + var_160_19 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_18) / var_160_19

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_18 + var_160_19 and arg_157_1.time_ < var_160_18 + var_160_19 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play317142040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 317142040
		arg_163_1.duration_ = 11.1

		local var_163_0 = {
			zh = 6.4,
			ja = 11.1
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play317142041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.6

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(317142040)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 24 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 24)

				if (24 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 24)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142040", "story_v_out_317142.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142040", "story_v_out_317142.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_317142", "317142040", "story_v_out_317142.awb")

						arg_163_1:RecordAudio("317142040", var_166_6)
						arg_163_1:RecordAudio("317142040", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_317142", "317142040", "story_v_out_317142.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_317142", "317142040", "story_v_out_317142.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play317142041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 317142041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play317142042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.675

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(317142041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 27 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 27)

				if (27 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 27)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play317142042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 317142042
		arg_171_1.duration_ = 6.97

		local var_171_0 = {
			zh = 5.733,
			ja = 6.966
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play317142043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.85

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(317142042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 34 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 34)

				if (34 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 34)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142042", "story_v_out_317142.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142042", "story_v_out_317142.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_317142", "317142042", "story_v_out_317142.awb")

						arg_171_1:RecordAudio("317142042", var_174_6)
						arg_171_1:RecordAudio("317142042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_317142", "317142042", "story_v_out_317142.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_317142", "317142042", "story_v_out_317142.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play317142043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 317142043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play317142044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.85

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(317142043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 74 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 74)

				if (74 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 74)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play317142044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317142044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317142045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.25

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(317142044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 10 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 10)

				if (10 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 10)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play317142045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 317142045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play317142046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.475

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(317142045).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 19 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 19)

				if (19 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 19)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play317142046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 317142046
		arg_187_1.duration_ = 10.5

		local var_187_0 = {
			zh = 4.333,
			ja = 10.5
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play317142047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.6

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(317142046)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 24 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 24)

				if (24 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 24)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142046", "story_v_out_317142.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142046", "story_v_out_317142.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_317142", "317142046", "story_v_out_317142.awb")

						arg_187_1:RecordAudio("317142046", var_190_6)
						arg_187_1:RecordAudio("317142046", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_317142", "317142046", "story_v_out_317142.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_317142", "317142046", "story_v_out_317142.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play317142047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317142047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play317142048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.5

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

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(317142047).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 60 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 60)

				if (60 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 60)) > 0 and var_194_0 < var_194_3 then
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
	Play317142048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317142048
		arg_195_1.duration_ = 13.7

		local var_195_0 = {
			zh = 7.966,
			ja = 13.7
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
				arg_195_0:Play317142049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.925

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(317142048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 37 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 37)

				if (37 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 37)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142048", "story_v_out_317142.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142048", "story_v_out_317142.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_317142", "317142048", "story_v_out_317142.awb")

						arg_195_1:RecordAudio("317142048", var_198_6)
						arg_195_1:RecordAudio("317142048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_317142", "317142048", "story_v_out_317142.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_317142", "317142048", "story_v_out_317142.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play317142049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317142049
		arg_199_1.duration_ = 5.5

		local var_199_0 = {
			zh = 5.266,
			ja = 5.5
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
				arg_199_0:Play317142050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.55

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(317142049)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 22 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 22)

				if (22 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 22)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142049", "story_v_out_317142.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142049", "story_v_out_317142.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_317142", "317142049", "story_v_out_317142.awb")

						arg_199_1:RecordAudio("317142049", var_202_6)
						arg_199_1:RecordAudio("317142049", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_317142", "317142049", "story_v_out_317142.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_317142", "317142049", "story_v_out_317142.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play317142050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317142050
		arg_203_1.duration_ = 11.83

		local var_203_0 = {
			zh = 10.366,
			ja = 11.833
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
				arg_203_0:Play317142051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(317142050)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 40 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 40)

				if (40 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 40)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142050", "story_v_out_317142.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142050", "story_v_out_317142.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_317142", "317142050", "story_v_out_317142.awb")

						arg_203_1:RecordAudio("317142050", var_206_6)
						arg_203_1:RecordAudio("317142050", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_317142", "317142050", "story_v_out_317142.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_317142", "317142050", "story_v_out_317142.awb")
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
	Play317142051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317142051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play317142052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.925

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(317142051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 37 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 37)

				if (37 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 37)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play317142052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317142052
		arg_211_1.duration_ = 10.63

		local var_211_0 = {
			zh = 4.2,
			ja = 10.633
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
				arg_211_0:Play317142053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.55

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(317142052)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 22 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 22)

				if (22 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 22)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142052", "story_v_out_317142.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142052", "story_v_out_317142.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_317142", "317142052", "story_v_out_317142.awb")

						arg_211_1:RecordAudio("317142052", var_214_6)
						arg_211_1:RecordAudio("317142052", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_317142", "317142052", "story_v_out_317142.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_317142", "317142052", "story_v_out_317142.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play317142053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317142053
		arg_215_1.duration_ = 8.53

		local var_215_0 = {
			zh = 5.8,
			ja = 8.533
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
				arg_215_0:Play317142054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.675

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(317142053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 27 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 27)

				if (27 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 27)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142053", "story_v_out_317142.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_317142", "317142053", "story_v_out_317142.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_317142", "317142053", "story_v_out_317142.awb")

						arg_215_1:RecordAudio("317142053", var_218_6)
						arg_215_1:RecordAudio("317142053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317142", "317142053", "story_v_out_317142.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317142", "317142053", "story_v_out_317142.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play317142054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317142054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play317142055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_222_1 = 0
			local var_222_2 = 0.525

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

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(317142054).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 21 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 21)

				if (21 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 21)) > 0 and var_222_2 < var_222_5 then
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
	Play317142055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317142055
		arg_223_1.duration_ = 13

		local var_223_0 = {
			zh = 11.4,
			ja = 13
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
				arg_223_0:Play317142056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if arg_223_1.bgs_.K09f == nil then
				local var_226_0 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09f")
				var_226_0.name = "K09f"
				var_226_0.transform.parent = arg_223_1.stage_.transform
				var_226_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_.K09f = var_226_0
			end

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= 2 + arg_226_0 then
				local var_226_1 = arg_223_1.bgs_.K09f

				arg_223_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_226_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_2 = var_226_1:GetComponent("SpriteRenderer")

				if var_226_2 and var_226_2.sprite then
					local var_226_3 = 2 * (var_226_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_226_1.transform.localScale = Vector3.New(var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, var_226_3 / var_226_2.sprite.bounds.size.y < var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x and var_226_3 * manager.ui.mainCameraCom_.aspect / var_226_2.sprite.bounds.size.x or var_226_3 / var_226_2.sprite.bounds.size.y, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "K09f" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_4 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_5 = 2

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_5 then
				local var_226_6 = Color.New(0, 0, 0)

				var_226_6.a = Mathf.Lerp(0, 1, (arg_223_1.time_ - var_226_4) / var_226_5)
				arg_223_1.mask_.color = var_226_6
			end

			if arg_223_1.time_ >= var_226_4 + var_226_5 and arg_223_1.time_ < var_226_4 + var_226_5 + arg_226_0 then
				local var_226_7 = Color.New(0, 0, 0)

				var_226_7.a = 1
				arg_223_1.mask_.color = var_226_7
			end

			local var_226_8 = 2

			if 2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_9 = 2

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 then
				local var_226_10 = Color.New(0, 0, 0)

				var_226_10.a = Mathf.Lerp(1, 0, (arg_223_1.time_ - var_226_8) / var_226_9)
				arg_223_1.mask_.color = var_226_10
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 then
				local var_226_11 = Color.New(0, 0, 0)

				arg_223_1.mask_.enabled = false
				var_226_11.a = 0
				arg_223_1.mask_.color = var_226_11
			end

			local var_226_12 = "1015ui_story"

			if arg_223_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_226_13 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_223_1.stage_.transform)

				var_226_13.name = var_226_12
				var_226_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.actors_[var_226_12] = var_226_13

				local var_226_14 = var_226_13:GetComponentInChildren(typeof(CharacterEffect))

				var_226_14.enabled = true

				local var_226_15 = GameObjectTools.GetOrAddComponent(var_226_13, typeof(DynamicBoneHelper))

				if var_226_15 then
					var_226_15:EnableDynamicBone(false)
				end

				arg_223_1:ShowWeapon(var_226_14.transform, false)

				arg_223_1.var_[var_226_12 .. "Animator"] = var_226_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_223_1.var_[var_226_12 .. "Animator"].applyRootMotion = true
				arg_223_1.var_[var_226_12 .. "LipSync"] = var_226_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_226_16 = arg_223_1.actors_["1015ui_story"].transform

			if 4 < arg_223_1.time_ and arg_223_1.time_ <= 4 + arg_226_0 then
				arg_223_1.var_.moveOldPos1015ui_story = var_226_16.localPosition
			end

			local var_226_17 = 0.001

			if 4 <= arg_223_1.time_ and arg_223_1.time_ < 4 + var_226_17 then
				var_226_16.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_223_1.time_ - 4) / var_226_17)
				var_226_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_16.position).x, (manager.ui.mainCamera.transform.position - var_226_16.position).y, (manager.ui.mainCamera.transform.position - var_226_16.position).z)
				var_226_16.localEulerAngles.z = 0
				var_226_16.localEulerAngles.x = 0
				var_226_16.localEulerAngles = var_226_16.localEulerAngles
			end

			if arg_223_1.time_ >= 4 + var_226_17 and arg_223_1.time_ < 4 + var_226_17 + arg_226_0 then
				var_226_16.localPosition = Vector3.New(0, -1.15, -6.2)
				var_226_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_16.position).x, (manager.ui.mainCamera.transform.position - var_226_16.position).y, (manager.ui.mainCamera.transform.position - var_226_16.position).z)
				var_226_16.localEulerAngles.z = 0
				var_226_16.localEulerAngles.x = 0
				var_226_16.localEulerAngles = var_226_16.localEulerAngles
			end

			local var_226_18 = arg_223_1.actors_["1015ui_story"]

			if 4 < arg_223_1.time_ and arg_223_1.time_ <= 4 + arg_226_0 and not isNil(var_226_18) and arg_223_1.var_.characterEffect1015ui_story == nil then
				arg_223_1.var_.characterEffect1015ui_story = var_226_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_19 = 0.200000002980232

			if 4 <= arg_223_1.time_ and arg_223_1.time_ < 4 + var_226_19 and not isNil(var_226_18) then
				if arg_223_1.var_.characterEffect1015ui_story and not isNil(var_226_18) then
					arg_223_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 4 + var_226_19 and arg_223_1.time_ < 4 + var_226_19 + arg_226_0 and not isNil(var_226_18) and arg_223_1.var_.characterEffect1015ui_story then
				arg_223_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 4 < arg_223_1.time_ and arg_223_1.time_ <= 4 + arg_226_0 then
				arg_223_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 4 < arg_223_1.time_ and arg_223_1.time_ <= 4 + arg_226_0 then
				arg_223_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_21 = 4
			local var_226_22 = 0.875

			if 4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_21 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_23 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_23:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_24 = arg_223_1:GetWordFromCfg(317142055)
				local var_226_25 = arg_223_1:FormatText(var_226_24.content)

				arg_223_1.text_.text = var_226_25

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_27 = 35 <= 0 and var_226_22 or var_226_22 * (utf8.len(var_226_25) / 35)

				if (35 <= 0 and var_226_22 or var_226_22 * (utf8.len(var_226_25) / 35)) > 0 and var_226_22 < var_226_27 then
					arg_223_1.talkMaxDuration = var_226_27
					var_226_21 = var_226_21 + 0.3

					if var_226_27 + var_226_21 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_27 + var_226_21
					end
				end

				arg_223_1.text_.text = var_226_25
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142055", "story_v_out_317142.awb") ~= 0 then
					local var_226_28 = manager.audio:GetVoiceLength("story_v_out_317142", "317142055", "story_v_out_317142.awb") / 1000

					if var_226_28 + var_226_21 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_28 + var_226_21
					end

					if var_226_24.prefab_name ~= "" and arg_223_1.actors_[var_226_24.prefab_name] ~= nil then
						local var_226_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_24.prefab_name].transform, "story_v_out_317142", "317142055", "story_v_out_317142.awb")

						arg_223_1:RecordAudio("317142055", var_226_29)
						arg_223_1:RecordAudio("317142055", var_226_29)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_317142", "317142055", "story_v_out_317142.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_317142", "317142055", "story_v_out_317142.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_30 = var_226_21 + 0.3
			local var_226_31 = math.max(var_226_22, arg_223_1.talkMaxDuration)

			if var_226_21 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_30 + var_226_31 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_30) / var_226_31

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_30 + var_226_31 and arg_223_1.time_ < var_226_30 + var_226_31 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play317142056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 317142056
		arg_229_1.duration_ = 3.6

		local var_229_0 = {
			zh = 3.166,
			ja = 3.6
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
				arg_229_0:Play317142057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if arg_229_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_232_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_229_1.stage_.transform)

				var_232_0.name = "2079ui_story"
				var_232_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["2079ui_story"] = var_232_0

				local var_232_1 = var_232_0:GetComponentInChildren(typeof(CharacterEffect))

				var_232_1.enabled = true

				local var_232_2 = GameObjectTools.GetOrAddComponent(var_232_0, typeof(DynamicBoneHelper))

				if var_232_2 then
					var_232_2:EnableDynamicBone(false)
				end

				arg_229_1:ShowWeapon(var_232_1.transform, false)

				arg_229_1.var_["2079ui_story" .. "Animator"] = var_232_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_229_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_229_1.var_["2079ui_story" .. "LipSync"] = var_232_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_232_3 = arg_229_1.actors_["2079ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos2079ui_story = var_232_3.localPosition
			end

			local var_232_4 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				var_232_3.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_229_1.time_ - 0) / var_232_4)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				var_232_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			local var_232_5 = arg_229_1.actors_["2079ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect2079ui_story == nil then
				arg_229_1.var_.characterEffect2079ui_story = var_232_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_6 and not isNil(var_232_5) then
				if arg_229_1.var_.characterEffect2079ui_story and not isNil(var_232_5) then
					arg_229_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_6 and arg_229_1.time_ < 0 + var_232_6 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect2079ui_story then
				arg_229_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_8 = arg_229_1.actors_["1015ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1015ui_story = var_232_8.localPosition
			end

			local var_232_9 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_9 then
				var_232_8.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_9)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_9 and arg_229_1.time_ < 0 + var_232_9 + arg_232_0 then
				var_232_8.localPosition = Vector3.New(0, 100, 0)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			local var_232_10 = arg_229_1.actors_["1015ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect1015ui_story == nil then
				arg_229_1.var_.characterEffect1015ui_story = var_232_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_11 and not isNil(var_232_10) then
				if arg_229_1.var_.characterEffect1015ui_story and not isNil(var_232_10) then
					arg_229_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_11)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_11 and arg_229_1.time_ < 0 + var_232_11 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect1015ui_story then
				arg_229_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_232_12 = 0
			local var_232_13 = 0.225

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_14 = arg_229_1:GetWordFromCfg(317142056)
				local var_232_15 = arg_229_1:FormatText(var_232_14.content)

				arg_229_1.text_.text = var_232_15

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 9 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 9)

				if (9 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 9)) > 0 and var_232_13 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17

					if var_232_17 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_15
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142056", "story_v_out_317142.awb") ~= 0 then
					local var_232_18 = manager.audio:GetVoiceLength("story_v_out_317142", "317142056", "story_v_out_317142.awb") / 1000

					if var_232_18 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_12
					end

					if var_232_14.prefab_name ~= "" and arg_229_1.actors_[var_232_14.prefab_name] ~= nil then
						local var_232_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_14.prefab_name].transform, "story_v_out_317142", "317142056", "story_v_out_317142.awb")

						arg_229_1:RecordAudio("317142056", var_232_19)
						arg_229_1:RecordAudio("317142056", var_232_19)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_317142", "317142056", "story_v_out_317142.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_317142", "317142056", "story_v_out_317142.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_20 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_20

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_20 and arg_229_1.time_ < var_232_12 + var_232_20 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play317142057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 317142057
		arg_233_1.duration_ = 5.1

		local var_233_0 = {
			zh = 2.8,
			ja = 5.1
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
				arg_233_0:Play317142058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos2079ui_story = arg_233_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["2079ui_story"].transform.position).z)
				arg_233_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["2079ui_story"].transform.localEulerAngles = arg_233_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_233_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["2079ui_story"].transform.position).z)
				arg_233_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["2079ui_story"].transform.localEulerAngles = arg_233_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["2079ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect2079ui_story == nil then
				arg_233_1.var_.characterEffect2079ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect2079ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect2079ui_story then
				arg_233_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = 0
			local var_236_5 = 0.3

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(317142057)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 12 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 12)

				if (12 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 12)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142057", "story_v_out_317142.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_317142", "317142057", "story_v_out_317142.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_317142", "317142057", "story_v_out_317142.awb")

						arg_233_1:RecordAudio("317142057", var_236_11)
						arg_233_1:RecordAudio("317142057", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_317142", "317142057", "story_v_out_317142.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_317142", "317142057", "story_v_out_317142.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play317142058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 317142058
		arg_237_1.duration_ = 3.9

		local var_237_0 = {
			zh = 3.9,
			ja = 3.166
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
				arg_237_0:Play317142059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_240_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_237_1.stage_.transform)

				var_240_0.name = "2078ui_story"
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["2078ui_story"] = var_240_0

				local var_240_1 = var_240_0:GetComponentInChildren(typeof(CharacterEffect))

				var_240_1.enabled = true

				local var_240_2 = GameObjectTools.GetOrAddComponent(var_240_0, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(false)
				end

				arg_237_1:ShowWeapon(var_240_1.transform, false)

				arg_237_1.var_["2078ui_story" .. "Animator"] = var_240_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_237_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_237_1.var_["2078ui_story" .. "LipSync"] = var_240_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_240_3 = arg_237_1.actors_["2078ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos2078ui_story = var_240_3.localPosition
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_3.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_237_1.time_ - 0) / var_240_4)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			local var_240_5 = arg_237_1.actors_["2078ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect2078ui_story == nil then
				arg_237_1.var_.characterEffect2078ui_story = var_240_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_6 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.characterEffect2078ui_story and not isNil(var_240_5) then
					arg_237_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect2078ui_story then
				arg_237_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_8 = arg_237_1.actors_["2079ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos2079ui_story = var_240_8.localPosition
			end

			local var_240_9 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_9 then
				var_240_8.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_9)
				var_240_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_8.position).x, (manager.ui.mainCamera.transform.position - var_240_8.position).y, (manager.ui.mainCamera.transform.position - var_240_8.position).z)
				var_240_8.localEulerAngles.z = 0
				var_240_8.localEulerAngles.x = 0
				var_240_8.localEulerAngles = var_240_8.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_9 and arg_237_1.time_ < 0 + var_240_9 + arg_240_0 then
				var_240_8.localPosition = Vector3.New(0, 100, 0)
				var_240_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_8.position).x, (manager.ui.mainCamera.transform.position - var_240_8.position).y, (manager.ui.mainCamera.transform.position - var_240_8.position).z)
				var_240_8.localEulerAngles.z = 0
				var_240_8.localEulerAngles.x = 0
				var_240_8.localEulerAngles = var_240_8.localEulerAngles
			end

			local var_240_10 = 0
			local var_240_11 = 0.325

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_12 = arg_237_1:GetWordFromCfg(317142058)
				local var_240_13 = arg_237_1:FormatText(var_240_12.content)

				arg_237_1.text_.text = var_240_13

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_15 = 13 <= 0 and var_240_11 or var_240_11 * (utf8.len(var_240_13) / 13)

				if (13 <= 0 and var_240_11 or var_240_11 * (utf8.len(var_240_13) / 13)) > 0 and var_240_11 < var_240_15 then
					arg_237_1.talkMaxDuration = var_240_15

					if var_240_15 + var_240_10 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_15 + var_240_10
					end
				end

				arg_237_1.text_.text = var_240_13
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142058", "story_v_out_317142.awb") ~= 0 then
					local var_240_16 = manager.audio:GetVoiceLength("story_v_out_317142", "317142058", "story_v_out_317142.awb") / 1000

					if var_240_16 + var_240_10 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_16 + var_240_10
					end

					if var_240_12.prefab_name ~= "" and arg_237_1.actors_[var_240_12.prefab_name] ~= nil then
						local var_240_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_12.prefab_name].transform, "story_v_out_317142", "317142058", "story_v_out_317142.awb")

						arg_237_1:RecordAudio("317142058", var_240_17)
						arg_237_1:RecordAudio("317142058", var_240_17)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_317142", "317142058", "story_v_out_317142.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_317142", "317142058", "story_v_out_317142.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_18 = math.max(var_240_11, arg_237_1.talkMaxDuration)

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_18 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_10) / var_240_18

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_10 + var_240_18 and arg_237_1.time_ < var_240_10 + var_240_18 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play317142059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 317142059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play317142060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos2078ui_story = arg_241_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2078ui_story"].transform.position).z)
				arg_241_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["2078ui_story"].transform.localEulerAngles = arg_241_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2078ui_story"].transform.position).z)
				arg_241_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["2078ui_story"].transform.localEulerAngles = arg_241_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["2078ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect2078ui_story == nil then
				arg_241_1.var_.characterEffect2078ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect2078ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_241_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_2)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect2078ui_story then
				arg_241_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_241_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_244_3 = 0
			local var_244_4 = 1.325

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(317142059).content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 53 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 53)

				if (53 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 53)) > 0 and var_244_4 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_8 and arg_241_1.time_ < var_244_3 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play317142060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 317142060
		arg_245_1.duration_ = 5.67

		local var_245_0 = {
			zh = 4.433,
			ja = 5.666
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
				arg_245_0:Play317142061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if arg_245_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_248_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_245_1.stage_.transform)

				var_248_0.name = "1093ui_story"
				var_248_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1093ui_story"] = var_248_0

				local var_248_1 = var_248_0:GetComponentInChildren(typeof(CharacterEffect))

				var_248_1.enabled = true

				local var_248_2 = GameObjectTools.GetOrAddComponent(var_248_0, typeof(DynamicBoneHelper))

				if var_248_2 then
					var_248_2:EnableDynamicBone(false)
				end

				arg_245_1:ShowWeapon(var_248_1.transform, false)

				arg_245_1.var_["1093ui_story" .. "Animator"] = var_248_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_245_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_245_1.var_["1093ui_story" .. "LipSync"] = var_248_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_248_3 = arg_245_1.actors_["1093ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1093ui_story = var_248_3.localPosition
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_3.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_245_1.time_ - 0) / var_248_4)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				var_248_3.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			local var_248_5 = arg_245_1.actors_["1093ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1093ui_story == nil then
				arg_245_1.var_.characterEffect1093ui_story = var_248_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_6 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 and not isNil(var_248_5) then
				if arg_245_1.var_.characterEffect1093ui_story and not isNil(var_248_5) then
					arg_245_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1093ui_story then
				arg_245_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_8 = 0
			local var_248_9 = 0.525

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_10 = arg_245_1:GetWordFromCfg(317142060)
				local var_248_11 = arg_245_1:FormatText(var_248_10.content)

				arg_245_1.text_.text = var_248_11

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 21 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 21)

				if (21 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 21)) > 0 and var_248_9 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_11
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142060", "story_v_out_317142.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_out_317142", "317142060", "story_v_out_317142.awb") / 1000

					if var_248_14 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_8
					end

					if var_248_10.prefab_name ~= "" and arg_245_1.actors_[var_248_10.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_10.prefab_name].transform, "story_v_out_317142", "317142060", "story_v_out_317142.awb")

						arg_245_1:RecordAudio("317142060", var_248_15)
						arg_245_1:RecordAudio("317142060", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_317142", "317142060", "story_v_out_317142.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_317142", "317142060", "story_v_out_317142.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_16 and arg_245_1.time_ < var_248_8 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play317142061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 317142061
		arg_249_1.duration_ = 5

		local var_249_0 = {
			zh = 3.9,
			ja = 5
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
				arg_249_0:Play317142062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1015ui_story = arg_249_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1015ui_story"].transform.position).z)
				arg_249_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1015ui_story"].transform.localEulerAngles = arg_249_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0.7, -1.15, -6.2)
				arg_249_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1015ui_story"].transform.position).z)
				arg_249_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1015ui_story"].transform.localEulerAngles = arg_249_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1015ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1015ui_story == nil then
				arg_249_1.var_.characterEffect1015ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1015ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1015ui_story then
				arg_249_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_252_4 = arg_249_1.actors_["1093ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1093ui_story == nil then
				arg_249_1.var_.characterEffect1093ui_story = var_252_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_5 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_5 and not isNil(var_252_4) then
				if arg_249_1.var_.characterEffect1093ui_story and not isNil(var_252_4) then
					arg_249_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_5)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_5 and arg_249_1.time_ < 0 + var_252_5 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1093ui_story then
				arg_249_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_252_6 = 0
			local var_252_7 = 0.525

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:GetWordFromCfg(317142061)
				local var_252_9 = arg_249_1:FormatText(var_252_8.content)

				arg_249_1.text_.text = var_252_9

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 21 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_9) / 21)

				if (21 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_9) / 21)) > 0 and var_252_7 < var_252_11 then
					arg_249_1.talkMaxDuration = var_252_11

					if var_252_11 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_9
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142061", "story_v_out_317142.awb") ~= 0 then
					local var_252_12 = manager.audio:GetVoiceLength("story_v_out_317142", "317142061", "story_v_out_317142.awb") / 1000

					if var_252_12 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_6
					end

					if var_252_8.prefab_name ~= "" and arg_249_1.actors_[var_252_8.prefab_name] ~= nil then
						local var_252_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_8.prefab_name].transform, "story_v_out_317142", "317142061", "story_v_out_317142.awb")

						arg_249_1:RecordAudio("317142061", var_252_13)
						arg_249_1:RecordAudio("317142061", var_252_13)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_317142", "317142061", "story_v_out_317142.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_317142", "317142061", "story_v_out_317142.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play317142062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 317142062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play317142063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1015ui_story"]) and arg_253_1.var_.characterEffect1015ui_story == nil then
				arg_253_1.var_.characterEffect1015ui_story = arg_253_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1015ui_story"]) then
				if arg_253_1.var_.characterEffect1015ui_story and not isNil(arg_253_1.actors_["1015ui_story"]) then
					arg_253_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1015ui_story"]) and arg_253_1.var_.characterEffect1015ui_story then
				arg_253_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.65

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(317142062).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 26 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 26)

				if (26 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 26)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play317142063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 317142063
		arg_257_1.duration_ = 3.9

		local var_257_0 = {
			zh = 3.9,
			ja = 2.4
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
				arg_257_0:Play317142064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1015ui_story = arg_257_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).z)
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles = arg_257_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_257_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).z)
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles = arg_257_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1015ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1015ui_story == nil then
				arg_257_1.var_.characterEffect1015ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1015ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1015ui_story then
				arg_257_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_4 = arg_257_1.actors_["1093ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1093ui_story = var_260_4.localPosition
			end

			local var_260_5 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_5 then
				var_260_4.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_5)
				var_260_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_4.position).x, (manager.ui.mainCamera.transform.position - var_260_4.position).y, (manager.ui.mainCamera.transform.position - var_260_4.position).z)
				var_260_4.localEulerAngles.z = 0
				var_260_4.localEulerAngles.x = 0
				var_260_4.localEulerAngles = var_260_4.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_5 and arg_257_1.time_ < 0 + var_260_5 + arg_260_0 then
				var_260_4.localPosition = Vector3.New(0, 100, 0)
				var_260_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_4.position).x, (manager.ui.mainCamera.transform.position - var_260_4.position).y, (manager.ui.mainCamera.transform.position - var_260_4.position).z)
				var_260_4.localEulerAngles.z = 0
				var_260_4.localEulerAngles.x = 0
				var_260_4.localEulerAngles = var_260_4.localEulerAngles
			end

			local var_260_6 = arg_257_1.actors_["1093ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect1093ui_story == nil then
				arg_257_1.var_.characterEffect1093ui_story = var_260_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_7 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 and not isNil(var_260_6) then
				if arg_257_1.var_.characterEffect1093ui_story and not isNil(var_260_6) then
					arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_7)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect1093ui_story then
				arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_260_8 = 0
			local var_260_9 = 0.25

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(317142063)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 10 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 10)

				if (10 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 10)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142063", "story_v_out_317142.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_317142", "317142063", "story_v_out_317142.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_317142", "317142063", "story_v_out_317142.awb")

						arg_257_1:RecordAudio("317142063", var_260_15)
						arg_257_1:RecordAudio("317142063", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_317142", "317142063", "story_v_out_317142.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_317142", "317142063", "story_v_out_317142.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317142064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 317142064
		arg_261_1.duration_ = 5.63

		local var_261_0 = {
			zh = 5.633,
			ja = 5.433
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
				arg_261_0:Play317142065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1015ui_story = arg_261_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).z)
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles = arg_261_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).z)
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles = arg_261_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_264_1 = 0
			local var_264_2 = 0.825

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(317142064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_6 = 33 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_4) / 33)

				if (33 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_4) / 33)) > 0 and var_264_2 < var_264_6 then
					arg_261_1.talkMaxDuration = var_264_6

					if var_264_6 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142064", "story_v_out_317142.awb") ~= 0 then
					local var_264_7 = manager.audio:GetVoiceLength("story_v_out_317142", "317142064", "story_v_out_317142.awb") / 1000

					if var_264_7 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_1
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_317142", "317142064", "story_v_out_317142.awb")

						arg_261_1:RecordAudio("317142064", var_264_8)
						arg_261_1:RecordAudio("317142064", var_264_8)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_317142", "317142064", "story_v_out_317142.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_317142", "317142064", "story_v_out_317142.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_9 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_9 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_9

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_9 and arg_261_1.time_ < var_264_1 + var_264_9 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play317142065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 317142065
		arg_265_1.duration_ = 6.7

		local var_265_0 = {
			zh = 4.4,
			ja = 6.7
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play317142066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1015ui_story = arg_265_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1015ui_story"].transform.position).z)
				arg_265_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1015ui_story"].transform.localEulerAngles = arg_265_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_265_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1015ui_story"].transform.position).z)
				arg_265_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1015ui_story"].transform.localEulerAngles = arg_265_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1015ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1015ui_story == nil then
				arg_265_1.var_.characterEffect1015ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1015ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1015ui_story then
				arg_265_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_4 = 0
			local var_268_5 = 0.65

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(317142065)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 26 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 26)

				if (26 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 26)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142065", "story_v_out_317142.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_317142", "317142065", "story_v_out_317142.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_317142", "317142065", "story_v_out_317142.awb")

						arg_265_1:RecordAudio("317142065", var_268_11)
						arg_265_1:RecordAudio("317142065", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_317142", "317142065", "story_v_out_317142.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_317142", "317142065", "story_v_out_317142.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play317142066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 317142066
		arg_269_1.duration_ = 2.97

		local var_269_0 = {
			zh = 2.4,
			ja = 2.966
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
				arg_269_0:Play317142067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1015ui_story = arg_269_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1015ui_story"].transform.position).z)
				arg_269_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1015ui_story"].transform.localEulerAngles = arg_269_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1015ui_story"].transform.position).z)
				arg_269_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1015ui_story"].transform.localEulerAngles = arg_269_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_272_1 = 0
			local var_272_2 = 0.275

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[548].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(317142066)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_6 = 11 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_4) / 11)

				if (11 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_4) / 11)) > 0 and var_272_2 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142066", "story_v_out_317142.awb") ~= 0 then
					local var_272_7 = manager.audio:GetVoiceLength("story_v_out_317142", "317142066", "story_v_out_317142.awb") / 1000

					if var_272_7 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_1
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_317142", "317142066", "story_v_out_317142.awb")

						arg_269_1:RecordAudio("317142066", var_272_8)
						arg_269_1:RecordAudio("317142066", var_272_8)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_317142", "317142066", "story_v_out_317142.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_317142", "317142066", "story_v_out_317142.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_9 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_9 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_9

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_9 and arg_269_1.time_ < var_272_1 + var_272_9 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play317142067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 317142067
		arg_273_1.duration_ = 6.47

		local var_273_0 = {
			zh = 2.733,
			ja = 6.466
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play317142068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1015ui_story = arg_273_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1015ui_story"].transform.position).z)
				arg_273_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1015ui_story"].transform.localEulerAngles = arg_273_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_273_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1015ui_story"].transform.position).z)
				arg_273_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1015ui_story"].transform.localEulerAngles = arg_273_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1015ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1015ui_story == nil then
				arg_273_1.var_.characterEffect1015ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1015ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1015ui_story then
				arg_273_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_276_4 = arg_273_1.actors_["2079ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos2079ui_story = var_276_4.localPosition
			end

			local var_276_5 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 then
				var_276_4.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_5)
				var_276_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_4.position).x, (manager.ui.mainCamera.transform.position - var_276_4.position).y, (manager.ui.mainCamera.transform.position - var_276_4.position).z)
				var_276_4.localEulerAngles.z = 0
				var_276_4.localEulerAngles.x = 0
				var_276_4.localEulerAngles = var_276_4.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 then
				var_276_4.localPosition = Vector3.New(0, 100, 0)
				var_276_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_4.position).x, (manager.ui.mainCamera.transform.position - var_276_4.position).y, (manager.ui.mainCamera.transform.position - var_276_4.position).z)
				var_276_4.localEulerAngles.z = 0
				var_276_4.localEulerAngles.x = 0
				var_276_4.localEulerAngles = var_276_4.localEulerAngles
			end

			local var_276_6 = arg_273_1.actors_["2079ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_6) and arg_273_1.var_.characterEffect2079ui_story == nil then
				arg_273_1.var_.characterEffect2079ui_story = var_276_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_7 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 and not isNil(var_276_6) then
				if arg_273_1.var_.characterEffect2079ui_story and not isNil(var_276_6) then
					arg_273_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_273_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_7)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 and not isNil(var_276_6) and arg_273_1.var_.characterEffect2079ui_story then
				arg_273_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_273_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_276_8 = 0
			local var_276_9 = 0.35

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(317142067)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 14 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 14)

				if (14 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 14)) > 0 and var_276_9 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317142", "317142067", "story_v_out_317142.awb") ~= 0 then
					local var_276_14 = manager.audio:GetVoiceLength("story_v_out_317142", "317142067", "story_v_out_317142.awb") / 1000

					if var_276_14 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_8
					end

					if var_276_10.prefab_name ~= "" and arg_273_1.actors_[var_276_10.prefab_name] ~= nil then
						local var_276_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_10.prefab_name].transform, "story_v_out_317142", "317142067", "story_v_out_317142.awb")

						arg_273_1:RecordAudio("317142067", var_276_15)
						arg_273_1:RecordAudio("317142067", var_276_15)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_317142", "317142067", "story_v_out_317142.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_317142", "317142067", "story_v_out_317142.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_16 and arg_273_1.time_ < var_276_8 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317142068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 317142068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
			arg_277_1.auto_ = false
		end

		function arg_277_1.playNext_(arg_279_0)
			arg_277_1.onStoryFinished_()
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1015ui_story = arg_277_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1015ui_story"].transform.position).z)
				arg_277_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1015ui_story"].transform.localEulerAngles = arg_277_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1015ui_story"].transform.position).z)
				arg_277_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1015ui_story"].transform.localEulerAngles = arg_277_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_280_1 = 0
			local var_280_2 = 0.55

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(317142068).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 22 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 22)

				if (22 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 22)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/YA0106",
		"TextureConfig/Background/YA0106a",
		"TextureConfig/Background/K09f"
	},
	voices = {
		"story_v_out_317142.awb"
	}
}
