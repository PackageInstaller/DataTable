return {
	Play323151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323151001
		arg_1_1.duration_ = 13.3

		local var_1_0 = {
			zh = 11.066,
			ja = 13.3
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
				arg_1_0:Play323151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2002 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2002")
				var_4_0.name = "ST2002"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2002 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2002

				arg_1_1.bgs_.ST2002.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2002" then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.8
			local var_4_17 = 0.9

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(323151001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 36 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 36)

				if (36 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 36)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151001", "story_v_out_323151.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_323151", "323151001", "story_v_out_323151.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_323151", "323151001", "story_v_out_323151.awb")

						arg_1_1:RecordAudio("323151001", var_4_24)
						arg_1_1:RecordAudio("323151001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_323151", "323151001", "story_v_out_323151.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_323151", "323151001", "story_v_out_323151.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323151002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323151002
		arg_9_1.duration_ = 17.2

		local var_9_0 = {
			zh = 14.6,
			ja = 17.2
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
				arg_9_0:Play323151003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1351].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(323151002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 49 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 49)

				if (49 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 49)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151002", "story_v_out_323151.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151002", "story_v_out_323151.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_323151", "323151002", "story_v_out_323151.awb")

						arg_9_1:RecordAudio("323151002", var_12_6)
						arg_9_1:RecordAudio("323151002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_323151", "323151002", "story_v_out_323151.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_323151", "323151002", "story_v_out_323151.awb")
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
	Play323151003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323151003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323151004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(323151003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 55 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 55)

				if (55 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 55)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play323151004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323151004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323151005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(323151004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 54 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 54)

				if (54 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 54)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play323151005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323151005
		arg_21_1.duration_ = 9.37

		local var_21_0 = {
			zh = 7.4,
			ja = 9.366
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
				arg_21_0:Play323151006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.925

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1456].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(323151005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)

				if (37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 37)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151005", "story_v_out_323151.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151005", "story_v_out_323151.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_323151", "323151005", "story_v_out_323151.awb")

						arg_21_1:RecordAudio("323151005", var_24_6)
						arg_21_1:RecordAudio("323151005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_323151", "323151005", "story_v_out_323151.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_323151", "323151005", "story_v_out_323151.awb")
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
	Play323151006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323151006
		arg_25_1.duration_ = 4.9

		local var_25_0 = {
			zh = 3.133,
			ja = 4.9
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
				arg_25_0:Play323151007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1457].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(323151006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 16 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 16)

				if (16 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 16)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151006", "story_v_out_323151.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151006", "story_v_out_323151.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_323151", "323151006", "story_v_out_323151.awb")

						arg_25_1:RecordAudio("323151006", var_28_6)
						arg_25_1:RecordAudio("323151006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_323151", "323151006", "story_v_out_323151.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_323151", "323151006", "story_v_out_323151.awb")
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
	Play323151007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323151007
		arg_29_1.duration_ = 9.3

		local var_29_0 = {
			zh = 6.666,
			ja = 9.3
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
				arg_29_0:Play323151008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.85

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1456].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(323151007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 34 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 34)

				if (34 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 34)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151007", "story_v_out_323151.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151007", "story_v_out_323151.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_323151", "323151007", "story_v_out_323151.awb")

						arg_29_1:RecordAudio("323151007", var_32_6)
						arg_29_1:RecordAudio("323151007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_323151", "323151007", "story_v_out_323151.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_323151", "323151007", "story_v_out_323151.awb")
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
	Play323151008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323151008
		arg_33_1.duration_ = 10.5

		local var_33_0 = {
			zh = 5.8,
			ja = 10.5
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
				arg_33_0:Play323151009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.6

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1457].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(323151008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 24 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 24)

				if (24 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 24)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151008", "story_v_out_323151.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151008", "story_v_out_323151.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_323151", "323151008", "story_v_out_323151.awb")

						arg_33_1:RecordAudio("323151008", var_36_6)
						arg_33_1:RecordAudio("323151008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323151", "323151008", "story_v_out_323151.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323151", "323151008", "story_v_out_323151.awb")
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
	Play323151009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323151009
		arg_37_1.duration_ = 8.7

		local var_37_0 = {
			zh = 6.3,
			ja = 8.7
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
				arg_37_0:Play323151010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.875

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1456].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(323151009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 35 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 35)

				if (35 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 35)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151009", "story_v_out_323151.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151009", "story_v_out_323151.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_323151", "323151009", "story_v_out_323151.awb")

						arg_37_1:RecordAudio("323151009", var_40_6)
						arg_37_1:RecordAudio("323151009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_323151", "323151009", "story_v_out_323151.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_323151", "323151009", "story_v_out_323151.awb")
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
	Play323151010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323151010
		arg_41_1.duration_ = 13.63

		local var_41_0 = {
			zh = 5.333,
			ja = 13.633
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play323151011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1457].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(323151010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 27 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 27)

				if (27 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 27)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151010", "story_v_out_323151.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151010", "story_v_out_323151.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_323151", "323151010", "story_v_out_323151.awb")

						arg_41_1:RecordAudio("323151010", var_44_6)
						arg_41_1:RecordAudio("323151010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323151", "323151010", "story_v_out_323151.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323151", "323151010", "story_v_out_323151.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play323151011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323151011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play323151012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.7

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(323151011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 28 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 28)

				if (28 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 28)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323151012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323151012
		arg_49_1.duration_ = 6.6

		local var_49_0 = {
			zh = 5.433,
			ja = 6.6
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323151013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_52_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_2 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_2

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_2
						arg_49_1.bgmTxt2_.text = var_52_2
					end

					if arg_49_1.bgmTimer then
						arg_49_1.bgmTimer:Stop()

						arg_49_1.bgmTimer = nil
					end

					if arg_49_1.settingData.show_music_name == 1 then
						arg_49_1.musicController:SetSelectedState("show")
						arg_49_1.musicAnimator_:Play("open", 0, 0)

						if arg_49_1.settingData.music_time ~= 0 then
							arg_49_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_49_1.settingData.music_time), function()
								if arg_49_1 == nil or isNil(arg_49_1.bgmTxt_) then
									return
								end

								arg_49_1.musicController:SetSelectedState("hide")
								arg_49_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_52_3 = 0
			local var_52_4 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1457].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_5 = arg_49_1:GetWordFromCfg(323151012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 24 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 24)

				if (24 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 24)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151012", "story_v_out_323151.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_323151", "323151012", "story_v_out_323151.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_323151", "323151012", "story_v_out_323151.awb")

						arg_49_1:RecordAudio("323151012", var_52_10)
						arg_49_1:RecordAudio("323151012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_323151", "323151012", "story_v_out_323151.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_323151", "323151012", "story_v_out_323151.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_11 and arg_49_1.time_ < var_52_3 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323151013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 323151013
		arg_54_1.duration_ = 4.3

		local var_54_0 = {
			zh = 2.166,
			ja = 4.3
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play323151014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.225

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(323151013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 9 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 9)

				if (9 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 9)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151013", "story_v_out_323151.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151013", "story_v_out_323151.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_323151", "323151013", "story_v_out_323151.awb")

						arg_54_1:RecordAudio("323151013", var_57_6)
						arg_54_1:RecordAudio("323151013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_323151", "323151013", "story_v_out_323151.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_323151", "323151013", "story_v_out_323151.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play323151014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 323151014
		arg_58_1.duration_ = 3.83

		local var_58_0 = {
			zh = 2.466,
			ja = 3.833
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play323151015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.4

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1456].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(323151014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 16 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 16)

				if (16 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 16)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151014", "story_v_out_323151.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151014", "story_v_out_323151.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_323151", "323151014", "story_v_out_323151.awb")

						arg_58_1:RecordAudio("323151014", var_61_6)
						arg_58_1:RecordAudio("323151014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_323151", "323151014", "story_v_out_323151.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_323151", "323151014", "story_v_out_323151.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play323151015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 323151015
		arg_62_1.duration_ = 10.43

		local var_62_0 = {
			zh = 10.433,
			ja = 7.433
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
				arg_62_0:Play323151016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.075

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
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(323151015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 43 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 43)

				if (43 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 43)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151015", "story_v_out_323151.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151015", "story_v_out_323151.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_323151", "323151015", "story_v_out_323151.awb")

						arg_62_1:RecordAudio("323151015", var_65_6)
						arg_62_1:RecordAudio("323151015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_323151", "323151015", "story_v_out_323151.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_323151", "323151015", "story_v_out_323151.awb")
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
	Play323151016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 323151016
		arg_66_1.duration_ = 6.87

		local var_66_0 = {
			zh = 3.933,
			ja = 6.866
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
				arg_66_0:Play323151017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_69_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_66_1.stage_.transform)

				var_69_0.name = "1059ui_story"
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1059ui_story"] = var_69_0

				local var_69_1 = var_69_0:GetComponentInChildren(typeof(CharacterEffect))

				var_69_1.enabled = true

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_1.transform, false)

				arg_66_1.var_["1059ui_story" .. "Animator"] = var_69_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_66_1.var_["1059ui_story" .. "LipSync"] = var_69_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_3 = arg_66_1.actors_["1059ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect1059ui_story == nil then
				arg_66_1.var_.characterEffect1059ui_story = var_69_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_4 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 and not isNil(var_69_3) then
				if arg_66_1.var_.characterEffect1059ui_story and not isNil(var_69_3) then
					arg_66_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_4)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect1059ui_story then
				arg_66_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_69_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_7 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_7

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_7
						arg_66_1.bgmTxt2_.text = var_69_7
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_66_1.time_ and arg_66_1.time_ <= 0.433333333333333 + arg_69_0 then
				arg_66_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_69_10 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_10 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_10

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_10
						arg_66_1.bgmTxt2_.text = var_69_10
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_69_11 = 0
			local var_69_12 = 0.475

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1457].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_13 = arg_66_1:GetWordFromCfg(323151016)
				local var_69_14 = arg_66_1:FormatText(var_69_13.content)

				arg_66_1.text_.text = var_69_14

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_16 = 19 <= 0 and var_69_12 or var_69_12 * (utf8.len(var_69_14) / 19)

				if (19 <= 0 and var_69_12 or var_69_12 * (utf8.len(var_69_14) / 19)) > 0 and var_69_12 < var_69_16 then
					arg_66_1.talkMaxDuration = var_69_16

					if var_69_16 + var_69_11 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_11
					end
				end

				arg_66_1.text_.text = var_69_14
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151016", "story_v_out_323151.awb") ~= 0 then
					local var_69_17 = manager.audio:GetVoiceLength("story_v_out_323151", "323151016", "story_v_out_323151.awb") / 1000

					if var_69_17 + var_69_11 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_17 + var_69_11
					end

					if var_69_13.prefab_name ~= "" and arg_66_1.actors_[var_69_13.prefab_name] ~= nil then
						local var_69_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_13.prefab_name].transform, "story_v_out_323151", "323151016", "story_v_out_323151.awb")

						arg_66_1:RecordAudio("323151016", var_69_18)
						arg_66_1:RecordAudio("323151016", var_69_18)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_323151", "323151016", "story_v_out_323151.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_323151", "323151016", "story_v_out_323151.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_19 = math.max(var_69_12, arg_66_1.talkMaxDuration)

			if var_69_11 <= arg_66_1.time_ and arg_66_1.time_ < var_69_11 + var_69_19 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_11) / var_69_19

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_11 + var_69_19 and arg_66_1.time_ < var_69_11 + var_69_19 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play323151017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 323151017
		arg_72_1.duration_ = 4.53

		local var_72_0 = {
			zh = 4.533,
			ja = 3.966
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
				arg_72_0:Play323151018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.325

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(323151017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 13 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 13)

				if (13 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 13)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151017", "story_v_out_323151.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151017", "story_v_out_323151.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_323151", "323151017", "story_v_out_323151.awb")

						arg_72_1:RecordAudio("323151017", var_75_6)
						arg_72_1:RecordAudio("323151017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_323151", "323151017", "story_v_out_323151.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_323151", "323151017", "story_v_out_323151.awb")
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
	Play323151018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 323151018
		arg_76_1.duration_ = 3.93

		local var_76_0 = {
			zh = 1.6,
			ja = 3.933
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
				arg_76_0:Play323151019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = arg_76_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) then
				if arg_76_1.var_.characterEffect1059ui_story and not isNil(arg_76_1.actors_["1059ui_story"]) then
					arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story then
				arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1456].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(323151018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 8 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 8)

				if (8 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 8)) > 0 and var_79_2 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151018", "story_v_out_323151.awb") ~= 0 then
					local var_79_7 = manager.audio:GetVoiceLength("story_v_out_323151", "323151018", "story_v_out_323151.awb") / 1000

					if var_79_7 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_1
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_323151", "323151018", "story_v_out_323151.awb")

						arg_76_1:RecordAudio("323151018", var_79_8)
						arg_76_1:RecordAudio("323151018", var_79_8)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_323151", "323151018", "story_v_out_323151.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_323151", "323151018", "story_v_out_323151.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_9 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_9 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_9

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_9 and arg_76_1.time_ < var_79_1 + var_79_9 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play323151019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 323151019
		arg_80_1.duration_ = 2.13

		local var_80_0 = {
			zh = 1.6,
			ja = 2.133
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
				arg_80_0:Play323151020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.125

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:GetWordFromCfg(323151019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 5 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 5)

				if (5 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 5)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151019", "story_v_out_323151.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151019", "story_v_out_323151.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_323151", "323151019", "story_v_out_323151.awb")

						arg_80_1:RecordAudio("323151019", var_83_6)
						arg_80_1:RecordAudio("323151019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_323151", "323151019", "story_v_out_323151.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_323151", "323151019", "story_v_out_323151.awb")
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
	Play323151020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 323151020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play323151021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1059ui_story"]) and arg_84_1.var_.characterEffect1059ui_story == nil then
				arg_84_1.var_.characterEffect1059ui_story = arg_84_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1059ui_story"]) then
				if arg_84_1.var_.characterEffect1059ui_story and not isNil(arg_84_1.actors_["1059ui_story"]) then
					arg_84_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1059ui_story"]) and arg_84_1.var_.characterEffect1059ui_story then
				arg_84_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.866666666666667 < arg_84_1.time_ and arg_84_1.time_ <= 0.866666666666667 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_teacup01", "")
			end

			local var_87_2 = 0
			local var_87_3 = 1.525

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(323151020).content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 61 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 61)

				if (61 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 61)) > 0 and var_87_3 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_7 and arg_84_1.time_ < var_87_2 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play323151021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 323151021
		arg_88_1.duration_ = 10.67

		local var_88_0 = {
			zh = 10.666,
			ja = 9.866
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
				arg_88_0:Play323151022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.025

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:GetWordFromCfg(323151021)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 41 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 41)

				if (41 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 41)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151021", "story_v_out_323151.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151021", "story_v_out_323151.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_323151", "323151021", "story_v_out_323151.awb")

						arg_88_1:RecordAudio("323151021", var_91_6)
						arg_88_1:RecordAudio("323151021", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_323151", "323151021", "story_v_out_323151.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_323151", "323151021", "story_v_out_323151.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play323151022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 323151022
		arg_92_1.duration_ = 11.23

		local var_92_0 = {
			zh = 8.333,
			ja = 11.233
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
				arg_92_0:Play323151023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.825

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(323151022)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 33 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 33)

				if (33 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 33)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151022", "story_v_out_323151.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151022", "story_v_out_323151.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_323151", "323151022", "story_v_out_323151.awb")

						arg_92_1:RecordAudio("323151022", var_95_6)
						arg_92_1:RecordAudio("323151022", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_323151", "323151022", "story_v_out_323151.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_323151", "323151022", "story_v_out_323151.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play323151023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 323151023
		arg_96_1.duration_ = 2.43

		local var_96_0 = {
			zh = 2.433,
			ja = 1.5
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
				arg_96_0:Play323151024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.275

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1456].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:GetWordFromCfg(323151023)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 11 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 11)

				if (11 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 11)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151023", "story_v_out_323151.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151023", "story_v_out_323151.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_323151", "323151023", "story_v_out_323151.awb")

						arg_96_1:RecordAudio("323151023", var_99_6)
						arg_96_1:RecordAudio("323151023", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_323151", "323151023", "story_v_out_323151.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_323151", "323151023", "story_v_out_323151.awb")
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
	Play323151024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 323151024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play323151025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0.125 < arg_100_1.time_ and arg_100_1.time_ <= 0.125 + arg_103_0 then
				arg_100_1:AudioAction("play", "effect", "se_story_140", "se_story_140_catch", "")
			end

			local var_103_1 = 0
			local var_103_2 = 1.125

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(323151024).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 45 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 45)

				if (45 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 45)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play323151025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 323151025
		arg_104_1.duration_ = 5.67

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play323151026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.allBtn_.enabled = false
			end

			if arg_104_1.time_ >= 0 + 1 and arg_104_1.time_ < 0 + 1 + arg_107_0 then
				arg_104_1.allBtn_.enabled = true
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_0 = 0.666666666666667
			local var_107_1 = 1.725

			if 0.666666666666667 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_2 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_2:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(323151025).content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 69 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 69)

				if (69 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 69)) > 0 and var_107_1 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5
					var_107_0 = var_107_0 + 0.3

					if var_107_5 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_6 = var_107_0 + 0.3
			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 + 0.3 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_7 and arg_104_1.time_ < var_107_6 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 10,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play323151026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 323151026
		arg_110_1.duration_ = 10.37

		local var_110_0 = {
			zh = 10.366,
			ja = 9.3
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
				arg_110_0:Play323151027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.95

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:GetWordFromCfg(323151026)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 38 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 38)

				if (38 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 38)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151026", "story_v_out_323151.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151026", "story_v_out_323151.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_323151", "323151026", "story_v_out_323151.awb")

						arg_110_1:RecordAudio("323151026", var_113_6)
						arg_110_1:RecordAudio("323151026", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_323151", "323151026", "story_v_out_323151.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_323151", "323151026", "story_v_out_323151.awb")
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
	Play323151027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 323151027
		arg_114_1.duration_ = 13.3

		local var_114_0 = {
			zh = 12.266,
			ja = 13.3
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
				arg_114_0:Play323151028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.925

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:GetWordFromCfg(323151027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 37 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 37)

				if (37 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 37)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151027", "story_v_out_323151.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151027", "story_v_out_323151.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_323151", "323151027", "story_v_out_323151.awb")

						arg_114_1:RecordAudio("323151027", var_117_6)
						arg_114_1:RecordAudio("323151027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_323151", "323151027", "story_v_out_323151.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_323151", "323151027", "story_v_out_323151.awb")
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
	Play323151028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 323151028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play323151029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 1.7

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

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(323151028).content)

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
	Play323151029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 323151029
		arg_122_1.duration_ = 9.9

		local var_122_0 = {
			zh = 8.766,
			ja = 9.9
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
				arg_122_0:Play323151030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.975

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_1 = arg_122_1:GetWordFromCfg(323151029)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 39 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 39)

				if (39 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 39)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151029", "story_v_out_323151.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151029", "story_v_out_323151.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_323151", "323151029", "story_v_out_323151.awb")

						arg_122_1:RecordAudio("323151029", var_125_6)
						arg_122_1:RecordAudio("323151029", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_323151", "323151029", "story_v_out_323151.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_323151", "323151029", "story_v_out_323151.awb")
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
	Play323151030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 323151030
		arg_126_1.duration_ = 13.6

		local var_126_0 = {
			zh = 7.133,
			ja = 13.6
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
				arg_126_0:Play323151031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_129_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_126_1.stage_.transform)

				var_129_0.name = "1071ui_story"
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1071ui_story"] = var_129_0

				local var_129_1 = var_129_0:GetComponentInChildren(typeof(CharacterEffect))

				var_129_1.enabled = true

				local var_129_2 = GameObjectTools.GetOrAddComponent(var_129_0, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_1.transform, false)

				arg_126_1.var_["1071ui_story" .. "Animator"] = var_129_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_126_1.var_["1071ui_story" .. "LipSync"] = var_129_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_129_3 = arg_126_1.actors_["1071ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1071ui_story = var_129_3.localPosition
			end

			local var_129_4 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				var_129_3.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_126_1.time_ - 0) / var_129_4)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				var_129_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			local var_129_5 = arg_126_1.actors_["1071ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1071ui_story == nil then
				arg_126_1.var_.characterEffect1071ui_story = var_129_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 and not isNil(var_129_5) then
				if arg_126_1.var_.characterEffect1071ui_story and not isNil(var_129_5) then
					arg_126_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1071ui_story then
				arg_126_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_129_8 = 0
			local var_129_9 = 0.6

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(323151030)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 24 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 24)

				if (24 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 24)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151030", "story_v_out_323151.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_323151", "323151030", "story_v_out_323151.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_323151", "323151030", "story_v_out_323151.awb")

						arg_126_1:RecordAudio("323151030", var_129_15)
						arg_126_1:RecordAudio("323151030", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_323151", "323151030", "story_v_out_323151.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_323151", "323151030", "story_v_out_323151.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play323151031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 323151031
		arg_130_1.duration_ = 16.87

		local var_130_0 = {
			zh = 10.966,
			ja = 16.866
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
				arg_130_0:Play323151032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1059ui_story"]) and arg_130_1.var_.characterEffect1059ui_story == nil then
				arg_130_1.var_.characterEffect1059ui_story = arg_130_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1059ui_story"]) then
				if arg_130_1.var_.characterEffect1059ui_story and not isNil(arg_130_1.actors_["1059ui_story"]) then
					arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1059ui_story"]) and arg_130_1.var_.characterEffect1059ui_story then
				arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_133_2 = arg_130_1.actors_["1071ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1071ui_story == nil then
				arg_130_1.var_.characterEffect1071ui_story = var_133_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_3 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 and not isNil(var_133_2) then
				if arg_130_1.var_.characterEffect1071ui_story and not isNil(var_133_2) then
					arg_130_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_3)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1071ui_story then
				arg_130_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_133_4 = 0
			local var_133_5 = 1.1

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_6 = arg_130_1:GetWordFromCfg(323151031)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 44 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 44)

				if (44 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 44)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151031", "story_v_out_323151.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_out_323151", "323151031", "story_v_out_323151.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_out_323151", "323151031", "story_v_out_323151.awb")

						arg_130_1:RecordAudio("323151031", var_133_11)
						arg_130_1:RecordAudio("323151031", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_323151", "323151031", "story_v_out_323151.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_323151", "323151031", "story_v_out_323151.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play323151032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 323151032
		arg_134_1.duration_ = 6.4

		local var_134_0 = {
			zh = 5.1,
			ja = 6.4
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
				arg_134_0:Play323151033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1071ui_story = arg_134_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1071ui_story"].transform.position).z)
				arg_134_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1071ui_story"].transform.localEulerAngles = arg_134_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1071ui_story"].transform.position).z)
				arg_134_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1071ui_story"].transform.localEulerAngles = arg_134_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_137_1 = "1069ui_story"

			if arg_134_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_137_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_134_1.stage_.transform)

				var_137_2.name = var_137_1
				var_137_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.actors_[var_137_1] = var_137_2

				local var_137_3 = var_137_2:GetComponentInChildren(typeof(CharacterEffect))

				var_137_3.enabled = true

				local var_137_4 = GameObjectTools.GetOrAddComponent(var_137_2, typeof(DynamicBoneHelper))

				if var_137_4 then
					var_137_4:EnableDynamicBone(false)
				end

				arg_134_1:ShowWeapon(var_137_3.transform, false)

				arg_134_1.var_[var_137_1 .. "Animator"] = var_137_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_134_1.var_[var_137_1 .. "Animator"].applyRootMotion = true
				arg_134_1.var_[var_137_1 .. "LipSync"] = var_137_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_137_5 = arg_134_1.actors_["1069ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1069ui_story = var_137_5.localPosition
			end

			local var_137_6 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_6 then
				var_137_5.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_134_1.time_ - 0) / var_137_6)
				var_137_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_5.position).x, (manager.ui.mainCamera.transform.position - var_137_5.position).y, (manager.ui.mainCamera.transform.position - var_137_5.position).z)
				var_137_5.localEulerAngles.z = 0
				var_137_5.localEulerAngles.x = 0
				var_137_5.localEulerAngles = var_137_5.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_6 and arg_134_1.time_ < 0 + var_137_6 + arg_137_0 then
				var_137_5.localPosition = Vector3.New(0, -1, -6)
				var_137_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_5.position).x, (manager.ui.mainCamera.transform.position - var_137_5.position).y, (manager.ui.mainCamera.transform.position - var_137_5.position).z)
				var_137_5.localEulerAngles.z = 0
				var_137_5.localEulerAngles.x = 0
				var_137_5.localEulerAngles = var_137_5.localEulerAngles
			end

			local var_137_7 = arg_134_1.actors_["1069ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_7) and arg_134_1.var_.characterEffect1069ui_story == nil then
				arg_134_1.var_.characterEffect1069ui_story = var_137_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_8 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_8 and not isNil(var_137_7) then
				if arg_134_1.var_.characterEffect1069ui_story and not isNil(var_137_7) then
					arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_8 and arg_134_1.time_ < 0 + var_137_8 + arg_137_0 and not isNil(var_137_7) and arg_134_1.var_.characterEffect1069ui_story then
				arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_137_10 = arg_134_1.actors_["1059ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_10) and arg_134_1.var_.characterEffect1059ui_story == nil then
				arg_134_1.var_.characterEffect1059ui_story = var_137_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_11 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_11 and not isNil(var_137_10) then
				if arg_134_1.var_.characterEffect1059ui_story and not isNil(var_137_10) then
					arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_11)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_11 and arg_134_1.time_ < 0 + var_137_11 + arg_137_0 and not isNil(var_137_10) and arg_134_1.var_.characterEffect1059ui_story then
				arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_12 = 0
			local var_137_13 = 0.7

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_14 = arg_134_1:GetWordFromCfg(323151032)
				local var_137_15 = arg_134_1:FormatText(var_137_14.content)

				arg_134_1.text_.text = var_137_15

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_17 = 28 <= 0 and var_137_13 or var_137_13 * (utf8.len(var_137_15) / 28)

				if (28 <= 0 and var_137_13 or var_137_13 * (utf8.len(var_137_15) / 28)) > 0 and var_137_13 < var_137_17 then
					arg_134_1.talkMaxDuration = var_137_17

					if var_137_17 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_17 + var_137_12
					end
				end

				arg_134_1.text_.text = var_137_15
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151032", "story_v_out_323151.awb") ~= 0 then
					local var_137_18 = manager.audio:GetVoiceLength("story_v_out_323151", "323151032", "story_v_out_323151.awb") / 1000

					if var_137_18 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_18 + var_137_12
					end

					if var_137_14.prefab_name ~= "" and arg_134_1.actors_[var_137_14.prefab_name] ~= nil then
						local var_137_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_14.prefab_name].transform, "story_v_out_323151", "323151032", "story_v_out_323151.awb")

						arg_134_1:RecordAudio("323151032", var_137_19)
						arg_134_1:RecordAudio("323151032", var_137_19)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_323151", "323151032", "story_v_out_323151.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_323151", "323151032", "story_v_out_323151.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_20 = math.max(var_137_13, arg_134_1.talkMaxDuration)

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_20 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_12) / var_137_20

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_12 + var_137_20 and arg_134_1.time_ < var_137_12 + var_137_20 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play323151033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 323151033
		arg_138_1.duration_ = 7.27

		local var_138_0 = {
			zh = 7.266,
			ja = 5.2
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
				arg_138_0:Play323151034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1069ui_story"]) and arg_138_1.var_.characterEffect1069ui_story == nil then
				arg_138_1.var_.characterEffect1069ui_story = arg_138_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1069ui_story"]) then
				if arg_138_1.var_.characterEffect1069ui_story and not isNil(arg_138_1.actors_["1069ui_story"]) then
					arg_138_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1069ui_story"]) and arg_138_1.var_.characterEffect1069ui_story then
				arg_138_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.675

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(323151033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 27 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 27)

				if (27 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 27)) > 0 and var_141_2 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151033", "story_v_out_323151.awb") ~= 0 then
					local var_141_7 = manager.audio:GetVoiceLength("story_v_out_323151", "323151033", "story_v_out_323151.awb") / 1000

					if var_141_7 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_1
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_323151", "323151033", "story_v_out_323151.awb")

						arg_138_1:RecordAudio("323151033", var_141_8)
						arg_138_1:RecordAudio("323151033", var_141_8)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_323151", "323151033", "story_v_out_323151.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_323151", "323151033", "story_v_out_323151.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_9 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_9 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_9

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_9 and arg_138_1.time_ < var_141_1 + var_141_9 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play323151034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 323151034
		arg_142_1.duration_ = 4.73

		local var_142_0 = {
			zh = 2.266,
			ja = 4.733
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
				arg_142_0:Play323151035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1069ui_story"]) and arg_142_1.var_.characterEffect1069ui_story == nil then
				arg_142_1.var_.characterEffect1069ui_story = arg_142_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1069ui_story"]) then
				if arg_142_1.var_.characterEffect1069ui_story and not isNil(arg_142_1.actors_["1069ui_story"]) then
					arg_142_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1069ui_story"]) and arg_142_1.var_.characterEffect1069ui_story then
				arg_142_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_2")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_145_2 = 0
			local var_145_3 = 0.35

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(323151034)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 14 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 14)

				if (14 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 14)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151034", "story_v_out_323151.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_323151", "323151034", "story_v_out_323151.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_323151", "323151034", "story_v_out_323151.awb")

						arg_142_1:RecordAudio("323151034", var_145_9)
						arg_142_1:RecordAudio("323151034", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_323151", "323151034", "story_v_out_323151.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_323151", "323151034", "story_v_out_323151.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_10 and arg_142_1.time_ < var_145_2 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play323151035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 323151035
		arg_146_1.duration_ = 2

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play323151036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1071ui_story = arg_146_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1071ui_story"].transform.position).z)
				arg_146_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1071ui_story"].transform.localEulerAngles = arg_146_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_146_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1071ui_story"].transform.position).z)
				arg_146_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1071ui_story"].transform.localEulerAngles = arg_146_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1069ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1069ui_story = var_149_1.localPosition
			end

			local var_149_2 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 then
				var_149_1.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_146_1.time_ - 0) / var_149_2)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 then
				var_149_1.localPosition = Vector3.New(0.7, -1, -6)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			local var_149_3 = arg_146_1.actors_["1071ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect1071ui_story == nil then
				arg_146_1.var_.characterEffect1071ui_story = var_149_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_4 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 and not isNil(var_149_3) then
				if arg_146_1.var_.characterEffect1071ui_story and not isNil(var_149_3) then
					arg_146_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect1071ui_story then
				arg_146_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_149_6 = arg_146_1.actors_["1069ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1069ui_story == nil then
				arg_146_1.var_.characterEffect1069ui_story = var_149_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_7 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 and not isNil(var_149_6) then
				if arg_146_1.var_.characterEffect1069ui_story and not isNil(var_149_6) then
					arg_146_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_7)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1069ui_story then
				arg_146_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_149_8 = 0
			local var_149_9 = 0.175

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_10 = arg_146_1:GetWordFromCfg(323151035)
				local var_149_11 = arg_146_1:FormatText(var_149_10.content)

				arg_146_1.text_.text = var_149_11

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_13 = 7 <= 0 and var_149_9 or var_149_9 * (utf8.len(var_149_11) / 7)

				if (7 <= 0 and var_149_9 or var_149_9 * (utf8.len(var_149_11) / 7)) > 0 and var_149_9 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_8
					end
				end

				arg_146_1.text_.text = var_149_11
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151035", "story_v_out_323151.awb") ~= 0 then
					local var_149_14 = manager.audio:GetVoiceLength("story_v_out_323151", "323151035", "story_v_out_323151.awb") / 1000

					if var_149_14 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_8
					end

					if var_149_10.prefab_name ~= "" and arg_146_1.actors_[var_149_10.prefab_name] ~= nil then
						local var_149_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_10.prefab_name].transform, "story_v_out_323151", "323151035", "story_v_out_323151.awb")

						arg_146_1:RecordAudio("323151035", var_149_15)
						arg_146_1:RecordAudio("323151035", var_149_15)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_323151", "323151035", "story_v_out_323151.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_323151", "323151035", "story_v_out_323151.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_9, arg_146_1.talkMaxDuration)

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_8) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_8 + var_149_16 and arg_146_1.time_ < var_149_8 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play323151036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 323151036
		arg_150_1.duration_ = 10.4

		local var_150_0 = {
			zh = 9.466,
			ja = 10.4
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
				arg_150_0:Play323151037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.825

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(323151036)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 33 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 33)

				if (33 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 33)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151036", "story_v_out_323151.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151036", "story_v_out_323151.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_323151", "323151036", "story_v_out_323151.awb")

						arg_150_1:RecordAudio("323151036", var_153_6)
						arg_150_1:RecordAudio("323151036", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_323151", "323151036", "story_v_out_323151.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_323151", "323151036", "story_v_out_323151.awb")
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
	Play323151037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 323151037
		arg_154_1.duration_ = 2.47

		local var_154_0 = {
			zh = 1.7,
			ja = 2.466
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
				arg_154_0:Play323151038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1059ui_story"]) and arg_154_1.var_.characterEffect1059ui_story == nil then
				arg_154_1.var_.characterEffect1059ui_story = arg_154_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1059ui_story"]) then
				if arg_154_1.var_.characterEffect1059ui_story and not isNil(arg_154_1.actors_["1059ui_story"]) then
					arg_154_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1059ui_story"]) and arg_154_1.var_.characterEffect1059ui_story then
				arg_154_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_157_2 = arg_154_1.actors_["1071ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1071ui_story == nil then
				arg_154_1.var_.characterEffect1071ui_story = var_157_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_3 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.characterEffect1071ui_story and not isNil(var_157_2) then
					arg_154_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_3)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1071ui_story then
				arg_154_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_157_4 = 0
			local var_157_5 = 0.125

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_6 = arg_154_1:GetWordFromCfg(323151037)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 5 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 5)

				if (5 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 5)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151037", "story_v_out_323151.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_out_323151", "323151037", "story_v_out_323151.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_out_323151", "323151037", "story_v_out_323151.awb")

						arg_154_1:RecordAudio("323151037", var_157_11)
						arg_154_1:RecordAudio("323151037", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_323151", "323151037", "story_v_out_323151.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_323151", "323151037", "story_v_out_323151.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play323151038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 323151038
		arg_158_1.duration_ = 2.2

		local var_158_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_158_0:Play323151039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1069ui_story = arg_158_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).z)
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles = arg_158_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_158_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).z)
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles = arg_158_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1069ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1069ui_story == nil then
				arg_158_1.var_.characterEffect1069ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect1069ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1069ui_story then
				arg_158_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_161_4 = arg_158_1.actors_["1071ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1071ui_story = var_161_4.localPosition
			end

			local var_161_5 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_5 then
				var_161_4.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_158_1.time_ - 0) / var_161_5)
				var_161_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_4.position).x, (manager.ui.mainCamera.transform.position - var_161_4.position).y, (manager.ui.mainCamera.transform.position - var_161_4.position).z)
				var_161_4.localEulerAngles.z = 0
				var_161_4.localEulerAngles.x = 0
				var_161_4.localEulerAngles = var_161_4.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_5 and arg_158_1.time_ < 0 + var_161_5 + arg_161_0 then
				var_161_4.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_161_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_4.position).x, (manager.ui.mainCamera.transform.position - var_161_4.position).y, (manager.ui.mainCamera.transform.position - var_161_4.position).z)
				var_161_4.localEulerAngles.z = 0
				var_161_4.localEulerAngles.x = 0
				var_161_4.localEulerAngles = var_161_4.localEulerAngles
			end

			local var_161_6 = 0
			local var_161_7 = 0.225

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_8 = arg_158_1:GetWordFromCfg(323151038)
				local var_161_9 = arg_158_1:FormatText(var_161_8.content)

				arg_158_1.text_.text = var_161_9

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 9 <= 0 and var_161_7 or var_161_7 * (utf8.len(var_161_9) / 9)

				if (9 <= 0 and var_161_7 or var_161_7 * (utf8.len(var_161_9) / 9)) > 0 and var_161_7 < var_161_11 then
					arg_158_1.talkMaxDuration = var_161_11

					if var_161_11 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_11 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_9
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151038", "story_v_out_323151.awb") ~= 0 then
					local var_161_12 = manager.audio:GetVoiceLength("story_v_out_323151", "323151038", "story_v_out_323151.awb") / 1000

					if var_161_12 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_6
					end

					if var_161_8.prefab_name ~= "" and arg_158_1.actors_[var_161_8.prefab_name] ~= nil then
						local var_161_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_8.prefab_name].transform, "story_v_out_323151", "323151038", "story_v_out_323151.awb")

						arg_158_1:RecordAudio("323151038", var_161_13)
						arg_158_1:RecordAudio("323151038", var_161_13)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_323151", "323151038", "story_v_out_323151.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_323151", "323151038", "story_v_out_323151.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play323151039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 323151039
		arg_162_1.duration_ = 8.8

		local var_162_0 = {
			zh = 7.033,
			ja = 8.8
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
				arg_162_0:Play323151040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1069ui_story"]) and arg_162_1.var_.characterEffect1069ui_story == nil then
				arg_162_1.var_.characterEffect1069ui_story = arg_162_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1069ui_story"]) then
				if arg_162_1.var_.characterEffect1069ui_story and not isNil(arg_162_1.actors_["1069ui_story"]) then
					arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1069ui_story"]) and arg_162_1.var_.characterEffect1069ui_story then
				arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.875

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(323151039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 35 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 35)

				if (35 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 35)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151039", "story_v_out_323151.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_323151", "323151039", "story_v_out_323151.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_323151", "323151039", "story_v_out_323151.awb")

						arg_162_1:RecordAudio("323151039", var_165_8)
						arg_162_1:RecordAudio("323151039", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_323151", "323151039", "story_v_out_323151.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_323151", "323151039", "story_v_out_323151.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play323151040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 323151040
		arg_166_1.duration_ = 6.3

		local var_166_0 = {
			zh = 5.8,
			ja = 6.3
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
				arg_166_0:Play323151041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1071ui_story"]) and arg_166_1.var_.characterEffect1071ui_story == nil then
				arg_166_1.var_.characterEffect1071ui_story = arg_166_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1071ui_story"]) then
				if arg_166_1.var_.characterEffect1071ui_story and not isNil(arg_166_1.actors_["1071ui_story"]) then
					arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1071ui_story"]) and arg_166_1.var_.characterEffect1071ui_story then
				arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_169_2 = 0
			local var_169_3 = 0.525

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_4 = arg_166_1:GetWordFromCfg(323151040)
				local var_169_5 = arg_166_1:FormatText(var_169_4.content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 21 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 21)

				if (21 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 21)) > 0 and var_169_3 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151040", "story_v_out_323151.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_323151", "323151040", "story_v_out_323151.awb") / 1000

					if var_169_8 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_2
					end

					if var_169_4.prefab_name ~= "" and arg_166_1.actors_[var_169_4.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_4.prefab_name].transform, "story_v_out_323151", "323151040", "story_v_out_323151.awb")

						arg_166_1:RecordAudio("323151040", var_169_9)
						arg_166_1:RecordAudio("323151040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_323151", "323151040", "story_v_out_323151.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_323151", "323151040", "story_v_out_323151.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_10 and arg_166_1.time_ < var_169_2 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play323151041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 323151041
		arg_170_1.duration_ = 6.63

		local var_170_0 = {
			zh = 4.6,
			ja = 6.633
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
				arg_170_0:Play323151042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1059ui_story"]) and arg_170_1.var_.characterEffect1059ui_story == nil then
				arg_170_1.var_.characterEffect1059ui_story = arg_170_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1059ui_story"]) then
				if arg_170_1.var_.characterEffect1059ui_story and not isNil(arg_170_1.actors_["1059ui_story"]) then
					arg_170_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1059ui_story"]) and arg_170_1.var_.characterEffect1059ui_story then
				arg_170_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_173_2 = arg_170_1.actors_["1071ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1071ui_story == nil then
				arg_170_1.var_.characterEffect1071ui_story = var_173_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_3 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.characterEffect1071ui_story and not isNil(var_173_2) then
					arg_170_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_3)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1071ui_story then
				arg_170_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_173_4 = 0
			local var_173_5 = 0.425

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_6 = arg_170_1:GetWordFromCfg(323151041)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 17 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 17)

				if (17 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 17)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151041", "story_v_out_323151.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_323151", "323151041", "story_v_out_323151.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_323151", "323151041", "story_v_out_323151.awb")

						arg_170_1:RecordAudio("323151041", var_173_11)
						arg_170_1:RecordAudio("323151041", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_323151", "323151041", "story_v_out_323151.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_323151", "323151041", "story_v_out_323151.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_12 and arg_170_1.time_ < var_173_4 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play323151042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 323151042
		arg_174_1.duration_ = 15.9

		local var_174_0 = {
			zh = 10.733,
			ja = 15.9
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
				arg_174_0:Play323151043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.975

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:GetWordFromCfg(323151042)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 39 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 39)

				if (39 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 39)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151042", "story_v_out_323151.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151042", "story_v_out_323151.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_323151", "323151042", "story_v_out_323151.awb")

						arg_174_1:RecordAudio("323151042", var_177_6)
						arg_174_1:RecordAudio("323151042", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_323151", "323151042", "story_v_out_323151.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_323151", "323151042", "story_v_out_323151.awb")
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
	Play323151043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 323151043
		arg_178_1.duration_ = 3.33

		local var_178_0 = {
			zh = 1.999999999999,
			ja = 3.333
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
				arg_178_0:Play323151044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1069ui_story = arg_178_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).z)
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles = arg_178_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_178_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).z)
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles = arg_178_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1069ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1069ui_story == nil then
				arg_178_1.var_.characterEffect1069ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1069ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1069ui_story then
				arg_178_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_181_4 = arg_178_1.actors_["1059ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1059ui_story == nil then
				arg_178_1.var_.characterEffect1059ui_story = var_181_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_5 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_5 and not isNil(var_181_4) then
				if arg_178_1.var_.characterEffect1059ui_story and not isNil(var_181_4) then
					arg_178_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_5)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_5 and arg_178_1.time_ < 0 + var_181_5 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1059ui_story then
				arg_178_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_2")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_181_6 = 0
			local var_181_7 = 0.2

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(323151043)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 8 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 8)

				if (8 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 8)) > 0 and var_181_7 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151043", "story_v_out_323151.awb") ~= 0 then
					local var_181_12 = manager.audio:GetVoiceLength("story_v_out_323151", "323151043", "story_v_out_323151.awb") / 1000

					if var_181_12 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_6
					end

					if var_181_8.prefab_name ~= "" and arg_178_1.actors_[var_181_8.prefab_name] ~= nil then
						local var_181_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_8.prefab_name].transform, "story_v_out_323151", "323151043", "story_v_out_323151.awb")

						arg_178_1:RecordAudio("323151043", var_181_13)
						arg_178_1:RecordAudio("323151043", var_181_13)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_323151", "323151043", "story_v_out_323151.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_323151", "323151043", "story_v_out_323151.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_14 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_14 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_14

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_14 and arg_178_1.time_ < var_181_6 + var_181_14 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play323151044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 323151044
		arg_182_1.duration_ = 11.67

		local var_182_0 = {
			zh = 9.533,
			ja = 11.666
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
				arg_182_0:Play323151045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1059ui_story"]) and arg_182_1.var_.characterEffect1059ui_story == nil then
				arg_182_1.var_.characterEffect1059ui_story = arg_182_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1059ui_story"]) then
				if arg_182_1.var_.characterEffect1059ui_story and not isNil(arg_182_1.actors_["1059ui_story"]) then
					arg_182_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1059ui_story"]) and arg_182_1.var_.characterEffect1059ui_story then
				arg_182_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_185_2 = arg_182_1.actors_["1069ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.characterEffect1069ui_story == nil then
				arg_182_1.var_.characterEffect1069ui_story = var_185_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_3 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_3 and not isNil(var_185_2) then
				if arg_182_1.var_.characterEffect1069ui_story and not isNil(var_185_2) then
					arg_182_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_3)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_3 and arg_182_1.time_ < 0 + var_185_3 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.characterEffect1069ui_story then
				arg_182_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_185_4 = 0
			local var_185_5 = 0.9

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_6 = arg_182_1:GetWordFromCfg(323151044)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 36 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 36)

				if (36 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 36)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151044", "story_v_out_323151.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_323151", "323151044", "story_v_out_323151.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_323151", "323151044", "story_v_out_323151.awb")

						arg_182_1:RecordAudio("323151044", var_185_11)
						arg_182_1:RecordAudio("323151044", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_323151", "323151044", "story_v_out_323151.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_323151", "323151044", "story_v_out_323151.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play323151045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 323151045
		arg_186_1.duration_ = 4.93

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play323151046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1071ui_story"]) and arg_186_1.var_.characterEffect1071ui_story == nil then
				arg_186_1.var_.characterEffect1071ui_story = arg_186_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1071ui_story"]) then
				if arg_186_1.var_.characterEffect1071ui_story and not isNil(arg_186_1.actors_["1071ui_story"]) then
					arg_186_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1071ui_story"]) and arg_186_1.var_.characterEffect1071ui_story then
				arg_186_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_189_2 = 0
			local var_189_3 = 0.55

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:GetWordFromCfg(323151045)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 22 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 22)

				if (22 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 22)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151045", "story_v_out_323151.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_323151", "323151045", "story_v_out_323151.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_out_323151", "323151045", "story_v_out_323151.awb")

						arg_186_1:RecordAudio("323151045", var_189_9)
						arg_186_1:RecordAudio("323151045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_323151", "323151045", "story_v_out_323151.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_323151", "323151045", "story_v_out_323151.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_10 and arg_186_1.time_ < var_189_2 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play323151046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 323151046
		arg_190_1.duration_ = 5.4

		local var_190_0 = {
			zh = 2.5,
			ja = 5.4
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
				arg_190_0:Play323151047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1059ui_story"]) and arg_190_1.var_.characterEffect1059ui_story == nil then
				arg_190_1.var_.characterEffect1059ui_story = arg_190_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1059ui_story"]) then
				if arg_190_1.var_.characterEffect1059ui_story and not isNil(arg_190_1.actors_["1059ui_story"]) then
					arg_190_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1059ui_story"]) and arg_190_1.var_.characterEffect1059ui_story then
				arg_190_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_193_2 = arg_190_1.actors_["1071ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1071ui_story == nil then
				arg_190_1.var_.characterEffect1071ui_story = var_193_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_3 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_3 and not isNil(var_193_2) then
				if arg_190_1.var_.characterEffect1071ui_story and not isNil(var_193_2) then
					arg_190_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_3)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_3 and arg_190_1.time_ < 0 + var_193_3 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1071ui_story then
				arg_190_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_193_4 = 0
			local var_193_5 = 0.325

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_6 = arg_190_1:GetWordFromCfg(323151046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 13 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 13)

				if (13 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 13)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151046", "story_v_out_323151.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_323151", "323151046", "story_v_out_323151.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_323151", "323151046", "story_v_out_323151.awb")

						arg_190_1:RecordAudio("323151046", var_193_11)
						arg_190_1:RecordAudio("323151046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_323151", "323151046", "story_v_out_323151.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_323151", "323151046", "story_v_out_323151.awb")
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

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play323151047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 323151047
		arg_194_1.duration_ = 8.83

		local var_194_0 = {
			zh = 3.433,
			ja = 8.833
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
				arg_194_0:Play323151048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.35

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(323151047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 14 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 14)

				if (14 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 14)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151047", "story_v_out_323151.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151047", "story_v_out_323151.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_323151", "323151047", "story_v_out_323151.awb")

						arg_194_1:RecordAudio("323151047", var_197_6)
						arg_194_1:RecordAudio("323151047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_323151", "323151047", "story_v_out_323151.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_323151", "323151047", "story_v_out_323151.awb")
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
	Play323151048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 323151048
		arg_198_1.duration_ = 5.47

		local var_198_0 = {
			zh = 4.833,
			ja = 5.466
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
				arg_198_0:Play323151049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1071ui_story"]) and arg_198_1.var_.characterEffect1071ui_story == nil then
				arg_198_1.var_.characterEffect1071ui_story = arg_198_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1071ui_story"]) then
				if arg_198_1.var_.characterEffect1071ui_story and not isNil(arg_198_1.actors_["1071ui_story"]) then
					arg_198_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1071ui_story"]) and arg_198_1.var_.characterEffect1071ui_story then
				arg_198_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_201_2 = 0
			local var_201_3 = 0.475

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:GetWordFromCfg(323151048)
				local var_201_5 = arg_198_1:FormatText(var_201_4.content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 19 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 19)

				if (19 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 19)) > 0 and var_201_3 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151048", "story_v_out_323151.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_323151", "323151048", "story_v_out_323151.awb") / 1000

					if var_201_8 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_2
					end

					if var_201_4.prefab_name ~= "" and arg_198_1.actors_[var_201_4.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_4.prefab_name].transform, "story_v_out_323151", "323151048", "story_v_out_323151.awb")

						arg_198_1:RecordAudio("323151048", var_201_9)
						arg_198_1:RecordAudio("323151048", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_323151", "323151048", "story_v_out_323151.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_323151", "323151048", "story_v_out_323151.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_10 and arg_198_1.time_ < var_201_2 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play323151049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 323151049
		arg_202_1.duration_ = 2.63

		local var_202_0 = {
			zh = 2.1,
			ja = 2.633
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
				arg_202_0:Play323151050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) and arg_202_1.var_.characterEffect1071ui_story == nil then
				arg_202_1.var_.characterEffect1071ui_story = arg_202_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) then
				if arg_202_1.var_.characterEffect1071ui_story and not isNil(arg_202_1.actors_["1071ui_story"]) then
					arg_202_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) and arg_202_1.var_.characterEffect1071ui_story then
				arg_202_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.2

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(323151049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_6 = 8 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 8)

				if (8 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 8)) > 0 and var_205_2 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6

					if var_205_6 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151049", "story_v_out_323151.awb") ~= 0 then
					local var_205_7 = manager.audio:GetVoiceLength("story_v_out_323151", "323151049", "story_v_out_323151.awb") / 1000

					if var_205_7 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_1
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_323151", "323151049", "story_v_out_323151.awb")

						arg_202_1:RecordAudio("323151049", var_205_8)
						arg_202_1:RecordAudio("323151049", var_205_8)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_323151", "323151049", "story_v_out_323151.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_323151", "323151049", "story_v_out_323151.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_9 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_9 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_9

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_9 and arg_202_1.time_ < var_205_1 + var_205_9 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play323151050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 323151050
		arg_206_1.duration_ = 4.7

		local var_206_0 = {
			zh = 3.9,
			ja = 4.7
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
				arg_206_0:Play323151051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1069ui_story = arg_206_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1069ui_story"].transform.position).z)
				arg_206_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1069ui_story"].transform.localEulerAngles = arg_206_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_206_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1069ui_story"].transform.position).z)
				arg_206_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1069ui_story"].transform.localEulerAngles = arg_206_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1071ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1071ui_story = var_209_1.localPosition
			end

			local var_209_2 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 then
				var_209_1.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_206_1.time_ - 0) / var_209_2)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 then
				var_209_1.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			local var_209_3 = arg_206_1.actors_["1069ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect1069ui_story == nil then
				arg_206_1.var_.characterEffect1069ui_story = var_209_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_4 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 and not isNil(var_209_3) then
				if arg_206_1.var_.characterEffect1069ui_story and not isNil(var_209_3) then
					arg_206_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect1069ui_story then
				arg_206_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_209_6 = arg_206_1.actors_["1059ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_6) and arg_206_1.var_.characterEffect1059ui_story == nil then
				arg_206_1.var_.characterEffect1059ui_story = var_209_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_7 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 and not isNil(var_209_6) then
				if arg_206_1.var_.characterEffect1059ui_story and not isNil(var_209_6) then
					arg_206_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_7)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 and not isNil(var_209_6) and arg_206_1.var_.characterEffect1059ui_story then
				arg_206_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_209_8 = 0
			local var_209_9 = 0.45

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_10 = arg_206_1:GetWordFromCfg(323151050)
				local var_209_11 = arg_206_1:FormatText(var_209_10.content)

				arg_206_1.text_.text = var_209_11

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 18 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 18)

				if (18 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 18)) > 0 and var_209_9 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_11
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151050", "story_v_out_323151.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_323151", "323151050", "story_v_out_323151.awb") / 1000

					if var_209_14 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_8
					end

					if var_209_10.prefab_name ~= "" and arg_206_1.actors_[var_209_10.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_10.prefab_name].transform, "story_v_out_323151", "323151050", "story_v_out_323151.awb")

						arg_206_1:RecordAudio("323151050", var_209_15)
						arg_206_1:RecordAudio("323151050", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_323151", "323151050", "story_v_out_323151.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_323151", "323151050", "story_v_out_323151.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play323151051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 323151051
		arg_210_1.duration_ = 16.17

		local var_210_0 = {
			zh = 9.766,
			ja = 16.166
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
				arg_210_0:Play323151052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1059ui_story"]) and arg_210_1.var_.characterEffect1059ui_story == nil then
				arg_210_1.var_.characterEffect1059ui_story = arg_210_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1059ui_story"]) then
				if arg_210_1.var_.characterEffect1059ui_story and not isNil(arg_210_1.actors_["1059ui_story"]) then
					arg_210_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1059ui_story"]) and arg_210_1.var_.characterEffect1059ui_story then
				arg_210_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_213_2 = arg_210_1.actors_["1069ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1069ui_story == nil then
				arg_210_1.var_.characterEffect1069ui_story = var_213_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_3 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.characterEffect1069ui_story and not isNil(var_213_2) then
					arg_210_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_3)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1069ui_story then
				arg_210_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_213_4 = 0
			local var_213_5 = 1.1

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_6 = arg_210_1:GetWordFromCfg(323151051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 44 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 44)

				if (44 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 44)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151051", "story_v_out_323151.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_323151", "323151051", "story_v_out_323151.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_323151", "323151051", "story_v_out_323151.awb")

						arg_210_1:RecordAudio("323151051", var_213_11)
						arg_210_1:RecordAudio("323151051", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_323151", "323151051", "story_v_out_323151.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_323151", "323151051", "story_v_out_323151.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play323151052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 323151052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play323151053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1069ui_story = arg_214_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1069ui_story"].transform.position).z)
				arg_214_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1069ui_story"].transform.localEulerAngles = arg_214_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1069ui_story"].transform.position).z)
				arg_214_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1069ui_story"].transform.localEulerAngles = arg_214_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["1059ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1059ui_story == nil then
				arg_214_1.var_.characterEffect1059ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect1059ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_2)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1059ui_story then
				arg_214_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.166666666666667 < arg_214_1.time_ and arg_214_1.time_ <= 0.166666666666667 + arg_217_0 then
				arg_214_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			if 0.766666666666667 < arg_214_1.time_ and arg_214_1.time_ <= 0.766666666666667 + arg_217_0 then
				arg_214_1:AudioAction("play", "effect", "se_story_145", "se_story_145_footstep03", "")
			end

			local var_217_5 = arg_214_1.actors_["1071ui_story"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1071ui_story = var_217_5.localPosition
			end

			local var_217_6 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_6 then
				var_217_5.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_6)
				var_217_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_5.position).x, (manager.ui.mainCamera.transform.position - var_217_5.position).y, (manager.ui.mainCamera.transform.position - var_217_5.position).z)
				var_217_5.localEulerAngles.z = 0
				var_217_5.localEulerAngles.x = 0
				var_217_5.localEulerAngles = var_217_5.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_6 and arg_214_1.time_ < 0 + var_217_6 + arg_217_0 then
				var_217_5.localPosition = Vector3.New(0, 100, 0)
				var_217_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_5.position).x, (manager.ui.mainCamera.transform.position - var_217_5.position).y, (manager.ui.mainCamera.transform.position - var_217_5.position).z)
				var_217_5.localEulerAngles.z = 0
				var_217_5.localEulerAngles.x = 0
				var_217_5.localEulerAngles = var_217_5.localEulerAngles
			end

			local var_217_7 = 0
			local var_217_8 = 1.075

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_7 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_9 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(323151052).content)

				arg_214_1.text_.text = var_217_9

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 43 <= 0 and var_217_8 or var_217_8 * (utf8.len(var_217_9) / 43)

				if (43 <= 0 and var_217_8 or var_217_8 * (utf8.len(var_217_9) / 43)) > 0 and var_217_8 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_7 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_7
					end
				end

				arg_214_1.text_.text = var_217_9
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_8, arg_214_1.talkMaxDuration)

			if var_217_7 <= arg_214_1.time_ and arg_214_1.time_ < var_217_7 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_7) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_7 + var_217_12 and arg_214_1.time_ < var_217_7 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play323151053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 323151053
		arg_218_1.duration_ = 16.03

		local var_218_0 = {
			zh = 9.8,
			ja = 16.033
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
				arg_218_0:Play323151054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 1.025

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:GetWordFromCfg(323151053)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 41 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 41)

				if (41 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 41)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323151", "323151053", "story_v_out_323151.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_323151", "323151053", "story_v_out_323151.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_323151", "323151053", "story_v_out_323151.awb")

						arg_218_1:RecordAudio("323151053", var_221_6)
						arg_218_1:RecordAudio("323151053", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_323151", "323151053", "story_v_out_323151.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_323151", "323151053", "story_v_out_323151.awb")
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
	Play323151054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 323151054
		arg_222_1.duration_ = 6

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
			arg_222_1.auto_ = false
		end

		function arg_222_1.playNext_(arg_224_0)
			arg_222_1.onStoryFinished_()
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_9000

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1059ui_story = arg_222_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).z)
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles = arg_222_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).z)
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles = arg_222_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["1059ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1059ui_story == nil then
				arg_222_1.var_.characterEffect1059ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1059ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_2)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1059ui_story then
				arg_222_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				local var_225_3 = arg_222_1.var_.effect2323

				if not arg_222_1.var_.effect2323 then
					var_225_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_225_3.name = "2323"
					arg_222_1.var_.effect2323 = var_225_3
				else
					var_225_3.transform:SetParent(var_225_9000)
				end

				var_225_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_225_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_225_3.transform.localScale = Vector3.New(var_225_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_225_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_225_3.transform.localScale.z)
			end

			local var_225_5 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			if arg_222_1.time_ >= var_225_5 + 1.26666666666667 and arg_222_1.time_ < var_225_5 + 1.26666666666667 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			if 0.034000001847744 < arg_222_1.time_ and arg_222_1.time_ <= 0.034000001847744 + arg_225_0 then
				arg_222_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_beep", "")
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_7 = 1
			local var_225_8 = 0.85

			if 1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_7 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_9 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_9:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_10 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(323151054).content)

				arg_222_1.text_.text = var_225_10

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_12 = 34 <= 0 and var_225_8 or var_225_8 * (utf8.len(var_225_10) / 34)

				if (34 <= 0 and var_225_8 or var_225_8 * (utf8.len(var_225_10) / 34)) > 0 and var_225_8 < var_225_12 then
					arg_222_1.talkMaxDuration = var_225_12
					var_225_7 = var_225_7 + 0.3

					if var_225_12 + var_225_7 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_7
					end
				end

				arg_222_1.text_.text = var_225_10
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = var_225_7 + 0.3
			local var_225_14 = math.max(var_225_8, arg_222_1.talkMaxDuration)

			if var_225_7 + 0.3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_13 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_13) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_13 + var_225_14 and arg_222_1.time_ < var_225_13 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
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
	assets = {
		"TextureConfig/Background/ST2002"
	},
	voices = {
		"story_v_out_323151.awb"
	}
}
