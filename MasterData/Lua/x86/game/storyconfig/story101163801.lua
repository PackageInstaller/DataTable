return {
	Play116381001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116381001
		arg_1_1.duration_ = 10.45

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116381002(arg_1_1)
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116381001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 2.01666666666667

			if 2.01666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_5 = 37
			local var_4_6 = 2.46666666666667
			local var_4_7, var_4_8 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116381001).content), 1)

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_9 = var_4_5 <= 0 and var_4_6 or var_4_6 * ((var_4_8 - arg_1_1.typewritterCharCountI18N) / var_4_5)

				if (var_4_5 <= 0 and var_4_6 or var_4_6 * ((var_4_8 - arg_1_1.typewritterCharCountI18N) / var_4_5)) > 0 and var_4_6 < var_4_9 then
					arg_1_1.talkMaxDuration = var_4_9

					if var_4_9 + var_4_4 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_9 + var_4_4
					end
				end
			end

			local var_4_10 = math.max(2.46666666666667, arg_1_1.talkMaxDuration)

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_10 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_7, (arg_1_1.time_ - var_4_4) / var_4_10)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_4 + var_4_10 and arg_1_1.time_ < var_4_4 + var_4_10 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_7

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_8
			end

			local var_4_11 = 2
			local var_4_12 = manager.audio:GetVoiceLength("story_v_out_116381", "116381001", "story_v_out_116381.awb") / 1000

			if var_4_12 > 0 and 8.451 < var_4_12 and var_4_12 + var_4_11 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_12 + var_4_11
			end

			if var_4_11 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_116381", "116381001", "story_v_out_116381.awb")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			if 2.2 < arg_1_1.time_ and arg_1_1.time_ <= 2.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= "" and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = ""

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = ""
						arg_1_1.bgmTxt2_.text = ""
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

			if 2.375 < arg_1_1.time_ and arg_1_1.time_ <= 2.375 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[97].musicName ~= "" then
					if arg_1_1.bgmTxt_.text ~= MusicRecordCfg[97].musicName and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = MusicRecordCfg[97].musicName

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = MusicRecordCfg[97].musicName
						arg_1_1.bgmTxt2_.text = MusicRecordCfg[97].musicName
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

			local var_4_20 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_21 = 2

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				local var_4_22 = Color.New(0, 0, 0)

				var_4_22.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_20) / var_4_21)
				arg_1_1.mask_.color = var_4_22
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				local var_4_23 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_23.a = 0
				arg_1_1.mask_.color = var_4_23
			end

			local var_4_24 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_24 + 2.48333333333333 and arg_1_1.time_ < var_4_24 + 2.48333333333333 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116381002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 116381002
		arg_8_1.duration_ = 10.27

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play116381003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.oldValueTypewriter = arg_8_1.fswtw_.percent

				SetActive(arg_8_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_8_1:ShowNextGo(false)
			end

			local var_11_0 = 44
			local var_11_1 = 2.93333333333333
			local var_11_2, var_11_3 = arg_8_1:GetPercentByPara(arg_8_1:FormatText(arg_8_1:GetWordFromCfg(116381001).content), 2)

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				local var_11_4 = var_11_0 <= 0 and var_11_1 or var_11_1 * ((var_11_3 - arg_8_1.typewritterCharCountI18N) / var_11_0)

				if (var_11_0 <= 0 and var_11_1 or var_11_1 * ((var_11_3 - arg_8_1.typewritterCharCountI18N) / var_11_0)) > 0 and var_11_1 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end
			end

			local var_11_5 = math.max(2.93333333333333, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_5 then
				arg_8_1.fswtw_.percent = Mathf.Lerp(arg_8_1.var_.oldValueTypewriter, var_11_2, (arg_8_1.time_ - 0) / var_11_5)
				arg_8_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_8_1.fswtw_:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_5 and arg_8_1.time_ < 0 + var_11_5 + arg_11_0 then
				arg_8_1.fswtw_.percent = var_11_2

				arg_8_1.fswtw_:SetDirty()
				arg_8_1:ShowNextGo(true)

				arg_8_1.typewritterCharCountI18N = var_11_3
			end

			local var_11_6 = 0
			local var_11_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381002", "story_v_out_116381.awb") / 1000

			if var_11_7 > 0 and 10.275 < var_11_7 and var_11_7 + var_11_6 > arg_8_1.duration_ then
				arg_8_1.duration_ = var_11_7 + var_11_6
			end

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1:AudioAction("play", "voice", "story_v_out_116381", "116381002", "story_v_out_116381.awb")
			end

			local var_11_9 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			if arg_8_1.time_ >= var_11_9 + 2.93333333333333 and arg_8_1.time_ < var_11_9 + 2.93333333333333 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play116381003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 116381003
		arg_12_1.duration_ = 13.78

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play116381004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.oldValueTypewriter = arg_12_1.fswtw_.percent

				SetActive(arg_12_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_12_1:ShowNextGo(false)
			end

			local var_15_0 = 61
			local var_15_1 = 4.13333333333333
			local var_15_2, var_15_3 = arg_12_1:GetPercentByPara(arg_12_1:FormatText(arg_12_1:GetWordFromCfg(116381001).content), 3)

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				local var_15_4 = var_15_0 <= 0 and var_15_1 or var_15_1 * ((var_15_3 - arg_12_1.typewritterCharCountI18N) / var_15_0)

				if (var_15_0 <= 0 and var_15_1 or var_15_1 * ((var_15_3 - arg_12_1.typewritterCharCountI18N) / var_15_0)) > 0 and var_15_1 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end
			end

			local var_15_5 = math.max(4.13333333333333, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				arg_12_1.fswtw_.percent = Mathf.Lerp(arg_12_1.var_.oldValueTypewriter, var_15_2, (arg_12_1.time_ - 0) / var_15_5)
				arg_12_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_12_1.fswtw_:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				arg_12_1.fswtw_.percent = var_15_2

				arg_12_1.fswtw_:SetDirty()
				arg_12_1:ShowNextGo(true)

				arg_12_1.typewritterCharCountI18N = var_15_3
			end

			local var_15_6 = 0
			local var_15_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381003", "story_v_out_116381.awb") / 1000

			if var_15_7 > 0 and 13.78 < var_15_7 and var_15_7 + var_15_6 > arg_12_1.duration_ then
				arg_12_1.duration_ = var_15_7 + var_15_6
			end

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1:AudioAction("play", "voice", "story_v_out_116381", "116381003", "story_v_out_116381.awb")
			end

			local var_15_9 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_9 + 4.13333333333333 and arg_12_1.time_ < var_15_9 + 4.13333333333333 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play116381004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 116381004
		arg_16_1.duration_ = 1.35

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play116381005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.oldValueTypewriter = arg_16_1.fswtw_.percent

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_0 = 11
			local var_19_1 = 0.733333333333333
			local var_19_2, var_19_3 = arg_16_1:GetPercentByPara(arg_16_1:FormatText(arg_16_1:GetWordFromCfg(116381001).content), 4)

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				local var_19_4 = var_19_0 <= 0 and var_19_1 or var_19_1 * ((var_19_3 - arg_16_1.typewritterCharCountI18N) / var_19_0)

				if (var_19_0 <= 0 and var_19_1 or var_19_1 * ((var_19_3 - arg_16_1.typewritterCharCountI18N) / var_19_0)) > 0 and var_19_1 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end
			end

			local var_19_5 = math.max(0.733333333333333, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				arg_16_1.fswtw_.percent = Mathf.Lerp(arg_16_1.var_.oldValueTypewriter, var_19_2, (arg_16_1.time_ - 0) / var_19_5)
				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_16_1.fswtw_:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				arg_16_1.fswtw_.percent = var_19_2

				arg_16_1.fswtw_:SetDirty()
				arg_16_1:ShowNextGo(true)

				arg_16_1.typewritterCharCountI18N = var_19_3
			end

			local var_19_6 = 0
			local var_19_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381004", "story_v_out_116381.awb") / 1000

			if var_19_7 > 0 and 1.349 < var_19_7 and var_19_7 + var_19_6 > arg_16_1.duration_ then
				arg_16_1.duration_ = var_19_7 + var_19_6
			end

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1:AudioAction("play", "voice", "story_v_out_116381", "116381004", "story_v_out_116381.awb")
			end

			local var_19_9 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_9 + 0.733333333333333 and arg_16_1.time_ < var_19_9 + 0.733333333333333 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play116381005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 116381005
		arg_20_1.duration_ = 4.22

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play116381006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_0 = 23
			local var_23_1 = 1.53333333333333
			local var_23_2, var_23_3 = arg_20_1:GetPercentByPara(arg_20_1:FormatText(arg_20_1:GetWordFromCfg(116381001).content), 5)

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_4 = var_23_0 <= 0 and var_23_1 or var_23_1 * ((var_23_3 - arg_20_1.typewritterCharCountI18N) / var_23_0)

				if (var_23_0 <= 0 and var_23_1 or var_23_1 * ((var_23_3 - arg_20_1.typewritterCharCountI18N) / var_23_0)) > 0 and var_23_1 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end
			end

			local var_23_5 = math.max(1.53333333333333, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_2, (arg_20_1.time_ - 0) / var_23_5)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_2

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_3
			end

			local var_23_6 = 0
			local var_23_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381005", "story_v_out_116381.awb") / 1000

			if var_23_7 > 0 and 4.217 < var_23_7 and var_23_7 + var_23_6 > arg_20_1.duration_ then
				arg_20_1.duration_ = var_23_7 + var_23_6
			end

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1:AudioAction("play", "voice", "story_v_out_116381", "116381005", "story_v_out_116381.awb")
			end

			local var_23_9 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_9 + 1.53333333333333 and arg_20_1.time_ < var_23_9 + 1.53333333333333 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play116381006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 116381006
		arg_24_1.duration_ = 7.03

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play116381007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.oldValueTypewriter = arg_24_1.fswtw_.percent

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_0 = 42
			local var_27_1 = 2.8
			local var_27_2, var_27_3 = arg_24_1:GetPercentByPara(arg_24_1:FormatText(arg_24_1:GetWordFromCfg(116381001).content), 6)

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				local var_27_4 = var_27_0 <= 0 and var_27_1 or var_27_1 * ((var_27_3 - arg_24_1.typewritterCharCountI18N) / var_27_0)

				if (var_27_0 <= 0 and var_27_1 or var_27_1 * ((var_27_3 - arg_24_1.typewritterCharCountI18N) / var_27_0)) > 0 and var_27_1 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end
			end

			local var_27_5 = math.max(2.8, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				arg_24_1.fswtw_.percent = Mathf.Lerp(arg_24_1.var_.oldValueTypewriter, var_27_2, (arg_24_1.time_ - 0) / var_27_5)
				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_24_1.fswtw_:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				arg_24_1.fswtw_.percent = var_27_2

				arg_24_1.fswtw_:SetDirty()
				arg_24_1:ShowNextGo(true)

				arg_24_1.typewritterCharCountI18N = var_27_3
			end

			local var_27_6 = 0
			local var_27_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381006", "story_v_out_116381.awb") / 1000

			if var_27_7 > 0 and 7.027 < var_27_7 and var_27_7 + var_27_6 > arg_24_1.duration_ then
				arg_24_1.duration_ = var_27_7 + var_27_6
			end

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1:AudioAction("play", "voice", "story_v_out_116381", "116381006", "story_v_out_116381.awb")
			end

			local var_27_9 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			if arg_24_1.time_ >= var_27_9 + 2.8 and arg_24_1.time_ < var_27_9 + 2.8 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play116381007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 116381007
		arg_28_1.duration_ = 10.29

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play116381008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.fswbg_:SetActive(true)
				arg_28_1.dialog_:SetActive(false)

				arg_28_1.fswtw_.percent = 0
				arg_28_1.fswt_.text = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(116381007).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.fswt_)

				arg_28_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_28_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_28_1.fswtw_:SetDirty()

				arg_28_1.typewritterCharCountI18N = 0

				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_28_1:ShowNextGo(false)
			end

			local var_31_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.var_.oldValueTypewriter = arg_28_1.fswtw_.percent

				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_28_1:ShowNextGo(false)
			end

			local var_31_1 = 48
			local var_31_2 = 3.2
			local var_31_3, var_31_4 = arg_28_1:GetPercentByPara(arg_28_1:FormatText(arg_28_1:GetWordFromCfg(116381007).content), 1)

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				local var_31_5 = var_31_1 <= 0 and var_31_2 or var_31_2 * ((var_31_4 - arg_28_1.typewritterCharCountI18N) / var_31_1)

				if (var_31_1 <= 0 and var_31_2 or var_31_2 * ((var_31_4 - arg_28_1.typewritterCharCountI18N) / var_31_1)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_0
					end
				end
			end

			local var_31_6 = math.max(3.2, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_6 then
				arg_28_1.fswtw_.percent = Mathf.Lerp(arg_28_1.var_.oldValueTypewriter, var_31_3, (arg_28_1.time_ - var_31_0) / var_31_6)
				arg_28_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_28_1.fswtw_:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_6 and arg_28_1.time_ < var_31_0 + var_31_6 + arg_31_0 then
				arg_28_1.fswtw_.percent = var_31_3

				arg_28_1.fswtw_:SetDirty()
				arg_28_1:ShowNextGo(true)

				arg_28_1.typewritterCharCountI18N = var_31_4
			end

			local var_31_7 = 0
			local var_31_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381007", "story_v_out_116381.awb") / 1000

			if var_31_8 > 0 and 10.287 < var_31_8 and var_31_8 + var_31_7 > arg_28_1.duration_ then
				arg_28_1.duration_ = var_31_8 + var_31_7
			end

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1:AudioAction("play", "voice", "story_v_out_116381", "116381007", "story_v_out_116381.awb")
			end

			local var_31_10 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_10 + 3.21666666666667 and arg_28_1.time_ < var_31_10 + 3.21666666666667 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play116381008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 116381008
		arg_32_1.duration_ = 7.65

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play116381009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.oldValueTypewriter = arg_32_1.fswtw_.percent

				SetActive(arg_32_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_32_1:ShowNextGo(false)
			end

			local var_35_0 = 27
			local var_35_1 = 1.8
			local var_35_2, var_35_3 = arg_32_1:GetPercentByPara(arg_32_1:FormatText(arg_32_1:GetWordFromCfg(116381007).content), 2)

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				local var_35_4 = var_35_0 <= 0 and var_35_1 or var_35_1 * ((var_35_3 - arg_32_1.typewritterCharCountI18N) / var_35_0)

				if (var_35_0 <= 0 and var_35_1 or var_35_1 * ((var_35_3 - arg_32_1.typewritterCharCountI18N) / var_35_0)) > 0 and var_35_1 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end
			end

			local var_35_5 = math.max(1.8, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				arg_32_1.fswtw_.percent = Mathf.Lerp(arg_32_1.var_.oldValueTypewriter, var_35_2, (arg_32_1.time_ - 0) / var_35_5)
				arg_32_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_32_1.fswtw_:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				arg_32_1.fswtw_.percent = var_35_2

				arg_32_1.fswtw_:SetDirty()
				arg_32_1:ShowNextGo(true)

				arg_32_1.typewritterCharCountI18N = var_35_3
			end

			local var_35_6 = 0
			local var_35_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381008", "story_v_out_116381.awb") / 1000

			if var_35_7 > 0 and 7.654 < var_35_7 and var_35_7 + var_35_6 > arg_32_1.duration_ then
				arg_32_1.duration_ = var_35_7 + var_35_6
			end

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1:AudioAction("play", "voice", "story_v_out_116381", "116381008", "story_v_out_116381.awb")
			end

			local var_35_9 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= var_35_9 + 1.8 and arg_32_1.time_ < var_35_9 + 1.8 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play116381009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116381009
		arg_36_1.duration_ = 12.17

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play116381010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.oldValueTypewriter = arg_36_1.fswtw_.percent

				SetActive(arg_36_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_36_1:ShowNextGo(false)
			end

			local var_39_0 = 61
			local var_39_1 = 4.06666666666667
			local var_39_2, var_39_3 = arg_36_1:GetPercentByPara(arg_36_1:FormatText(arg_36_1:GetWordFromCfg(116381007).content), 3)

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				local var_39_4 = var_39_0 <= 0 and var_39_1 or var_39_1 * ((var_39_3 - arg_36_1.typewritterCharCountI18N) / var_39_0)

				if (var_39_0 <= 0 and var_39_1 or var_39_1 * ((var_39_3 - arg_36_1.typewritterCharCountI18N) / var_39_0)) > 0 and var_39_1 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end
			end

			local var_39_5 = math.max(4.06666666666667, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				arg_36_1.fswtw_.percent = Mathf.Lerp(arg_36_1.var_.oldValueTypewriter, var_39_2, (arg_36_1.time_ - 0) / var_39_5)
				arg_36_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_36_1.fswtw_:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				arg_36_1.fswtw_.percent = var_39_2

				arg_36_1.fswtw_:SetDirty()
				arg_36_1:ShowNextGo(true)

				arg_36_1.typewritterCharCountI18N = var_39_3
			end

			local var_39_6 = 0
			local var_39_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381009", "story_v_out_116381.awb") / 1000

			if var_39_7 > 0 and 12.169 < var_39_7 and var_39_7 + var_39_6 > arg_36_1.duration_ then
				arg_36_1.duration_ = var_39_7 + var_39_6
			end

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1:AudioAction("play", "voice", "story_v_out_116381", "116381009", "story_v_out_116381.awb")
			end

			local var_39_9 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_9 + 4.06666666666667 and arg_36_1.time_ < var_39_9 + 4.06666666666667 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play116381010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 116381010
		arg_40_1.duration_ = 9.97

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play116381011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.oldValueTypewriter = arg_40_1.fswtw_.percent

				SetActive(arg_40_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_40_1:ShowNextGo(false)
			end

			local var_43_0 = 31
			local var_43_1 = 2.06666666666667
			local var_43_2, var_43_3 = arg_40_1:GetPercentByPara(arg_40_1:FormatText(arg_40_1:GetWordFromCfg(116381007).content), 4)

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				local var_43_4 = var_43_0 <= 0 and var_43_1 or var_43_1 * ((var_43_3 - arg_40_1.typewritterCharCountI18N) / var_43_0)

				if (var_43_0 <= 0 and var_43_1 or var_43_1 * ((var_43_3 - arg_40_1.typewritterCharCountI18N) / var_43_0)) > 0 and var_43_1 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end
			end

			local var_43_5 = math.max(2.06666666666667, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				arg_40_1.fswtw_.percent = Mathf.Lerp(arg_40_1.var_.oldValueTypewriter, var_43_2, (arg_40_1.time_ - 0) / var_43_5)
				arg_40_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_40_1.fswtw_:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				arg_40_1.fswtw_.percent = var_43_2

				arg_40_1.fswtw_:SetDirty()
				arg_40_1:ShowNextGo(true)

				arg_40_1.typewritterCharCountI18N = var_43_3
			end

			local var_43_6 = 0
			local var_43_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381010", "story_v_out_116381.awb") / 1000

			if var_43_7 > 0 and 9.974 < var_43_7 and var_43_7 + var_43_6 > arg_40_1.duration_ then
				arg_40_1.duration_ = var_43_7 + var_43_6
			end

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1:AudioAction("play", "voice", "story_v_out_116381", "116381010", "story_v_out_116381.awb")
			end

			local var_43_9 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_9 + 2.06666666666667 and arg_40_1.time_ < var_43_9 + 2.06666666666667 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play116381011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 116381011
		arg_44_1.duration_ = 0.96

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play116381012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.oldValueTypewriter = arg_44_1.fswtw_.percent

				SetActive(arg_44_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_44_1:ShowNextGo(false)
			end

			local var_47_0 = 10
			local var_47_1 = 0.666666666666667
			local var_47_2, var_47_3 = arg_44_1:GetPercentByPara(arg_44_1:FormatText(arg_44_1:GetWordFromCfg(116381007).content), 5)

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				local var_47_4 = var_47_0 <= 0 and var_47_1 or var_47_1 * ((var_47_3 - arg_44_1.typewritterCharCountI18N) / var_47_0)

				if (var_47_0 <= 0 and var_47_1 or var_47_1 * ((var_47_3 - arg_44_1.typewritterCharCountI18N) / var_47_0)) > 0 and var_47_1 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end
			end

			local var_47_5 = math.max(0.666666666666667, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				arg_44_1.fswtw_.percent = Mathf.Lerp(arg_44_1.var_.oldValueTypewriter, var_47_2, (arg_44_1.time_ - 0) / var_47_5)
				arg_44_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_44_1.fswtw_:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				arg_44_1.fswtw_.percent = var_47_2

				arg_44_1.fswtw_:SetDirty()
				arg_44_1:ShowNextGo(true)

				arg_44_1.typewritterCharCountI18N = var_47_3
			end

			local var_47_6 = 0
			local var_47_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381011", "story_v_out_116381.awb") / 1000

			if var_47_7 > 0 and 0.965 < var_47_7 and var_47_7 + var_47_6 > arg_44_1.duration_ then
				arg_44_1.duration_ = var_47_7 + var_47_6
			end

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1:AudioAction("play", "voice", "story_v_out_116381", "116381011", "story_v_out_116381.awb")
			end

			local var_47_9 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			if arg_44_1.time_ >= var_47_9 + 0.666666666666667 and arg_44_1.time_ < var_47_9 + 0.666666666666667 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play116381012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 116381012
		arg_48_1.duration_ = 9.53

		local var_48_0 = {
			zh = 8.2,
			ja = 9.533
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
				arg_48_0:Play116381013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if arg_48_1.bgs_.SK0107 == nil then
				local var_51_0 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0107")
				var_51_0.name = "SK0107"
				var_51_0.transform.parent = arg_48_1.stage_.transform
				var_51_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_.SK0107 = var_51_0
			end

			if 2 < arg_48_1.time_ and arg_48_1.time_ <= 2 + arg_51_0 then
				local var_51_1 = arg_48_1.bgs_.SK0107

				arg_48_1.bgs_.SK0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_51_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_2 = var_51_1:GetComponent("SpriteRenderer")

				if var_51_2 and var_51_2.sprite then
					local var_51_3 = 2 * (var_51_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_51_1.transform.localScale = Vector3.New(var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "SK0107" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_4 = 0

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_5 = 2

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_5 then
				local var_51_6 = Color.New(0, 0, 0)

				var_51_6.a = Mathf.Lerp(0, 1, (arg_48_1.time_ - var_51_4) / var_51_5)
				arg_48_1.mask_.color = var_51_6
			end

			if arg_48_1.time_ >= var_51_4 + var_51_5 and arg_48_1.time_ < var_51_4 + var_51_5 + arg_51_0 then
				local var_51_7 = Color.New(0, 0, 0)

				var_51_7.a = 1
				arg_48_1.mask_.color = var_51_7
			end

			local var_51_8 = 2

			if 2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_9 = 2

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_9 then
				local var_51_10 = Color.New(0, 0, 0)

				var_51_10.a = Mathf.Lerp(1, 0, (arg_48_1.time_ - var_51_8) / var_51_9)
				arg_48_1.mask_.color = var_51_10
			end

			if arg_48_1.time_ >= var_51_8 + var_51_9 and arg_48_1.time_ < var_51_8 + var_51_9 + arg_51_0 then
				local var_51_11 = Color.New(0, 0, 0)

				arg_48_1.mask_.enabled = false
				var_51_11.a = 0
				arg_48_1.mask_.color = var_51_11
			end

			if 1.98333333333333 < arg_48_1.time_ and arg_48_1.time_ <= 1.98333333333333 + arg_51_0 then
				arg_48_1.fswbg_:SetActive(false)
				arg_48_1.dialog_:SetActive(false)
				SetActive(arg_48_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_48_1:ShowNextGo(false)
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_12 = 4
			local var_51_13 = 0.4

			if 4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_14 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_14:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_48_1.dialogCg_.alpha = arg_52_0
				end))
				var_51_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_15 = arg_48_1:GetWordFromCfg(116381012)
				local var_51_16 = arg_48_1:FormatText(var_51_15.content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_18 = 15 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_16) / 15)

				if (15 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_16) / 15)) > 0 and var_51_13 < var_51_18 then
					arg_48_1.talkMaxDuration = var_51_18
					var_51_12 = var_51_12 + 0.3

					if var_51_18 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381012", "story_v_out_116381.awb") ~= 0 then
					local var_51_19 = manager.audio:GetVoiceLength("story_v_out_116381", "116381012", "story_v_out_116381.awb") / 1000

					if var_51_19 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_12
					end

					if var_51_15.prefab_name ~= "" and arg_48_1.actors_[var_51_15.prefab_name] ~= nil then
						local var_51_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_15.prefab_name].transform, "story_v_out_116381", "116381012", "story_v_out_116381.awb")

						arg_48_1:RecordAudio("116381012", var_51_20)
						arg_48_1:RecordAudio("116381012", var_51_20)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_116381", "116381012", "story_v_out_116381.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_116381", "116381012", "story_v_out_116381.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_21 = var_51_12 + 0.3
			local var_51_22 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 + 0.3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_21) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play116381013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116381013
		arg_54_1.duration_ = 15.2

		local var_54_0 = {
			zh = 11.366,
			ja = 15.2
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
				arg_54_0:Play116381014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.bgs_.SK0112 == nil then
				local var_57_0 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0112")
				var_57_0.name = "SK0112"
				var_57_0.transform.parent = arg_54_1.stage_.transform
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_.SK0112 = var_57_0
			end

			if 2 < arg_54_1.time_ and arg_54_1.time_ <= 2 + arg_57_0 then
				local var_57_1 = arg_54_1.bgs_.SK0112

				arg_54_1.bgs_.SK0112.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_57_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_2 = var_57_1:GetComponent("SpriteRenderer")

				if var_57_2 and var_57_2.sprite then
					local var_57_3 = 2 * (var_57_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_57_1.transform.localScale = Vector3.New(var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "SK0112" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_4 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_5 = 2

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_5 then
				local var_57_6 = Color.New(0, 0, 0)

				var_57_6.a = Mathf.Lerp(0, 1, (arg_54_1.time_ - var_57_4) / var_57_5)
				arg_54_1.mask_.color = var_57_6
			end

			if arg_54_1.time_ >= var_57_4 + var_57_5 and arg_54_1.time_ < var_57_4 + var_57_5 + arg_57_0 then
				local var_57_7 = Color.New(0, 0, 0)

				var_57_7.a = 1
				arg_54_1.mask_.color = var_57_7
			end

			local var_57_8 = 2

			if 2 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_9 = 2

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_9 then
				local var_57_10 = Color.New(0, 0, 0)

				var_57_10.a = Mathf.Lerp(1, 0, (arg_54_1.time_ - var_57_8) / var_57_9)
				arg_54_1.mask_.color = var_57_10
			end

			if arg_54_1.time_ >= var_57_8 + var_57_9 and arg_54_1.time_ < var_57_8 + var_57_9 + arg_57_0 then
				local var_57_11 = Color.New(0, 0, 0)

				arg_54_1.mask_.enabled = false
				var_57_11.a = 0
				arg_54_1.mask_.color = var_57_11
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_12 = 4
			local var_57_13 = 0.7

			if 4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_12 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_14 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_14:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_15 = arg_54_1:GetWordFromCfg(116381013)
				local var_57_16 = arg_54_1:FormatText(var_57_15.content)

				arg_54_1.text_.text = var_57_16

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_18 = 26 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_16) / 26)

				if (26 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_16) / 26)) > 0 and var_57_13 < var_57_18 then
					arg_54_1.talkMaxDuration = var_57_18
					var_57_12 = var_57_12 + 0.3

					if var_57_18 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_18 + var_57_12
					end
				end

				arg_54_1.text_.text = var_57_16
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381013", "story_v_out_116381.awb") ~= 0 then
					local var_57_19 = manager.audio:GetVoiceLength("story_v_out_116381", "116381013", "story_v_out_116381.awb") / 1000

					if var_57_19 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_19 + var_57_12
					end

					if var_57_15.prefab_name ~= "" and arg_54_1.actors_[var_57_15.prefab_name] ~= nil then
						local var_57_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_15.prefab_name].transform, "story_v_out_116381", "116381013", "story_v_out_116381.awb")

						arg_54_1:RecordAudio("116381013", var_57_20)
						arg_54_1:RecordAudio("116381013", var_57_20)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_116381", "116381013", "story_v_out_116381.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_116381", "116381013", "story_v_out_116381.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_21 = var_57_12 + 0.3
			local var_57_22 = math.max(var_57_13, arg_54_1.talkMaxDuration)

			if var_57_12 + 0.3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_22 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_21) / var_57_22

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_21 + var_57_22 and arg_54_1.time_ < var_57_21 + var_57_22 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play116381014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116381014
		arg_60_1.duration_ = 8.83

		local var_60_0 = {
			zh = 8.833,
			ja = 7.933
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
				arg_60_0:Play116381015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.bgs_.SK0201 == nil then
				local var_63_0 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0201")
				var_63_0.name = "SK0201"
				var_63_0.transform.parent = arg_60_1.stage_.transform
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_.SK0201 = var_63_0
			end

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= 2 + arg_63_0 then
				local var_63_1 = arg_60_1.bgs_.SK0201

				arg_60_1.bgs_.SK0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_2 = var_63_1:GetComponent("SpriteRenderer")

				if var_63_2 and var_63_2.sprite then
					local var_63_3 = 2 * (var_63_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_1.transform.localScale = Vector3.New(var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "SK0201" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_4 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_5 = 2

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_5 then
				local var_63_6 = Color.New(0, 0, 0)

				var_63_6.a = Mathf.Lerp(0, 1, (arg_60_1.time_ - var_63_4) / var_63_5)
				arg_60_1.mask_.color = var_63_6
			end

			if arg_60_1.time_ >= var_63_4 + var_63_5 and arg_60_1.time_ < var_63_4 + var_63_5 + arg_63_0 then
				local var_63_7 = Color.New(0, 0, 0)

				var_63_7.a = 1
				arg_60_1.mask_.color = var_63_7
			end

			local var_63_8 = 2

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_9 = 2

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_9 then
				local var_63_10 = Color.New(0, 0, 0)

				var_63_10.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_8) / var_63_9)
				arg_60_1.mask_.color = var_63_10
			end

			if arg_60_1.time_ >= var_63_8 + var_63_9 and arg_60_1.time_ < var_63_8 + var_63_9 + arg_63_0 then
				local var_63_11 = Color.New(0, 0, 0)

				arg_60_1.mask_.enabled = false
				var_63_11.a = 0
				arg_60_1.mask_.color = var_63_11
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_12 = 4
			local var_63_13 = 0.4

			if 4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_14 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_14:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_15 = arg_60_1:GetWordFromCfg(116381014)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_18 = 16 <= 0 and var_63_13 or var_63_13 * (utf8.len(var_63_16) / 16)

				if (16 <= 0 and var_63_13 or var_63_13 * (utf8.len(var_63_16) / 16)) > 0 and var_63_13 < var_63_18 then
					arg_60_1.talkMaxDuration = var_63_18
					var_63_12 = var_63_12 + 0.3

					if var_63_18 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381014", "story_v_out_116381.awb") ~= 0 then
					local var_63_19 = manager.audio:GetVoiceLength("story_v_out_116381", "116381014", "story_v_out_116381.awb") / 1000

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_116381", "116381014", "story_v_out_116381.awb")

						arg_60_1:RecordAudio("116381014", var_63_20)
						arg_60_1:RecordAudio("116381014", var_63_20)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_116381", "116381014", "story_v_out_116381.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_116381", "116381014", "story_v_out_116381.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_21 = var_63_12 + 0.3
			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_21) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_21 + var_63_22 and arg_60_1.time_ < var_63_21 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play116381015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116381015
		arg_66_1.duration_ = 17.77

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116381016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 2 < arg_66_1.time_ and arg_66_1.time_ <= 2 + arg_69_0 then
				local var_69_0 = arg_66_1.bgs_.STblack

				arg_66_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_1 = var_69_0:GetComponent("SpriteRenderer")

				if var_69_1 and var_69_1.sprite then
					local var_69_2 = 2 * (var_69_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_0.transform.localScale = Vector3.New(var_69_2 / var_69_1.sprite.bounds.size.y < var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x and var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x or var_69_2 / var_69_1.sprite.bounds.size.y, var_69_2 / var_69_1.sprite.bounds.size.y < var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x and var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x or var_69_2 / var_69_1.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "STblack" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_3 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_4 = 2

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_4 then
				local var_69_5 = Color.New(0, 0, 0)

				var_69_5.a = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_3) / var_69_4)
				arg_66_1.mask_.color = var_69_5
			end

			if arg_66_1.time_ >= var_69_3 + var_69_4 and arg_66_1.time_ < var_69_3 + var_69_4 + arg_69_0 then
				local var_69_6 = Color.New(0, 0, 0)

				var_69_6.a = 1
				arg_66_1.mask_.color = var_69_6
			end

			local var_69_7 = 2

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_8 = 2

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_8 then
				local var_69_9 = Color.New(0, 0, 0)

				var_69_9.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_7) / var_69_8)
				arg_66_1.mask_.color = var_69_9
			end

			if arg_66_1.time_ >= var_69_7 + var_69_8 and arg_66_1.time_ < var_69_7 + var_69_8 + arg_69_0 then
				local var_69_10 = Color.New(0, 0, 0)

				arg_66_1.mask_.enabled = false
				var_69_10.a = 0
				arg_66_1.mask_.color = var_69_10
			end

			local var_69_11 = 4
			local var_69_12 = manager.audio:GetVoiceLength("story_v_out_116381", "116381015", "story_v_out_116381.awb") / 1000

			if var_69_12 > 0 and 12.868 < var_69_12 and var_69_12 + var_69_11 > arg_66_1.duration_ then
				arg_66_1.duration_ = var_69_12 + var_69_11
			end

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1:AudioAction("play", "voice", "story_v_out_116381", "116381015", "story_v_out_116381.awb")
			end

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= 2 + arg_69_0 then
				arg_66_1.fswbg_:SetActive(true)
				arg_66_1.dialog_:SetActive(false)

				arg_66_1.fswtw_.percent = 0
				arg_66_1.fswt_.text = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(116381015).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.fswt_)

				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_66_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_66_1.fswtw_:SetDirty()

				arg_66_1.typewritterCharCountI18N = 0

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_14 = 4

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1.var_.oldValueTypewriter = arg_66_1.fswtw_.percent

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_15 = 53
			local var_69_16 = 3.53333333333333
			local var_69_17, var_69_18 = arg_66_1:GetPercentByPara(arg_66_1:FormatText(arg_66_1:GetWordFromCfg(116381015).content), 1)

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				local var_69_19 = var_69_15 <= 0 and var_69_16 or var_69_16 * ((var_69_18 - arg_66_1.typewritterCharCountI18N) / var_69_15)

				if (var_69_15 <= 0 and var_69_16 or var_69_16 * ((var_69_18 - arg_66_1.typewritterCharCountI18N) / var_69_15)) > 0 and var_69_16 < var_69_19 then
					arg_66_1.talkMaxDuration = var_69_19

					if var_69_19 + var_69_14 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_19 + var_69_14
					end
				end
			end

			local var_69_20 = math.max(3.53333333333333, arg_66_1.talkMaxDuration)

			if var_69_14 <= arg_66_1.time_ and arg_66_1.time_ < var_69_14 + var_69_20 then
				arg_66_1.fswtw_.percent = Mathf.Lerp(arg_66_1.var_.oldValueTypewriter, var_69_17, (arg_66_1.time_ - var_69_14) / var_69_20)
				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.fswtw_:SetDirty()
			end

			if arg_66_1.time_ >= var_69_14 + var_69_20 and arg_66_1.time_ < var_69_14 + var_69_20 + arg_69_0 then
				arg_66_1.fswtw_.percent = var_69_17

				arg_66_1.fswtw_:SetDirty()
				arg_66_1:ShowNextGo(true)

				arg_66_1.typewritterCharCountI18N = var_69_18
			end

			local var_69_21 = 4

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_21 + 3.53333333333333 and arg_66_1.time_ < var_69_21 + 3.53333333333333 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play116381016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116381016
		arg_70_1.duration_ = 7.7

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116381017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.oldValueTypewriter = arg_70_1.fswtw_.percent

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_0 = 93
			local var_73_1 = 2.66666666666667
			local var_73_2, var_73_3 = arg_70_1:GetPercentByPara(arg_70_1:FormatText(arg_70_1:GetWordFromCfg(116381015).content), 2)

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				local var_73_4 = var_73_0 <= 0 and var_73_1 or var_73_1 * ((var_73_3 - arg_70_1.typewritterCharCountI18N) / var_73_0)

				if (var_73_0 <= 0 and var_73_1 or var_73_1 * ((var_73_3 - arg_70_1.typewritterCharCountI18N) / var_73_0)) > 0 and var_73_1 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end
			end

			local var_73_5 = math.max(2.66666666666667, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_5 then
				arg_70_1.fswtw_.percent = Mathf.Lerp(arg_70_1.var_.oldValueTypewriter, var_73_2, (arg_70_1.time_ - 0) / var_73_5)
				arg_70_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_70_1.fswtw_:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_5 and arg_70_1.time_ < 0 + var_73_5 + arg_73_0 then
				arg_70_1.fswtw_.percent = var_73_2

				arg_70_1.fswtw_:SetDirty()
				arg_70_1:ShowNextGo(true)

				arg_70_1.typewritterCharCountI18N = var_73_3
			end

			local var_73_6 = 0
			local var_73_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381016", "story_v_out_116381.awb") / 1000

			if var_73_7 > 0 and 7.697 < var_73_7 and var_73_7 + var_73_6 > arg_70_1.duration_ then
				arg_70_1.duration_ = var_73_7 + var_73_6
			end

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1:AudioAction("play", "voice", "story_v_out_116381", "116381016", "story_v_out_116381.awb")
			end

			local var_73_9 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			if arg_70_1.time_ >= var_73_9 + 2.66666666666667 and arg_70_1.time_ < var_73_9 + 2.66666666666667 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116381017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116381017
		arg_74_1.duration_ = 3.49

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play116381018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.oldValueTypewriter = arg_74_1.fswtw_.percent

				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_0 = 12
			local var_77_1 = 0.8
			local var_77_2, var_77_3 = arg_74_1:GetPercentByPara(arg_74_1:FormatText(arg_74_1:GetWordFromCfg(116381015).content), 3)

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				local var_77_4 = var_77_0 <= 0 and var_77_1 or var_77_1 * ((var_77_3 - arg_74_1.typewritterCharCountI18N) / var_77_0)

				if (var_77_0 <= 0 and var_77_1 or var_77_1 * ((var_77_3 - arg_74_1.typewritterCharCountI18N) / var_77_0)) > 0 and var_77_1 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end
			end

			local var_77_5 = math.max(0.8, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_5 then
				arg_74_1.fswtw_.percent = Mathf.Lerp(arg_74_1.var_.oldValueTypewriter, var_77_2, (arg_74_1.time_ - 0) / var_77_5)
				arg_74_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_74_1.fswtw_:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_5 and arg_74_1.time_ < 0 + var_77_5 + arg_77_0 then
				arg_74_1.fswtw_.percent = var_77_2

				arg_74_1.fswtw_:SetDirty()
				arg_74_1:ShowNextGo(true)

				arg_74_1.typewritterCharCountI18N = var_77_3
			end

			local var_77_6 = 0
			local var_77_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381017", "story_v_out_116381.awb") / 1000

			if var_77_7 > 0 and 3.495 < var_77_7 and var_77_7 + var_77_6 > arg_74_1.duration_ then
				arg_74_1.duration_ = var_77_7 + var_77_6
			end

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1:AudioAction("play", "voice", "story_v_out_116381", "116381017", "story_v_out_116381.awb")
			end

			local var_77_9 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			if arg_74_1.time_ >= var_77_9 + 0.8 and arg_74_1.time_ < var_77_9 + 0.8 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play116381018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116381018
		arg_78_1.duration_ = 13.85

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116381019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.oldValueTypewriter = arg_78_1.fswtw_.percent

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_0 = 64
			local var_81_1 = 4.26666666666667
			local var_81_2, var_81_3 = arg_78_1:GetPercentByPara(arg_78_1:FormatText(arg_78_1:GetWordFromCfg(116381015).content), 4)

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				local var_81_4 = var_81_0 <= 0 and var_81_1 or var_81_1 * ((var_81_3 - arg_78_1.typewritterCharCountI18N) / var_81_0)

				if (var_81_0 <= 0 and var_81_1 or var_81_1 * ((var_81_3 - arg_78_1.typewritterCharCountI18N) / var_81_0)) > 0 and var_81_1 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end
			end

			local var_81_5 = math.max(4.26666666666667, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_5 then
				arg_78_1.fswtw_.percent = Mathf.Lerp(arg_78_1.var_.oldValueTypewriter, var_81_2, (arg_78_1.time_ - 0) / var_81_5)
				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.fswtw_:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_5 and arg_78_1.time_ < 0 + var_81_5 + arg_81_0 then
				arg_78_1.fswtw_.percent = var_81_2

				arg_78_1.fswtw_:SetDirty()
				arg_78_1:ShowNextGo(true)

				arg_78_1.typewritterCharCountI18N = var_81_3
			end

			local var_81_6 = 0
			local var_81_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381018", "story_v_out_116381.awb") / 1000

			if var_81_7 > 0 and 13.849 < var_81_7 and var_81_7 + var_81_6 > arg_78_1.duration_ then
				arg_78_1.duration_ = var_81_7 + var_81_6
			end

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1:AudioAction("play", "voice", "story_v_out_116381", "116381018", "story_v_out_116381.awb")
			end

			local var_81_9 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			if arg_78_1.time_ >= var_81_9 + 4.26666666666667 and arg_78_1.time_ < var_81_9 + 4.26666666666667 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play116381019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116381019
		arg_82_1.duration_ = 4.21

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116381020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.oldValueTypewriter = arg_82_1.fswtw_.percent

				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_0 = 15
			local var_85_1 = 1
			local var_85_2, var_85_3 = arg_82_1:GetPercentByPara(arg_82_1:FormatText(arg_82_1:GetWordFromCfg(116381015).content), 5)

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				local var_85_4 = var_85_0 <= 0 and var_85_1 or var_85_1 * ((var_85_3 - arg_82_1.typewritterCharCountI18N) / var_85_0)

				if (var_85_0 <= 0 and var_85_1 or var_85_1 * ((var_85_3 - arg_82_1.typewritterCharCountI18N) / var_85_0)) > 0 and var_85_1 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end
			end

			local var_85_5 = math.max(1, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_5 then
				arg_82_1.fswtw_.percent = Mathf.Lerp(arg_82_1.var_.oldValueTypewriter, var_85_2, (arg_82_1.time_ - 0) / var_85_5)
				arg_82_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_82_1.fswtw_:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_5 and arg_82_1.time_ < 0 + var_85_5 + arg_85_0 then
				arg_82_1.fswtw_.percent = var_85_2

				arg_82_1.fswtw_:SetDirty()
				arg_82_1:ShowNextGo(true)

				arg_82_1.typewritterCharCountI18N = var_85_3
			end

			local var_85_6 = 0
			local var_85_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381019", "story_v_out_116381.awb") / 1000

			if var_85_7 > 0 and 4.215 < var_85_7 and var_85_7 + var_85_6 > arg_82_1.duration_ then
				arg_82_1.duration_ = var_85_7 + var_85_6
			end

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1:AudioAction("play", "voice", "story_v_out_116381", "116381019", "story_v_out_116381.awb")
			end

			local var_85_9 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_9 + 1 and arg_82_1.time_ < var_85_9 + 1 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116381020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116381020
		arg_86_1.duration_ = 10.61

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116381021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.oldValueTypewriter = arg_86_1.fswtw_.percent

				SetActive(arg_86_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_86_1:ShowNextGo(false)
			end

			local var_89_0 = 49
			local var_89_1 = 3.26666666666667
			local var_89_2, var_89_3 = arg_86_1:GetPercentByPara(arg_86_1:FormatText(arg_86_1:GetWordFromCfg(116381015).content), 6)

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				local var_89_4 = var_89_0 <= 0 and var_89_1 or var_89_1 * ((var_89_3 - arg_86_1.typewritterCharCountI18N) / var_89_0)

				if (var_89_0 <= 0 and var_89_1 or var_89_1 * ((var_89_3 - arg_86_1.typewritterCharCountI18N) / var_89_0)) > 0 and var_89_1 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end
			end

			local var_89_5 = math.max(3.26666666666667, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 then
				arg_86_1.fswtw_.percent = Mathf.Lerp(arg_86_1.var_.oldValueTypewriter, var_89_2, (arg_86_1.time_ - 0) / var_89_5)
				arg_86_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_86_1.fswtw_:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 then
				arg_86_1.fswtw_.percent = var_89_2

				arg_86_1.fswtw_:SetDirty()
				arg_86_1:ShowNextGo(true)

				arg_86_1.typewritterCharCountI18N = var_89_3
			end

			local var_89_6 = 0
			local var_89_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381020", "story_v_out_116381.awb") / 1000

			if var_89_7 > 0 and 10.607 < var_89_7 and var_89_7 + var_89_6 > arg_86_1.duration_ then
				arg_86_1.duration_ = var_89_7 + var_89_6
			end

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1:AudioAction("play", "voice", "story_v_out_116381", "116381020", "story_v_out_116381.awb")
			end

			local var_89_9 = 0

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			if arg_86_1.time_ >= var_89_9 + 3.26666666666667 and arg_86_1.time_ < var_89_9 + 3.26666666666667 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play116381021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116381021
		arg_90_1.duration_ = 7.81

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116381022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.oldValueTypewriter = arg_90_1.fswtw_.percent

				SetActive(arg_90_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_90_1:ShowNextGo(false)
			end

			local var_93_0 = 43
			local var_93_1 = 2.86666666666667
			local var_93_2, var_93_3 = arg_90_1:GetPercentByPara(arg_90_1:FormatText(arg_90_1:GetWordFromCfg(116381015).content), 7)

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				local var_93_4 = var_93_0 <= 0 and var_93_1 or var_93_1 * ((var_93_3 - arg_90_1.typewritterCharCountI18N) / var_93_0)

				if (var_93_0 <= 0 and var_93_1 or var_93_1 * ((var_93_3 - arg_90_1.typewritterCharCountI18N) / var_93_0)) > 0 and var_93_1 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end
			end

			local var_93_5 = math.max(2.86666666666667, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_5 then
				arg_90_1.fswtw_.percent = Mathf.Lerp(arg_90_1.var_.oldValueTypewriter, var_93_2, (arg_90_1.time_ - 0) / var_93_5)
				arg_90_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_90_1.fswtw_:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_5 and arg_90_1.time_ < 0 + var_93_5 + arg_93_0 then
				arg_90_1.fswtw_.percent = var_93_2

				arg_90_1.fswtw_:SetDirty()
				arg_90_1:ShowNextGo(true)

				arg_90_1.typewritterCharCountI18N = var_93_3
			end

			local var_93_6 = 0
			local var_93_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381021", "story_v_out_116381.awb") / 1000

			if var_93_7 > 0 and 7.807 < var_93_7 and var_93_7 + var_93_6 > arg_90_1.duration_ then
				arg_90_1.duration_ = var_93_7 + var_93_6
			end

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1:AudioAction("play", "voice", "story_v_out_116381", "116381021", "story_v_out_116381.awb")
			end

			local var_93_9 = 0

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.allBtn_.enabled = false
			end

			if arg_90_1.time_ >= var_93_9 + 2.86666666666667 and arg_90_1.time_ < var_93_9 + 2.86666666666667 + arg_93_0 then
				arg_90_1.allBtn_.enabled = true
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116381022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116381022
		arg_94_1.duration_ = 20.4

		local var_94_0 = {
			zh = 15.7,
			ja = 20.4
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
				arg_94_0:Play116381023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.bgs_.SK0106 == nil then
				local var_97_0 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0106")
				var_97_0.name = "SK0106"
				var_97_0.transform.parent = arg_94_1.stage_.transform
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_.SK0106 = var_97_0
			end

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= 2 + arg_97_0 then
				local var_97_1 = arg_94_1.bgs_.SK0106

				arg_94_1.bgs_.SK0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_2 = var_97_1:GetComponent("SpriteRenderer")

				if var_97_2 and var_97_2.sprite then
					local var_97_3 = 2 * (var_97_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_1.transform.localScale = Vector3.New(var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "SK0106" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_4 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_5 = 2

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_5 then
				local var_97_6 = Color.New(0, 0, 0)

				var_97_6.a = Mathf.Lerp(0, 1, (arg_94_1.time_ - var_97_4) / var_97_5)
				arg_94_1.mask_.color = var_97_6
			end

			if arg_94_1.time_ >= var_97_4 + var_97_5 and arg_94_1.time_ < var_97_4 + var_97_5 + arg_97_0 then
				local var_97_7 = Color.New(0, 0, 0)

				var_97_7.a = 1
				arg_94_1.mask_.color = var_97_7
			end

			local var_97_8 = 2

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_9 = 2

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_9 then
				local var_97_10 = Color.New(0, 0, 0)

				var_97_10.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_8) / var_97_9)
				arg_94_1.mask_.color = var_97_10
			end

			if arg_94_1.time_ >= var_97_8 + var_97_9 and arg_94_1.time_ < var_97_8 + var_97_9 + arg_97_0 then
				local var_97_11 = Color.New(0, 0, 0)

				arg_94_1.mask_.enabled = false
				var_97_11.a = 0
				arg_94_1.mask_.color = var_97_11
			end

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= 2 + arg_97_0 then
				arg_94_1.fswbg_:SetActive(false)
				arg_94_1.dialog_:SetActive(false)
				SetActive(arg_94_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_94_1:ShowNextGo(false)
			end

			local var_97_12 = 2

			arg_94_1.isInRecall_ = false

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.screenFilterGo_:SetActive(true)

				arg_94_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_97_2, iter_97_3 in pairs(arg_94_1.actors_) do
					for iter_97_4, iter_97_5 in ipairs((iter_97_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_97_5.color = iter_97_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_97_13 = 0.1

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_13 then
				arg_94_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_94_1.time_ - var_97_12) / var_97_13)
			end

			if arg_94_1.time_ >= var_97_12 + var_97_13 and arg_94_1.time_ < var_97_12 + var_97_13 + arg_97_0 then
				arg_94_1.screenFilterEffect_.weight = 1
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_14 = 4
			local var_97_15 = 0.875

			if 4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_14 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_16 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_16:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_17 = arg_94_1:GetWordFromCfg(116381022)
				local var_97_18 = arg_94_1:FormatText(var_97_17.content)

				arg_94_1.text_.text = var_97_18

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_20 = 34 <= 0 and var_97_15 or var_97_15 * (utf8.len(var_97_18) / 34)

				if (34 <= 0 and var_97_15 or var_97_15 * (utf8.len(var_97_18) / 34)) > 0 and var_97_15 < var_97_20 then
					arg_94_1.talkMaxDuration = var_97_20
					var_97_14 = var_97_14 + 0.3

					if var_97_20 + var_97_14 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_14
					end
				end

				arg_94_1.text_.text = var_97_18
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381022", "story_v_out_116381.awb") ~= 0 then
					local var_97_21 = manager.audio:GetVoiceLength("story_v_out_116381", "116381022", "story_v_out_116381.awb") / 1000

					if var_97_21 + var_97_14 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_21 + var_97_14
					end

					if var_97_17.prefab_name ~= "" and arg_94_1.actors_[var_97_17.prefab_name] ~= nil then
						local var_97_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_17.prefab_name].transform, "story_v_out_116381", "116381022", "story_v_out_116381.awb")

						arg_94_1:RecordAudio("116381022", var_97_22)
						arg_94_1:RecordAudio("116381022", var_97_22)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_116381", "116381022", "story_v_out_116381.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_116381", "116381022", "story_v_out_116381.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_23 = var_97_14 + 0.3
			local var_97_24 = math.max(var_97_15, arg_94_1.talkMaxDuration)

			if var_97_14 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_23 + var_97_24 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_23) / var_97_24

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_23 + var_97_24 and arg_94_1.time_ < var_97_23 + var_97_24 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play116381023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116381023
		arg_100_1.duration_ = 15.73

		local var_100_0 = {
			zh = 12.1,
			ja = 15.733
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
				arg_100_0:Play116381024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 1.15

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:GetWordFromCfg(116381023)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 46 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 46)

				if (46 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 46)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381023", "story_v_out_116381.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381023", "story_v_out_116381.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_116381", "116381023", "story_v_out_116381.awb")

						arg_100_1:RecordAudio("116381023", var_103_6)
						arg_100_1:RecordAudio("116381023", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_116381", "116381023", "story_v_out_116381.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_116381", "116381023", "story_v_out_116381.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play116381024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 116381024
		arg_104_1.duration_ = 8.8

		local var_104_0 = {
			zh = 4.066,
			ja = 8.8
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
				arg_104_0:Play116381025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.375

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:GetWordFromCfg(116381024)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 15 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 15)

				if (15 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 15)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381024", "story_v_out_116381.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381024", "story_v_out_116381.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_116381", "116381024", "story_v_out_116381.awb")

						arg_104_1:RecordAudio("116381024", var_107_6)
						arg_104_1:RecordAudio("116381024", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_116381", "116381024", "story_v_out_116381.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_116381", "116381024", "story_v_out_116381.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play116381025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 116381025
		arg_108_1.duration_ = 3.83

		local var_108_0 = {
			zh = 3.2,
			ja = 3.833
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
				arg_108_0:Play116381026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.35

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:GetWordFromCfg(116381025)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 13 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 13)

				if (13 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 13)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381025", "story_v_out_116381.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381025", "story_v_out_116381.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_116381", "116381025", "story_v_out_116381.awb")

						arg_108_1:RecordAudio("116381025", var_111_6)
						arg_108_1:RecordAudio("116381025", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_116381", "116381025", "story_v_out_116381.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_116381", "116381025", "story_v_out_116381.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play116381026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 116381026
		arg_112_1.duration_ = 12.73

		local var_112_0 = {
			zh = 12.733,
			ja = 9.8
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
				arg_112_0:Play116381027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if arg_112_1.bgs_.SK0102 == nil then
				local var_115_0 = Object.Instantiate(arg_112_1.paintGo_)

				var_115_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0102")
				var_115_0.name = "SK0102"
				var_115_0.transform.parent = arg_112_1.stage_.transform
				var_115_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.bgs_.SK0102 = var_115_0
			end

			if 2 < arg_112_1.time_ and arg_112_1.time_ <= 2 + arg_115_0 then
				local var_115_1 = arg_112_1.bgs_.SK0102

				arg_112_1.bgs_.SK0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_115_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_115_2 = var_115_1:GetComponent("SpriteRenderer")

				if var_115_2 and var_115_2.sprite then
					local var_115_3 = 2 * (var_115_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_115_1.transform.localScale = Vector3.New(var_115_3 / var_115_2.sprite.bounds.size.y < var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x and var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x or var_115_3 / var_115_2.sprite.bounds.size.y, var_115_3 / var_115_2.sprite.bounds.size.y < var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x and var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x or var_115_3 / var_115_2.sprite.bounds.size.y, 0)
				end

				for iter_115_0, iter_115_1 in pairs(arg_112_1.bgs_) do
					if iter_115_0 ~= "SK0102" then
						iter_115_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_115_4 = 0

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_5 = 2

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_5 then
				local var_115_6 = Color.New(0, 0, 0)

				var_115_6.a = Mathf.Lerp(0, 1, (arg_112_1.time_ - var_115_4) / var_115_5)
				arg_112_1.mask_.color = var_115_6
			end

			if arg_112_1.time_ >= var_115_4 + var_115_5 and arg_112_1.time_ < var_115_4 + var_115_5 + arg_115_0 then
				local var_115_7 = Color.New(0, 0, 0)

				var_115_7.a = 1
				arg_112_1.mask_.color = var_115_7
			end

			local var_115_8 = 2

			if 2 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_9 = 2

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_9 then
				local var_115_10 = Color.New(0, 0, 0)

				var_115_10.a = Mathf.Lerp(1, 0, (arg_112_1.time_ - var_115_8) / var_115_9)
				arg_112_1.mask_.color = var_115_10
			end

			if arg_112_1.time_ >= var_115_8 + var_115_9 and arg_112_1.time_ < var_115_8 + var_115_9 + arg_115_0 then
				local var_115_11 = Color.New(0, 0, 0)

				arg_112_1.mask_.enabled = false
				var_115_11.a = 0
				arg_112_1.mask_.color = var_115_11
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_12 = 4
			local var_115_13 = 0.45

			if 4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_14 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_14:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_15 = arg_112_1:GetWordFromCfg(116381026)
				local var_115_16 = arg_112_1:FormatText(var_115_15.content)

				arg_112_1.text_.text = var_115_16

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_18 = 19 <= 0 and var_115_13 or var_115_13 * (utf8.len(var_115_16) / 19)

				if (19 <= 0 and var_115_13 or var_115_13 * (utf8.len(var_115_16) / 19)) > 0 and var_115_13 < var_115_18 then
					arg_112_1.talkMaxDuration = var_115_18
					var_115_12 = var_115_12 + 0.3

					if var_115_18 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_18 + var_115_12
					end
				end

				arg_112_1.text_.text = var_115_16
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381026", "story_v_out_116381.awb") ~= 0 then
					local var_115_19 = manager.audio:GetVoiceLength("story_v_out_116381", "116381026", "story_v_out_116381.awb") / 1000

					if var_115_19 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_19 + var_115_12
					end

					if var_115_15.prefab_name ~= "" and arg_112_1.actors_[var_115_15.prefab_name] ~= nil then
						local var_115_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_15.prefab_name].transform, "story_v_out_116381", "116381026", "story_v_out_116381.awb")

						arg_112_1:RecordAudio("116381026", var_115_20)
						arg_112_1:RecordAudio("116381026", var_115_20)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_116381", "116381026", "story_v_out_116381.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_116381", "116381026", "story_v_out_116381.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_21 = var_115_12 + 0.3
			local var_115_22 = math.max(var_115_13, arg_112_1.talkMaxDuration)

			if var_115_12 + 0.3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_22 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_21) / var_115_22

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_21 + var_115_22 and arg_112_1.time_ < var_115_21 + var_115_22 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play116381027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116381027
		arg_118_1.duration_ = 2.67

		local var_118_0 = {
			zh = 2.666,
			ja = 1.966
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
				arg_118_0:Play116381028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.2

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_1 = arg_118_1:GetWordFromCfg(116381027)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 9 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 9)

				if (9 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 9)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381027", "story_v_out_116381.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381027", "story_v_out_116381.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_116381", "116381027", "story_v_out_116381.awb")

						arg_118_1:RecordAudio("116381027", var_121_6)
						arg_118_1:RecordAudio("116381027", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_116381", "116381027", "story_v_out_116381.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_116381", "116381027", "story_v_out_116381.awb")
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
	Play116381028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116381028
		arg_122_1.duration_ = 4.57

		local var_122_0 = {
			zh = 4.566,
			ja = 4.233
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
				arg_122_0:Play116381029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.175

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_1 = arg_122_1:GetWordFromCfg(116381028)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381028", "story_v_out_116381.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381028", "story_v_out_116381.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_116381", "116381028", "story_v_out_116381.awb")

						arg_122_1:RecordAudio("116381028", var_125_6)
						arg_122_1:RecordAudio("116381028", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_116381", "116381028", "story_v_out_116381.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_116381", "116381028", "story_v_out_116381.awb")
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
	Play116381029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116381029
		arg_126_1.duration_ = 11.1

		local var_126_0 = {
			zh = 9.733,
			ja = 11.1
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
				arg_126_0:Play116381030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.bgs_.I05f == nil then
				local var_129_0 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05f")
				var_129_0.name = "I05f"
				var_129_0.transform.parent = arg_126_1.stage_.transform
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_.I05f = var_129_0
			end

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= 2 + arg_129_0 then
				local var_129_1 = arg_126_1.bgs_.I05f

				arg_126_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_129_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_2 = var_129_1:GetComponent("SpriteRenderer")

				if var_129_2 and var_129_2.sprite then
					local var_129_3 = 2 * (var_129_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_129_1.transform.localScale = Vector3.New(var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "I05f" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_4 = 0

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_5 = 2

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_5 then
				local var_129_6 = Color.New(0, 0, 0)

				var_129_6.a = Mathf.Lerp(0, 1, (arg_126_1.time_ - var_129_4) / var_129_5)
				arg_126_1.mask_.color = var_129_6
			end

			if arg_126_1.time_ >= var_129_4 + var_129_5 and arg_126_1.time_ < var_129_4 + var_129_5 + arg_129_0 then
				local var_129_7 = Color.New(0, 0, 0)

				var_129_7.a = 1
				arg_126_1.mask_.color = var_129_7
			end

			local var_129_8 = 2

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_9 = 2

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_9 then
				local var_129_10 = Color.New(0, 0, 0)

				var_129_10.a = Mathf.Lerp(1, 0, (arg_126_1.time_ - var_129_8) / var_129_9)
				arg_126_1.mask_.color = var_129_10
			end

			if arg_126_1.time_ >= var_129_8 + var_129_9 and arg_126_1.time_ < var_129_8 + var_129_9 + arg_129_0 then
				local var_129_11 = Color.New(0, 0, 0)

				arg_126_1.mask_.enabled = false
				var_129_11.a = 0
				arg_126_1.mask_.color = var_129_11
			end

			local var_129_12 = "10024ui_story"

			if arg_126_1.actors_["10024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10024ui_story"))) then
				local var_129_13 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_126_1.stage_.transform)

				var_129_13.name = var_129_12
				var_129_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_[var_129_12] = var_129_13

				local var_129_14 = var_129_13:GetComponentInChildren(typeof(CharacterEffect))

				var_129_14.enabled = true

				local var_129_15 = GameObjectTools.GetOrAddComponent(var_129_13, typeof(DynamicBoneHelper))

				if var_129_15 then
					var_129_15:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_14.transform, false)

				arg_126_1.var_[var_129_12 .. "Animator"] = var_129_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_[var_129_12 .. "Animator"].applyRootMotion = true
				arg_126_1.var_[var_129_12 .. "LipSync"] = var_129_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= 4 + arg_129_0 then
				arg_126_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= 4 + arg_129_0 then
				arg_126_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_129_16 = arg_126_1.actors_["10024ui_story"]

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= 4 + arg_129_0 and not isNil(var_129_16) and arg_126_1.var_.characterEffect10024ui_story == nil then
				arg_126_1.var_.characterEffect10024ui_story = var_129_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_17 = 0.2

			if 4 <= arg_126_1.time_ and arg_126_1.time_ < 4 + var_129_17 and not isNil(var_129_16) then
				if arg_126_1.var_.characterEffect10024ui_story and not isNil(var_129_16) then
					arg_126_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 4 + var_129_17 and arg_126_1.time_ < 4 + var_129_17 + arg_129_0 and not isNil(var_129_16) and arg_126_1.var_.characterEffect10024ui_story then
				arg_126_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_129_19 = "10025ui_story"

			if arg_126_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_129_20 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_126_1.stage_.transform)

				var_129_20.name = var_129_19
				var_129_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_[var_129_19] = var_129_20

				local var_129_21 = var_129_20:GetComponentInChildren(typeof(CharacterEffect))

				var_129_21.enabled = true

				local var_129_22 = GameObjectTools.GetOrAddComponent(var_129_20, typeof(DynamicBoneHelper))

				if var_129_22 then
					var_129_22:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_21.transform, false)

				arg_126_1.var_[var_129_19 .. "Animator"] = var_129_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_[var_129_19 .. "Animator"].applyRootMotion = true
				arg_126_1.var_[var_129_19 .. "LipSync"] = var_129_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_129_23 = arg_126_1.actors_["10025ui_story"]

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= 2 + arg_129_0 and not isNil(var_129_23) and arg_126_1.var_.characterEffect10025ui_story == nil then
				arg_126_1.var_.characterEffect10025ui_story = var_129_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_24 = 0.2

			if 2 <= arg_126_1.time_ and arg_126_1.time_ < 2 + var_129_24 and not isNil(var_129_23) then
				if arg_126_1.var_.characterEffect10025ui_story and not isNil(var_129_23) then
					arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 2) / var_129_24)
				end
			end

			if arg_126_1.time_ >= 2 + var_129_24 and arg_126_1.time_ < 2 + var_129_24 + arg_129_0 and not isNil(var_129_23) and arg_126_1.var_.characterEffect10025ui_story then
				arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_129_25 = arg_126_1.actors_["10024ui_story"].transform

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= 4 + arg_129_0 then
				arg_126_1.var_.moveOldPos10024ui_story = var_129_25.localPosition
			end

			local var_129_26 = 0.001

			if 4 <= arg_126_1.time_ and arg_126_1.time_ < 4 + var_129_26 then
				var_129_25.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_126_1.time_ - 4) / var_129_26)
				var_129_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_25.position).x, (manager.ui.mainCamera.transform.position - var_129_25.position).y, (manager.ui.mainCamera.transform.position - var_129_25.position).z)
				var_129_25.localEulerAngles.z = 0
				var_129_25.localEulerAngles.x = 0
				var_129_25.localEulerAngles = var_129_25.localEulerAngles
			end

			if arg_126_1.time_ >= 4 + var_129_26 and arg_126_1.time_ < 4 + var_129_26 + arg_129_0 then
				var_129_25.localPosition = Vector3.New(-0.7, -1, -6)
				var_129_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_25.position).x, (manager.ui.mainCamera.transform.position - var_129_25.position).y, (manager.ui.mainCamera.transform.position - var_129_25.position).z)
				var_129_25.localEulerAngles.z = 0
				var_129_25.localEulerAngles.x = 0
				var_129_25.localEulerAngles = var_129_25.localEulerAngles
			end

			local var_129_27 = arg_126_1.actors_["10025ui_story"].transform

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= 4 + arg_129_0 then
				arg_126_1.var_.moveOldPos10025ui_story = var_129_27.localPosition
			end

			local var_129_28 = 0.001

			if 4 <= arg_126_1.time_ and arg_126_1.time_ < 4 + var_129_28 then
				var_129_27.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_126_1.time_ - 4) / var_129_28)
				var_129_27.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_27.position).x, (manager.ui.mainCamera.transform.position - var_129_27.position).y, (manager.ui.mainCamera.transform.position - var_129_27.position).z)
				var_129_27.localEulerAngles.z = 0
				var_129_27.localEulerAngles.x = 0
				var_129_27.localEulerAngles = var_129_27.localEulerAngles
			end

			if arg_126_1.time_ >= 4 + var_129_28 and arg_126_1.time_ < 4 + var_129_28 + arg_129_0 then
				var_129_27.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_129_27.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_27.position).x, (manager.ui.mainCamera.transform.position - var_129_27.position).y, (manager.ui.mainCamera.transform.position - var_129_27.position).z)
				var_129_27.localEulerAngles.z = 0
				var_129_27.localEulerAngles.x = 0
				var_129_27.localEulerAngles = var_129_27.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_129_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_31 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_31

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_31
						arg_126_1.bgmTxt2_.text = var_129_31
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_126_1.time_ and arg_126_1.time_ <= 0.4 + arg_129_0 then
				arg_126_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_129_34 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_34 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_34

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_34
						arg_126_1.bgmTxt2_.text = var_129_34
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_35 = 4
			local var_129_36 = 0.55

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_35 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_37 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_37:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_126_1.dialogCg_.alpha = arg_132_0
				end))
				var_129_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_38 = arg_126_1:GetWordFromCfg(116381029)
				local var_129_39 = arg_126_1:FormatText(var_129_38.content)

				arg_126_1.text_.text = var_129_39

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_41 = 22 <= 0 and var_129_36 or var_129_36 * (utf8.len(var_129_39) / 22)

				if (22 <= 0 and var_129_36 or var_129_36 * (utf8.len(var_129_39) / 22)) > 0 and var_129_36 < var_129_41 then
					arg_126_1.talkMaxDuration = var_129_41
					var_129_35 = var_129_35 + 0.3

					if var_129_41 + var_129_35 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_41 + var_129_35
					end
				end

				arg_126_1.text_.text = var_129_39
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381029", "story_v_out_116381.awb") ~= 0 then
					local var_129_42 = manager.audio:GetVoiceLength("story_v_out_116381", "116381029", "story_v_out_116381.awb") / 1000

					if var_129_42 + var_129_35 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_42 + var_129_35
					end

					if var_129_38.prefab_name ~= "" and arg_126_1.actors_[var_129_38.prefab_name] ~= nil then
						local var_129_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_38.prefab_name].transform, "story_v_out_116381", "116381029", "story_v_out_116381.awb")

						arg_126_1:RecordAudio("116381029", var_129_43)
						arg_126_1:RecordAudio("116381029", var_129_43)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_116381", "116381029", "story_v_out_116381.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_116381", "116381029", "story_v_out_116381.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_44 = var_129_35 + 0.3
			local var_129_45 = math.max(var_129_36, arg_126_1.talkMaxDuration)

			if var_129_35 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_44 + var_129_45 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_44) / var_129_45

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_44 + var_129_45 and arg_126_1.time_ < var_129_44 + var_129_45 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play116381030 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 116381030
		arg_134_1.duration_ = 4.07

		local var_134_0 = {
			zh = 4.066,
			ja = 3.433
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
				arg_134_0:Play116381031(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_137_0 = arg_134_1.actors_["10024ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos10024ui_story = var_137_0.localPosition
			end

			local var_137_1 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_1 then
				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_134_1.time_ - 0) / var_137_1)
				var_137_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_0.position).x, (manager.ui.mainCamera.transform.position - var_137_0.position).y, (manager.ui.mainCamera.transform.position - var_137_0.position).z)
				var_137_0.localEulerAngles.z = 0
				var_137_0.localEulerAngles.x = 0
				var_137_0.localEulerAngles = var_137_0.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_1 and arg_134_1.time_ < 0 + var_137_1 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(-0.7, -1, -6)
				var_137_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_0.position).x, (manager.ui.mainCamera.transform.position - var_137_0.position).y, (manager.ui.mainCamera.transform.position - var_137_0.position).z)
				var_137_0.localEulerAngles.z = 0
				var_137_0.localEulerAngles.x = 0
				var_137_0.localEulerAngles = var_137_0.localEulerAngles
			end

			local var_137_2 = arg_134_1.actors_["10025ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos10025ui_story = var_137_2.localPosition
			end

			local var_137_3 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 then
				var_137_2.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_134_1.time_ - 0) / var_137_3)
				var_137_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_2.position).x, (manager.ui.mainCamera.transform.position - var_137_2.position).y, (manager.ui.mainCamera.transform.position - var_137_2.position).z)
				var_137_2.localEulerAngles.z = 0
				var_137_2.localEulerAngles.x = 0
				var_137_2.localEulerAngles = var_137_2.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 then
				var_137_2.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_137_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_2.position).x, (manager.ui.mainCamera.transform.position - var_137_2.position).y, (manager.ui.mainCamera.transform.position - var_137_2.position).z)
				var_137_2.localEulerAngles.z = 0
				var_137_2.localEulerAngles.x = 0
				var_137_2.localEulerAngles = var_137_2.localEulerAngles
			end

			local var_137_4 = 0
			local var_137_5 = 0.45

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(116381030)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 18 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 18)

				if (18 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 18)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381030", "story_v_out_116381.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_116381", "116381030", "story_v_out_116381.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_116381", "116381030", "story_v_out_116381.awb")

						arg_134_1:RecordAudio("116381030", var_137_11)
						arg_134_1:RecordAudio("116381030", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_116381", "116381030", "story_v_out_116381.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_116381", "116381030", "story_v_out_116381.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play116381031 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 116381031
		arg_138_1.duration_ = 4.33

		local var_138_0 = {
			zh = 4.333,
			ja = 2.866
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
				arg_138_0:Play116381032(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_141_0 = arg_138_1.actors_["10025ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10025ui_story == nil then
				arg_138_1.var_.characterEffect10025ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_1 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 and not isNil(var_141_0) then
				if arg_138_1.var_.characterEffect10025ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10025ui_story then
				arg_138_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_141_3 = arg_138_1.actors_["10024ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10024ui_story == nil then
				arg_138_1.var_.characterEffect10024ui_story = var_141_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 and not isNil(var_141_3) then
				if arg_138_1.var_.characterEffect10024ui_story and not isNil(var_141_3) then
					arg_138_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_138_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_4)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10024ui_story then
				arg_138_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_138_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_141_5 = 0
			local var_141_6 = 0.25

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(116381031)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 11 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 11)

				if (11 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 11)) > 0 and var_141_6 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381031", "story_v_out_116381.awb") ~= 0 then
					local var_141_11 = manager.audio:GetVoiceLength("story_v_out_116381", "116381031", "story_v_out_116381.awb") / 1000

					if var_141_11 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_5
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_out_116381", "116381031", "story_v_out_116381.awb")

						arg_138_1:RecordAudio("116381031", var_141_12)
						arg_138_1:RecordAudio("116381031", var_141_12)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_116381", "116381031", "story_v_out_116381.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_116381", "116381031", "story_v_out_116381.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_13 and arg_138_1.time_ < var_141_5 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play116381032 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 116381032
		arg_142_1.duration_ = 6.77

		local var_142_0 = {
			zh = 6.766,
			ja = 4.033
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
				arg_142_0:Play116381033(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_145_0 = arg_142_1.actors_["10024ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10024ui_story == nil then
				arg_142_1.var_.characterEffect10024ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_1 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 and not isNil(var_145_0) then
				if arg_142_1.var_.characterEffect10024ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10024ui_story then
				arg_142_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_145_3 = arg_142_1.actors_["10025ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10025ui_story == nil then
				arg_142_1.var_.characterEffect10025ui_story = var_145_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_4 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 and not isNil(var_145_3) then
				if arg_142_1.var_.characterEffect10025ui_story and not isNil(var_145_3) then
					arg_142_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_4)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10025ui_story then
				arg_142_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_145_5 = 0
			local var_145_6 = 0.525

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_7 = arg_142_1:GetWordFromCfg(116381032)
				local var_145_8 = arg_142_1:FormatText(var_145_7.content)

				arg_142_1.text_.text = var_145_8

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_10 = 21 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 21)

				if (21 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 21)) > 0 and var_145_6 < var_145_10 then
					arg_142_1.talkMaxDuration = var_145_10

					if var_145_10 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_8
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381032", "story_v_out_116381.awb") ~= 0 then
					local var_145_11 = manager.audio:GetVoiceLength("story_v_out_116381", "116381032", "story_v_out_116381.awb") / 1000

					if var_145_11 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_5
					end

					if var_145_7.prefab_name ~= "" and arg_142_1.actors_[var_145_7.prefab_name] ~= nil then
						local var_145_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_7.prefab_name].transform, "story_v_out_116381", "116381032", "story_v_out_116381.awb")

						arg_142_1:RecordAudio("116381032", var_145_12)
						arg_142_1:RecordAudio("116381032", var_145_12)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_116381", "116381032", "story_v_out_116381.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_116381", "116381032", "story_v_out_116381.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_13 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_13 and arg_142_1.time_ < var_145_5 + var_145_13 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play116381033 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116381033
		arg_146_1.duration_ = 2.27

		local var_146_0 = {
			zh = 2.266,
			ja = 1.999999999999
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
				arg_146_0:Play116381034(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_149_0 = arg_146_1.actors_["10024ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect10024ui_story == nil then
				arg_146_1.var_.characterEffect10024ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_1 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_1 and not isNil(var_149_0) then
				if arg_146_1.var_.characterEffect10024ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_1)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_1 and arg_146_1.time_ < 0 + var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect10024ui_story then
				arg_146_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_149_2 = arg_146_1.actors_["10025ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect10025ui_story == nil then
				arg_146_1.var_.characterEffect10025ui_story = var_149_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_3 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.characterEffect10025ui_story and not isNil(var_149_2) then
					arg_146_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect10025ui_story then
				arg_146_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_149_5 = 0
			local var_149_6 = 0.125

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_7 = arg_146_1:GetWordFromCfg(116381033)
				local var_149_8 = arg_146_1:FormatText(var_149_7.content)

				arg_146_1.text_.text = var_149_8

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 5 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_8) / 5)

				if (5 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_8) / 5)) > 0 and var_149_6 < var_149_10 then
					arg_146_1.talkMaxDuration = var_149_10

					if var_149_10 + var_149_5 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_5
					end
				end

				arg_146_1.text_.text = var_149_8
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381033", "story_v_out_116381.awb") ~= 0 then
					local var_149_11 = manager.audio:GetVoiceLength("story_v_out_116381", "116381033", "story_v_out_116381.awb") / 1000

					if var_149_11 + var_149_5 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_5
					end

					if var_149_7.prefab_name ~= "" and arg_146_1.actors_[var_149_7.prefab_name] ~= nil then
						local var_149_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_7.prefab_name].transform, "story_v_out_116381", "116381033", "story_v_out_116381.awb")

						arg_146_1:RecordAudio("116381033", var_149_12)
						arg_146_1:RecordAudio("116381033", var_149_12)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_116381", "116381033", "story_v_out_116381.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_116381", "116381033", "story_v_out_116381.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_13 = math.max(var_149_6, arg_146_1.talkMaxDuration)

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_13 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_5) / var_149_13

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_5 + var_149_13 and arg_146_1.time_ < var_149_5 + var_149_13 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play116381034 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 116381034
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play116381035(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10024ui_story = arg_150_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10024ui_story"].transform.position).z)
				arg_150_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10024ui_story"].transform.localEulerAngles = arg_150_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10024ui_story"].transform.position).z)
				arg_150_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10024ui_story"].transform.localEulerAngles = arg_150_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["10025ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10025ui_story = var_153_1.localPosition
			end

			local var_153_2 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 then
				var_153_1.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_2)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 then
				var_153_1.localPosition = Vector3.New(0, 100, 0)
				var_153_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_1.position).x, (manager.ui.mainCamera.transform.position - var_153_1.position).y, (manager.ui.mainCamera.transform.position - var_153_1.position).z)
				var_153_1.localEulerAngles.z = 0
				var_153_1.localEulerAngles.x = 0
				var_153_1.localEulerAngles = var_153_1.localEulerAngles
			end

			local var_153_3 = 0
			local var_153_4 = 1.3

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_3 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_5 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(116381034).content)

				arg_150_1.text_.text = var_153_5

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_7 = 52 <= 0 and var_153_4 or var_153_4 * (utf8.len(var_153_5) / 52)

				if (52 <= 0 and var_153_4 or var_153_4 * (utf8.len(var_153_5) / 52)) > 0 and var_153_4 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_3 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_3
					end
				end

				arg_150_1.text_.text = var_153_5
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_8 = math.max(var_153_4, arg_150_1.talkMaxDuration)

			if var_153_3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_3 + var_153_8 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_3) / var_153_8

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_3 + var_153_8 and arg_150_1.time_ < var_153_3 + var_153_8 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play116381035 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 116381035
		arg_154_1.duration_ = 10.6

		local var_154_0 = {
			zh = 10.6,
			ja = 9.933
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
				arg_154_0:Play116381036(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.15

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:GetWordFromCfg(116381035)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 46 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 46)

				if (46 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 46)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381035", "story_v_out_116381.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381035", "story_v_out_116381.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_116381", "116381035", "story_v_out_116381.awb")

						arg_154_1:RecordAudio("116381035", var_157_6)
						arg_154_1:RecordAudio("116381035", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_116381", "116381035", "story_v_out_116381.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_116381", "116381035", "story_v_out_116381.awb")
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
	Play116381036 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 116381036
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play116381037(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			if 0.333333333333333 < arg_158_1.time_ and arg_158_1.time_ <= 0.333333333333333 + arg_161_0 then
				arg_158_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_161_2 = manager.ui.mainCamera.transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.shakeOldPos = var_161_2.localPosition
			end

			local var_161_3 = 0.6

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 then
				local var_161_4, var_161_5 = math.modf((arg_158_1.time_ - 0) / 0.066)

				var_161_2.localPosition = Vector3.New(var_161_5 * 0.13, var_161_5 * 0.13, var_161_5 * 0.13) + arg_158_1.var_.shakeOldPos
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 then
				var_161_2.localPosition = arg_158_1.var_.shakeOldPos
			end

			local var_161_6 = manager.ui.mainCamera.transform

			if 0.7 < arg_158_1.time_ and arg_158_1.time_ <= 0.7 + arg_161_0 then
				arg_158_1.var_.shakeOldPos = var_161_6.localPosition
			end

			local var_161_7 = 0.6

			if 0.7 <= arg_158_1.time_ and arg_158_1.time_ < 0.7 + var_161_7 then
				local var_161_8, var_161_9 = math.modf((arg_158_1.time_ - 0.7) / 0.066)

				var_161_6.localPosition = Vector3.New(var_161_9 * 0.13, var_161_9 * 0.13, var_161_9 * 0.13) + arg_158_1.var_.shakeOldPos
			end

			if arg_158_1.time_ >= 0.7 + var_161_7 and arg_158_1.time_ < 0.7 + var_161_7 + arg_161_0 then
				var_161_6.localPosition = arg_158_1.var_.shakeOldPos
			end

			local var_161_10 = 0

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 then
				arg_158_1.allBtn_.enabled = false
			end

			if arg_158_1.time_ >= var_161_10 + 1.3 and arg_158_1.time_ < var_161_10 + 1.3 + arg_161_0 then
				arg_158_1.allBtn_.enabled = true
			end

			local var_161_11 = 0
			local var_161_12 = 0.1

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_11 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_13 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(116381036).content)

				arg_158_1.text_.text = var_161_13

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_15 = 4 <= 0 and var_161_12 or var_161_12 * (utf8.len(var_161_13) / 4)

				if (4 <= 0 and var_161_12 or var_161_12 * (utf8.len(var_161_13) / 4)) > 0 and var_161_12 < var_161_15 then
					arg_158_1.talkMaxDuration = var_161_15

					if var_161_15 + var_161_11 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_15 + var_161_11
					end
				end

				arg_158_1.text_.text = var_161_13
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_12, arg_158_1.talkMaxDuration)

			if var_161_11 <= arg_158_1.time_ and arg_158_1.time_ < var_161_11 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_11) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_11 + var_161_16 and arg_158_1.time_ < var_161_11 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play116381037 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 116381037
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play116381038(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1

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

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(116381037).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 40 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 40)

				if (40 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 40)) > 0 and var_165_0 < var_165_3 then
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
	Play116381038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 116381038
		arg_166_1.duration_ = 8.33

		local var_166_0 = {
			zh = 8.2,
			ja = 8.333
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
				arg_166_0:Play116381039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10024ui_story = arg_166_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10024ui_story"].transform.position).z)
				arg_166_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10024ui_story"].transform.localEulerAngles = arg_166_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_166_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10024ui_story"].transform.position).z)
				arg_166_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10024ui_story"].transform.localEulerAngles = arg_166_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_169_1 = arg_166_1.actors_["10024ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect10024ui_story == nil then
				arg_166_1.var_.characterEffect10024ui_story = var_169_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 and not isNil(var_169_1) then
				if arg_166_1.var_.characterEffect10024ui_story and not isNil(var_169_1) then
					arg_166_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect10024ui_story then
				arg_166_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_169_4 = 0
			local var_169_5 = 0.7

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(116381038)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 28 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 28)

				if (28 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 28)) > 0 and var_169_5 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381038", "story_v_out_116381.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_out_116381", "116381038", "story_v_out_116381.awb") / 1000

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end

					if var_169_6.prefab_name ~= "" and arg_166_1.actors_[var_169_6.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_6.prefab_name].transform, "story_v_out_116381", "116381038", "story_v_out_116381.awb")

						arg_166_1:RecordAudio("116381038", var_169_11)
						arg_166_1:RecordAudio("116381038", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_116381", "116381038", "story_v_out_116381.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_116381", "116381038", "story_v_out_116381.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_12 and arg_166_1.time_ < var_169_4 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play116381039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 116381039
		arg_170_1.duration_ = 5.07

		local var_170_0 = {
			zh = 4.866,
			ja = 5.066
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
				arg_170_0:Play116381040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024actionlink/10024action462")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_173_0 = 0
			local var_173_1 = 0.375

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(116381039)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 15 <= 0 and var_173_1 or var_173_1 * (utf8.len(var_173_3) / 15)

				if (15 <= 0 and var_173_1 or var_173_1 * (utf8.len(var_173_3) / 15)) > 0 and var_173_1 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381039", "story_v_out_116381.awb") ~= 0 then
					local var_173_6 = manager.audio:GetVoiceLength("story_v_out_116381", "116381039", "story_v_out_116381.awb") / 1000

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end

					if var_173_2.prefab_name ~= "" and arg_170_1.actors_[var_173_2.prefab_name] ~= nil then
						local var_173_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_2.prefab_name].transform, "story_v_out_116381", "116381039", "story_v_out_116381.awb")

						arg_170_1:RecordAudio("116381039", var_173_7)
						arg_170_1:RecordAudio("116381039", var_173_7)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_116381", "116381039", "story_v_out_116381.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_116381", "116381039", "story_v_out_116381.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_8 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_8 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_8

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_8 and arg_170_1.time_ < var_173_0 + var_173_8 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play116381040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 116381040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play116381041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10024ui_story = arg_174_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10024ui_story"].transform.position).z)
				arg_174_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10024ui_story"].transform.localEulerAngles = arg_174_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["10024ui_story"].transform.position).z)
				arg_174_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["10024ui_story"].transform.localEulerAngles = arg_174_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_177_1 = 0
			local var_177_2 = 0.675

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_3 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(116381040).content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 27 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 27)

				if (27 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 27)) > 0 and var_177_2 < var_177_5 then
					arg_174_1.talkMaxDuration = var_177_5

					if var_177_5 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_6 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_6 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_6

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_6 and arg_174_1.time_ < var_177_1 + var_177_6 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play116381041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 116381041
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play116381042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.825

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(116381041).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 32 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 32)

				if (32 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 32)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play116381042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 116381042
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play116381043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.3

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(116381042).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 12 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 12)

				if (12 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 12)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play116381043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 116381043
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play116381044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.675

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

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(116381043).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 27 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 27)

				if (27 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 27)) > 0 and var_189_0 < var_189_3 then
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
	Play116381044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 116381044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play116381045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.8

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(116381044).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 32 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 32)

				if (32 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 32)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play116381045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 116381045
		arg_194_1.duration_ = 12.3

		local var_194_0 = {
			zh = 7.966,
			ja = 12.3
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
				arg_194_0:Play116381046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.775

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(116381045)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 30 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 30)

				if (30 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 30)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381045", "story_v_out_116381.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381045", "story_v_out_116381.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_116381", "116381045", "story_v_out_116381.awb")

						arg_194_1:RecordAudio("116381045", var_197_6)
						arg_194_1:RecordAudio("116381045", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_116381", "116381045", "story_v_out_116381.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_116381", "116381045", "story_v_out_116381.awb")
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
	Play116381046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 116381046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play116381047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.675

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(116381046).content)

				arg_198_1.text_.text = var_201_1

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_3 = 27 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 27)

				if (27 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 27)) > 0 and var_201_0 < var_201_3 then
					arg_198_1.talkMaxDuration = var_201_3

					if var_201_3 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_3 + 0
					end
				end

				arg_198_1.text_.text = var_201_1
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_4 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_4

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play116381047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 116381047
		arg_202_1.duration_ = 7.1

		local var_202_0 = {
			zh = 4.166,
			ja = 7.1
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
				arg_202_0:Play116381048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_205_0 = 0.6

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				local var_205_1, var_205_2 = math.modf((arg_202_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_205_2 * 0.13, var_205_2 * 0.13, var_205_2 * 0.13) + arg_202_1.var_.shakeOldPos
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				manager.ui.mainCamera.transform.localPosition = arg_202_1.var_.shakeOldPos
			end

			local var_205_3 = 0

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			if arg_202_1.time_ >= var_205_3 + 0.6 and arg_202_1.time_ < var_205_3 + 0.6 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			local var_205_4 = 0
			local var_205_5 = 0.475

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_6 = arg_202_1:GetWordFromCfg(116381047)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 19 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 19)

				if (19 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 19)) > 0 and var_205_5 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381047", "story_v_out_116381.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_116381", "116381047", "story_v_out_116381.awb") / 1000

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_116381", "116381047", "story_v_out_116381.awb")

						arg_202_1:RecordAudio("116381047", var_205_11)
						arg_202_1:RecordAudio("116381047", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_116381", "116381047", "story_v_out_116381.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_116381", "116381047", "story_v_out_116381.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_12 and arg_202_1.time_ < var_205_4 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play116381048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 116381048
		arg_206_1.duration_ = 3.23

		local var_206_0 = {
			zh = 3.2,
			ja = 3.233
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
				arg_206_0:Play116381049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos10024ui_story = arg_206_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10024ui_story"].transform.position).z)
				arg_206_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10024ui_story"].transform.localEulerAngles = arg_206_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_206_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10024ui_story"].transform.position).z)
				arg_206_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10024ui_story"].transform.localEulerAngles = arg_206_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_209_1 = arg_206_1.actors_["10024ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect10024ui_story == nil then
				arg_206_1.var_.characterEffect10024ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect10024ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect10024ui_story then
				arg_206_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_209_4 = 0
			local var_209_5 = 0.25

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:GetWordFromCfg(116381048)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 10 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 10)

				if (10 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 10)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381048", "story_v_out_116381.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_out_116381", "116381048", "story_v_out_116381.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_out_116381", "116381048", "story_v_out_116381.awb")

						arg_206_1:RecordAudio("116381048", var_209_11)
						arg_206_1:RecordAudio("116381048", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_116381", "116381048", "story_v_out_116381.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_116381", "116381048", "story_v_out_116381.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_12 and arg_206_1.time_ < var_209_4 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play116381049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 116381049
		arg_210_1.duration_ = 2.8

		local var_210_0 = {
			zh = 2.2,
			ja = 2.8
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
				arg_210_0:Play116381050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10024ui_story = arg_210_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10024ui_story"].transform.position).z)
				arg_210_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10024ui_story"].transform.localEulerAngles = arg_210_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_210_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10024ui_story"].transform.position).z)
				arg_210_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10024ui_story"].transform.localEulerAngles = arg_210_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_2")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_213_1 = 0
			local var_213_2 = 0.15

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_3 = arg_210_1:GetWordFromCfg(116381049)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_6 = 6 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_4) / 6)

				if (6 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_4) / 6)) > 0 and var_213_2 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381049", "story_v_out_116381.awb") ~= 0 then
					local var_213_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381049", "story_v_out_116381.awb") / 1000

					if var_213_7 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_1
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_116381", "116381049", "story_v_out_116381.awb")

						arg_210_1:RecordAudio("116381049", var_213_8)
						arg_210_1:RecordAudio("116381049", var_213_8)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_116381", "116381049", "story_v_out_116381.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_116381", "116381049", "story_v_out_116381.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_9 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_9 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_9

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_9 and arg_210_1.time_ < var_213_1 + var_213_9 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play116381050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 116381050
		arg_214_1.duration_ = 9.1

		local var_214_0 = {
			zh = 9.1,
			ja = 7.233
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
				arg_214_0:Play116381051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10024ui_story = arg_214_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10024ui_story"].transform.position).z)
				arg_214_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["10024ui_story"].transform.localEulerAngles = arg_214_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_214_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10024ui_story"].transform.position).z)
				arg_214_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["10024ui_story"].transform.localEulerAngles = arg_214_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_217_1 = 0
			local var_217_2 = 1.025

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(116381050)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 41 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 41)

				if (41 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_4) / 41)) > 0 and var_217_2 < var_217_6 then
					arg_214_1.talkMaxDuration = var_217_6

					if var_217_6 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381050", "story_v_out_116381.awb") ~= 0 then
					local var_217_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381050", "story_v_out_116381.awb") / 1000

					if var_217_7 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_1
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_116381", "116381050", "story_v_out_116381.awb")

						arg_214_1:RecordAudio("116381050", var_217_8)
						arg_214_1:RecordAudio("116381050", var_217_8)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_116381", "116381050", "story_v_out_116381.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_116381", "116381050", "story_v_out_116381.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_9 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_9 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_9

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_9 and arg_214_1.time_ < var_217_1 + var_217_9 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play116381051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 116381051
		arg_218_1.duration_ = 6.33

		local var_218_0 = {
			zh = 5.1,
			ja = 6.333
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
				arg_218_0:Play116381052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10024ui_story = arg_218_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10024ui_story"].transform.position).z)
				arg_218_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["10024ui_story"].transform.localEulerAngles = arg_218_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10024ui_story"].transform.position).z)
				arg_218_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["10024ui_story"].transform.localEulerAngles = arg_218_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_221_1 = 0
			local var_221_2 = 0.35

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_3 = arg_218_1:GetWordFromCfg(116381051)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_6 = 14 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_4) / 14)

				if (14 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_4) / 14)) > 0 and var_221_2 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381051", "story_v_out_116381.awb") ~= 0 then
					local var_221_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381051", "story_v_out_116381.awb") / 1000

					if var_221_7 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_1
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_116381", "116381051", "story_v_out_116381.awb")

						arg_218_1:RecordAudio("116381051", var_221_8)
						arg_218_1:RecordAudio("116381051", var_221_8)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_116381", "116381051", "story_v_out_116381.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_116381", "116381051", "story_v_out_116381.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_9 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_9 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_9

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_9 and arg_218_1.time_ < var_221_1 + var_221_9 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play116381052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 116381052
		arg_222_1.duration_ = 9.83

		local var_222_0 = {
			zh = 9.833,
			ja = 5
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
				arg_222_0:Play116381053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.725

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(116381052)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381052", "story_v_out_116381.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381052", "story_v_out_116381.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_116381", "116381052", "story_v_out_116381.awb")

						arg_222_1:RecordAudio("116381052", var_225_6)
						arg_222_1:RecordAudio("116381052", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_116381", "116381052", "story_v_out_116381.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_116381", "116381052", "story_v_out_116381.awb")
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
	Play116381053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 116381053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play116381054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.025

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

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(116381053).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 41 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 41)

				if (41 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 41)) > 0 and var_229_0 < var_229_3 then
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
	Play116381054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 116381054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play116381055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.275

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(116381054).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 11 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 11)

				if (11 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 11)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play116381055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 116381055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play116381056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.1

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(116381055).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 4 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 4)

				if (4 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 4)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play116381056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 116381056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play116381057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.175

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(116381056).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 7 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 7)

				if (7 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 7)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play116381057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 116381057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play116381058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 1.05

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(116381057).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 42 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 42)

				if (42 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 42)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play116381058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 116381058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play116381059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.05

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

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(116381058).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 42 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 42)

				if (42 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 42)) > 0 and var_249_0 < var_249_3 then
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
	Play116381059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 116381059
		arg_250_1.duration_ = 8.87

		local var_250_0 = {
			zh = 8.3,
			ja = 8.866
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
				arg_250_0:Play116381060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.625

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:GetWordFromCfg(116381059)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 20 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 20)

				if (20 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 20)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381059", "story_v_out_116381.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381059", "story_v_out_116381.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_116381", "116381059", "story_v_out_116381.awb")

						arg_250_1:RecordAudio("116381059", var_253_6)
						arg_250_1:RecordAudio("116381059", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_116381", "116381059", "story_v_out_116381.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_116381", "116381059", "story_v_out_116381.awb")
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
	Play116381060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 116381060
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play116381061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.2

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(116381060).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 8 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 8)

				if (8 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 8)) > 0 and var_257_0 < var_257_3 then
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
	Play116381061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 116381061
		arg_258_1.duration_ = 7.33

		local var_258_0 = {
			zh = 3.866,
			ja = 7.333
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
				arg_258_0:Play116381062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.325

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:GetWordFromCfg(116381061)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 13 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 13)

				if (13 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 13)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381061", "story_v_out_116381.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_116381", "116381061", "story_v_out_116381.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_116381", "116381061", "story_v_out_116381.awb")

						arg_258_1:RecordAudio("116381061", var_261_6)
						arg_258_1:RecordAudio("116381061", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_116381", "116381061", "story_v_out_116381.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_116381", "116381061", "story_v_out_116381.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play116381062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 116381062
		arg_262_1.duration_ = 10.54

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play116381063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 2 < arg_262_1.time_ and arg_262_1.time_ <= 2 + arg_265_0 then
				local var_265_0 = arg_262_1.bgs_.STblack

				arg_262_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_265_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_265_1 = var_265_0:GetComponent("SpriteRenderer")

				if var_265_1 and var_265_1.sprite then
					local var_265_2 = 2 * (var_265_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_265_0.transform.localScale = Vector3.New(var_265_2 / var_265_1.sprite.bounds.size.y < var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x and var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x or var_265_2 / var_265_1.sprite.bounds.size.y, var_265_2 / var_265_1.sprite.bounds.size.y < var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x and var_265_2 * manager.ui.mainCameraCom_.aspect / var_265_1.sprite.bounds.size.x or var_265_2 / var_265_1.sprite.bounds.size.y, 0)
				end

				for iter_265_0, iter_265_1 in pairs(arg_262_1.bgs_) do
					if iter_265_0 ~= "STblack" then
						iter_265_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= 2 + arg_265_0 then
				arg_262_1.fswbg_:SetActive(true)
				arg_262_1.dialog_:SetActive(false)

				arg_262_1.fswtw_.percent = 0
				arg_262_1.fswt_.text = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(116381062).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.fswt_)

				arg_262_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_262_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_262_1.fswtw_:SetDirty()

				arg_262_1.typewritterCharCountI18N = 0

				SetActive(arg_262_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_262_1:ShowNextGo(false)
			end

			local var_265_3 = 2.01666666666667

			if 2.01666666666667 < arg_262_1.time_ and arg_262_1.time_ <= var_265_3 + arg_265_0 then
				arg_262_1.var_.oldValueTypewriter = arg_262_1.fswtw_.percent

				SetActive(arg_262_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_262_1:ShowNextGo(false)
			end

			local var_265_4 = 44
			local var_265_5 = 2.93333333333333
			local var_265_6, var_265_7 = arg_262_1:GetPercentByPara(arg_262_1:FormatText(arg_262_1:GetWordFromCfg(116381062).content), 1)

			if var_265_3 < arg_262_1.time_ and arg_262_1.time_ <= var_265_3 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				local var_265_8 = var_265_4 <= 0 and var_265_5 or var_265_5 * ((var_265_7 - arg_262_1.typewritterCharCountI18N) / var_265_4)

				if (var_265_4 <= 0 and var_265_5 or var_265_5 * ((var_265_7 - arg_262_1.typewritterCharCountI18N) / var_265_4)) > 0 and var_265_5 < var_265_8 then
					arg_262_1.talkMaxDuration = var_265_8

					if var_265_8 + var_265_3 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_3
					end
				end
			end

			local var_265_9 = math.max(2.93333333333333, arg_262_1.talkMaxDuration)

			if var_265_3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_3 + var_265_9 then
				arg_262_1.fswtw_.percent = Mathf.Lerp(arg_262_1.var_.oldValueTypewriter, var_265_6, (arg_262_1.time_ - var_265_3) / var_265_9)
				arg_262_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_262_1.fswtw_:SetDirty()
			end

			if arg_262_1.time_ >= var_265_3 + var_265_9 and arg_262_1.time_ < var_265_3 + var_265_9 + arg_265_0 then
				arg_262_1.fswtw_.percent = var_265_6

				arg_262_1.fswtw_:SetDirty()
				arg_262_1:ShowNextGo(true)

				arg_262_1.typewritterCharCountI18N = var_265_7
			end

			local var_265_10 = 2
			local var_265_11 = manager.audio:GetVoiceLength("story_v_out_116381", "116381062", "story_v_out_116381.awb") / 1000

			if var_265_11 > 0 and 8.543 < var_265_11 and var_265_11 + var_265_10 > arg_262_1.duration_ then
				arg_262_1.duration_ = var_265_11 + var_265_10
			end

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1:AudioAction("play", "voice", "story_v_out_116381", "116381062", "story_v_out_116381.awb")
			end

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= 2 + arg_265_0 then
				arg_262_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_265_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_262_1.bgmTxt_.text ~= var_265_15 and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = var_265_15

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = var_265_15
						arg_262_1.bgmTxt2_.text = var_265_15
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.4 < arg_262_1.time_ and arg_262_1.time_ <= 2.4 + arg_265_0 then
				arg_262_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_262_1.bgmTxt_.text ~= "" and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = ""

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = ""
						arg_262_1.bgmTxt2_.text = ""
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.575 < arg_262_1.time_ and arg_262_1.time_ <= 2.575 + arg_265_0 then
				arg_262_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "corg", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[96].musicName ~= "" then
					if arg_262_1.bgmTxt_.text ~= MusicRecordCfg[96].musicName and arg_262_1.bgmTxt_.text ~= "" then
						if arg_262_1.bgmTxt2_.text ~= "" then
							arg_262_1.bgmTxt_.text = arg_262_1.bgmTxt2_.text
						end

						arg_262_1.bgmTxt2_.text = MusicRecordCfg[96].musicName

						arg_262_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_262_1.bgmTxt_.text = MusicRecordCfg[96].musicName
						arg_262_1.bgmTxt2_.text = MusicRecordCfg[96].musicName
					end

					if arg_262_1.bgmTimer then
						arg_262_1.bgmTimer:Stop()

						arg_262_1.bgmTimer = nil
					end

					if arg_262_1.settingData.show_music_name == 1 then
						arg_262_1.musicController:SetSelectedState("show")
						arg_262_1.musicAnimator_:Play("open", 0, 0)

						if arg_262_1.settingData.music_time ~= 0 then
							arg_262_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_262_1.settingData.music_time), function()
								if arg_262_1 == nil or isNil(arg_262_1.bgmTxt_) then
									return
								end

								arg_262_1.musicController:SetSelectedState("hide")
								arg_262_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_265_19 = 0

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_19 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_20 = 2

			if var_265_19 <= arg_262_1.time_ and arg_262_1.time_ < var_265_19 + var_265_20 then
				local var_265_21 = Color.New(0, 0, 0)

				var_265_21.a = Mathf.Lerp(0, 1, (arg_262_1.time_ - var_265_19) / var_265_20)
				arg_262_1.mask_.color = var_265_21
			end

			if arg_262_1.time_ >= var_265_19 + var_265_20 and arg_262_1.time_ < var_265_19 + var_265_20 + arg_265_0 then
				local var_265_22 = Color.New(0, 0, 0)

				var_265_22.a = 1
				arg_262_1.mask_.color = var_265_22
			end

			local var_265_23 = 2

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= var_265_23 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_24 = 2

			if var_265_23 <= arg_262_1.time_ and arg_262_1.time_ < var_265_23 + var_265_24 then
				local var_265_25 = Color.New(0, 0, 0)

				var_265_25.a = Mathf.Lerp(1, 0, (arg_262_1.time_ - var_265_23) / var_265_24)
				arg_262_1.mask_.color = var_265_25
			end

			if arg_262_1.time_ >= var_265_23 + var_265_24 and arg_262_1.time_ < var_265_23 + var_265_24 + arg_265_0 then
				local var_265_26 = Color.New(0, 0, 0)

				arg_262_1.mask_.enabled = false
				var_265_26.a = 0
				arg_262_1.mask_.color = var_265_26
			end

			local var_265_27 = 2

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= var_265_27 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			if arg_262_1.time_ >= var_265_27 + 2.95 and arg_262_1.time_ < var_265_27 + 2.95 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			local var_265_28 = 1.96666666666667

			arg_262_1.isInRecall_ = false

			if var_265_28 < arg_262_1.time_ and arg_262_1.time_ <= var_265_28 + arg_265_0 then
				arg_262_1.screenFilterGo_:SetActive(false)

				for iter_265_2, iter_265_3 in pairs(arg_262_1.actors_) do
					for iter_265_4, iter_265_5 in ipairs((iter_265_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_265_5.color = iter_265_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_265_29 = 0.0333333333333332

			if var_265_28 <= arg_262_1.time_ and arg_262_1.time_ < var_265_28 + var_265_29 then
				arg_262_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_262_1.time_ - var_265_28) / var_265_29)
			end

			if arg_262_1.time_ >= var_265_28 + var_265_29 and arg_262_1.time_ < var_265_28 + var_265_29 + arg_265_0 then
				arg_262_1.screenFilterEffect_.weight = 0
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play116381063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 116381063
		arg_269_1.duration_ = 8.08

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play116381064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_0 = 26
			local var_272_1 = 1.73333333333333
			local var_272_2, var_272_3 = arg_269_1:GetPercentByPara(arg_269_1:FormatText(arg_269_1:GetWordFromCfg(116381062).content), 2)

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_4 = var_272_0 <= 0 and var_272_1 or var_272_1 * ((var_272_3 - arg_269_1.typewritterCharCountI18N) / var_272_0)

				if (var_272_0 <= 0 and var_272_1 or var_272_1 * ((var_272_3 - arg_269_1.typewritterCharCountI18N) / var_272_0)) > 0 and var_272_1 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end
			end

			local var_272_5 = math.max(1.73333333333333, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_5 then
				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_2, (arg_269_1.time_ - 0) / var_272_5)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_5 and arg_269_1.time_ < 0 + var_272_5 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_2

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_3
			end

			local var_272_6 = 0
			local var_272_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381063", "story_v_out_116381.awb") / 1000

			if var_272_7 > 0 and 8.082 < var_272_7 and var_272_7 + var_272_6 > arg_269_1.duration_ then
				arg_269_1.duration_ = var_272_7 + var_272_6
			end

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1:AudioAction("play", "voice", "story_v_out_116381", "116381063", "story_v_out_116381.awb")
			end

			local var_272_9 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_9 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_9 + 1.73333333333333 and arg_269_1.time_ < var_272_9 + 1.73333333333333 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play116381064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 116381064
		arg_273_1.duration_ = 7.44

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play116381065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.oldValueTypewriter = arg_273_1.fswtw_.percent

				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_0 = 34
			local var_276_1 = 2.26666666666667
			local var_276_2, var_276_3 = arg_273_1:GetPercentByPara(arg_273_1:FormatText(arg_273_1:GetWordFromCfg(116381062).content), 3)

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				local var_276_4 = var_276_0 <= 0 and var_276_1 or var_276_1 * ((var_276_3 - arg_273_1.typewritterCharCountI18N) / var_276_0)

				if (var_276_0 <= 0 and var_276_1 or var_276_1 * ((var_276_3 - arg_273_1.typewritterCharCountI18N) / var_276_0)) > 0 and var_276_1 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end
			end

			local var_276_5 = math.max(2.26666666666667, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 then
				arg_273_1.fswtw_.percent = Mathf.Lerp(arg_273_1.var_.oldValueTypewriter, var_276_2, (arg_273_1.time_ - 0) / var_276_5)
				arg_273_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_273_1.fswtw_:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 then
				arg_273_1.fswtw_.percent = var_276_2

				arg_273_1.fswtw_:SetDirty()
				arg_273_1:ShowNextGo(true)

				arg_273_1.typewritterCharCountI18N = var_276_3
			end

			local var_276_6 = 0
			local var_276_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381064", "story_v_out_116381.awb") / 1000

			if var_276_7 > 0 and 7.438 < var_276_7 and var_276_7 + var_276_6 > arg_273_1.duration_ then
				arg_273_1.duration_ = var_276_7 + var_276_6
			end

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1:AudioAction("play", "voice", "story_v_out_116381", "116381064", "story_v_out_116381.awb")
			end

			local var_276_9 = 0

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1.allBtn_.enabled = false
			end

			if arg_273_1.time_ >= var_276_9 + 2.26666666666667 and arg_273_1.time_ < var_276_9 + 2.26666666666667 + arg_276_0 then
				arg_273_1.allBtn_.enabled = true
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play116381065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 116381065
		arg_277_1.duration_ = 5.85

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play116381066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.oldValueTypewriter = arg_277_1.fswtw_.percent

				SetActive(arg_277_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_277_1:ShowNextGo(false)
			end

			local var_280_0 = 26
			local var_280_1 = 1.73333333333333
			local var_280_2, var_280_3 = arg_277_1:GetPercentByPara(arg_277_1:FormatText(arg_277_1:GetWordFromCfg(116381062).content), 4)

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				local var_280_4 = var_280_0 <= 0 and var_280_1 or var_280_1 * ((var_280_3 - arg_277_1.typewritterCharCountI18N) / var_280_0)

				if (var_280_0 <= 0 and var_280_1 or var_280_1 * ((var_280_3 - arg_277_1.typewritterCharCountI18N) / var_280_0)) > 0 and var_280_1 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end
			end

			local var_280_5 = math.max(1.73333333333333, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 then
				arg_277_1.fswtw_.percent = Mathf.Lerp(arg_277_1.var_.oldValueTypewriter, var_280_2, (arg_277_1.time_ - 0) / var_280_5)
				arg_277_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_277_1.fswtw_:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 then
				arg_277_1.fswtw_.percent = var_280_2

				arg_277_1.fswtw_:SetDirty()
				arg_277_1:ShowNextGo(true)

				arg_277_1.typewritterCharCountI18N = var_280_3
			end

			local var_280_6 = 0
			local var_280_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381065", "story_v_out_116381.awb") / 1000

			if var_280_7 > 0 and 5.847 < var_280_7 and var_280_7 + var_280_6 > arg_277_1.duration_ then
				arg_277_1.duration_ = var_280_7 + var_280_6
			end

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1:AudioAction("play", "voice", "story_v_out_116381", "116381065", "story_v_out_116381.awb")
			end

			local var_280_9 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_9 + 1.73333333333333 and arg_277_1.time_ < var_280_9 + 1.73333333333333 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play116381066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 116381066
		arg_281_1.duration_ = 1.44

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play116381067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.oldValueTypewriter = arg_281_1.fswtw_.percent

				SetActive(arg_281_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_281_1:ShowNextGo(false)
			end

			local var_284_0 = 12
			local var_284_1 = 0.8
			local var_284_2, var_284_3 = arg_281_1:GetPercentByPara(arg_281_1:FormatText(arg_281_1:GetWordFromCfg(116381062).content), 5)

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				local var_284_4 = var_284_0 <= 0 and var_284_1 or var_284_1 * ((var_284_3 - arg_281_1.typewritterCharCountI18N) / var_284_0)

				if (var_284_0 <= 0 and var_284_1 or var_284_1 * ((var_284_3 - arg_281_1.typewritterCharCountI18N) / var_284_0)) > 0 and var_284_1 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end
			end

			local var_284_5 = math.max(0.8, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_5 then
				arg_281_1.fswtw_.percent = Mathf.Lerp(arg_281_1.var_.oldValueTypewriter, var_284_2, (arg_281_1.time_ - 0) / var_284_5)
				arg_281_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_281_1.fswtw_:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_5 and arg_281_1.time_ < 0 + var_284_5 + arg_284_0 then
				arg_281_1.fswtw_.percent = var_284_2

				arg_281_1.fswtw_:SetDirty()
				arg_281_1:ShowNextGo(true)

				arg_281_1.typewritterCharCountI18N = var_284_3
			end

			local var_284_6 = 0
			local var_284_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381066", "story_v_out_116381.awb") / 1000

			if var_284_7 > 0 and 1.438 < var_284_7 and var_284_7 + var_284_6 > arg_281_1.duration_ then
				arg_281_1.duration_ = var_284_7 + var_284_6
			end

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1:AudioAction("play", "voice", "story_v_out_116381", "116381066", "story_v_out_116381.awb")
			end

			local var_284_9 = 0

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			if arg_281_1.time_ >= var_284_9 + 0.8 and arg_281_1.time_ < var_284_9 + 0.8 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play116381067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 116381067
		arg_285_1.duration_ = 7.73

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play116381068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.oldValueTypewriter = arg_285_1.fswtw_.percent

				SetActive(arg_285_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_285_1:ShowNextGo(false)
			end

			local var_288_0 = 36
			local var_288_1 = 2.4
			local var_288_2, var_288_3 = arg_285_1:GetPercentByPara(arg_285_1:FormatText(arg_285_1:GetWordFromCfg(116381062).content), 6)

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				local var_288_4 = var_288_0 <= 0 and var_288_1 or var_288_1 * ((var_288_3 - arg_285_1.typewritterCharCountI18N) / var_288_0)

				if (var_288_0 <= 0 and var_288_1 or var_288_1 * ((var_288_3 - arg_285_1.typewritterCharCountI18N) / var_288_0)) > 0 and var_288_1 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end
			end

			local var_288_5 = math.max(2.4, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_5 then
				arg_285_1.fswtw_.percent = Mathf.Lerp(arg_285_1.var_.oldValueTypewriter, var_288_2, (arg_285_1.time_ - 0) / var_288_5)
				arg_285_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_285_1.fswtw_:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_5 and arg_285_1.time_ < 0 + var_288_5 + arg_288_0 then
				arg_285_1.fswtw_.percent = var_288_2

				arg_285_1.fswtw_:SetDirty()
				arg_285_1:ShowNextGo(true)

				arg_285_1.typewritterCharCountI18N = var_288_3
			end

			local var_288_6 = 0
			local var_288_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381067", "story_v_out_116381.awb") / 1000

			if var_288_7 > 0 and 7.735 < var_288_7 and var_288_7 + var_288_6 > arg_285_1.duration_ then
				arg_285_1.duration_ = var_288_7 + var_288_6
			end

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1:AudioAction("play", "voice", "story_v_out_116381", "116381067", "story_v_out_116381.awb")
			end

			local var_288_9 = 0

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 then
				arg_285_1.allBtn_.enabled = false
			end

			if arg_285_1.time_ >= var_288_9 + 2.4 and arg_285_1.time_ < var_288_9 + 2.4 + arg_288_0 then
				arg_285_1.allBtn_.enabled = true
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play116381068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 116381068
		arg_289_1.duration_ = 5.26

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play116381069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.fswbg_:SetActive(true)
				arg_289_1.dialog_:SetActive(false)

				arg_289_1.fswtw_.percent = 0
				arg_289_1.fswt_.text = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(116381068).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.fswt_)

				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_289_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_289_1.fswtw_:SetDirty()

				arg_289_1.typewritterCharCountI18N = 0

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.var_.oldValueTypewriter = arg_289_1.fswtw_.percent

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_1 = 16
			local var_292_2 = 1.06666666666667
			local var_292_3, var_292_4 = arg_289_1:GetPercentByPara(arg_289_1:FormatText(arg_289_1:GetWordFromCfg(116381068).content), 1)

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				local var_292_5 = var_292_1 <= 0 and var_292_2 or var_292_2 * ((var_292_4 - arg_289_1.typewritterCharCountI18N) / var_292_1)

				if (var_292_1 <= 0 and var_292_2 or var_292_2 * ((var_292_4 - arg_289_1.typewritterCharCountI18N) / var_292_1)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_0
					end
				end
			end

			local var_292_6 = math.max(1.06666666666667, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_6 then
				arg_289_1.fswtw_.percent = Mathf.Lerp(arg_289_1.var_.oldValueTypewriter, var_292_3, (arg_289_1.time_ - var_292_0) / var_292_6)
				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_289_1.fswtw_:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_6 and arg_289_1.time_ < var_292_0 + var_292_6 + arg_292_0 then
				arg_289_1.fswtw_.percent = var_292_3

				arg_289_1.fswtw_:SetDirty()
				arg_289_1:ShowNextGo(true)

				arg_289_1.typewritterCharCountI18N = var_292_4
			end

			local var_292_7 = 0
			local var_292_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381068", "story_v_out_116381.awb") / 1000

			if var_292_8 > 0 and 5.257 < var_292_8 and var_292_8 + var_292_7 > arg_289_1.duration_ then
				arg_289_1.duration_ = var_292_8 + var_292_7
			end

			if var_292_7 < arg_289_1.time_ and arg_289_1.time_ <= var_292_7 + arg_292_0 then
				arg_289_1:AudioAction("play", "voice", "story_v_out_116381", "116381068", "story_v_out_116381.awb")
			end

			local var_292_10 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			if arg_289_1.time_ >= var_292_10 + 1.08333333333333 and arg_289_1.time_ < var_292_10 + 1.08333333333333 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play116381069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 116381069
		arg_293_1.duration_ = 0.75

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play116381070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.oldValueTypewriter = arg_293_1.fswtw_.percent

				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_0 = 7
			local var_296_1 = 0.466666666666667
			local var_296_2, var_296_3 = arg_293_1:GetPercentByPara(arg_293_1:FormatText(arg_293_1:GetWordFromCfg(116381068).content), 2)

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				local var_296_4 = var_296_0 <= 0 and var_296_1 or var_296_1 * ((var_296_3 - arg_293_1.typewritterCharCountI18N) / var_296_0)

				if (var_296_0 <= 0 and var_296_1 or var_296_1 * ((var_296_3 - arg_293_1.typewritterCharCountI18N) / var_296_0)) > 0 and var_296_1 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end
			end

			local var_296_5 = math.max(0.466666666666667, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 then
				arg_293_1.fswtw_.percent = Mathf.Lerp(arg_293_1.var_.oldValueTypewriter, var_296_2, (arg_293_1.time_ - 0) / var_296_5)
				arg_293_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_293_1.fswtw_:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 then
				arg_293_1.fswtw_.percent = var_296_2

				arg_293_1.fswtw_:SetDirty()
				arg_293_1:ShowNextGo(true)

				arg_293_1.typewritterCharCountI18N = var_296_3
			end

			local var_296_6 = 0
			local var_296_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381069", "story_v_out_116381.awb") / 1000

			if var_296_7 > 0 and 0.75 < var_296_7 and var_296_7 + var_296_6 > arg_293_1.duration_ then
				arg_293_1.duration_ = var_296_7 + var_296_6
			end

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1:AudioAction("play", "voice", "story_v_out_116381", "116381069", "story_v_out_116381.awb")
			end

			local var_296_9 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_9 + 0.466666666666667 and arg_293_1.time_ < var_296_9 + 0.466666666666667 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play116381070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 116381070
		arg_297_1.duration_ = 3.3

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play116381071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.oldValueTypewriter = arg_297_1.fswtw_.percent

				SetActive(arg_297_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_297_1:ShowNextGo(false)
			end

			local var_300_0 = 19
			local var_300_1 = 1.26666666666667
			local var_300_2, var_300_3 = arg_297_1:GetPercentByPara(arg_297_1:FormatText(arg_297_1:GetWordFromCfg(116381068).content), 3)

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				local var_300_4 = var_300_0 <= 0 and var_300_1 or var_300_1 * ((var_300_3 - arg_297_1.typewritterCharCountI18N) / var_300_0)

				if (var_300_0 <= 0 and var_300_1 or var_300_1 * ((var_300_3 - arg_297_1.typewritterCharCountI18N) / var_300_0)) > 0 and var_300_1 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end
			end

			local var_300_5 = math.max(1.26666666666667, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 then
				arg_297_1.fswtw_.percent = Mathf.Lerp(arg_297_1.var_.oldValueTypewriter, var_300_2, (arg_297_1.time_ - 0) / var_300_5)
				arg_297_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_297_1.fswtw_:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 then
				arg_297_1.fswtw_.percent = var_300_2

				arg_297_1.fswtw_:SetDirty()
				arg_297_1:ShowNextGo(true)

				arg_297_1.typewritterCharCountI18N = var_300_3
			end

			local var_300_6 = 0
			local var_300_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381070", "story_v_out_116381.awb") / 1000

			if var_300_7 > 0 and 3.304 < var_300_7 and var_300_7 + var_300_6 > arg_297_1.duration_ then
				arg_297_1.duration_ = var_300_7 + var_300_6
			end

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1:AudioAction("play", "voice", "story_v_out_116381", "116381070", "story_v_out_116381.awb")
			end

			local var_300_9 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			if arg_297_1.time_ >= var_300_9 + 1.26666666666667 and arg_297_1.time_ < var_300_9 + 1.26666666666667 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play116381071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 116381071
		arg_301_1.duration_ = 10.21

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play116381072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.oldValueTypewriter = arg_301_1.fswtw_.percent

				SetActive(arg_301_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_301_1:ShowNextGo(false)
			end

			local var_304_0 = 48
			local var_304_1 = 3.2
			local var_304_2, var_304_3 = arg_301_1:GetPercentByPara(arg_301_1:FormatText(arg_301_1:GetWordFromCfg(116381068).content), 4)

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				local var_304_4 = var_304_0 <= 0 and var_304_1 or var_304_1 * ((var_304_3 - arg_301_1.typewritterCharCountI18N) / var_304_0)

				if (var_304_0 <= 0 and var_304_1 or var_304_1 * ((var_304_3 - arg_301_1.typewritterCharCountI18N) / var_304_0)) > 0 and var_304_1 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end
			end

			local var_304_5 = math.max(3.2, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_5 then
				arg_301_1.fswtw_.percent = Mathf.Lerp(arg_301_1.var_.oldValueTypewriter, var_304_2, (arg_301_1.time_ - 0) / var_304_5)
				arg_301_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_301_1.fswtw_:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_5 and arg_301_1.time_ < 0 + var_304_5 + arg_304_0 then
				arg_301_1.fswtw_.percent = var_304_2

				arg_301_1.fswtw_:SetDirty()
				arg_301_1:ShowNextGo(true)

				arg_301_1.typewritterCharCountI18N = var_304_3
			end

			local var_304_6 = 0
			local var_304_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381071", "story_v_out_116381.awb") / 1000

			if var_304_7 > 0 and 10.214 < var_304_7 and var_304_7 + var_304_6 > arg_301_1.duration_ then
				arg_301_1.duration_ = var_304_7 + var_304_6
			end

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1:AudioAction("play", "voice", "story_v_out_116381", "116381071", "story_v_out_116381.awb")
			end

			local var_304_9 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			if arg_301_1.time_ >= var_304_9 + 3.2 and arg_301_1.time_ < var_304_9 + 3.2 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play116381072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 116381072
		arg_305_1.duration_ = 13.12

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play116381073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.oldValueTypewriter = arg_305_1.fswtw_.percent

				SetActive(arg_305_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_305_1:ShowNextGo(false)
			end

			local var_308_0 = 54
			local var_308_1 = 3.6
			local var_308_2, var_308_3 = arg_305_1:GetPercentByPara(arg_305_1:FormatText(arg_305_1:GetWordFromCfg(116381068).content), 5)

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				local var_308_4 = var_308_0 <= 0 and var_308_1 or var_308_1 * ((var_308_3 - arg_305_1.typewritterCharCountI18N) / var_308_0)

				if (var_308_0 <= 0 and var_308_1 or var_308_1 * ((var_308_3 - arg_305_1.typewritterCharCountI18N) / var_308_0)) > 0 and var_308_1 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end
			end

			local var_308_5 = math.max(3.6, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_5 then
				arg_305_1.fswtw_.percent = Mathf.Lerp(arg_305_1.var_.oldValueTypewriter, var_308_2, (arg_305_1.time_ - 0) / var_308_5)
				arg_305_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_305_1.fswtw_:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_5 and arg_305_1.time_ < 0 + var_308_5 + arg_308_0 then
				arg_305_1.fswtw_.percent = var_308_2

				arg_305_1.fswtw_:SetDirty()
				arg_305_1:ShowNextGo(true)

				arg_305_1.typewritterCharCountI18N = var_308_3
			end

			local var_308_6 = 0
			local var_308_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381072", "story_v_out_116381.awb") / 1000

			if var_308_7 > 0 and 13.122 < var_308_7 and var_308_7 + var_308_6 > arg_305_1.duration_ then
				arg_305_1.duration_ = var_308_7 + var_308_6
			end

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1:AudioAction("play", "voice", "story_v_out_116381", "116381072", "story_v_out_116381.awb")
			end

			local var_308_9 = 0

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			if arg_305_1.time_ >= var_308_9 + 3.6 and arg_305_1.time_ < var_308_9 + 3.6 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play116381073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 116381073
		arg_309_1.duration_ = 11.52

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play116381074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.oldValueTypewriter = arg_309_1.fswtw_.percent

				SetActive(arg_309_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_309_1:ShowNextGo(false)
			end

			local var_312_0 = 54
			local var_312_1 = 3.6
			local var_312_2, var_312_3 = arg_309_1:GetPercentByPara(arg_309_1:FormatText(arg_309_1:GetWordFromCfg(116381068).content), 6)

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0

				local var_312_4 = var_312_0 <= 0 and var_312_1 or var_312_1 * ((var_312_3 - arg_309_1.typewritterCharCountI18N) / var_312_0)

				if (var_312_0 <= 0 and var_312_1 or var_312_1 * ((var_312_3 - arg_309_1.typewritterCharCountI18N) / var_312_0)) > 0 and var_312_1 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end
			end

			local var_312_5 = math.max(3.6, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_5 then
				arg_309_1.fswtw_.percent = Mathf.Lerp(arg_309_1.var_.oldValueTypewriter, var_312_2, (arg_309_1.time_ - 0) / var_312_5)
				arg_309_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_309_1.fswtw_:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_5 and arg_309_1.time_ < 0 + var_312_5 + arg_312_0 then
				arg_309_1.fswtw_.percent = var_312_2

				arg_309_1.fswtw_:SetDirty()
				arg_309_1:ShowNextGo(true)

				arg_309_1.typewritterCharCountI18N = var_312_3
			end

			local var_312_6 = 0
			local var_312_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381073", "story_v_out_116381.awb") / 1000

			if var_312_7 > 0 and 11.523 < var_312_7 and var_312_7 + var_312_6 > arg_309_1.duration_ then
				arg_309_1.duration_ = var_312_7 + var_312_6
			end

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1:AudioAction("play", "voice", "story_v_out_116381", "116381073", "story_v_out_116381.awb")
			end

			local var_312_9 = 0

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_9 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			if arg_309_1.time_ >= var_312_9 + 3.6 and arg_309_1.time_ < var_312_9 + 3.6 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play116381074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 116381074
		arg_313_1.duration_ = 11.03

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play116381075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.fswbg_:SetActive(true)
				arg_313_1.dialog_:SetActive(false)

				arg_313_1.fswtw_.percent = 0
				arg_313_1.fswt_.text = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(116381074).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.fswt_)

				arg_313_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_313_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_313_1.fswtw_:SetDirty()

				arg_313_1.typewritterCharCountI18N = 0

				SetActive(arg_313_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_313_1:ShowNextGo(false)
			end

			local var_316_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.var_.oldValueTypewriter = arg_313_1.fswtw_.percent

				SetActive(arg_313_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_313_1:ShowNextGo(false)
			end

			local var_316_1 = 43
			local var_316_2 = 2.86666666666667
			local var_316_3, var_316_4 = arg_313_1:GetPercentByPara(arg_313_1:FormatText(arg_313_1:GetWordFromCfg(116381074).content), 1)

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				local var_316_5 = var_316_1 <= 0 and var_316_2 or var_316_2 * ((var_316_4 - arg_313_1.typewritterCharCountI18N) / var_316_1)

				if (var_316_1 <= 0 and var_316_2 or var_316_2 * ((var_316_4 - arg_313_1.typewritterCharCountI18N) / var_316_1)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_0
					end
				end
			end

			local var_316_6 = math.max(2.86666666666667, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_6 then
				arg_313_1.fswtw_.percent = Mathf.Lerp(arg_313_1.var_.oldValueTypewriter, var_316_3, (arg_313_1.time_ - var_316_0) / var_316_6)
				arg_313_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_313_1.fswtw_:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_6 and arg_313_1.time_ < var_316_0 + var_316_6 + arg_316_0 then
				arg_313_1.fswtw_.percent = var_316_3

				arg_313_1.fswtw_:SetDirty()
				arg_313_1:ShowNextGo(true)

				arg_313_1.typewritterCharCountI18N = var_316_4
			end

			local var_316_7 = 0
			local var_316_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381074", "story_v_out_116381.awb") / 1000

			if var_316_8 > 0 and 11.026 < var_316_8 and var_316_8 + var_316_7 > arg_313_1.duration_ then
				arg_313_1.duration_ = var_316_8 + var_316_7
			end

			if var_316_7 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 then
				arg_313_1:AudioAction("play", "voice", "story_v_out_116381", "116381074", "story_v_out_116381.awb")
			end

			local var_316_10 = 0

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.allBtn_.enabled = false
			end

			if arg_313_1.time_ >= var_316_10 + 2.88333333333333 and arg_313_1.time_ < var_316_10 + 2.88333333333333 + arg_316_0 then
				arg_313_1.allBtn_.enabled = true
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play116381075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 116381075
		arg_317_1.duration_ = 11.27

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play116381076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.oldValueTypewriter = arg_317_1.fswtw_.percent

				SetActive(arg_317_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_317_1:ShowNextGo(false)
			end

			local var_320_0 = 57
			local var_320_1 = 3.8
			local var_320_2, var_320_3 = arg_317_1:GetPercentByPara(arg_317_1:FormatText(arg_317_1:GetWordFromCfg(116381074).content), 2)

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				local var_320_4 = var_320_0 <= 0 and var_320_1 or var_320_1 * ((var_320_3 - arg_317_1.typewritterCharCountI18N) / var_320_0)

				if (var_320_0 <= 0 and var_320_1 or var_320_1 * ((var_320_3 - arg_317_1.typewritterCharCountI18N) / var_320_0)) > 0 and var_320_1 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end
			end

			local var_320_5 = math.max(3.8, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_5 then
				arg_317_1.fswtw_.percent = Mathf.Lerp(arg_317_1.var_.oldValueTypewriter, var_320_2, (arg_317_1.time_ - 0) / var_320_5)
				arg_317_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_317_1.fswtw_:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_5 and arg_317_1.time_ < 0 + var_320_5 + arg_320_0 then
				arg_317_1.fswtw_.percent = var_320_2

				arg_317_1.fswtw_:SetDirty()
				arg_317_1:ShowNextGo(true)

				arg_317_1.typewritterCharCountI18N = var_320_3
			end

			local var_320_6 = 0
			local var_320_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381075", "story_v_out_116381.awb") / 1000

			if var_320_7 > 0 and 11.274 < var_320_7 and var_320_7 + var_320_6 > arg_317_1.duration_ then
				arg_317_1.duration_ = var_320_7 + var_320_6
			end

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1:AudioAction("play", "voice", "story_v_out_116381", "116381075", "story_v_out_116381.awb")
			end

			local var_320_9 = 0

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 then
				arg_317_1.allBtn_.enabled = false
			end

			if arg_317_1.time_ >= var_320_9 + 3.86666666666667 and arg_317_1.time_ < var_320_9 + 3.86666666666667 + arg_320_0 then
				arg_317_1.allBtn_.enabled = true
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play116381076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 116381076
		arg_321_1.duration_ = 3.4

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play116381077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.oldValueTypewriter = arg_321_1.fswtw_.percent

				SetActive(arg_321_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_321_1:ShowNextGo(false)
			end

			local var_324_0 = 12
			local var_324_1 = 0.8
			local var_324_2, var_324_3 = arg_321_1:GetPercentByPara(arg_321_1:FormatText(arg_321_1:GetWordFromCfg(116381074).content), 3)

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				local var_324_4 = var_324_0 <= 0 and var_324_1 or var_324_1 * ((var_324_3 - arg_321_1.typewritterCharCountI18N) / var_324_0)

				if (var_324_0 <= 0 and var_324_1 or var_324_1 * ((var_324_3 - arg_321_1.typewritterCharCountI18N) / var_324_0)) > 0 and var_324_1 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end
			end

			local var_324_5 = math.max(0.8, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_5 then
				arg_321_1.fswtw_.percent = Mathf.Lerp(arg_321_1.var_.oldValueTypewriter, var_324_2, (arg_321_1.time_ - 0) / var_324_5)
				arg_321_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_321_1.fswtw_:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_5 and arg_321_1.time_ < 0 + var_324_5 + arg_324_0 then
				arg_321_1.fswtw_.percent = var_324_2

				arg_321_1.fswtw_:SetDirty()
				arg_321_1:ShowNextGo(true)

				arg_321_1.typewritterCharCountI18N = var_324_3
			end

			local var_324_6 = 0
			local var_324_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381076", "story_v_out_116381.awb") / 1000

			if var_324_7 > 0 and 3.404 < var_324_7 and var_324_7 + var_324_6 > arg_321_1.duration_ then
				arg_321_1.duration_ = var_324_7 + var_324_6
			end

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1:AudioAction("play", "voice", "story_v_out_116381", "116381076", "story_v_out_116381.awb")
			end

			local var_324_9 = 0

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			if arg_321_1.time_ >= var_324_9 + 0.8 and arg_321_1.time_ < var_324_9 + 0.8 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play116381077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 116381077
		arg_325_1.duration_ = 8.78

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play116381078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.oldValueTypewriter = arg_325_1.fswtw_.percent

				SetActive(arg_325_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_325_1:ShowNextGo(false)
			end

			local var_328_0 = 45
			local var_328_1 = 3
			local var_328_2, var_328_3 = arg_325_1:GetPercentByPara(arg_325_1:FormatText(arg_325_1:GetWordFromCfg(116381074).content), 4)

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				local var_328_4 = var_328_0 <= 0 and var_328_1 or var_328_1 * ((var_328_3 - arg_325_1.typewritterCharCountI18N) / var_328_0)

				if (var_328_0 <= 0 and var_328_1 or var_328_1 * ((var_328_3 - arg_325_1.typewritterCharCountI18N) / var_328_0)) > 0 and var_328_1 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end
			end

			local var_328_5 = math.max(3, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_5 then
				arg_325_1.fswtw_.percent = Mathf.Lerp(arg_325_1.var_.oldValueTypewriter, var_328_2, (arg_325_1.time_ - 0) / var_328_5)
				arg_325_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_325_1.fswtw_:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_5 and arg_325_1.time_ < 0 + var_328_5 + arg_328_0 then
				arg_325_1.fswtw_.percent = var_328_2

				arg_325_1.fswtw_:SetDirty()
				arg_325_1:ShowNextGo(true)

				arg_325_1.typewritterCharCountI18N = var_328_3
			end

			local var_328_6 = 0
			local var_328_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381077", "story_v_out_116381.awb") / 1000

			if var_328_7 > 0 and 8.782 < var_328_7 and var_328_7 + var_328_6 > arg_325_1.duration_ then
				arg_325_1.duration_ = var_328_7 + var_328_6
			end

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1:AudioAction("play", "voice", "story_v_out_116381", "116381077", "story_v_out_116381.awb")
			end

			local var_328_9 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_9 + 3 and arg_325_1.time_ < var_328_9 + 3 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play116381078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 116381078
		arg_329_1.duration_ = 5.99

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play116381079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.oldValueTypewriter = arg_329_1.fswtw_.percent

				SetActive(arg_329_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_329_1:ShowNextGo(false)
			end

			local var_332_0 = 24
			local var_332_1 = 1.6
			local var_332_2, var_332_3 = arg_329_1:GetPercentByPara(arg_329_1:FormatText(arg_329_1:GetWordFromCfg(116381074).content), 5)

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				local var_332_4 = var_332_0 <= 0 and var_332_1 or var_332_1 * ((var_332_3 - arg_329_1.typewritterCharCountI18N) / var_332_0)

				if (var_332_0 <= 0 and var_332_1 or var_332_1 * ((var_332_3 - arg_329_1.typewritterCharCountI18N) / var_332_0)) > 0 and var_332_1 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end
			end

			local var_332_5 = math.max(1.6, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_5 then
				arg_329_1.fswtw_.percent = Mathf.Lerp(arg_329_1.var_.oldValueTypewriter, var_332_2, (arg_329_1.time_ - 0) / var_332_5)
				arg_329_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_329_1.fswtw_:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_5 and arg_329_1.time_ < 0 + var_332_5 + arg_332_0 then
				arg_329_1.fswtw_.percent = var_332_2

				arg_329_1.fswtw_:SetDirty()
				arg_329_1:ShowNextGo(true)

				arg_329_1.typewritterCharCountI18N = var_332_3
			end

			local var_332_6 = 0
			local var_332_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381078", "story_v_out_116381.awb") / 1000

			if var_332_7 > 0 and 5.986 < var_332_7 and var_332_7 + var_332_6 > arg_329_1.duration_ then
				arg_329_1.duration_ = var_332_7 + var_332_6
			end

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1:AudioAction("play", "voice", "story_v_out_116381", "116381078", "story_v_out_116381.awb")
			end

			local var_332_9 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_9 + 1.6 and arg_329_1.time_ < var_332_9 + 1.6 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play116381079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 116381079
		arg_333_1.duration_ = 13.09

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play116381080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.oldValueTypewriter = arg_333_1.fswtw_.percent

				SetActive(arg_333_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_333_1:ShowNextGo(false)
			end

			local var_336_0 = 56
			local var_336_1 = 3.73333333333333
			local var_336_2, var_336_3 = arg_333_1:GetPercentByPara(arg_333_1:FormatText(arg_333_1:GetWordFromCfg(116381074).content), 6)

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				local var_336_4 = var_336_0 <= 0 and var_336_1 or var_336_1 * ((var_336_3 - arg_333_1.typewritterCharCountI18N) / var_336_0)

				if (var_336_0 <= 0 and var_336_1 or var_336_1 * ((var_336_3 - arg_333_1.typewritterCharCountI18N) / var_336_0)) > 0 and var_336_1 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end
			end

			local var_336_5 = math.max(3.73333333333333, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_5 then
				arg_333_1.fswtw_.percent = Mathf.Lerp(arg_333_1.var_.oldValueTypewriter, var_336_2, (arg_333_1.time_ - 0) / var_336_5)
				arg_333_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_333_1.fswtw_:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_5 and arg_333_1.time_ < 0 + var_336_5 + arg_336_0 then
				arg_333_1.fswtw_.percent = var_336_2

				arg_333_1.fswtw_:SetDirty()
				arg_333_1:ShowNextGo(true)

				arg_333_1.typewritterCharCountI18N = var_336_3
			end

			local var_336_6 = 0
			local var_336_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381079", "story_v_out_116381.awb") / 1000

			if var_336_7 > 0 and 13.093 < var_336_7 and var_336_7 + var_336_6 > arg_333_1.duration_ then
				arg_333_1.duration_ = var_336_7 + var_336_6
			end

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1:AudioAction("play", "voice", "story_v_out_116381", "116381079", "story_v_out_116381.awb")
			end

			local var_336_9 = 0

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 then
				arg_333_1.allBtn_.enabled = false
			end

			if arg_333_1.time_ >= var_336_9 + 3.8 and arg_333_1.time_ < var_336_9 + 3.8 + arg_336_0 then
				arg_333_1.allBtn_.enabled = true
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play116381080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 116381080
		arg_337_1.duration_ = 5.22

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play116381081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.fswbg_:SetActive(true)
				arg_337_1.dialog_:SetActive(false)

				arg_337_1.fswtw_.percent = 0
				arg_337_1.fswt_.text = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(116381080).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.fswt_)

				arg_337_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_337_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_337_1.fswtw_:SetDirty()

				arg_337_1.typewritterCharCountI18N = 0

				SetActive(arg_337_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_337_1:ShowNextGo(false)
			end

			local var_340_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.var_.oldValueTypewriter = arg_337_1.fswtw_.percent

				SetActive(arg_337_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_337_1:ShowNextGo(false)
			end

			local var_340_1 = 27
			local var_340_2 = 1.8
			local var_340_3, var_340_4 = arg_337_1:GetPercentByPara(arg_337_1:FormatText(arg_337_1:GetWordFromCfg(116381080).content), 1)

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0

				local var_340_5 = var_340_1 <= 0 and var_340_2 or var_340_2 * ((var_340_4 - arg_337_1.typewritterCharCountI18N) / var_340_1)

				if (var_340_1 <= 0 and var_340_2 or var_340_2 * ((var_340_4 - arg_337_1.typewritterCharCountI18N) / var_340_1)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_0
					end
				end
			end

			local var_340_6 = math.max(1.8, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_6 then
				arg_337_1.fswtw_.percent = Mathf.Lerp(arg_337_1.var_.oldValueTypewriter, var_340_3, (arg_337_1.time_ - var_340_0) / var_340_6)
				arg_337_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_337_1.fswtw_:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_6 and arg_337_1.time_ < var_340_0 + var_340_6 + arg_340_0 then
				arg_337_1.fswtw_.percent = var_340_3

				arg_337_1.fswtw_:SetDirty()
				arg_337_1:ShowNextGo(true)

				arg_337_1.typewritterCharCountI18N = var_340_4
			end

			local var_340_7 = 0
			local var_340_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381080", "story_v_out_116381.awb") / 1000

			if var_340_8 > 0 and 5.216 < var_340_8 and var_340_8 + var_340_7 > arg_337_1.duration_ then
				arg_337_1.duration_ = var_340_8 + var_340_7
			end

			if var_340_7 < arg_337_1.time_ and arg_337_1.time_ <= var_340_7 + arg_340_0 then
				arg_337_1:AudioAction("play", "voice", "story_v_out_116381", "116381080", "story_v_out_116381.awb")
			end

			local var_340_10 = 0

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 then
				arg_337_1.allBtn_.enabled = false
			end

			if arg_337_1.time_ >= var_340_10 + 1.81666666666667 and arg_337_1.time_ < var_340_10 + 1.81666666666667 + arg_340_0 then
				arg_337_1.allBtn_.enabled = true
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play116381081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 116381081
		arg_341_1.duration_ = 5.71

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play116381082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.oldValueTypewriter = arg_341_1.fswtw_.percent

				SetActive(arg_341_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_341_1:ShowNextGo(false)
			end

			local var_344_0 = 25
			local var_344_1 = 1.66666666666667
			local var_344_2, var_344_3 = arg_341_1:GetPercentByPara(arg_341_1:FormatText(arg_341_1:GetWordFromCfg(116381080).content), 2)

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				local var_344_4 = var_344_0 <= 0 and var_344_1 or var_344_1 * ((var_344_3 - arg_341_1.typewritterCharCountI18N) / var_344_0)

				if (var_344_0 <= 0 and var_344_1 or var_344_1 * ((var_344_3 - arg_341_1.typewritterCharCountI18N) / var_344_0)) > 0 and var_344_1 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end
			end

			local var_344_5 = math.max(1.66666666666667, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_5 then
				arg_341_1.fswtw_.percent = Mathf.Lerp(arg_341_1.var_.oldValueTypewriter, var_344_2, (arg_341_1.time_ - 0) / var_344_5)
				arg_341_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_341_1.fswtw_:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_5 and arg_341_1.time_ < 0 + var_344_5 + arg_344_0 then
				arg_341_1.fswtw_.percent = var_344_2

				arg_341_1.fswtw_:SetDirty()
				arg_341_1:ShowNextGo(true)

				arg_341_1.typewritterCharCountI18N = var_344_3
			end

			local var_344_6 = 0
			local var_344_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381081", "story_v_out_116381.awb") / 1000

			if var_344_7 > 0 and 5.711 < var_344_7 and var_344_7 + var_344_6 > arg_341_1.duration_ then
				arg_341_1.duration_ = var_344_7 + var_344_6
			end

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1:AudioAction("play", "voice", "story_v_out_116381", "116381081", "story_v_out_116381.awb")
			end

			local var_344_9 = 0

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_9 + arg_344_0 then
				arg_341_1.allBtn_.enabled = false
			end

			if arg_341_1.time_ >= var_344_9 + 1.66666666666667 and arg_341_1.time_ < var_344_9 + 1.66666666666667 + arg_344_0 then
				arg_341_1.allBtn_.enabled = true
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play116381082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 116381082
		arg_345_1.duration_ = 6.7

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play116381083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.oldValueTypewriter = arg_345_1.fswtw_.percent

				SetActive(arg_345_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_345_1:ShowNextGo(false)
			end

			local var_348_0 = 34
			local var_348_1 = 2.26666666666667
			local var_348_2, var_348_3 = arg_345_1:GetPercentByPara(arg_345_1:FormatText(arg_345_1:GetWordFromCfg(116381080).content), 3)

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				local var_348_4 = var_348_0 <= 0 and var_348_1 or var_348_1 * ((var_348_3 - arg_345_1.typewritterCharCountI18N) / var_348_0)

				if (var_348_0 <= 0 and var_348_1 or var_348_1 * ((var_348_3 - arg_345_1.typewritterCharCountI18N) / var_348_0)) > 0 and var_348_1 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end
			end

			local var_348_5 = math.max(2.26666666666667, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_5 then
				arg_345_1.fswtw_.percent = Mathf.Lerp(arg_345_1.var_.oldValueTypewriter, var_348_2, (arg_345_1.time_ - 0) / var_348_5)
				arg_345_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_345_1.fswtw_:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_5 and arg_345_1.time_ < 0 + var_348_5 + arg_348_0 then
				arg_345_1.fswtw_.percent = var_348_2

				arg_345_1.fswtw_:SetDirty()
				arg_345_1:ShowNextGo(true)

				arg_345_1.typewritterCharCountI18N = var_348_3
			end

			local var_348_6 = 0
			local var_348_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381082", "story_v_out_116381.awb") / 1000

			if var_348_7 > 0 and 6.696 < var_348_7 and var_348_7 + var_348_6 > arg_345_1.duration_ then
				arg_345_1.duration_ = var_348_7 + var_348_6
			end

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1:AudioAction("play", "voice", "story_v_out_116381", "116381082", "story_v_out_116381.awb")
			end

			local var_348_9 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_9 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_9 + 2.26666666666667 and arg_345_1.time_ < var_348_9 + 2.26666666666667 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play116381083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 116381083
		arg_349_1.duration_ = 8.8

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play116381084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.oldValueTypewriter = arg_349_1.fswtw_.percent

				SetActive(arg_349_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_349_1:ShowNextGo(false)
			end

			local var_352_0 = 43
			local var_352_1 = 2.86666666666667
			local var_352_2, var_352_3 = arg_349_1:GetPercentByPara(arg_349_1:FormatText(arg_349_1:GetWordFromCfg(116381080).content), 4)

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				local var_352_4 = var_352_0 <= 0 and var_352_1 or var_352_1 * ((var_352_3 - arg_349_1.typewritterCharCountI18N) / var_352_0)

				if (var_352_0 <= 0 and var_352_1 or var_352_1 * ((var_352_3 - arg_349_1.typewritterCharCountI18N) / var_352_0)) > 0 and var_352_1 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end
			end

			local var_352_5 = math.max(2.86666666666667, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_5 then
				arg_349_1.fswtw_.percent = Mathf.Lerp(arg_349_1.var_.oldValueTypewriter, var_352_2, (arg_349_1.time_ - 0) / var_352_5)
				arg_349_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_349_1.fswtw_:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_5 and arg_349_1.time_ < 0 + var_352_5 + arg_352_0 then
				arg_349_1.fswtw_.percent = var_352_2

				arg_349_1.fswtw_:SetDirty()
				arg_349_1:ShowNextGo(true)

				arg_349_1.typewritterCharCountI18N = var_352_3
			end

			local var_352_6 = 0
			local var_352_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381083", "story_v_out_116381.awb") / 1000

			if var_352_7 > 0 and 8.798 < var_352_7 and var_352_7 + var_352_6 > arg_349_1.duration_ then
				arg_349_1.duration_ = var_352_7 + var_352_6
			end

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1:AudioAction("play", "voice", "story_v_out_116381", "116381083", "story_v_out_116381.awb")
			end

			local var_352_9 = 0

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_9 + arg_352_0 then
				arg_349_1.allBtn_.enabled = false
			end

			if arg_349_1.time_ >= var_352_9 + 2.86666666666667 and arg_349_1.time_ < var_352_9 + 2.86666666666667 + arg_352_0 then
				arg_349_1.allBtn_.enabled = true
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play116381084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 116381084
		arg_353_1.duration_ = 5.75

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play116381085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.oldValueTypewriter = arg_353_1.fswtw_.percent

				SetActive(arg_353_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_353_1:ShowNextGo(false)
			end

			local var_356_0 = 19
			local var_356_1 = 1.26666666666667
			local var_356_2, var_356_3 = arg_353_1:GetPercentByPara(arg_353_1:FormatText(arg_353_1:GetWordFromCfg(116381080).content), 5)

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				local var_356_4 = var_356_0 <= 0 and var_356_1 or var_356_1 * ((var_356_3 - arg_353_1.typewritterCharCountI18N) / var_356_0)

				if (var_356_0 <= 0 and var_356_1 or var_356_1 * ((var_356_3 - arg_353_1.typewritterCharCountI18N) / var_356_0)) > 0 and var_356_1 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end
			end

			local var_356_5 = math.max(1.26666666666667, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_5 then
				arg_353_1.fswtw_.percent = Mathf.Lerp(arg_353_1.var_.oldValueTypewriter, var_356_2, (arg_353_1.time_ - 0) / var_356_5)
				arg_353_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_353_1.fswtw_:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_5 and arg_353_1.time_ < 0 + var_356_5 + arg_356_0 then
				arg_353_1.fswtw_.percent = var_356_2

				arg_353_1.fswtw_:SetDirty()
				arg_353_1:ShowNextGo(true)

				arg_353_1.typewritterCharCountI18N = var_356_3
			end

			local var_356_6 = 0
			local var_356_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381084", "story_v_out_116381.awb") / 1000

			if var_356_7 > 0 and 5.75 < var_356_7 and var_356_7 + var_356_6 > arg_353_1.duration_ then
				arg_353_1.duration_ = var_356_7 + var_356_6
			end

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1:AudioAction("play", "voice", "story_v_out_116381", "116381084", "story_v_out_116381.awb")
			end

			local var_356_9 = 0

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 then
				arg_353_1.allBtn_.enabled = false
			end

			if arg_353_1.time_ >= var_356_9 + 1.33333333333333 and arg_353_1.time_ < var_356_9 + 1.33333333333333 + arg_356_0 then
				arg_353_1.allBtn_.enabled = true
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play116381085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 116381085
		arg_357_1.duration_ = 10.58

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play116381086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.oldValueTypewriter = arg_357_1.fswtw_.percent

				SetActive(arg_357_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_357_1:ShowNextGo(false)
			end

			local var_360_0 = 51
			local var_360_1 = 3.26666666666667
			local var_360_2, var_360_3 = arg_357_1:GetPercentByPara(arg_357_1:FormatText(arg_357_1:GetWordFromCfg(116381080).content), 6)

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				local var_360_4 = var_360_0 <= 0 and var_360_1 or var_360_1 * ((var_360_3 - arg_357_1.typewritterCharCountI18N) / var_360_0)

				if (var_360_0 <= 0 and var_360_1 or var_360_1 * ((var_360_3 - arg_357_1.typewritterCharCountI18N) / var_360_0)) > 0 and var_360_1 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end
			end

			local var_360_5 = math.max(3.26666666666667, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_5 then
				arg_357_1.fswtw_.percent = Mathf.Lerp(arg_357_1.var_.oldValueTypewriter, var_360_2, (arg_357_1.time_ - 0) / var_360_5)
				arg_357_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_357_1.fswtw_:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_5 and arg_357_1.time_ < 0 + var_360_5 + arg_360_0 then
				arg_357_1.fswtw_.percent = var_360_2

				arg_357_1.fswtw_:SetDirty()
				arg_357_1:ShowNextGo(true)

				arg_357_1.typewritterCharCountI18N = var_360_3
			end

			local var_360_6 = 0
			local var_360_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381085", "story_v_out_116381.awb") / 1000

			if var_360_7 > 0 and 10.582 < var_360_7 and var_360_7 + var_360_6 > arg_357_1.duration_ then
				arg_357_1.duration_ = var_360_7 + var_360_6
			end

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1:AudioAction("play", "voice", "story_v_out_116381", "116381085", "story_v_out_116381.awb")
			end

			local var_360_9 = 0

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 then
				arg_357_1.allBtn_.enabled = false
			end

			if arg_357_1.time_ >= var_360_9 + 3.26666666666667 and arg_357_1.time_ < var_360_9 + 3.26666666666667 + arg_360_0 then
				arg_357_1.allBtn_.enabled = true
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play116381086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 116381086
		arg_361_1.duration_ = 3.71

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play116381087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.fswbg_:SetActive(true)
				arg_361_1.dialog_:SetActive(false)

				arg_361_1.fswtw_.percent = 0
				arg_361_1.fswt_.text = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(116381086).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.fswt_)

				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_361_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_361_1.fswtw_:SetDirty()

				arg_361_1.typewritterCharCountI18N = 0

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.var_.oldValueTypewriter = arg_361_1.fswtw_.percent

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_1 = 18
			local var_364_2 = 1.2
			local var_364_3, var_364_4 = arg_361_1:GetPercentByPara(arg_361_1:FormatText(arg_361_1:GetWordFromCfg(116381086).content), 1)

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				local var_364_5 = var_364_1 <= 0 and var_364_2 or var_364_2 * ((var_364_4 - arg_361_1.typewritterCharCountI18N) / var_364_1)

				if (var_364_1 <= 0 and var_364_2 or var_364_2 * ((var_364_4 - arg_361_1.typewritterCharCountI18N) / var_364_1)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_0
					end
				end
			end

			local var_364_6 = math.max(1.2, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_6 then
				arg_361_1.fswtw_.percent = Mathf.Lerp(arg_361_1.var_.oldValueTypewriter, var_364_3, (arg_361_1.time_ - var_364_0) / var_364_6)
				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_361_1.fswtw_:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_6 and arg_361_1.time_ < var_364_0 + var_364_6 + arg_364_0 then
				arg_361_1.fswtw_.percent = var_364_3

				arg_361_1.fswtw_:SetDirty()
				arg_361_1:ShowNextGo(true)

				arg_361_1.typewritterCharCountI18N = var_364_4
			end

			local var_364_7 = 0
			local var_364_8 = manager.audio:GetVoiceLength("story_v_out_116381", "116381086", "story_v_out_116381.awb") / 1000

			if var_364_8 > 0 and 3.714 < var_364_8 and var_364_8 + var_364_7 > arg_361_1.duration_ then
				arg_361_1.duration_ = var_364_8 + var_364_7
			end

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1:AudioAction("play", "voice", "story_v_out_116381", "116381086", "story_v_out_116381.awb")
			end

			local var_364_10 = 0

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_10 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			if arg_361_1.time_ >= var_364_10 + 1.21666666666667 and arg_361_1.time_ < var_364_10 + 1.21666666666667 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play116381087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 116381087
		arg_365_1.duration_ = 6.92

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play116381088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.oldValueTypewriter = arg_365_1.fswtw_.percent

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_0 = 36
			local var_368_1 = 2.4
			local var_368_2, var_368_3 = arg_365_1:GetPercentByPara(arg_365_1:FormatText(arg_365_1:GetWordFromCfg(116381086).content), 2)

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				local var_368_4 = var_368_0 <= 0 and var_368_1 or var_368_1 * ((var_368_3 - arg_365_1.typewritterCharCountI18N) / var_368_0)

				if (var_368_0 <= 0 and var_368_1 or var_368_1 * ((var_368_3 - arg_365_1.typewritterCharCountI18N) / var_368_0)) > 0 and var_368_1 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end
			end

			local var_368_5 = math.max(2.4, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_5 then
				arg_365_1.fswtw_.percent = Mathf.Lerp(arg_365_1.var_.oldValueTypewriter, var_368_2, (arg_365_1.time_ - 0) / var_368_5)
				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_365_1.fswtw_:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_5 and arg_365_1.time_ < 0 + var_368_5 + arg_368_0 then
				arg_365_1.fswtw_.percent = var_368_2

				arg_365_1.fswtw_:SetDirty()
				arg_365_1:ShowNextGo(true)

				arg_365_1.typewritterCharCountI18N = var_368_3
			end

			local var_368_6 = 0
			local var_368_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381087", "story_v_out_116381.awb") / 1000

			if var_368_7 > 0 and 6.923 < var_368_7 and var_368_7 + var_368_6 > arg_365_1.duration_ then
				arg_365_1.duration_ = var_368_7 + var_368_6
			end

			if var_368_6 < arg_365_1.time_ and arg_365_1.time_ <= var_368_6 + arg_368_0 then
				arg_365_1:AudioAction("play", "voice", "story_v_out_116381", "116381087", "story_v_out_116381.awb")
			end

			local var_368_9 = 0

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_9 + arg_368_0 then
				arg_365_1.allBtn_.enabled = false
			end

			if arg_365_1.time_ >= var_368_9 + 2.4 and arg_365_1.time_ < var_368_9 + 2.4 + arg_368_0 then
				arg_365_1.allBtn_.enabled = true
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play116381088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 116381088
		arg_369_1.duration_ = 3.37

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play116381089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.oldValueTypewriter = arg_369_1.fswtw_.percent

				SetActive(arg_369_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_369_1:ShowNextGo(false)
			end

			local var_372_0 = 16
			local var_372_1 = 1.06666666666667
			local var_372_2, var_372_3 = arg_369_1:GetPercentByPara(arg_369_1:FormatText(arg_369_1:GetWordFromCfg(116381086).content), 3)

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				local var_372_4 = var_372_0 <= 0 and var_372_1 or var_372_1 * ((var_372_3 - arg_369_1.typewritterCharCountI18N) / var_372_0)

				if (var_372_0 <= 0 and var_372_1 or var_372_1 * ((var_372_3 - arg_369_1.typewritterCharCountI18N) / var_372_0)) > 0 and var_372_1 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end
			end

			local var_372_5 = math.max(1.06666666666667, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_5 then
				arg_369_1.fswtw_.percent = Mathf.Lerp(arg_369_1.var_.oldValueTypewriter, var_372_2, (arg_369_1.time_ - 0) / var_372_5)
				arg_369_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_369_1.fswtw_:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_5 and arg_369_1.time_ < 0 + var_372_5 + arg_372_0 then
				arg_369_1.fswtw_.percent = var_372_2

				arg_369_1.fswtw_:SetDirty()
				arg_369_1:ShowNextGo(true)

				arg_369_1.typewritterCharCountI18N = var_372_3
			end

			local var_372_6 = 0
			local var_372_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381088", "story_v_out_116381.awb") / 1000

			if var_372_7 > 0 and 3.098 < var_372_7 and var_372_7 + var_372_6 > arg_369_1.duration_ then
				arg_369_1.duration_ = var_372_7 + var_372_6
			end

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1:AudioAction("play", "voice", "story_v_out_116381", "116381088", "story_v_out_116381.awb")
			end

			local var_372_9 = 0

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			if arg_369_1.time_ >= var_372_9 + 1.06666666666667 and arg_369_1.time_ < var_372_9 + 1.06666666666667 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play116381089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 116381089
		arg_373_1.duration_ = 4.83

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play116381090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.oldValueTypewriter = arg_373_1.fswtw_.percent

				SetActive(arg_373_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_373_1:ShowNextGo(false)
			end

			local var_376_0 = 17
			local var_376_1 = 1.13333333333333
			local var_376_2, var_376_3 = arg_373_1:GetPercentByPara(arg_373_1:FormatText(arg_373_1:GetWordFromCfg(116381086).content), 4)

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				local var_376_4 = var_376_0 <= 0 and var_376_1 or var_376_1 * ((var_376_3 - arg_373_1.typewritterCharCountI18N) / var_376_0)

				if (var_376_0 <= 0 and var_376_1 or var_376_1 * ((var_376_3 - arg_373_1.typewritterCharCountI18N) / var_376_0)) > 0 and var_376_1 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end
			end

			local var_376_5 = math.max(1.13333333333333, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_5 then
				arg_373_1.fswtw_.percent = Mathf.Lerp(arg_373_1.var_.oldValueTypewriter, var_376_2, (arg_373_1.time_ - 0) / var_376_5)
				arg_373_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_373_1.fswtw_:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_5 and arg_373_1.time_ < 0 + var_376_5 + arg_376_0 then
				arg_373_1.fswtw_.percent = var_376_2

				arg_373_1.fswtw_:SetDirty()
				arg_373_1:ShowNextGo(true)

				arg_373_1.typewritterCharCountI18N = var_376_3
			end

			local var_376_6 = 0
			local var_376_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381089", "story_v_out_116381.awb") / 1000

			if var_376_7 > 0 and 4.835 < var_376_7 and var_376_7 + var_376_6 > arg_373_1.duration_ then
				arg_373_1.duration_ = var_376_7 + var_376_6
			end

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1:AudioAction("play", "voice", "story_v_out_116381", "116381089", "story_v_out_116381.awb")
			end

			local var_376_9 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			if arg_373_1.time_ >= var_376_9 + 1.13333333333333 and arg_373_1.time_ < var_376_9 + 1.13333333333333 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play116381090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 116381090
		arg_377_1.duration_ = 6.23

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play116381091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.oldValueTypewriter = arg_377_1.fswtw_.percent

				SetActive(arg_377_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_377_1:ShowNextGo(false)
			end

			local var_380_0 = 22
			local var_380_1 = 1.46666666666667
			local var_380_2, var_380_3 = arg_377_1:GetPercentByPara(arg_377_1:FormatText(arg_377_1:GetWordFromCfg(116381086).content), 5)

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				local var_380_4 = var_380_0 <= 0 and var_380_1 or var_380_1 * ((var_380_3 - arg_377_1.typewritterCharCountI18N) / var_380_0)

				if (var_380_0 <= 0 and var_380_1 or var_380_1 * ((var_380_3 - arg_377_1.typewritterCharCountI18N) / var_380_0)) > 0 and var_380_1 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end
			end

			local var_380_5 = math.max(1.46666666666667, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_5 then
				arg_377_1.fswtw_.percent = Mathf.Lerp(arg_377_1.var_.oldValueTypewriter, var_380_2, (arg_377_1.time_ - 0) / var_380_5)
				arg_377_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_377_1.fswtw_:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_5 and arg_377_1.time_ < 0 + var_380_5 + arg_380_0 then
				arg_377_1.fswtw_.percent = var_380_2

				arg_377_1.fswtw_:SetDirty()
				arg_377_1:ShowNextGo(true)

				arg_377_1.typewritterCharCountI18N = var_380_3
			end

			local var_380_6 = 0
			local var_380_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381090", "story_v_out_116381.awb") / 1000

			if var_380_7 > 0 and 6.234 < var_380_7 and var_380_7 + var_380_6 > arg_377_1.duration_ then
				arg_377_1.duration_ = var_380_7 + var_380_6
			end

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1:AudioAction("play", "voice", "story_v_out_116381", "116381090", "story_v_out_116381.awb")
			end

			local var_380_9 = 0

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_9 + arg_380_0 then
				arg_377_1.allBtn_.enabled = false
			end

			if arg_377_1.time_ >= var_380_9 + 1.46666666666667 and arg_377_1.time_ < var_380_9 + 1.46666666666667 + arg_380_0 then
				arg_377_1.allBtn_.enabled = true
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play116381091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 116381091
		arg_381_1.duration_ = 3.03

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
			arg_381_1.auto_ = false
		end

		function arg_381_1.playNext_(arg_383_0)
			arg_381_1.onStoryFinished_()
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.oldValueTypewriter = arg_381_1.fswtw_.percent

				SetActive(arg_381_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_381_1:ShowNextGo(false)
			end

			local var_384_0 = 11
			local var_384_1 = 0.733333333333333
			local var_384_2, var_384_3 = arg_381_1:GetPercentByPara(arg_381_1:FormatText(arg_381_1:GetWordFromCfg(116381086).content), 6)

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0

				local var_384_4 = var_384_0 <= 0 and var_384_1 or var_384_1 * ((var_384_3 - arg_381_1.typewritterCharCountI18N) / var_384_0)

				if (var_384_0 <= 0 and var_384_1 or var_384_1 * ((var_384_3 - arg_381_1.typewritterCharCountI18N) / var_384_0)) > 0 and var_384_1 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end
			end

			local var_384_5 = math.max(0.733333333333333, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_5 then
				arg_381_1.fswtw_.percent = Mathf.Lerp(arg_381_1.var_.oldValueTypewriter, var_384_2, (arg_381_1.time_ - 0) / var_384_5)
				arg_381_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_381_1.fswtw_:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_5 and arg_381_1.time_ < 0 + var_384_5 + arg_384_0 then
				arg_381_1.fswtw_.percent = var_384_2

				arg_381_1.fswtw_:SetDirty()
				arg_381_1:ShowNextGo(true)

				arg_381_1.typewritterCharCountI18N = var_384_3
			end

			local var_384_6 = 0
			local var_384_7 = manager.audio:GetVoiceLength("story_v_out_116381", "116381091", "story_v_out_116381.awb") / 1000

			if var_384_7 > 0 and 2.753 < var_384_7 and var_384_7 + var_384_6 > arg_381_1.duration_ then
				arg_381_1.duration_ = var_384_7 + var_384_6
			end

			if var_384_6 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1:AudioAction("play", "voice", "story_v_out_116381", "116381091", "story_v_out_116381.awb")
			end

			local var_384_9 = 0

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_9 + arg_384_0 then
				arg_381_1.allBtn_.enabled = false
			end

			if arg_381_1.time_ >= var_384_9 + 0.733333333333333 and arg_381_1.time_ < var_384_9 + 0.733333333333333 + arg_384_0 then
				arg_381_1.allBtn_.enabled = true
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SK0107",
		"TextureConfig/Background/SK0112",
		"TextureConfig/Background/SK0201",
		"TextureConfig/Background/SK0106",
		"TextureConfig/Background/SK0102",
		"TextureConfig/Background/I05f"
	},
	voices = {
		"story_v_out_116381.awb"
	}
}
