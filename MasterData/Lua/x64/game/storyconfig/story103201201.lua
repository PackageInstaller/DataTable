return {
	Play320121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320121001
		arg_1_1.duration_ = 4.8

		local var_1_0 = {
			zh = 4.8,
			ja = 4.033
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
				arg_1_0:Play320121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0502 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0502")
				var_4_0.name = "ST0502"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0502 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0502

				arg_1_1.bgs_.ST0502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0502" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_6_story_rich_area", "bgm_activity_3_6_story_rich_area")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(320121001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 11 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 11)

				if (11 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 11)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121001", "story_v_out_320121.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_320121", "320121001", "story_v_out_320121.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_320121", "320121001", "story_v_out_320121.awb")

						arg_1_1:RecordAudio("320121001", var_4_23)
						arg_1_1:RecordAudio("320121001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320121", "320121001", "story_v_out_320121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320121", "320121001", "story_v_out_320121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320121002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play320121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(320121002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 11 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 11)

				if (11 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 11)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play320121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320121003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.325

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(320121003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 53 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 53)

				if (53 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 53)) > 0 and var_16_0 < var_16_3 then
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
	Play320121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320121004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320121005(arg_17_1)
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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(320121004).content)

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
	Play320121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320121005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play320121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(320121005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 50 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 50)

				if (50 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 50)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320121006
		arg_25_1.duration_ = 8.13

		local var_25_0 = {
			zh = 4.733,
			ja = 8.133
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
				arg_25_0:Play320121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.6

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(320121006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 24 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 24)

				if (24 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 24)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121006", "story_v_out_320121.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121006", "story_v_out_320121.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_320121", "320121006", "story_v_out_320121.awb")

						arg_25_1:RecordAudio("320121006", var_28_6)
						arg_25_1:RecordAudio("320121006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320121", "320121006", "story_v_out_320121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320121", "320121006", "story_v_out_320121.awb")
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
	Play320121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320121007
		arg_29_1.duration_ = 2.4

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_29_0:Play320121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "10102ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10102ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["10102ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["10102ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["10102ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10102ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["10102ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10102ui_story == nil then
				arg_29_1.var_.characterEffect10102ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect10102ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10102ui_story then
				arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_8 = 0
			local var_32_9 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(320121007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 7 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 7)

				if (7 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 7)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121007", "story_v_out_320121.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_320121", "320121007", "story_v_out_320121.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_320121", "320121007", "story_v_out_320121.awb")

						arg_29_1:RecordAudio("320121007", var_32_15)
						arg_29_1:RecordAudio("320121007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320121", "320121007", "story_v_out_320121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320121", "320121007", "story_v_out_320121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play320121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320121008
		arg_33_1.duration_ = 4.93

		local var_33_0 = {
			zh = 4.933,
			ja = 2.8
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
				arg_33_0:Play320121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10102ui_story"]) and arg_33_1.var_.characterEffect10102ui_story == nil then
				arg_33_1.var_.characterEffect10102ui_story = arg_33_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10102ui_story"]) then
				if arg_33_1.var_.characterEffect10102ui_story and not isNil(arg_33_1.actors_["10102ui_story"]) then
					arg_33_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10102ui_story"]) and arg_33_1.var_.characterEffect10102ui_story then
				arg_33_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.6

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(320121008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 24 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 24)

				if (24 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 24)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121008", "story_v_out_320121.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_320121", "320121008", "story_v_out_320121.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_320121", "320121008", "story_v_out_320121.awb")

						arg_33_1:RecordAudio("320121008", var_36_8)
						arg_33_1:RecordAudio("320121008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320121", "320121008", "story_v_out_320121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320121", "320121008", "story_v_out_320121.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320121009
		arg_37_1.duration_ = 2.7

		local var_37_0 = {
			zh = 0.999999999999,
			ja = 2.7
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
				arg_37_0:Play320121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1047].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(320121009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 2 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 2)

				if (2 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 2)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121009", "story_v_out_320121.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121009", "story_v_out_320121.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_320121", "320121009", "story_v_out_320121.awb")

						arg_37_1:RecordAudio("320121009", var_40_6)
						arg_37_1:RecordAudio("320121009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320121", "320121009", "story_v_out_320121.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320121", "320121009", "story_v_out_320121.awb")
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
	Play320121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320121010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play320121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10102ui_story = arg_41_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).z)
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles = arg_41_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).z)
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles = arg_41_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["10102ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10102ui_story == nil then
				arg_41_1.var_.characterEffect10102ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect10102ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_2)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10102ui_story then
				arg_41_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_44_3 = 0
			local var_44_4 = 1.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(320121010).content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 58 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 58)

				if (58 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 58)) > 0 and var_44_4 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_8 and arg_41_1.time_ < var_44_3 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play320121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320121011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.675

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

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(320121011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 67 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 67)

				if (67 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 67)) > 0 and var_48_0 < var_48_3 then
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
	Play320121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320121012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play320121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.975

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(320121012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 39 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 39)

				if (39 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 39)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320121013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.875

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(320121013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 35 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 35)

				if (35 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 35)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320121014
		arg_57_1.duration_ = 6.07

		local var_57_0 = {
			zh = 1.366,
			ja = 6.066
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
				arg_57_0:Play320121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(320121014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 5 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 5)

				if (5 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 5)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121014", "story_v_out_320121.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121014", "story_v_out_320121.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_320121", "320121014", "story_v_out_320121.awb")

						arg_57_1:RecordAudio("320121014", var_60_6)
						arg_57_1:RecordAudio("320121014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320121", "320121014", "story_v_out_320121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320121", "320121014", "story_v_out_320121.awb")
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
	Play320121015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320121015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play320121016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(320121015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 44 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 44)

				if (44 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 44)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320121016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320121016
		arg_65_1.duration_ = 6.67

		local var_65_0 = {
			zh = 2.666,
			ja = 6.666
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
				arg_65_0:Play320121017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(320121016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)

				if (13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 13)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121016", "story_v_out_320121.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121016", "story_v_out_320121.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_320121", "320121016", "story_v_out_320121.awb")

						arg_65_1:RecordAudio("320121016", var_68_6)
						arg_65_1:RecordAudio("320121016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320121", "320121016", "story_v_out_320121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320121", "320121016", "story_v_out_320121.awb")
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
	Play320121017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320121017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320121018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.575

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(320121017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 23 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 23)

				if (23 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 23)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320121018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320121018
		arg_73_1.duration_ = 1.4

		local var_73_0 = {
			zh = 1.066,
			ja = 1.4
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
				arg_73_0:Play320121019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.075

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(320121018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 3 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 3)

				if (3 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 3)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121018", "story_v_out_320121.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121018", "story_v_out_320121.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_320121", "320121018", "story_v_out_320121.awb")

						arg_73_1:RecordAudio("320121018", var_76_6)
						arg_73_1:RecordAudio("320121018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320121", "320121018", "story_v_out_320121.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320121", "320121018", "story_v_out_320121.awb")
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
	Play320121019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320121019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play320121020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(320121019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 44 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 44)

				if (44 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 44)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320121020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320121020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play320121021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.775

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(320121020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 71 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 71)

				if (71 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 71)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320121021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320121021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play320121022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(320121021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 15 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 15)

				if (15 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 15)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play320121022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320121022
		arg_89_1.duration_ = 11.03

		local var_89_0 = {
			zh = 11.033,
			ja = 10.4
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
				arg_89_0:Play320121023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(320121022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 48 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 48)

				if (48 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 48)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121022", "story_v_out_320121.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121022", "story_v_out_320121.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_320121", "320121022", "story_v_out_320121.awb")

						arg_89_1:RecordAudio("320121022", var_92_6)
						arg_89_1:RecordAudio("320121022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_320121", "320121022", "story_v_out_320121.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_320121", "320121022", "story_v_out_320121.awb")
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
	Play320121023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320121023
		arg_93_1.duration_ = 12.87

		local var_93_0 = {
			zh = 10.433,
			ja = 12.866
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
				arg_93_0:Play320121024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(320121023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 49 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 49)

				if (49 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 49)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121023", "story_v_out_320121.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121023", "story_v_out_320121.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_320121", "320121023", "story_v_out_320121.awb")

						arg_93_1:RecordAudio("320121023", var_96_6)
						arg_93_1:RecordAudio("320121023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320121", "320121023", "story_v_out_320121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320121", "320121023", "story_v_out_320121.awb")
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
	Play320121024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320121024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320121025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.2

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(320121024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 48 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 48)

				if (48 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 48)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320121025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320121025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play320121026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.8

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(320121025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 32 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 32)

				if (32 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 32)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320121026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320121026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320121027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.25

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(320121026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 50 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 50)

				if (50 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 50)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320121027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320121027
		arg_109_1.duration_ = 2.83

		local var_109_0 = {
			zh = 2.1,
			ja = 2.833
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
				arg_109_0:Play320121028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.25

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(320121027)
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

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121027", "story_v_out_320121.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121027", "story_v_out_320121.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_320121", "320121027", "story_v_out_320121.awb")

						arg_109_1:RecordAudio("320121027", var_112_6)
						arg_109_1:RecordAudio("320121027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320121", "320121027", "story_v_out_320121.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320121", "320121027", "story_v_out_320121.awb")
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
	Play320121028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320121028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play320121029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(320121028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 14)

				if (14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 14)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play320121029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320121029
		arg_117_1.duration_ = 18.07

		local var_117_0 = {
			zh = 7.6,
			ja = 18.066
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
				arg_117_0:Play320121030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.875

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(320121029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 35 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 35)

				if (35 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 35)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121029", "story_v_out_320121.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121029", "story_v_out_320121.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_320121", "320121029", "story_v_out_320121.awb")

						arg_117_1:RecordAudio("320121029", var_120_6)
						arg_117_1:RecordAudio("320121029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_320121", "320121029", "story_v_out_320121.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_320121", "320121029", "story_v_out_320121.awb")
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
	Play320121030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320121030
		arg_121_1.duration_ = 11.77

		local var_121_0 = {
			zh = 11.766,
			ja = 11.033
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
				arg_121_0:Play320121031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.4

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(320121030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 56 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 56)

				if (56 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 56)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121030", "story_v_out_320121.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121030", "story_v_out_320121.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_320121", "320121030", "story_v_out_320121.awb")

						arg_121_1:RecordAudio("320121030", var_124_6)
						arg_121_1:RecordAudio("320121030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_320121", "320121030", "story_v_out_320121.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_320121", "320121030", "story_v_out_320121.awb")
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
	Play320121031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320121031
		arg_125_1.duration_ = 11.93

		local var_125_0 = {
			zh = 11.466,
			ja = 11.933
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play320121032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.35

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(320121031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 54 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 54)

				if (54 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 54)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121031", "story_v_out_320121.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121031", "story_v_out_320121.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_320121", "320121031", "story_v_out_320121.awb")

						arg_125_1:RecordAudio("320121031", var_128_6)
						arg_125_1:RecordAudio("320121031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320121", "320121031", "story_v_out_320121.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320121", "320121031", "story_v_out_320121.awb")
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
	Play320121032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320121032
		arg_129_1.duration_ = 4.8

		local var_129_0 = {
			zh = 2.833,
			ja = 4.8
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play320121033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.325

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(320121032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 13 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 13)

				if (13 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 13)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121032", "story_v_out_320121.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121032", "story_v_out_320121.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_320121", "320121032", "story_v_out_320121.awb")

						arg_129_1:RecordAudio("320121032", var_132_6)
						arg_129_1:RecordAudio("320121032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320121", "320121032", "story_v_out_320121.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320121", "320121032", "story_v_out_320121.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play320121033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320121033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play320121034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.95

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(320121033).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 38 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 38)

				if (38 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 38)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play320121034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320121034
		arg_137_1.duration_ = 6.57

		local var_137_0 = {
			zh = 3.233,
			ja = 6.566
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
				arg_137_0:Play320121035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.35

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(320121034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 14 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 14)

				if (14 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 14)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121034", "story_v_out_320121.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121034", "story_v_out_320121.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_320121", "320121034", "story_v_out_320121.awb")

						arg_137_1:RecordAudio("320121034", var_140_6)
						arg_137_1:RecordAudio("320121034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320121", "320121034", "story_v_out_320121.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320121", "320121034", "story_v_out_320121.awb")
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
	Play320121035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320121035
		arg_141_1.duration_ = 6.57

		local var_141_0 = {
			zh = 6.566,
			ja = 5.733
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
				arg_141_0:Play320121036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.75

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1041].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(320121035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 30 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 30)

				if (30 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 30)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121035", "story_v_out_320121.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_320121", "320121035", "story_v_out_320121.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_320121", "320121035", "story_v_out_320121.awb")

						arg_141_1:RecordAudio("320121035", var_144_6)
						arg_141_1:RecordAudio("320121035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320121", "320121035", "story_v_out_320121.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320121", "320121035", "story_v_out_320121.awb")
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
	Play320121036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320121036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play320121037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.6

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(320121036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 24 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 24)

				if (24 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 24)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320121037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320121037
		arg_149_1.duration_ = 4.9

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320121038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.bgs_.STblack == nil then
				local var_152_0 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_152_0.name = "STblack"
				var_152_0.transform.parent = arg_149_1.stage_.transform
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_.STblack = var_152_0
			end

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= 2 + arg_152_0 then
				local var_152_1 = arg_149_1.bgs_.STblack

				arg_149_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_2 = var_152_1:GetComponent("SpriteRenderer")

				if var_152_2 and var_152_2.sprite then
					local var_152_3 = 2 * (var_152_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_1.transform.localScale = Vector3.New(var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "STblack" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_4 = 4

			if 4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_4 + 0.3 and arg_149_1.time_ < var_152_4 + 0.3 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_5 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_6 = 2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 then
				local var_152_7 = Color.New(0, 0, 0)

				var_152_7.a = Mathf.Lerp(0, 1, (arg_149_1.time_ - var_152_5) / var_152_6)
				arg_149_1.mask_.color = var_152_7
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 then
				local var_152_8 = Color.New(0, 0, 0)

				var_152_8.a = 1
				arg_149_1.mask_.color = var_152_8
			end

			local var_152_9 = 2

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_10 = 2

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 then
				local var_152_11 = Color.New(0, 0, 0)

				var_152_11.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_9) / var_152_10)
				arg_149_1.mask_.color = var_152_11
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 then
				local var_152_12 = Color.New(0, 0, 0)

				arg_149_1.mask_.enabled = false
				var_152_12.a = 0
				arg_149_1.mask_.color = var_152_12
			end

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= 2 + arg_152_0 then
				arg_149_1.fswbg_:SetActive(true)
				arg_149_1.dialog_:SetActive(false)

				arg_149_1.fswtw_.percent = 0
				arg_149_1.fswt_.text = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(320121037).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.fswt_)

				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_149_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_149_1.fswtw_:SetDirty()

				arg_149_1.typewritterCharCountI18N = 0

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_13 = 3.91666666666667

			if 3.91666666666667 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1.var_.oldValueTypewriter = arg_149_1.fswtw_.percent

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_14 = 10
			local var_152_15 = 0.666666666666667
			local var_152_16, var_152_17 = arg_149_1:GetPercentByPara(arg_149_1:FormatText(arg_149_1:GetWordFromCfg(320121037).content), 1)

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				local var_152_18 = var_152_14 <= 0 and var_152_15 or var_152_15 * ((var_152_17 - arg_149_1.typewritterCharCountI18N) / var_152_14)

				if (var_152_14 <= 0 and var_152_15 or var_152_15 * ((var_152_17 - arg_149_1.typewritterCharCountI18N) / var_152_14)) > 0 and var_152_15 < var_152_18 then
					arg_149_1.talkMaxDuration = var_152_18

					if var_152_18 + var_152_13 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_13
					end
				end
			end

			local var_152_19 = math.max(0.666666666666667, arg_149_1.talkMaxDuration)

			if var_152_13 <= arg_149_1.time_ and arg_149_1.time_ < var_152_13 + var_152_19 then
				arg_149_1.fswtw_.percent = Mathf.Lerp(arg_149_1.var_.oldValueTypewriter, var_152_16, (arg_149_1.time_ - var_152_13) / var_152_19)
				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_149_1.fswtw_:SetDirty()
			end

			if arg_149_1.time_ >= var_152_13 + var_152_19 and arg_149_1.time_ < var_152_13 + var_152_19 + arg_152_0 then
				arg_149_1.fswtw_.percent = var_152_16

				arg_149_1.fswtw_:SetDirty()
				arg_149_1:ShowNextGo(true)

				arg_149_1.typewritterCharCountI18N = var_152_17
			end

			if 3.9 < arg_149_1.time_ and arg_149_1.time_ <= 3.9 + arg_152_0 then
				local var_152_20 = arg_149_1.fswbg_.transform:Find("textbox/adapt/content") or arg_149_1.fswbg_.transform:Find("textbox/content")
				local var_152_21 = arg_149_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_152_22 = var_152_20:GetComponent("RectTransform")

				var_152_20:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_152_22.offsetMin = Vector2.New(0, 0)
				var_152_22.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320121038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320121038
		arg_153_1.duration_ = 4.07

		local var_153_0 = {
			zh = 3.5,
			ja = 4.066
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
				arg_153_0:Play320121039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if arg_153_1.bgs_.ST05a == nil then
				local var_156_0 = Object.Instantiate(arg_153_1.paintGo_)

				var_156_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05a")
				var_156_0.name = "ST05a"
				var_156_0.transform.parent = arg_153_1.stage_.transform
				var_156_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.bgs_.ST05a = var_156_0
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				local var_156_1 = arg_153_1.bgs_.ST05a

				arg_153_1.bgs_.ST05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_156_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_2 = var_156_1:GetComponent("SpriteRenderer")

				if var_156_2 and var_156_2.sprite then
					local var_156_3 = 2 * (var_156_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_156_1.transform.localScale = Vector3.New(var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "ST05a" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_4 = 2

			if 2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			if arg_153_1.time_ >= var_156_4 + 0.3 and arg_153_1.time_ < var_156_4 + 0.3 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			local var_156_5 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_6 = 2

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 then
				local var_156_7 = Color.New(0, 0, 0)

				var_156_7.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_5) / var_156_6)
				arg_153_1.mask_.color = var_156_7
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 then
				local var_156_8 = Color.New(0, 0, 0)

				arg_153_1.mask_.enabled = false
				var_156_8.a = 0
				arg_153_1.mask_.color = var_156_8
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.fswbg_:SetActive(false)
				arg_153_1.dialog_:SetActive(false)
				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_153_1:ShowNextGo(false)
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_9 = 2
			local var_156_10 = 0.2

			if 2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_11 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_11:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1047].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_12 = arg_153_1:GetWordFromCfg(320121038)
				local var_156_13 = arg_153_1:FormatText(var_156_12.content)

				arg_153_1.text_.text = var_156_13

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_15 = 8 <= 0 and var_156_10 or var_156_10 * (utf8.len(var_156_13) / 8)

				if (8 <= 0 and var_156_10 or var_156_10 * (utf8.len(var_156_13) / 8)) > 0 and var_156_10 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15
					var_156_9 = var_156_9 + 0.3

					if var_156_15 + var_156_9 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_9
					end
				end

				arg_153_1.text_.text = var_156_13
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121038", "story_v_out_320121.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_320121", "320121038", "story_v_out_320121.awb") / 1000

					if var_156_16 + var_156_9 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_9
					end

					if var_156_12.prefab_name ~= "" and arg_153_1.actors_[var_156_12.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_12.prefab_name].transform, "story_v_out_320121", "320121038", "story_v_out_320121.awb")

						arg_153_1:RecordAudio("320121038", var_156_17)
						arg_153_1:RecordAudio("320121038", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320121", "320121038", "story_v_out_320121.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320121", "320121038", "story_v_out_320121.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = var_156_9 + 0.3
			local var_156_19 = math.max(var_156_10, arg_153_1.talkMaxDuration)

			if var_156_9 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_18 + var_156_19 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_18) / var_156_19

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_18 + var_156_19 and arg_153_1.time_ < var_156_18 + var_156_19 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play320121039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 320121039
		arg_159_1.duration_ = 4.5

		local var_159_0 = {
			zh = 4.5,
			ja = 4.1
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
				arg_159_0:Play320121040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10102ui_story = arg_159_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10102ui_story"].transform.position).z)
				arg_159_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10102ui_story"].transform.localEulerAngles = arg_159_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_159_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10102ui_story"].transform.position).z)
				arg_159_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10102ui_story"].transform.localEulerAngles = arg_159_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["10102ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10102ui_story == nil then
				arg_159_1.var_.characterEffect10102ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect10102ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect10102ui_story then
				arg_159_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_162_4 = 0
			local var_162_5 = 0.675

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(320121039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 27 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 27)

				if (27 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 27)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121039", "story_v_out_320121.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_320121", "320121039", "story_v_out_320121.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_320121", "320121039", "story_v_out_320121.awb")

						arg_159_1:RecordAudio("320121039", var_162_11)
						arg_159_1:RecordAudio("320121039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_320121", "320121039", "story_v_out_320121.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_320121", "320121039", "story_v_out_320121.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play320121040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 320121040
		arg_163_1.duration_ = 9.6

		local var_163_0 = {
			zh = 7.733,
			ja = 9.6
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
				arg_163_0:Play320121041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10102ui_story = arg_163_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10102ui_story"].transform.position).z)
				arg_163_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10102ui_story"].transform.localEulerAngles = arg_163_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_163_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10102ui_story"].transform.position).z)
				arg_163_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10102ui_story"].transform.localEulerAngles = arg_163_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["10102ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect10102ui_story == nil then
				arg_163_1.var_.characterEffect10102ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect10102ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_2)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect10102ui_story then
				arg_163_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_166_3 = "1011ui_story"

			if arg_163_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_166_4 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_163_1.stage_.transform)

				var_166_4.name = var_166_3
				var_166_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_[var_166_3] = var_166_4

				local var_166_5 = var_166_4:GetComponentInChildren(typeof(CharacterEffect))

				var_166_5.enabled = true

				local var_166_6 = GameObjectTools.GetOrAddComponent(var_166_4, typeof(DynamicBoneHelper))

				if var_166_6 then
					var_166_6:EnableDynamicBone(false)
				end

				arg_163_1:ShowWeapon(var_166_5.transform, false)

				arg_163_1.var_[var_166_3 .. "Animator"] = var_166_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_163_1.var_[var_166_3 .. "Animator"].applyRootMotion = true
				arg_163_1.var_[var_166_3 .. "LipSync"] = var_166_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_166_7 = arg_163_1.actors_["1011ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1011ui_story = var_166_7.localPosition
			end

			local var_166_8 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_8 then
				var_166_7.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_163_1.time_ - 0) / var_166_8)
				var_166_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_7.position).x, (manager.ui.mainCamera.transform.position - var_166_7.position).y, (manager.ui.mainCamera.transform.position - var_166_7.position).z)
				var_166_7.localEulerAngles.z = 0
				var_166_7.localEulerAngles.x = 0
				var_166_7.localEulerAngles = var_166_7.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_8 and arg_163_1.time_ < 0 + var_166_8 + arg_166_0 then
				var_166_7.localPosition = Vector3.New(0.7, -0.71, -6)
				var_166_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_7.position).x, (manager.ui.mainCamera.transform.position - var_166_7.position).y, (manager.ui.mainCamera.transform.position - var_166_7.position).z)
				var_166_7.localEulerAngles.z = 0
				var_166_7.localEulerAngles.x = 0
				var_166_7.localEulerAngles = var_166_7.localEulerAngles
			end

			local var_166_9 = arg_163_1.actors_["1011ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1011ui_story == nil then
				arg_163_1.var_.characterEffect1011ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_10 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_10 and not isNil(var_166_9) then
				if arg_163_1.var_.characterEffect1011ui_story and not isNil(var_166_9) then
					arg_163_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_10 and arg_163_1.time_ < 0 + var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1011ui_story then
				arg_163_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_166_12 = 0
			local var_166_13 = 0.7

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_14 = arg_163_1:GetWordFromCfg(320121040)
				local var_166_15 = arg_163_1:FormatText(var_166_14.content)

				arg_163_1.text_.text = var_166_15

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_17 = 28 <= 0 and var_166_13 or var_166_13 * (utf8.len(var_166_15) / 28)

				if (28 <= 0 and var_166_13 or var_166_13 * (utf8.len(var_166_15) / 28)) > 0 and var_166_13 < var_166_17 then
					arg_163_1.talkMaxDuration = var_166_17

					if var_166_17 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_12
					end
				end

				arg_163_1.text_.text = var_166_15
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121040", "story_v_out_320121.awb") ~= 0 then
					local var_166_18 = manager.audio:GetVoiceLength("story_v_out_320121", "320121040", "story_v_out_320121.awb") / 1000

					if var_166_18 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_12
					end

					if var_166_14.prefab_name ~= "" and arg_163_1.actors_[var_166_14.prefab_name] ~= nil then
						local var_166_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_14.prefab_name].transform, "story_v_out_320121", "320121040", "story_v_out_320121.awb")

						arg_163_1:RecordAudio("320121040", var_166_19)
						arg_163_1:RecordAudio("320121040", var_166_19)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_320121", "320121040", "story_v_out_320121.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_320121", "320121040", "story_v_out_320121.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_20 and arg_163_1.time_ < var_166_12 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play320121041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 320121041
		arg_167_1.duration_ = 3.77

		local var_167_0 = {
			zh = 3.5,
			ja = 3.766
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
				arg_167_0:Play320121042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10102ui_story"]) and arg_167_1.var_.characterEffect10102ui_story == nil then
				arg_167_1.var_.characterEffect10102ui_story = arg_167_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10102ui_story"]) then
				if arg_167_1.var_.characterEffect10102ui_story and not isNil(arg_167_1.actors_["10102ui_story"]) then
					arg_167_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10102ui_story"]) and arg_167_1.var_.characterEffect10102ui_story then
				arg_167_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_170_2 = arg_167_1.actors_["1011ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1011ui_story == nil then
				arg_167_1.var_.characterEffect1011ui_story = var_170_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_3 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.characterEffect1011ui_story and not isNil(var_170_2) then
					arg_167_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_3)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1011ui_story then
				arg_167_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_170_4 = 0
			local var_170_5 = 0.3

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(320121041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 12 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 12)

				if (12 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 12)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121041", "story_v_out_320121.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_320121", "320121041", "story_v_out_320121.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_320121", "320121041", "story_v_out_320121.awb")

						arg_167_1:RecordAudio("320121041", var_170_11)
						arg_167_1:RecordAudio("320121041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_320121", "320121041", "story_v_out_320121.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_320121", "320121041", "story_v_out_320121.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play320121042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 320121042
		arg_171_1.duration_ = 4.13

		local var_171_0 = {
			zh = 2.9,
			ja = 4.133
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
				arg_171_0:Play320121043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10102ui_story"]) and arg_171_1.var_.characterEffect10102ui_story == nil then
				arg_171_1.var_.characterEffect10102ui_story = arg_171_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10102ui_story"]) then
				if arg_171_1.var_.characterEffect10102ui_story and not isNil(arg_171_1.actors_["10102ui_story"]) then
					arg_171_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10102ui_story"]) and arg_171_1.var_.characterEffect10102ui_story then
				arg_171_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.4

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1047].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(320121042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_6 = 16 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_4) / 16)

				if (16 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_4) / 16)) > 0 and var_174_2 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121042", "story_v_out_320121.awb") ~= 0 then
					local var_174_7 = manager.audio:GetVoiceLength("story_v_out_320121", "320121042", "story_v_out_320121.awb") / 1000

					if var_174_7 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_1
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_320121", "320121042", "story_v_out_320121.awb")

						arg_171_1:RecordAudio("320121042", var_174_8)
						arg_171_1:RecordAudio("320121042", var_174_8)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_320121", "320121042", "story_v_out_320121.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_320121", "320121042", "story_v_out_320121.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_9 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_9 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_9

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_9 and arg_171_1.time_ < var_174_1 + var_174_9 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play320121043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 320121043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play320121044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10102ui_story = arg_175_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10102ui_story"].transform.position).z)
				arg_175_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10102ui_story"].transform.localEulerAngles = arg_175_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10102ui_story"].transform.position).z)
				arg_175_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10102ui_story"].transform.localEulerAngles = arg_175_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["10102ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10102ui_story == nil then
				arg_175_1.var_.characterEffect10102ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect10102ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_2)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10102ui_story then
				arg_175_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_178_3 = arg_175_1.actors_["1011ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1011ui_story = var_178_3.localPosition
			end

			local var_178_4 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				var_178_3.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_4)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				var_178_3.localPosition = Vector3.New(0, 100, 0)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			local var_178_5 = arg_175_1.actors_["1011ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1011ui_story == nil then
				arg_175_1.var_.characterEffect1011ui_story = var_178_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.characterEffect1011ui_story and not isNil(var_178_5) then
					arg_175_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_6)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1011ui_story then
				arg_175_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_175_1.time_ and arg_175_1.time_ <= 0.3 + arg_178_0 then
				arg_175_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_178_8 = 0
			local var_178_9 = 1.475

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(320121043).content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_12 = 59 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_10) / 59)

				if (59 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_10) / 59)) > 0 and var_178_9 < var_178_12 then
					arg_175_1.talkMaxDuration = var_178_12

					if var_178_12 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_13 and arg_175_1.time_ < var_178_8 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play320121044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 320121044
		arg_179_1.duration_ = 2.6

		local var_179_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_179_0:Play320121045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10102ui_story = arg_179_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10102ui_story"].transform.position).z)
				arg_179_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10102ui_story"].transform.localEulerAngles = arg_179_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_179_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10102ui_story"].transform.position).z)
				arg_179_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10102ui_story"].transform.localEulerAngles = arg_179_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["10102ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10102ui_story == nil then
				arg_179_1.var_.characterEffect10102ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect10102ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10102ui_story then
				arg_179_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_182_4 = 0
			local var_182_5 = 0.225

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(320121044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 9 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 9)

				if (9 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 9)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121044", "story_v_out_320121.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_320121", "320121044", "story_v_out_320121.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_320121", "320121044", "story_v_out_320121.awb")

						arg_179_1:RecordAudio("320121044", var_182_11)
						arg_179_1:RecordAudio("320121044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_320121", "320121044", "story_v_out_320121.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_320121", "320121044", "story_v_out_320121.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play320121045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 320121045
		arg_183_1.duration_ = 7.27

		local var_183_0 = {
			zh = 5,
			ja = 7.266
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
				arg_183_0:Play320121046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1011ui_story = arg_183_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).z)
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles = arg_183_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_183_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).z)
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles = arg_183_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1011ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1011ui_story == nil then
				arg_183_1.var_.characterEffect1011ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1011ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1011ui_story then
				arg_183_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_186_4 = arg_183_1.actors_["10102ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect10102ui_story == nil then
				arg_183_1.var_.characterEffect10102ui_story = var_186_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_5 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_5 and not isNil(var_186_4) then
				if arg_183_1.var_.characterEffect10102ui_story and not isNil(var_186_4) then
					arg_183_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_5)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_5 and arg_183_1.time_ < 0 + var_186_5 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect10102ui_story then
				arg_183_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_186_6 = 0
			local var_186_7 = 0.35

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(320121045)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 14 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 14)

				if (14 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 14)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121045", "story_v_out_320121.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_out_320121", "320121045", "story_v_out_320121.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_out_320121", "320121045", "story_v_out_320121.awb")

						arg_183_1:RecordAudio("320121045", var_186_13)
						arg_183_1:RecordAudio("320121045", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_320121", "320121045", "story_v_out_320121.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_320121", "320121045", "story_v_out_320121.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play320121046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 320121046
		arg_187_1.duration_ = 6.1

		local var_187_0 = {
			zh = 4.633,
			ja = 6.1
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
			arg_187_1.auto_ = false
		end

		function arg_187_1.playNext_(arg_189_0)
			arg_187_1.onStoryFinished_()
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_0 = 0
			local var_190_1 = 0.55

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(320121046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 22 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 22)

				if (22 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 22)) > 0 and var_190_1 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320121", "320121046", "story_v_out_320121.awb") ~= 0 then
					local var_190_6 = manager.audio:GetVoiceLength("story_v_out_320121", "320121046", "story_v_out_320121.awb") / 1000

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end

					if var_190_2.prefab_name ~= "" and arg_187_1.actors_[var_190_2.prefab_name] ~= nil then
						local var_190_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_2.prefab_name].transform, "story_v_out_320121", "320121046", "story_v_out_320121.awb")

						arg_187_1:RecordAudio("320121046", var_190_7)
						arg_187_1:RecordAudio("320121046", var_190_7)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_320121", "320121046", "story_v_out_320121.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_320121", "320121046", "story_v_out_320121.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_8 and arg_187_1.time_ < var_190_0 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0502",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST05a"
	},
	voices = {
		"story_v_out_320121.awb"
	}
}
