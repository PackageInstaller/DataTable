return {
	Play108041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108041001
		arg_1_1.duration_ = 5.62

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108041003(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.S0808 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0808")
				var_4_0.name = "S0808"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.S0808 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.S0808

				arg_1_1.bgs_.S0808.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0808" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(108041001).content)

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

			local var_4_5 = 22
			local var_4_6 = 1.46666666666667
			local var_4_7, var_4_8 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(108041001).content), 1)

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

			local var_4_10 = math.max(1.46666666666667, arg_1_1.talkMaxDuration)

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_14 = 2
			local var_4_15 = manager.audio:GetVoiceLength("story_v_out_108041", "108041001", "story_v_out_108041.awb") / 1000

			if var_4_15 > 0 and 3.616 < var_4_15 and var_4_15 + var_4_14 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_15 + var_4_14
			end

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_108041", "108041001", "story_v_out_108041.awb")
			end

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_18 = 2

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_17) / var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_20.a = 0
				arg_1_1.mask_.color = var_4_20
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play108041003 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 108041003
		arg_6_1.duration_ = 4.32

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play108041004(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 22
			local var_9_1 = 1.46666666666667
			local var_9_2, var_9_3 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(108041001).content), 2)

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_4 = var_9_0 <= 0 and var_9_1 or var_9_1 * ((var_9_3 - arg_6_1.typewritterCharCountI18N) / var_9_0)

				if (var_9_0 <= 0 and var_9_1 or var_9_1 * ((var_9_3 - arg_6_1.typewritterCharCountI18N) / var_9_0)) > 0 and var_9_1 < var_9_4 then
					arg_6_1.talkMaxDuration = var_9_4

					if var_9_4 + 0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_4 + 0
					end
				end
			end

			local var_9_5 = math.max(1.46666666666667, arg_6_1.talkMaxDuration)

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_5 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_2, (arg_6_1.time_ - 0) / var_9_5)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= 0 + var_9_5 and arg_6_1.time_ < 0 + var_9_5 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_2

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_3
			end

			local var_9_6 = 0
			local var_9_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041003", "story_v_out_108041.awb") / 1000

			if var_9_7 > 0 and 4.325 < var_9_7 and var_9_7 + var_9_6 > arg_6_1.duration_ then
				arg_6_1.duration_ = var_9_7 + var_9_6
			end

			if var_9_6 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1:AudioAction("play", "voice", "story_v_out_108041", "108041003", "story_v_out_108041.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play108041004 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 108041004
		arg_10_1.duration_ = 7.93

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play108041005(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 43
			local var_13_1 = 2.86666666666667
			local var_13_2, var_13_3 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(108041001).content), 3)

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_4 = var_13_0 <= 0 and var_13_1 or var_13_1 * ((var_13_3 - arg_10_1.typewritterCharCountI18N) / var_13_0)

				if (var_13_0 <= 0 and var_13_1 or var_13_1 * ((var_13_3 - arg_10_1.typewritterCharCountI18N) / var_13_0)) > 0 and var_13_1 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end
			end

			local var_13_5 = math.max(2.86666666666667, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_5 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_2, (arg_10_1.time_ - 0) / var_13_5)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_5 and arg_10_1.time_ < 0 + var_13_5 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_2

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_3
			end

			local var_13_6 = 0
			local var_13_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041004", "story_v_out_108041.awb") / 1000

			if var_13_7 > 0 and 7.933 < var_13_7 and var_13_7 + var_13_6 > arg_10_1.duration_ then
				arg_10_1.duration_ = var_13_7 + var_13_6
			end

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1:AudioAction("play", "voice", "story_v_out_108041", "108041004", "story_v_out_108041.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play108041005 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 108041005
		arg_14_1.duration_ = 15.96

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play108041006(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_0 = 81
			local var_17_1 = 5.4
			local var_17_2, var_17_3 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(108041001).content), 4)

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_4 = var_17_0 <= 0 and var_17_1 or var_17_1 * ((var_17_3 - arg_14_1.typewritterCharCountI18N) / var_17_0)

				if (var_17_0 <= 0 and var_17_1 or var_17_1 * ((var_17_3 - arg_14_1.typewritterCharCountI18N) / var_17_0)) > 0 and var_17_1 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end
			end

			local var_17_5 = math.max(5.4, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_5 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_2, (arg_14_1.time_ - 0) / var_17_5)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_5 and arg_14_1.time_ < 0 + var_17_5 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_2

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_3
			end

			local var_17_6 = 0
			local var_17_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041005", "story_v_out_108041.awb") / 1000

			if var_17_7 > 0 and 15.957 < var_17_7 and var_17_7 + var_17_6 > arg_14_1.duration_ then
				arg_14_1.duration_ = var_17_7 + var_17_6
			end

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1:AudioAction("play", "voice", "story_v_out_108041", "108041005", "story_v_out_108041.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play108041006 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 108041006
		arg_18_1.duration_ = 2.41

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play108041007(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_0 = 21
			local var_21_1 = 1.4
			local var_21_2, var_21_3 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(108041001).content), 5)

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_4 = var_21_0 <= 0 and var_21_1 or var_21_1 * ((var_21_3 - arg_18_1.typewritterCharCountI18N) / var_21_0)

				if (var_21_0 <= 0 and var_21_1 or var_21_1 * ((var_21_3 - arg_18_1.typewritterCharCountI18N) / var_21_0)) > 0 and var_21_1 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end
			end

			local var_21_5 = math.max(1.4, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_5 then
				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_2, (arg_18_1.time_ - 0) / var_21_5)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_5 and arg_18_1.time_ < 0 + var_21_5 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_2

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_3
			end

			local var_21_6 = 0
			local var_21_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041006", "story_v_out_108041.awb") / 1000

			if var_21_7 > 0 and 2.41 < var_21_7 and var_21_7 + var_21_6 > arg_18_1.duration_ then
				arg_18_1.duration_ = var_21_7 + var_21_6
			end

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1:AudioAction("play", "voice", "story_v_out_108041", "108041006", "story_v_out_108041.awb")
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play108041007 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 108041007
		arg_22_1.duration_ = 19.08

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play108041009(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_0 = 89
			local var_25_1 = 5.93333333333333
			local var_25_2, var_25_3 = arg_22_1:GetPercentByPara(arg_22_1:FormatText(arg_22_1:GetWordFromCfg(108041001).content), 6)

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_4 = var_25_0 <= 0 and var_25_1 or var_25_1 * ((var_25_3 - arg_22_1.typewritterCharCountI18N) / var_25_0)

				if (var_25_0 <= 0 and var_25_1 or var_25_1 * ((var_25_3 - arg_22_1.typewritterCharCountI18N) / var_25_0)) > 0 and var_25_1 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end
			end

			local var_25_5 = math.max(5.93333333333333, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_5 then
				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_2, (arg_22_1.time_ - 0) / var_25_5)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_5 and arg_22_1.time_ < 0 + var_25_5 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_2

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_3
			end

			local var_25_6 = 0
			local var_25_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041007", "story_v_out_108041.awb") / 1000

			if var_25_7 > 0 and 19.082 < var_25_7 and var_25_7 + var_25_6 > arg_22_1.duration_ then
				arg_22_1.duration_ = var_25_7 + var_25_6
			end

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1:AudioAction("play", "voice", "story_v_out_108041", "108041007", "story_v_out_108041.awb")
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play108041009 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 108041009
		arg_26_1.duration_ = 11.98

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play108041011(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(true)
				arg_26_1.dialog_:SetActive(false)

				arg_26_1.fswtw_.percent = 0
				arg_26_1.fswt_.text = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(108041009).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.fswt_)

				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_26_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_26_1.fswtw_:SetDirty()

				arg_26_1.typewritterCharCountI18N = 0

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_1 = 60
			local var_29_2 = 4
			local var_29_3, var_29_4 = arg_26_1:GetPercentByPara(arg_26_1:FormatText(arg_26_1:GetWordFromCfg(108041009).content), 1)

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_5 = var_29_1 <= 0 and var_29_2 or var_29_2 * ((var_29_4 - arg_26_1.typewritterCharCountI18N) / var_29_1)

				if (var_29_1 <= 0 and var_29_2 or var_29_2 * ((var_29_4 - arg_26_1.typewritterCharCountI18N) / var_29_1)) > 0 and var_29_2 < var_29_5 then
					arg_26_1.talkMaxDuration = var_29_5

					if var_29_5 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + var_29_0
					end
				end
			end

			local var_29_6 = math.max(4, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_6 then
				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_3, (arg_26_1.time_ - var_29_0) / var_29_6)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_6 and arg_26_1.time_ < var_29_0 + var_29_6 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_3

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_4
			end

			local var_29_7 = 0
			local var_29_8 = manager.audio:GetVoiceLength("story_v_out_108041", "108041009", "story_v_out_108041.awb") / 1000

			if var_29_8 > 0 and 11.984 < var_29_8 and var_29_8 + var_29_7 > arg_26_1.duration_ then
				arg_26_1.duration_ = var_29_8 + var_29_7
			end

			if var_29_7 < arg_26_1.time_ and arg_26_1.time_ <= var_29_7 + arg_29_0 then
				arg_26_1:AudioAction("play", "voice", "story_v_out_108041", "108041009", "story_v_out_108041.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play108041011 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 108041011
		arg_30_1.duration_ = 8.56

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play108041012(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_0 = 42
			local var_33_1 = 2.8
			local var_33_2, var_33_3 = arg_30_1:GetPercentByPara(arg_30_1:FormatText(arg_30_1:GetWordFromCfg(108041009).content), 2)

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_4 = var_33_0 <= 0 and var_33_1 or var_33_1 * ((var_33_3 - arg_30_1.typewritterCharCountI18N) / var_33_0)

				if (var_33_0 <= 0 and var_33_1 or var_33_1 * ((var_33_3 - arg_30_1.typewritterCharCountI18N) / var_33_0)) > 0 and var_33_1 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end
			end

			local var_33_5 = math.max(2.8, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_5 then
				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_2, (arg_30_1.time_ - 0) / var_33_5)
				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_5 and arg_30_1.time_ < 0 + var_33_5 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_2

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_3
			end

			local var_33_6 = 0
			local var_33_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041011", "story_v_out_108041.awb") / 1000

			if var_33_7 > 0 and 8.558 < var_33_7 and var_33_7 + var_33_6 > arg_30_1.duration_ then
				arg_30_1.duration_ = var_33_7 + var_33_6
			end

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1:AudioAction("play", "voice", "story_v_out_108041", "108041011", "story_v_out_108041.awb")
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play108041012 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 108041012
		arg_34_1.duration_ = 8.08

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play108041013(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_0 = 43
			local var_37_1 = 2.86666666666667
			local var_37_2, var_37_3 = arg_34_1:GetPercentByPara(arg_34_1:FormatText(arg_34_1:GetWordFromCfg(108041009).content), 3)

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				local var_37_4 = var_37_0 <= 0 and var_37_1 or var_37_1 * ((var_37_3 - arg_34_1.typewritterCharCountI18N) / var_37_0)

				if (var_37_0 <= 0 and var_37_1 or var_37_1 * ((var_37_3 - arg_34_1.typewritterCharCountI18N) / var_37_0)) > 0 and var_37_1 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end
			end

			local var_37_5 = math.max(2.86666666666667, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_5 then
				arg_34_1.fswtw_.percent = Mathf.Lerp(arg_34_1.var_.oldValueTypewriter, var_37_2, (arg_34_1.time_ - 0) / var_37_5)
				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.fswtw_:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_5 and arg_34_1.time_ < 0 + var_37_5 + arg_37_0 then
				arg_34_1.fswtw_.percent = var_37_2

				arg_34_1.fswtw_:SetDirty()
				arg_34_1:ShowNextGo(true)

				arg_34_1.typewritterCharCountI18N = var_37_3
			end

			local var_37_6 = 0
			local var_37_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041012", "story_v_out_108041.awb") / 1000

			if var_37_7 > 0 and 8.085 < var_37_7 and var_37_7 + var_37_6 > arg_34_1.duration_ then
				arg_34_1.duration_ = var_37_7 + var_37_6
			end

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1:AudioAction("play", "voice", "story_v_out_108041", "108041012", "story_v_out_108041.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play108041013 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 108041013
		arg_38_1.duration_ = 3.93

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play108041014(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_0 = 24
			local var_41_1 = 1.6
			local var_41_2, var_41_3 = arg_38_1:GetPercentByPara(arg_38_1:FormatText(arg_38_1:GetWordFromCfg(108041009).content), 4)

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				local var_41_4 = var_41_0 <= 0 and var_41_1 or var_41_1 * ((var_41_3 - arg_38_1.typewritterCharCountI18N) / var_41_0)

				if (var_41_0 <= 0 and var_41_1 or var_41_1 * ((var_41_3 - arg_38_1.typewritterCharCountI18N) / var_41_0)) > 0 and var_41_1 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end
			end

			local var_41_5 = math.max(1.6, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_5 then
				arg_38_1.fswtw_.percent = Mathf.Lerp(arg_38_1.var_.oldValueTypewriter, var_41_2, (arg_38_1.time_ - 0) / var_41_5)
				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_38_1.fswtw_:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_5 and arg_38_1.time_ < 0 + var_41_5 + arg_41_0 then
				arg_38_1.fswtw_.percent = var_41_2

				arg_38_1.fswtw_:SetDirty()
				arg_38_1:ShowNextGo(true)

				arg_38_1.typewritterCharCountI18N = var_41_3
			end

			local var_41_6 = 0
			local var_41_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041013", "story_v_out_108041.awb") / 1000

			if var_41_7 > 0 and 3.929 < var_41_7 and var_41_7 + var_41_6 > arg_38_1.duration_ then
				arg_38_1.duration_ = var_41_7 + var_41_6
			end

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1:AudioAction("play", "voice", "story_v_out_108041", "108041013", "story_v_out_108041.awb")
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play108041014 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 108041014
		arg_42_1.duration_ = 8.25

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play108041015(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_0 = 40
			local var_45_1 = 2.66666666666667
			local var_45_2, var_45_3 = arg_42_1:GetPercentByPara(arg_42_1:FormatText(arg_42_1:GetWordFromCfg(108041009).content), 5)

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				local var_45_4 = var_45_0 <= 0 and var_45_1 or var_45_1 * ((var_45_3 - arg_42_1.typewritterCharCountI18N) / var_45_0)

				if (var_45_0 <= 0 and var_45_1 or var_45_1 * ((var_45_3 - arg_42_1.typewritterCharCountI18N) / var_45_0)) > 0 and var_45_1 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end
			end

			local var_45_5 = math.max(2.66666666666667, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_5 then
				arg_42_1.fswtw_.percent = Mathf.Lerp(arg_42_1.var_.oldValueTypewriter, var_45_2, (arg_42_1.time_ - 0) / var_45_5)
				arg_42_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_42_1.fswtw_:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_5 and arg_42_1.time_ < 0 + var_45_5 + arg_45_0 then
				arg_42_1.fswtw_.percent = var_45_2

				arg_42_1.fswtw_:SetDirty()
				arg_42_1:ShowNextGo(true)

				arg_42_1.typewritterCharCountI18N = var_45_3
			end

			local var_45_6 = 0
			local var_45_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041014", "story_v_out_108041.awb") / 1000

			if var_45_7 > 0 and 8.253 < var_45_7 and var_45_7 + var_45_6 > arg_42_1.duration_ then
				arg_42_1.duration_ = var_45_7 + var_45_6
			end

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1:AudioAction("play", "voice", "story_v_out_108041", "108041014", "story_v_out_108041.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play108041015 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 108041015
		arg_46_1.duration_ = 4.62

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play108041016(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_0 = 28
			local var_49_1 = 1.86666666666667
			local var_49_2, var_49_3 = arg_46_1:GetPercentByPara(arg_46_1:FormatText(arg_46_1:GetWordFromCfg(108041009).content), 6)

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				local var_49_4 = var_49_0 <= 0 and var_49_1 or var_49_1 * ((var_49_3 - arg_46_1.typewritterCharCountI18N) / var_49_0)

				if (var_49_0 <= 0 and var_49_1 or var_49_1 * ((var_49_3 - arg_46_1.typewritterCharCountI18N) / var_49_0)) > 0 and var_49_1 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end
			end

			local var_49_5 = math.max(1.86666666666667, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_5 then
				arg_46_1.fswtw_.percent = Mathf.Lerp(arg_46_1.var_.oldValueTypewriter, var_49_2, (arg_46_1.time_ - 0) / var_49_5)
				arg_46_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_46_1.fswtw_:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_5 and arg_46_1.time_ < 0 + var_49_5 + arg_49_0 then
				arg_46_1.fswtw_.percent = var_49_2

				arg_46_1.fswtw_:SetDirty()
				arg_46_1:ShowNextGo(true)

				arg_46_1.typewritterCharCountI18N = var_49_3
			end

			local var_49_6 = 0
			local var_49_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041015", "story_v_out_108041.awb") / 1000

			if var_49_7 > 0 and 4.618 < var_49_7 and var_49_7 + var_49_6 > arg_46_1.duration_ then
				arg_46_1.duration_ = var_49_7 + var_49_6
			end

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1:AudioAction("play", "voice", "story_v_out_108041", "108041015", "story_v_out_108041.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play108041016 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 108041016
		arg_50_1.duration_ = 12.99

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play108041017(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.fswbg_:SetActive(true)
				arg_50_1.dialog_:SetActive(false)

				arg_50_1.fswtw_.percent = 0
				arg_50_1.fswt_.text = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(108041017).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.fswt_)

				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_50_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_50_1.fswtw_:SetDirty()

				arg_50_1.typewritterCharCountI18N = 0

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.var_.oldValueTypewriter = arg_50_1.fswtw_.percent

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_1 = 62
			local var_53_2 = 4.13333333333333
			local var_53_3, var_53_4 = arg_50_1:GetPercentByPara(arg_50_1:FormatText(arg_50_1:GetWordFromCfg(108041017).content), 1)

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				local var_53_5 = var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_4 - arg_50_1.typewritterCharCountI18N) / var_53_1)

				if (var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_4 - arg_50_1.typewritterCharCountI18N) / var_53_1)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_0
					end
				end
			end

			local var_53_6 = math.max(4.13333333333333, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_6 then
				arg_50_1.fswtw_.percent = Mathf.Lerp(arg_50_1.var_.oldValueTypewriter, var_53_3, (arg_50_1.time_ - var_53_0) / var_53_6)
				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.fswtw_:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_6 and arg_50_1.time_ < var_53_0 + var_53_6 + arg_53_0 then
				arg_50_1.fswtw_.percent = var_53_3

				arg_50_1.fswtw_:SetDirty()
				arg_50_1:ShowNextGo(true)

				arg_50_1.typewritterCharCountI18N = var_53_4
			end

			local var_53_7 = 0
			local var_53_8 = manager.audio:GetVoiceLength("story_v_out_108041", "108041016", "story_v_out_108041.awb") / 1000

			if var_53_8 > 0 and 12.992 < var_53_8 and var_53_8 + var_53_7 > arg_50_1.duration_ then
				arg_50_1.duration_ = var_53_8 + var_53_7
			end

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1:AudioAction("play", "voice", "story_v_out_108041", "108041016", "story_v_out_108041.awb")
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play108041017 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 108041017
		arg_54_1.duration_ = 2.76

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play108041019(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.oldValueTypewriter = arg_54_1.fswtw_.percent

				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_54_1:ShowNextGo(false)
			end

			local var_57_0 = 18
			local var_57_1 = 1.2
			local var_57_2, var_57_3 = arg_54_1:GetPercentByPara(arg_54_1:FormatText(arg_54_1:GetWordFromCfg(108041017).content), 2)

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				local var_57_4 = var_57_0 <= 0 and var_57_1 or var_57_1 * ((var_57_3 - arg_54_1.typewritterCharCountI18N) / var_57_0)

				if (var_57_0 <= 0 and var_57_1 or var_57_1 * ((var_57_3 - arg_54_1.typewritterCharCountI18N) / var_57_0)) > 0 and var_57_1 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end
			end

			local var_57_5 = math.max(1.2, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_5 then
				arg_54_1.fswtw_.percent = Mathf.Lerp(arg_54_1.var_.oldValueTypewriter, var_57_2, (arg_54_1.time_ - 0) / var_57_5)
				arg_54_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_54_1.fswtw_:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_5 and arg_54_1.time_ < 0 + var_57_5 + arg_57_0 then
				arg_54_1.fswtw_.percent = var_57_2

				arg_54_1.fswtw_:SetDirty()
				arg_54_1:ShowNextGo(true)

				arg_54_1.typewritterCharCountI18N = var_57_3
			end

			local var_57_6 = 0
			local var_57_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041017", "story_v_out_108041.awb") / 1000

			if var_57_7 > 0 and 2.763 < var_57_7 and var_57_7 + var_57_6 > arg_54_1.duration_ then
				arg_54_1.duration_ = var_57_7 + var_57_6
			end

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1:AudioAction("play", "voice", "story_v_out_108041", "108041017", "story_v_out_108041.awb")
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play108041019 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 108041019
		arg_58_1.duration_ = 2.39

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play108041020(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.oldValueTypewriter = arg_58_1.fswtw_.percent

				SetActive(arg_58_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_58_1:ShowNextGo(false)
			end

			local var_61_0 = 11
			local var_61_1 = 0.733333333333333
			local var_61_2, var_61_3 = arg_58_1:GetPercentByPara(arg_58_1:FormatText(arg_58_1:GetWordFromCfg(108041017).content), 3)

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				local var_61_4 = var_61_0 <= 0 and var_61_1 or var_61_1 * ((var_61_3 - arg_58_1.typewritterCharCountI18N) / var_61_0)

				if (var_61_0 <= 0 and var_61_1 or var_61_1 * ((var_61_3 - arg_58_1.typewritterCharCountI18N) / var_61_0)) > 0 and var_61_1 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end
			end

			local var_61_5 = math.max(0.733333333333333, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_5 then
				arg_58_1.fswtw_.percent = Mathf.Lerp(arg_58_1.var_.oldValueTypewriter, var_61_2, (arg_58_1.time_ - 0) / var_61_5)
				arg_58_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_58_1.fswtw_:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_5 and arg_58_1.time_ < 0 + var_61_5 + arg_61_0 then
				arg_58_1.fswtw_.percent = var_61_2

				arg_58_1.fswtw_:SetDirty()
				arg_58_1:ShowNextGo(true)

				arg_58_1.typewritterCharCountI18N = var_61_3
			end

			local var_61_6 = 0
			local var_61_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041019", "story_v_out_108041.awb") / 1000

			if var_61_7 > 0 and 2.389 < var_61_7 and var_61_7 + var_61_6 > arg_58_1.duration_ then
				arg_58_1.duration_ = var_61_7 + var_61_6
			end

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1:AudioAction("play", "voice", "story_v_out_108041", "108041019", "story_v_out_108041.awb")
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play108041020 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 108041020
		arg_62_1.duration_ = 5.93

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play108041021(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.oldValueTypewriter = arg_62_1.fswtw_.percent

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_0 = 32
			local var_65_1 = 2.13333333333333
			local var_65_2, var_65_3 = arg_62_1:GetPercentByPara(arg_62_1:FormatText(arg_62_1:GetWordFromCfg(108041017).content), 4)

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				local var_65_4 = var_65_0 <= 0 and var_65_1 or var_65_1 * ((var_65_3 - arg_62_1.typewritterCharCountI18N) / var_65_0)

				if (var_65_0 <= 0 and var_65_1 or var_65_1 * ((var_65_3 - arg_62_1.typewritterCharCountI18N) / var_65_0)) > 0 and var_65_1 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end
			end

			local var_65_5 = math.max(2.13333333333333, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_5 then
				arg_62_1.fswtw_.percent = Mathf.Lerp(arg_62_1.var_.oldValueTypewriter, var_65_2, (arg_62_1.time_ - 0) / var_65_5)
				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.fswtw_:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_5 and arg_62_1.time_ < 0 + var_65_5 + arg_65_0 then
				arg_62_1.fswtw_.percent = var_65_2

				arg_62_1.fswtw_:SetDirty()
				arg_62_1:ShowNextGo(true)

				arg_62_1.typewritterCharCountI18N = var_65_3
			end

			local var_65_6 = 0
			local var_65_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041020", "story_v_out_108041.awb") / 1000

			if var_65_7 > 0 and 5.926 < var_65_7 and var_65_7 + var_65_6 > arg_62_1.duration_ then
				arg_62_1.duration_ = var_65_7 + var_65_6
			end

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1:AudioAction("play", "voice", "story_v_out_108041", "108041020", "story_v_out_108041.awb")
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play108041021 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 108041021
		arg_66_1.duration_ = 1.73

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play108041022(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.oldValueTypewriter = arg_66_1.fswtw_.percent

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_0 = 26
			local var_69_1 = 1.73333333333333
			local var_69_2, var_69_3 = arg_66_1:GetPercentByPara(arg_66_1:FormatText(arg_66_1:GetWordFromCfg(108041017).content), 5)

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				local var_69_4 = var_69_0 <= 0 and var_69_1 or var_69_1 * ((var_69_3 - arg_66_1.typewritterCharCountI18N) / var_69_0)

				if (var_69_0 <= 0 and var_69_1 or var_69_1 * ((var_69_3 - arg_66_1.typewritterCharCountI18N) / var_69_0)) > 0 and var_69_1 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end
			end

			local var_69_5 = math.max(1.73333333333333, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_5 then
				arg_66_1.fswtw_.percent = Mathf.Lerp(arg_66_1.var_.oldValueTypewriter, var_69_2, (arg_66_1.time_ - 0) / var_69_5)
				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.fswtw_:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_5 and arg_66_1.time_ < 0 + var_69_5 + arg_69_0 then
				arg_66_1.fswtw_.percent = var_69_2

				arg_66_1.fswtw_:SetDirty()
				arg_66_1:ShowNextGo(true)

				arg_66_1.typewritterCharCountI18N = var_69_3
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play108041022 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 108041022
		arg_70_1.duration_ = 2.5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play108041023(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.oldValueTypewriter = arg_70_1.fswtw_.percent

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_0 = 15
			local var_73_1 = 1
			local var_73_2, var_73_3 = arg_70_1:GetPercentByPara(arg_70_1:FormatText(arg_70_1:GetWordFromCfg(108041017).content), 6)

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

			local var_73_5 = math.max(1, arg_70_1.talkMaxDuration)

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
			local var_73_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041022", "story_v_out_108041.awb") / 1000

			if var_73_7 > 0 and 2.503 < var_73_7 and var_73_7 + var_73_6 > arg_70_1.duration_ then
				arg_70_1.duration_ = var_73_7 + var_73_6
			end

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1:AudioAction("play", "voice", "story_v_out_108041", "108041022", "story_v_out_108041.awb")
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play108041023 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 108041023
		arg_74_1.duration_ = 5.29

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play108041024(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.oldValueTypewriter = arg_74_1.fswtw_.percent

				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_0 = 20
			local var_77_1 = 1.33333333333333
			local var_77_2, var_77_3 = arg_74_1:GetPercentByPara(arg_74_1:FormatText(arg_74_1:GetWordFromCfg(108041017).content), 7)

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

			local var_77_5 = math.max(1.33333333333333, arg_74_1.talkMaxDuration)

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
			local var_77_7 = manager.audio:GetVoiceLength("story_v_out_108041", "108041023", "story_v_out_108041.awb") / 1000

			if var_77_7 > 0 and 5.286 < var_77_7 and var_77_7 + var_77_6 > arg_74_1.duration_ then
				arg_74_1.duration_ = var_77_7 + var_77_6
			end

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1:AudioAction("play", "voice", "story_v_out_108041", "108041023", "story_v_out_108041.awb")
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play108041024 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 108041024
		arg_78_1.duration_ = 3.15

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play108041026(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.fswbg_:SetActive(true)
				arg_78_1.dialog_:SetActive(false)

				arg_78_1.fswtw_.percent = 0
				arg_78_1.fswt_.text = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(108041018).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.fswt_)

				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_78_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_78_1.fswtw_:SetDirty()

				arg_78_1.typewritterCharCountI18N = 0

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.var_.oldValueTypewriter = arg_78_1.fswtw_.percent

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_1 = 47
			local var_81_2 = 3.13333333333333
			local var_81_3, var_81_4 = arg_78_1:GetPercentByPara(arg_78_1:FormatText(arg_78_1:GetWordFromCfg(108041018).content), 1)

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				local var_81_5 = var_81_1 <= 0 and var_81_2 or var_81_2 * ((var_81_4 - arg_78_1.typewritterCharCountI18N) / var_81_1)

				if (var_81_1 <= 0 and var_81_2 or var_81_2 * ((var_81_4 - arg_78_1.typewritterCharCountI18N) / var_81_1)) > 0 and var_81_2 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_0
					end
				end
			end

			local var_81_6 = math.max(3.13333333333333, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_6 then
				arg_78_1.fswtw_.percent = Mathf.Lerp(arg_78_1.var_.oldValueTypewriter, var_81_3, (arg_78_1.time_ - var_81_0) / var_81_6)
				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.fswtw_:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_6 and arg_78_1.time_ < var_81_0 + var_81_6 + arg_81_0 then
				arg_78_1.fswtw_.percent = var_81_3

				arg_78_1.fswtw_:SetDirty()
				arg_78_1:ShowNextGo(true)

				arg_78_1.typewritterCharCountI18N = var_81_4
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play108041026 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 108041026
		arg_82_1.duration_ = 5.02

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play108041027(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.fswbg_:SetActive(false)
				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_0 = 0.0166666666666667
			local var_85_1 = 1.3

			if 0.0166666666666667 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_2 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_2:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(108041026).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 52 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 52)

				if (52 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 52)) > 0 and var_85_1 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5
					var_85_0 = var_85_0 + 0.3

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = var_85_0 + 0.3
			local var_85_7 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play108041027 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 108041027
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play108041028(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.575

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

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(108041027).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 23 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 23)

				if (23 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 23)) > 0 and var_91_0 < var_91_3 then
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
	Play108041028 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 108041028
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play108041029(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire", "")
			end

			local var_95_1 = 0
			local var_95_2 = 0.55

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(108041028).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 22 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 22)

				if (22 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 22)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play108041029 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 108041029
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play108041030(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.5

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

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(108041029).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 20 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 20)

				if (20 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 20)) > 0 and var_99_0 < var_99_3 then
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
	Play108041030 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 108041030
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
			arg_100_1.auto_ = false
		end

		function arg_100_1.playNext_(arg_102_0)
			arg_100_1.onStoryFinished_()
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire02", "")
			end

			local var_103_1 = 0
			local var_103_2 = 0.975

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

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(108041030).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 35 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 35)

				if (35 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 35)) > 0 and var_103_2 < var_103_5 then
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
	assets = {
		"TextureConfig/Background/S0808"
	},
	voices = {
		"story_v_out_108041.awb"
	}
}
