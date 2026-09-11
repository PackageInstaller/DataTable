return {
	Play110101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110101001
		arg_1_1.duration_ = 5.86

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play110101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(110101001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_0 = 2.01666666666667

			if 2.01666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_1 = 17
			local var_4_2 = 1.13333333333333
			local var_4_3, var_4_4 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(110101001).content), 1)

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_5 = var_4_1 <= 0 and var_4_2 or var_4_2 * ((var_4_4 - arg_1_1.typewritterCharCountI18N) / var_4_1)

				if (var_4_1 <= 0 and var_4_2 or var_4_2 * ((var_4_4 - arg_1_1.typewritterCharCountI18N) / var_4_1)) > 0 and var_4_2 < var_4_5 then
					arg_1_1.talkMaxDuration = var_4_5

					if var_4_5 + var_4_0 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_5 + var_4_0
					end
				end
			end

			local var_4_6 = math.max(1.13333333333333, arg_1_1.talkMaxDuration)

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_6 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_3, (arg_1_1.time_ - var_4_0) / var_4_6)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_0 + var_4_6 and arg_1_1.time_ < var_4_0 + var_4_6 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_3

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_4
			end

			local var_4_7 = "OS0107"

			if arg_1_1.bgs_.OS0107 == nil then
				local var_4_8 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_7)
				var_4_8.name = var_4_7
				var_4_8.transform.parent = arg_1_1.stage_.transform
				var_4_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_7] = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_9 = arg_1_1.bgs_.OS0107

				arg_1_1.bgs_.OS0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_10 = var_4_9:GetComponent("SpriteRenderer")

				if var_4_10 and var_4_10.sprite then
					local var_4_11 = 2 * (var_4_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_9.transform.localScale = Vector3.New(var_4_11 / var_4_10.sprite.bounds.size.y < var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x and var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x or var_4_11 / var_4_10.sprite.bounds.size.y, var_4_11 / var_4_10.sprite.bounds.size.y < var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x and var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x or var_4_11 / var_4_10.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "OS0107" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.bgs_.OS0107:GetComponent("SpriteRenderer")

				if var_4_12 then
					arg_1_1.var_.alphaOldValueOS0107 = var_4_12.color.a
					arg_1_1.var_.alphaMatValueOS0107 = var_4_12
				end

				arg_1_1.var_.alphaOldValueOS0107 = 0
			end

			local var_4_13 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				if arg_1_1.var_.alphaMatValueOS0107 then
					arg_1_1.var_.alphaMatValueOS0107.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueOS0107, 1, (arg_1_1.time_ - 0) / var_4_13)
					arg_1_1.var_.alphaMatValueOS0107.color = arg_1_1.var_.alphaMatValueOS0107.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and arg_1_1.var_.alphaMatValueOS0107 then
				arg_1_1.var_.alphaMatValueOS0107.color.a = 1
				arg_1_1.var_.alphaMatValueOS0107.color = arg_1_1.var_.alphaMatValueOS0107.color
			end

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_14 + 2 and arg_1_1.time_ < var_4_14 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_15 = 2
			local var_4_16 = manager.audio:GetVoiceLength("story_v_out_110101", "110101001", "story_v_out_110101.awb") / 1000

			if var_4_16 > 0 and 3.856 < var_4_16 and var_4_16 + var_4_15 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_16 + var_4_15
			end

			if var_4_15 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_110101", "110101001", "story_v_out_110101.awb")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.738461699336767 < arg_1_1.time_ and arg_1_1.time_ <= 0.738461699336767 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play110101002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 110101002
		arg_7_1.duration_ = 4.44

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play110101003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_0 = 28
			local var_10_1 = 1.86666666666667
			local var_10_2, var_10_3 = arg_7_1:GetPercentByPara(arg_7_1:FormatText(arg_7_1:GetWordFromCfg(110101001).content), 2)

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_4 = var_10_0 <= 0 and var_10_1 or var_10_1 * ((var_10_3 - arg_7_1.typewritterCharCountI18N) / var_10_0)

				if (var_10_0 <= 0 and var_10_1 or var_10_1 * ((var_10_3 - arg_7_1.typewritterCharCountI18N) / var_10_0)) > 0 and var_10_1 < var_10_4 then
					arg_7_1.talkMaxDuration = var_10_4

					if var_10_4 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_4 + 0
					end
				end
			end

			local var_10_5 = math.max(1.86666666666667, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_5 then
				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_2, (arg_7_1.time_ - 0) / var_10_5)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_5 and arg_7_1.time_ < 0 + var_10_5 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_2

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_3
			end

			local var_10_6 = 0
			local var_10_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101002", "story_v_out_110101.awb") / 1000

			if var_10_7 > 0 and 4.437 < var_10_7 and var_10_7 + var_10_6 > arg_7_1.duration_ then
				arg_7_1.duration_ = var_10_7 + var_10_6
			end

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1:AudioAction("play", "voice", "story_v_out_110101", "110101002", "story_v_out_110101.awb")
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play110101003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 110101003
		arg_11_1.duration_ = 4.43

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play110101004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_0 = 30
			local var_14_1 = 2
			local var_14_2, var_14_3 = arg_11_1:GetPercentByPara(arg_11_1:FormatText(arg_11_1:GetWordFromCfg(110101001).content), 3)

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				local var_14_4 = var_14_0 <= 0 and var_14_1 or var_14_1 * ((var_14_3 - arg_11_1.typewritterCharCountI18N) / var_14_0)

				if (var_14_0 <= 0 and var_14_1 or var_14_1 * ((var_14_3 - arg_11_1.typewritterCharCountI18N) / var_14_0)) > 0 and var_14_1 < var_14_4 then
					arg_11_1.talkMaxDuration = var_14_4

					if var_14_4 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_4 + 0
					end
				end
			end

			local var_14_5 = math.max(2, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_5 then
				arg_11_1.fswtw_.percent = Mathf.Lerp(arg_11_1.var_.oldValueTypewriter, var_14_2, (arg_11_1.time_ - 0) / var_14_5)
				arg_11_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_11_1.fswtw_:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_5 and arg_11_1.time_ < 0 + var_14_5 + arg_14_0 then
				arg_11_1.fswtw_.percent = var_14_2

				arg_11_1.fswtw_:SetDirty()
				arg_11_1:ShowNextGo(true)

				arg_11_1.typewritterCharCountI18N = var_14_3
			end

			local var_14_6 = 0
			local var_14_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101003", "story_v_out_110101.awb") / 1000

			if var_14_7 > 0 and 4.432 < var_14_7 and var_14_7 + var_14_6 > arg_11_1.duration_ then
				arg_11_1.duration_ = var_14_7 + var_14_6
			end

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1:AudioAction("play", "voice", "story_v_out_110101", "110101003", "story_v_out_110101.awb")
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play110101004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 110101004
		arg_15_1.duration_ = 4.72

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play110101005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.oldValueTypewriter = arg_15_1.fswtw_.percent

				SetActive(arg_15_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_15_1:ShowNextGo(false)
			end

			local var_18_0 = 26
			local var_18_1 = 1.73333333333333
			local var_18_2, var_18_3 = arg_15_1:GetPercentByPara(arg_15_1:FormatText(arg_15_1:GetWordFromCfg(110101001).content), 4)

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				local var_18_4 = var_18_0 <= 0 and var_18_1 or var_18_1 * ((var_18_3 - arg_15_1.typewritterCharCountI18N) / var_18_0)

				if (var_18_0 <= 0 and var_18_1 or var_18_1 * ((var_18_3 - arg_15_1.typewritterCharCountI18N) / var_18_0)) > 0 and var_18_1 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end
			end

			local var_18_5 = math.max(1.73333333333333, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_5 then
				arg_15_1.fswtw_.percent = Mathf.Lerp(arg_15_1.var_.oldValueTypewriter, var_18_2, (arg_15_1.time_ - 0) / var_18_5)
				arg_15_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_15_1.fswtw_:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_5 and arg_15_1.time_ < 0 + var_18_5 + arg_18_0 then
				arg_15_1.fswtw_.percent = var_18_2

				arg_15_1.fswtw_:SetDirty()
				arg_15_1:ShowNextGo(true)

				arg_15_1.typewritterCharCountI18N = var_18_3
			end

			local var_18_6 = 0
			local var_18_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101004", "story_v_out_110101.awb") / 1000

			if var_18_7 > 0 and 4.718 < var_18_7 and var_18_7 + var_18_6 > arg_15_1.duration_ then
				arg_15_1.duration_ = var_18_7 + var_18_6
			end

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1:AudioAction("play", "voice", "story_v_out_110101", "110101004", "story_v_out_110101.awb")
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play110101005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 110101005
		arg_19_1.duration_ = 9.42

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play110101006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.oldValueTypewriter = arg_19_1.fswtw_.percent

				SetActive(arg_19_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_19_1:ShowNextGo(false)
			end

			local var_22_0 = 41
			local var_22_1 = 2.73333333333333
			local var_22_2, var_22_3 = arg_19_1:GetPercentByPara(arg_19_1:FormatText(arg_19_1:GetWordFromCfg(110101001).content), 5)

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				local var_22_4 = var_22_0 <= 0 and var_22_1 or var_22_1 * ((var_22_3 - arg_19_1.typewritterCharCountI18N) / var_22_0)

				if (var_22_0 <= 0 and var_22_1 or var_22_1 * ((var_22_3 - arg_19_1.typewritterCharCountI18N) / var_22_0)) > 0 and var_22_1 < var_22_4 then
					arg_19_1.talkMaxDuration = var_22_4

					if var_22_4 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_4 + 0
					end
				end
			end

			local var_22_5 = math.max(2.73333333333333, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_5 then
				arg_19_1.fswtw_.percent = Mathf.Lerp(arg_19_1.var_.oldValueTypewriter, var_22_2, (arg_19_1.time_ - 0) / var_22_5)
				arg_19_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_19_1.fswtw_:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_5 and arg_19_1.time_ < 0 + var_22_5 + arg_22_0 then
				arg_19_1.fswtw_.percent = var_22_2

				arg_19_1.fswtw_:SetDirty()
				arg_19_1:ShowNextGo(true)

				arg_19_1.typewritterCharCountI18N = var_22_3
			end

			local var_22_6 = 0
			local var_22_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101005", "story_v_out_110101.awb") / 1000

			if var_22_7 > 0 and 9.418 < var_22_7 and var_22_7 + var_22_6 > arg_19_1.duration_ then
				arg_19_1.duration_ = var_22_7 + var_22_6
			end

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1:AudioAction("play", "voice", "story_v_out_110101", "110101005", "story_v_out_110101.awb")
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play110101006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 110101006
		arg_23_1.duration_ = 6.86

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play110101007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.oldValueTypewriter = arg_23_1.fswtw_.percent

				SetActive(arg_23_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_23_1:ShowNextGo(false)
			end

			local var_26_0 = 26
			local var_26_1 = 1.73333333333333
			local var_26_2, var_26_3 = arg_23_1:GetPercentByPara(arg_23_1:FormatText(arg_23_1:GetWordFromCfg(110101001).content), 6)

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				local var_26_4 = var_26_0 <= 0 and var_26_1 or var_26_1 * ((var_26_3 - arg_23_1.typewritterCharCountI18N) / var_26_0)

				if (var_26_0 <= 0 and var_26_1 or var_26_1 * ((var_26_3 - arg_23_1.typewritterCharCountI18N) / var_26_0)) > 0 and var_26_1 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end
			end

			local var_26_5 = math.max(1.73333333333333, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_5 then
				arg_23_1.fswtw_.percent = Mathf.Lerp(arg_23_1.var_.oldValueTypewriter, var_26_2, (arg_23_1.time_ - 0) / var_26_5)
				arg_23_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_23_1.fswtw_:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_5 and arg_23_1.time_ < 0 + var_26_5 + arg_26_0 then
				arg_23_1.fswtw_.percent = var_26_2

				arg_23_1.fswtw_:SetDirty()
				arg_23_1:ShowNextGo(true)

				arg_23_1.typewritterCharCountI18N = var_26_3
			end

			local var_26_6 = 0
			local var_26_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101006", "story_v_out_110101.awb") / 1000

			if var_26_7 > 0 and 6.856 < var_26_7 and var_26_7 + var_26_6 > arg_23_1.duration_ then
				arg_23_1.duration_ = var_26_7 + var_26_6
			end

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1:AudioAction("play", "voice", "story_v_out_110101", "110101006", "story_v_out_110101.awb")
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play110101007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 110101007
		arg_27_1.duration_ = 6.45

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play110101008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.oldValueTypewriter = arg_27_1.fswtw_.percent

				SetActive(arg_27_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_27_1:ShowNextGo(false)
			end

			local var_30_0 = 30
			local var_30_1 = 2
			local var_30_2, var_30_3 = arg_27_1:GetPercentByPara(arg_27_1:FormatText(arg_27_1:GetWordFromCfg(110101001).content), 7)

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				local var_30_4 = var_30_0 <= 0 and var_30_1 or var_30_1 * ((var_30_3 - arg_27_1.typewritterCharCountI18N) / var_30_0)

				if (var_30_0 <= 0 and var_30_1 or var_30_1 * ((var_30_3 - arg_27_1.typewritterCharCountI18N) / var_30_0)) > 0 and var_30_1 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end
			end

			local var_30_5 = math.max(2, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 then
				arg_27_1.fswtw_.percent = Mathf.Lerp(arg_27_1.var_.oldValueTypewriter, var_30_2, (arg_27_1.time_ - 0) / var_30_5)
				arg_27_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_27_1.fswtw_:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 then
				arg_27_1.fswtw_.percent = var_30_2

				arg_27_1.fswtw_:SetDirty()
				arg_27_1:ShowNextGo(true)

				arg_27_1.typewritterCharCountI18N = var_30_3
			end

			local var_30_6 = 0
			local var_30_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101007", "story_v_out_110101.awb") / 1000

			if var_30_7 > 0 and 6.453 < var_30_7 and var_30_7 + var_30_6 > arg_27_1.duration_ then
				arg_27_1.duration_ = var_30_7 + var_30_6
			end

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1:AudioAction("play", "voice", "story_v_out_110101", "110101007", "story_v_out_110101.awb")
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play110101008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 110101008
		arg_31_1.duration_ = 4.99

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play110101009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.fswbg_:SetActive(true)
				arg_31_1.dialog_:SetActive(false)

				arg_31_1.fswtw_.percent = 0
				arg_31_1.fswt_.text = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(110101008).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.fswt_)

				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_31_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_31_1.fswtw_:SetDirty()

				arg_31_1.typewritterCharCountI18N = 0

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.var_.oldValueTypewriter = arg_31_1.fswtw_.percent

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_1 = 25
			local var_34_2 = 1.66666666666667
			local var_34_3, var_34_4 = arg_31_1:GetPercentByPara(arg_31_1:FormatText(arg_31_1:GetWordFromCfg(110101008).content), 1)

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				local var_34_5 = var_34_1 <= 0 and var_34_2 or var_34_2 * ((var_34_4 - arg_31_1.typewritterCharCountI18N) / var_34_1)

				if (var_34_1 <= 0 and var_34_2 or var_34_2 * ((var_34_4 - arg_31_1.typewritterCharCountI18N) / var_34_1)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_0
					end
				end
			end

			local var_34_6 = math.max(1.66666666666667, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_6 then
				arg_31_1.fswtw_.percent = Mathf.Lerp(arg_31_1.var_.oldValueTypewriter, var_34_3, (arg_31_1.time_ - var_34_0) / var_34_6)
				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_31_1.fswtw_:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_6 and arg_31_1.time_ < var_34_0 + var_34_6 + arg_34_0 then
				arg_31_1.fswtw_.percent = var_34_3

				arg_31_1.fswtw_:SetDirty()
				arg_31_1:ShowNextGo(true)

				arg_31_1.typewritterCharCountI18N = var_34_4
			end

			local var_34_7 = 0
			local var_34_8 = manager.audio:GetVoiceLength("story_v_out_110101", "110101008", "story_v_out_110101.awb") / 1000

			if var_34_8 > 0 and 4.992 < var_34_8 and var_34_8 + var_34_7 > arg_31_1.duration_ then
				arg_31_1.duration_ = var_34_8 + var_34_7
			end

			if var_34_7 < arg_31_1.time_ and arg_31_1.time_ <= var_34_7 + arg_34_0 then
				arg_31_1:AudioAction("play", "voice", "story_v_out_110101", "110101008", "story_v_out_110101.awb")
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play110101009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 110101009
		arg_35_1.duration_ = 5.4

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play110101010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.oldValueTypewriter = arg_35_1.fswtw_.percent

				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_0 = 26
			local var_38_1 = 1.73333333333333
			local var_38_2, var_38_3 = arg_35_1:GetPercentByPara(arg_35_1:FormatText(arg_35_1:GetWordFromCfg(110101008).content), 2)

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				local var_38_4 = var_38_0 <= 0 and var_38_1 or var_38_1 * ((var_38_3 - arg_35_1.typewritterCharCountI18N) / var_38_0)

				if (var_38_0 <= 0 and var_38_1 or var_38_1 * ((var_38_3 - arg_35_1.typewritterCharCountI18N) / var_38_0)) > 0 and var_38_1 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end
			end

			local var_38_5 = math.max(1.73333333333333, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 then
				arg_35_1.fswtw_.percent = Mathf.Lerp(arg_35_1.var_.oldValueTypewriter, var_38_2, (arg_35_1.time_ - 0) / var_38_5)
				arg_35_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_35_1.fswtw_:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 then
				arg_35_1.fswtw_.percent = var_38_2

				arg_35_1.fswtw_:SetDirty()
				arg_35_1:ShowNextGo(true)

				arg_35_1.typewritterCharCountI18N = var_38_3
			end

			local var_38_6 = 0
			local var_38_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101009", "story_v_out_110101.awb") / 1000

			if var_38_7 > 0 and 5.402 < var_38_7 and var_38_7 + var_38_6 > arg_35_1.duration_ then
				arg_35_1.duration_ = var_38_7 + var_38_6
			end

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1:AudioAction("play", "voice", "story_v_out_110101", "110101009", "story_v_out_110101.awb")
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play110101010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 110101010
		arg_39_1.duration_ = 5.41

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play110101011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.oldValueTypewriter = arg_39_1.fswtw_.percent

				SetActive(arg_39_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_39_1:ShowNextGo(false)
			end

			local var_42_0 = 28
			local var_42_1 = 1.86666666666667
			local var_42_2, var_42_3 = arg_39_1:GetPercentByPara(arg_39_1:FormatText(arg_39_1:GetWordFromCfg(110101008).content), 3)

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				local var_42_4 = var_42_0 <= 0 and var_42_1 or var_42_1 * ((var_42_3 - arg_39_1.typewritterCharCountI18N) / var_42_0)

				if (var_42_0 <= 0 and var_42_1 or var_42_1 * ((var_42_3 - arg_39_1.typewritterCharCountI18N) / var_42_0)) > 0 and var_42_1 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end
			end

			local var_42_5 = math.max(1.86666666666667, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				arg_39_1.fswtw_.percent = Mathf.Lerp(arg_39_1.var_.oldValueTypewriter, var_42_2, (arg_39_1.time_ - 0) / var_42_5)
				arg_39_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_39_1.fswtw_:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				arg_39_1.fswtw_.percent = var_42_2

				arg_39_1.fswtw_:SetDirty()
				arg_39_1:ShowNextGo(true)

				arg_39_1.typewritterCharCountI18N = var_42_3
			end

			local var_42_6 = 0
			local var_42_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101010", "story_v_out_110101.awb") / 1000

			if var_42_7 > 0 and 5.413 < var_42_7 and var_42_7 + var_42_6 > arg_39_1.duration_ then
				arg_39_1.duration_ = var_42_7 + var_42_6
			end

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1:AudioAction("play", "voice", "story_v_out_110101", "110101010", "story_v_out_110101.awb")
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play110101011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 110101011
		arg_43_1.duration_ = 4.31

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play110101012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.oldValueTypewriter = arg_43_1.fswtw_.percent

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_0 = 21
			local var_46_1 = 1.4
			local var_46_2, var_46_3 = arg_43_1:GetPercentByPara(arg_43_1:FormatText(arg_43_1:GetWordFromCfg(110101008).content), 4)

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				local var_46_4 = var_46_0 <= 0 and var_46_1 or var_46_1 * ((var_46_3 - arg_43_1.typewritterCharCountI18N) / var_46_0)

				if (var_46_0 <= 0 and var_46_1 or var_46_1 * ((var_46_3 - arg_43_1.typewritterCharCountI18N) / var_46_0)) > 0 and var_46_1 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end
			end

			local var_46_5 = math.max(1.4, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 then
				arg_43_1.fswtw_.percent = Mathf.Lerp(arg_43_1.var_.oldValueTypewriter, var_46_2, (arg_43_1.time_ - 0) / var_46_5)
				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.fswtw_:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 then
				arg_43_1.fswtw_.percent = var_46_2

				arg_43_1.fswtw_:SetDirty()
				arg_43_1:ShowNextGo(true)

				arg_43_1.typewritterCharCountI18N = var_46_3
			end

			local var_46_6 = 0
			local var_46_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101011", "story_v_out_110101.awb") / 1000

			if var_46_7 > 0 and 4.312 < var_46_7 and var_46_7 + var_46_6 > arg_43_1.duration_ then
				arg_43_1.duration_ = var_46_7 + var_46_6
			end

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1:AudioAction("play", "voice", "story_v_out_110101", "110101011", "story_v_out_110101.awb")
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play110101012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 110101012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play110101013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.oldValueTypewriter = arg_47_1.fswtw_.percent

				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_47_1:ShowNextGo(false)
			end

			local var_50_0 = 32
			local var_50_1 = 2.13333333333333
			local var_50_2, var_50_3 = arg_47_1:GetPercentByPara(arg_47_1:FormatText(arg_47_1:GetWordFromCfg(110101008).content), 5)

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				local var_50_4 = var_50_0 <= 0 and var_50_1 or var_50_1 * ((var_50_3 - arg_47_1.typewritterCharCountI18N) / var_50_0)

				if (var_50_0 <= 0 and var_50_1 or var_50_1 * ((var_50_3 - arg_47_1.typewritterCharCountI18N) / var_50_0)) > 0 and var_50_1 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end
			end

			local var_50_5 = math.max(2.13333333333333, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 then
				arg_47_1.fswtw_.percent = Mathf.Lerp(arg_47_1.var_.oldValueTypewriter, var_50_2, (arg_47_1.time_ - 0) / var_50_5)
				arg_47_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_47_1.fswtw_:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 then
				arg_47_1.fswtw_.percent = var_50_2

				arg_47_1.fswtw_:SetDirty()
				arg_47_1:ShowNextGo(true)

				arg_47_1.typewritterCharCountI18N = var_50_3
			end

			local var_50_6 = 0
			local var_50_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101012", "story_v_out_110101.awb") / 1000

			if var_50_7 > 0 and 5.002 < var_50_7 and var_50_7 + var_50_6 > arg_47_1.duration_ then
				arg_47_1.duration_ = var_50_7 + var_50_6
			end

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1:AudioAction("play", "voice", "story_v_out_110101", "110101012", "story_v_out_110101.awb")
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play110101013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 110101013
		arg_51_1.duration_ = 8.69

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play110101014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.oldValueTypewriter = arg_51_1.fswtw_.percent

				SetActive(arg_51_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_51_1:ShowNextGo(false)
			end

			local var_54_0 = 35
			local var_54_1 = 2.33333333333333
			local var_54_2, var_54_3 = arg_51_1:GetPercentByPara(arg_51_1:FormatText(arg_51_1:GetWordFromCfg(110101008).content), 6)

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				local var_54_4 = var_54_0 <= 0 and var_54_1 or var_54_1 * ((var_54_3 - arg_51_1.typewritterCharCountI18N) / var_54_0)

				if (var_54_0 <= 0 and var_54_1 or var_54_1 * ((var_54_3 - arg_51_1.typewritterCharCountI18N) / var_54_0)) > 0 and var_54_1 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end
			end

			local var_54_5 = math.max(2.33333333333333, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 then
				arg_51_1.fswtw_.percent = Mathf.Lerp(arg_51_1.var_.oldValueTypewriter, var_54_2, (arg_51_1.time_ - 0) / var_54_5)
				arg_51_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_51_1.fswtw_:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 then
				arg_51_1.fswtw_.percent = var_54_2

				arg_51_1.fswtw_:SetDirty()
				arg_51_1:ShowNextGo(true)

				arg_51_1.typewritterCharCountI18N = var_54_3
			end

			local var_54_6 = 0
			local var_54_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101013", "story_v_out_110101.awb") / 1000

			if var_54_7 > 0 and 8.688 < var_54_7 and var_54_7 + var_54_6 > arg_51_1.duration_ then
				arg_51_1.duration_ = var_54_7 + var_54_6
			end

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1:AudioAction("play", "voice", "story_v_out_110101", "110101013", "story_v_out_110101.awb")
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play110101014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 110101014
		arg_55_1.duration_ = 7.93

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play110101015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.oldValueTypewriter = arg_55_1.fswtw_.percent

				SetActive(arg_55_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_55_1:ShowNextGo(false)
			end

			local var_58_0 = 27
			local var_58_1 = 1.8
			local var_58_2, var_58_3 = arg_55_1:GetPercentByPara(arg_55_1:FormatText(arg_55_1:GetWordFromCfg(110101008).content), 7)

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				local var_58_4 = var_58_0 <= 0 and var_58_1 or var_58_1 * ((var_58_3 - arg_55_1.typewritterCharCountI18N) / var_58_0)

				if (var_58_0 <= 0 and var_58_1 or var_58_1 * ((var_58_3 - arg_55_1.typewritterCharCountI18N) / var_58_0)) > 0 and var_58_1 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end
			end

			local var_58_5 = math.max(1.8, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 then
				arg_55_1.fswtw_.percent = Mathf.Lerp(arg_55_1.var_.oldValueTypewriter, var_58_2, (arg_55_1.time_ - 0) / var_58_5)
				arg_55_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_55_1.fswtw_:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 then
				arg_55_1.fswtw_.percent = var_58_2

				arg_55_1.fswtw_:SetDirty()
				arg_55_1:ShowNextGo(true)

				arg_55_1.typewritterCharCountI18N = var_58_3
			end

			local var_58_6 = 0
			local var_58_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101014", "story_v_out_110101.awb") / 1000

			if var_58_7 > 0 and 7.933 < var_58_7 and var_58_7 + var_58_6 > arg_55_1.duration_ then
				arg_55_1.duration_ = var_58_7 + var_58_6
			end

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1:AudioAction("play", "voice", "story_v_out_110101", "110101014", "story_v_out_110101.awb")
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play110101015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 110101015
		arg_59_1.duration_ = 5.95

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play110101016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.fswbg_:SetActive(true)
				arg_59_1.dialog_:SetActive(false)

				arg_59_1.fswtw_.percent = 0
				arg_59_1.fswt_.text = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(110101015).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.fswt_)

				arg_59_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_59_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_59_1.fswtw_:SetDirty()

				arg_59_1.typewritterCharCountI18N = 0

				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			local var_62_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.var_.oldValueTypewriter = arg_59_1.fswtw_.percent

				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			local var_62_1 = 27
			local var_62_2 = 1.8
			local var_62_3, var_62_4 = arg_59_1:GetPercentByPara(arg_59_1:FormatText(arg_59_1:GetWordFromCfg(110101015).content), 1)

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				local var_62_5 = var_62_1 <= 0 and var_62_2 or var_62_2 * ((var_62_4 - arg_59_1.typewritterCharCountI18N) / var_62_1)

				if (var_62_1 <= 0 and var_62_2 or var_62_2 * ((var_62_4 - arg_59_1.typewritterCharCountI18N) / var_62_1)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_0
					end
				end
			end

			local var_62_6 = math.max(1.8, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_6 then
				arg_59_1.fswtw_.percent = Mathf.Lerp(arg_59_1.var_.oldValueTypewriter, var_62_3, (arg_59_1.time_ - var_62_0) / var_62_6)
				arg_59_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_59_1.fswtw_:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_6 and arg_59_1.time_ < var_62_0 + var_62_6 + arg_62_0 then
				arg_59_1.fswtw_.percent = var_62_3

				arg_59_1.fswtw_:SetDirty()
				arg_59_1:ShowNextGo(true)

				arg_59_1.typewritterCharCountI18N = var_62_4
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_7 = arg_59_1.bgs_.OS0107:GetComponent("SpriteRenderer")

				if var_62_7 then
					arg_59_1.var_.alphaOldValueOS0107 = var_62_7.color.a
					arg_59_1.var_.alphaMatValueOS0107 = var_62_7
				end

				arg_59_1.var_.alphaOldValueOS0107 = 1
			end

			local var_62_8 = 0.75

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_8 then
				if arg_59_1.var_.alphaMatValueOS0107 then
					arg_59_1.var_.alphaMatValueOS0107.color.a = Mathf.Lerp(arg_59_1.var_.alphaOldValueOS0107, 0, (arg_59_1.time_ - 0) / var_62_8)
					arg_59_1.var_.alphaMatValueOS0107.color = arg_59_1.var_.alphaMatValueOS0107.color
				end
			end

			if arg_59_1.time_ >= 0 + var_62_8 and arg_59_1.time_ < 0 + var_62_8 + arg_62_0 and arg_59_1.var_.alphaMatValueOS0107 then
				arg_59_1.var_.alphaMatValueOS0107.color.a = 0
				arg_59_1.var_.alphaMatValueOS0107.color = arg_59_1.var_.alphaMatValueOS0107.color
			end

			if 1 < arg_59_1.time_ and arg_59_1.time_ <= 1 + arg_62_0 then
				local var_62_9 = arg_59_1.bgs_.OS0107:GetComponent("SpriteRenderer")

				if var_62_9 then
					arg_59_1.var_.alphaOldValueOS0107 = var_62_9.color.a
					arg_59_1.var_.alphaMatValueOS0107 = var_62_9
				end

				arg_59_1.var_.alphaOldValueOS0107 = 0
			end

			local var_62_10 = 0.75

			if 1 <= arg_59_1.time_ and arg_59_1.time_ < 1 + var_62_10 then
				if arg_59_1.var_.alphaMatValueOS0107 then
					arg_59_1.var_.alphaMatValueOS0107.color.a = Mathf.Lerp(arg_59_1.var_.alphaOldValueOS0107, 1, (arg_59_1.time_ - 1) / var_62_10)
					arg_59_1.var_.alphaMatValueOS0107.color = arg_59_1.var_.alphaMatValueOS0107.color
				end
			end

			if arg_59_1.time_ >= 1 + var_62_10 and arg_59_1.time_ < 1 + var_62_10 + arg_62_0 and arg_59_1.var_.alphaMatValueOS0107 then
				arg_59_1.var_.alphaMatValueOS0107.color.a = 1
				arg_59_1.var_.alphaMatValueOS0107.color = arg_59_1.var_.alphaMatValueOS0107.color
			end

			local var_62_11 = 0
			local var_62_12 = manager.audio:GetVoiceLength("story_v_out_110101", "110101015", "story_v_out_110101.awb") / 1000

			if var_62_12 > 0 and 5.952 < var_62_12 and var_62_12 + var_62_11 > arg_59_1.duration_ then
				arg_59_1.duration_ = var_62_12 + var_62_11
			end

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				arg_59_1:AudioAction("play", "voice", "story_v_out_110101", "110101015", "story_v_out_110101.awb")
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play110101016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 110101016
		arg_63_1.duration_ = 9.56

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play110101017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.oldValueTypewriter = arg_63_1.fswtw_.percent

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_0 = 38
			local var_66_1 = 2.53333333333333
			local var_66_2, var_66_3 = arg_63_1:GetPercentByPara(arg_63_1:FormatText(arg_63_1:GetWordFromCfg(110101015).content), 2)

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				local var_66_4 = var_66_0 <= 0 and var_66_1 or var_66_1 * ((var_66_3 - arg_63_1.typewritterCharCountI18N) / var_66_0)

				if (var_66_0 <= 0 and var_66_1 or var_66_1 * ((var_66_3 - arg_63_1.typewritterCharCountI18N) / var_66_0)) > 0 and var_66_1 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end
			end

			local var_66_5 = math.max(2.53333333333333, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_5 then
				arg_63_1.fswtw_.percent = Mathf.Lerp(arg_63_1.var_.oldValueTypewriter, var_66_2, (arg_63_1.time_ - 0) / var_66_5)
				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_63_1.fswtw_:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_5 and arg_63_1.time_ < 0 + var_66_5 + arg_66_0 then
				arg_63_1.fswtw_.percent = var_66_2

				arg_63_1.fswtw_:SetDirty()
				arg_63_1:ShowNextGo(true)

				arg_63_1.typewritterCharCountI18N = var_66_3
			end

			local var_66_6 = 0
			local var_66_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101016", "story_v_out_110101.awb") / 1000

			if var_66_7 > 0 and 9.562 < var_66_7 and var_66_7 + var_66_6 > arg_63_1.duration_ then
				arg_63_1.duration_ = var_66_7 + var_66_6
			end

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1:AudioAction("play", "voice", "story_v_out_110101", "110101016", "story_v_out_110101.awb")
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play110101017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 110101017
		arg_67_1.duration_ = 2.5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play110101018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.oldValueTypewriter = arg_67_1.fswtw_.percent

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_0 = 11
			local var_70_1 = 0.733333333333333
			local var_70_2, var_70_3 = arg_67_1:GetPercentByPara(arg_67_1:FormatText(arg_67_1:GetWordFromCfg(110101015).content), 3)

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				local var_70_4 = var_70_0 <= 0 and var_70_1 or var_70_1 * ((var_70_3 - arg_67_1.typewritterCharCountI18N) / var_70_0)

				if (var_70_0 <= 0 and var_70_1 or var_70_1 * ((var_70_3 - arg_67_1.typewritterCharCountI18N) / var_70_0)) > 0 and var_70_1 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end
			end

			local var_70_5 = math.max(0.733333333333333, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 then
				arg_67_1.fswtw_.percent = Mathf.Lerp(arg_67_1.var_.oldValueTypewriter, var_70_2, (arg_67_1.time_ - 0) / var_70_5)
				arg_67_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_67_1.fswtw_:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 then
				arg_67_1.fswtw_.percent = var_70_2

				arg_67_1.fswtw_:SetDirty()
				arg_67_1:ShowNextGo(true)

				arg_67_1.typewritterCharCountI18N = var_70_3
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				local var_70_6 = arg_67_1.bgs_.OS0107:GetComponent("SpriteRenderer")

				if var_70_6 then
					arg_67_1.var_.alphaOldValueOS0107 = var_70_6.color.a
					arg_67_1.var_.alphaMatValueOS0107 = var_70_6
				end

				arg_67_1.var_.alphaOldValueOS0107 = 1
			end

			local var_70_7 = 1

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				if arg_67_1.var_.alphaMatValueOS0107 then
					arg_67_1.var_.alphaMatValueOS0107.color.a = Mathf.Lerp(arg_67_1.var_.alphaOldValueOS0107, 0, (arg_67_1.time_ - 0) / var_70_7)
					arg_67_1.var_.alphaMatValueOS0107.color = arg_67_1.var_.alphaMatValueOS0107.color
				end
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 and arg_67_1.var_.alphaMatValueOS0107 then
				arg_67_1.var_.alphaMatValueOS0107.color.a = 0
				arg_67_1.var_.alphaMatValueOS0107.color = arg_67_1.var_.alphaMatValueOS0107.color
			end

			if 1.5 < arg_67_1.time_ and arg_67_1.time_ <= 1.5 + arg_70_0 then
				local var_70_8 = arg_67_1.bgs_.OS0107:GetComponent("SpriteRenderer")

				if var_70_8 then
					arg_67_1.var_.alphaOldValueOS0107 = var_70_8.color.a
					arg_67_1.var_.alphaMatValueOS0107 = var_70_8
				end

				arg_67_1.var_.alphaOldValueOS0107 = 0
			end

			local var_70_9 = 1

			if 1.5 <= arg_67_1.time_ and arg_67_1.time_ < 1.5 + var_70_9 then
				if arg_67_1.var_.alphaMatValueOS0107 then
					arg_67_1.var_.alphaMatValueOS0107.color.a = Mathf.Lerp(arg_67_1.var_.alphaOldValueOS0107, 1, (arg_67_1.time_ - 1.5) / var_70_9)
					arg_67_1.var_.alphaMatValueOS0107.color = arg_67_1.var_.alphaMatValueOS0107.color
				end
			end

			if arg_67_1.time_ >= 1.5 + var_70_9 and arg_67_1.time_ < 1.5 + var_70_9 + arg_70_0 and arg_67_1.var_.alphaMatValueOS0107 then
				arg_67_1.var_.alphaMatValueOS0107.color.a = 1
				arg_67_1.var_.alphaMatValueOS0107.color = arg_67_1.var_.alphaMatValueOS0107.color
			end

			local var_70_10 = 0
			local var_70_11 = manager.audio:GetVoiceLength("story_v_out_110101", "110101017", "story_v_out_110101.awb") / 1000

			if var_70_11 > 0 and 1.491 < var_70_11 and var_70_11 + var_70_10 > arg_67_1.duration_ then
				arg_67_1.duration_ = var_70_11 + var_70_10
			end

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1:AudioAction("play", "voice", "story_v_out_110101", "110101017", "story_v_out_110101.awb")
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play110101018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 110101018
		arg_71_1.duration_ = 3.01

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play110101019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.oldValueTypewriter = arg_71_1.fswtw_.percent

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_0 = 15
			local var_74_1 = 1
			local var_74_2, var_74_3 = arg_71_1:GetPercentByPara(arg_71_1:FormatText(arg_71_1:GetWordFromCfg(110101015).content), 4)

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				local var_74_4 = var_74_0 <= 0 and var_74_1 or var_74_1 * ((var_74_3 - arg_71_1.typewritterCharCountI18N) / var_74_0)

				if (var_74_0 <= 0 and var_74_1 or var_74_1 * ((var_74_3 - arg_71_1.typewritterCharCountI18N) / var_74_0)) > 0 and var_74_1 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end
			end

			local var_74_5 = math.max(1, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 then
				arg_71_1.fswtw_.percent = Mathf.Lerp(arg_71_1.var_.oldValueTypewriter, var_74_2, (arg_71_1.time_ - 0) / var_74_5)
				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.fswtw_:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 then
				arg_71_1.fswtw_.percent = var_74_2

				arg_71_1.fswtw_:SetDirty()
				arg_71_1:ShowNextGo(true)

				arg_71_1.typewritterCharCountI18N = var_74_3
			end

			local var_74_6 = 0
			local var_74_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101018", "story_v_out_110101.awb") / 1000

			if var_74_7 > 0 and 3.008 < var_74_7 and var_74_7 + var_74_6 > arg_71_1.duration_ then
				arg_71_1.duration_ = var_74_7 + var_74_6
			end

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1:AudioAction("play", "voice", "story_v_out_110101", "110101018", "story_v_out_110101.awb")
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play110101019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 110101019
		arg_75_1.duration_ = 5.98

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play110101020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_0 = 22
			local var_78_1 = 1.46666666666667
			local var_78_2, var_78_3 = arg_75_1:GetPercentByPara(arg_75_1:FormatText(arg_75_1:GetWordFromCfg(110101015).content), 5)

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_4 = var_78_0 <= 0 and var_78_1 or var_78_1 * ((var_78_3 - arg_75_1.typewritterCharCountI18N) / var_78_0)

				if (var_78_0 <= 0 and var_78_1 or var_78_1 * ((var_78_3 - arg_75_1.typewritterCharCountI18N) / var_78_0)) > 0 and var_78_1 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end
			end

			local var_78_5 = math.max(1.46666666666667, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 then
				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_2, (arg_75_1.time_ - 0) / var_78_5)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_2

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_3
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_6 = arg_75_1.bgs_.OS0107:GetComponent("SpriteRenderer")

				if var_78_6 then
					arg_75_1.var_.alphaOldValueOS0107 = var_78_6.color.a
					arg_75_1.var_.alphaMatValueOS0107 = var_78_6
				end

				arg_75_1.var_.alphaOldValueOS0107 = 1
			end

			local var_78_7 = 2.5

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				if arg_75_1.var_.alphaMatValueOS0107 then
					arg_75_1.var_.alphaMatValueOS0107.color.a = Mathf.Lerp(arg_75_1.var_.alphaOldValueOS0107, 0, (arg_75_1.time_ - 0) / var_78_7)
					arg_75_1.var_.alphaMatValueOS0107.color = arg_75_1.var_.alphaMatValueOS0107.color
				end
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 and arg_75_1.var_.alphaMatValueOS0107 then
				arg_75_1.var_.alphaMatValueOS0107.color.a = 0
				arg_75_1.var_.alphaMatValueOS0107.color = arg_75_1.var_.alphaMatValueOS0107.color
			end

			local var_78_8 = 0
			local var_78_9 = manager.audio:GetVoiceLength("story_v_out_110101", "110101019", "story_v_out_110101.awb") / 1000

			if var_78_9 > 0 and 5.984 < var_78_9 and var_78_9 + var_78_8 > arg_75_1.duration_ then
				arg_75_1.duration_ = var_78_9 + var_78_8
			end

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1:AudioAction("play", "voice", "story_v_out_110101", "110101019", "story_v_out_110101.awb")
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play110101020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 110101020
		arg_79_1.duration_ = 5.66

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
			arg_79_1.auto_ = false
		end

		function arg_79_1.playNext_(arg_81_0)
			arg_79_1.onStoryFinished_()
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.oldValueTypewriter = arg_79_1.fswtw_.percent

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_0 = 27
			local var_82_1 = 1.8
			local var_82_2, var_82_3 = arg_79_1:GetPercentByPara(arg_79_1:FormatText(arg_79_1:GetWordFromCfg(110101015).content), 6)

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				local var_82_4 = var_82_0 <= 0 and var_82_1 or var_82_1 * ((var_82_3 - arg_79_1.typewritterCharCountI18N) / var_82_0)

				if (var_82_0 <= 0 and var_82_1 or var_82_1 * ((var_82_3 - arg_79_1.typewritterCharCountI18N) / var_82_0)) > 0 and var_82_1 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end
			end

			local var_82_5 = math.max(1.8, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 then
				arg_79_1.fswtw_.percent = Mathf.Lerp(arg_79_1.var_.oldValueTypewriter, var_82_2, (arg_79_1.time_ - 0) / var_82_5)
				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_79_1.fswtw_:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 then
				arg_79_1.fswtw_.percent = var_82_2

				arg_79_1.fswtw_:SetDirty()
				arg_79_1:ShowNextGo(true)

				arg_79_1.typewritterCharCountI18N = var_82_3
			end

			local var_82_6 = 0
			local var_82_7 = manager.audio:GetVoiceLength("story_v_out_110101", "110101020", "story_v_out_110101.awb") / 1000

			if var_82_7 > 0 and 5.663 < var_82_7 and var_82_7 + var_82_6 > arg_79_1.duration_ then
				arg_79_1.duration_ = var_82_7 + var_82_6
			end

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1:AudioAction("play", "voice", "story_v_out_110101", "110101020", "story_v_out_110101.awb")
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OS0107"
	},
	voices = {
		"story_v_out_110101.awb"
	}
}
