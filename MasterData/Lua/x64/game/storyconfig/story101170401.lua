return {
	Play117041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117041001
		arg_1_1.duration_ = 13.57

		local var_1_0 = {
			zh = 13.566,
			ja = 8.966
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
				arg_1_0:Play117041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.TI0101 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "TI0101")
				var_4_0.name = "TI0101"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.TI0101 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.TI0101

				arg_1_1.bgs_.TI0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "TI0101" then
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

			local var_4_11 = 2
			local var_4_12 = 1.425

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:GetWordFromCfg(117041001)
				local var_4_15 = arg_1_1:FormatText(var_4_14.content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 57 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 57)

				if (57 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 57)) > 0 and var_4_12 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_11 = var_4_11 + 0.3

					if var_4_17 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041001", "story_v_out_117041.awb") ~= 0 then
					local var_4_18 = manager.audio:GetVoiceLength("story_v_out_117041", "117041001", "story_v_out_117041.awb") / 1000

					if var_4_18 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_11
					end

					if var_4_14.prefab_name ~= "" and arg_1_1.actors_[var_4_14.prefab_name] ~= nil then
						local var_4_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_14.prefab_name].transform, "story_v_out_117041", "117041001", "story_v_out_117041.awb")

						arg_1_1:RecordAudio("117041001", var_4_19)
						arg_1_1:RecordAudio("117041001", var_4_19)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_117041", "117041001", "story_v_out_117041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_117041", "117041001", "story_v_out_117041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_11 + 0.3
			local var_4_21 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
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
	Play117041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 117041002
		arg_8_1.duration_ = 13.03

		local var_8_0 = {
			zh = 13.033,
			ja = 9.133
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
				arg_8_0:Play117041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.625

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(117041002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 65 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 65)

				if (65 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 65)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041002", "story_v_out_117041.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041002", "story_v_out_117041.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_117041", "117041002", "story_v_out_117041.awb")

						arg_8_1:RecordAudio("117041002", var_11_6)
						arg_8_1:RecordAudio("117041002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_117041", "117041002", "story_v_out_117041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_117041", "117041002", "story_v_out_117041.awb")
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
	Play117041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 117041003
		arg_12_1.duration_ = 11.2

		local var_12_0 = {
			zh = 11.2,
			ja = 10.266
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
				arg_12_0:Play117041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:GetWordFromCfg(117041003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 53 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 53)

				if (53 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 53)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041003", "story_v_out_117041.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041003", "story_v_out_117041.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_117041", "117041003", "story_v_out_117041.awb")

						arg_12_1:RecordAudio("117041003", var_15_6)
						arg_12_1:RecordAudio("117041003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_117041", "117041003", "story_v_out_117041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_117041", "117041003", "story_v_out_117041.awb")
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
	Play117041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 117041004
		arg_16_1.duration_ = 9

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play117041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.bgs_.ST12 == nil then
				local var_19_0 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_19_0.name = "ST12"
				var_19_0.transform.parent = arg_16_1.stage_.transform
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_.ST12 = var_19_0
			end

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= 2 + arg_19_0 then
				local var_19_1 = arg_16_1.bgs_.ST12

				arg_16_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_2 = var_19_1:GetComponent("SpriteRenderer")

				if var_19_2 and var_19_2.sprite then
					local var_19_3 = 2 * (var_19_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_1.transform.localScale = Vector3.New(var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "ST12" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_4 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_5 = 2

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_5 then
				local var_19_6 = Color.New(0, 0, 0)

				var_19_6.a = Mathf.Lerp(0, 1, (arg_16_1.time_ - var_19_4) / var_19_5)
				arg_16_1.mask_.color = var_19_6
			end

			if arg_16_1.time_ >= var_19_4 + var_19_5 and arg_16_1.time_ < var_19_4 + var_19_5 + arg_19_0 then
				local var_19_7 = Color.New(0, 0, 0)

				var_19_7.a = 1
				arg_16_1.mask_.color = var_19_7
			end

			local var_19_8 = 2

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_9 = 2

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_9 then
				local var_19_10 = Color.New(0, 0, 0)

				var_19_10.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_8) / var_19_9)
				arg_16_1.mask_.color = var_19_10
			end

			if arg_16_1.time_ >= var_19_8 + var_19_9 and arg_16_1.time_ < var_19_8 + var_19_9 + arg_19_0 then
				local var_19_11 = Color.New(0, 0, 0)

				arg_16_1.mask_.enabled = false
				var_19_11.a = 0
				arg_16_1.mask_.color = var_19_11
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_19_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_14 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_14

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_14
						arg_16_1.bgmTxt2_.text = var_19_14
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 4 < arg_16_1.time_ and arg_16_1.time_ <= 4 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_19_17 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_17 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_17

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_17
						arg_16_1.bgmTxt2_.text = var_19_17
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_18 = 4
			local var_19_19 = 0.45

			if 4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_20 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_20:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_21 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(117041004).content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_23 = 18 <= 0 and var_19_19 or var_19_19 * (utf8.len(var_19_21) / 18)

				if (18 <= 0 and var_19_19 or var_19_19 * (utf8.len(var_19_21) / 18)) > 0 and var_19_19 < var_19_23 then
					arg_16_1.talkMaxDuration = var_19_23
					var_19_18 = var_19_18 + 0.3

					if var_19_23 + var_19_18 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_18
					end
				end

				arg_16_1.text_.text = var_19_21
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_24 = var_19_18 + 0.3
			local var_19_25 = math.max(var_19_19, arg_16_1.talkMaxDuration)

			if var_19_18 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_24 + var_19_25 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_24) / var_19_25

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_24 + var_19_25 and arg_16_1.time_ < var_19_24 + var_19_25 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play117041005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 117041005
		arg_24_1.duration_ = 4.9

		local var_24_0 = {
			zh = 4.9,
			ja = 4.333
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
				arg_24_0:Play117041006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1029"] == nil then
				local var_27_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1029")

				if not isNil(var_27_0) then
					local var_27_1 = Object.Instantiate(var_27_0, arg_24_1.canvasGo_.transform)

					var_27_1.transform:SetSiblingIndex(1)

					var_27_1.name = "1029"
					var_27_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_24_1.actors_["1029"] = var_27_1

					if arg_24_1.isInRecall_ then
						for iter_27_0, iter_27_1 in ipairs((var_27_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_27_1.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_27_2 = arg_24_1.actors_["1029"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1029 = var_27_2.localPosition
				var_27_2.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1029", 2)

				for iter_27_2 = 0, var_27_2.childCount - 1 do
					local var_27_3 = var_27_2:GetChild(iter_27_2)

					if var_27_3.name == "split_1" or not string.find(var_27_3.name, "split") then
						var_27_3.gameObject:SetActive(true)
					else
						var_27_3.gameObject:SetActive(false)
					end
				end
			end

			local var_27_4 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_2.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1029, Vector3.New(-390, -355, -140), (arg_24_1.time_ - 0) / var_27_4)
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_2.localPosition = Vector3.New(-390, -355, -140)
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				local var_27_5 = arg_24_1.actors_["1029"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_27_5 then
					arg_24_1.var_.alphaOldValue1029 = var_27_5.alpha
					arg_24_1.var_.characterEffect1029 = var_27_5
				end

				arg_24_1.var_.alphaOldValue1029 = 0
			end

			local var_27_6 = 0.333333333333333

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 then
				if arg_24_1.var_.characterEffect1029 then
					arg_24_1.var_.characterEffect1029.alpha = Mathf.Lerp(arg_24_1.var_.alphaOldValue1029, 1, (arg_24_1.time_ - 0) / var_27_6)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 and arg_24_1.var_.characterEffect1029 then
				arg_24_1.var_.characterEffect1029.alpha = 1
			end

			local var_27_7 = arg_24_1.actors_["1029"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.actorSpriteComps1029 == nil then
				arg_24_1.var_.actorSpriteComps1029 = var_27_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_8 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.actorSpriteComps1029 then
					for iter_27_3, iter_27_4 in pairs(arg_24_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_27_4 then
							if arg_24_1.isInRecall_ then
								iter_27_4.color = Color.New(Mathf.Lerp(iter_27_4.color.r, arg_24_1.hightColor1.r, (arg_24_1.time_ - 0) / var_27_8), Mathf.Lerp(iter_27_4.color.g, arg_24_1.hightColor1.g, (arg_24_1.time_ - 0) / var_27_8), (Mathf.Lerp(iter_27_4.color.b, arg_24_1.hightColor1.b, (arg_24_1.time_ - 0) / var_27_8)))
							else
								local var_27_9 = Mathf.Lerp(iter_27_4.color.r, 1, (arg_24_1.time_ - 0) / var_27_8)

								iter_27_4.color = Color.New(var_27_9, var_27_9, var_27_9)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.actorSpriteComps1029 then
				for iter_27_5, iter_27_6 in pairs(arg_24_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_27_6 then
						iter_27_6.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps1029 = nil
			end

			local var_27_10 = 0
			local var_27_11 = 0.625

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(117041005)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 25 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 25)

				if (25 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 25)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041005", "story_v_out_117041.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041005", "story_v_out_117041.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_117041", "117041005", "story_v_out_117041.awb")

						arg_24_1:RecordAudio("117041005", var_27_17)
						arg_24_1:RecordAudio("117041005", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_117041", "117041005", "story_v_out_117041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_117041", "117041005", "story_v_out_117041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_18 and arg_24_1.time_ < var_27_10 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play117041006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 117041006
		arg_28_1.duration_ = 9.4

		local var_28_0 = {
			zh = 3.933,
			ja = 9.4
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
				arg_28_0:Play117041007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1033"] == nil then
				local var_31_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_31_0) then
					local var_31_1 = Object.Instantiate(var_31_0, arg_28_1.canvasGo_.transform)

					var_31_1.transform:SetSiblingIndex(1)

					var_31_1.name = "1033"
					var_31_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_28_1.actors_["1033"] = var_31_1

					if arg_28_1.isInRecall_ then
						for iter_31_0, iter_31_1 in ipairs((var_31_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_31_1.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_31_2 = arg_28_1.actors_["1033"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1033 = var_31_2.localPosition
				var_31_2.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("1033", 4)

				for iter_31_2 = 0, var_31_2.childCount - 1 do
					local var_31_3 = var_31_2:GetChild(iter_31_2)

					if var_31_3.name == "split_6" or not string.find(var_31_3.name, "split") then
						var_31_3.gameObject:SetActive(true)
					else
						var_31_3.gameObject:SetActive(false)
					end
				end
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_2.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_28_1.time_ - 0) / var_31_4)
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_2.localPosition = Vector3.New(390, -420, 0)
			end

			local var_31_5 = arg_28_1.actors_["1029"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.actorSpriteComps1029 == nil then
				arg_28_1.var_.actorSpriteComps1029 = var_31_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_6 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.actorSpriteComps1029 then
					for iter_31_3, iter_31_4 in pairs(arg_28_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_31_4 then
							if arg_28_1.isInRecall_ then
								iter_31_4.color = Color.New(Mathf.Lerp(iter_31_4.color.r, arg_28_1.hightColor2.r, (arg_28_1.time_ - 0) / var_31_6), Mathf.Lerp(iter_31_4.color.g, arg_28_1.hightColor2.g, (arg_28_1.time_ - 0) / var_31_6), (Mathf.Lerp(iter_31_4.color.b, arg_28_1.hightColor2.b, (arg_28_1.time_ - 0) / var_31_6)))
							else
								local var_31_7 = Mathf.Lerp(iter_31_4.color.r, 0.5, (arg_28_1.time_ - 0) / var_31_6)

								iter_31_4.color = Color.New(var_31_7, var_31_7, var_31_7)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.actorSpriteComps1029 then
				for iter_31_5, iter_31_6 in pairs(arg_28_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_31_6 then
						iter_31_6.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_28_1.var_.actorSpriteComps1029 = nil
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				local var_31_8 = arg_28_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_31_8 then
					arg_28_1.var_.alphaOldValue1033 = var_31_8.alpha
					arg_28_1.var_.characterEffect1033 = var_31_8
				end

				arg_28_1.var_.alphaOldValue1033 = 0
			end

			local var_31_9 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				if arg_28_1.var_.characterEffect1033 then
					arg_28_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_28_1.var_.alphaOldValue1033, 1, (arg_28_1.time_ - 0) / var_31_9)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 and arg_28_1.var_.characterEffect1033 then
				arg_28_1.var_.characterEffect1033.alpha = 1
			end

			local var_31_10 = 0
			local var_31_11 = 0.45

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(117041006)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 18 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 18)

				if (18 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 18)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041006", "story_v_out_117041.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041006", "story_v_out_117041.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_117041", "117041006", "story_v_out_117041.awb")

						arg_28_1:RecordAudio("117041006", var_31_17)
						arg_28_1:RecordAudio("117041006", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_117041", "117041006", "story_v_out_117041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_117041", "117041006", "story_v_out_117041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play117041007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 117041007
		arg_32_1.duration_ = 2.83

		local var_32_0 = {
			zh = 1.233,
			ja = 2.833
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
				arg_32_0:Play117041008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1033"]) and arg_32_1.var_.actorSpriteComps1033 == nil then
				arg_32_1.var_.actorSpriteComps1033 = arg_32_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1033"]) then
				if arg_32_1.var_.actorSpriteComps1033 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								iter_35_1.color = Color.New(Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor2.r, (arg_32_1.time_ - 0) / var_35_0), Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor2.g, (arg_32_1.time_ - 0) / var_35_0), (Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor2.b, (arg_32_1.time_ - 0) / var_35_0)))
							else
								local var_35_1 = Mathf.Lerp(iter_35_1.color.r, 0.5, (arg_32_1.time_ - 0) / var_35_0)

								iter_35_1.color = Color.New(var_35_1, var_35_1, var_35_1)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1033"]) and arg_32_1.var_.actorSpriteComps1033 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps1033 = nil
			end

			local var_35_2 = arg_32_1.actors_["1029"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps1029 == nil then
				arg_32_1.var_.actorSpriteComps1029 = var_35_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.actorSpriteComps1029 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								iter_35_5.color = Color.New(Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor1.r, (arg_32_1.time_ - 0) / var_35_3), Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor1.g, (arg_32_1.time_ - 0) / var_35_3), (Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor1.b, (arg_32_1.time_ - 0) / var_35_3)))
							else
								local var_35_4 = Mathf.Lerp(iter_35_5.color.r, 1, (arg_32_1.time_ - 0) / var_35_3)

								iter_35_5.color = Color.New(var_35_4, var_35_4, var_35_4)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps1029 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_35_7 then
						iter_35_7.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps1029 = nil
			end

			local var_35_5 = 0
			local var_35_6 = 0.075

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_7 = arg_32_1:GetWordFromCfg(117041007)
				local var_35_8 = arg_32_1:FormatText(var_35_7.content)

				arg_32_1.text_.text = var_35_8

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_10 = 3 <= 0 and var_35_6 or var_35_6 * (utf8.len(var_35_8) / 3)

				if (3 <= 0 and var_35_6 or var_35_6 * (utf8.len(var_35_8) / 3)) > 0 and var_35_6 < var_35_10 then
					arg_32_1.talkMaxDuration = var_35_10

					if var_35_10 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_5
					end
				end

				arg_32_1.text_.text = var_35_8
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041007", "story_v_out_117041.awb") ~= 0 then
					local var_35_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041007", "story_v_out_117041.awb") / 1000

					if var_35_11 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_5
					end

					if var_35_7.prefab_name ~= "" and arg_32_1.actors_[var_35_7.prefab_name] ~= nil then
						local var_35_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_7.prefab_name].transform, "story_v_out_117041", "117041007", "story_v_out_117041.awb")

						arg_32_1:RecordAudio("117041007", var_35_12)
						arg_32_1:RecordAudio("117041007", var_35_12)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_117041", "117041007", "story_v_out_117041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_117041", "117041007", "story_v_out_117041.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_13 = math.max(var_35_6, arg_32_1.talkMaxDuration)

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_13 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_5) / var_35_13

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_5 + var_35_13 and arg_32_1.time_ < var_35_5 + var_35_13 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play117041008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 117041008
		arg_36_1.duration_ = 1.6

		local var_36_0 = {
			zh = 1.566,
			ja = 1.6
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
				arg_36_0:Play117041009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1033"]) and arg_36_1.var_.actorSpriteComps1033 == nil then
				arg_36_1.var_.actorSpriteComps1033 = arg_36_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1033"]) then
				if arg_36_1.var_.actorSpriteComps1033 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								iter_39_1.color = Color.New(Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, (arg_36_1.time_ - 0) / var_39_0), Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, (arg_36_1.time_ - 0) / var_39_0), (Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, (arg_36_1.time_ - 0) / var_39_0)))
							else
								local var_39_1 = Mathf.Lerp(iter_39_1.color.r, 1, (arg_36_1.time_ - 0) / var_39_0)

								iter_39_1.color = Color.New(var_39_1, var_39_1, var_39_1)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1033"]) and arg_36_1.var_.actorSpriteComps1033 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps1033 = nil
			end

			local var_39_2 = arg_36_1.actors_["1029"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps1029 == nil then
				arg_36_1.var_.actorSpriteComps1029 = var_39_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.actorSpriteComps1029 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								iter_39_5.color = Color.New(Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, (arg_36_1.time_ - 0) / var_39_3), Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, (arg_36_1.time_ - 0) / var_39_3), (Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, (arg_36_1.time_ - 0) / var_39_3)))
							else
								local var_39_4 = Mathf.Lerp(iter_39_5.color.r, 0.5, (arg_36_1.time_ - 0) / var_39_3)

								iter_39_5.color = Color.New(var_39_4, var_39_4, var_39_4)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps1029 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_39_7 then
						iter_39_7.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps1029 = nil
			end

			local var_39_5 = 0
			local var_39_6 = 0.075

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:GetWordFromCfg(117041008)
				local var_39_8 = arg_36_1:FormatText(var_39_7.content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 3 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_8) / 3)

				if (3 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_8) / 3)) > 0 and var_39_6 < var_39_10 then
					arg_36_1.talkMaxDuration = var_39_10

					if var_39_10 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_8
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041008", "story_v_out_117041.awb") ~= 0 then
					local var_39_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041008", "story_v_out_117041.awb") / 1000

					if var_39_11 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_5
					end

					if var_39_7.prefab_name ~= "" and arg_36_1.actors_[var_39_7.prefab_name] ~= nil then
						local var_39_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_7.prefab_name].transform, "story_v_out_117041", "117041008", "story_v_out_117041.awb")

						arg_36_1:RecordAudio("117041008", var_39_12)
						arg_36_1:RecordAudio("117041008", var_39_12)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_117041", "117041008", "story_v_out_117041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_117041", "117041008", "story_v_out_117041.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_13 and arg_36_1.time_ < var_39_5 + var_39_13 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play117041009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 117041009
		arg_40_1.duration_ = 2.63

		local var_40_0 = {
			zh = 1.6,
			ja = 2.633
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
				arg_40_0:Play117041010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1033"]) and arg_40_1.var_.actorSpriteComps1033 == nil then
				arg_40_1.var_.actorSpriteComps1033 = arg_40_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1033"]) then
				if arg_40_1.var_.actorSpriteComps1033 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								iter_43_1.color = Color.New(Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor2.r, (arg_40_1.time_ - 0) / var_43_0), Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor2.g, (arg_40_1.time_ - 0) / var_43_0), (Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor2.b, (arg_40_1.time_ - 0) / var_43_0)))
							else
								local var_43_1 = Mathf.Lerp(iter_43_1.color.r, 0.5, (arg_40_1.time_ - 0) / var_43_0)

								iter_43_1.color = Color.New(var_43_1, var_43_1, var_43_1)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1033"]) and arg_40_1.var_.actorSpriteComps1033 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_40_1.var_.actorSpriteComps1033 = nil
			end

			local var_43_2 = arg_40_1.actors_["1029"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1029 == nil then
				arg_40_1.var_.actorSpriteComps1029 = var_43_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_3 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.actorSpriteComps1029 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_43_5 then
							if arg_40_1.isInRecall_ then
								iter_43_5.color = Color.New(Mathf.Lerp(iter_43_5.color.r, arg_40_1.hightColor1.r, (arg_40_1.time_ - 0) / var_43_3), Mathf.Lerp(iter_43_5.color.g, arg_40_1.hightColor1.g, (arg_40_1.time_ - 0) / var_43_3), (Mathf.Lerp(iter_43_5.color.b, arg_40_1.hightColor1.b, (arg_40_1.time_ - 0) / var_43_3)))
							else
								local var_43_4 = Mathf.Lerp(iter_43_5.color.r, 1, (arg_40_1.time_ - 0) / var_43_3)

								iter_43_5.color = Color.New(var_43_4, var_43_4, var_43_4)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1029 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_43_7 then
						iter_43_7.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps1029 = nil
			end

			local var_43_5 = 0
			local var_43_6 = 0.2

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(117041009)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 8 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 8)

				if (8 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 8)) > 0 and var_43_6 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10

					if var_43_10 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041009", "story_v_out_117041.awb") ~= 0 then
					local var_43_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041009", "story_v_out_117041.awb") / 1000

					if var_43_11 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_5
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_117041", "117041009", "story_v_out_117041.awb")

						arg_40_1:RecordAudio("117041009", var_43_12)
						arg_40_1:RecordAudio("117041009", var_43_12)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_117041", "117041009", "story_v_out_117041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_117041", "117041009", "story_v_out_117041.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_13 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_13 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_13

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_13 and arg_40_1.time_ < var_43_5 + var_43_13 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play117041010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 117041010
		arg_44_1.duration_ = 4.47

		local var_44_0 = {
			zh = 3.966,
			ja = 4.466
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
				arg_44_0:Play117041011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1033"]) and arg_44_1.var_.actorSpriteComps1033 == nil then
				arg_44_1.var_.actorSpriteComps1033 = arg_44_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1033"]) then
				if arg_44_1.var_.actorSpriteComps1033 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								iter_47_1.color = Color.New(Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, (arg_44_1.time_ - 0) / var_47_0), Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, (arg_44_1.time_ - 0) / var_47_0), (Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, (arg_44_1.time_ - 0) / var_47_0)))
							else
								local var_47_1 = Mathf.Lerp(iter_47_1.color.r, 1, (arg_44_1.time_ - 0) / var_47_0)

								iter_47_1.color = Color.New(var_47_1, var_47_1, var_47_1)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1033"]) and arg_44_1.var_.actorSpriteComps1033 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_47_3 then
						iter_47_3.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_44_1.var_.actorSpriteComps1033 = nil
			end

			local var_47_2 = arg_44_1.actors_["1029"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps1029 == nil then
				arg_44_1.var_.actorSpriteComps1029 = var_47_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.actorSpriteComps1029 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								iter_47_5.color = Color.New(Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, (arg_44_1.time_ - 0) / var_47_3), Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, (arg_44_1.time_ - 0) / var_47_3), (Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, (arg_44_1.time_ - 0) / var_47_3)))
							else
								local var_47_4 = Mathf.Lerp(iter_47_5.color.r, 0.5, (arg_44_1.time_ - 0) / var_47_3)

								iter_47_5.color = Color.New(var_47_4, var_47_4, var_47_4)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps1029 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_47_7 then
						iter_47_7.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_44_1.var_.actorSpriteComps1029 = nil
			end

			local var_47_5 = 0
			local var_47_6 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:GetWordFromCfg(117041010)
				local var_47_8 = arg_44_1:FormatText(var_47_7.content)

				arg_44_1.text_.text = var_47_8

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 20 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 20)

				if (20 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 20)) > 0 and var_47_6 < var_47_10 then
					arg_44_1.talkMaxDuration = var_47_10

					if var_47_10 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_8
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041010", "story_v_out_117041.awb") ~= 0 then
					local var_47_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041010", "story_v_out_117041.awb") / 1000

					if var_47_11 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_5
					end

					if var_47_7.prefab_name ~= "" and arg_44_1.actors_[var_47_7.prefab_name] ~= nil then
						local var_47_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_7.prefab_name].transform, "story_v_out_117041", "117041010", "story_v_out_117041.awb")

						arg_44_1:RecordAudio("117041010", var_47_12)
						arg_44_1:RecordAudio("117041010", var_47_12)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_117041", "117041010", "story_v_out_117041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_117041", "117041010", "story_v_out_117041.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_13 and arg_44_1.time_ < var_47_5 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play117041011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 117041011
		arg_48_1.duration_ = 11.03

		local var_48_0 = {
			zh = 11.033,
			ja = 7.766
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
				arg_48_0:Play117041012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1033"]) and arg_48_1.var_.actorSpriteComps1033 == nil then
				arg_48_1.var_.actorSpriteComps1033 = arg_48_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1033"]) then
				if arg_48_1.var_.actorSpriteComps1033 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								iter_51_1.color = Color.New(Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor2.r, (arg_48_1.time_ - 0) / var_51_0), Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor2.g, (arg_48_1.time_ - 0) / var_51_0), (Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor2.b, (arg_48_1.time_ - 0) / var_51_0)))
							else
								local var_51_1 = Mathf.Lerp(iter_51_1.color.r, 0.5, (arg_48_1.time_ - 0) / var_51_0)

								iter_51_1.color = Color.New(var_51_1, var_51_1, var_51_1)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1033"]) and arg_48_1.var_.actorSpriteComps1033 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps1033 = nil
			end

			local var_51_2 = arg_48_1.actors_["1029"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.actorSpriteComps1029 == nil then
				arg_48_1.var_.actorSpriteComps1029 = var_51_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_3 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.actorSpriteComps1029 then
					for iter_51_4, iter_51_5 in pairs(arg_48_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_51_5 then
							if arg_48_1.isInRecall_ then
								iter_51_5.color = Color.New(Mathf.Lerp(iter_51_5.color.r, arg_48_1.hightColor1.r, (arg_48_1.time_ - 0) / var_51_3), Mathf.Lerp(iter_51_5.color.g, arg_48_1.hightColor1.g, (arg_48_1.time_ - 0) / var_51_3), (Mathf.Lerp(iter_51_5.color.b, arg_48_1.hightColor1.b, (arg_48_1.time_ - 0) / var_51_3)))
							else
								local var_51_4 = Mathf.Lerp(iter_51_5.color.r, 1, (arg_48_1.time_ - 0) / var_51_3)

								iter_51_5.color = Color.New(var_51_4, var_51_4, var_51_4)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.actorSpriteComps1029 then
				for iter_51_6, iter_51_7 in pairs(arg_48_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_51_7 then
						iter_51_7.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_48_1.var_.actorSpriteComps1029 = nil
			end

			local var_51_5 = 0
			local var_51_6 = 0.825

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:GetWordFromCfg(117041011)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 33 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 33)

				if (33 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 33)) > 0 and var_51_6 < var_51_10 then
					arg_48_1.talkMaxDuration = var_51_10

					if var_51_10 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041011", "story_v_out_117041.awb") ~= 0 then
					local var_51_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041011", "story_v_out_117041.awb") / 1000

					if var_51_11 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_5
					end

					if var_51_7.prefab_name ~= "" and arg_48_1.actors_[var_51_7.prefab_name] ~= nil then
						local var_51_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_7.prefab_name].transform, "story_v_out_117041", "117041011", "story_v_out_117041.awb")

						arg_48_1:RecordAudio("117041011", var_51_12)
						arg_48_1:RecordAudio("117041011", var_51_12)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_117041", "117041011", "story_v_out_117041.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_117041", "117041011", "story_v_out_117041.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_13 and arg_48_1.time_ < var_51_5 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play117041012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 117041012
		arg_52_1.duration_ = 9.7

		local var_52_0 = {
			zh = 9.066,
			ja = 9.7
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
				arg_52_0:Play117041013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1033"]) and arg_52_1.var_.actorSpriteComps1033 == nil then
				arg_52_1.var_.actorSpriteComps1033 = arg_52_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1033"]) then
				if arg_52_1.var_.actorSpriteComps1033 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								iter_55_1.color = Color.New(Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, (arg_52_1.time_ - 0) / var_55_0), Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, (arg_52_1.time_ - 0) / var_55_0), (Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, (arg_52_1.time_ - 0) / var_55_0)))
							else
								local var_55_1 = Mathf.Lerp(iter_55_1.color.r, 1, (arg_52_1.time_ - 0) / var_55_0)

								iter_55_1.color = Color.New(var_55_1, var_55_1, var_55_1)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1033"]) and arg_52_1.var_.actorSpriteComps1033 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps1033 = nil
			end

			local var_55_2 = arg_52_1.actors_["1029"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1029 == nil then
				arg_52_1.var_.actorSpriteComps1029 = var_55_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_3 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.actorSpriteComps1029 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								iter_55_5.color = Color.New(Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, (arg_52_1.time_ - 0) / var_55_3), Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, (arg_52_1.time_ - 0) / var_55_3), (Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, (arg_52_1.time_ - 0) / var_55_3)))
							else
								local var_55_4 = Mathf.Lerp(iter_55_5.color.r, 0.5, (arg_52_1.time_ - 0) / var_55_3)

								iter_55_5.color = Color.New(var_55_4, var_55_4, var_55_4)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1029 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_55_7 then
						iter_55_7.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_52_1.var_.actorSpriteComps1029 = nil
			end

			local var_55_5 = 0
			local var_55_6 = 1.1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_7 = arg_52_1:GetWordFromCfg(117041012)
				local var_55_8 = arg_52_1:FormatText(var_55_7.content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 44 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 44)

				if (44 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 44)) > 0 and var_55_6 < var_55_10 then
					arg_52_1.talkMaxDuration = var_55_10

					if var_55_10 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_5
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041012", "story_v_out_117041.awb") ~= 0 then
					local var_55_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041012", "story_v_out_117041.awb") / 1000

					if var_55_11 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_5
					end

					if var_55_7.prefab_name ~= "" and arg_52_1.actors_[var_55_7.prefab_name] ~= nil then
						local var_55_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_7.prefab_name].transform, "story_v_out_117041", "117041012", "story_v_out_117041.awb")

						arg_52_1:RecordAudio("117041012", var_55_12)
						arg_52_1:RecordAudio("117041012", var_55_12)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_117041", "117041012", "story_v_out_117041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_117041", "117041012", "story_v_out_117041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_13 = math.max(var_55_6, arg_52_1.talkMaxDuration)

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_13 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_5) / var_55_13

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_5 + var_55_13 and arg_52_1.time_ < var_55_5 + var_55_13 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play117041013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 117041013
		arg_56_1.duration_ = 9.5

		local var_56_0 = {
			zh = 7.066,
			ja = 9.5
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
				arg_56_0:Play117041014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1033"]) and arg_56_1.var_.actorSpriteComps1033 == nil then
				arg_56_1.var_.actorSpriteComps1033 = arg_56_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1033"]) then
				if arg_56_1.var_.actorSpriteComps1033 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 0.5, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1033"]) and arg_56_1.var_.actorSpriteComps1033 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps1033 = nil
			end

			local var_59_2 = arg_56_1.actors_["1029"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps1029 == nil then
				arg_56_1.var_.actorSpriteComps1029 = var_59_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_3 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.actorSpriteComps1029 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								iter_59_5.color = Color.New(Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor1.r, (arg_56_1.time_ - 0) / var_59_3), Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor1.g, (arg_56_1.time_ - 0) / var_59_3), (Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor1.b, (arg_56_1.time_ - 0) / var_59_3)))
							else
								local var_59_4 = Mathf.Lerp(iter_59_5.color.r, 1, (arg_56_1.time_ - 0) / var_59_3)

								iter_59_5.color = Color.New(var_59_4, var_59_4, var_59_4)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps1029 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_59_7 then
						iter_59_7.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps1029 = nil
			end

			local var_59_5 = 0
			local var_59_6 = 0.775

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:GetWordFromCfg(117041013)
				local var_59_8 = arg_56_1:FormatText(var_59_7.content)

				arg_56_1.text_.text = var_59_8

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 32 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 32)

				if (32 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 32)) > 0 and var_59_6 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_8
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041013", "story_v_out_117041.awb") ~= 0 then
					local var_59_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041013", "story_v_out_117041.awb") / 1000

					if var_59_11 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_5
					end

					if var_59_7.prefab_name ~= "" and arg_56_1.actors_[var_59_7.prefab_name] ~= nil then
						local var_59_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_7.prefab_name].transform, "story_v_out_117041", "117041013", "story_v_out_117041.awb")

						arg_56_1:RecordAudio("117041013", var_59_12)
						arg_56_1:RecordAudio("117041013", var_59_12)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_117041", "117041013", "story_v_out_117041.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_117041", "117041013", "story_v_out_117041.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_13 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_13

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_13 and arg_56_1.time_ < var_59_5 + var_59_13 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play117041014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 117041014
		arg_60_1.duration_ = 2.13

		local var_60_0 = {
			zh = 1.166,
			ja = 2.133
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
				arg_60_0:Play117041015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1033"]) and arg_60_1.var_.actorSpriteComps1033 == nil then
				arg_60_1.var_.actorSpriteComps1033 = arg_60_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1033"]) then
				if arg_60_1.var_.actorSpriteComps1033 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								iter_63_1.color = Color.New(Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, (arg_60_1.time_ - 0) / var_63_0), Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, (arg_60_1.time_ - 0) / var_63_0), (Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, (arg_60_1.time_ - 0) / var_63_0)))
							else
								local var_63_1 = Mathf.Lerp(iter_63_1.color.r, 1, (arg_60_1.time_ - 0) / var_63_0)

								iter_63_1.color = Color.New(var_63_1, var_63_1, var_63_1)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1033"]) and arg_60_1.var_.actorSpriteComps1033 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_60_1.var_.actorSpriteComps1033 = nil
			end

			local var_63_2 = arg_60_1.actors_["1029"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps1029 == nil then
				arg_60_1.var_.actorSpriteComps1029 = var_63_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_3 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.actorSpriteComps1029 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								iter_63_5.color = Color.New(Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, (arg_60_1.time_ - 0) / var_63_3), Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, (arg_60_1.time_ - 0) / var_63_3), (Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, (arg_60_1.time_ - 0) / var_63_3)))
							else
								local var_63_4 = Mathf.Lerp(iter_63_5.color.r, 0.5, (arg_60_1.time_ - 0) / var_63_3)

								iter_63_5.color = Color.New(var_63_4, var_63_4, var_63_4)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps1029 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_63_7 then
						iter_63_7.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_60_1.var_.actorSpriteComps1029 = nil
			end

			local var_63_5 = 0
			local var_63_6 = 0.1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:GetWordFromCfg(117041014)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_10 = 4 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_8) / 4)

				if (4 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_8) / 4)) > 0 and var_63_6 < var_63_10 then
					arg_60_1.talkMaxDuration = var_63_10

					if var_63_10 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_5
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041014", "story_v_out_117041.awb") ~= 0 then
					local var_63_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041014", "story_v_out_117041.awb") / 1000

					if var_63_11 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_5
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_117041", "117041014", "story_v_out_117041.awb")

						arg_60_1:RecordAudio("117041014", var_63_12)
						arg_60_1:RecordAudio("117041014", var_63_12)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_117041", "117041014", "story_v_out_117041.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_117041", "117041014", "story_v_out_117041.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_13 = math.max(var_63_6, arg_60_1.talkMaxDuration)

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_13 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_5) / var_63_13

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_5 + var_63_13 and arg_60_1.time_ < var_63_5 + var_63_13 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play117041015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 117041015
		arg_64_1.duration_ = 11.87

		local var_64_0 = {
			zh = 11.4,
			ja = 11.866
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
				arg_64_0:Play117041016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1033"]) and arg_64_1.var_.actorSpriteComps1033 == nil then
				arg_64_1.var_.actorSpriteComps1033 = arg_64_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1033"]) then
				if arg_64_1.var_.actorSpriteComps1033 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor2.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor2.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor2.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 0.5, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1033"]) and arg_64_1.var_.actorSpriteComps1033 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps1033 = nil
			end

			local var_67_2 = arg_64_1.actors_["1029"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps1029 == nil then
				arg_64_1.var_.actorSpriteComps1029 = var_67_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_3 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.actorSpriteComps1029 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								iter_67_5.color = Color.New(Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor1.r, (arg_64_1.time_ - 0) / var_67_3), Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor1.g, (arg_64_1.time_ - 0) / var_67_3), (Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor1.b, (arg_64_1.time_ - 0) / var_67_3)))
							else
								local var_67_4 = Mathf.Lerp(iter_67_5.color.r, 1, (arg_64_1.time_ - 0) / var_67_3)

								iter_67_5.color = Color.New(var_67_4, var_67_4, var_67_4)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps1029 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_67_7 then
						iter_67_7.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps1029 = nil
			end

			local var_67_5 = 0
			local var_67_6 = 1.525

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:GetWordFromCfg(117041015)
				local var_67_8 = arg_64_1:FormatText(var_67_7.content)

				arg_64_1.text_.text = var_67_8

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_10 = 61 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_8) / 61)

				if (61 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_8) / 61)) > 0 and var_67_6 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_5
					end
				end

				arg_64_1.text_.text = var_67_8
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041015", "story_v_out_117041.awb") ~= 0 then
					local var_67_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041015", "story_v_out_117041.awb") / 1000

					if var_67_11 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_5
					end

					if var_67_7.prefab_name ~= "" and arg_64_1.actors_[var_67_7.prefab_name] ~= nil then
						local var_67_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_7.prefab_name].transform, "story_v_out_117041", "117041015", "story_v_out_117041.awb")

						arg_64_1:RecordAudio("117041015", var_67_12)
						arg_64_1:RecordAudio("117041015", var_67_12)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_117041", "117041015", "story_v_out_117041.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_117041", "117041015", "story_v_out_117041.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_13 = math.max(var_67_6, arg_64_1.talkMaxDuration)

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_13 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_5) / var_67_13

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_5 + var_67_13 and arg_64_1.time_ < var_67_5 + var_67_13 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play117041016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 117041016
		arg_68_1.duration_ = 12.27

		local var_68_0 = {
			zh = 8.3,
			ja = 12.266
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
				arg_68_0:Play117041017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.85

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:GetWordFromCfg(117041016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 34 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 34)

				if (34 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 34)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041016", "story_v_out_117041.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041016", "story_v_out_117041.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_117041", "117041016", "story_v_out_117041.awb")

						arg_68_1:RecordAudio("117041016", var_71_6)
						arg_68_1:RecordAudio("117041016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_117041", "117041016", "story_v_out_117041.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_117041", "117041016", "story_v_out_117041.awb")
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
	Play117041017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 117041017
		arg_72_1.duration_ = 7.77

		local var_72_0 = {
			zh = 7.766,
			ja = 5.2
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
				arg_72_0:Play117041018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1033"]) and arg_72_1.var_.actorSpriteComps1033 == nil then
				arg_72_1.var_.actorSpriteComps1033 = arg_72_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1033"]) then
				if arg_72_1.var_.actorSpriteComps1033 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 1, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1033"]) and arg_72_1.var_.actorSpriteComps1033 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps1033 = nil
			end

			local var_75_2 = arg_72_1.actors_["1029"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps1029 == nil then
				arg_72_1.var_.actorSpriteComps1029 = var_75_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_3 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.actorSpriteComps1029 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								iter_75_5.color = Color.New(Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, (arg_72_1.time_ - 0) / var_75_3), Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, (arg_72_1.time_ - 0) / var_75_3), (Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, (arg_72_1.time_ - 0) / var_75_3)))
							else
								local var_75_4 = Mathf.Lerp(iter_75_5.color.r, 0.5, (arg_72_1.time_ - 0) / var_75_3)

								iter_75_5.color = Color.New(var_75_4, var_75_4, var_75_4)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps1029 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_75_7 then
						iter_75_7.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_72_1.var_.actorSpriteComps1029 = nil
			end

			local var_75_5 = 0
			local var_75_6 = 0.875

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_7 = arg_72_1:GetWordFromCfg(117041017)
				local var_75_8 = arg_72_1:FormatText(var_75_7.content)

				arg_72_1.text_.text = var_75_8

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_10 = 35 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_8) / 35)

				if (35 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_8) / 35)) > 0 and var_75_6 < var_75_10 then
					arg_72_1.talkMaxDuration = var_75_10

					if var_75_10 + var_75_5 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_5
					end
				end

				arg_72_1.text_.text = var_75_8
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041017", "story_v_out_117041.awb") ~= 0 then
					local var_75_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041017", "story_v_out_117041.awb") / 1000

					if var_75_11 + var_75_5 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_5
					end

					if var_75_7.prefab_name ~= "" and arg_72_1.actors_[var_75_7.prefab_name] ~= nil then
						local var_75_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_7.prefab_name].transform, "story_v_out_117041", "117041017", "story_v_out_117041.awb")

						arg_72_1:RecordAudio("117041017", var_75_12)
						arg_72_1:RecordAudio("117041017", var_75_12)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_117041", "117041017", "story_v_out_117041.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_117041", "117041017", "story_v_out_117041.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_13 = math.max(var_75_6, arg_72_1.talkMaxDuration)

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_13 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_5) / var_75_13

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_5 + var_75_13 and arg_72_1.time_ < var_75_5 + var_75_13 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play117041018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 117041018
		arg_76_1.duration_ = 7.87

		local var_76_0 = {
			zh = 7.866,
			ja = 7.066
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
				arg_76_0:Play117041019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1033"]) and arg_76_1.var_.actorSpriteComps1033 == nil then
				arg_76_1.var_.actorSpriteComps1033 = arg_76_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1033"]) then
				if arg_76_1.var_.actorSpriteComps1033 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1033"]) and arg_76_1.var_.actorSpriteComps1033 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps1033 = nil
			end

			local var_79_2 = arg_76_1.actors_["1029"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1029 == nil then
				arg_76_1.var_.actorSpriteComps1029 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps1029 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								iter_79_5.color = Color.New(Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_5.color.r, 1, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_5.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1029 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_79_7 then
						iter_79_7.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps1029 = nil
			end

			local var_79_5 = 0
			local var_79_6 = 0.8

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_7 = arg_76_1:GetWordFromCfg(117041018)
				local var_79_8 = arg_76_1:FormatText(var_79_7.content)

				arg_76_1.text_.text = var_79_8

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_10 = 32 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_8) / 32)

				if (32 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_8) / 32)) > 0 and var_79_6 < var_79_10 then
					arg_76_1.talkMaxDuration = var_79_10

					if var_79_10 + var_79_5 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_5
					end
				end

				arg_76_1.text_.text = var_79_8
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041018", "story_v_out_117041.awb") ~= 0 then
					local var_79_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041018", "story_v_out_117041.awb") / 1000

					if var_79_11 + var_79_5 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_5
					end

					if var_79_7.prefab_name ~= "" and arg_76_1.actors_[var_79_7.prefab_name] ~= nil then
						local var_79_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_7.prefab_name].transform, "story_v_out_117041", "117041018", "story_v_out_117041.awb")

						arg_76_1:RecordAudio("117041018", var_79_12)
						arg_76_1:RecordAudio("117041018", var_79_12)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_117041", "117041018", "story_v_out_117041.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_117041", "117041018", "story_v_out_117041.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_13 = math.max(var_79_6, arg_76_1.talkMaxDuration)

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_13 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_5) / var_79_13

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_5 + var_79_13 and arg_76_1.time_ < var_79_5 + var_79_13 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play117041019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 117041019
		arg_80_1.duration_ = 8.27

		local var_80_0 = {
			zh = 3.666,
			ja = 8.266
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
				arg_80_0:Play117041020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1033"]) and arg_80_1.var_.actorSpriteComps1033 == nil then
				arg_80_1.var_.actorSpriteComps1033 = arg_80_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1033"]) then
				if arg_80_1.var_.actorSpriteComps1033 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								iter_83_1.color = Color.New(Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, (arg_80_1.time_ - 0) / var_83_0), Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, (arg_80_1.time_ - 0) / var_83_0), (Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, (arg_80_1.time_ - 0) / var_83_0)))
							else
								local var_83_1 = Mathf.Lerp(iter_83_1.color.r, 1, (arg_80_1.time_ - 0) / var_83_0)

								iter_83_1.color = Color.New(var_83_1, var_83_1, var_83_1)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1033"]) and arg_80_1.var_.actorSpriteComps1033 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps1033 = nil
			end

			local var_83_2 = arg_80_1.actors_["1029"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps1029 == nil then
				arg_80_1.var_.actorSpriteComps1029 = var_83_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_3 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.actorSpriteComps1029 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_83_5 then
							if arg_80_1.isInRecall_ then
								iter_83_5.color = Color.New(Mathf.Lerp(iter_83_5.color.r, arg_80_1.hightColor2.r, (arg_80_1.time_ - 0) / var_83_3), Mathf.Lerp(iter_83_5.color.g, arg_80_1.hightColor2.g, (arg_80_1.time_ - 0) / var_83_3), (Mathf.Lerp(iter_83_5.color.b, arg_80_1.hightColor2.b, (arg_80_1.time_ - 0) / var_83_3)))
							else
								local var_83_4 = Mathf.Lerp(iter_83_5.color.r, 0.5, (arg_80_1.time_ - 0) / var_83_3)

								iter_83_5.color = Color.New(var_83_4, var_83_4, var_83_4)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps1029 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_83_7 then
						iter_83_7.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_80_1.var_.actorSpriteComps1029 = nil
			end

			local var_83_5 = 0
			local var_83_6 = 0.325

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(117041019)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 13 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 13)

				if (13 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 13)) > 0 and var_83_6 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041019", "story_v_out_117041.awb") ~= 0 then
					local var_83_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041019", "story_v_out_117041.awb") / 1000

					if var_83_11 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_5
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_117041", "117041019", "story_v_out_117041.awb")

						arg_80_1:RecordAudio("117041019", var_83_12)
						arg_80_1:RecordAudio("117041019", var_83_12)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_117041", "117041019", "story_v_out_117041.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_117041", "117041019", "story_v_out_117041.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_13 and arg_80_1.time_ < var_83_5 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play117041020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 117041020
		arg_84_1.duration_ = 5.9

		local var_84_0 = {
			zh = 2.566,
			ja = 5.9
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
				arg_84_0:Play117041021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1033"]) and arg_84_1.var_.actorSpriteComps1033 == nil then
				arg_84_1.var_.actorSpriteComps1033 = arg_84_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1033"]) then
				if arg_84_1.var_.actorSpriteComps1033 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1033"]) and arg_84_1.var_.actorSpriteComps1033 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps1033 = nil
			end

			local var_87_2 = arg_84_1.actors_["1029"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps1029 == nil then
				arg_84_1.var_.actorSpriteComps1029 = var_87_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_3 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.actorSpriteComps1029 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_87_5 then
							if arg_84_1.isInRecall_ then
								iter_87_5.color = Color.New(Mathf.Lerp(iter_87_5.color.r, arg_84_1.hightColor1.r, (arg_84_1.time_ - 0) / var_87_3), Mathf.Lerp(iter_87_5.color.g, arg_84_1.hightColor1.g, (arg_84_1.time_ - 0) / var_87_3), (Mathf.Lerp(iter_87_5.color.b, arg_84_1.hightColor1.b, (arg_84_1.time_ - 0) / var_87_3)))
							else
								local var_87_4 = Mathf.Lerp(iter_87_5.color.r, 1, (arg_84_1.time_ - 0) / var_87_3)

								iter_87_5.color = Color.New(var_87_4, var_87_4, var_87_4)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps1029 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_87_7 then
						iter_87_7.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps1029 = nil
			end

			local var_87_5 = 0
			local var_87_6 = 0.25

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:GetWordFromCfg(117041020)
				local var_87_8 = arg_84_1:FormatText(var_87_7.content)

				arg_84_1.text_.text = var_87_8

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 10 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 10)

				if (10 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 10)) > 0 and var_87_6 < var_87_10 then
					arg_84_1.talkMaxDuration = var_87_10

					if var_87_10 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_8
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041020", "story_v_out_117041.awb") ~= 0 then
					local var_87_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041020", "story_v_out_117041.awb") / 1000

					if var_87_11 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_5
					end

					if var_87_7.prefab_name ~= "" and arg_84_1.actors_[var_87_7.prefab_name] ~= nil then
						local var_87_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_7.prefab_name].transform, "story_v_out_117041", "117041020", "story_v_out_117041.awb")

						arg_84_1:RecordAudio("117041020", var_87_12)
						arg_84_1:RecordAudio("117041020", var_87_12)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_117041", "117041020", "story_v_out_117041.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_117041", "117041020", "story_v_out_117041.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_13 and arg_84_1.time_ < var_87_5 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play117041021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 117041021
		arg_88_1.duration_ = 1.57

		local var_88_0 = {
			zh = 1,
			ja = 1.566
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
				arg_88_0:Play117041022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1033"]) and arg_88_1.var_.actorSpriteComps1033 == nil then
				arg_88_1.var_.actorSpriteComps1033 = arg_88_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1033"]) then
				if arg_88_1.var_.actorSpriteComps1033 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 1, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1033"]) and arg_88_1.var_.actorSpriteComps1033 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_88_1.var_.actorSpriteComps1033 = nil
			end

			local var_91_2 = arg_88_1.actors_["1029"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps1029 == nil then
				arg_88_1.var_.actorSpriteComps1029 = var_91_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_3 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.actorSpriteComps1029 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								iter_91_5.color = Color.New(Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, (arg_88_1.time_ - 0) / var_91_3), Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, (arg_88_1.time_ - 0) / var_91_3), (Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, (arg_88_1.time_ - 0) / var_91_3)))
							else
								local var_91_4 = Mathf.Lerp(iter_91_5.color.r, 0.5, (arg_88_1.time_ - 0) / var_91_3)

								iter_91_5.color = Color.New(var_91_4, var_91_4, var_91_4)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps1029 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_91_7 then
						iter_91_7.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_88_1.var_.actorSpriteComps1029 = nil
			end

			local var_91_5 = 0
			local var_91_6 = 0.075

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:GetWordFromCfg(117041021)
				local var_91_8 = arg_88_1:FormatText(var_91_7.content)

				arg_88_1.text_.text = var_91_8

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 3 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 3)

				if (3 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 3)) > 0 and var_91_6 < var_91_10 then
					arg_88_1.talkMaxDuration = var_91_10

					if var_91_10 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_8
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041021", "story_v_out_117041.awb") ~= 0 then
					local var_91_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041021", "story_v_out_117041.awb") / 1000

					if var_91_11 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_5
					end

					if var_91_7.prefab_name ~= "" and arg_88_1.actors_[var_91_7.prefab_name] ~= nil then
						local var_91_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_7.prefab_name].transform, "story_v_out_117041", "117041021", "story_v_out_117041.awb")

						arg_88_1:RecordAudio("117041021", var_91_12)
						arg_88_1:RecordAudio("117041021", var_91_12)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_117041", "117041021", "story_v_out_117041.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_117041", "117041021", "story_v_out_117041.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_13 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_13 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_13

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_13 and arg_88_1.time_ < var_91_5 + var_91_13 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play117041022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 117041022
		arg_92_1.duration_ = 10.23

		local var_92_0 = {
			zh = 10.233,
			ja = 9.633
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
				arg_92_0:Play117041023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.bgs_.ST03 == nil then
				local var_95_0 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_95_0.name = "ST03"
				var_95_0.transform.parent = arg_92_1.stage_.transform
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_.ST03 = var_95_0
			end

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= 2 + arg_95_0 then
				local var_95_1 = arg_92_1.bgs_.ST03

				arg_92_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_95_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_2 = var_95_1:GetComponent("SpriteRenderer")

				if var_95_2 and var_95_2.sprite then
					local var_95_3 = 2 * (var_95_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_95_1.transform.localScale = Vector3.New(var_95_3 / var_95_2.sprite.bounds.size.y < var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x and var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x or var_95_3 / var_95_2.sprite.bounds.size.y, var_95_3 / var_95_2.sprite.bounds.size.y < var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x and var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x or var_95_3 / var_95_2.sprite.bounds.size.y, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "ST03" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_4 = 0

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_5 = 2

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_5 then
				local var_95_6 = Color.New(0, 0, 0)

				var_95_6.a = Mathf.Lerp(0, 1, (arg_92_1.time_ - var_95_4) / var_95_5)
				arg_92_1.mask_.color = var_95_6
			end

			if arg_92_1.time_ >= var_95_4 + var_95_5 and arg_92_1.time_ < var_95_4 + var_95_5 + arg_95_0 then
				local var_95_7 = Color.New(0, 0, 0)

				var_95_7.a = 1
				arg_92_1.mask_.color = var_95_7
			end

			local var_95_8 = 2

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_9 = 2

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_9 then
				local var_95_10 = Color.New(0, 0, 0)

				var_95_10.a = Mathf.Lerp(1, 0, (arg_92_1.time_ - var_95_8) / var_95_9)
				arg_92_1.mask_.color = var_95_10
			end

			if arg_92_1.time_ >= var_95_8 + var_95_9 and arg_92_1.time_ < var_95_8 + var_95_9 + arg_95_0 then
				local var_95_11 = Color.New(0, 0, 0)

				arg_92_1.mask_.enabled = false
				var_95_11.a = 0
				arg_92_1.mask_.color = var_95_11
			end

			local var_95_12 = arg_92_1.actors_["1033"].transform

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= 2 + arg_95_0 then
				arg_92_1.var_.moveOldPos1033 = var_95_12.localPosition
				var_95_12.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1033", 7)

				for iter_95_2 = 0, var_95_12.childCount - 1 do
					local var_95_13 = var_95_12:GetChild(iter_95_2)

					if var_95_13.name == "split_6" or not string.find(var_95_13.name, "split") then
						var_95_13.gameObject:SetActive(true)
					else
						var_95_13.gameObject:SetActive(false)
					end
				end
			end

			local var_95_14 = 0.001

			if 2 <= arg_92_1.time_ and arg_92_1.time_ < 2 + var_95_14 then
				var_95_12.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_92_1.time_ - 2) / var_95_14)
			end

			if arg_92_1.time_ >= 2 + var_95_14 and arg_92_1.time_ < 2 + var_95_14 + arg_95_0 then
				var_95_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_15 = arg_92_1.actors_["1029"].transform

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= 2 + arg_95_0 then
				arg_92_1.var_.moveOldPos1029 = var_95_15.localPosition
				var_95_15.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1029", 7)

				for iter_95_3 = 0, var_95_15.childCount - 1 do
					local var_95_16 = var_95_15:GetChild(iter_95_3)

					if var_95_16.name == "split_1" or not string.find(var_95_16.name, "split") then
						var_95_16.gameObject:SetActive(true)
					else
						var_95_16.gameObject:SetActive(false)
					end
				end
			end

			local var_95_17 = 0.001

			if 2 <= arg_92_1.time_ and arg_92_1.time_ < 2 + var_95_17 then
				var_95_15.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1029, Vector3.New(0, -2000, -140), (arg_92_1.time_ - 2) / var_95_17)
			end

			if arg_92_1.time_ >= 2 + var_95_17 and arg_92_1.time_ < 2 + var_95_17 + arg_95_0 then
				var_95_15.localPosition = Vector3.New(0, -2000, -140)
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_18 = 4
			local var_95_19 = 0.8

			if 4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_18 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_20 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_20:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_21 = arg_92_1:GetWordFromCfg(117041022)
				local var_95_22 = arg_92_1:FormatText(var_95_21.content)

				arg_92_1.text_.text = var_95_22

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_24 = 32 <= 0 and var_95_19 or var_95_19 * (utf8.len(var_95_22) / 32)

				if (32 <= 0 and var_95_19 or var_95_19 * (utf8.len(var_95_22) / 32)) > 0 and var_95_19 < var_95_24 then
					arg_92_1.talkMaxDuration = var_95_24
					var_95_18 = var_95_18 + 0.3

					if var_95_24 + var_95_18 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_24 + var_95_18
					end
				end

				arg_92_1.text_.text = var_95_22
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041022", "story_v_out_117041.awb") ~= 0 then
					local var_95_25 = manager.audio:GetVoiceLength("story_v_out_117041", "117041022", "story_v_out_117041.awb") / 1000

					if var_95_25 + var_95_18 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_25 + var_95_18
					end

					if var_95_21.prefab_name ~= "" and arg_92_1.actors_[var_95_21.prefab_name] ~= nil then
						local var_95_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_21.prefab_name].transform, "story_v_out_117041", "117041022", "story_v_out_117041.awb")

						arg_92_1:RecordAudio("117041022", var_95_26)
						arg_92_1:RecordAudio("117041022", var_95_26)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_117041", "117041022", "story_v_out_117041.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_117041", "117041022", "story_v_out_117041.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_27 = var_95_18 + 0.3
			local var_95_28 = math.max(var_95_19, arg_92_1.talkMaxDuration)

			if var_95_18 + 0.3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_27 + var_95_28 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_27) / var_95_28

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_27 + var_95_28 and arg_92_1.time_ < var_95_27 + var_95_28 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play117041023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 117041023
		arg_98_1.duration_ = 4.33

		local var_98_0 = {
			zh = 4.333,
			ja = 2.966
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
				arg_98_0:Play117041024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if arg_98_1.actors_["10036"] == nil then
				local var_101_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10036")

				if not isNil(var_101_0) then
					local var_101_1 = Object.Instantiate(var_101_0, arg_98_1.canvasGo_.transform)

					var_101_1.transform:SetSiblingIndex(1)

					var_101_1.name = "10036"
					var_101_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_98_1.actors_["10036"] = var_101_1

					if arg_98_1.isInRecall_ then
						for iter_101_0, iter_101_1 in ipairs((var_101_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_101_1.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_101_2 = arg_98_1.actors_["10036"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10036 = var_101_2.localPosition
				var_101_2.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("10036", 3)

				for iter_101_2 = 0, var_101_2.childCount - 1 do
					local var_101_3 = var_101_2:GetChild(iter_101_2)

					if var_101_3.name == "split_1" or not string.find(var_101_3.name, "split") then
						var_101_3.gameObject:SetActive(true)
					else
						var_101_3.gameObject:SetActive(false)
					end
				end
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_2.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10036, Vector3.New(0, -445, -290), (arg_98_1.time_ - 0) / var_101_4)
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_2.localPosition = Vector3.New(0, -445, -290)
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				local var_101_5 = arg_98_1.actors_["10036"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_101_5 then
					arg_98_1.var_.alphaOldValue10036 = var_101_5.alpha
					arg_98_1.var_.characterEffect10036 = var_101_5
				end

				arg_98_1.var_.alphaOldValue10036 = 0
			end

			local var_101_6 = 0.333333333333333

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_6 then
				if arg_98_1.var_.characterEffect10036 then
					arg_98_1.var_.characterEffect10036.alpha = Mathf.Lerp(arg_98_1.var_.alphaOldValue10036, 1, (arg_98_1.time_ - 0) / var_101_6)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_6 and arg_98_1.time_ < 0 + var_101_6 + arg_101_0 and arg_98_1.var_.characterEffect10036 then
				arg_98_1.var_.characterEffect10036.alpha = 1
			end

			local var_101_7 = 0
			local var_101_8 = 0.525

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_9 = arg_98_1:GetWordFromCfg(117041023)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_12 = 21 <= 0 and var_101_8 or var_101_8 * (utf8.len(var_101_10) / 21)

				if (21 <= 0 and var_101_8 or var_101_8 * (utf8.len(var_101_10) / 21)) > 0 and var_101_8 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_7 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_7
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041023", "story_v_out_117041.awb") ~= 0 then
					local var_101_13 = manager.audio:GetVoiceLength("story_v_out_117041", "117041023", "story_v_out_117041.awb") / 1000

					if var_101_13 + var_101_7 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_7
					end

					if var_101_9.prefab_name ~= "" and arg_98_1.actors_[var_101_9.prefab_name] ~= nil then
						local var_101_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_9.prefab_name].transform, "story_v_out_117041", "117041023", "story_v_out_117041.awb")

						arg_98_1:RecordAudio("117041023", var_101_14)
						arg_98_1:RecordAudio("117041023", var_101_14)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_117041", "117041023", "story_v_out_117041.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_117041", "117041023", "story_v_out_117041.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_15 = math.max(var_101_8, arg_98_1.talkMaxDuration)

			if var_101_7 <= arg_98_1.time_ and arg_98_1.time_ < var_101_7 + var_101_15 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_7) / var_101_15

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_7 + var_101_15 and arg_98_1.time_ < var_101_7 + var_101_15 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play117041024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 117041024
		arg_102_1.duration_ = 5.43

		local var_102_0 = {
			zh = 5.433,
			ja = 5.233
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
				arg_102_0:Play117041025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10036"]) and arg_102_1.var_.actorSpriteComps10036 == nil then
				arg_102_1.var_.actorSpriteComps10036 = arg_102_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10036"]) then
				if arg_102_1.var_.actorSpriteComps10036 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10036"]) and arg_102_1.var_.actorSpriteComps10036 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps10036 = nil
			end

			local var_105_2 = 0
			local var_105_3 = 0.75

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_4 = arg_102_1:GetWordFromCfg(117041024)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 30 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 30)

				if (30 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 30)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041024", "story_v_out_117041.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041024", "story_v_out_117041.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_117041", "117041024", "story_v_out_117041.awb")

						arg_102_1:RecordAudio("117041024", var_105_9)
						arg_102_1:RecordAudio("117041024", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_117041", "117041024", "story_v_out_117041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_117041", "117041024", "story_v_out_117041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_10 and arg_102_1.time_ < var_105_2 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play117041025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 117041025
		arg_106_1.duration_ = 5.2

		local var_106_0 = {
			zh = 5.2,
			ja = 5.066
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
				arg_106_0:Play117041026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10036"]) and arg_106_1.var_.actorSpriteComps10036 == nil then
				arg_106_1.var_.actorSpriteComps10036 = arg_106_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10036"]) then
				if arg_106_1.var_.actorSpriteComps10036 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 1, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10036"]) and arg_106_1.var_.actorSpriteComps10036 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps10036 = nil
			end

			local var_109_2 = 0
			local var_109_3 = 0.675

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(117041025)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 27 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 27)

				if (27 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 27)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041025", "story_v_out_117041.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041025", "story_v_out_117041.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_117041", "117041025", "story_v_out_117041.awb")

						arg_106_1:RecordAudio("117041025", var_109_9)
						arg_106_1:RecordAudio("117041025", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_117041", "117041025", "story_v_out_117041.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_117041", "117041025", "story_v_out_117041.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_10 and arg_106_1.time_ < var_109_2 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play117041026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 117041026
		arg_110_1.duration_ = 9.67

		local var_110_0 = {
			zh = 7.766,
			ja = 9.666
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
				arg_110_0:Play117041027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.95

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(117041026)
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

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041026", "story_v_out_117041.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041026", "story_v_out_117041.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_117041", "117041026", "story_v_out_117041.awb")

						arg_110_1:RecordAudio("117041026", var_113_6)
						arg_110_1:RecordAudio("117041026", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_117041", "117041026", "story_v_out_117041.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_117041", "117041026", "story_v_out_117041.awb")
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
	Play117041027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 117041027
		arg_114_1.duration_ = 5.17

		local var_114_0 = {
			zh = 3.166,
			ja = 5.166
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
				arg_114_0:Play117041028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10036"]) and arg_114_1.var_.actorSpriteComps10036 == nil then
				arg_114_1.var_.actorSpriteComps10036 = arg_114_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10036"]) then
				if arg_114_1.var_.actorSpriteComps10036 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								iter_117_1.color = Color.New(Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, (arg_114_1.time_ - 0) / var_117_0), Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, (arg_114_1.time_ - 0) / var_117_0), (Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, (arg_114_1.time_ - 0) / var_117_0)))
							else
								local var_117_1 = Mathf.Lerp(iter_117_1.color.r, 0.5, (arg_114_1.time_ - 0) / var_117_0)

								iter_117_1.color = Color.New(var_117_1, var_117_1, var_117_1)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10036"]) and arg_114_1.var_.actorSpriteComps10036 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_117_3 then
						iter_117_3.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_114_1.var_.actorSpriteComps10036 = nil
			end

			local var_117_2 = 0
			local var_117_3 = 0.4

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_4 = arg_114_1:GetWordFromCfg(117041027)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 16 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 16)

				if (16 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 16)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041027", "story_v_out_117041.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041027", "story_v_out_117041.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_117041", "117041027", "story_v_out_117041.awb")

						arg_114_1:RecordAudio("117041027", var_117_9)
						arg_114_1:RecordAudio("117041027", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_117041", "117041027", "story_v_out_117041.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_117041", "117041027", "story_v_out_117041.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_10 and arg_114_1.time_ < var_117_2 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play117041028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 117041028
		arg_118_1.duration_ = 11.3

		local var_118_0 = {
			zh = 10.666,
			ja = 11.3
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
				arg_118_0:Play117041029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["10036"]) and arg_118_1.var_.actorSpriteComps10036 == nil then
				arg_118_1.var_.actorSpriteComps10036 = arg_118_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["10036"]) then
				if arg_118_1.var_.actorSpriteComps10036 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 1, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["10036"]) and arg_118_1.var_.actorSpriteComps10036 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_118_1.var_.actorSpriteComps10036 = nil
			end

			local var_121_2 = 0
			local var_121_3 = 1.325

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_4 = arg_118_1:GetWordFromCfg(117041028)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 53 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 53)

				if (53 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 53)) > 0 and var_121_3 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041028", "story_v_out_117041.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041028", "story_v_out_117041.awb") / 1000

					if var_121_8 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_2
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_117041", "117041028", "story_v_out_117041.awb")

						arg_118_1:RecordAudio("117041028", var_121_9)
						arg_118_1:RecordAudio("117041028", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_117041", "117041028", "story_v_out_117041.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_117041", "117041028", "story_v_out_117041.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_10 and arg_118_1.time_ < var_121_2 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play117041029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 117041029
		arg_122_1.duration_ = 9

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play117041030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if arg_122_1.bgs_.ST24a == nil then
				local var_125_0 = Object.Instantiate(arg_122_1.paintGo_)

				var_125_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST24a")
				var_125_0.name = "ST24a"
				var_125_0.transform.parent = arg_122_1.stage_.transform
				var_125_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.bgs_.ST24a = var_125_0
			end

			if 2 < arg_122_1.time_ and arg_122_1.time_ <= 2 + arg_125_0 then
				local var_125_1 = arg_122_1.bgs_.ST24a

				arg_122_1.bgs_.ST24a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_125_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_2 = var_125_1:GetComponent("SpriteRenderer")

				if var_125_2 and var_125_2.sprite then
					local var_125_3 = 2 * (var_125_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_125_1.transform.localScale = Vector3.New(var_125_3 / var_125_2.sprite.bounds.size.y < var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x and var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x or var_125_3 / var_125_2.sprite.bounds.size.y, var_125_3 / var_125_2.sprite.bounds.size.y < var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x and var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x or var_125_3 / var_125_2.sprite.bounds.size.y, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "ST24a" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_4 = 0

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_5 = 2

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_5 then
				local var_125_6 = Color.New(0, 0, 0)

				var_125_6.a = Mathf.Lerp(0, 1, (arg_122_1.time_ - var_125_4) / var_125_5)
				arg_122_1.mask_.color = var_125_6
			end

			if arg_122_1.time_ >= var_125_4 + var_125_5 and arg_122_1.time_ < var_125_4 + var_125_5 + arg_125_0 then
				local var_125_7 = Color.New(0, 0, 0)

				var_125_7.a = 1
				arg_122_1.mask_.color = var_125_7
			end

			local var_125_8 = 2

			if 2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_9 = 2

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_9 then
				local var_125_10 = Color.New(0, 0, 0)

				var_125_10.a = Mathf.Lerp(1, 0, (arg_122_1.time_ - var_125_8) / var_125_9)
				arg_122_1.mask_.color = var_125_10
			end

			if arg_122_1.time_ >= var_125_8 + var_125_9 and arg_122_1.time_ < var_125_8 + var_125_9 + arg_125_0 then
				local var_125_11 = Color.New(0, 0, 0)

				arg_122_1.mask_.enabled = false
				var_125_11.a = 0
				arg_122_1.mask_.color = var_125_11
			end

			local var_125_12 = arg_122_1.actors_["10036"].transform

			if 2 < arg_122_1.time_ and arg_122_1.time_ <= 2 + arg_125_0 then
				arg_122_1.var_.moveOldPos10036 = var_125_12.localPosition
				var_125_12.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("10036", 7)

				for iter_125_2 = 0, var_125_12.childCount - 1 do
					local var_125_13 = var_125_12:GetChild(iter_125_2)

					if var_125_13.name == "split_1" or not string.find(var_125_13.name, "split") then
						var_125_13.gameObject:SetActive(true)
					else
						var_125_13.gameObject:SetActive(false)
					end
				end
			end

			local var_125_14 = 0.001

			if 2 <= arg_122_1.time_ and arg_122_1.time_ < 2 + var_125_14 then
				var_125_12.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10036, Vector3.New(0, -2000, -290), (arg_122_1.time_ - 2) / var_125_14)
			end

			if arg_122_1.time_ >= 2 + var_125_14 and arg_122_1.time_ < 2 + var_125_14 + arg_125_0 then
				var_125_12.localPosition = Vector3.New(0, -2000, -290)
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_125_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_17 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_17

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_17
						arg_122_1.bgmTxt2_.text = var_125_17
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_18 = 4
			local var_125_19 = 1.425

			if 4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_18 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_20 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_20:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_122_1.dialogCg_.alpha = arg_127_0
				end))
				var_125_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_21 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(117041029).content)

				arg_122_1.text_.text = var_125_21

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_23 = 57 <= 0 and var_125_19 or var_125_19 * (utf8.len(var_125_21) / 57)

				if (57 <= 0 and var_125_19 or var_125_19 * (utf8.len(var_125_21) / 57)) > 0 and var_125_19 < var_125_23 then
					arg_122_1.talkMaxDuration = var_125_23
					var_125_18 = var_125_18 + 0.3

					if var_125_23 + var_125_18 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_23 + var_125_18
					end
				end

				arg_122_1.text_.text = var_125_21
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_24 = var_125_18 + 0.3
			local var_125_25 = math.max(var_125_19, arg_122_1.talkMaxDuration)

			if var_125_18 + 0.3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_24 + var_125_25 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_24) / var_125_25

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_24 + var_125_25 and arg_122_1.time_ < var_125_24 + var_125_25 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play117041030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 117041030
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play117041031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_132_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_2 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_2

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_2
						arg_129_1.bgmTxt2_.text = var_132_2
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_129_1.time_ and arg_129_1.time_ <= 0.3 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_132_5 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_5 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_5

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_5
						arg_129_1.bgmTxt2_.text = var_132_5
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_6 = 0
			local var_132_7 = 0.625

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(117041030).content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 25 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 25)

				if (25 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 25)) > 0 and var_132_7 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_11 and arg_129_1.time_ < var_132_6 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play117041031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 117041031
		arg_135_1.duration_ = 9.07

		local var_135_0 = {
			zh = 7.8,
			ja = 9.066
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play117041032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.actors_["10034"] == nil then
				local var_138_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10034")

				if not isNil(var_138_0) then
					local var_138_1 = Object.Instantiate(var_138_0, arg_135_1.canvasGo_.transform)

					var_138_1.transform:SetSiblingIndex(1)

					var_138_1.name = "10034"
					var_138_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_135_1.actors_["10034"] = var_138_1

					if arg_135_1.isInRecall_ then
						for iter_138_0, iter_138_1 in ipairs((var_138_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_138_1.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_138_2 = arg_135_1.actors_["10034"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10034 = var_138_2.localPosition
				var_138_2.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10034", 3)

				for iter_138_2 = 0, var_138_2.childCount - 1 do
					local var_138_3 = var_138_2:GetChild(iter_138_2)

					if var_138_3.name == "split_3" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10034, Vector3.New(0, -415, -290), (arg_135_1.time_ - 0) / var_138_4)
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(0, -415, -290)
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_5 = arg_135_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_138_5 then
					arg_135_1.var_.alphaOldValue10034 = var_138_5.alpha
					arg_135_1.var_.characterEffect10034 = var_138_5
				end

				arg_135_1.var_.alphaOldValue10034 = 0
			end

			local var_138_6 = 0.333333333333333

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 then
				if arg_135_1.var_.characterEffect10034 then
					arg_135_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_135_1.var_.alphaOldValue10034, 1, (arg_135_1.time_ - 0) / var_138_6)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and arg_135_1.var_.characterEffect10034 then
				arg_135_1.var_.characterEffect10034.alpha = 1
			end

			local var_138_7 = arg_135_1.actors_["10034"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10034 == nil then
				arg_135_1.var_.actorSpriteComps10034 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_8 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_8 and not isNil(var_138_7) then
				if arg_135_1.var_.actorSpriteComps10034 then
					for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_138_4 then
							if arg_135_1.isInRecall_ then
								iter_138_4.color = Color.New(Mathf.Lerp(iter_138_4.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_8), Mathf.Lerp(iter_138_4.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_8), (Mathf.Lerp(iter_138_4.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_8)))
							else
								local var_138_9 = Mathf.Lerp(iter_138_4.color.r, 1, (arg_135_1.time_ - 0) / var_138_8)

								iter_138_4.color = Color.New(var_138_9, var_138_9, var_138_9)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_8 and arg_135_1.time_ < 0 + var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10034 then
				for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_138_6 then
						iter_138_6.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10034 = nil
			end

			local var_138_10 = 0
			local var_138_11 = 0.775

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:GetWordFromCfg(117041031)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 31 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 31)

				if (31 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 31)) > 0 and var_138_11 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041031", "story_v_out_117041.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041031", "story_v_out_117041.awb") / 1000

					if var_138_16 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_10
					end

					if var_138_12.prefab_name ~= "" and arg_135_1.actors_[var_138_12.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_12.prefab_name].transform, "story_v_out_117041", "117041031", "story_v_out_117041.awb")

						arg_135_1:RecordAudio("117041031", var_138_17)
						arg_135_1:RecordAudio("117041031", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_117041", "117041031", "story_v_out_117041.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_117041", "117041031", "story_v_out_117041.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_18 and arg_135_1.time_ < var_138_10 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play117041032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 117041032
		arg_139_1.duration_ = 12.27

		local var_139_0 = {
			zh = 12.266,
			ja = 12
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play117041033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.325

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(117041032)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 53 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 53)

				if (53 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 53)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041032", "story_v_out_117041.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041032", "story_v_out_117041.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_117041", "117041032", "story_v_out_117041.awb")

						arg_139_1:RecordAudio("117041032", var_142_6)
						arg_139_1:RecordAudio("117041032", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_117041", "117041032", "story_v_out_117041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_117041", "117041032", "story_v_out_117041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play117041033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 117041033
		arg_143_1.duration_ = 4.97

		local var_143_0 = {
			zh = 4.333,
			ja = 4.966
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play117041034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.35

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(117041033)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 14 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 14)

				if (14 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 14)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041033", "story_v_out_117041.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041033", "story_v_out_117041.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_117041", "117041033", "story_v_out_117041.awb")

						arg_143_1:RecordAudio("117041033", var_146_6)
						arg_143_1:RecordAudio("117041033", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_117041", "117041033", "story_v_out_117041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_117041", "117041033", "story_v_out_117041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play117041034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 117041034
		arg_147_1.duration_ = 7.17

		local var_147_0 = {
			zh = 4.833,
			ja = 7.166
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play117041035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10034 = arg_147_1.actors_["10034"].transform.localPosition
				arg_147_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10034", 2)

				for iter_150_0 = 0, arg_147_1.actors_["10034"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["10034"].transform:GetChild(iter_150_0)

					if var_150_0.name == "split_3" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_150_2 = "10035"

			if arg_147_1.actors_["10035"] == nil then
				local var_150_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10035")

				if not isNil(var_150_3) then
					local var_150_4 = Object.Instantiate(var_150_3, arg_147_1.canvasGo_.transform)

					var_150_4.transform:SetSiblingIndex(1)

					var_150_4.name = var_150_2
					var_150_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_147_1.actors_[var_150_2] = var_150_4

					if arg_147_1.isInRecall_ then
						for iter_150_1, iter_150_2 in ipairs((var_150_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_150_2.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_150_5 = arg_147_1.actors_["10035"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10035 = var_150_5.localPosition
				var_150_5.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10035", 4)

				for iter_150_3 = 0, var_150_5.childCount - 1 do
					local var_150_6 = var_150_5:GetChild(iter_150_3)

					if var_150_6.name == "split_1" or not string.find(var_150_6.name, "split") then
						var_150_6.gameObject:SetActive(true)
					else
						var_150_6.gameObject:SetActive(false)
					end
				end
			end

			local var_150_7 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				var_150_5.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_147_1.time_ - 0) / var_150_7)
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				var_150_5.localPosition = Vector3.New(390, -410, -235)
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				local var_150_8 = arg_147_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_150_8 then
					arg_147_1.var_.alphaOldValue10035 = var_150_8.alpha
					arg_147_1.var_.characterEffect10035 = var_150_8
				end

				arg_147_1.var_.alphaOldValue10035 = 0
			end

			local var_150_9 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_9 then
				if arg_147_1.var_.characterEffect10035 then
					arg_147_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_147_1.var_.alphaOldValue10035, 1, (arg_147_1.time_ - 0) / var_150_9)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_9 and arg_147_1.time_ < 0 + var_150_9 + arg_150_0 and arg_147_1.var_.characterEffect10035 then
				arg_147_1.var_.characterEffect10035.alpha = 1
			end

			local var_150_10 = arg_147_1.actors_["10034"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_10) and arg_147_1.var_.actorSpriteComps10034 == nil then
				arg_147_1.var_.actorSpriteComps10034 = var_150_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_11 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_11 and not isNil(var_150_10) then
				if arg_147_1.var_.actorSpriteComps10034 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								iter_150_5.color = Color.New(Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_11), Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_11), (Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_11)))
							else
								local var_150_12 = Mathf.Lerp(iter_150_5.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_11)

								iter_150_5.color = Color.New(var_150_12, var_150_12, var_150_12)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_11 and arg_147_1.time_ < 0 + var_150_11 + arg_150_0 and not isNil(var_150_10) and arg_147_1.var_.actorSpriteComps10034 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_150_7 then
						iter_150_7.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10034 = nil
			end

			local var_150_13 = arg_147_1.actors_["10035"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.actorSpriteComps10035 == nil then
				arg_147_1.var_.actorSpriteComps10035 = var_150_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_14 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_14 and not isNil(var_150_13) then
				if arg_147_1.var_.actorSpriteComps10035 then
					for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_150_9 then
							if arg_147_1.isInRecall_ then
								iter_150_9.color = Color.New(Mathf.Lerp(iter_150_9.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_14), Mathf.Lerp(iter_150_9.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_14), (Mathf.Lerp(iter_150_9.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_14)))
							else
								local var_150_15 = Mathf.Lerp(iter_150_9.color.r, 1, (arg_147_1.time_ - 0) / var_150_14)

								iter_150_9.color = Color.New(var_150_15, var_150_15, var_150_15)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_14 and arg_147_1.time_ < 0 + var_150_14 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.actorSpriteComps10035 then
				for iter_150_10, iter_150_11 in pairs(arg_147_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_150_11 then
						iter_150_11.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10035 = nil
			end

			local var_150_16 = 0
			local var_150_17 = 0.4

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(117041034)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_21 = 16 <= 0 and var_150_17 or var_150_17 * (utf8.len(var_150_19) / 16)

				if (16 <= 0 and var_150_17 or var_150_17 * (utf8.len(var_150_19) / 16)) > 0 and var_150_17 < var_150_21 then
					arg_147_1.talkMaxDuration = var_150_21

					if var_150_21 + var_150_16 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_21 + var_150_16
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041034", "story_v_out_117041.awb") ~= 0 then
					local var_150_22 = manager.audio:GetVoiceLength("story_v_out_117041", "117041034", "story_v_out_117041.awb") / 1000

					if var_150_22 + var_150_16 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_16
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_117041", "117041034", "story_v_out_117041.awb")

						arg_147_1:RecordAudio("117041034", var_150_23)
						arg_147_1:RecordAudio("117041034", var_150_23)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_117041", "117041034", "story_v_out_117041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_117041", "117041034", "story_v_out_117041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_24 = math.max(var_150_17, arg_147_1.talkMaxDuration)

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_24 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_16) / var_150_24

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_16 + var_150_24 and arg_147_1.time_ < var_150_16 + var_150_24 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play117041035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 117041035
		arg_151_1.duration_ = 14.3

		local var_151_0 = {
			zh = 10.7,
			ja = 14.3
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play117041036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10034"]) and arg_151_1.var_.actorSpriteComps10034 == nil then
				arg_151_1.var_.actorSpriteComps10034 = arg_151_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10034"]) then
				if arg_151_1.var_.actorSpriteComps10034 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10034"]) and arg_151_1.var_.actorSpriteComps10034 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10034 = nil
			end

			local var_154_2 = arg_151_1.actors_["10035"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10035 == nil then
				arg_151_1.var_.actorSpriteComps10035 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps10035 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								iter_154_5.color = Color.New(Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_5.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_5.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10035 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10035 = nil
			end

			local var_154_5 = 0
			local var_154_6 = 0.925

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(117041035)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 37 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 37)

				if (37 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 37)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041035", "story_v_out_117041.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041035", "story_v_out_117041.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_117041", "117041035", "story_v_out_117041.awb")

						arg_151_1:RecordAudio("117041035", var_154_12)
						arg_151_1:RecordAudio("117041035", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_117041", "117041035", "story_v_out_117041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_117041", "117041035", "story_v_out_117041.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_13 and arg_151_1.time_ < var_154_5 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play117041036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 117041036
		arg_155_1.duration_ = 3.2

		local var_155_0 = {
			zh = 3.2,
			ja = 2.266
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play117041037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10034 = arg_155_1.actors_["10034"].transform.localPosition
				arg_155_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10034", 2)

				for iter_158_0 = 0, arg_155_1.actors_["10034"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10034"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_3" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_158_2 = arg_155_1.actors_["10035"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10035 = var_158_2.localPosition
				var_158_2.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10035", 4)

				for iter_158_1 = 0, var_158_2.childCount - 1 do
					local var_158_3 = var_158_2:GetChild(iter_158_1)

					if var_158_3.name == "split_1" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				var_158_2.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_155_1.time_ - 0) / var_158_4)
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				var_158_2.localPosition = Vector3.New(390, -410, -235)
			end

			local var_158_5 = arg_155_1.actors_["10034"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps10034 == nil then
				arg_155_1.var_.actorSpriteComps10034 = var_158_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_6 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 and not isNil(var_158_5) then
				if arg_155_1.var_.actorSpriteComps10034 then
					for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_158_3 then
							if arg_155_1.isInRecall_ then
								iter_158_3.color = Color.New(Mathf.Lerp(iter_158_3.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_6), Mathf.Lerp(iter_158_3.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_6), (Mathf.Lerp(iter_158_3.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_6)))
							else
								local var_158_7 = Mathf.Lerp(iter_158_3.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_6)

								iter_158_3.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps10034 then
				for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_158_5 then
						iter_158_5.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10034 = nil
			end

			local var_158_8 = arg_155_1.actors_["10035"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps10035 == nil then
				arg_155_1.var_.actorSpriteComps10035 = var_158_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_9 and not isNil(var_158_8) then
				if arg_155_1.var_.actorSpriteComps10035 then
					for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_158_7 then
							if arg_155_1.isInRecall_ then
								iter_158_7.color = Color.New(Mathf.Lerp(iter_158_7.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_9), Mathf.Lerp(iter_158_7.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_9), (Mathf.Lerp(iter_158_7.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_9)))
							else
								local var_158_10 = Mathf.Lerp(iter_158_7.color.r, 1, (arg_155_1.time_ - 0) / var_158_9)

								iter_158_7.color = Color.New(var_158_10, var_158_10, var_158_10)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_9 and arg_155_1.time_ < 0 + var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps10035 then
				for iter_158_8, iter_158_9 in pairs(arg_155_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_158_9 then
						iter_158_9.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10035 = nil
			end

			local var_158_11 = 0
			local var_158_12 = 0.325

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_13 = arg_155_1:GetWordFromCfg(117041036)
				local var_158_14 = arg_155_1:FormatText(var_158_13.content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_16 = 13 <= 0 and var_158_12 or var_158_12 * (utf8.len(var_158_14) / 13)

				if (13 <= 0 and var_158_12 or var_158_12 * (utf8.len(var_158_14) / 13)) > 0 and var_158_12 < var_158_16 then
					arg_155_1.talkMaxDuration = var_158_16

					if var_158_16 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_16 + var_158_11
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041036", "story_v_out_117041.awb") ~= 0 then
					local var_158_17 = manager.audio:GetVoiceLength("story_v_out_117041", "117041036", "story_v_out_117041.awb") / 1000

					if var_158_17 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_11
					end

					if var_158_13.prefab_name ~= "" and arg_155_1.actors_[var_158_13.prefab_name] ~= nil then
						local var_158_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_13.prefab_name].transform, "story_v_out_117041", "117041036", "story_v_out_117041.awb")

						arg_155_1:RecordAudio("117041036", var_158_18)
						arg_155_1:RecordAudio("117041036", var_158_18)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_117041", "117041036", "story_v_out_117041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_117041", "117041036", "story_v_out_117041.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_19 = math.max(var_158_12, arg_155_1.talkMaxDuration)

			if var_158_11 <= arg_155_1.time_ and arg_155_1.time_ < var_158_11 + var_158_19 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_11) / var_158_19

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_11 + var_158_19 and arg_155_1.time_ < var_158_11 + var_158_19 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play117041037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 117041037
		arg_159_1.duration_ = 7.73

		local var_159_0 = {
			zh = 6.133,
			ja = 7.733
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play117041038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.725

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(117041037)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 29 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 29)

				if (29 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 29)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041037", "story_v_out_117041.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041037", "story_v_out_117041.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_117041", "117041037", "story_v_out_117041.awb")

						arg_159_1:RecordAudio("117041037", var_162_6)
						arg_159_1:RecordAudio("117041037", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_117041", "117041037", "story_v_out_117041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_117041", "117041037", "story_v_out_117041.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play117041038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 117041038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play117041039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10035"]) and arg_163_1.var_.actorSpriteComps10035 == nil then
				arg_163_1.var_.actorSpriteComps10035 = arg_163_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10035"]) then
				if arg_163_1.var_.actorSpriteComps10035 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10035"]) and arg_163_1.var_.actorSpriteComps10035 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10035 = nil
			end

			local var_166_2 = 0
			local var_166_3 = 0.45

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(117041038).content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 18 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_4) / 18)

				if (18 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_4) / 18)) > 0 and var_166_3 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_7 and arg_163_1.time_ < var_166_2 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play117041039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 117041039
		arg_167_1.duration_ = 6.23

		local var_167_0 = {
			zh = 6.1,
			ja = 6.233
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play117041040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10034"]) and arg_167_1.var_.actorSpriteComps10034 == nil then
				arg_167_1.var_.actorSpriteComps10034 = arg_167_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10034"]) then
				if arg_167_1.var_.actorSpriteComps10034 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 1, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10034"]) and arg_167_1.var_.actorSpriteComps10034 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10034 = nil
			end

			local var_170_2 = arg_167_1.actors_["10034"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10034 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10034", 2)

				for iter_170_4 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_4)

					if var_170_3.name == "split_2" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_170_5 = 0
			local var_170_6 = 0.675

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(117041039)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 27 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 27)

				if (27 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 27)) > 0 and var_170_6 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041039", "story_v_out_117041.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041039", "story_v_out_117041.awb") / 1000

					if var_170_11 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_5
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_117041", "117041039", "story_v_out_117041.awb")

						arg_167_1:RecordAudio("117041039", var_170_12)
						arg_167_1:RecordAudio("117041039", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_117041", "117041039", "story_v_out_117041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_117041", "117041039", "story_v_out_117041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_13 and arg_167_1.time_ < var_170_5 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play117041040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 117041040
		arg_171_1.duration_ = 4.7

		local var_171_0 = {
			zh = 4.7,
			ja = 2.166
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
				arg_171_0:Play117041041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10034"]) and arg_171_1.var_.actorSpriteComps10034 == nil then
				arg_171_1.var_.actorSpriteComps10034 = arg_171_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10034"]) then
				if arg_171_1.var_.actorSpriteComps10034 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10034"]) and arg_171_1.var_.actorSpriteComps10034 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10034 = nil
			end

			local var_174_2 = arg_171_1.actors_["10035"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10035 == nil then
				arg_171_1.var_.actorSpriteComps10035 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps10035 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								iter_174_5.color = Color.New(Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_5.color.r, 1, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_5.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10035 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10035 = nil
			end

			local var_174_5 = 0
			local var_174_6 = 0.475

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(117041040)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 19 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 19)

				if (19 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 19)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041040", "story_v_out_117041.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041040", "story_v_out_117041.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_117041", "117041040", "story_v_out_117041.awb")

						arg_171_1:RecordAudio("117041040", var_174_12)
						arg_171_1:RecordAudio("117041040", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_117041", "117041040", "story_v_out_117041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_117041", "117041040", "story_v_out_117041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play117041041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 117041041
		arg_175_1.duration_ = 5.87

		local var_175_0 = {
			zh = 5.866,
			ja = 5.466
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play117041042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10034 = arg_175_1.actors_["10034"].transform.localPosition
				arg_175_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10034", 2)

				for iter_178_0 = 0, arg_175_1.actors_["10034"].transform.childCount - 1 do
					local var_178_0 = arg_175_1.actors_["10034"].transform:GetChild(iter_178_0)

					if var_178_0.name == "split_2" or not string.find(var_178_0.name, "split") then
						var_178_0.gameObject:SetActive(true)
					else
						var_178_0.gameObject:SetActive(false)
					end
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_175_1.time_ - 0) / var_178_1)
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_178_2 = arg_175_1.actors_["10035"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10035 == nil then
				arg_175_1.var_.actorSpriteComps10035 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps10035 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								iter_178_2.color = Color.New(Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_2.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_2.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10035 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_178_4 then
						iter_178_4.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10035 = nil
			end

			local var_178_5 = arg_175_1.actors_["10034"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps10034 == nil then
				arg_175_1.var_.actorSpriteComps10034 = var_178_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_6 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.actorSpriteComps10034 then
					for iter_178_5, iter_178_6 in pairs(arg_175_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_178_6 then
							if arg_175_1.isInRecall_ then
								iter_178_6.color = Color.New(Mathf.Lerp(iter_178_6.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_6), Mathf.Lerp(iter_178_6.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_6), (Mathf.Lerp(iter_178_6.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_6)))
							else
								local var_178_7 = Mathf.Lerp(iter_178_6.color.r, 1, (arg_175_1.time_ - 0) / var_178_6)

								iter_178_6.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps10034 then
				for iter_178_7, iter_178_8 in pairs(arg_175_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_178_8 then
						iter_178_8.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10034 = nil
			end

			local var_178_8 = 0
			local var_178_9 = 0.6

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(117041041)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 24 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 24)

				if (24 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 24)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041041", "story_v_out_117041.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041041", "story_v_out_117041.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_117041", "117041041", "story_v_out_117041.awb")

						arg_175_1:RecordAudio("117041041", var_178_15)
						arg_175_1:RecordAudio("117041041", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_117041", "117041041", "story_v_out_117041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_117041", "117041041", "story_v_out_117041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play117041042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 117041042
		arg_179_1.duration_ = 11.5

		local var_179_0 = {
			zh = 11.5,
			ja = 4.2
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play117041043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10034"]) and arg_179_1.var_.actorSpriteComps10034 == nil then
				arg_179_1.var_.actorSpriteComps10034 = arg_179_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10034"]) then
				if arg_179_1.var_.actorSpriteComps10034 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10034"]) and arg_179_1.var_.actorSpriteComps10034 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10034 = nil
			end

			local var_182_2 = arg_179_1.actors_["10035"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10035 = var_182_2.localPosition
				var_182_2.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10035", 4)

				for iter_182_4 = 0, var_182_2.childCount - 1 do
					local var_182_3 = var_182_2:GetChild(iter_182_4)

					if var_182_3.name == "split_4" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_2.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_179_1.time_ - 0) / var_182_4)
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_2.localPosition = Vector3.New(390, -410, -235)
			end

			local var_182_5 = arg_179_1.actors_["10035"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10035 == nil then
				arg_179_1.var_.actorSpriteComps10035 = var_182_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_6 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_6 and not isNil(var_182_5) then
				if arg_179_1.var_.actorSpriteComps10035 then
					for iter_182_5, iter_182_6 in pairs(arg_179_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_182_6 then
							if arg_179_1.isInRecall_ then
								iter_182_6.color = Color.New(Mathf.Lerp(iter_182_6.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_6), Mathf.Lerp(iter_182_6.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_6), (Mathf.Lerp(iter_182_6.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_6)))
							else
								local var_182_7 = Mathf.Lerp(iter_182_6.color.r, 1, (arg_179_1.time_ - 0) / var_182_6)

								iter_182_6.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_6 and arg_179_1.time_ < 0 + var_182_6 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10035 then
				for iter_182_7, iter_182_8 in pairs(arg_179_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_182_8 then
						iter_182_8.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10035 = nil
			end

			local var_182_8 = 0
			local var_182_9 = 1.075

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(117041042)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 42 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 42)

				if (42 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 42)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041042", "story_v_out_117041.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041042", "story_v_out_117041.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_117041", "117041042", "story_v_out_117041.awb")

						arg_179_1:RecordAudio("117041042", var_182_15)
						arg_179_1:RecordAudio("117041042", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_117041", "117041042", "story_v_out_117041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_117041", "117041042", "story_v_out_117041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_16 and arg_179_1.time_ < var_182_8 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play117041043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 117041043
		arg_183_1.duration_ = 5

		local var_183_0 = {
			zh = 5,
			ja = 4.7
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play117041044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10034"]) and arg_183_1.var_.actorSpriteComps10034 == nil then
				arg_183_1.var_.actorSpriteComps10034 = arg_183_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10034"]) then
				if arg_183_1.var_.actorSpriteComps10034 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10034"]) and arg_183_1.var_.actorSpriteComps10034 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10034 = nil
			end

			local var_186_2 = 0
			local var_186_3 = 0.575

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_4 = arg_183_1:GetWordFromCfg(117041043)
				local var_186_5 = arg_183_1:FormatText(var_186_4.content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 23 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 23)

				if (23 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 23)) > 0 and var_186_3 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041043", "story_v_out_117041.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041043", "story_v_out_117041.awb") / 1000

					if var_186_8 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_2
					end

					if var_186_4.prefab_name ~= "" and arg_183_1.actors_[var_186_4.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_4.prefab_name].transform, "story_v_out_117041", "117041043", "story_v_out_117041.awb")

						arg_183_1:RecordAudio("117041043", var_186_9)
						arg_183_1:RecordAudio("117041043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_117041", "117041043", "story_v_out_117041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_117041", "117041043", "story_v_out_117041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_10 and arg_183_1.time_ < var_186_2 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play117041044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 117041044
		arg_187_1.duration_ = 7.07

		local var_187_0 = {
			zh = 4.8,
			ja = 7.066
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
				arg_187_0:Play117041045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10034 = arg_187_1.actors_["10034"].transform.localPosition
				arg_187_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10034", 2)

				for iter_190_0 = 0, arg_187_1.actors_["10034"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["10034"].transform:GetChild(iter_190_0)

					if var_190_0.name == "split_5" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_190_2 = arg_187_1.actors_["10035"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10035 == nil then
				arg_187_1.var_.actorSpriteComps10035 = var_190_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_3 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.actorSpriteComps10035 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								iter_190_2.color = Color.New(Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_3), Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_3), (Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_3)))
							else
								local var_190_4 = Mathf.Lerp(iter_190_2.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_3)

								iter_190_2.color = Color.New(var_190_4, var_190_4, var_190_4)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10035 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_190_4 then
						iter_190_4.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps10035 = nil
			end

			local var_190_5 = arg_187_1.actors_["10034"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.actorSpriteComps10034 == nil then
				arg_187_1.var_.actorSpriteComps10034 = var_190_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_6 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.actorSpriteComps10034 then
					for iter_190_5, iter_190_6 in pairs(arg_187_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_190_6 then
							if arg_187_1.isInRecall_ then
								iter_190_6.color = Color.New(Mathf.Lerp(iter_190_6.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_6), Mathf.Lerp(iter_190_6.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_6), (Mathf.Lerp(iter_190_6.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_6)))
							else
								local var_190_7 = Mathf.Lerp(iter_190_6.color.r, 1, (arg_187_1.time_ - 0) / var_190_6)

								iter_190_6.color = Color.New(var_190_7, var_190_7, var_190_7)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.actorSpriteComps10034 then
				for iter_190_7, iter_190_8 in pairs(arg_187_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_190_8 then
						iter_190_8.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps10034 = nil
			end

			local var_190_8 = 0
			local var_190_9 = 0.525

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(117041044)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 21 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 21)

				if (21 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 21)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041044", "story_v_out_117041.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041044", "story_v_out_117041.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_117041", "117041044", "story_v_out_117041.awb")

						arg_187_1:RecordAudio("117041044", var_190_15)
						arg_187_1:RecordAudio("117041044", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_117041", "117041044", "story_v_out_117041.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_117041", "117041044", "story_v_out_117041.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play117041045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 117041045
		arg_191_1.duration_ = 6.23

		local var_191_0 = {
			zh = 6.233,
			ja = 5.3
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play117041046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10034"]) and arg_191_1.var_.actorSpriteComps10034 == nil then
				arg_191_1.var_.actorSpriteComps10034 = arg_191_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10034"]) then
				if arg_191_1.var_.actorSpriteComps10034 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10034"]) and arg_191_1.var_.actorSpriteComps10034 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps10034 = nil
			end

			local var_194_2 = arg_191_1.actors_["10035"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10035 == nil then
				arg_191_1.var_.actorSpriteComps10035 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps10035 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								iter_194_5.color = Color.New(Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_5.color.r, 1, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_5.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10035 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_194_7 then
						iter_194_7.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10035 = nil
			end

			local var_194_5 = 0
			local var_194_6 = 0.7

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(117041045)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 28 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 28)

				if (28 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 28)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041045", "story_v_out_117041.awb") ~= 0 then
					local var_194_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041045", "story_v_out_117041.awb") / 1000

					if var_194_11 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_5
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_117041", "117041045", "story_v_out_117041.awb")

						arg_191_1:RecordAudio("117041045", var_194_12)
						arg_191_1:RecordAudio("117041045", var_194_12)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_117041", "117041045", "story_v_out_117041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_117041", "117041045", "story_v_out_117041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_13 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_13 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_13

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_13 and arg_191_1.time_ < var_194_5 + var_194_13 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play117041046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 117041046
		arg_195_1.duration_ = 13.67

		local var_195_0 = {
			zh = 9.8,
			ja = 13.666
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
				arg_195_0:Play117041047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10034"]) and arg_195_1.var_.actorSpriteComps10034 == nil then
				arg_195_1.var_.actorSpriteComps10034 = arg_195_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10034"]) then
				if arg_195_1.var_.actorSpriteComps10034 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 1, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10034"]) and arg_195_1.var_.actorSpriteComps10034 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps10034 = nil
			end

			local var_198_2 = arg_195_1.actors_["10035"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10035 == nil then
				arg_195_1.var_.actorSpriteComps10035 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps10035 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								iter_198_5.color = Color.New(Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_5.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_5.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10035 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_198_7 then
						iter_198_7.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps10035 = nil
			end

			local var_198_5 = arg_195_1.actors_["10034"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10034 = var_198_5.localPosition
				var_198_5.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10034", 2)

				for iter_198_8 = 0, var_198_5.childCount - 1 do
					local var_198_6 = var_198_5:GetChild(iter_198_8)

					if var_198_6.name == "split_2" or not string.find(var_198_6.name, "split") then
						var_198_6.gameObject:SetActive(true)
					else
						var_198_6.gameObject:SetActive(false)
					end
				end
			end

			local var_198_7 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_195_1.time_ - 0) / var_198_7)
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_198_8 = 0
			local var_198_9 = 0.95

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_10 = arg_195_1:GetWordFromCfg(117041046)
				local var_198_11 = arg_195_1:FormatText(var_198_10.content)

				arg_195_1.text_.text = var_198_11

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_13 = 38 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 38)

				if (38 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 38)) > 0 and var_198_9 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_11
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041046", "story_v_out_117041.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041046", "story_v_out_117041.awb") / 1000

					if var_198_14 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_8
					end

					if var_198_10.prefab_name ~= "" and arg_195_1.actors_[var_198_10.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_10.prefab_name].transform, "story_v_out_117041", "117041046", "story_v_out_117041.awb")

						arg_195_1:RecordAudio("117041046", var_198_15)
						arg_195_1:RecordAudio("117041046", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_117041", "117041046", "story_v_out_117041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_117041", "117041046", "story_v_out_117041.awb")
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
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play117041047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 117041047
		arg_199_1.duration_ = 2.27

		local var_199_0 = {
			zh = 2,
			ja = 2.266
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
				arg_199_0:Play117041048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10034"]) and arg_199_1.var_.actorSpriteComps10034 == nil then
				arg_199_1.var_.actorSpriteComps10034 = arg_199_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10034"]) then
				if arg_199_1.var_.actorSpriteComps10034 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10034"]) and arg_199_1.var_.actorSpriteComps10034 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10034 = nil
			end

			local var_202_2 = 0
			local var_202_3 = 0.275

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1132_split_2")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_4 = arg_199_1:GetWordFromCfg(117041047)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 11 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 11)

				if (11 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_5) / 11)) > 0 and var_202_3 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041047", "story_v_out_117041.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041047", "story_v_out_117041.awb") / 1000

					if var_202_8 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_2
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_out_117041", "117041047", "story_v_out_117041.awb")

						arg_199_1:RecordAudio("117041047", var_202_9)
						arg_199_1:RecordAudio("117041047", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_117041", "117041047", "story_v_out_117041.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_117041", "117041047", "story_v_out_117041.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_10 and arg_199_1.time_ < var_202_2 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play117041048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 117041048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play117041049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.8

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(117041048).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 32 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 32)

				if (32 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 32)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play117041049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 117041049
		arg_207_1.duration_ = 4.97

		local var_207_0 = {
			zh = 1.533,
			ja = 4.966
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
				arg_207_0:Play117041050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10034 = arg_207_1.actors_["10034"].transform.localPosition
				arg_207_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10034", 2)

				for iter_210_0 = 0, arg_207_1.actors_["10034"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["10034"].transform:GetChild(iter_210_0)

					if var_210_0.name == "split_1" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_210_2 = arg_207_1.actors_["10034"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10034 == nil then
				arg_207_1.var_.actorSpriteComps10034 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps10034 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								iter_210_2.color = Color.New(Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_3), Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_3), (Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_3)))
							else
								local var_210_4 = Mathf.Lerp(iter_210_2.color.r, 1, (arg_207_1.time_ - 0) / var_210_3)

								iter_210_2.color = Color.New(var_210_4, var_210_4, var_210_4)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10034 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_210_4 then
						iter_210_4.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps10034 = nil
			end

			local var_210_5 = 0
			local var_210_6 = 0.15

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:GetWordFromCfg(117041049)
				local var_210_8 = arg_207_1:FormatText(var_210_7.content)

				arg_207_1.text_.text = var_210_8

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_10 = 6 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 6)

				if (6 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 6)) > 0 and var_210_6 < var_210_10 then
					arg_207_1.talkMaxDuration = var_210_10

					if var_210_10 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_5
					end
				end

				arg_207_1.text_.text = var_210_8
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041049", "story_v_out_117041.awb") ~= 0 then
					local var_210_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041049", "story_v_out_117041.awb") / 1000

					if var_210_11 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_5
					end

					if var_210_7.prefab_name ~= "" and arg_207_1.actors_[var_210_7.prefab_name] ~= nil then
						local var_210_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_7.prefab_name].transform, "story_v_out_117041", "117041049", "story_v_out_117041.awb")

						arg_207_1:RecordAudio("117041049", var_210_12)
						arg_207_1:RecordAudio("117041049", var_210_12)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_117041", "117041049", "story_v_out_117041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_117041", "117041049", "story_v_out_117041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_13 = math.max(var_210_6, arg_207_1.talkMaxDuration)

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_5) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_5 + var_210_13 and arg_207_1.time_ < var_210_5 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play117041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 117041050
		arg_211_1.duration_ = 1.83

		local var_211_0 = {
			zh = 1.833,
			ja = 1.3
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
				arg_211_0:Play117041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10034"]) and arg_211_1.var_.actorSpriteComps10034 == nil then
				arg_211_1.var_.actorSpriteComps10034 = arg_211_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10034"]) then
				if arg_211_1.var_.actorSpriteComps10034 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10034"]) and arg_211_1.var_.actorSpriteComps10034 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps10034 = nil
			end

			local var_214_2 = arg_211_1.actors_["10035"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10035 = var_214_2.localPosition
				var_214_2.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10035", 4)

				for iter_214_4 = 0, var_214_2.childCount - 1 do
					local var_214_3 = var_214_2:GetChild(iter_214_4)

					if var_214_3.name == "split_5" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_2.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_211_1.time_ - 0) / var_214_4)
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_2.localPosition = Vector3.New(390, -410, -235)
			end

			local var_214_5 = arg_211_1.actors_["10035"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.actorSpriteComps10035 == nil then
				arg_211_1.var_.actorSpriteComps10035 = var_214_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_6 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 and not isNil(var_214_5) then
				if arg_211_1.var_.actorSpriteComps10035 then
					for iter_214_5, iter_214_6 in pairs(arg_211_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_214_6 then
							if arg_211_1.isInRecall_ then
								iter_214_6.color = Color.New(Mathf.Lerp(iter_214_6.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_6), Mathf.Lerp(iter_214_6.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_6), (Mathf.Lerp(iter_214_6.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_6)))
							else
								local var_214_7 = Mathf.Lerp(iter_214_6.color.r, 1, (arg_211_1.time_ - 0) / var_214_6)

								iter_214_6.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.actorSpriteComps10035 then
				for iter_214_7, iter_214_8 in pairs(arg_211_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_214_8 then
						iter_214_8.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps10035 = nil
			end

			local var_214_8 = 0
			local var_214_9 = 0.15

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_10 = arg_211_1:GetWordFromCfg(117041050)
				local var_214_11 = arg_211_1:FormatText(var_214_10.content)

				arg_211_1.text_.text = var_214_11

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 6 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 6)

				if (6 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 6)) > 0 and var_214_9 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_11
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041050", "story_v_out_117041.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041050", "story_v_out_117041.awb") / 1000

					if var_214_14 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_8
					end

					if var_214_10.prefab_name ~= "" and arg_211_1.actors_[var_214_10.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_10.prefab_name].transform, "story_v_out_117041", "117041050", "story_v_out_117041.awb")

						arg_211_1:RecordAudio("117041050", var_214_15)
						arg_211_1:RecordAudio("117041050", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_117041", "117041050", "story_v_out_117041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_117041", "117041050", "story_v_out_117041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_16 and arg_211_1.time_ < var_214_8 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play117041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 117041051
		arg_215_1.duration_ = 5.5

		local var_215_0 = {
			zh = 5.5,
			ja = 4.466
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
				arg_215_0:Play117041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if arg_215_1.actors_["1132"] == nil then
				local var_218_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

				if not isNil(var_218_0) then
					local var_218_1 = Object.Instantiate(var_218_0, arg_215_1.canvasGo_.transform)

					var_218_1.transform:SetSiblingIndex(1)

					var_218_1.name = "1132"
					var_218_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_215_1.actors_["1132"] = var_218_1

					if arg_215_1.isInRecall_ then
						for iter_218_0, iter_218_1 in ipairs((var_218_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_218_1.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_218_2 = arg_215_1.actors_["1132"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1132 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1132", 3)

				for iter_218_2 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_2)

					if var_218_3.name == "split_2" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1132, Vector3.New(0, -413, -185), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(0, -413, -185)
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_5 = arg_215_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_5 then
					arg_215_1.var_.alphaOldValue1132 = var_218_5.alpha
					arg_215_1.var_.characterEffect1132 = var_218_5
				end

				arg_215_1.var_.alphaOldValue1132 = 0
			end

			local var_218_6 = 0.333333333333333

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 then
				if arg_215_1.var_.characterEffect1132 then
					arg_215_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_215_1.var_.alphaOldValue1132, 1, (arg_215_1.time_ - 0) / var_218_6)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 and arg_215_1.var_.characterEffect1132 then
				arg_215_1.var_.characterEffect1132.alpha = 1
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_7 = arg_215_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_7 then
					arg_215_1.var_.alphaOldValue10035 = var_218_7.alpha
					arg_215_1.var_.characterEffect10035 = var_218_7
				end

				arg_215_1.var_.alphaOldValue10035 = 1
			end

			local var_218_8 = 0.333333333333333

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_8 then
				if arg_215_1.var_.characterEffect10035 then
					arg_215_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_215_1.var_.alphaOldValue10035, 0, (arg_215_1.time_ - 0) / var_218_8)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_8 and arg_215_1.time_ < 0 + var_218_8 + arg_218_0 and arg_215_1.var_.characterEffect10035 then
				arg_215_1.var_.characterEffect10035.alpha = 0
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_9 = arg_215_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_9 then
					arg_215_1.var_.alphaOldValue10034 = var_218_9.alpha
					arg_215_1.var_.characterEffect10034 = var_218_9
				end

				arg_215_1.var_.alphaOldValue10034 = 1
			end

			local var_218_10 = 0.333333333333333

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_10 then
				if arg_215_1.var_.characterEffect10034 then
					arg_215_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_215_1.var_.alphaOldValue10034, 0, (arg_215_1.time_ - 0) / var_218_10)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_10 and arg_215_1.time_ < 0 + var_218_10 + arg_218_0 and arg_215_1.var_.characterEffect10034 then
				arg_215_1.var_.characterEffect10034.alpha = 0
			end

			local var_218_11 = arg_215_1.actors_["1132"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_11) and arg_215_1.var_.actorSpriteComps1132 == nil then
				arg_215_1.var_.actorSpriteComps1132 = var_218_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_12 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_12 and not isNil(var_218_11) then
				if arg_215_1.var_.actorSpriteComps1132 then
					for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_218_4 then
							if arg_215_1.isInRecall_ then
								iter_218_4.color = Color.New(Mathf.Lerp(iter_218_4.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_12), Mathf.Lerp(iter_218_4.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_12), (Mathf.Lerp(iter_218_4.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_12)))
							else
								local var_218_13 = Mathf.Lerp(iter_218_4.color.r, 1, (arg_215_1.time_ - 0) / var_218_12)

								iter_218_4.color = Color.New(var_218_13, var_218_13, var_218_13)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_12 and arg_215_1.time_ < 0 + var_218_12 + arg_218_0 and not isNil(var_218_11) and arg_215_1.var_.actorSpriteComps1132 then
				for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_218_6 then
						iter_218_6.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps1132 = nil
			end

			local var_218_14 = 0
			local var_218_15 = 0.65

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_16 = arg_215_1:GetWordFromCfg(117041051)
				local var_218_17 = arg_215_1:FormatText(var_218_16.content)

				arg_215_1.text_.text = var_218_17

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_19 = 26 <= 0 and var_218_15 or var_218_15 * (utf8.len(var_218_17) / 26)

				if (26 <= 0 and var_218_15 or var_218_15 * (utf8.len(var_218_17) / 26)) > 0 and var_218_15 < var_218_19 then
					arg_215_1.talkMaxDuration = var_218_19

					if var_218_19 + var_218_14 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_19 + var_218_14
					end
				end

				arg_215_1.text_.text = var_218_17
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041051", "story_v_out_117041.awb") ~= 0 then
					local var_218_20 = manager.audio:GetVoiceLength("story_v_out_117041", "117041051", "story_v_out_117041.awb") / 1000

					if var_218_20 + var_218_14 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_20 + var_218_14
					end

					if var_218_16.prefab_name ~= "" and arg_215_1.actors_[var_218_16.prefab_name] ~= nil then
						local var_218_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_16.prefab_name].transform, "story_v_out_117041", "117041051", "story_v_out_117041.awb")

						arg_215_1:RecordAudio("117041051", var_218_21)
						arg_215_1:RecordAudio("117041051", var_218_21)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_117041", "117041051", "story_v_out_117041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_117041", "117041051", "story_v_out_117041.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = math.max(var_218_15, arg_215_1.talkMaxDuration)

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_22 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_14) / var_218_22

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_14 + var_218_22 and arg_215_1.time_ < var_218_14 + var_218_22 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play117041052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 117041052
		arg_219_1.duration_ = 2.2

		local var_219_0 = {
			zh = 2.2,
			ja = 1.9
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
				arg_219_0:Play117041053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1132"]) and arg_219_1.var_.actorSpriteComps1132 == nil then
				arg_219_1.var_.actorSpriteComps1132 = arg_219_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1132"]) then
				if arg_219_1.var_.actorSpriteComps1132 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								iter_222_1.color = Color.New(Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor2.r, (arg_219_1.time_ - 0) / var_222_0), Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor2.g, (arg_219_1.time_ - 0) / var_222_0), (Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor2.b, (arg_219_1.time_ - 0) / var_222_0)))
							else
								local var_222_1 = Mathf.Lerp(iter_222_1.color.r, 0.5, (arg_219_1.time_ - 0) / var_222_0)

								iter_222_1.color = Color.New(var_222_1, var_222_1, var_222_1)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1132"]) and arg_219_1.var_.actorSpriteComps1132 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_222_3 then
						iter_222_3.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_219_1.var_.actorSpriteComps1132 = nil
			end

			local var_222_2 = 0
			local var_222_3 = 0.2

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_4")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_4 = arg_219_1:GetWordFromCfg(117041052)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 8 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 8)

				if (8 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 8)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041052", "story_v_out_117041.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041052", "story_v_out_117041.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_117041", "117041052", "story_v_out_117041.awb")

						arg_219_1:RecordAudio("117041052", var_222_9)
						arg_219_1:RecordAudio("117041052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_117041", "117041052", "story_v_out_117041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_117041", "117041052", "story_v_out_117041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play117041053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 117041053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play117041054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				local var_226_0 = arg_223_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_226_0 then
					arg_223_1.var_.alphaOldValue1132 = var_226_0.alpha
					arg_223_1.var_.characterEffect1132 = var_226_0
				end

				arg_223_1.var_.alphaOldValue1132 = 1
			end

			local var_226_1 = 0.333333333333333

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				if arg_223_1.var_.characterEffect1132 then
					arg_223_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_223_1.var_.alphaOldValue1132, 0, (arg_223_1.time_ - 0) / var_226_1)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 and arg_223_1.var_.characterEffect1132 then
				arg_223_1.var_.characterEffect1132.alpha = 0
			end

			local var_226_2 = 0
			local var_226_3 = 0.675

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_4 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(117041053).content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 27 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 27)

				if (27 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 27)) > 0 and var_226_3 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_7 and arg_223_1.time_ < var_226_2 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play117041054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 117041054
		arg_227_1.duration_ = 13.6

		local var_227_0 = {
			zh = 12.1,
			ja = 13.6
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
				arg_227_0:Play117041055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				local var_230_0 = arg_227_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_0 then
					arg_227_1.var_.alphaOldValue10034 = var_230_0.alpha
					arg_227_1.var_.characterEffect10034 = var_230_0
				end

				arg_227_1.var_.alphaOldValue10034 = 0
			end

			local var_230_1 = 0.333333333333333

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				if arg_227_1.var_.characterEffect10034 then
					arg_227_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_227_1.var_.alphaOldValue10034, 1, (arg_227_1.time_ - 0) / var_230_1)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 and arg_227_1.var_.characterEffect10034 then
				arg_227_1.var_.characterEffect10034.alpha = 1
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				local var_230_2 = arg_227_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_2 then
					arg_227_1.var_.alphaOldValue10035 = var_230_2.alpha
					arg_227_1.var_.characterEffect10035 = var_230_2
				end

				arg_227_1.var_.alphaOldValue10035 = 0
			end

			local var_230_3 = 0.333333333333333

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 then
				if arg_227_1.var_.characterEffect10035 then
					arg_227_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_227_1.var_.alphaOldValue10035, 1, (arg_227_1.time_ - 0) / var_230_3)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and arg_227_1.var_.characterEffect10035 then
				arg_227_1.var_.characterEffect10035.alpha = 1
			end

			local var_230_4 = arg_227_1.actors_["10035"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10035 = var_230_4.localPosition
				var_230_4.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10035", 4)

				for iter_230_0 = 0, var_230_4.childCount - 1 do
					local var_230_5 = var_230_4:GetChild(iter_230_0)

					if var_230_5.name == "split_1" or not string.find(var_230_5.name, "split") then
						var_230_5.gameObject:SetActive(true)
					else
						var_230_5.gameObject:SetActive(false)
					end
				end
			end

			local var_230_6 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 then
				var_230_4.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_227_1.time_ - 0) / var_230_6)
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 then
				var_230_4.localPosition = Vector3.New(390, -410, -235)
			end

			local var_230_7 = arg_227_1.actors_["10034"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps10034 == nil then
				arg_227_1.var_.actorSpriteComps10034 = var_230_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_8 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_8 and not isNil(var_230_7) then
				if arg_227_1.var_.actorSpriteComps10034 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								iter_230_2.color = Color.New(Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_8), Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_8), (Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_8)))
							else
								local var_230_9 = Mathf.Lerp(iter_230_2.color.r, 1, (arg_227_1.time_ - 0) / var_230_8)

								iter_230_2.color = Color.New(var_230_9, var_230_9, var_230_9)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_8 and arg_227_1.time_ < 0 + var_230_8 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps10034 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_230_4 then
						iter_230_4.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps10034 = nil
			end

			local var_230_10 = 0
			local var_230_11 = 1.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_12 = arg_227_1:GetWordFromCfg(117041054)
				local var_230_13 = arg_227_1:FormatText(var_230_12.content)

				arg_227_1.text_.text = var_230_13

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_15 = 45 <= 0 and var_230_11 or var_230_11 * (utf8.len(var_230_13) / 45)

				if (45 <= 0 and var_230_11 or var_230_11 * (utf8.len(var_230_13) / 45)) > 0 and var_230_11 < var_230_15 then
					arg_227_1.talkMaxDuration = var_230_15

					if var_230_15 + var_230_10 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_15 + var_230_10
					end
				end

				arg_227_1.text_.text = var_230_13
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041054", "story_v_out_117041.awb") ~= 0 then
					local var_230_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041054", "story_v_out_117041.awb") / 1000

					if var_230_16 + var_230_10 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_10
					end

					if var_230_12.prefab_name ~= "" and arg_227_1.actors_[var_230_12.prefab_name] ~= nil then
						local var_230_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_12.prefab_name].transform, "story_v_out_117041", "117041054", "story_v_out_117041.awb")

						arg_227_1:RecordAudio("117041054", var_230_17)
						arg_227_1:RecordAudio("117041054", var_230_17)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_117041", "117041054", "story_v_out_117041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_117041", "117041054", "story_v_out_117041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = math.max(var_230_11, arg_227_1.talkMaxDuration)

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_18 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_10) / var_230_18

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_10 + var_230_18 and arg_227_1.time_ < var_230_10 + var_230_18 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play117041055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 117041055
		arg_231_1.duration_ = 6.97

		local var_231_0 = {
			zh = 6.766,
			ja = 6.966
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
				arg_231_0:Play117041056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10035"]) and arg_231_1.var_.actorSpriteComps10035 == nil then
				arg_231_1.var_.actorSpriteComps10035 = arg_231_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10035"]) then
				if arg_231_1.var_.actorSpriteComps10035 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 1, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10035"]) and arg_231_1.var_.actorSpriteComps10035 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps10035 = nil
			end

			local var_234_2 = arg_231_1.actors_["10034"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10034 == nil then
				arg_231_1.var_.actorSpriteComps10034 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps10034 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								iter_234_5.color = Color.New(Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_5.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_5.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10034 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_234_7 then
						iter_234_7.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps10034 = nil
			end

			local var_234_5 = 0
			local var_234_6 = 0.775

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(117041055)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 31 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 31)

				if (31 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 31)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041055", "story_v_out_117041.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041055", "story_v_out_117041.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_117041", "117041055", "story_v_out_117041.awb")

						arg_231_1:RecordAudio("117041055", var_234_12)
						arg_231_1:RecordAudio("117041055", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_117041", "117041055", "story_v_out_117041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_117041", "117041055", "story_v_out_117041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_13 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_13 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_13

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_13 and arg_231_1.time_ < var_234_5 + var_234_13 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play117041056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 117041056
		arg_235_1.duration_ = 7.17

		local var_235_0 = {
			zh = 7.166,
			ja = 6.266
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
				arg_235_0:Play117041057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10035"]) and arg_235_1.var_.actorSpriteComps10035 == nil then
				arg_235_1.var_.actorSpriteComps10035 = arg_235_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10035"]) then
				if arg_235_1.var_.actorSpriteComps10035 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10035"]) and arg_235_1.var_.actorSpriteComps10035 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps10035 = nil
			end

			local var_238_2 = 0
			local var_238_3 = 0.95

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1132_split_6")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_4 = arg_235_1:GetWordFromCfg(117041056)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 38 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 38)

				if (38 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 38)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041056", "story_v_out_117041.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041056", "story_v_out_117041.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_117041", "117041056", "story_v_out_117041.awb")

						arg_235_1:RecordAudio("117041056", var_238_9)
						arg_235_1:RecordAudio("117041056", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_117041", "117041056", "story_v_out_117041.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_117041", "117041056", "story_v_out_117041.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play117041057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 117041057
		arg_239_1.duration_ = 3.4

		local var_239_0 = {
			zh = 3.066,
			ja = 3.4
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play117041058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10035 = arg_239_1.actors_["10035"].transform.localPosition
				arg_239_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10035", 4)

				for iter_242_0 = 0, arg_239_1.actors_["10035"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["10035"].transform:GetChild(iter_242_0)

					if var_242_0.name == "split_4" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_242_2 = arg_239_1.actors_["10035"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10035 == nil then
				arg_239_1.var_.actorSpriteComps10035 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps10035 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 1, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10035 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps10035 = nil
			end

			local var_242_5 = 0
			local var_242_6 = 0.4

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_7 = arg_239_1:GetWordFromCfg(117041057)
				local var_242_8 = arg_239_1:FormatText(var_242_7.content)

				arg_239_1.text_.text = var_242_8

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_10 = 16 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 16)

				if (16 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 16)) > 0 and var_242_6 < var_242_10 then
					arg_239_1.talkMaxDuration = var_242_10

					if var_242_10 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_5
					end
				end

				arg_239_1.text_.text = var_242_8
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041057", "story_v_out_117041.awb") ~= 0 then
					local var_242_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041057", "story_v_out_117041.awb") / 1000

					if var_242_11 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_5
					end

					if var_242_7.prefab_name ~= "" and arg_239_1.actors_[var_242_7.prefab_name] ~= nil then
						local var_242_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_7.prefab_name].transform, "story_v_out_117041", "117041057", "story_v_out_117041.awb")

						arg_239_1:RecordAudio("117041057", var_242_12)
						arg_239_1:RecordAudio("117041057", var_242_12)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_117041", "117041057", "story_v_out_117041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_117041", "117041057", "story_v_out_117041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_13 = math.max(var_242_6, arg_239_1.talkMaxDuration)

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_13 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_5) / var_242_13

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_5 + var_242_13 and arg_239_1.time_ < var_242_5 + var_242_13 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play117041058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 117041058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play117041059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10035"]) and arg_243_1.var_.actorSpriteComps10035 == nil then
				arg_243_1.var_.actorSpriteComps10035 = arg_243_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10035"]) then
				if arg_243_1.var_.actorSpriteComps10035 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10035"]) and arg_243_1.var_.actorSpriteComps10035 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps10035 = nil
			end

			local var_246_2 = 0
			local var_246_3 = 0.775

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(117041058).content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 31 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 31)

				if (31 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 31)) > 0 and var_246_3 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_7 and arg_243_1.time_ < var_246_2 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play117041059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 117041059
		arg_247_1.duration_ = 9.8

		local var_247_0 = {
			zh = 9.8,
			ja = 7.4
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
				arg_247_0:Play117041060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10034"]) and arg_247_1.var_.actorSpriteComps10034 == nil then
				arg_247_1.var_.actorSpriteComps10034 = arg_247_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10034"]) then
				if arg_247_1.var_.actorSpriteComps10034 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 1, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10034"]) and arg_247_1.var_.actorSpriteComps10034 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10034 = nil
			end

			local var_250_2 = 0
			local var_250_3 = 0.85

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(117041059)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 34 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 34)

				if (34 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 34)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041059", "story_v_out_117041.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041059", "story_v_out_117041.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_117041", "117041059", "story_v_out_117041.awb")

						arg_247_1:RecordAudio("117041059", var_250_9)
						arg_247_1:RecordAudio("117041059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_117041", "117041059", "story_v_out_117041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_117041", "117041059", "story_v_out_117041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play117041060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 117041060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play117041061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				local var_254_0 = arg_251_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_0 then
					arg_251_1.var_.alphaOldValue10035 = var_254_0.alpha
					arg_251_1.var_.characterEffect10035 = var_254_0
				end

				arg_251_1.var_.alphaOldValue10035 = 1
			end

			local var_254_1 = 0.333333333333333

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				if arg_251_1.var_.characterEffect10035 then
					arg_251_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_251_1.var_.alphaOldValue10035, 0, (arg_251_1.time_ - 0) / var_254_1)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 and arg_251_1.var_.characterEffect10035 then
				arg_251_1.var_.characterEffect10035.alpha = 0
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				local var_254_2 = arg_251_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_2 then
					arg_251_1.var_.alphaOldValue10034 = var_254_2.alpha
					arg_251_1.var_.characterEffect10034 = var_254_2
				end

				arg_251_1.var_.alphaOldValue10034 = 1
			end

			local var_254_3 = 0.333333333333333

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 then
				if arg_251_1.var_.characterEffect10034 then
					arg_251_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_251_1.var_.alphaOldValue10034, 0, (arg_251_1.time_ - 0) / var_254_3)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and arg_251_1.var_.characterEffect10034 then
				arg_251_1.var_.characterEffect10034.alpha = 0
			end

			local var_254_4 = 0
			local var_254_5 = 0.975

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(117041060).content)

				arg_251_1.text_.text = var_254_6

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_8 = 39 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_6) / 39)

				if (39 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_6) / 39)) > 0 and var_254_5 < var_254_8 then
					arg_251_1.talkMaxDuration = var_254_8

					if var_254_8 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_6
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_9 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_9 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_9

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_9 and arg_251_1.time_ < var_254_4 + var_254_9 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play117041061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 117041061
		arg_255_1.duration_ = 6.7

		local var_255_0 = {
			zh = 3.966,
			ja = 6.7
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
				arg_255_0:Play117041062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				local var_258_0 = arg_255_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_258_0 then
					arg_255_1.var_.alphaOldValue1132 = var_258_0.alpha
					arg_255_1.var_.characterEffect1132 = var_258_0
				end

				arg_255_1.var_.alphaOldValue1132 = 0
			end

			local var_258_1 = 0.333333333333333

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 then
				if arg_255_1.var_.characterEffect1132 then
					arg_255_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_255_1.var_.alphaOldValue1132, 1, (arg_255_1.time_ - 0) / var_258_1)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 and arg_255_1.var_.characterEffect1132 then
				arg_255_1.var_.characterEffect1132.alpha = 1
			end

			local var_258_2 = arg_255_1.actors_["1132"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1132 == nil then
				arg_255_1.var_.actorSpriteComps1132 = var_258_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_3 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 and not isNil(var_258_2) then
				if arg_255_1.var_.actorSpriteComps1132 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_3), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_3), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_3)))
							else
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_4, var_258_4)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1132 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1132 = nil
			end

			local var_258_5 = 0
			local var_258_6 = 0.4

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(117041061)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 16 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 16)

				if (16 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 16)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041061", "story_v_out_117041.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041061", "story_v_out_117041.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_117041", "117041061", "story_v_out_117041.awb")

						arg_255_1:RecordAudio("117041061", var_258_12)
						arg_255_1:RecordAudio("117041061", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_117041", "117041061", "story_v_out_117041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_117041", "117041061", "story_v_out_117041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play117041062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 117041062
		arg_259_1.duration_ = 5.97

		local var_259_0 = {
			zh = 5.2,
			ja = 5.966
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play117041063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1132 = arg_259_1.actors_["1132"].transform.localPosition
				arg_259_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1132", 2)

				for iter_262_0 = 0, arg_259_1.actors_["1132"].transform.childCount - 1 do
					local var_262_0 = arg_259_1.actors_["1132"].transform:GetChild(iter_262_0)

					if var_262_0.name == "split_2" or not string.find(var_262_0.name, "split") then
						var_262_0.gameObject:SetActive(true)
					else
						var_262_0.gameObject:SetActive(false)
					end
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_259_1.time_ - 0) / var_262_1)
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_262_2 = arg_259_1.actors_["10035"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10035 = var_262_2.localPosition
				var_262_2.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10035", 4)

				for iter_262_1 = 0, var_262_2.childCount - 1 do
					local var_262_3 = var_262_2:GetChild(iter_262_1)

					if var_262_3.name == "split_2" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_2.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_259_1.time_ - 0) / var_262_4)
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_2.localPosition = Vector3.New(390, -410, -235)
			end

			local var_262_5 = arg_259_1.actors_["1132"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.actorSpriteComps1132 == nil then
				arg_259_1.var_.actorSpriteComps1132 = var_262_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_6 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_6 and not isNil(var_262_5) then
				if arg_259_1.var_.actorSpriteComps1132 then
					for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_262_3 then
							if arg_259_1.isInRecall_ then
								iter_262_3.color = Color.New(Mathf.Lerp(iter_262_3.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_6), Mathf.Lerp(iter_262_3.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_6), (Mathf.Lerp(iter_262_3.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_6)))
							else
								local var_262_7 = Mathf.Lerp(iter_262_3.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_6)

								iter_262_3.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_6 and arg_259_1.time_ < 0 + var_262_6 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.actorSpriteComps1132 then
				for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_262_5 then
						iter_262_5.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps1132 = nil
			end

			local var_262_8 = arg_259_1.actors_["10035"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10035 == nil then
				arg_259_1.var_.actorSpriteComps10035 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_9 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_9 and not isNil(var_262_8) then
				if arg_259_1.var_.actorSpriteComps10035 then
					for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_262_7 then
							if arg_259_1.isInRecall_ then
								iter_262_7.color = Color.New(Mathf.Lerp(iter_262_7.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_9), Mathf.Lerp(iter_262_7.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_9), (Mathf.Lerp(iter_262_7.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_9)))
							else
								local var_262_10 = Mathf.Lerp(iter_262_7.color.r, 1, (arg_259_1.time_ - 0) / var_262_9)

								iter_262_7.color = Color.New(var_262_10, var_262_10, var_262_10)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_9 and arg_259_1.time_ < 0 + var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps10035 then
				for iter_262_8, iter_262_9 in pairs(arg_259_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_262_9 then
						iter_262_9.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				local var_262_11 = arg_259_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_262_11 then
					arg_259_1.var_.alphaOldValue10035 = var_262_11.alpha
					arg_259_1.var_.characterEffect10035 = var_262_11
				end

				arg_259_1.var_.alphaOldValue10035 = 0
			end

			local var_262_12 = 0.333333333333333

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_12 then
				if arg_259_1.var_.characterEffect10035 then
					arg_259_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_259_1.var_.alphaOldValue10035, 1, (arg_259_1.time_ - 0) / var_262_12)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_12 and arg_259_1.time_ < 0 + var_262_12 + arg_262_0 and arg_259_1.var_.characterEffect10035 then
				arg_259_1.var_.characterEffect10035.alpha = 1
			end

			local var_262_13 = 0
			local var_262_14 = 0.625

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_13 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_15 = arg_259_1:GetWordFromCfg(117041062)
				local var_262_16 = arg_259_1:FormatText(var_262_15.content)

				arg_259_1.text_.text = var_262_16

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_18 = 25 <= 0 and var_262_14 or var_262_14 * (utf8.len(var_262_16) / 25)

				if (25 <= 0 and var_262_14 or var_262_14 * (utf8.len(var_262_16) / 25)) > 0 and var_262_14 < var_262_18 then
					arg_259_1.talkMaxDuration = var_262_18

					if var_262_18 + var_262_13 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_13
					end
				end

				arg_259_1.text_.text = var_262_16
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041062", "story_v_out_117041.awb") ~= 0 then
					local var_262_19 = manager.audio:GetVoiceLength("story_v_out_117041", "117041062", "story_v_out_117041.awb") / 1000

					if var_262_19 + var_262_13 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_19 + var_262_13
					end

					if var_262_15.prefab_name ~= "" and arg_259_1.actors_[var_262_15.prefab_name] ~= nil then
						local var_262_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_15.prefab_name].transform, "story_v_out_117041", "117041062", "story_v_out_117041.awb")

						arg_259_1:RecordAudio("117041062", var_262_20)
						arg_259_1:RecordAudio("117041062", var_262_20)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_117041", "117041062", "story_v_out_117041.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_117041", "117041062", "story_v_out_117041.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_21 = math.max(var_262_14, arg_259_1.talkMaxDuration)

			if var_262_13 <= arg_259_1.time_ and arg_259_1.time_ < var_262_13 + var_262_21 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_13) / var_262_21

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_13 + var_262_21 and arg_259_1.time_ < var_262_13 + var_262_21 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play117041063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 117041063
		arg_263_1.duration_ = 5.13

		local var_263_0 = {
			zh = 5.1,
			ja = 5.133
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
				arg_263_0:Play117041064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.6

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(117041063)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 24 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 24)

				if (24 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 24)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041063", "story_v_out_117041.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041063", "story_v_out_117041.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_117041", "117041063", "story_v_out_117041.awb")

						arg_263_1:RecordAudio("117041063", var_266_6)
						arg_263_1:RecordAudio("117041063", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_117041", "117041063", "story_v_out_117041.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_117041", "117041063", "story_v_out_117041.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play117041064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 117041064
		arg_267_1.duration_ = 4.07

		local var_267_0 = {
			zh = 3.8,
			ja = 4.066
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
				arg_267_0:Play117041065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1132 = arg_267_1.actors_["1132"].transform.localPosition
				arg_267_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1132", 2)

				for iter_270_0 = 0, arg_267_1.actors_["1132"].transform.childCount - 1 do
					local var_270_0 = arg_267_1.actors_["1132"].transform:GetChild(iter_270_0)

					if var_270_0.name == "split_6" or not string.find(var_270_0.name, "split") then
						var_270_0.gameObject:SetActive(true)
					else
						var_270_0.gameObject:SetActive(false)
					end
				end
			end

			local var_270_1 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 then
				arg_267_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_267_1.time_ - 0) / var_270_1)
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 then
				arg_267_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_270_2 = arg_267_1.actors_["1132"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1132 == nil then
				arg_267_1.var_.actorSpriteComps1132 = var_270_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_3 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.actorSpriteComps1132 then
					for iter_270_1, iter_270_2 in pairs(arg_267_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_270_2 then
							if arg_267_1.isInRecall_ then
								iter_270_2.color = Color.New(Mathf.Lerp(iter_270_2.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_3), Mathf.Lerp(iter_270_2.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_3), (Mathf.Lerp(iter_270_2.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_3)))
							else
								local var_270_4 = Mathf.Lerp(iter_270_2.color.r, 1, (arg_267_1.time_ - 0) / var_270_3)

								iter_270_2.color = Color.New(var_270_4, var_270_4, var_270_4)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1132 then
				for iter_270_3, iter_270_4 in pairs(arg_267_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_270_4 then
						iter_270_4.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps1132 = nil
			end

			local var_270_5 = arg_267_1.actors_["10035"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_5) and arg_267_1.var_.actorSpriteComps10035 == nil then
				arg_267_1.var_.actorSpriteComps10035 = var_270_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_6 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_6 and not isNil(var_270_5) then
				if arg_267_1.var_.actorSpriteComps10035 then
					for iter_270_5, iter_270_6 in pairs(arg_267_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_270_6 then
							if arg_267_1.isInRecall_ then
								iter_270_6.color = Color.New(Mathf.Lerp(iter_270_6.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_6), Mathf.Lerp(iter_270_6.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_6), (Mathf.Lerp(iter_270_6.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_6)))
							else
								local var_270_7 = Mathf.Lerp(iter_270_6.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_6)

								iter_270_6.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_6 and arg_267_1.time_ < 0 + var_270_6 + arg_270_0 and not isNil(var_270_5) and arg_267_1.var_.actorSpriteComps10035 then
				for iter_270_7, iter_270_8 in pairs(arg_267_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_270_8 then
						iter_270_8.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				local var_270_8 = arg_267_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_270_8 then
					arg_267_1.var_.alphaOldValue10035 = var_270_8.alpha
					arg_267_1.var_.characterEffect10035 = var_270_8
				end

				arg_267_1.var_.alphaOldValue10035 = 0
			end

			local var_270_9 = 0.0166666666666667

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_9 then
				if arg_267_1.var_.characterEffect10035 then
					arg_267_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_267_1.var_.alphaOldValue10035, 1, (arg_267_1.time_ - 0) / var_270_9)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_9 and arg_267_1.time_ < 0 + var_270_9 + arg_270_0 and arg_267_1.var_.characterEffect10035 then
				arg_267_1.var_.characterEffect10035.alpha = 1
			end

			local var_270_10 = 0
			local var_270_11 = 0.5

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_12 = arg_267_1:GetWordFromCfg(117041064)
				local var_270_13 = arg_267_1:FormatText(var_270_12.content)

				arg_267_1.text_.text = var_270_13

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_15 = 20 <= 0 and var_270_11 or var_270_11 * (utf8.len(var_270_13) / 20)

				if (20 <= 0 and var_270_11 or var_270_11 * (utf8.len(var_270_13) / 20)) > 0 and var_270_11 < var_270_15 then
					arg_267_1.talkMaxDuration = var_270_15

					if var_270_15 + var_270_10 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_15 + var_270_10
					end
				end

				arg_267_1.text_.text = var_270_13
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041064", "story_v_out_117041.awb") ~= 0 then
					local var_270_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041064", "story_v_out_117041.awb") / 1000

					if var_270_16 + var_270_10 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_16 + var_270_10
					end

					if var_270_12.prefab_name ~= "" and arg_267_1.actors_[var_270_12.prefab_name] ~= nil then
						local var_270_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_12.prefab_name].transform, "story_v_out_117041", "117041064", "story_v_out_117041.awb")

						arg_267_1:RecordAudio("117041064", var_270_17)
						arg_267_1:RecordAudio("117041064", var_270_17)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_117041", "117041064", "story_v_out_117041.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_117041", "117041064", "story_v_out_117041.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_18 = math.max(var_270_11, arg_267_1.talkMaxDuration)

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_18 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_10) / var_270_18

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_10 + var_270_18 and arg_267_1.time_ < var_270_10 + var_270_18 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play117041065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 117041065
		arg_271_1.duration_ = 2.83

		local var_271_0 = {
			zh = 1.466,
			ja = 2.833
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
				arg_271_0:Play117041066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10035 = arg_271_1.actors_["10035"].transform.localPosition
				arg_271_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10035", 4)

				for iter_274_0 = 0, arg_271_1.actors_["10035"].transform.childCount - 1 do
					local var_274_0 = arg_271_1.actors_["10035"].transform:GetChild(iter_274_0)

					if var_274_0.name == "split_4" or not string.find(var_274_0.name, "split") then
						var_274_0.gameObject:SetActive(true)
					else
						var_274_0.gameObject:SetActive(false)
					end
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_271_1.time_ - 0) / var_274_1)
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_274_2 = arg_271_1.actors_["1132"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1132 == nil then
				arg_271_1.var_.actorSpriteComps1132 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps1132 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								iter_274_2.color = Color.New(Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 0) / var_274_3), Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 0) / var_274_3), (Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 0) / var_274_3)))
							else
								local var_274_4 = Mathf.Lerp(iter_274_2.color.r, 0.5, (arg_271_1.time_ - 0) / var_274_3)

								iter_274_2.color = Color.New(var_274_4, var_274_4, var_274_4)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1132 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_274_4 then
						iter_274_4.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps1132 = nil
			end

			local var_274_5 = arg_271_1.actors_["10035"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.actorSpriteComps10035 == nil then
				arg_271_1.var_.actorSpriteComps10035 = var_274_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_6 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_6 and not isNil(var_274_5) then
				if arg_271_1.var_.actorSpriteComps10035 then
					for iter_274_5, iter_274_6 in pairs(arg_271_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_274_6 then
							if arg_271_1.isInRecall_ then
								iter_274_6.color = Color.New(Mathf.Lerp(iter_274_6.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 0) / var_274_6), Mathf.Lerp(iter_274_6.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 0) / var_274_6), (Mathf.Lerp(iter_274_6.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 0) / var_274_6)))
							else
								local var_274_7 = Mathf.Lerp(iter_274_6.color.r, 1, (arg_271_1.time_ - 0) / var_274_6)

								iter_274_6.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_6 and arg_271_1.time_ < 0 + var_274_6 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.actorSpriteComps10035 then
				for iter_274_7, iter_274_8 in pairs(arg_271_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_274_8 then
						iter_274_8.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps10035 = nil
			end

			local var_274_8 = 0
			local var_274_9 = 0.075

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:GetWordFromCfg(117041065)
				local var_274_11 = arg_271_1:FormatText(var_274_10.content)

				arg_271_1.text_.text = var_274_11

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 3 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 3)

				if (3 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 3)) > 0 and var_274_9 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_11
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041065", "story_v_out_117041.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041065", "story_v_out_117041.awb") / 1000

					if var_274_14 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_8
					end

					if var_274_10.prefab_name ~= "" and arg_271_1.actors_[var_274_10.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_10.prefab_name].transform, "story_v_out_117041", "117041065", "story_v_out_117041.awb")

						arg_271_1:RecordAudio("117041065", var_274_15)
						arg_271_1:RecordAudio("117041065", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_117041", "117041065", "story_v_out_117041.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_117041", "117041065", "story_v_out_117041.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play117041066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 117041066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play117041067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10035"]) and arg_275_1.var_.actorSpriteComps10035 == nil then
				arg_275_1.var_.actorSpriteComps10035 = arg_275_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10035"]) then
				if arg_275_1.var_.actorSpriteComps10035 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor2.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor2.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor2.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 0.5, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10035"]) and arg_275_1.var_.actorSpriteComps10035 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps10035 = nil
			end

			local var_278_2 = 0
			local var_278_3 = 0.975

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(117041066).content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 39 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 39)

				if (39 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 39)) > 0 and var_278_3 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_7 and arg_275_1.time_ < var_278_2 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play117041067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 117041067
		arg_279_1.duration_ = 7.8

		local var_279_0 = {
			zh = 6.9,
			ja = 7.8
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
				arg_279_0:Play117041068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10035"]) and arg_279_1.var_.actorSpriteComps10035 == nil then
				arg_279_1.var_.actorSpriteComps10035 = arg_279_1.actors_["10035"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10035"]) then
				if arg_279_1.var_.actorSpriteComps10035 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								iter_282_1.color = Color.New(Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_0), Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_0), (Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_0)))
							else
								local var_282_1 = Mathf.Lerp(iter_282_1.color.r, 1, (arg_279_1.time_ - 0) / var_282_0)

								iter_282_1.color = Color.New(var_282_1, var_282_1, var_282_1)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10035"]) and arg_279_1.var_.actorSpriteComps10035 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10035 = nil
			end

			local var_282_2 = 0
			local var_282_3 = 0.725

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(117041067)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 29 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 29)

				if (29 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 29)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041067", "story_v_out_117041.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041067", "story_v_out_117041.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_out_117041", "117041067", "story_v_out_117041.awb")

						arg_279_1:RecordAudio("117041067", var_282_9)
						arg_279_1:RecordAudio("117041067", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_117041", "117041067", "story_v_out_117041.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_117041", "117041067", "story_v_out_117041.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play117041068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 117041068
		arg_283_1.duration_ = 6.3

		local var_283_0 = {
			zh = 6.3,
			ja = 1.6
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
				arg_283_0:Play117041069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.625

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:GetWordFromCfg(117041068)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 25 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 25)

				if (25 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 25)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041068", "story_v_out_117041.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041068", "story_v_out_117041.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_117041", "117041068", "story_v_out_117041.awb")

						arg_283_1:RecordAudio("117041068", var_286_6)
						arg_283_1:RecordAudio("117041068", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_117041", "117041068", "story_v_out_117041.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_117041", "117041068", "story_v_out_117041.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play117041069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 117041069
		arg_287_1.duration_ = 6.23

		local var_287_0 = {
			zh = 4.5,
			ja = 6.233
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
				arg_287_0:Play117041070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1132"]) and arg_287_1.var_.actorSpriteComps1132 == nil then
				arg_287_1.var_.actorSpriteComps1132 = arg_287_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1132"]) then
				if arg_287_1.var_.actorSpriteComps1132 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								iter_290_1.color = Color.New(Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, (arg_287_1.time_ - 0) / var_290_0), Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, (arg_287_1.time_ - 0) / var_290_0), (Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, (arg_287_1.time_ - 0) / var_290_0)))
							else
								local var_290_1 = Mathf.Lerp(iter_290_1.color.r, 1, (arg_287_1.time_ - 0) / var_290_0)

								iter_290_1.color = Color.New(var_290_1, var_290_1, var_290_1)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1132"]) and arg_287_1.var_.actorSpriteComps1132 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps1132 = nil
			end

			local var_290_2 = arg_287_1.actors_["10035"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10035 == nil then
				arg_287_1.var_.actorSpriteComps10035 = var_290_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_3 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 and not isNil(var_290_2) then
				if arg_287_1.var_.actorSpriteComps10035 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_290_5 then
							if arg_287_1.isInRecall_ then
								iter_290_5.color = Color.New(Mathf.Lerp(iter_290_5.color.r, arg_287_1.hightColor2.r, (arg_287_1.time_ - 0) / var_290_3), Mathf.Lerp(iter_290_5.color.g, arg_287_1.hightColor2.g, (arg_287_1.time_ - 0) / var_290_3), (Mathf.Lerp(iter_290_5.color.b, arg_287_1.hightColor2.b, (arg_287_1.time_ - 0) / var_290_3)))
							else
								local var_290_4 = Mathf.Lerp(iter_290_5.color.r, 0.5, (arg_287_1.time_ - 0) / var_290_3)

								iter_290_5.color = Color.New(var_290_4, var_290_4, var_290_4)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10035 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_290_7 then
						iter_290_7.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_287_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				local var_290_5 = arg_287_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_290_5 then
					arg_287_1.var_.alphaOldValue10035 = var_290_5.alpha
					arg_287_1.var_.characterEffect10035 = var_290_5
				end

				arg_287_1.var_.alphaOldValue10035 = 0
			end

			local var_290_6 = 0.0166666666666667

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_6 then
				if arg_287_1.var_.characterEffect10035 then
					arg_287_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_287_1.var_.alphaOldValue10035, 1, (arg_287_1.time_ - 0) / var_290_6)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_6 and arg_287_1.time_ < 0 + var_290_6 + arg_290_0 and arg_287_1.var_.characterEffect10035 then
				arg_287_1.var_.characterEffect10035.alpha = 1
			end

			local var_290_7 = 0
			local var_290_8 = 0.575

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_7 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_9 = arg_287_1:GetWordFromCfg(117041069)
				local var_290_10 = arg_287_1:FormatText(var_290_9.content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_12 = 23 <= 0 and var_290_8 or var_290_8 * (utf8.len(var_290_10) / 23)

				if (23 <= 0 and var_290_8 or var_290_8 * (utf8.len(var_290_10) / 23)) > 0 and var_290_8 < var_290_12 then
					arg_287_1.talkMaxDuration = var_290_12

					if var_290_12 + var_290_7 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_7
					end
				end

				arg_287_1.text_.text = var_290_10
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041069", "story_v_out_117041.awb") ~= 0 then
					local var_290_13 = manager.audio:GetVoiceLength("story_v_out_117041", "117041069", "story_v_out_117041.awb") / 1000

					if var_290_13 + var_290_7 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_7
					end

					if var_290_9.prefab_name ~= "" and arg_287_1.actors_[var_290_9.prefab_name] ~= nil then
						local var_290_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_9.prefab_name].transform, "story_v_out_117041", "117041069", "story_v_out_117041.awb")

						arg_287_1:RecordAudio("117041069", var_290_14)
						arg_287_1:RecordAudio("117041069", var_290_14)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_117041", "117041069", "story_v_out_117041.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_117041", "117041069", "story_v_out_117041.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_15 = math.max(var_290_8, arg_287_1.talkMaxDuration)

			if var_290_7 <= arg_287_1.time_ and arg_287_1.time_ < var_290_7 + var_290_15 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_7) / var_290_15

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_7 + var_290_15 and arg_287_1.time_ < var_290_7 + var_290_15 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play117041070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 117041070
		arg_291_1.duration_ = 5.33

		local var_291_0 = {
			zh = 3.266,
			ja = 5.333
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
				arg_291_0:Play117041071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1132"]) and arg_291_1.var_.actorSpriteComps1132 == nil then
				arg_291_1.var_.actorSpriteComps1132 = arg_291_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1132"]) then
				if arg_291_1.var_.actorSpriteComps1132 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1132"]) and arg_291_1.var_.actorSpriteComps1132 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps1132 = nil
			end

			local var_294_2 = arg_291_1.actors_["10035"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10035 = var_294_2.localPosition
				var_294_2.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10035", 4)

				for iter_294_4 = 0, var_294_2.childCount - 1 do
					local var_294_3 = var_294_2:GetChild(iter_294_4)

					if var_294_3.name == "split_5" or not string.find(var_294_3.name, "split") then
						var_294_3.gameObject:SetActive(true)
					else
						var_294_3.gameObject:SetActive(false)
					end
				end
			end

			local var_294_4 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				var_294_2.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_291_1.time_ - 0) / var_294_4)
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				var_294_2.localPosition = Vector3.New(390, -410, -235)
			end

			local var_294_5 = arg_291_1.actors_["10035"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.actorSpriteComps10035 == nil then
				arg_291_1.var_.actorSpriteComps10035 = var_294_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_6 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_6 and not isNil(var_294_5) then
				if arg_291_1.var_.actorSpriteComps10035 then
					for iter_294_5, iter_294_6 in pairs(arg_291_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_294_6 then
							if arg_291_1.isInRecall_ then
								iter_294_6.color = Color.New(Mathf.Lerp(iter_294_6.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_6), Mathf.Lerp(iter_294_6.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_6), (Mathf.Lerp(iter_294_6.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_6)))
							else
								local var_294_7 = Mathf.Lerp(iter_294_6.color.r, 1, (arg_291_1.time_ - 0) / var_294_6)

								iter_294_6.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_6 and arg_291_1.time_ < 0 + var_294_6 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.actorSpriteComps10035 then
				for iter_294_7, iter_294_8 in pairs(arg_291_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_294_8 then
						iter_294_8.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps10035 = nil
			end

			local var_294_8 = 0
			local var_294_9 = 0.35

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_10 = arg_291_1:GetWordFromCfg(117041070)
				local var_294_11 = arg_291_1:FormatText(var_294_10.content)

				arg_291_1.text_.text = var_294_11

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 14 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 14)

				if (14 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 14)) > 0 and var_294_9 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_11
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041070", "story_v_out_117041.awb") ~= 0 then
					local var_294_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041070", "story_v_out_117041.awb") / 1000

					if var_294_14 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_8
					end

					if var_294_10.prefab_name ~= "" and arg_291_1.actors_[var_294_10.prefab_name] ~= nil then
						local var_294_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_10.prefab_name].transform, "story_v_out_117041", "117041070", "story_v_out_117041.awb")

						arg_291_1:RecordAudio("117041070", var_294_15)
						arg_291_1:RecordAudio("117041070", var_294_15)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_117041", "117041070", "story_v_out_117041.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_117041", "117041070", "story_v_out_117041.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_16 and arg_291_1.time_ < var_294_8 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play117041071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 117041071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play117041072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10035 = arg_295_1.actors_["10035"].transform.localPosition
				arg_295_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10035", 4)

				for iter_298_0 = 0, arg_295_1.actors_["10035"].transform.childCount - 1 do
					local var_298_0 = arg_295_1.actors_["10035"].transform:GetChild(iter_298_0)

					if var_298_0.name == "split_4" or not string.find(var_298_0.name, "split") then
						var_298_0.gameObject:SetActive(true)
					else
						var_298_0.gameObject:SetActive(false)
					end
				end
			end

			local var_298_1 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				arg_295_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10035, Vector3.New(390, -410, -235), (arg_295_1.time_ - 0) / var_298_1)
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 then
				arg_295_1.actors_["10035"].transform.localPosition = Vector3.New(390, -410, -235)
			end

			local var_298_2 = 0
			local var_298_3 = 0.75

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_4 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(117041071).content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_6 = 30 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_4) / 30)

				if (30 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_4) / 30)) > 0 and var_298_3 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_7 and arg_295_1.time_ < var_298_2 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play117041072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 117041072
		arg_299_1.duration_ = 4.2

		local var_299_0 = {
			zh = 2.5,
			ja = 4.2
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
				arg_299_0:Play117041073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.325

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:GetWordFromCfg(117041072)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 13 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 13)

				if (13 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 13)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041072", "story_v_out_117041.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041072", "story_v_out_117041.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_117041", "117041072", "story_v_out_117041.awb")

						arg_299_1:RecordAudio("117041072", var_302_6)
						arg_299_1:RecordAudio("117041072", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_117041", "117041072", "story_v_out_117041.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_117041", "117041072", "story_v_out_117041.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play117041073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 117041073
		arg_303_1.duration_ = 3.07

		local var_303_0 = {
			zh = 3.066,
			ja = 0.999999999999
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
				arg_303_0:Play117041074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1132"]) and arg_303_1.var_.actorSpriteComps1132 == nil then
				arg_303_1.var_.actorSpriteComps1132 = arg_303_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1132"]) then
				if arg_303_1.var_.actorSpriteComps1132 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								iter_306_1.color = Color.New(Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, (arg_303_1.time_ - 0) / var_306_0), Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, (arg_303_1.time_ - 0) / var_306_0), (Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, (arg_303_1.time_ - 0) / var_306_0)))
							else
								local var_306_1 = Mathf.Lerp(iter_306_1.color.r, 1, (arg_303_1.time_ - 0) / var_306_0)

								iter_306_1.color = Color.New(var_306_1, var_306_1, var_306_1)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1132"]) and arg_303_1.var_.actorSpriteComps1132 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_306_3 then
						iter_306_3.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_303_1.var_.actorSpriteComps1132 = nil
			end

			local var_306_2 = 0
			local var_306_3 = 0.05

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_4 = arg_303_1:GetWordFromCfg(117041073)
				local var_306_5 = arg_303_1:FormatText(var_306_4.content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_7 = 2 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 2)

				if (2 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 2)) > 0 and var_306_3 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041073", "story_v_out_117041.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041073", "story_v_out_117041.awb") / 1000

					if var_306_8 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_2
					end

					if var_306_4.prefab_name ~= "" and arg_303_1.actors_[var_306_4.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_4.prefab_name].transform, "story_v_out_117041", "117041073", "story_v_out_117041.awb")

						arg_303_1:RecordAudio("117041073", var_306_9)
						arg_303_1:RecordAudio("117041073", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_117041", "117041073", "story_v_out_117041.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_117041", "117041073", "story_v_out_117041.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_10 and arg_303_1.time_ < var_306_2 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play117041074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 117041074
		arg_307_1.duration_ = 1.9

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play117041075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.25

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:GetWordFromCfg(117041074)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 10 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 10)

				if (10 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 10)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041074", "story_v_out_117041.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041074", "story_v_out_117041.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_out_117041", "117041074", "story_v_out_117041.awb")

						arg_307_1:RecordAudio("117041074", var_310_6)
						arg_307_1:RecordAudio("117041074", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_117041", "117041074", "story_v_out_117041.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_117041", "117041074", "story_v_out_117041.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play117041075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 117041075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play117041076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1132"]) and arg_311_1.var_.actorSpriteComps1132 == nil then
				arg_311_1.var_.actorSpriteComps1132 = arg_311_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1132"]) then
				if arg_311_1.var_.actorSpriteComps1132 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								iter_314_1.color = Color.New(Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_0), Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_0), (Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_0)))
							else
								local var_314_1 = Mathf.Lerp(iter_314_1.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_0)

								iter_314_1.color = Color.New(var_314_1, var_314_1, var_314_1)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1132"]) and arg_311_1.var_.actorSpriteComps1132 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps1132 = nil
			end

			local var_314_2 = 0
			local var_314_3 = 0.625

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_4 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(117041075).content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_6 = 25 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_4) / 25)

				if (25 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_4) / 25)) > 0 and var_314_3 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_2
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_3, arg_311_1.talkMaxDuration)

			if var_314_2 <= arg_311_1.time_ and arg_311_1.time_ < var_314_2 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_2) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_2 + var_314_7 and arg_311_1.time_ < var_314_2 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play117041076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 117041076
		arg_315_1.duration_ = 2.73

		local var_315_0 = {
			zh = 1.366,
			ja = 2.733
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
				arg_315_0:Play117041077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				local var_318_0 = arg_315_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_318_0 then
					arg_315_1.var_.alphaOldValue1132 = var_318_0.alpha
					arg_315_1.var_.characterEffect1132 = var_318_0
				end

				arg_315_1.var_.alphaOldValue1132 = 1
			end

			local var_318_1 = 0.333333333333333

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 then
				if arg_315_1.var_.characterEffect1132 then
					arg_315_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_315_1.var_.alphaOldValue1132, 0, (arg_315_1.time_ - 0) / var_318_1)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 and arg_315_1.var_.characterEffect1132 then
				arg_315_1.var_.characterEffect1132.alpha = 0
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				local var_318_2 = arg_315_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_318_2 then
					arg_315_1.var_.alphaOldValue10034 = var_318_2.alpha
					arg_315_1.var_.characterEffect10034 = var_318_2
				end

				arg_315_1.var_.alphaOldValue10034 = 0
			end

			local var_318_3 = 0.333333333333333

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 then
				if arg_315_1.var_.characterEffect10034 then
					arg_315_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_315_1.var_.alphaOldValue10034, 1, (arg_315_1.time_ - 0) / var_318_3)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and arg_315_1.var_.characterEffect10034 then
				arg_315_1.var_.characterEffect10034.alpha = 1
			end

			local var_318_4 = arg_315_1.actors_["10034"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10034 = var_318_4.localPosition
				var_318_4.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10034", 2)

				for iter_318_0 = 0, var_318_4.childCount - 1 do
					local var_318_5 = var_318_4:GetChild(iter_318_0)

					if var_318_5.name == "split_2" or not string.find(var_318_5.name, "split") then
						var_318_5.gameObject:SetActive(true)
					else
						var_318_5.gameObject:SetActive(false)
					end
				end
			end

			local var_318_6 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_6 then
				var_318_4.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_315_1.time_ - 0) / var_318_6)
			end

			if arg_315_1.time_ >= 0 + var_318_6 and arg_315_1.time_ < 0 + var_318_6 + arg_318_0 then
				var_318_4.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_318_7 = arg_315_1.actors_["10034"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.actorSpriteComps10034 == nil then
				arg_315_1.var_.actorSpriteComps10034 = var_318_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_8 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_8 and not isNil(var_318_7) then
				if arg_315_1.var_.actorSpriteComps10034 then
					for iter_318_1, iter_318_2 in pairs(arg_315_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_318_2 then
							if arg_315_1.isInRecall_ then
								iter_318_2.color = Color.New(Mathf.Lerp(iter_318_2.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_8), Mathf.Lerp(iter_318_2.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_8), (Mathf.Lerp(iter_318_2.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_8)))
							else
								local var_318_9 = Mathf.Lerp(iter_318_2.color.r, 1, (arg_315_1.time_ - 0) / var_318_8)

								iter_318_2.color = Color.New(var_318_9, var_318_9, var_318_9)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_8 and arg_315_1.time_ < 0 + var_318_8 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.actorSpriteComps10034 then
				for iter_318_3, iter_318_4 in pairs(arg_315_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_318_4 then
						iter_318_4.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps10034 = nil
			end

			local var_318_10 = 0
			local var_318_11 = 0.1

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_12 = arg_315_1:GetWordFromCfg(117041076)
				local var_318_13 = arg_315_1:FormatText(var_318_12.content)

				arg_315_1.text_.text = var_318_13

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_15 = 4 <= 0 and var_318_11 or var_318_11 * (utf8.len(var_318_13) / 4)

				if (4 <= 0 and var_318_11 or var_318_11 * (utf8.len(var_318_13) / 4)) > 0 and var_318_11 < var_318_15 then
					arg_315_1.talkMaxDuration = var_318_15

					if var_318_15 + var_318_10 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_15 + var_318_10
					end
				end

				arg_315_1.text_.text = var_318_13
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041076", "story_v_out_117041.awb") ~= 0 then
					local var_318_16 = manager.audio:GetVoiceLength("story_v_out_117041", "117041076", "story_v_out_117041.awb") / 1000

					if var_318_16 + var_318_10 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_16 + var_318_10
					end

					if var_318_12.prefab_name ~= "" and arg_315_1.actors_[var_318_12.prefab_name] ~= nil then
						local var_318_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_12.prefab_name].transform, "story_v_out_117041", "117041076", "story_v_out_117041.awb")

						arg_315_1:RecordAudio("117041076", var_318_17)
						arg_315_1:RecordAudio("117041076", var_318_17)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_117041", "117041076", "story_v_out_117041.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_117041", "117041076", "story_v_out_117041.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_18 = math.max(var_318_11, arg_315_1.talkMaxDuration)

			if var_318_10 <= arg_315_1.time_ and arg_315_1.time_ < var_318_10 + var_318_18 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_10) / var_318_18

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_10 + var_318_18 and arg_315_1.time_ < var_318_10 + var_318_18 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play117041077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 117041077
		arg_319_1.duration_ = 4.97

		local var_319_0 = {
			zh = 2.066,
			ja = 4.966
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play117041078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["10034"]) and arg_319_1.var_.actorSpriteComps10034 == nil then
				arg_319_1.var_.actorSpriteComps10034 = arg_319_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["10034"]) then
				if arg_319_1.var_.actorSpriteComps10034 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["10034"]) and arg_319_1.var_.actorSpriteComps10034 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps10034 = nil
			end

			local var_322_2 = arg_319_1.actors_["10035"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps10035 == nil then
				arg_319_1.var_.actorSpriteComps10035 = var_322_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_3 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.actorSpriteComps10035 then
					for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_322_5 then
							if arg_319_1.isInRecall_ then
								iter_322_5.color = Color.New(Mathf.Lerp(iter_322_5.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_3), Mathf.Lerp(iter_322_5.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_3), (Mathf.Lerp(iter_322_5.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_3)))
							else
								local var_322_4 = Mathf.Lerp(iter_322_5.color.r, 1, (arg_319_1.time_ - 0) / var_322_3)

								iter_322_5.color = Color.New(var_322_4, var_322_4, var_322_4)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps10035 then
				for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_322_7 then
						iter_322_7.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps10035 = nil
			end

			local var_322_5 = 0
			local var_322_6 = 0.3

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_7 = arg_319_1:GetWordFromCfg(117041077)
				local var_322_8 = arg_319_1:FormatText(var_322_7.content)

				arg_319_1.text_.text = var_322_8

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_10 = 12 <= 0 and var_322_6 or var_322_6 * (utf8.len(var_322_8) / 12)

				if (12 <= 0 and var_322_6 or var_322_6 * (utf8.len(var_322_8) / 12)) > 0 and var_322_6 < var_322_10 then
					arg_319_1.talkMaxDuration = var_322_10

					if var_322_10 + var_322_5 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_5
					end
				end

				arg_319_1.text_.text = var_322_8
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041077", "story_v_out_117041.awb") ~= 0 then
					local var_322_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041077", "story_v_out_117041.awb") / 1000

					if var_322_11 + var_322_5 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_11 + var_322_5
					end

					if var_322_7.prefab_name ~= "" and arg_319_1.actors_[var_322_7.prefab_name] ~= nil then
						local var_322_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_7.prefab_name].transform, "story_v_out_117041", "117041077", "story_v_out_117041.awb")

						arg_319_1:RecordAudio("117041077", var_322_12)
						arg_319_1:RecordAudio("117041077", var_322_12)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_117041", "117041077", "story_v_out_117041.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_117041", "117041077", "story_v_out_117041.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_13 = math.max(var_322_6, arg_319_1.talkMaxDuration)

			if var_322_5 <= arg_319_1.time_ and arg_319_1.time_ < var_322_5 + var_322_13 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_5) / var_322_13

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_5 + var_322_13 and arg_319_1.time_ < var_322_5 + var_322_13 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play117041078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 117041078
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play117041079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				local var_326_0 = arg_323_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_0 then
					arg_323_1.var_.alphaOldValue10035 = var_326_0.alpha
					arg_323_1.var_.characterEffect10035 = var_326_0
				end

				arg_323_1.var_.alphaOldValue10035 = 1
			end

			local var_326_1 = 0.333333333333333

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				if arg_323_1.var_.characterEffect10035 then
					arg_323_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_323_1.var_.alphaOldValue10035, 0, (arg_323_1.time_ - 0) / var_326_1)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 and arg_323_1.var_.characterEffect10035 then
				arg_323_1.var_.characterEffect10035.alpha = 0
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				local var_326_2 = arg_323_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_2 then
					arg_323_1.var_.alphaOldValue10034 = var_326_2.alpha
					arg_323_1.var_.characterEffect10034 = var_326_2
				end

				arg_323_1.var_.alphaOldValue10034 = 1
			end

			local var_326_3 = 0.333333333333333

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 then
				if arg_323_1.var_.characterEffect10034 then
					arg_323_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_323_1.var_.alphaOldValue10034, 0, (arg_323_1.time_ - 0) / var_326_3)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and arg_323_1.var_.characterEffect10034 then
				arg_323_1.var_.characterEffect10034.alpha = 0
			end

			local var_326_4 = 0
			local var_326_5 = 0.575

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(117041078).content)

				arg_323_1.text_.text = var_326_6

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_8 = 23 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_6) / 23)

				if (23 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_6) / 23)) > 0 and var_326_5 < var_326_8 then
					arg_323_1.talkMaxDuration = var_326_8

					if var_326_8 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_6
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_9 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_9 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_9

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_9 and arg_323_1.time_ < var_326_4 + var_326_9 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play117041079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 117041079
		arg_327_1.duration_ = 9

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play117041080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_0 = 2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				local var_330_1 = Color.New(0, 0, 0)

				var_330_1.a = Mathf.Lerp(0, 1, (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.mask_.color = var_330_1
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				local var_330_2 = Color.New(0, 0, 0)

				var_330_2.a = 1
				arg_327_1.mask_.color = var_330_2
			end

			local var_330_3 = 2

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= var_330_3 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_4 = 2

			if var_330_3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_3 + var_330_4 then
				local var_330_5 = Color.New(0, 0, 0)

				var_330_5.a = Mathf.Lerp(1, 0, (arg_327_1.time_ - var_330_3) / var_330_4)
				arg_327_1.mask_.color = var_330_5
			end

			if arg_327_1.time_ >= var_330_3 + var_330_4 and arg_327_1.time_ < var_330_3 + var_330_4 + arg_330_0 then
				local var_330_6 = Color.New(0, 0, 0)

				arg_327_1.mask_.enabled = false
				var_330_6.a = 0
				arg_327_1.mask_.color = var_330_6
			end

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= 4 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close", "")
			end

			if arg_327_1.frameCnt_ <= 1 then
				arg_327_1.dialog_:SetActive(false)
			end

			local var_330_8 = 4
			local var_330_9 = 0.775

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0

				arg_327_1.dialog_:SetActive(true)

				arg_327_1.dialogCg_.alpha = 0

				local var_330_10 = LeanTween.value(arg_327_1.dialog_, 0, 1, 0.3)

				var_330_10:setOnUpdate(LuaHelper.FloatAction(function(arg_331_0)
					arg_327_1.dialogCg_.alpha = arg_331_0
				end))
				var_330_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_327_1.dialog_)
					var_330_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_327_1.duration_ = arg_327_1.duration_ + 0.3

				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_11 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(117041079).content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 31 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 31)

				if (31 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 31)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13
					var_330_8 = var_330_8 + 0.3

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = var_330_8 + 0.3
			local var_330_15 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 + 0.3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_14 + var_330_15 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_14) / var_330_15

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_14 + var_330_15 and arg_327_1.time_ < var_330_14 + var_330_15 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play117041080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 117041080
		arg_333_1.duration_ = 10.17

		local var_333_0 = {
			zh = 10.166,
			ja = 5.133
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play117041081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				local var_336_0 = arg_333_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_336_0 then
					arg_333_1.var_.alphaOldValue10034 = var_336_0.alpha
					arg_333_1.var_.characterEffect10034 = var_336_0
				end

				arg_333_1.var_.alphaOldValue10034 = 0
			end

			local var_336_1 = 0.333333333333333

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_1 then
				if arg_333_1.var_.characterEffect10034 then
					arg_333_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_333_1.var_.alphaOldValue10034, 1, (arg_333_1.time_ - 0) / var_336_1)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_1 and arg_333_1.time_ < 0 + var_336_1 + arg_336_0 and arg_333_1.var_.characterEffect10034 then
				arg_333_1.var_.characterEffect10034.alpha = 1
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				local var_336_2 = arg_333_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_336_2 then
					arg_333_1.var_.alphaOldValue1132 = var_336_2.alpha
					arg_333_1.var_.characterEffect1132 = var_336_2
				end

				arg_333_1.var_.alphaOldValue1132 = 0
			end

			local var_336_3 = 0.333333333333333

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 then
				if arg_333_1.var_.characterEffect1132 then
					arg_333_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_333_1.var_.alphaOldValue1132, 1, (arg_333_1.time_ - 0) / var_336_3)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and arg_333_1.var_.characterEffect1132 then
				arg_333_1.var_.characterEffect1132.alpha = 1
			end

			local var_336_4 = arg_333_1.actors_["10034"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10034 = var_336_4.localPosition
				var_336_4.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10034", 4)

				for iter_336_0 = 0, var_336_4.childCount - 1 do
					local var_336_5 = var_336_4:GetChild(iter_336_0)

					if var_336_5.name == "split_2" or not string.find(var_336_5.name, "split") then
						var_336_5.gameObject:SetActive(true)
					else
						var_336_5.gameObject:SetActive(false)
					end
				end
			end

			local var_336_6 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_6 then
				var_336_4.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_333_1.time_ - 0) / var_336_6)
			end

			if arg_333_1.time_ >= 0 + var_336_6 and arg_333_1.time_ < 0 + var_336_6 + arg_336_0 then
				var_336_4.localPosition = Vector3.New(390, -415, -290)
			end

			local var_336_7 = arg_333_1.actors_["1132"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1132 = var_336_7.localPosition
				var_336_7.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1132", 2)

				for iter_336_1 = 0, var_336_7.childCount - 1 do
					local var_336_8 = var_336_7:GetChild(iter_336_1)

					if var_336_8.name == "split_6" or not string.find(var_336_8.name, "split") then
						var_336_8.gameObject:SetActive(true)
					else
						var_336_8.gameObject:SetActive(false)
					end
				end
			end

			local var_336_9 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_9 then
				var_336_7.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_333_1.time_ - 0) / var_336_9)
			end

			if arg_333_1.time_ >= 0 + var_336_9 and arg_333_1.time_ < 0 + var_336_9 + arg_336_0 then
				var_336_7.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_336_10 = arg_333_1.actors_["10034"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_10) and arg_333_1.var_.actorSpriteComps10034 == nil then
				arg_333_1.var_.actorSpriteComps10034 = var_336_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_11 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_11 and not isNil(var_336_10) then
				if arg_333_1.var_.actorSpriteComps10034 then
					for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_336_3 then
							if arg_333_1.isInRecall_ then
								iter_336_3.color = Color.New(Mathf.Lerp(iter_336_3.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_11), Mathf.Lerp(iter_336_3.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_11), (Mathf.Lerp(iter_336_3.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_11)))
							else
								local var_336_12 = Mathf.Lerp(iter_336_3.color.r, 1, (arg_333_1.time_ - 0) / var_336_11)

								iter_336_3.color = Color.New(var_336_12, var_336_12, var_336_12)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_11 and arg_333_1.time_ < 0 + var_336_11 + arg_336_0 and not isNil(var_336_10) and arg_333_1.var_.actorSpriteComps10034 then
				for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_336_5 then
						iter_336_5.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps10034 = nil
			end

			local var_336_13 = 0
			local var_336_14 = 1.05

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_13 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_15 = arg_333_1:GetWordFromCfg(117041080)
				local var_336_16 = arg_333_1:FormatText(var_336_15.content)

				arg_333_1.text_.text = var_336_16

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_18 = 42 <= 0 and var_336_14 or var_336_14 * (utf8.len(var_336_16) / 42)

				if (42 <= 0 and var_336_14 or var_336_14 * (utf8.len(var_336_16) / 42)) > 0 and var_336_14 < var_336_18 then
					arg_333_1.talkMaxDuration = var_336_18

					if var_336_18 + var_336_13 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_18 + var_336_13
					end
				end

				arg_333_1.text_.text = var_336_16
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041080", "story_v_out_117041.awb") ~= 0 then
					local var_336_19 = manager.audio:GetVoiceLength("story_v_out_117041", "117041080", "story_v_out_117041.awb") / 1000

					if var_336_19 + var_336_13 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_19 + var_336_13
					end

					if var_336_15.prefab_name ~= "" and arg_333_1.actors_[var_336_15.prefab_name] ~= nil then
						local var_336_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_15.prefab_name].transform, "story_v_out_117041", "117041080", "story_v_out_117041.awb")

						arg_333_1:RecordAudio("117041080", var_336_20)
						arg_333_1:RecordAudio("117041080", var_336_20)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_117041", "117041080", "story_v_out_117041.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_117041", "117041080", "story_v_out_117041.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_21 = math.max(var_336_14, arg_333_1.talkMaxDuration)

			if var_336_13 <= arg_333_1.time_ and arg_333_1.time_ < var_336_13 + var_336_21 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_13) / var_336_21

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_13 + var_336_21 and arg_333_1.time_ < var_336_13 + var_336_21 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play117041081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 117041081
		arg_337_1.duration_ = 5.37

		local var_337_0 = {
			zh = 5.366,
			ja = 4.633
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
				arg_337_0:Play117041082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["10034"]) and arg_337_1.var_.actorSpriteComps10034 == nil then
				arg_337_1.var_.actorSpriteComps10034 = arg_337_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["10034"]) then
				if arg_337_1.var_.actorSpriteComps10034 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								iter_340_1.color = Color.New(Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor2.r, (arg_337_1.time_ - 0) / var_340_0), Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor2.g, (arg_337_1.time_ - 0) / var_340_0), (Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor2.b, (arg_337_1.time_ - 0) / var_340_0)))
							else
								local var_340_1 = Mathf.Lerp(iter_340_1.color.r, 0.5, (arg_337_1.time_ - 0) / var_340_0)

								iter_340_1.color = Color.New(var_340_1, var_340_1, var_340_1)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["10034"]) and arg_337_1.var_.actorSpriteComps10034 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_340_3 then
						iter_340_3.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_337_1.var_.actorSpriteComps10034 = nil
			end

			local var_340_2 = arg_337_1.actors_["1132"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps1132 == nil then
				arg_337_1.var_.actorSpriteComps1132 = var_340_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_3 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.actorSpriteComps1132 then
					for iter_340_4, iter_340_5 in pairs(arg_337_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_340_5 then
							if arg_337_1.isInRecall_ then
								iter_340_5.color = Color.New(Mathf.Lerp(iter_340_5.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_3), Mathf.Lerp(iter_340_5.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_3), (Mathf.Lerp(iter_340_5.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_3)))
							else
								local var_340_4 = Mathf.Lerp(iter_340_5.color.r, 1, (arg_337_1.time_ - 0) / var_340_3)

								iter_340_5.color = Color.New(var_340_4, var_340_4, var_340_4)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps1132 then
				for iter_340_6, iter_340_7 in pairs(arg_337_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_340_7 then
						iter_340_7.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps1132 = nil
			end

			local var_340_5 = 0
			local var_340_6 = 0.725

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_7 = arg_337_1:GetWordFromCfg(117041081)
				local var_340_8 = arg_337_1:FormatText(var_340_7.content)

				arg_337_1.text_.text = var_340_8

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_10 = 29 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_8) / 29)

				if (29 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_8) / 29)) > 0 and var_340_6 < var_340_10 then
					arg_337_1.talkMaxDuration = var_340_10

					if var_340_10 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_8
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041081", "story_v_out_117041.awb") ~= 0 then
					local var_340_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041081", "story_v_out_117041.awb") / 1000

					if var_340_11 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_11 + var_340_5
					end

					if var_340_7.prefab_name ~= "" and arg_337_1.actors_[var_340_7.prefab_name] ~= nil then
						local var_340_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_7.prefab_name].transform, "story_v_out_117041", "117041081", "story_v_out_117041.awb")

						arg_337_1:RecordAudio("117041081", var_340_12)
						arg_337_1:RecordAudio("117041081", var_340_12)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_117041", "117041081", "story_v_out_117041.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_117041", "117041081", "story_v_out_117041.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_13 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_13 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_13

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_13 and arg_337_1.time_ < var_340_5 + var_340_13 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play117041082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 117041082
		arg_341_1.duration_ = 8.93

		local var_341_0 = {
			zh = 3.366,
			ja = 8.933
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play117041083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10034 = arg_341_1.actors_["10034"].transform.localPosition
				arg_341_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10034", 4)

				for iter_344_0 = 0, arg_341_1.actors_["10034"].transform.childCount - 1 do
					local var_344_0 = arg_341_1.actors_["10034"].transform:GetChild(iter_344_0)

					if var_344_0.name == "split_2" or not string.find(var_344_0.name, "split") then
						var_344_0.gameObject:SetActive(true)
					else
						var_344_0.gameObject:SetActive(false)
					end
				end
			end

			local var_344_1 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 then
				arg_341_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_341_1.time_ - 0) / var_344_1)
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 then
				arg_341_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_344_2 = arg_341_1.actors_["1132"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps1132 == nil then
				arg_341_1.var_.actorSpriteComps1132 = var_344_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_3 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.actorSpriteComps1132 then
					for iter_344_1, iter_344_2 in pairs(arg_341_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_344_2 then
							if arg_341_1.isInRecall_ then
								iter_344_2.color = Color.New(Mathf.Lerp(iter_344_2.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_3), Mathf.Lerp(iter_344_2.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_3), (Mathf.Lerp(iter_344_2.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_3)))
							else
								local var_344_4 = Mathf.Lerp(iter_344_2.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_3)

								iter_344_2.color = Color.New(var_344_4, var_344_4, var_344_4)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps1132 then
				for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_344_4 then
						iter_344_4.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps1132 = nil
			end

			local var_344_5 = arg_341_1.actors_["10034"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps10034 == nil then
				arg_341_1.var_.actorSpriteComps10034 = var_344_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_6 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_6 and not isNil(var_344_5) then
				if arg_341_1.var_.actorSpriteComps10034 then
					for iter_344_5, iter_344_6 in pairs(arg_341_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_344_6 then
							if arg_341_1.isInRecall_ then
								iter_344_6.color = Color.New(Mathf.Lerp(iter_344_6.color.r, arg_341_1.hightColor1.r, (arg_341_1.time_ - 0) / var_344_6), Mathf.Lerp(iter_344_6.color.g, arg_341_1.hightColor1.g, (arg_341_1.time_ - 0) / var_344_6), (Mathf.Lerp(iter_344_6.color.b, arg_341_1.hightColor1.b, (arg_341_1.time_ - 0) / var_344_6)))
							else
								local var_344_7 = Mathf.Lerp(iter_344_6.color.r, 1, (arg_341_1.time_ - 0) / var_344_6)

								iter_344_6.color = Color.New(var_344_7, var_344_7, var_344_7)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_6 and arg_341_1.time_ < 0 + var_344_6 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps10034 then
				for iter_344_7, iter_344_8 in pairs(arg_341_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_344_8 then
						iter_344_8.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_341_1.var_.actorSpriteComps10034 = nil
			end

			local var_344_8 = 0
			local var_344_9 = 0.325

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_10 = arg_341_1:GetWordFromCfg(117041082)
				local var_344_11 = arg_341_1:FormatText(var_344_10.content)

				arg_341_1.text_.text = var_344_11

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_13 = 13 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 13)

				if (13 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 13)) > 0 and var_344_9 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_8
					end
				end

				arg_341_1.text_.text = var_344_11
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041082", "story_v_out_117041.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041082", "story_v_out_117041.awb") / 1000

					if var_344_14 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_8
					end

					if var_344_10.prefab_name ~= "" and arg_341_1.actors_[var_344_10.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_10.prefab_name].transform, "story_v_out_117041", "117041082", "story_v_out_117041.awb")

						arg_341_1:RecordAudio("117041082", var_344_15)
						arg_341_1:RecordAudio("117041082", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_117041", "117041082", "story_v_out_117041.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_117041", "117041082", "story_v_out_117041.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_9, arg_341_1.talkMaxDuration)

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_8) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_8 + var_344_16 and arg_341_1.time_ < var_344_8 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play117041083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 117041083
		arg_345_1.duration_ = 3.2

		local var_345_0 = {
			zh = 3.2,
			ja = 3.133
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
				arg_345_0:Play117041084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.25

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(117041083)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 10 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 10)

				if (10 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 10)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041083", "story_v_out_117041.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041083", "story_v_out_117041.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_117041", "117041083", "story_v_out_117041.awb")

						arg_345_1:RecordAudio("117041083", var_348_6)
						arg_345_1:RecordAudio("117041083", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_117041", "117041083", "story_v_out_117041.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_117041", "117041083", "story_v_out_117041.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play117041084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 117041084
		arg_349_1.duration_ = 6

		local var_349_0 = {
			zh = 2,
			ja = 6
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play117041085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1132"]) and arg_349_1.var_.actorSpriteComps1132 == nil then
				arg_349_1.var_.actorSpriteComps1132 = arg_349_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_0 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1132"]) then
				if arg_349_1.var_.actorSpriteComps1132 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								iter_352_1.color = Color.New(Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor1.r, (arg_349_1.time_ - 0) / var_352_0), Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor1.g, (arg_349_1.time_ - 0) / var_352_0), (Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor1.b, (arg_349_1.time_ - 0) / var_352_0)))
							else
								local var_352_1 = Mathf.Lerp(iter_352_1.color.r, 1, (arg_349_1.time_ - 0) / var_352_0)

								iter_352_1.color = Color.New(var_352_1, var_352_1, var_352_1)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1132"]) and arg_349_1.var_.actorSpriteComps1132 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_352_3 then
						iter_352_3.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_349_1.var_.actorSpriteComps1132 = nil
			end

			local var_352_2 = arg_349_1.actors_["10034"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps10034 == nil then
				arg_349_1.var_.actorSpriteComps10034 = var_352_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_3 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 and not isNil(var_352_2) then
				if arg_349_1.var_.actorSpriteComps10034 then
					for iter_352_4, iter_352_5 in pairs(arg_349_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_352_5 then
							if arg_349_1.isInRecall_ then
								iter_352_5.color = Color.New(Mathf.Lerp(iter_352_5.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_3), Mathf.Lerp(iter_352_5.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_3), (Mathf.Lerp(iter_352_5.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_3)))
							else
								local var_352_4 = Mathf.Lerp(iter_352_5.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_3)

								iter_352_5.color = Color.New(var_352_4, var_352_4, var_352_4)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps10034 then
				for iter_352_6, iter_352_7 in pairs(arg_349_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_352_7 then
						iter_352_7.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps10034 = nil
			end

			local var_352_5 = 0
			local var_352_6 = 0.275

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_7 = arg_349_1:GetWordFromCfg(117041084)
				local var_352_8 = arg_349_1:FormatText(var_352_7.content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_10 = 11 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_8) / 11)

				if (11 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_8) / 11)) > 0 and var_352_6 < var_352_10 then
					arg_349_1.talkMaxDuration = var_352_10

					if var_352_10 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_5
					end
				end

				arg_349_1.text_.text = var_352_8
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041084", "story_v_out_117041.awb") ~= 0 then
					local var_352_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041084", "story_v_out_117041.awb") / 1000

					if var_352_11 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_5
					end

					if var_352_7.prefab_name ~= "" and arg_349_1.actors_[var_352_7.prefab_name] ~= nil then
						local var_352_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_7.prefab_name].transform, "story_v_out_117041", "117041084", "story_v_out_117041.awb")

						arg_349_1:RecordAudio("117041084", var_352_12)
						arg_349_1:RecordAudio("117041084", var_352_12)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_117041", "117041084", "story_v_out_117041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_117041", "117041084", "story_v_out_117041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_13 = math.max(var_352_6, arg_349_1.talkMaxDuration)

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_13 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_5) / var_352_13

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_5 + var_352_13 and arg_349_1.time_ < var_352_5 + var_352_13 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play117041085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 117041085
		arg_353_1.duration_ = 7.5

		local var_353_0 = {
			zh = 7.5,
			ja = 3.766
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
				arg_353_0:Play117041086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["10034"]) and arg_353_1.var_.actorSpriteComps10034 == nil then
				arg_353_1.var_.actorSpriteComps10034 = arg_353_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["10034"]) then
				if arg_353_1.var_.actorSpriteComps10034 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								iter_356_1.color = Color.New(Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_0), Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_0), (Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_0)))
							else
								local var_356_1 = Mathf.Lerp(iter_356_1.color.r, 1, (arg_353_1.time_ - 0) / var_356_0)

								iter_356_1.color = Color.New(var_356_1, var_356_1, var_356_1)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["10034"]) and arg_353_1.var_.actorSpriteComps10034 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_356_3 then
						iter_356_3.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps10034 = nil
			end

			local var_356_2 = arg_353_1.actors_["1132"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1132 == nil then
				arg_353_1.var_.actorSpriteComps1132 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps1132 then
					for iter_356_4, iter_356_5 in pairs(arg_353_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_356_5 then
							if arg_353_1.isInRecall_ then
								iter_356_5.color = Color.New(Mathf.Lerp(iter_356_5.color.r, arg_353_1.hightColor2.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_5.color.g, arg_353_1.hightColor2.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_5.color.b, arg_353_1.hightColor2.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_5.color.r, 0.5, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_5.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1132 then
				for iter_356_6, iter_356_7 in pairs(arg_353_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_356_7 then
						iter_356_7.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_353_1.var_.actorSpriteComps1132 = nil
			end

			local var_356_5 = 0
			local var_356_6 = 0.675

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(117041085)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 27 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 27)

				if (27 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 27)) > 0 and var_356_6 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_5
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041085", "story_v_out_117041.awb") ~= 0 then
					local var_356_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041085", "story_v_out_117041.awb") / 1000

					if var_356_11 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_5
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_out_117041", "117041085", "story_v_out_117041.awb")

						arg_353_1:RecordAudio("117041085", var_356_12)
						arg_353_1:RecordAudio("117041085", var_356_12)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_117041", "117041085", "story_v_out_117041.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_117041", "117041085", "story_v_out_117041.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_13 = math.max(var_356_6, arg_353_1.talkMaxDuration)

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_13 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_5) / var_356_13

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_5 + var_356_13 and arg_353_1.time_ < var_356_5 + var_356_13 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play117041086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 117041086
		arg_357_1.duration_ = 8.9

		local var_357_0 = {
			zh = 8.533,
			ja = 8.9
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
				arg_357_0:Play117041087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1132"]) and arg_357_1.var_.actorSpriteComps1132 == nil then
				arg_357_1.var_.actorSpriteComps1132 = arg_357_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1132"]) then
				if arg_357_1.var_.actorSpriteComps1132 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 1, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1132"]) and arg_357_1.var_.actorSpriteComps1132 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps1132 = nil
			end

			local var_360_2 = arg_357_1.actors_["10034"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10034 == nil then
				arg_357_1.var_.actorSpriteComps10034 = var_360_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_3 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.actorSpriteComps10034 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								iter_360_5.color = Color.New(Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_3), Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_3), (Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_3)))
							else
								local var_360_4 = Mathf.Lerp(iter_360_5.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_3)

								iter_360_5.color = Color.New(var_360_4, var_360_4, var_360_4)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10034 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_360_7 then
						iter_360_7.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps10034 = nil
			end

			local var_360_5 = 0
			local var_360_6 = 1.2

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:GetWordFromCfg(117041086)
				local var_360_8 = arg_357_1:FormatText(var_360_7.content)

				arg_357_1.text_.text = var_360_8

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_10 = 48 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 48)

				if (48 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 48)) > 0 and var_360_6 < var_360_10 then
					arg_357_1.talkMaxDuration = var_360_10

					if var_360_10 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_5
					end
				end

				arg_357_1.text_.text = var_360_8
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041086", "story_v_out_117041.awb") ~= 0 then
					local var_360_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041086", "story_v_out_117041.awb") / 1000

					if var_360_11 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_5
					end

					if var_360_7.prefab_name ~= "" and arg_357_1.actors_[var_360_7.prefab_name] ~= nil then
						local var_360_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_7.prefab_name].transform, "story_v_out_117041", "117041086", "story_v_out_117041.awb")

						arg_357_1:RecordAudio("117041086", var_360_12)
						arg_357_1:RecordAudio("117041086", var_360_12)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_117041", "117041086", "story_v_out_117041.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_117041", "117041086", "story_v_out_117041.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = math.max(var_360_6, arg_357_1.talkMaxDuration)

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_13 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_5) / var_360_13

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_5 + var_360_13 and arg_357_1.time_ < var_360_5 + var_360_13 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play117041087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 117041087
		arg_361_1.duration_ = 1.73

		local var_361_0 = {
			zh = 1.733,
			ja = 1.4
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play117041088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10034 = arg_361_1.actors_["10034"].transform.localPosition
				arg_361_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10034", 4)

				for iter_364_0 = 0, arg_361_1.actors_["10034"].transform.childCount - 1 do
					local var_364_0 = arg_361_1.actors_["10034"].transform:GetChild(iter_364_0)

					if var_364_0.name == "split_2" or not string.find(var_364_0.name, "split") then
						var_364_0.gameObject:SetActive(true)
					else
						var_364_0.gameObject:SetActive(false)
					end
				end
			end

			local var_364_1 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				arg_361_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_361_1.time_ - 0) / var_364_1)
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 then
				arg_361_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_364_2 = arg_361_1.actors_["1132"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps1132 == nil then
				arg_361_1.var_.actorSpriteComps1132 = var_364_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_3 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_3 and not isNil(var_364_2) then
				if arg_361_1.var_.actorSpriteComps1132 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								iter_364_2.color = Color.New(Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor2.r, (arg_361_1.time_ - 0) / var_364_3), Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor2.g, (arg_361_1.time_ - 0) / var_364_3), (Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor2.b, (arg_361_1.time_ - 0) / var_364_3)))
							else
								local var_364_4 = Mathf.Lerp(iter_364_2.color.r, 0.5, (arg_361_1.time_ - 0) / var_364_3)

								iter_364_2.color = Color.New(var_364_4, var_364_4, var_364_4)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_3 and arg_361_1.time_ < 0 + var_364_3 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps1132 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_364_4 then
						iter_364_4.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_361_1.var_.actorSpriteComps1132 = nil
			end

			local var_364_5 = arg_361_1.actors_["10034"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_5) and arg_361_1.var_.actorSpriteComps10034 == nil then
				arg_361_1.var_.actorSpriteComps10034 = var_364_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_6 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_6 and not isNil(var_364_5) then
				if arg_361_1.var_.actorSpriteComps10034 then
					for iter_364_5, iter_364_6 in pairs(arg_361_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_364_6 then
							if arg_361_1.isInRecall_ then
								iter_364_6.color = Color.New(Mathf.Lerp(iter_364_6.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_6), Mathf.Lerp(iter_364_6.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_6), (Mathf.Lerp(iter_364_6.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_6)))
							else
								local var_364_7 = Mathf.Lerp(iter_364_6.color.r, 1, (arg_361_1.time_ - 0) / var_364_6)

								iter_364_6.color = Color.New(var_364_7, var_364_7, var_364_7)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_6 and arg_361_1.time_ < 0 + var_364_6 + arg_364_0 and not isNil(var_364_5) and arg_361_1.var_.actorSpriteComps10034 then
				for iter_364_7, iter_364_8 in pairs(arg_361_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_364_8 then
						iter_364_8.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps10034 = nil
			end

			local var_364_8 = 0
			local var_364_9 = 0.075

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_10 = arg_361_1:GetWordFromCfg(117041087)
				local var_364_11 = arg_361_1:FormatText(var_364_10.content)

				arg_361_1.text_.text = var_364_11

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_13 = 3 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 3)

				if (3 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 3)) > 0 and var_364_9 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_8
					end
				end

				arg_361_1.text_.text = var_364_11
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041087", "story_v_out_117041.awb") ~= 0 then
					local var_364_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041087", "story_v_out_117041.awb") / 1000

					if var_364_14 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_8
					end

					if var_364_10.prefab_name ~= "" and arg_361_1.actors_[var_364_10.prefab_name] ~= nil then
						local var_364_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_10.prefab_name].transform, "story_v_out_117041", "117041087", "story_v_out_117041.awb")

						arg_361_1:RecordAudio("117041087", var_364_15)
						arg_361_1:RecordAudio("117041087", var_364_15)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_117041", "117041087", "story_v_out_117041.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_117041", "117041087", "story_v_out_117041.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_16 = math.max(var_364_9, arg_361_1.talkMaxDuration)

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_16 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_8) / var_364_16

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_8 + var_364_16 and arg_361_1.time_ < var_364_8 + var_364_16 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play117041088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 117041088
		arg_365_1.duration_ = 12.5

		local var_365_0 = {
			zh = 12.5,
			ja = 8.7
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play117041089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.175

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(117041088)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 47 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 47)

				if (47 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 47)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041088", "story_v_out_117041.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041088", "story_v_out_117041.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_117041", "117041088", "story_v_out_117041.awb")

						arg_365_1:RecordAudio("117041088", var_368_6)
						arg_365_1:RecordAudio("117041088", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_117041", "117041088", "story_v_out_117041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_117041", "117041088", "story_v_out_117041.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play117041089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 117041089
		arg_369_1.duration_ = 4.87

		local var_369_0 = {
			zh = 2.366,
			ja = 4.866
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play117041090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1132 = arg_369_1.actors_["1132"].transform.localPosition
				arg_369_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1132", 2)

				for iter_372_0 = 0, arg_369_1.actors_["1132"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["1132"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_5" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_372_2 = arg_369_1.actors_["1132"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1132 == nil then
				arg_369_1.var_.actorSpriteComps1132 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps1132 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								iter_372_2.color = Color.New(Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_2.color.r, 1, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_2.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1132 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps1132 = nil
			end

			local var_372_5 = arg_369_1.actors_["10034"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps10034 == nil then
				arg_369_1.var_.actorSpriteComps10034 = var_372_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_6 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_6 and not isNil(var_372_5) then
				if arg_369_1.var_.actorSpriteComps10034 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_372_6 then
							if arg_369_1.isInRecall_ then
								iter_372_6.color = Color.New(Mathf.Lerp(iter_372_6.color.r, arg_369_1.hightColor2.r, (arg_369_1.time_ - 0) / var_372_6), Mathf.Lerp(iter_372_6.color.g, arg_369_1.hightColor2.g, (arg_369_1.time_ - 0) / var_372_6), (Mathf.Lerp(iter_372_6.color.b, arg_369_1.hightColor2.b, (arg_369_1.time_ - 0) / var_372_6)))
							else
								local var_372_7 = Mathf.Lerp(iter_372_6.color.r, 0.5, (arg_369_1.time_ - 0) / var_372_6)

								iter_372_6.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_6 and arg_369_1.time_ < 0 + var_372_6 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps10034 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_372_8 then
						iter_372_8.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps10034 = nil
			end

			local var_372_8 = 0
			local var_372_9 = 0.3

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_10 = arg_369_1:GetWordFromCfg(117041089)
				local var_372_11 = arg_369_1:FormatText(var_372_10.content)

				arg_369_1.text_.text = var_372_11

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 12 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 12)

				if (12 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 12)) > 0 and var_372_9 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_11
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041089", "story_v_out_117041.awb") ~= 0 then
					local var_372_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041089", "story_v_out_117041.awb") / 1000

					if var_372_14 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_14 + var_372_8
					end

					if var_372_10.prefab_name ~= "" and arg_369_1.actors_[var_372_10.prefab_name] ~= nil then
						local var_372_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_10.prefab_name].transform, "story_v_out_117041", "117041089", "story_v_out_117041.awb")

						arg_369_1:RecordAudio("117041089", var_372_15)
						arg_369_1:RecordAudio("117041089", var_372_15)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_117041", "117041089", "story_v_out_117041.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_117041", "117041089", "story_v_out_117041.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_16 and arg_369_1.time_ < var_372_8 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play117041090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 117041090
		arg_373_1.duration_ = 9.23

		local var_373_0 = {
			zh = 7.6,
			ja = 9.233
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
				arg_373_0:Play117041091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["10034"]) and arg_373_1.var_.actorSpriteComps10034 == nil then
				arg_373_1.var_.actorSpriteComps10034 = arg_373_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["10034"]) then
				if arg_373_1.var_.actorSpriteComps10034 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 1, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["10034"]) and arg_373_1.var_.actorSpriteComps10034 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps10034 = nil
			end

			local var_376_2 = arg_373_1.actors_["1132"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1132 == nil then
				arg_373_1.var_.actorSpriteComps1132 = var_376_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_3 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.actorSpriteComps1132 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								iter_376_5.color = Color.New(Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_3), Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_3), (Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_3)))
							else
								local var_376_4 = Mathf.Lerp(iter_376_5.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_3)

								iter_376_5.color = Color.New(var_376_4, var_376_4, var_376_4)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1132 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_376_7 then
						iter_376_7.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps1132 = nil
			end

			local var_376_5 = 0
			local var_376_6 = 0.825

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_7 = arg_373_1:GetWordFromCfg(117041090)
				local var_376_8 = arg_373_1:FormatText(var_376_7.content)

				arg_373_1.text_.text = var_376_8

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 33 <= 0 and var_376_6 or var_376_6 * (utf8.len(var_376_8) / 33)

				if (33 <= 0 and var_376_6 or var_376_6 * (utf8.len(var_376_8) / 33)) > 0 and var_376_6 < var_376_10 then
					arg_373_1.talkMaxDuration = var_376_10

					if var_376_10 + var_376_5 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_5
					end
				end

				arg_373_1.text_.text = var_376_8
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041090", "story_v_out_117041.awb") ~= 0 then
					local var_376_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041090", "story_v_out_117041.awb") / 1000

					if var_376_11 + var_376_5 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_11 + var_376_5
					end

					if var_376_7.prefab_name ~= "" and arg_373_1.actors_[var_376_7.prefab_name] ~= nil then
						local var_376_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_7.prefab_name].transform, "story_v_out_117041", "117041090", "story_v_out_117041.awb")

						arg_373_1:RecordAudio("117041090", var_376_12)
						arg_373_1:RecordAudio("117041090", var_376_12)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_117041", "117041090", "story_v_out_117041.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_117041", "117041090", "story_v_out_117041.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_13 = math.max(var_376_6, arg_373_1.talkMaxDuration)

			if var_376_5 <= arg_373_1.time_ and arg_373_1.time_ < var_376_5 + var_376_13 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_5) / var_376_13

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_5 + var_376_13 and arg_373_1.time_ < var_376_5 + var_376_13 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play117041091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 117041091
		arg_377_1.duration_ = 15

		local var_377_0 = {
			zh = 15,
			ja = 5.2
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play117041092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1132 = arg_377_1.actors_["1132"].transform.localPosition
				arg_377_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1132", 2)

				for iter_380_0 = 0, arg_377_1.actors_["1132"].transform.childCount - 1 do
					local var_380_0 = arg_377_1.actors_["1132"].transform:GetChild(iter_380_0)

					if var_380_0.name == "split_6" or not string.find(var_380_0.name, "split") then
						var_380_0.gameObject:SetActive(true)
					else
						var_380_0.gameObject:SetActive(false)
					end
				end
			end

			local var_380_1 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_1 then
				arg_377_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_377_1.time_ - 0) / var_380_1)
			end

			if arg_377_1.time_ >= 0 + var_380_1 and arg_377_1.time_ < 0 + var_380_1 + arg_380_0 then
				arg_377_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_380_2 = arg_377_1.actors_["10034"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps10034 == nil then
				arg_377_1.var_.actorSpriteComps10034 = var_380_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_3 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_3 and not isNil(var_380_2) then
				if arg_377_1.var_.actorSpriteComps10034 then
					for iter_380_1, iter_380_2 in pairs(arg_377_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_380_2 then
							if arg_377_1.isInRecall_ then
								iter_380_2.color = Color.New(Mathf.Lerp(iter_380_2.color.r, arg_377_1.hightColor2.r, (arg_377_1.time_ - 0) / var_380_3), Mathf.Lerp(iter_380_2.color.g, arg_377_1.hightColor2.g, (arg_377_1.time_ - 0) / var_380_3), (Mathf.Lerp(iter_380_2.color.b, arg_377_1.hightColor2.b, (arg_377_1.time_ - 0) / var_380_3)))
							else
								local var_380_4 = Mathf.Lerp(iter_380_2.color.r, 0.5, (arg_377_1.time_ - 0) / var_380_3)

								iter_380_2.color = Color.New(var_380_4, var_380_4, var_380_4)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_3 and arg_377_1.time_ < 0 + var_380_3 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps10034 then
				for iter_380_3, iter_380_4 in pairs(arg_377_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_380_4 then
						iter_380_4.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps10034 = nil
			end

			local var_380_5 = arg_377_1.actors_["1132"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.actorSpriteComps1132 == nil then
				arg_377_1.var_.actorSpriteComps1132 = var_380_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_6 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_6 and not isNil(var_380_5) then
				if arg_377_1.var_.actorSpriteComps1132 then
					for iter_380_5, iter_380_6 in pairs(arg_377_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_380_6 then
							if arg_377_1.isInRecall_ then
								iter_380_6.color = Color.New(Mathf.Lerp(iter_380_6.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_6), Mathf.Lerp(iter_380_6.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_6), (Mathf.Lerp(iter_380_6.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_6)))
							else
								local var_380_7 = Mathf.Lerp(iter_380_6.color.r, 1, (arg_377_1.time_ - 0) / var_380_6)

								iter_380_6.color = Color.New(var_380_7, var_380_7, var_380_7)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_6 and arg_377_1.time_ < 0 + var_380_6 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.actorSpriteComps1132 then
				for iter_380_7, iter_380_8 in pairs(arg_377_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_380_8 then
						iter_380_8.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps1132 = nil
			end

			local var_380_8 = 0
			local var_380_9 = 1.375

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_10 = arg_377_1:GetWordFromCfg(117041091)
				local var_380_11 = arg_377_1:FormatText(var_380_10.content)

				arg_377_1.text_.text = var_380_11

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_13 = 55 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 55)

				if (55 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_11) / 55)) > 0 and var_380_9 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_8
					end
				end

				arg_377_1.text_.text = var_380_11
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041091", "story_v_out_117041.awb") ~= 0 then
					local var_380_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041091", "story_v_out_117041.awb") / 1000

					if var_380_14 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_14 + var_380_8
					end

					if var_380_10.prefab_name ~= "" and arg_377_1.actors_[var_380_10.prefab_name] ~= nil then
						local var_380_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_10.prefab_name].transform, "story_v_out_117041", "117041091", "story_v_out_117041.awb")

						arg_377_1:RecordAudio("117041091", var_380_15)
						arg_377_1:RecordAudio("117041091", var_380_15)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_117041", "117041091", "story_v_out_117041.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_117041", "117041091", "story_v_out_117041.awb")
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
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play117041092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 117041092
		arg_381_1.duration_ = 3.8

		local var_381_0 = {
			zh = 3.8,
			ja = 1.833
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play117041093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10034 = arg_381_1.actors_["10034"].transform.localPosition
				arg_381_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10034", 4)

				for iter_384_0 = 0, arg_381_1.actors_["10034"].transform.childCount - 1 do
					local var_384_0 = arg_381_1.actors_["10034"].transform:GetChild(iter_384_0)

					if var_384_0.name == "split_2" or not string.find(var_384_0.name, "split") then
						var_384_0.gameObject:SetActive(true)
					else
						var_384_0.gameObject:SetActive(false)
					end
				end
			end

			local var_384_1 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_1 then
				arg_381_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_381_1.time_ - 0) / var_384_1)
			end

			if arg_381_1.time_ >= 0 + var_384_1 and arg_381_1.time_ < 0 + var_384_1 + arg_384_0 then
				arg_381_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_384_2 = arg_381_1.actors_["10034"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps10034 == nil then
				arg_381_1.var_.actorSpriteComps10034 = var_384_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_3 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.actorSpriteComps10034 then
					for iter_384_1, iter_384_2 in pairs(arg_381_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_384_2 then
							if arg_381_1.isInRecall_ then
								iter_384_2.color = Color.New(Mathf.Lerp(iter_384_2.color.r, arg_381_1.hightColor1.r, (arg_381_1.time_ - 0) / var_384_3), Mathf.Lerp(iter_384_2.color.g, arg_381_1.hightColor1.g, (arg_381_1.time_ - 0) / var_384_3), (Mathf.Lerp(iter_384_2.color.b, arg_381_1.hightColor1.b, (arg_381_1.time_ - 0) / var_384_3)))
							else
								local var_384_4 = Mathf.Lerp(iter_384_2.color.r, 1, (arg_381_1.time_ - 0) / var_384_3)

								iter_384_2.color = Color.New(var_384_4, var_384_4, var_384_4)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps10034 then
				for iter_384_3, iter_384_4 in pairs(arg_381_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_384_4 then
						iter_384_4.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps10034 = nil
			end

			local var_384_5 = arg_381_1.actors_["1132"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.actorSpriteComps1132 == nil then
				arg_381_1.var_.actorSpriteComps1132 = var_384_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_6 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_6 and not isNil(var_384_5) then
				if arg_381_1.var_.actorSpriteComps1132 then
					for iter_384_5, iter_384_6 in pairs(arg_381_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_384_6 then
							if arg_381_1.isInRecall_ then
								iter_384_6.color = Color.New(Mathf.Lerp(iter_384_6.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_6), Mathf.Lerp(iter_384_6.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_6), (Mathf.Lerp(iter_384_6.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_6)))
							else
								local var_384_7 = Mathf.Lerp(iter_384_6.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_6)

								iter_384_6.color = Color.New(var_384_7, var_384_7, var_384_7)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_6 and arg_381_1.time_ < 0 + var_384_6 + arg_384_0 and not isNil(var_384_5) and arg_381_1.var_.actorSpriteComps1132 then
				for iter_384_7, iter_384_8 in pairs(arg_381_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_384_8 then
						iter_384_8.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1132 = nil
			end

			local var_384_8 = 0
			local var_384_9 = 0.325

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_10 = arg_381_1:GetWordFromCfg(117041092)
				local var_384_11 = arg_381_1:FormatText(var_384_10.content)

				arg_381_1.text_.text = var_384_11

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_13 = 13 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_11) / 13)

				if (13 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_11) / 13)) > 0 and var_384_9 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_8
					end
				end

				arg_381_1.text_.text = var_384_11
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041092", "story_v_out_117041.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041092", "story_v_out_117041.awb") / 1000

					if var_384_14 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_8
					end

					if var_384_10.prefab_name ~= "" and arg_381_1.actors_[var_384_10.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_10.prefab_name].transform, "story_v_out_117041", "117041092", "story_v_out_117041.awb")

						arg_381_1:RecordAudio("117041092", var_384_15)
						arg_381_1:RecordAudio("117041092", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_117041", "117041092", "story_v_out_117041.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_117041", "117041092", "story_v_out_117041.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_9, arg_381_1.talkMaxDuration)

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_8) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_8 + var_384_16 and arg_381_1.time_ < var_384_8 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play117041093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 117041093
		arg_385_1.duration_ = 6.5

		local var_385_0 = {
			zh = 6.5,
			ja = 5.666
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play117041094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.675

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(117041093)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 27 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 27)

				if (27 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 27)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041093", "story_v_out_117041.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041093", "story_v_out_117041.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_117041", "117041093", "story_v_out_117041.awb")

						arg_385_1:RecordAudio("117041093", var_388_6)
						arg_385_1:RecordAudio("117041093", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_117041", "117041093", "story_v_out_117041.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_117041", "117041093", "story_v_out_117041.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play117041094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 117041094
		arg_389_1.duration_ = 7.63

		local var_389_0 = {
			zh = 7.333,
			ja = 7.633
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play117041095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1132 = arg_389_1.actors_["1132"].transform.localPosition
				arg_389_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1132", 2)

				for iter_392_0 = 0, arg_389_1.actors_["1132"].transform.childCount - 1 do
					local var_392_0 = arg_389_1.actors_["1132"].transform:GetChild(iter_392_0)

					if var_392_0.name == "split_2" or not string.find(var_392_0.name, "split") then
						var_392_0.gameObject:SetActive(true)
					else
						var_392_0.gameObject:SetActive(false)
					end
				end
			end

			local var_392_1 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_1 then
				arg_389_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_389_1.time_ - 0) / var_392_1)
			end

			if arg_389_1.time_ >= 0 + var_392_1 and arg_389_1.time_ < 0 + var_392_1 + arg_392_0 then
				arg_389_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_392_2 = arg_389_1.actors_["10034"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps10034 == nil then
				arg_389_1.var_.actorSpriteComps10034 = var_392_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_3 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 and not isNil(var_392_2) then
				if arg_389_1.var_.actorSpriteComps10034 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_392_2 then
							if arg_389_1.isInRecall_ then
								iter_392_2.color = Color.New(Mathf.Lerp(iter_392_2.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 0) / var_392_3), Mathf.Lerp(iter_392_2.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 0) / var_392_3), (Mathf.Lerp(iter_392_2.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 0) / var_392_3)))
							else
								local var_392_4 = Mathf.Lerp(iter_392_2.color.r, 0.5, (arg_389_1.time_ - 0) / var_392_3)

								iter_392_2.color = Color.New(var_392_4, var_392_4, var_392_4)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps10034 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_392_4 then
						iter_392_4.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps10034 = nil
			end

			local var_392_5 = arg_389_1.actors_["1132"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.actorSpriteComps1132 == nil then
				arg_389_1.var_.actorSpriteComps1132 = var_392_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_6 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_6 and not isNil(var_392_5) then
				if arg_389_1.var_.actorSpriteComps1132 then
					for iter_392_5, iter_392_6 in pairs(arg_389_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_392_6 then
							if arg_389_1.isInRecall_ then
								iter_392_6.color = Color.New(Mathf.Lerp(iter_392_6.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_6), Mathf.Lerp(iter_392_6.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_6), (Mathf.Lerp(iter_392_6.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_6)))
							else
								local var_392_7 = Mathf.Lerp(iter_392_6.color.r, 1, (arg_389_1.time_ - 0) / var_392_6)

								iter_392_6.color = Color.New(var_392_7, var_392_7, var_392_7)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_6 and arg_389_1.time_ < 0 + var_392_6 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.actorSpriteComps1132 then
				for iter_392_7, iter_392_8 in pairs(arg_389_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_392_8 then
						iter_392_8.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps1132 = nil
			end

			local var_392_8 = 0
			local var_392_9 = 0.875

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_10 = arg_389_1:GetWordFromCfg(117041094)
				local var_392_11 = arg_389_1:FormatText(var_392_10.content)

				arg_389_1.text_.text = var_392_11

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_13 = 35 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_11) / 35)

				if (35 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_11) / 35)) > 0 and var_392_9 < var_392_13 then
					arg_389_1.talkMaxDuration = var_392_13

					if var_392_13 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_8
					end
				end

				arg_389_1.text_.text = var_392_11
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041094", "story_v_out_117041.awb") ~= 0 then
					local var_392_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041094", "story_v_out_117041.awb") / 1000

					if var_392_14 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_14 + var_392_8
					end

					if var_392_10.prefab_name ~= "" and arg_389_1.actors_[var_392_10.prefab_name] ~= nil then
						local var_392_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_10.prefab_name].transform, "story_v_out_117041", "117041094", "story_v_out_117041.awb")

						arg_389_1:RecordAudio("117041094", var_392_15)
						arg_389_1:RecordAudio("117041094", var_392_15)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_117041", "117041094", "story_v_out_117041.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_117041", "117041094", "story_v_out_117041.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_16 = math.max(var_392_9, arg_389_1.talkMaxDuration)

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_16 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_8) / var_392_16

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_8 + var_392_16 and arg_389_1.time_ < var_392_8 + var_392_16 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play117041095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 117041095
		arg_393_1.duration_ = 8.67

		local var_393_0 = {
			zh = 7.5,
			ja = 8.666
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play117041096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.75

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:GetWordFromCfg(117041095)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 30 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 30)

				if (30 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 30)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041095", "story_v_out_117041.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041095", "story_v_out_117041.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_117041", "117041095", "story_v_out_117041.awb")

						arg_393_1:RecordAudio("117041095", var_396_6)
						arg_393_1:RecordAudio("117041095", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_117041", "117041095", "story_v_out_117041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_117041", "117041095", "story_v_out_117041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play117041096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 117041096
		arg_397_1.duration_ = 6.33

		local var_397_0 = {
			zh = 3.266,
			ja = 6.333
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play117041097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["10034"]) and arg_397_1.var_.actorSpriteComps10034 == nil then
				arg_397_1.var_.actorSpriteComps10034 = arg_397_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["10034"]) then
				if arg_397_1.var_.actorSpriteComps10034 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								iter_400_1.color = Color.New(Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_0), Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_0), (Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_0)))
							else
								local var_400_1 = Mathf.Lerp(iter_400_1.color.r, 1, (arg_397_1.time_ - 0) / var_400_0)

								iter_400_1.color = Color.New(var_400_1, var_400_1, var_400_1)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["10034"]) and arg_397_1.var_.actorSpriteComps10034 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps10034 = nil
			end

			local var_400_2 = arg_397_1.actors_["1132"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps1132 == nil then
				arg_397_1.var_.actorSpriteComps1132 = var_400_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_3 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 and not isNil(var_400_2) then
				if arg_397_1.var_.actorSpriteComps1132 then
					for iter_400_4, iter_400_5 in pairs(arg_397_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_400_5 then
							if arg_397_1.isInRecall_ then
								iter_400_5.color = Color.New(Mathf.Lerp(iter_400_5.color.r, arg_397_1.hightColor2.r, (arg_397_1.time_ - 0) / var_400_3), Mathf.Lerp(iter_400_5.color.g, arg_397_1.hightColor2.g, (arg_397_1.time_ - 0) / var_400_3), (Mathf.Lerp(iter_400_5.color.b, arg_397_1.hightColor2.b, (arg_397_1.time_ - 0) / var_400_3)))
							else
								local var_400_4 = Mathf.Lerp(iter_400_5.color.r, 0.5, (arg_397_1.time_ - 0) / var_400_3)

								iter_400_5.color = Color.New(var_400_4, var_400_4, var_400_4)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps1132 then
				for iter_400_6, iter_400_7 in pairs(arg_397_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_400_7 then
						iter_400_7.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps1132 = nil
			end

			local var_400_5 = 0
			local var_400_6 = 0.325

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_7 = arg_397_1:GetWordFromCfg(117041096)
				local var_400_8 = arg_397_1:FormatText(var_400_7.content)

				arg_397_1.text_.text = var_400_8

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_10 = 13 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_8) / 13)

				if (13 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_8) / 13)) > 0 and var_400_6 < var_400_10 then
					arg_397_1.talkMaxDuration = var_400_10

					if var_400_10 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_5
					end
				end

				arg_397_1.text_.text = var_400_8
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041096", "story_v_out_117041.awb") ~= 0 then
					local var_400_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041096", "story_v_out_117041.awb") / 1000

					if var_400_11 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_11 + var_400_5
					end

					if var_400_7.prefab_name ~= "" and arg_397_1.actors_[var_400_7.prefab_name] ~= nil then
						local var_400_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_7.prefab_name].transform, "story_v_out_117041", "117041096", "story_v_out_117041.awb")

						arg_397_1:RecordAudio("117041096", var_400_12)
						arg_397_1:RecordAudio("117041096", var_400_12)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_117041", "117041096", "story_v_out_117041.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_117041", "117041096", "story_v_out_117041.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_13 = math.max(var_400_6, arg_397_1.talkMaxDuration)

			if var_400_5 <= arg_397_1.time_ and arg_397_1.time_ < var_400_5 + var_400_13 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_5) / var_400_13

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_5 + var_400_13 and arg_397_1.time_ < var_400_5 + var_400_13 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play117041097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 117041097
		arg_401_1.duration_ = 2.3

		local var_401_0 = {
			zh = 2.3,
			ja = 0.999999999999
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play117041098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1132 = arg_401_1.actors_["1132"].transform.localPosition
				arg_401_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("1132", 2)

				for iter_404_0 = 0, arg_401_1.actors_["1132"].transform.childCount - 1 do
					local var_404_0 = arg_401_1.actors_["1132"].transform:GetChild(iter_404_0)

					if var_404_0.name == "split_6" or not string.find(var_404_0.name, "split") then
						var_404_0.gameObject:SetActive(true)
					else
						var_404_0.gameObject:SetActive(false)
					end
				end
			end

			local var_404_1 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_1 then
				arg_401_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_401_1.time_ - 0) / var_404_1)
			end

			if arg_401_1.time_ >= 0 + var_404_1 and arg_401_1.time_ < 0 + var_404_1 + arg_404_0 then
				arg_401_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_404_2 = arg_401_1.actors_["10034"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps10034 == nil then
				arg_401_1.var_.actorSpriteComps10034 = var_404_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_3 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 and not isNil(var_404_2) then
				if arg_401_1.var_.actorSpriteComps10034 then
					for iter_404_1, iter_404_2 in pairs(arg_401_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_404_2 then
							if arg_401_1.isInRecall_ then
								iter_404_2.color = Color.New(Mathf.Lerp(iter_404_2.color.r, arg_401_1.hightColor2.r, (arg_401_1.time_ - 0) / var_404_3), Mathf.Lerp(iter_404_2.color.g, arg_401_1.hightColor2.g, (arg_401_1.time_ - 0) / var_404_3), (Mathf.Lerp(iter_404_2.color.b, arg_401_1.hightColor2.b, (arg_401_1.time_ - 0) / var_404_3)))
							else
								local var_404_4 = Mathf.Lerp(iter_404_2.color.r, 0.5, (arg_401_1.time_ - 0) / var_404_3)

								iter_404_2.color = Color.New(var_404_4, var_404_4, var_404_4)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps10034 then
				for iter_404_3, iter_404_4 in pairs(arg_401_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_404_4 then
						iter_404_4.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_401_1.var_.actorSpriteComps10034 = nil
			end

			local var_404_5 = arg_401_1.actors_["1132"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_5) and arg_401_1.var_.actorSpriteComps1132 == nil then
				arg_401_1.var_.actorSpriteComps1132 = var_404_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_6 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_6 and not isNil(var_404_5) then
				if arg_401_1.var_.actorSpriteComps1132 then
					for iter_404_5, iter_404_6 in pairs(arg_401_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_404_6 then
							if arg_401_1.isInRecall_ then
								iter_404_6.color = Color.New(Mathf.Lerp(iter_404_6.color.r, arg_401_1.hightColor1.r, (arg_401_1.time_ - 0) / var_404_6), Mathf.Lerp(iter_404_6.color.g, arg_401_1.hightColor1.g, (arg_401_1.time_ - 0) / var_404_6), (Mathf.Lerp(iter_404_6.color.b, arg_401_1.hightColor1.b, (arg_401_1.time_ - 0) / var_404_6)))
							else
								local var_404_7 = Mathf.Lerp(iter_404_6.color.r, 1, (arg_401_1.time_ - 0) / var_404_6)

								iter_404_6.color = Color.New(var_404_7, var_404_7, var_404_7)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_6 and arg_401_1.time_ < 0 + var_404_6 + arg_404_0 and not isNil(var_404_5) and arg_401_1.var_.actorSpriteComps1132 then
				for iter_404_7, iter_404_8 in pairs(arg_401_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_404_8 then
						iter_404_8.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_401_1.var_.actorSpriteComps1132 = nil
			end

			local var_404_8 = 0
			local var_404_9 = 0.275

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_8 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_10 = arg_401_1:GetWordFromCfg(117041097)
				local var_404_11 = arg_401_1:FormatText(var_404_10.content)

				arg_401_1.text_.text = var_404_11

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_13 = 11 <= 0 and var_404_9 or var_404_9 * (utf8.len(var_404_11) / 11)

				if (11 <= 0 and var_404_9 or var_404_9 * (utf8.len(var_404_11) / 11)) > 0 and var_404_9 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_8 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_8
					end
				end

				arg_401_1.text_.text = var_404_11
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041097", "story_v_out_117041.awb") ~= 0 then
					local var_404_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041097", "story_v_out_117041.awb") / 1000

					if var_404_14 + var_404_8 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_14 + var_404_8
					end

					if var_404_10.prefab_name ~= "" and arg_401_1.actors_[var_404_10.prefab_name] ~= nil then
						local var_404_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_10.prefab_name].transform, "story_v_out_117041", "117041097", "story_v_out_117041.awb")

						arg_401_1:RecordAudio("117041097", var_404_15)
						arg_401_1:RecordAudio("117041097", var_404_15)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_117041", "117041097", "story_v_out_117041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_117041", "117041097", "story_v_out_117041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_16 = math.max(var_404_9, arg_401_1.talkMaxDuration)

			if var_404_8 <= arg_401_1.time_ and arg_401_1.time_ < var_404_8 + var_404_16 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_8) / var_404_16

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_8 + var_404_16 and arg_401_1.time_ < var_404_8 + var_404_16 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play117041098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 117041098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play117041099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1132"]) and arg_405_1.var_.actorSpriteComps1132 == nil then
				arg_405_1.var_.actorSpriteComps1132 = arg_405_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_0 = 0.2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1132"]) then
				if arg_405_1.var_.actorSpriteComps1132 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								iter_408_1.color = Color.New(Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor2.r, (arg_405_1.time_ - 0) / var_408_0), Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor2.g, (arg_405_1.time_ - 0) / var_408_0), (Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor2.b, (arg_405_1.time_ - 0) / var_408_0)))
							else
								local var_408_1 = Mathf.Lerp(iter_408_1.color.r, 0.5, (arg_405_1.time_ - 0) / var_408_0)

								iter_408_1.color = Color.New(var_408_1, var_408_1, var_408_1)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1132"]) and arg_405_1.var_.actorSpriteComps1132 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_408_3 then
						iter_408_3.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_405_1.var_.actorSpriteComps1132 = nil
			end

			local var_408_2 = 0
			local var_408_3 = 0.45

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_4 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(117041098).content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_6 = 18 <= 0 and var_408_3 or var_408_3 * (utf8.len(var_408_4) / 18)

				if (18 <= 0 and var_408_3 or var_408_3 * (utf8.len(var_408_4) / 18)) > 0 and var_408_3 < var_408_6 then
					arg_405_1.talkMaxDuration = var_408_6

					if var_408_6 + var_408_2 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_6 + var_408_2
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_3, arg_405_1.talkMaxDuration)

			if var_408_2 <= arg_405_1.time_ and arg_405_1.time_ < var_408_2 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_2) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_2 + var_408_7 and arg_405_1.time_ < var_408_2 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play117041099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 117041099
		arg_409_1.duration_ = 3.8

		local var_409_0 = {
			zh = 3.8,
			ja = 3
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play117041100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1132"]) and arg_409_1.var_.actorSpriteComps1132 == nil then
				arg_409_1.var_.actorSpriteComps1132 = arg_409_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1132"]) then
				if arg_409_1.var_.actorSpriteComps1132 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								iter_412_1.color = Color.New(Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_0), Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_0), (Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_0)))
							else
								local var_412_1 = Mathf.Lerp(iter_412_1.color.r, 1, (arg_409_1.time_ - 0) / var_412_0)

								iter_412_1.color = Color.New(var_412_1, var_412_1, var_412_1)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1132"]) and arg_409_1.var_.actorSpriteComps1132 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_412_3 then
						iter_412_3.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps1132 = nil
			end

			local var_412_2 = 0
			local var_412_3 = 0.275

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:GetWordFromCfg(117041099)
				local var_412_5 = arg_409_1:FormatText(var_412_4.content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 11 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 11)

				if (11 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 11)) > 0 and var_412_3 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041099", "story_v_out_117041.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041099", "story_v_out_117041.awb") / 1000

					if var_412_8 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_2
					end

					if var_412_4.prefab_name ~= "" and arg_409_1.actors_[var_412_4.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_4.prefab_name].transform, "story_v_out_117041", "117041099", "story_v_out_117041.awb")

						arg_409_1:RecordAudio("117041099", var_412_9)
						arg_409_1:RecordAudio("117041099", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_117041", "117041099", "story_v_out_117041.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_117041", "117041099", "story_v_out_117041.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_10 and arg_409_1.time_ < var_412_2 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play117041100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 117041100
		arg_413_1.duration_ = 7.7

		local var_413_0 = {
			zh = 7.7,
			ja = 4.666
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play117041101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.725

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:GetWordFromCfg(117041100)
				local var_416_2 = arg_413_1:FormatText(var_416_1.content)

				arg_413_1.text_.text = var_416_2

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 29 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 29)

				if (29 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 29)) > 0 and var_416_0 < var_416_4 then
					arg_413_1.talkMaxDuration = var_416_4

					if var_416_4 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_4 + 0
					end
				end

				arg_413_1.text_.text = var_416_2
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041100", "story_v_out_117041.awb") ~= 0 then
					local var_416_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041100", "story_v_out_117041.awb") / 1000

					if var_416_5 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + 0
					end

					if var_416_1.prefab_name ~= "" and arg_413_1.actors_[var_416_1.prefab_name] ~= nil then
						local var_416_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_1.prefab_name].transform, "story_v_out_117041", "117041100", "story_v_out_117041.awb")

						arg_413_1:RecordAudio("117041100", var_416_6)
						arg_413_1:RecordAudio("117041100", var_416_6)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_117041", "117041100", "story_v_out_117041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_117041", "117041100", "story_v_out_117041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_7 and arg_413_1.time_ < 0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play117041101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 117041101
		arg_417_1.duration_ = 4.63

		local var_417_0 = {
			zh = 3.366,
			ja = 4.633
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play117041102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1132"]) and arg_417_1.var_.actorSpriteComps1132 == nil then
				arg_417_1.var_.actorSpriteComps1132 = arg_417_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1132"]) then
				if arg_417_1.var_.actorSpriteComps1132 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								iter_420_1.color = Color.New(Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor2.r, (arg_417_1.time_ - 0) / var_420_0), Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor2.g, (arg_417_1.time_ - 0) / var_420_0), (Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor2.b, (arg_417_1.time_ - 0) / var_420_0)))
							else
								local var_420_1 = Mathf.Lerp(iter_420_1.color.r, 0.5, (arg_417_1.time_ - 0) / var_420_0)

								iter_420_1.color = Color.New(var_420_1, var_420_1, var_420_1)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1132"]) and arg_417_1.var_.actorSpriteComps1132 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_417_1.var_.actorSpriteComps1132 = nil
			end

			local var_420_2 = arg_417_1.actors_["10034"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps10034 == nil then
				arg_417_1.var_.actorSpriteComps10034 = var_420_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_3 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_3 and not isNil(var_420_2) then
				if arg_417_1.var_.actorSpriteComps10034 then
					for iter_420_4, iter_420_5 in pairs(arg_417_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_420_5 then
							if arg_417_1.isInRecall_ then
								iter_420_5.color = Color.New(Mathf.Lerp(iter_420_5.color.r, arg_417_1.hightColor1.r, (arg_417_1.time_ - 0) / var_420_3), Mathf.Lerp(iter_420_5.color.g, arg_417_1.hightColor1.g, (arg_417_1.time_ - 0) / var_420_3), (Mathf.Lerp(iter_420_5.color.b, arg_417_1.hightColor1.b, (arg_417_1.time_ - 0) / var_420_3)))
							else
								local var_420_4 = Mathf.Lerp(iter_420_5.color.r, 1, (arg_417_1.time_ - 0) / var_420_3)

								iter_420_5.color = Color.New(var_420_4, var_420_4, var_420_4)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_3 and arg_417_1.time_ < 0 + var_420_3 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps10034 then
				for iter_420_6, iter_420_7 in pairs(arg_417_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_420_7 then
						iter_420_7.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps10034 = nil
			end

			local var_420_5 = 0
			local var_420_6 = 0.225

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_5 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_7 = arg_417_1:GetWordFromCfg(117041101)
				local var_420_8 = arg_417_1:FormatText(var_420_7.content)

				arg_417_1.text_.text = var_420_8

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_10 = 9 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 9)

				if (9 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 9)) > 0 and var_420_6 < var_420_10 then
					arg_417_1.talkMaxDuration = var_420_10

					if var_420_10 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_5
					end
				end

				arg_417_1.text_.text = var_420_8
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041101", "story_v_out_117041.awb") ~= 0 then
					local var_420_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041101", "story_v_out_117041.awb") / 1000

					if var_420_11 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_11 + var_420_5
					end

					if var_420_7.prefab_name ~= "" and arg_417_1.actors_[var_420_7.prefab_name] ~= nil then
						local var_420_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_7.prefab_name].transform, "story_v_out_117041", "117041101", "story_v_out_117041.awb")

						arg_417_1:RecordAudio("117041101", var_420_12)
						arg_417_1:RecordAudio("117041101", var_420_12)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_117041", "117041101", "story_v_out_117041.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_117041", "117041101", "story_v_out_117041.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_13 = math.max(var_420_6, arg_417_1.talkMaxDuration)

			if var_420_5 <= arg_417_1.time_ and arg_417_1.time_ < var_420_5 + var_420_13 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_5) / var_420_13

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_5 + var_420_13 and arg_417_1.time_ < var_420_5 + var_420_13 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play117041102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 117041102
		arg_421_1.duration_ = 9

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play117041103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if arg_421_1.bgs_.TI0103 == nil then
				local var_424_0 = Object.Instantiate(arg_421_1.paintGo_)

				var_424_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "TI0103")
				var_424_0.name = "TI0103"
				var_424_0.transform.parent = arg_421_1.stage_.transform
				var_424_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.bgs_.TI0103 = var_424_0
			end

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= 2 + arg_424_0 then
				local var_424_1 = arg_421_1.bgs_.TI0103

				arg_421_1.bgs_.TI0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_424_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_424_2 = var_424_1:GetComponent("SpriteRenderer")

				if var_424_2 and var_424_2.sprite then
					local var_424_3 = 2 * (var_424_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_424_1.transform.localScale = Vector3.New(var_424_3 / var_424_2.sprite.bounds.size.y < var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x and var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x or var_424_3 / var_424_2.sprite.bounds.size.y, var_424_3 / var_424_2.sprite.bounds.size.y < var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x and var_424_3 * manager.ui.mainCameraCom_.aspect / var_424_2.sprite.bounds.size.x or var_424_3 / var_424_2.sprite.bounds.size.y, 0)
				end

				for iter_424_0, iter_424_1 in pairs(arg_421_1.bgs_) do
					if iter_424_0 ~= "TI0103" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_4 = 0

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_5 = 2

			if var_424_4 <= arg_421_1.time_ and arg_421_1.time_ < var_424_4 + var_424_5 then
				local var_424_6 = Color.New(0, 0, 0)

				var_424_6.a = Mathf.Lerp(0, 1, (arg_421_1.time_ - var_424_4) / var_424_5)
				arg_421_1.mask_.color = var_424_6
			end

			if arg_421_1.time_ >= var_424_4 + var_424_5 and arg_421_1.time_ < var_424_4 + var_424_5 + arg_424_0 then
				local var_424_7 = Color.New(0, 0, 0)

				var_424_7.a = 1
				arg_421_1.mask_.color = var_424_7
			end

			local var_424_8 = 2

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_9 = 2

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_9 then
				local var_424_10 = Color.New(0, 0, 0)

				var_424_10.a = Mathf.Lerp(1, 0, (arg_421_1.time_ - var_424_8) / var_424_9)
				arg_421_1.mask_.color = var_424_10
			end

			if arg_421_1.time_ >= var_424_8 + var_424_9 and arg_421_1.time_ < var_424_8 + var_424_9 + arg_424_0 then
				local var_424_11 = Color.New(0, 0, 0)

				arg_421_1.mask_.enabled = false
				var_424_11.a = 0
				arg_421_1.mask_.color = var_424_11
			end

			local var_424_12 = arg_421_1.actors_["1132"].transform

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= 2 + arg_424_0 then
				arg_421_1.var_.moveOldPos1132 = var_424_12.localPosition
				var_424_12.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("1132", 7)

				for iter_424_2 = 0, var_424_12.childCount - 1 do
					local var_424_13 = var_424_12:GetChild(iter_424_2)

					if var_424_13.name == "split_6" or not string.find(var_424_13.name, "split") then
						var_424_13.gameObject:SetActive(true)
					else
						var_424_13.gameObject:SetActive(false)
					end
				end
			end

			local var_424_14 = 0.001

			if 2 <= arg_421_1.time_ and arg_421_1.time_ < 2 + var_424_14 then
				var_424_12.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1132, Vector3.New(0, -2000, -185), (arg_421_1.time_ - 2) / var_424_14)
			end

			if arg_421_1.time_ >= 2 + var_424_14 and arg_421_1.time_ < 2 + var_424_14 + arg_424_0 then
				var_424_12.localPosition = Vector3.New(0, -2000, -185)
			end

			local var_424_15 = arg_421_1.actors_["10034"].transform

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= 2 + arg_424_0 then
				arg_421_1.var_.moveOldPos10034 = var_424_15.localPosition
				var_424_15.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("10034", 7)

				for iter_424_3 = 0, var_424_15.childCount - 1 do
					local var_424_16 = var_424_15:GetChild(iter_424_3)

					if var_424_16.name == "split_2" or not string.find(var_424_16.name, "split") then
						var_424_16.gameObject:SetActive(true)
					else
						var_424_16.gameObject:SetActive(false)
					end
				end
			end

			local var_424_17 = 0.001

			if 2 <= arg_421_1.time_ and arg_421_1.time_ < 2 + var_424_17 then
				var_424_15.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10034, Vector3.New(0, -2000, -290), (arg_421_1.time_ - 2) / var_424_17)
			end

			if arg_421_1.time_ >= 2 + var_424_17 and arg_421_1.time_ < 2 + var_424_17 + arg_424_0 then
				var_424_15.localPosition = Vector3.New(0, -2000, -290)
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_18 = 4
			local var_424_19 = 0.65

			if 4 < arg_421_1.time_ and arg_421_1.time_ <= var_424_18 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_20 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_20:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_21 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(117041102).content)

				arg_421_1.text_.text = var_424_21

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_23 = 26 <= 0 and var_424_19 or var_424_19 * (utf8.len(var_424_21) / 26)

				if (26 <= 0 and var_424_19 or var_424_19 * (utf8.len(var_424_21) / 26)) > 0 and var_424_19 < var_424_23 then
					arg_421_1.talkMaxDuration = var_424_23
					var_424_18 = var_424_18 + 0.3

					if var_424_23 + var_424_18 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_23 + var_424_18
					end
				end

				arg_421_1.text_.text = var_424_21
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_24 = var_424_18 + 0.3
			local var_424_25 = math.max(var_424_19, arg_421_1.talkMaxDuration)

			if var_424_18 + 0.3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_24 + var_424_25 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_24) / var_424_25

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_24 + var_424_25 and arg_421_1.time_ < var_424_24 + var_424_25 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play117041103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 117041103
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play117041104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 1.125

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(117041103).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 45 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 45)

				if (45 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 45)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play117041104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 117041104
		arg_431_1.duration_ = 7.43

		local var_431_0 = {
			zh = 3.433,
			ja = 7.433
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play117041105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.35

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_1 = arg_431_1:GetWordFromCfg(117041104)
				local var_434_2 = arg_431_1:FormatText(var_434_1.content)

				arg_431_1.text_.text = var_434_2

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 14 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_2) / 14)

				if (14 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_2) / 14)) > 0 and var_434_0 < var_434_4 then
					arg_431_1.talkMaxDuration = var_434_4

					if var_434_4 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_4 + 0
					end
				end

				arg_431_1.text_.text = var_434_2
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041104", "story_v_out_117041.awb") ~= 0 then
					local var_434_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041104", "story_v_out_117041.awb") / 1000

					if var_434_5 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + 0
					end

					if var_434_1.prefab_name ~= "" and arg_431_1.actors_[var_434_1.prefab_name] ~= nil then
						local var_434_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_1.prefab_name].transform, "story_v_out_117041", "117041104", "story_v_out_117041.awb")

						arg_431_1:RecordAudio("117041104", var_434_6)
						arg_431_1:RecordAudio("117041104", var_434_6)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_117041", "117041104", "story_v_out_117041.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_117041", "117041104", "story_v_out_117041.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_7 and arg_431_1.time_ < 0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play117041105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 117041105
		arg_435_1.duration_ = 1.6

		local var_435_0 = {
			zh = 1.6,
			ja = 1.333
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play117041106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.125

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:GetWordFromCfg(117041105)
				local var_438_2 = arg_435_1:FormatText(var_438_1.content)

				arg_435_1.text_.text = var_438_2

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 5 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 5)

				if (5 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 5)) > 0 and var_438_0 < var_438_4 then
					arg_435_1.talkMaxDuration = var_438_4

					if var_438_4 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_4 + 0
					end
				end

				arg_435_1.text_.text = var_438_2
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041105", "story_v_out_117041.awb") ~= 0 then
					local var_438_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041105", "story_v_out_117041.awb") / 1000

					if var_438_5 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + 0
					end

					if var_438_1.prefab_name ~= "" and arg_435_1.actors_[var_438_1.prefab_name] ~= nil then
						local var_438_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_1.prefab_name].transform, "story_v_out_117041", "117041105", "story_v_out_117041.awb")

						arg_435_1:RecordAudio("117041105", var_438_6)
						arg_435_1:RecordAudio("117041105", var_438_6)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_117041", "117041105", "story_v_out_117041.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_117041", "117041105", "story_v_out_117041.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_7 and arg_435_1.time_ < 0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play117041106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 117041106
		arg_439_1.duration_ = 15.4

		local var_439_0 = {
			zh = 13.3,
			ja = 15.4
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play117041107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 1.5

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:GetWordFromCfg(117041106)
				local var_442_2 = arg_439_1:FormatText(var_442_1.content)

				arg_439_1.text_.text = var_442_2

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 60 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 60)

				if (60 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 60)) > 0 and var_442_0 < var_442_4 then
					arg_439_1.talkMaxDuration = var_442_4

					if var_442_4 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_4 + 0
					end
				end

				arg_439_1.text_.text = var_442_2
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041106", "story_v_out_117041.awb") ~= 0 then
					local var_442_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041106", "story_v_out_117041.awb") / 1000

					if var_442_5 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + 0
					end

					if var_442_1.prefab_name ~= "" and arg_439_1.actors_[var_442_1.prefab_name] ~= nil then
						local var_442_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_1.prefab_name].transform, "story_v_out_117041", "117041106", "story_v_out_117041.awb")

						arg_439_1:RecordAudio("117041106", var_442_6)
						arg_439_1:RecordAudio("117041106", var_442_6)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_117041", "117041106", "story_v_out_117041.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_117041", "117041106", "story_v_out_117041.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_7 and arg_439_1.time_ < 0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play117041107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 117041107
		arg_443_1.duration_ = 16.43

		local var_443_0 = {
			zh = 14.733,
			ja = 16.433
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play117041108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 1.55

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:GetWordFromCfg(117041107)
				local var_446_2 = arg_443_1:FormatText(var_446_1.content)

				arg_443_1.text_.text = var_446_2

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_4 = 62 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 62)

				if (62 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 62)) > 0 and var_446_0 < var_446_4 then
					arg_443_1.talkMaxDuration = var_446_4

					if var_446_4 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_4 + 0
					end
				end

				arg_443_1.text_.text = var_446_2
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041107", "story_v_out_117041.awb") ~= 0 then
					local var_446_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041107", "story_v_out_117041.awb") / 1000

					if var_446_5 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + 0
					end

					if var_446_1.prefab_name ~= "" and arg_443_1.actors_[var_446_1.prefab_name] ~= nil then
						local var_446_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_1.prefab_name].transform, "story_v_out_117041", "117041107", "story_v_out_117041.awb")

						arg_443_1:RecordAudio("117041107", var_446_6)
						arg_443_1:RecordAudio("117041107", var_446_6)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_117041", "117041107", "story_v_out_117041.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_117041", "117041107", "story_v_out_117041.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_7 and arg_443_1.time_ < 0 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play117041108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 117041108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play117041109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.45

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(117041108).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 18 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 18)

				if (18 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 18)) > 0 and var_450_0 < var_450_3 then
					arg_447_1.talkMaxDuration = var_450_3

					if var_450_3 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_3 + 0
					end
				end

				arg_447_1.text_.text = var_450_1
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_4 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_4

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play117041109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 117041109
		arg_451_1.duration_ = 4.5

		local var_451_0 = {
			zh = 4.5,
			ja = 2.8
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play117041110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0.525

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:GetWordFromCfg(117041109)
				local var_454_2 = arg_451_1:FormatText(var_454_1.content)

				arg_451_1.text_.text = var_454_2

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 21 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 21)

				if (21 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 21)) > 0 and var_454_0 < var_454_4 then
					arg_451_1.talkMaxDuration = var_454_4

					if var_454_4 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_4 + 0
					end
				end

				arg_451_1.text_.text = var_454_2
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041109", "story_v_out_117041.awb") ~= 0 then
					local var_454_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041109", "story_v_out_117041.awb") / 1000

					if var_454_5 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + 0
					end

					if var_454_1.prefab_name ~= "" and arg_451_1.actors_[var_454_1.prefab_name] ~= nil then
						local var_454_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_1.prefab_name].transform, "story_v_out_117041", "117041109", "story_v_out_117041.awb")

						arg_451_1:RecordAudio("117041109", var_454_6)
						arg_451_1:RecordAudio("117041109", var_454_6)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_117041", "117041109", "story_v_out_117041.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_117041", "117041109", "story_v_out_117041.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play117041110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 117041110
		arg_455_1.duration_ = 14.23

		local var_455_0 = {
			zh = 14.233,
			ja = 11.7
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play117041111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 1.5

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_1")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_1 = arg_455_1:GetWordFromCfg(117041110)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 60 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 60)

				if (60 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 60)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041110", "story_v_out_117041.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041110", "story_v_out_117041.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_out_117041", "117041110", "story_v_out_117041.awb")

						arg_455_1:RecordAudio("117041110", var_458_6)
						arg_455_1:RecordAudio("117041110", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_117041", "117041110", "story_v_out_117041.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_117041", "117041110", "story_v_out_117041.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_7 and arg_455_1.time_ < 0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play117041111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 117041111
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play117041112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 1.275

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(117041111).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 51 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 51)

				if (51 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 51)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play117041112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 117041112
		arg_463_1.duration_ = 8.63

		local var_463_0 = {
			zh = 7,
			ja = 8.633
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play117041113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.775

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:GetWordFromCfg(117041112)
				local var_466_2 = arg_463_1:FormatText(var_466_1.content)

				arg_463_1.text_.text = var_466_2

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 31 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 31)

				if (31 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 31)) > 0 and var_466_0 < var_466_4 then
					arg_463_1.talkMaxDuration = var_466_4

					if var_466_4 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_4 + 0
					end
				end

				arg_463_1.text_.text = var_466_2
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041112", "story_v_out_117041.awb") ~= 0 then
					local var_466_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041112", "story_v_out_117041.awb") / 1000

					if var_466_5 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + 0
					end

					if var_466_1.prefab_name ~= "" and arg_463_1.actors_[var_466_1.prefab_name] ~= nil then
						local var_466_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_1.prefab_name].transform, "story_v_out_117041", "117041112", "story_v_out_117041.awb")

						arg_463_1:RecordAudio("117041112", var_466_6)
						arg_463_1:RecordAudio("117041112", var_466_6)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_117041", "117041112", "story_v_out_117041.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_117041", "117041112", "story_v_out_117041.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_7 and arg_463_1.time_ < 0 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play117041113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 117041113
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play117041114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.9

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_1 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(117041113).content)

				arg_467_1.text_.text = var_470_1

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_3 = 36 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 36)

				if (36 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 36)) > 0 and var_470_0 < var_470_3 then
					arg_467_1.talkMaxDuration = var_470_3

					if var_470_3 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_3 + 0
					end
				end

				arg_467_1.text_.text = var_470_1
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_4 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_4

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play117041114 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 117041114
		arg_471_1.duration_ = 1

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play117041115(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.05

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_1 = arg_471_1:GetWordFromCfg(117041114)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 2 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 2)

				if (2 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 2)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041114", "story_v_out_117041.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041114", "story_v_out_117041.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_out_117041", "117041114", "story_v_out_117041.awb")

						arg_471_1:RecordAudio("117041114", var_474_6)
						arg_471_1:RecordAudio("117041114", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_117041", "117041114", "story_v_out_117041.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_117041", "117041114", "story_v_out_117041.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_7 and arg_471_1.time_ < 0 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play117041115 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 117041115
		arg_475_1.duration_ = 18.77

		local var_475_0 = {
			zh = 12.6,
			ja = 18.766
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play117041116(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 1.025

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_3")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_1 = arg_475_1:GetWordFromCfg(117041115)
				local var_478_2 = arg_475_1:FormatText(var_478_1.content)

				arg_475_1.text_.text = var_478_2

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_4 = 41 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 41)

				if (41 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 41)) > 0 and var_478_0 < var_478_4 then
					arg_475_1.talkMaxDuration = var_478_4

					if var_478_4 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_4 + 0
					end
				end

				arg_475_1.text_.text = var_478_2
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041115", "story_v_out_117041.awb") ~= 0 then
					local var_478_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041115", "story_v_out_117041.awb") / 1000

					if var_478_5 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_5 + 0
					end

					if var_478_1.prefab_name ~= "" and arg_475_1.actors_[var_478_1.prefab_name] ~= nil then
						local var_478_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_1.prefab_name].transform, "story_v_out_117041", "117041115", "story_v_out_117041.awb")

						arg_475_1:RecordAudio("117041115", var_478_6)
						arg_475_1:RecordAudio("117041115", var_478_6)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_117041", "117041115", "story_v_out_117041.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_117041", "117041115", "story_v_out_117041.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_7 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_7 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_7

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_7 and arg_475_1.time_ < 0 + var_478_7 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play117041116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 117041116
		arg_479_1.duration_ = 9.77

		local var_479_0 = {
			zh = 9.766,
			ja = 7.166
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play117041117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 1

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:GetWordFromCfg(117041116)
				local var_482_2 = arg_479_1:FormatText(var_482_1.content)

				arg_479_1.text_.text = var_482_2

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 40 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 40)

				if (40 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 40)) > 0 and var_482_0 < var_482_4 then
					arg_479_1.talkMaxDuration = var_482_4

					if var_482_4 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_4 + 0
					end
				end

				arg_479_1.text_.text = var_482_2
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041116", "story_v_out_117041.awb") ~= 0 then
					local var_482_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041116", "story_v_out_117041.awb") / 1000

					if var_482_5 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + 0
					end

					if var_482_1.prefab_name ~= "" and arg_479_1.actors_[var_482_1.prefab_name] ~= nil then
						local var_482_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_1.prefab_name].transform, "story_v_out_117041", "117041116", "story_v_out_117041.awb")

						arg_479_1:RecordAudio("117041116", var_482_6)
						arg_479_1:RecordAudio("117041116", var_482_6)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_117041", "117041116", "story_v_out_117041.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_117041", "117041116", "story_v_out_117041.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play117041117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 117041117
		arg_483_1.duration_ = 5.6

		local var_483_0 = {
			zh = 5.066,
			ja = 5.6
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play117041118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.475

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:GetWordFromCfg(117041117)
				local var_486_2 = arg_483_1:FormatText(var_486_1.content)

				arg_483_1.text_.text = var_486_2

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 19 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 19)

				if (19 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 19)) > 0 and var_486_0 < var_486_4 then
					arg_483_1.talkMaxDuration = var_486_4

					if var_486_4 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_4 + 0
					end
				end

				arg_483_1.text_.text = var_486_2
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041117", "story_v_out_117041.awb") ~= 0 then
					local var_486_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041117", "story_v_out_117041.awb") / 1000

					if var_486_5 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + 0
					end

					if var_486_1.prefab_name ~= "" and arg_483_1.actors_[var_486_1.prefab_name] ~= nil then
						local var_486_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_1.prefab_name].transform, "story_v_out_117041", "117041117", "story_v_out_117041.awb")

						arg_483_1:RecordAudio("117041117", var_486_6)
						arg_483_1:RecordAudio("117041117", var_486_6)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_117041", "117041117", "story_v_out_117041.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_117041", "117041117", "story_v_out_117041.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_7 and arg_483_1.time_ < 0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play117041118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 117041118
		arg_487_1.duration_ = 2.13

		local var_487_0 = {
			zh = 1.166,
			ja = 2.133
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play117041119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.075

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_1 = arg_487_1:GetWordFromCfg(117041118)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 3 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 3)

				if (3 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 3)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041118", "story_v_out_117041.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041118", "story_v_out_117041.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_out_117041", "117041118", "story_v_out_117041.awb")

						arg_487_1:RecordAudio("117041118", var_490_6)
						arg_487_1:RecordAudio("117041118", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_117041", "117041118", "story_v_out_117041.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_117041", "117041118", "story_v_out_117041.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play117041119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 117041119
		arg_491_1.duration_ = 1

		local var_491_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play117041120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.125

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_1 = arg_491_1:GetWordFromCfg(117041119)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 4 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 4)

				if (4 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 4)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041119", "story_v_out_117041.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041119", "story_v_out_117041.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_out_117041", "117041119", "story_v_out_117041.awb")

						arg_491_1:RecordAudio("117041119", var_494_6)
						arg_491_1:RecordAudio("117041119", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_117041", "117041119", "story_v_out_117041.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_117041", "117041119", "story_v_out_117041.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play117041120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 117041120
		arg_495_1.duration_ = 6.13

		local var_495_0 = {
			zh = 3,
			ja = 6.133
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play117041121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.275

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:GetWordFromCfg(117041120)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 11 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 11)

				if (11 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 11)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041120", "story_v_out_117041.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041120", "story_v_out_117041.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_117041", "117041120", "story_v_out_117041.awb")

						arg_495_1:RecordAudio("117041120", var_498_6)
						arg_495_1:RecordAudio("117041120", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_117041", "117041120", "story_v_out_117041.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_117041", "117041120", "story_v_out_117041.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play117041121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 117041121
		arg_499_1.duration_ = 1.67

		local var_499_0 = {
			zh = 1.166,
			ja = 1.666
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play117041122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.1

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:GetWordFromCfg(117041121)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 4 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 4)

				if (4 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 4)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041121", "story_v_out_117041.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041121", "story_v_out_117041.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_out_117041", "117041121", "story_v_out_117041.awb")

						arg_499_1:RecordAudio("117041121", var_502_6)
						arg_499_1:RecordAudio("117041121", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_117041", "117041121", "story_v_out_117041.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_117041", "117041121", "story_v_out_117041.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play117041122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 117041122
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play117041123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.55

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(117041122).content)

				arg_503_1.text_.text = var_506_1

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_3 = 22 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 22)

				if (22 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 22)) > 0 and var_506_0 < var_506_3 then
					arg_503_1.talkMaxDuration = var_506_3

					if var_506_3 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_3 + 0
					end
				end

				arg_503_1.text_.text = var_506_1
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_4 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_4

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play117041123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 117041123
		arg_507_1.duration_ = 9

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play117041124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 2 < arg_507_1.time_ and arg_507_1.time_ <= 2 + arg_510_0 then
				local var_510_0 = arg_507_1.bgs_.ST24a

				arg_507_1.bgs_.ST24a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_510_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_510_1 = var_510_0:GetComponent("SpriteRenderer")

				if var_510_1 and var_510_1.sprite then
					local var_510_2 = 2 * (var_510_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_510_0.transform.localScale = Vector3.New(var_510_2 / var_510_1.sprite.bounds.size.y < var_510_2 * manager.ui.mainCameraCom_.aspect / var_510_1.sprite.bounds.size.x and var_510_2 * manager.ui.mainCameraCom_.aspect / var_510_1.sprite.bounds.size.x or var_510_2 / var_510_1.sprite.bounds.size.y, var_510_2 / var_510_1.sprite.bounds.size.y < var_510_2 * manager.ui.mainCameraCom_.aspect / var_510_1.sprite.bounds.size.x and var_510_2 * manager.ui.mainCameraCom_.aspect / var_510_1.sprite.bounds.size.x or var_510_2 / var_510_1.sprite.bounds.size.y, 0)
				end

				for iter_510_0, iter_510_1 in pairs(arg_507_1.bgs_) do
					if iter_510_0 ~= "ST24a" then
						iter_510_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_510_3 = 0

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_3 + arg_510_0 then
				arg_507_1.mask_.enabled = true
				arg_507_1.mask_.raycastTarget = false

				arg_507_1:SetGaussion(false)
			end

			local var_510_4 = 2

			if var_510_3 <= arg_507_1.time_ and arg_507_1.time_ < var_510_3 + var_510_4 then
				local var_510_5 = Color.New(0, 0, 0)

				var_510_5.a = Mathf.Lerp(0, 1, (arg_507_1.time_ - var_510_3) / var_510_4)
				arg_507_1.mask_.color = var_510_5
			end

			if arg_507_1.time_ >= var_510_3 + var_510_4 and arg_507_1.time_ < var_510_3 + var_510_4 + arg_510_0 then
				local var_510_6 = Color.New(0, 0, 0)

				var_510_6.a = 1
				arg_507_1.mask_.color = var_510_6
			end

			local var_510_7 = 2

			if 2 < arg_507_1.time_ and arg_507_1.time_ <= var_510_7 + arg_510_0 then
				arg_507_1.mask_.enabled = true
				arg_507_1.mask_.raycastTarget = false

				arg_507_1:SetGaussion(false)
			end

			local var_510_8 = 2

			if var_510_7 <= arg_507_1.time_ and arg_507_1.time_ < var_510_7 + var_510_8 then
				local var_510_9 = Color.New(0, 0, 0)

				var_510_9.a = Mathf.Lerp(1, 0, (arg_507_1.time_ - var_510_7) / var_510_8)
				arg_507_1.mask_.color = var_510_9
			end

			if arg_507_1.time_ >= var_510_7 + var_510_8 and arg_507_1.time_ < var_510_7 + var_510_8 + arg_510_0 then
				local var_510_10 = Color.New(0, 0, 0)

				arg_507_1.mask_.enabled = false
				var_510_10.a = 0
				arg_507_1.mask_.color = var_510_10
			end

			if 4 < arg_507_1.time_ and arg_507_1.time_ <= 4 + arg_510_0 then
				arg_507_1:AudioAction("play", "effect", "se_story_17", "se_story_17_ringing", "")
			end

			if arg_507_1.frameCnt_ <= 1 then
				arg_507_1.dialog_:SetActive(false)
			end

			local var_510_12 = 4
			local var_510_13 = 1.425

			if 4 < arg_507_1.time_ and arg_507_1.time_ <= var_510_12 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				arg_507_1.dialog_:SetActive(true)

				arg_507_1.dialogCg_.alpha = 0

				local var_510_14 = LeanTween.value(arg_507_1.dialog_, 0, 1, 0.3)

				var_510_14:setOnUpdate(LuaHelper.FloatAction(function(arg_511_0)
					arg_507_1.dialogCg_.alpha = arg_511_0
				end))
				var_510_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_507_1.dialog_)
					var_510_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_507_1.duration_ = arg_507_1.duration_ + 0.3

				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_15 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(117041123).content)

				arg_507_1.text_.text = var_510_15

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_17 = 57 <= 0 and var_510_13 or var_510_13 * (utf8.len(var_510_15) / 57)

				if (57 <= 0 and var_510_13 or var_510_13 * (utf8.len(var_510_15) / 57)) > 0 and var_510_13 < var_510_17 then
					arg_507_1.talkMaxDuration = var_510_17
					var_510_12 = var_510_12 + 0.3

					if var_510_17 + var_510_12 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_17 + var_510_12
					end
				end

				arg_507_1.text_.text = var_510_15
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_18 = var_510_12 + 0.3
			local var_510_19 = math.max(var_510_13, arg_507_1.talkMaxDuration)

			if var_510_12 + 0.3 <= arg_507_1.time_ and arg_507_1.time_ < var_510_18 + var_510_19 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_18) / var_510_19

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_18 + var_510_19 and arg_507_1.time_ < var_510_18 + var_510_19 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play117041124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 117041124
		arg_513_1.duration_ = 5.2

		local var_513_0 = {
			zh = 5.2,
			ja = 2
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play117041125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPos1132 = arg_513_1.actors_["1132"].transform.localPosition
				arg_513_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_513_1:CheckSpriteTmpPos("1132", 2)

				for iter_516_0 = 0, arg_513_1.actors_["1132"].transform.childCount - 1 do
					local var_516_0 = arg_513_1.actors_["1132"].transform:GetChild(iter_516_0)

					if var_516_0.name == "split_6" or not string.find(var_516_0.name, "split") then
						var_516_0.gameObject:SetActive(true)
					else
						var_516_0.gameObject:SetActive(false)
					end
				end
			end

			local var_516_1 = 0.001

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_1 then
				arg_513_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_513_1.time_ - 0) / var_516_1)
			end

			if arg_513_1.time_ >= 0 + var_516_1 and arg_513_1.time_ < 0 + var_516_1 + arg_516_0 then
				arg_513_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_516_2 = arg_513_1.actors_["10034"].transform

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPos10034 = var_516_2.localPosition
				var_516_2.localScale = Vector3.New(1, 1, 1)

				arg_513_1:CheckSpriteTmpPos("10034", 4)

				for iter_516_1 = 0, var_516_2.childCount - 1 do
					local var_516_3 = var_516_2:GetChild(iter_516_1)

					if var_516_3.name == "split_2" or not string.find(var_516_3.name, "split") then
						var_516_3.gameObject:SetActive(true)
					else
						var_516_3.gameObject:SetActive(false)
					end
				end
			end

			local var_516_4 = 0.001

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				var_516_2.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_513_1.time_ - 0) / var_516_4)
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				var_516_2.localPosition = Vector3.New(390, -415, -290)
			end

			local var_516_5 = arg_513_1.actors_["1132"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_5) and arg_513_1.var_.actorSpriteComps1132 == nil then
				arg_513_1.var_.actorSpriteComps1132 = var_516_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_516_6 = 0.2

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_6 and not isNil(var_516_5) then
				if arg_513_1.var_.actorSpriteComps1132 then
					for iter_516_2, iter_516_3 in pairs(arg_513_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_516_3 then
							if arg_513_1.isInRecall_ then
								iter_516_3.color = Color.New(Mathf.Lerp(iter_516_3.color.r, arg_513_1.hightColor1.r, (arg_513_1.time_ - 0) / var_516_6), Mathf.Lerp(iter_516_3.color.g, arg_513_1.hightColor1.g, (arg_513_1.time_ - 0) / var_516_6), (Mathf.Lerp(iter_516_3.color.b, arg_513_1.hightColor1.b, (arg_513_1.time_ - 0) / var_516_6)))
							else
								local var_516_7 = Mathf.Lerp(iter_516_3.color.r, 1, (arg_513_1.time_ - 0) / var_516_6)

								iter_516_3.color = Color.New(var_516_7, var_516_7, var_516_7)
							end
						end
					end
				end
			end

			if arg_513_1.time_ >= 0 + var_516_6 and arg_513_1.time_ < 0 + var_516_6 + arg_516_0 and not isNil(var_516_5) and arg_513_1.var_.actorSpriteComps1132 then
				for iter_516_4, iter_516_5 in pairs(arg_513_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_516_5 then
						iter_516_5.color = arg_513_1.isInRecall_ and (arg_513_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_513_1.var_.actorSpriteComps1132 = nil
			end

			local var_516_8 = arg_513_1.actors_["10034"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_8) and arg_513_1.var_.actorSpriteComps10034 == nil then
				arg_513_1.var_.actorSpriteComps10034 = var_516_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_516_9 = 0.034

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_9 and not isNil(var_516_8) then
				if arg_513_1.var_.actorSpriteComps10034 then
					for iter_516_6, iter_516_7 in pairs(arg_513_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_516_7 then
							if arg_513_1.isInRecall_ then
								iter_516_7.color = Color.New(Mathf.Lerp(iter_516_7.color.r, arg_513_1.hightColor2.r, (arg_513_1.time_ - 0) / var_516_9), Mathf.Lerp(iter_516_7.color.g, arg_513_1.hightColor2.g, (arg_513_1.time_ - 0) / var_516_9), (Mathf.Lerp(iter_516_7.color.b, arg_513_1.hightColor2.b, (arg_513_1.time_ - 0) / var_516_9)))
							else
								local var_516_10 = Mathf.Lerp(iter_516_7.color.r, 0.5, (arg_513_1.time_ - 0) / var_516_9)

								iter_516_7.color = Color.New(var_516_10, var_516_10, var_516_10)
							end
						end
					end
				end
			end

			if arg_513_1.time_ >= 0 + var_516_9 and arg_513_1.time_ < 0 + var_516_9 + arg_516_0 and not isNil(var_516_8) and arg_513_1.var_.actorSpriteComps10034 then
				for iter_516_8, iter_516_9 in pairs(arg_513_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_516_9 then
						iter_516_9.color = arg_513_1.isInRecall_ and (arg_513_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_513_1.var_.actorSpriteComps10034 = nil
			end

			local var_516_11 = 0
			local var_516_12 = 0.225

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_11 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_13 = arg_513_1:GetWordFromCfg(117041124)
				local var_516_14 = arg_513_1:FormatText(var_516_13.content)

				arg_513_1.text_.text = var_516_14

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_16 = 9 <= 0 and var_516_12 or var_516_12 * (utf8.len(var_516_14) / 9)

				if (9 <= 0 and var_516_12 or var_516_12 * (utf8.len(var_516_14) / 9)) > 0 and var_516_12 < var_516_16 then
					arg_513_1.talkMaxDuration = var_516_16

					if var_516_16 + var_516_11 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_16 + var_516_11
					end
				end

				arg_513_1.text_.text = var_516_14
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041124", "story_v_out_117041.awb") ~= 0 then
					local var_516_17 = manager.audio:GetVoiceLength("story_v_out_117041", "117041124", "story_v_out_117041.awb") / 1000

					if var_516_17 + var_516_11 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_17 + var_516_11
					end

					if var_516_13.prefab_name ~= "" and arg_513_1.actors_[var_516_13.prefab_name] ~= nil then
						local var_516_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_13.prefab_name].transform, "story_v_out_117041", "117041124", "story_v_out_117041.awb")

						arg_513_1:RecordAudio("117041124", var_516_18)
						arg_513_1:RecordAudio("117041124", var_516_18)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_117041", "117041124", "story_v_out_117041.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_117041", "117041124", "story_v_out_117041.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_19 = math.max(var_516_12, arg_513_1.talkMaxDuration)

			if var_516_11 <= arg_513_1.time_ and arg_513_1.time_ < var_516_11 + var_516_19 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_11) / var_516_19

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_11 + var_516_19 and arg_513_1.time_ < var_516_11 + var_516_19 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play117041125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 117041125
		arg_517_1.duration_ = 3.33

		local var_517_0 = {
			zh = 2.133,
			ja = 3.333
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play117041126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1132"]) and arg_517_1.var_.actorSpriteComps1132 == nil then
				arg_517_1.var_.actorSpriteComps1132 = arg_517_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_0 = 0.2

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1132"]) then
				if arg_517_1.var_.actorSpriteComps1132 then
					for iter_520_0, iter_520_1 in pairs(arg_517_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_520_1 then
							if arg_517_1.isInRecall_ then
								iter_520_1.color = Color.New(Mathf.Lerp(iter_520_1.color.r, arg_517_1.hightColor2.r, (arg_517_1.time_ - 0) / var_520_0), Mathf.Lerp(iter_520_1.color.g, arg_517_1.hightColor2.g, (arg_517_1.time_ - 0) / var_520_0), (Mathf.Lerp(iter_520_1.color.b, arg_517_1.hightColor2.b, (arg_517_1.time_ - 0) / var_520_0)))
							else
								local var_520_1 = Mathf.Lerp(iter_520_1.color.r, 0.5, (arg_517_1.time_ - 0) / var_520_0)

								iter_520_1.color = Color.New(var_520_1, var_520_1, var_520_1)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1132"]) and arg_517_1.var_.actorSpriteComps1132 then
				for iter_520_2, iter_520_3 in pairs(arg_517_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_520_3 then
						iter_520_3.color = arg_517_1.isInRecall_ and (arg_517_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_517_1.var_.actorSpriteComps1132 = nil
			end

			local var_520_2 = arg_517_1.actors_["10034"]

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(var_520_2) and arg_517_1.var_.actorSpriteComps10034 == nil then
				arg_517_1.var_.actorSpriteComps10034 = var_520_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_3 = 0.2

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_3 and not isNil(var_520_2) then
				if arg_517_1.var_.actorSpriteComps10034 then
					for iter_520_4, iter_520_5 in pairs(arg_517_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_520_5 then
							if arg_517_1.isInRecall_ then
								iter_520_5.color = Color.New(Mathf.Lerp(iter_520_5.color.r, arg_517_1.hightColor1.r, (arg_517_1.time_ - 0) / var_520_3), Mathf.Lerp(iter_520_5.color.g, arg_517_1.hightColor1.g, (arg_517_1.time_ - 0) / var_520_3), (Mathf.Lerp(iter_520_5.color.b, arg_517_1.hightColor1.b, (arg_517_1.time_ - 0) / var_520_3)))
							else
								local var_520_4 = Mathf.Lerp(iter_520_5.color.r, 1, (arg_517_1.time_ - 0) / var_520_3)

								iter_520_5.color = Color.New(var_520_4, var_520_4, var_520_4)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= 0 + var_520_3 and arg_517_1.time_ < 0 + var_520_3 + arg_520_0 and not isNil(var_520_2) and arg_517_1.var_.actorSpriteComps10034 then
				for iter_520_6, iter_520_7 in pairs(arg_517_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_520_7 then
						iter_520_7.color = arg_517_1.isInRecall_ and (arg_517_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_517_1.var_.actorSpriteComps10034 = nil
			end

			local var_520_5 = 0
			local var_520_6 = 0.2

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_5 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_7 = arg_517_1:GetWordFromCfg(117041125)
				local var_520_8 = arg_517_1:FormatText(var_520_7.content)

				arg_517_1.text_.text = var_520_8

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_10 = 8 <= 0 and var_520_6 or var_520_6 * (utf8.len(var_520_8) / 8)

				if (8 <= 0 and var_520_6 or var_520_6 * (utf8.len(var_520_8) / 8)) > 0 and var_520_6 < var_520_10 then
					arg_517_1.talkMaxDuration = var_520_10

					if var_520_10 + var_520_5 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_10 + var_520_5
					end
				end

				arg_517_1.text_.text = var_520_8
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041125", "story_v_out_117041.awb") ~= 0 then
					local var_520_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041125", "story_v_out_117041.awb") / 1000

					if var_520_11 + var_520_5 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_11 + var_520_5
					end

					if var_520_7.prefab_name ~= "" and arg_517_1.actors_[var_520_7.prefab_name] ~= nil then
						local var_520_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_7.prefab_name].transform, "story_v_out_117041", "117041125", "story_v_out_117041.awb")

						arg_517_1:RecordAudio("117041125", var_520_12)
						arg_517_1:RecordAudio("117041125", var_520_12)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_117041", "117041125", "story_v_out_117041.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_117041", "117041125", "story_v_out_117041.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_13 = math.max(var_520_6, arg_517_1.talkMaxDuration)

			if var_520_5 <= arg_517_1.time_ and arg_517_1.time_ < var_520_5 + var_520_13 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_5) / var_520_13

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_5 + var_520_13 and arg_517_1.time_ < var_520_5 + var_520_13 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play117041126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 117041126
		arg_521_1.duration_ = 10.4

		local var_521_0 = {
			zh = 10.4,
			ja = 9
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play117041127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1132"]) and arg_521_1.var_.actorSpriteComps1132 == nil then
				arg_521_1.var_.actorSpriteComps1132 = arg_521_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_0 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1132"]) then
				if arg_521_1.var_.actorSpriteComps1132 then
					for iter_524_0, iter_524_1 in pairs(arg_521_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_524_1 then
							if arg_521_1.isInRecall_ then
								iter_524_1.color = Color.New(Mathf.Lerp(iter_524_1.color.r, arg_521_1.hightColor1.r, (arg_521_1.time_ - 0) / var_524_0), Mathf.Lerp(iter_524_1.color.g, arg_521_1.hightColor1.g, (arg_521_1.time_ - 0) / var_524_0), (Mathf.Lerp(iter_524_1.color.b, arg_521_1.hightColor1.b, (arg_521_1.time_ - 0) / var_524_0)))
							else
								local var_524_1 = Mathf.Lerp(iter_524_1.color.r, 1, (arg_521_1.time_ - 0) / var_524_0)

								iter_524_1.color = Color.New(var_524_1, var_524_1, var_524_1)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1132"]) and arg_521_1.var_.actorSpriteComps1132 then
				for iter_524_2, iter_524_3 in pairs(arg_521_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_524_3 then
						iter_524_3.color = arg_521_1.isInRecall_ and (arg_521_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_521_1.var_.actorSpriteComps1132 = nil
			end

			local var_524_2 = arg_521_1.actors_["10034"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_2) and arg_521_1.var_.actorSpriteComps10034 == nil then
				arg_521_1.var_.actorSpriteComps10034 = var_524_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_3 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_3 and not isNil(var_524_2) then
				if arg_521_1.var_.actorSpriteComps10034 then
					for iter_524_4, iter_524_5 in pairs(arg_521_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_524_5 then
							if arg_521_1.isInRecall_ then
								iter_524_5.color = Color.New(Mathf.Lerp(iter_524_5.color.r, arg_521_1.hightColor2.r, (arg_521_1.time_ - 0) / var_524_3), Mathf.Lerp(iter_524_5.color.g, arg_521_1.hightColor2.g, (arg_521_1.time_ - 0) / var_524_3), (Mathf.Lerp(iter_524_5.color.b, arg_521_1.hightColor2.b, (arg_521_1.time_ - 0) / var_524_3)))
							else
								local var_524_4 = Mathf.Lerp(iter_524_5.color.r, 0.5, (arg_521_1.time_ - 0) / var_524_3)

								iter_524_5.color = Color.New(var_524_4, var_524_4, var_524_4)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= 0 + var_524_3 and arg_521_1.time_ < 0 + var_524_3 + arg_524_0 and not isNil(var_524_2) and arg_521_1.var_.actorSpriteComps10034 then
				for iter_524_6, iter_524_7 in pairs(arg_521_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_524_7 then
						iter_524_7.color = arg_521_1.isInRecall_ and (arg_521_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_521_1.var_.actorSpriteComps10034 = nil
			end

			local var_524_5 = 0
			local var_524_6 = 1.025

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_5 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_7 = arg_521_1:GetWordFromCfg(117041126)
				local var_524_8 = arg_521_1:FormatText(var_524_7.content)

				arg_521_1.text_.text = var_524_8

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_10 = 41 <= 0 and var_524_6 or var_524_6 * (utf8.len(var_524_8) / 41)

				if (41 <= 0 and var_524_6 or var_524_6 * (utf8.len(var_524_8) / 41)) > 0 and var_524_6 < var_524_10 then
					arg_521_1.talkMaxDuration = var_524_10

					if var_524_10 + var_524_5 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_5
					end
				end

				arg_521_1.text_.text = var_524_8
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041126", "story_v_out_117041.awb") ~= 0 then
					local var_524_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041126", "story_v_out_117041.awb") / 1000

					if var_524_11 + var_524_5 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_11 + var_524_5
					end

					if var_524_7.prefab_name ~= "" and arg_521_1.actors_[var_524_7.prefab_name] ~= nil then
						local var_524_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_7.prefab_name].transform, "story_v_out_117041", "117041126", "story_v_out_117041.awb")

						arg_521_1:RecordAudio("117041126", var_524_12)
						arg_521_1:RecordAudio("117041126", var_524_12)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_117041", "117041126", "story_v_out_117041.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_117041", "117041126", "story_v_out_117041.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_13 = math.max(var_524_6, arg_521_1.talkMaxDuration)

			if var_524_5 <= arg_521_1.time_ and arg_521_1.time_ < var_524_5 + var_524_13 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_5) / var_524_13

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_5 + var_524_13 and arg_521_1.time_ < var_524_5 + var_524_13 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play117041127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 117041127
		arg_525_1.duration_ = 10.87

		local var_525_0 = {
			zh = 10.8,
			ja = 10.866
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play117041128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos10034 = arg_525_1.actors_["10034"].transform.localPosition
				arg_525_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_525_1:CheckSpriteTmpPos("10034", 4)

				for iter_528_0 = 0, arg_525_1.actors_["10034"].transform.childCount - 1 do
					local var_528_0 = arg_525_1.actors_["10034"].transform:GetChild(iter_528_0)

					if var_528_0.name == "split_5" or not string.find(var_528_0.name, "split") then
						var_528_0.gameObject:SetActive(true)
					else
						var_528_0.gameObject:SetActive(false)
					end
				end
			end

			local var_528_1 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_1 then
				arg_525_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_525_1.time_ - 0) / var_528_1)
			end

			if arg_525_1.time_ >= 0 + var_528_1 and arg_525_1.time_ < 0 + var_528_1 + arg_528_0 then
				arg_525_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_528_2 = arg_525_1.actors_["1132"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_2) and arg_525_1.var_.actorSpriteComps1132 == nil then
				arg_525_1.var_.actorSpriteComps1132 = var_528_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_3 = 0.2

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_3 and not isNil(var_528_2) then
				if arg_525_1.var_.actorSpriteComps1132 then
					for iter_528_1, iter_528_2 in pairs(arg_525_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_528_2 then
							if arg_525_1.isInRecall_ then
								iter_528_2.color = Color.New(Mathf.Lerp(iter_528_2.color.r, arg_525_1.hightColor2.r, (arg_525_1.time_ - 0) / var_528_3), Mathf.Lerp(iter_528_2.color.g, arg_525_1.hightColor2.g, (arg_525_1.time_ - 0) / var_528_3), (Mathf.Lerp(iter_528_2.color.b, arg_525_1.hightColor2.b, (arg_525_1.time_ - 0) / var_528_3)))
							else
								local var_528_4 = Mathf.Lerp(iter_528_2.color.r, 0.5, (arg_525_1.time_ - 0) / var_528_3)

								iter_528_2.color = Color.New(var_528_4, var_528_4, var_528_4)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= 0 + var_528_3 and arg_525_1.time_ < 0 + var_528_3 + arg_528_0 and not isNil(var_528_2) and arg_525_1.var_.actorSpriteComps1132 then
				for iter_528_3, iter_528_4 in pairs(arg_525_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_528_4 then
						iter_528_4.color = arg_525_1.isInRecall_ and (arg_525_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_525_1.var_.actorSpriteComps1132 = nil
			end

			local var_528_5 = arg_525_1.actors_["10034"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_5) and arg_525_1.var_.actorSpriteComps10034 == nil then
				arg_525_1.var_.actorSpriteComps10034 = var_528_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_6 = 0.2

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_6 and not isNil(var_528_5) then
				if arg_525_1.var_.actorSpriteComps10034 then
					for iter_528_5, iter_528_6 in pairs(arg_525_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_528_6 then
							if arg_525_1.isInRecall_ then
								iter_528_6.color = Color.New(Mathf.Lerp(iter_528_6.color.r, arg_525_1.hightColor1.r, (arg_525_1.time_ - 0) / var_528_6), Mathf.Lerp(iter_528_6.color.g, arg_525_1.hightColor1.g, (arg_525_1.time_ - 0) / var_528_6), (Mathf.Lerp(iter_528_6.color.b, arg_525_1.hightColor1.b, (arg_525_1.time_ - 0) / var_528_6)))
							else
								local var_528_7 = Mathf.Lerp(iter_528_6.color.r, 1, (arg_525_1.time_ - 0) / var_528_6)

								iter_528_6.color = Color.New(var_528_7, var_528_7, var_528_7)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= 0 + var_528_6 and arg_525_1.time_ < 0 + var_528_6 + arg_528_0 and not isNil(var_528_5) and arg_525_1.var_.actorSpriteComps10034 then
				for iter_528_7, iter_528_8 in pairs(arg_525_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_528_8 then
						iter_528_8.color = arg_525_1.isInRecall_ and (arg_525_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_525_1.var_.actorSpriteComps10034 = nil
			end

			local var_528_8 = 0
			local var_528_9 = 1.025

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_8 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_10 = arg_525_1:GetWordFromCfg(117041127)
				local var_528_11 = arg_525_1:FormatText(var_528_10.content)

				arg_525_1.text_.text = var_528_11

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_13 = 41 <= 0 and var_528_9 or var_528_9 * (utf8.len(var_528_11) / 41)

				if (41 <= 0 and var_528_9 or var_528_9 * (utf8.len(var_528_11) / 41)) > 0 and var_528_9 < var_528_13 then
					arg_525_1.talkMaxDuration = var_528_13

					if var_528_13 + var_528_8 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_8
					end
				end

				arg_525_1.text_.text = var_528_11
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041127", "story_v_out_117041.awb") ~= 0 then
					local var_528_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041127", "story_v_out_117041.awb") / 1000

					if var_528_14 + var_528_8 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_14 + var_528_8
					end

					if var_528_10.prefab_name ~= "" and arg_525_1.actors_[var_528_10.prefab_name] ~= nil then
						local var_528_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_10.prefab_name].transform, "story_v_out_117041", "117041127", "story_v_out_117041.awb")

						arg_525_1:RecordAudio("117041127", var_528_15)
						arg_525_1:RecordAudio("117041127", var_528_15)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_117041", "117041127", "story_v_out_117041.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_117041", "117041127", "story_v_out_117041.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_16 = math.max(var_528_9, arg_525_1.talkMaxDuration)

			if var_528_8 <= arg_525_1.time_ and arg_525_1.time_ < var_528_8 + var_528_16 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_8) / var_528_16

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_8 + var_528_16 and arg_525_1.time_ < var_528_8 + var_528_16 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play117041128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 117041128
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play117041129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos10034 = arg_529_1.actors_["10034"].transform.localPosition
				arg_529_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_529_1:CheckSpriteTmpPos("10034", 4)

				for iter_532_0 = 0, arg_529_1.actors_["10034"].transform.childCount - 1 do
					local var_532_0 = arg_529_1.actors_["10034"].transform:GetChild(iter_532_0)

					if var_532_0.name == "split_2" or not string.find(var_532_0.name, "split") then
						var_532_0.gameObject:SetActive(true)
					else
						var_532_0.gameObject:SetActive(false)
					end
				end
			end

			local var_532_1 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_1 then
				arg_529_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_529_1.time_ - 0) / var_532_1)
			end

			if arg_529_1.time_ >= 0 + var_532_1 and arg_529_1.time_ < 0 + var_532_1 + arg_532_0 then
				arg_529_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_532_2 = arg_529_1.actors_["10034"]

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(var_532_2) and arg_529_1.var_.actorSpriteComps10034 == nil then
				arg_529_1.var_.actorSpriteComps10034 = var_532_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_3 = 0.2

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_3 and not isNil(var_532_2) then
				if arg_529_1.var_.actorSpriteComps10034 then
					for iter_532_1, iter_532_2 in pairs(arg_529_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_532_2 then
							if arg_529_1.isInRecall_ then
								iter_532_2.color = Color.New(Mathf.Lerp(iter_532_2.color.r, arg_529_1.hightColor2.r, (arg_529_1.time_ - 0) / var_532_3), Mathf.Lerp(iter_532_2.color.g, arg_529_1.hightColor2.g, (arg_529_1.time_ - 0) / var_532_3), (Mathf.Lerp(iter_532_2.color.b, arg_529_1.hightColor2.b, (arg_529_1.time_ - 0) / var_532_3)))
							else
								local var_532_4 = Mathf.Lerp(iter_532_2.color.r, 0.5, (arg_529_1.time_ - 0) / var_532_3)

								iter_532_2.color = Color.New(var_532_4, var_532_4, var_532_4)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= 0 + var_532_3 and arg_529_1.time_ < 0 + var_532_3 + arg_532_0 and not isNil(var_532_2) and arg_529_1.var_.actorSpriteComps10034 then
				for iter_532_3, iter_532_4 in pairs(arg_529_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_532_4 then
						iter_532_4.color = arg_529_1.isInRecall_ and (arg_529_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_529_1.var_.actorSpriteComps10034 = nil
			end

			local var_532_5 = 0
			local var_532_6 = 0.925

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_5 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_7 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(117041128).content)

				arg_529_1.text_.text = var_532_7

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_9 = 37 <= 0 and var_532_6 or var_532_6 * (utf8.len(var_532_7) / 37)

				if (37 <= 0 and var_532_6 or var_532_6 * (utf8.len(var_532_7) / 37)) > 0 and var_532_6 < var_532_9 then
					arg_529_1.talkMaxDuration = var_532_9

					if var_532_9 + var_532_5 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_9 + var_532_5
					end
				end

				arg_529_1.text_.text = var_532_7
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_10 = math.max(var_532_6, arg_529_1.talkMaxDuration)

			if var_532_5 <= arg_529_1.time_ and arg_529_1.time_ < var_532_5 + var_532_10 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_5) / var_532_10

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_5 + var_532_10 and arg_529_1.time_ < var_532_5 + var_532_10 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play117041129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 117041129
		arg_533_1.duration_ = 4.5

		local var_533_0 = {
			zh = 3.3,
			ja = 4.5
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play117041130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos1132 = arg_533_1.actors_["1132"].transform.localPosition
				arg_533_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_533_1:CheckSpriteTmpPos("1132", 2)

				for iter_536_0 = 0, arg_533_1.actors_["1132"].transform.childCount - 1 do
					local var_536_0 = arg_533_1.actors_["1132"].transform:GetChild(iter_536_0)

					if var_536_0.name == "split_1" or not string.find(var_536_0.name, "split") then
						var_536_0.gameObject:SetActive(true)
					else
						var_536_0.gameObject:SetActive(false)
					end
				end
			end

			local var_536_1 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_1 then
				arg_533_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_533_1.time_ - 0) / var_536_1)
			end

			if arg_533_1.time_ >= 0 + var_536_1 and arg_533_1.time_ < 0 + var_536_1 + arg_536_0 then
				arg_533_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_536_2 = arg_533_1.actors_["1132"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_2) and arg_533_1.var_.actorSpriteComps1132 == nil then
				arg_533_1.var_.actorSpriteComps1132 = var_536_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_536_3 = 0.2

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_3 and not isNil(var_536_2) then
				if arg_533_1.var_.actorSpriteComps1132 then
					for iter_536_1, iter_536_2 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_536_2 then
							if arg_533_1.isInRecall_ then
								iter_536_2.color = Color.New(Mathf.Lerp(iter_536_2.color.r, arg_533_1.hightColor1.r, (arg_533_1.time_ - 0) / var_536_3), Mathf.Lerp(iter_536_2.color.g, arg_533_1.hightColor1.g, (arg_533_1.time_ - 0) / var_536_3), (Mathf.Lerp(iter_536_2.color.b, arg_533_1.hightColor1.b, (arg_533_1.time_ - 0) / var_536_3)))
							else
								local var_536_4 = Mathf.Lerp(iter_536_2.color.r, 1, (arg_533_1.time_ - 0) / var_536_3)

								iter_536_2.color = Color.New(var_536_4, var_536_4, var_536_4)
							end
						end
					end
				end
			end

			if arg_533_1.time_ >= 0 + var_536_3 and arg_533_1.time_ < 0 + var_536_3 + arg_536_0 and not isNil(var_536_2) and arg_533_1.var_.actorSpriteComps1132 then
				for iter_536_3, iter_536_4 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_536_4 then
						iter_536_4.color = arg_533_1.isInRecall_ and (arg_533_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_533_1.var_.actorSpriteComps1132 = nil
			end

			local var_536_5 = arg_533_1.actors_["1132"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_5) and arg_533_1.var_.actorSpriteComps1132 == nil then
				arg_533_1.var_.actorSpriteComps1132 = var_536_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_536_6 = 0.2

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_6 and not isNil(var_536_5) then
				if arg_533_1.var_.actorSpriteComps1132 then
					for iter_536_5, iter_536_6 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_536_6 then
							if arg_533_1.isInRecall_ then
								iter_536_6.color = Color.New(Mathf.Lerp(iter_536_6.color.r, arg_533_1.hightColor1.r, (arg_533_1.time_ - 0) / var_536_6), Mathf.Lerp(iter_536_6.color.g, arg_533_1.hightColor1.g, (arg_533_1.time_ - 0) / var_536_6), (Mathf.Lerp(iter_536_6.color.b, arg_533_1.hightColor1.b, (arg_533_1.time_ - 0) / var_536_6)))
							else
								local var_536_7 = Mathf.Lerp(iter_536_6.color.r, 1, (arg_533_1.time_ - 0) / var_536_6)

								iter_536_6.color = Color.New(var_536_7, var_536_7, var_536_7)
							end
						end
					end
				end
			end

			if arg_533_1.time_ >= 0 + var_536_6 and arg_533_1.time_ < 0 + var_536_6 + arg_536_0 and not isNil(var_536_5) and arg_533_1.var_.actorSpriteComps1132 then
				for iter_536_7, iter_536_8 in pairs(arg_533_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_536_8 then
						iter_536_8.color = arg_533_1.isInRecall_ and (arg_533_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_533_1.var_.actorSpriteComps1132 = nil
			end

			local var_536_8 = 0
			local var_536_9 = 0.325

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_8 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_10 = arg_533_1:GetWordFromCfg(117041129)
				local var_536_11 = arg_533_1:FormatText(var_536_10.content)

				arg_533_1.text_.text = var_536_11

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_13 = 13 <= 0 and var_536_9 or var_536_9 * (utf8.len(var_536_11) / 13)

				if (13 <= 0 and var_536_9 or var_536_9 * (utf8.len(var_536_11) / 13)) > 0 and var_536_9 < var_536_13 then
					arg_533_1.talkMaxDuration = var_536_13

					if var_536_13 + var_536_8 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_13 + var_536_8
					end
				end

				arg_533_1.text_.text = var_536_11
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041129", "story_v_out_117041.awb") ~= 0 then
					local var_536_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041129", "story_v_out_117041.awb") / 1000

					if var_536_14 + var_536_8 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_14 + var_536_8
					end

					if var_536_10.prefab_name ~= "" and arg_533_1.actors_[var_536_10.prefab_name] ~= nil then
						local var_536_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_10.prefab_name].transform, "story_v_out_117041", "117041129", "story_v_out_117041.awb")

						arg_533_1:RecordAudio("117041129", var_536_15)
						arg_533_1:RecordAudio("117041129", var_536_15)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_117041", "117041129", "story_v_out_117041.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_117041", "117041129", "story_v_out_117041.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_16 = math.max(var_536_9, arg_533_1.talkMaxDuration)

			if var_536_8 <= arg_533_1.time_ and arg_533_1.time_ < var_536_8 + var_536_16 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_8) / var_536_16

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_8 + var_536_16 and arg_533_1.time_ < var_536_8 + var_536_16 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play117041130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 117041130
		arg_537_1.duration_ = 5.07

		local var_537_0 = {
			zh = 4.066,
			ja = 5.066
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play117041131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos1132 = arg_537_1.actors_["1132"].transform.localPosition
				arg_537_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("1132", 2)

				for iter_540_0 = 0, arg_537_1.actors_["1132"].transform.childCount - 1 do
					local var_540_0 = arg_537_1.actors_["1132"].transform:GetChild(iter_540_0)

					if var_540_0.name == "split_6" or not string.find(var_540_0.name, "split") then
						var_540_0.gameObject:SetActive(true)
					else
						var_540_0.gameObject:SetActive(false)
					end
				end
			end

			local var_540_1 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_1 then
				arg_537_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_537_1.time_ - 0) / var_540_1)
			end

			if arg_537_1.time_ >= 0 + var_540_1 and arg_537_1.time_ < 0 + var_540_1 + arg_540_0 then
				arg_537_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_540_2 = 0
			local var_540_3 = 0.375

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_2 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_4 = arg_537_1:GetWordFromCfg(117041130)
				local var_540_5 = arg_537_1:FormatText(var_540_4.content)

				arg_537_1.text_.text = var_540_5

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_7 = 15 <= 0 and var_540_3 or var_540_3 * (utf8.len(var_540_5) / 15)

				if (15 <= 0 and var_540_3 or var_540_3 * (utf8.len(var_540_5) / 15)) > 0 and var_540_3 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_2
					end
				end

				arg_537_1.text_.text = var_540_5
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041130", "story_v_out_117041.awb") ~= 0 then
					local var_540_8 = manager.audio:GetVoiceLength("story_v_out_117041", "117041130", "story_v_out_117041.awb") / 1000

					if var_540_8 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_8 + var_540_2
					end

					if var_540_4.prefab_name ~= "" and arg_537_1.actors_[var_540_4.prefab_name] ~= nil then
						local var_540_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_4.prefab_name].transform, "story_v_out_117041", "117041130", "story_v_out_117041.awb")

						arg_537_1:RecordAudio("117041130", var_540_9)
						arg_537_1:RecordAudio("117041130", var_540_9)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_117041", "117041130", "story_v_out_117041.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_117041", "117041130", "story_v_out_117041.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_10 = math.max(var_540_3, arg_537_1.talkMaxDuration)

			if var_540_2 <= arg_537_1.time_ and arg_537_1.time_ < var_540_2 + var_540_10 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_2) / var_540_10

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_2 + var_540_10 and arg_537_1.time_ < var_540_2 + var_540_10 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play117041131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 117041131
		arg_541_1.duration_ = 6.63

		local var_541_0 = {
			zh = 6.633,
			ja = 5.3
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play117041132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1132"]) and arg_541_1.var_.actorSpriteComps1132 == nil then
				arg_541_1.var_.actorSpriteComps1132 = arg_541_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_0 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1132"]) then
				if arg_541_1.var_.actorSpriteComps1132 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								iter_544_1.color = Color.New(Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor2.r, (arg_541_1.time_ - 0) / var_544_0), Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor2.g, (arg_541_1.time_ - 0) / var_544_0), (Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor2.b, (arg_541_1.time_ - 0) / var_544_0)))
							else
								local var_544_1 = Mathf.Lerp(iter_544_1.color.r, 0.5, (arg_541_1.time_ - 0) / var_544_0)

								iter_544_1.color = Color.New(var_544_1, var_544_1, var_544_1)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1132"]) and arg_541_1.var_.actorSpriteComps1132 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_544_3 then
						iter_544_3.color = arg_541_1.isInRecall_ and (arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_541_1.var_.actorSpriteComps1132 = nil
			end

			local var_544_2 = arg_541_1.actors_["10034"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_2) and arg_541_1.var_.actorSpriteComps10034 == nil then
				arg_541_1.var_.actorSpriteComps10034 = var_544_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_3 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_3 and not isNil(var_544_2) then
				if arg_541_1.var_.actorSpriteComps10034 then
					for iter_544_4, iter_544_5 in pairs(arg_541_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_544_5 then
							if arg_541_1.isInRecall_ then
								iter_544_5.color = Color.New(Mathf.Lerp(iter_544_5.color.r, arg_541_1.hightColor1.r, (arg_541_1.time_ - 0) / var_544_3), Mathf.Lerp(iter_544_5.color.g, arg_541_1.hightColor1.g, (arg_541_1.time_ - 0) / var_544_3), (Mathf.Lerp(iter_544_5.color.b, arg_541_1.hightColor1.b, (arg_541_1.time_ - 0) / var_544_3)))
							else
								local var_544_4 = Mathf.Lerp(iter_544_5.color.r, 1, (arg_541_1.time_ - 0) / var_544_3)

								iter_544_5.color = Color.New(var_544_4, var_544_4, var_544_4)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= 0 + var_544_3 and arg_541_1.time_ < 0 + var_544_3 + arg_544_0 and not isNil(var_544_2) and arg_541_1.var_.actorSpriteComps10034 then
				for iter_544_6, iter_544_7 in pairs(arg_541_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_544_7 then
						iter_544_7.color = arg_541_1.isInRecall_ and (arg_541_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_541_1.var_.actorSpriteComps10034 = nil
			end

			local var_544_5 = arg_541_1.actors_["10034"].transform

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos10034 = var_544_5.localPosition
				var_544_5.localScale = Vector3.New(1, 1, 1)

				arg_541_1:CheckSpriteTmpPos("10034", 4)

				for iter_544_8 = 0, var_544_5.childCount - 1 do
					local var_544_6 = var_544_5:GetChild(iter_544_8)

					if var_544_6.name == "split_2" or not string.find(var_544_6.name, "split") then
						var_544_6.gameObject:SetActive(true)
					else
						var_544_6.gameObject:SetActive(false)
					end
				end
			end

			local var_544_7 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				var_544_5.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_541_1.time_ - 0) / var_544_7)
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				var_544_5.localPosition = Vector3.New(390, -415, -290)
			end

			local var_544_8 = 0
			local var_544_9 = 0.65

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_8 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_10 = arg_541_1:GetWordFromCfg(117041131)
				local var_544_11 = arg_541_1:FormatText(var_544_10.content)

				arg_541_1.text_.text = var_544_11

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_13 = 26 <= 0 and var_544_9 or var_544_9 * (utf8.len(var_544_11) / 26)

				if (26 <= 0 and var_544_9 or var_544_9 * (utf8.len(var_544_11) / 26)) > 0 and var_544_9 < var_544_13 then
					arg_541_1.talkMaxDuration = var_544_13

					if var_544_13 + var_544_8 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_13 + var_544_8
					end
				end

				arg_541_1.text_.text = var_544_11
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041131", "story_v_out_117041.awb") ~= 0 then
					local var_544_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041131", "story_v_out_117041.awb") / 1000

					if var_544_14 + var_544_8 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_14 + var_544_8
					end

					if var_544_10.prefab_name ~= "" and arg_541_1.actors_[var_544_10.prefab_name] ~= nil then
						local var_544_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_10.prefab_name].transform, "story_v_out_117041", "117041131", "story_v_out_117041.awb")

						arg_541_1:RecordAudio("117041131", var_544_15)
						arg_541_1:RecordAudio("117041131", var_544_15)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_117041", "117041131", "story_v_out_117041.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_117041", "117041131", "story_v_out_117041.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_16 = math.max(var_544_9, arg_541_1.talkMaxDuration)

			if var_544_8 <= arg_541_1.time_ and arg_541_1.time_ < var_544_8 + var_544_16 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_8) / var_544_16

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_8 + var_544_16 and arg_541_1.time_ < var_544_8 + var_544_16 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play117041132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 117041132
		arg_545_1.duration_ = 13.2

		local var_545_0 = {
			zh = 10.6,
			ja = 13.2
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play117041133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 1.15

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_1 = arg_545_1:GetWordFromCfg(117041132)
				local var_548_2 = arg_545_1:FormatText(var_548_1.content)

				arg_545_1.text_.text = var_548_2

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_4 = 46 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_2) / 46)

				if (46 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_2) / 46)) > 0 and var_548_0 < var_548_4 then
					arg_545_1.talkMaxDuration = var_548_4

					if var_548_4 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_4 + 0
					end
				end

				arg_545_1.text_.text = var_548_2
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041132", "story_v_out_117041.awb") ~= 0 then
					local var_548_5 = manager.audio:GetVoiceLength("story_v_out_117041", "117041132", "story_v_out_117041.awb") / 1000

					if var_548_5 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_5 + 0
					end

					if var_548_1.prefab_name ~= "" and arg_545_1.actors_[var_548_1.prefab_name] ~= nil then
						local var_548_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_1.prefab_name].transform, "story_v_out_117041", "117041132", "story_v_out_117041.awb")

						arg_545_1:RecordAudio("117041132", var_548_6)
						arg_545_1:RecordAudio("117041132", var_548_6)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_117041", "117041132", "story_v_out_117041.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_117041", "117041132", "story_v_out_117041.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_7 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_7 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_7

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_7 and arg_545_1.time_ < 0 + var_548_7 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play117041133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 117041133
		arg_549_1.duration_ = 5.83

		local var_549_0 = {
			zh = 5.833,
			ja = 4.933
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play117041134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1132 = arg_549_1.actors_["1132"].transform.localPosition
				arg_549_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_549_1:CheckSpriteTmpPos("1132", 2)

				for iter_552_0 = 0, arg_549_1.actors_["1132"].transform.childCount - 1 do
					local var_552_0 = arg_549_1.actors_["1132"].transform:GetChild(iter_552_0)

					if var_552_0.name == "split_2" or not string.find(var_552_0.name, "split") then
						var_552_0.gameObject:SetActive(true)
					else
						var_552_0.gameObject:SetActive(false)
					end
				end
			end

			local var_552_1 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_1 then
				arg_549_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (arg_549_1.time_ - 0) / var_552_1)
			end

			if arg_549_1.time_ >= 0 + var_552_1 and arg_549_1.time_ < 0 + var_552_1 + arg_552_0 then
				arg_549_1.actors_["1132"].transform.localPosition = Vector3.New(-390, -413, -185)
			end

			local var_552_2 = arg_549_1.actors_["1132"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_2) and arg_549_1.var_.actorSpriteComps1132 == nil then
				arg_549_1.var_.actorSpriteComps1132 = var_552_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_552_3 = 0.2

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_3 and not isNil(var_552_2) then
				if arg_549_1.var_.actorSpriteComps1132 then
					for iter_552_1, iter_552_2 in pairs(arg_549_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_552_2 then
							if arg_549_1.isInRecall_ then
								iter_552_2.color = Color.New(Mathf.Lerp(iter_552_2.color.r, arg_549_1.hightColor1.r, (arg_549_1.time_ - 0) / var_552_3), Mathf.Lerp(iter_552_2.color.g, arg_549_1.hightColor1.g, (arg_549_1.time_ - 0) / var_552_3), (Mathf.Lerp(iter_552_2.color.b, arg_549_1.hightColor1.b, (arg_549_1.time_ - 0) / var_552_3)))
							else
								local var_552_4 = Mathf.Lerp(iter_552_2.color.r, 1, (arg_549_1.time_ - 0) / var_552_3)

								iter_552_2.color = Color.New(var_552_4, var_552_4, var_552_4)
							end
						end
					end
				end
			end

			if arg_549_1.time_ >= 0 + var_552_3 and arg_549_1.time_ < 0 + var_552_3 + arg_552_0 and not isNil(var_552_2) and arg_549_1.var_.actorSpriteComps1132 then
				for iter_552_3, iter_552_4 in pairs(arg_549_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_552_4 then
						iter_552_4.color = arg_549_1.isInRecall_ and (arg_549_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_549_1.var_.actorSpriteComps1132 = nil
			end

			local var_552_5 = arg_549_1.actors_["10034"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_5) and arg_549_1.var_.actorSpriteComps10034 == nil then
				arg_549_1.var_.actorSpriteComps10034 = var_552_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_552_6 = 0.2

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_6 and not isNil(var_552_5) then
				if arg_549_1.var_.actorSpriteComps10034 then
					for iter_552_5, iter_552_6 in pairs(arg_549_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_552_6 then
							if arg_549_1.isInRecall_ then
								iter_552_6.color = Color.New(Mathf.Lerp(iter_552_6.color.r, arg_549_1.hightColor2.r, (arg_549_1.time_ - 0) / var_552_6), Mathf.Lerp(iter_552_6.color.g, arg_549_1.hightColor2.g, (arg_549_1.time_ - 0) / var_552_6), (Mathf.Lerp(iter_552_6.color.b, arg_549_1.hightColor2.b, (arg_549_1.time_ - 0) / var_552_6)))
							else
								local var_552_7 = Mathf.Lerp(iter_552_6.color.r, 0.5, (arg_549_1.time_ - 0) / var_552_6)

								iter_552_6.color = Color.New(var_552_7, var_552_7, var_552_7)
							end
						end
					end
				end
			end

			if arg_549_1.time_ >= 0 + var_552_6 and arg_549_1.time_ < 0 + var_552_6 + arg_552_0 and not isNil(var_552_5) and arg_549_1.var_.actorSpriteComps10034 then
				for iter_552_7, iter_552_8 in pairs(arg_549_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_552_8 then
						iter_552_8.color = arg_549_1.isInRecall_ and (arg_549_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_549_1.var_.actorSpriteComps10034 = nil
			end

			local var_552_8 = 0
			local var_552_9 = 0.525

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_8 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_10 = arg_549_1:GetWordFromCfg(117041133)
				local var_552_11 = arg_549_1:FormatText(var_552_10.content)

				arg_549_1.text_.text = var_552_11

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_13 = 21 <= 0 and var_552_9 or var_552_9 * (utf8.len(var_552_11) / 21)

				if (21 <= 0 and var_552_9 or var_552_9 * (utf8.len(var_552_11) / 21)) > 0 and var_552_9 < var_552_13 then
					arg_549_1.talkMaxDuration = var_552_13

					if var_552_13 + var_552_8 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_13 + var_552_8
					end
				end

				arg_549_1.text_.text = var_552_11
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041133", "story_v_out_117041.awb") ~= 0 then
					local var_552_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041133", "story_v_out_117041.awb") / 1000

					if var_552_14 + var_552_8 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_14 + var_552_8
					end

					if var_552_10.prefab_name ~= "" and arg_549_1.actors_[var_552_10.prefab_name] ~= nil then
						local var_552_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_10.prefab_name].transform, "story_v_out_117041", "117041133", "story_v_out_117041.awb")

						arg_549_1:RecordAudio("117041133", var_552_15)
						arg_549_1:RecordAudio("117041133", var_552_15)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_117041", "117041133", "story_v_out_117041.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_117041", "117041133", "story_v_out_117041.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_16 = math.max(var_552_9, arg_549_1.talkMaxDuration)

			if var_552_8 <= arg_549_1.time_ and arg_549_1.time_ < var_552_8 + var_552_16 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_8) / var_552_16

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_8 + var_552_16 and arg_549_1.time_ < var_552_8 + var_552_16 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_549_1:InitPlayNodeList()
	end,
	Play117041134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 117041134
		arg_553_1.duration_ = 3.33

		local var_553_0 = {
			zh = 3.333,
			ja = 2.6
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play117041135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1132"]) and arg_553_1.var_.actorSpriteComps1132 == nil then
				arg_553_1.var_.actorSpriteComps1132 = arg_553_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_0 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1132"]) then
				if arg_553_1.var_.actorSpriteComps1132 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								iter_556_1.color = Color.New(Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor2.r, (arg_553_1.time_ - 0) / var_556_0), Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor2.g, (arg_553_1.time_ - 0) / var_556_0), (Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor2.b, (arg_553_1.time_ - 0) / var_556_0)))
							else
								local var_556_1 = Mathf.Lerp(iter_556_1.color.r, 0.5, (arg_553_1.time_ - 0) / var_556_0)

								iter_556_1.color = Color.New(var_556_1, var_556_1, var_556_1)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1132"]) and arg_553_1.var_.actorSpriteComps1132 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_556_3 then
						iter_556_3.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_553_1.var_.actorSpriteComps1132 = nil
			end

			local var_556_2 = arg_553_1.actors_["10034"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.actorSpriteComps10034 == nil then
				arg_553_1.var_.actorSpriteComps10034 = var_556_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_3 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_3 and not isNil(var_556_2) then
				if arg_553_1.var_.actorSpriteComps10034 then
					for iter_556_4, iter_556_5 in pairs(arg_553_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_556_5 then
							if arg_553_1.isInRecall_ then
								iter_556_5.color = Color.New(Mathf.Lerp(iter_556_5.color.r, arg_553_1.hightColor1.r, (arg_553_1.time_ - 0) / var_556_3), Mathf.Lerp(iter_556_5.color.g, arg_553_1.hightColor1.g, (arg_553_1.time_ - 0) / var_556_3), (Mathf.Lerp(iter_556_5.color.b, arg_553_1.hightColor1.b, (arg_553_1.time_ - 0) / var_556_3)))
							else
								local var_556_4 = Mathf.Lerp(iter_556_5.color.r, 1, (arg_553_1.time_ - 0) / var_556_3)

								iter_556_5.color = Color.New(var_556_4, var_556_4, var_556_4)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_3 and arg_553_1.time_ < 0 + var_556_3 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.actorSpriteComps10034 then
				for iter_556_6, iter_556_7 in pairs(arg_553_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_556_7 then
						iter_556_7.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_553_1.var_.actorSpriteComps10034 = nil
			end

			local var_556_5 = 0
			local var_556_6 = 0.225

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_5 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_7 = arg_553_1:GetWordFromCfg(117041134)
				local var_556_8 = arg_553_1:FormatText(var_556_7.content)

				arg_553_1.text_.text = var_556_8

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_10 = 9 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_8) / 9)

				if (9 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_8) / 9)) > 0 and var_556_6 < var_556_10 then
					arg_553_1.talkMaxDuration = var_556_10

					if var_556_10 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_5
					end
				end

				arg_553_1.text_.text = var_556_8
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041134", "story_v_out_117041.awb") ~= 0 then
					local var_556_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041134", "story_v_out_117041.awb") / 1000

					if var_556_11 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_11 + var_556_5
					end

					if var_556_7.prefab_name ~= "" and arg_553_1.actors_[var_556_7.prefab_name] ~= nil then
						local var_556_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_7.prefab_name].transform, "story_v_out_117041", "117041134", "story_v_out_117041.awb")

						arg_553_1:RecordAudio("117041134", var_556_12)
						arg_553_1:RecordAudio("117041134", var_556_12)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_117041", "117041134", "story_v_out_117041.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_117041", "117041134", "story_v_out_117041.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_13 = math.max(var_556_6, arg_553_1.talkMaxDuration)

			if var_556_5 <= arg_553_1.time_ and arg_553_1.time_ < var_556_5 + var_556_13 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_5) / var_556_13

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_5 + var_556_13 and arg_553_1.time_ < var_556_5 + var_556_13 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play117041135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 117041135
		arg_557_1.duration_ = 1.63

		local var_557_0 = {
			zh = 1.133,
			ja = 1.633
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play117041136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1132"]) and arg_557_1.var_.actorSpriteComps1132 == nil then
				arg_557_1.var_.actorSpriteComps1132 = arg_557_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_0 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1132"]) then
				if arg_557_1.var_.actorSpriteComps1132 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								iter_560_1.color = Color.New(Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor1.r, (arg_557_1.time_ - 0) / var_560_0), Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor1.g, (arg_557_1.time_ - 0) / var_560_0), (Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor1.b, (arg_557_1.time_ - 0) / var_560_0)))
							else
								local var_560_1 = Mathf.Lerp(iter_560_1.color.r, 1, (arg_557_1.time_ - 0) / var_560_0)

								iter_560_1.color = Color.New(var_560_1, var_560_1, var_560_1)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1132"]) and arg_557_1.var_.actorSpriteComps1132 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_560_3 then
						iter_560_3.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_557_1.var_.actorSpriteComps1132 = nil
			end

			local var_560_2 = arg_557_1.actors_["10034"]

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(var_560_2) and arg_557_1.var_.actorSpriteComps10034 == nil then
				arg_557_1.var_.actorSpriteComps10034 = var_560_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_3 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_3 and not isNil(var_560_2) then
				if arg_557_1.var_.actorSpriteComps10034 then
					for iter_560_4, iter_560_5 in pairs(arg_557_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_560_5 then
							if arg_557_1.isInRecall_ then
								iter_560_5.color = Color.New(Mathf.Lerp(iter_560_5.color.r, arg_557_1.hightColor2.r, (arg_557_1.time_ - 0) / var_560_3), Mathf.Lerp(iter_560_5.color.g, arg_557_1.hightColor2.g, (arg_557_1.time_ - 0) / var_560_3), (Mathf.Lerp(iter_560_5.color.b, arg_557_1.hightColor2.b, (arg_557_1.time_ - 0) / var_560_3)))
							else
								local var_560_4 = Mathf.Lerp(iter_560_5.color.r, 0.5, (arg_557_1.time_ - 0) / var_560_3)

								iter_560_5.color = Color.New(var_560_4, var_560_4, var_560_4)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0 + var_560_3 and arg_557_1.time_ < 0 + var_560_3 + arg_560_0 and not isNil(var_560_2) and arg_557_1.var_.actorSpriteComps10034 then
				for iter_560_6, iter_560_7 in pairs(arg_557_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_560_7 then
						iter_560_7.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_557_1.var_.actorSpriteComps10034 = nil
			end

			local var_560_5 = 0
			local var_560_6 = 0.125

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_7 = arg_557_1:GetWordFromCfg(117041135)
				local var_560_8 = arg_557_1:FormatText(var_560_7.content)

				arg_557_1.text_.text = var_560_8

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_10 = 5 <= 0 and var_560_6 or var_560_6 * (utf8.len(var_560_8) / 5)

				if (5 <= 0 and var_560_6 or var_560_6 * (utf8.len(var_560_8) / 5)) > 0 and var_560_6 < var_560_10 then
					arg_557_1.talkMaxDuration = var_560_10

					if var_560_10 + var_560_5 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_10 + var_560_5
					end
				end

				arg_557_1.text_.text = var_560_8
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041135", "story_v_out_117041.awb") ~= 0 then
					local var_560_11 = manager.audio:GetVoiceLength("story_v_out_117041", "117041135", "story_v_out_117041.awb") / 1000

					if var_560_11 + var_560_5 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_11 + var_560_5
					end

					if var_560_7.prefab_name ~= "" and arg_557_1.actors_[var_560_7.prefab_name] ~= nil then
						local var_560_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_7.prefab_name].transform, "story_v_out_117041", "117041135", "story_v_out_117041.awb")

						arg_557_1:RecordAudio("117041135", var_560_12)
						arg_557_1:RecordAudio("117041135", var_560_12)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_117041", "117041135", "story_v_out_117041.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_117041", "117041135", "story_v_out_117041.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_13 = math.max(var_560_6, arg_557_1.talkMaxDuration)

			if var_560_5 <= arg_557_1.time_ and arg_557_1.time_ < var_560_5 + var_560_13 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_5) / var_560_13

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_5 + var_560_13 and arg_557_1.time_ < var_560_5 + var_560_13 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play117041136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 117041136
		arg_561_1.duration_ = 5.17

		local var_561_0 = {
			zh = 5,
			ja = 5.166
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play117041137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["1132"]) and arg_561_1.var_.actorSpriteComps1132 == nil then
				arg_561_1.var_.actorSpriteComps1132 = arg_561_1.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_0 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["1132"]) then
				if arg_561_1.var_.actorSpriteComps1132 then
					for iter_564_0, iter_564_1 in pairs(arg_561_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_564_1 then
							if arg_561_1.isInRecall_ then
								iter_564_1.color = Color.New(Mathf.Lerp(iter_564_1.color.r, arg_561_1.hightColor2.r, (arg_561_1.time_ - 0) / var_564_0), Mathf.Lerp(iter_564_1.color.g, arg_561_1.hightColor2.g, (arg_561_1.time_ - 0) / var_564_0), (Mathf.Lerp(iter_564_1.color.b, arg_561_1.hightColor2.b, (arg_561_1.time_ - 0) / var_564_0)))
							else
								local var_564_1 = Mathf.Lerp(iter_564_1.color.r, 0.5, (arg_561_1.time_ - 0) / var_564_0)

								iter_564_1.color = Color.New(var_564_1, var_564_1, var_564_1)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["1132"]) and arg_561_1.var_.actorSpriteComps1132 then
				for iter_564_2, iter_564_3 in pairs(arg_561_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_564_3 then
						iter_564_3.color = arg_561_1.isInRecall_ and (arg_561_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_561_1.var_.actorSpriteComps1132 = nil
			end

			local var_564_2 = arg_561_1.actors_["10034"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_2) and arg_561_1.var_.actorSpriteComps10034 == nil then
				arg_561_1.var_.actorSpriteComps10034 = var_564_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_3 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_3 and not isNil(var_564_2) then
				if arg_561_1.var_.actorSpriteComps10034 then
					for iter_564_4, iter_564_5 in pairs(arg_561_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_564_5 then
							if arg_561_1.isInRecall_ then
								iter_564_5.color = Color.New(Mathf.Lerp(iter_564_5.color.r, arg_561_1.hightColor1.r, (arg_561_1.time_ - 0) / var_564_3), Mathf.Lerp(iter_564_5.color.g, arg_561_1.hightColor1.g, (arg_561_1.time_ - 0) / var_564_3), (Mathf.Lerp(iter_564_5.color.b, arg_561_1.hightColor1.b, (arg_561_1.time_ - 0) / var_564_3)))
							else
								local var_564_4 = Mathf.Lerp(iter_564_5.color.r, 1, (arg_561_1.time_ - 0) / var_564_3)

								iter_564_5.color = Color.New(var_564_4, var_564_4, var_564_4)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= 0 + var_564_3 and arg_561_1.time_ < 0 + var_564_3 + arg_564_0 and not isNil(var_564_2) and arg_561_1.var_.actorSpriteComps10034 then
				for iter_564_6, iter_564_7 in pairs(arg_561_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_564_7 then
						iter_564_7.color = arg_561_1.isInRecall_ and (arg_561_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_561_1.var_.actorSpriteComps10034 = nil
			end

			local var_564_5 = arg_561_1.actors_["10034"].transform

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos10034 = var_564_5.localPosition
				var_564_5.localScale = Vector3.New(1, 1, 1)

				arg_561_1:CheckSpriteTmpPos("10034", 4)

				for iter_564_8 = 0, var_564_5.childCount - 1 do
					local var_564_6 = var_564_5:GetChild(iter_564_8)

					if var_564_6.name == "split_5" or not string.find(var_564_6.name, "split") then
						var_564_6.gameObject:SetActive(true)
					else
						var_564_6.gameObject:SetActive(false)
					end
				end
			end

			local var_564_7 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_7 then
				var_564_5.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_561_1.time_ - 0) / var_564_7)
			end

			if arg_561_1.time_ >= 0 + var_564_7 and arg_561_1.time_ < 0 + var_564_7 + arg_564_0 then
				var_564_5.localPosition = Vector3.New(390, -415, -290)
			end

			local var_564_8 = 0
			local var_564_9 = 0.35

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_8 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_10 = arg_561_1:GetWordFromCfg(117041136)
				local var_564_11 = arg_561_1:FormatText(var_564_10.content)

				arg_561_1.text_.text = var_564_11

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_13 = 14 <= 0 and var_564_9 or var_564_9 * (utf8.len(var_564_11) / 14)

				if (14 <= 0 and var_564_9 or var_564_9 * (utf8.len(var_564_11) / 14)) > 0 and var_564_9 < var_564_13 then
					arg_561_1.talkMaxDuration = var_564_13

					if var_564_13 + var_564_8 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_13 + var_564_8
					end
				end

				arg_561_1.text_.text = var_564_11
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117041", "117041136", "story_v_out_117041.awb") ~= 0 then
					local var_564_14 = manager.audio:GetVoiceLength("story_v_out_117041", "117041136", "story_v_out_117041.awb") / 1000

					if var_564_14 + var_564_8 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_14 + var_564_8
					end

					if var_564_10.prefab_name ~= "" and arg_561_1.actors_[var_564_10.prefab_name] ~= nil then
						local var_564_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_10.prefab_name].transform, "story_v_out_117041", "117041136", "story_v_out_117041.awb")

						arg_561_1:RecordAudio("117041136", var_564_15)
						arg_561_1:RecordAudio("117041136", var_564_15)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_117041", "117041136", "story_v_out_117041.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_117041", "117041136", "story_v_out_117041.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_16 = math.max(var_564_9, arg_561_1.talkMaxDuration)

			if var_564_8 <= arg_561_1.time_ and arg_561_1.time_ < var_564_8 + var_564_16 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_8) / var_564_16

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_8 + var_564_16 and arg_561_1.time_ < var_564_8 + var_564_16 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play117041137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 117041137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play117041138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				local var_568_0 = arg_565_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_568_0 then
					arg_565_1.var_.alphaOldValue10034 = var_568_0.alpha
					arg_565_1.var_.characterEffect10034 = var_568_0
				end

				arg_565_1.var_.alphaOldValue10034 = 1
			end

			local var_568_1 = 0.333333333333333

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_1 then
				if arg_565_1.var_.characterEffect10034 then
					arg_565_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_565_1.var_.alphaOldValue10034, 0, (arg_565_1.time_ - 0) / var_568_1)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_1 and arg_565_1.time_ < 0 + var_568_1 + arg_568_0 and arg_565_1.var_.characterEffect10034 then
				arg_565_1.var_.characterEffect10034.alpha = 0
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				local var_568_2 = arg_565_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_568_2 then
					arg_565_1.var_.alphaOldValue1132 = var_568_2.alpha
					arg_565_1.var_.characterEffect1132 = var_568_2
				end

				arg_565_1.var_.alphaOldValue1132 = 1
			end

			local var_568_3 = 0.333333333333333

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_3 then
				if arg_565_1.var_.characterEffect1132 then
					arg_565_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_565_1.var_.alphaOldValue1132, 0, (arg_565_1.time_ - 0) / var_568_3)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_3 and arg_565_1.time_ < 0 + var_568_3 + arg_568_0 and arg_565_1.var_.characterEffect1132 then
				arg_565_1.var_.characterEffect1132.alpha = 0
			end

			local var_568_4 = 0
			local var_568_5 = 0.675

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, false)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_6 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(117041137).content)

				arg_565_1.text_.text = var_568_6

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_8 = 27 <= 0 and var_568_5 or var_568_5 * (utf8.len(var_568_6) / 27)

				if (27 <= 0 and var_568_5 or var_568_5 * (utf8.len(var_568_6) / 27)) > 0 and var_568_5 < var_568_8 then
					arg_565_1.talkMaxDuration = var_568_8

					if var_568_8 + var_568_4 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_8 + var_568_4
					end
				end

				arg_565_1.text_.text = var_568_6
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_9 = math.max(var_568_5, arg_565_1.talkMaxDuration)

			if var_568_4 <= arg_565_1.time_ and arg_565_1.time_ < var_568_4 + var_568_9 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_4) / var_568_9

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_4 + var_568_9 and arg_565_1.time_ < var_568_4 + var_568_9 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play117041138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 117041138
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
			arg_569_1.auto_ = false
		end

		function arg_569_1.playNext_(arg_571_0)
			arg_569_1.onStoryFinished_()
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_572_1 = 0
			local var_572_2 = 0.425

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(117041138).content)

				arg_569_1.text_.text = var_572_3

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 17 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 17)

				if (17 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 17)) > 0 and var_572_2 < var_572_5 then
					arg_569_1.talkMaxDuration = var_572_5

					if var_572_5 + var_572_1 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + var_572_1
					end
				end

				arg_569_1.text_.text = var_572_3
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_6 = math.max(var_572_2, arg_569_1.talkMaxDuration)

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_6 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_1) / var_572_6

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_1 + var_572_6 and arg_569_1.time_ < var_572_1 + var_572_6 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/TI0101",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST24a",
		"TextureConfig/Background/TI0103"
	},
	voices = {
		"story_v_out_117041.awb"
	}
}
