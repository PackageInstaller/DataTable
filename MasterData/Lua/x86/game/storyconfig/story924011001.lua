return {
	Play924011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 924011001
		arg_1_1.duration_ = 3.47

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play924011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_["STblack "] == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack ")
				var_4_0.name = "STblack "
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_["STblack "] = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_["STblack "]

				arg_1_1.bgs_["STblack "].transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack " then
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
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(924011001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_10 = 22
			local var_4_11 = 1.46666666666667
			local var_4_12, var_4_13 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(924011001).content), 1)

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_14 = var_4_10 <= 0 and var_4_11 or var_4_11 * ((var_4_13 - arg_1_1.typewritterCharCountI18N) / var_4_10)

				if (var_4_10 <= 0 and var_4_11 or var_4_11 * ((var_4_13 - arg_1_1.typewritterCharCountI18N) / var_4_10)) > 0 and var_4_11 < var_4_14 then
					arg_1_1.talkMaxDuration = var_4_14

					if var_4_14 + var_4_9 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_14 + var_4_9
					end
				end
			end

			local var_4_15 = math.max(1.46666666666667, arg_1_1.talkMaxDuration)

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_15 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_12, (arg_1_1.time_ - var_4_9) / var_4_15)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_9 + var_4_15 and arg_1_1.time_ < var_4_9 + var_4_15 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_12

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_13
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_16 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_17 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_18 = var_4_16:GetComponent("RectTransform")

				var_4_16:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_18.offsetMin = Vector2.New(0, 0)
				var_4_18.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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
	Play924011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 924011002
		arg_6_1.duration_ = 3.93

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play924011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 1 < arg_6_1.time_ and arg_6_1.time_ <= 1 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 44
			local var_9_1 = 2.93333333333333
			local var_9_2, var_9_3 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(924011001).content), 2)

			if 1 < arg_6_1.time_ and arg_6_1.time_ <= 1 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_4 = var_9_0 <= 0 and var_9_1 or var_9_1 * ((var_9_3 - arg_6_1.typewritterCharCountI18N) / var_9_0)

				if (var_9_0 <= 0 and var_9_1 or var_9_1 * ((var_9_3 - arg_6_1.typewritterCharCountI18N) / var_9_0)) > 0 and var_9_1 < var_9_4 then
					arg_6_1.talkMaxDuration = var_9_4

					if var_9_4 + 1 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_4 + 1
					end
				end
			end

			local var_9_5 = math.max(2.93333333333333, arg_6_1.talkMaxDuration)

			if 1 <= arg_6_1.time_ and arg_6_1.time_ < 1 + var_9_5 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_2, (arg_6_1.time_ - 1) / var_9_5)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= 1 + var_9_5 and arg_6_1.time_ < 1 + var_9_5 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_2

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_3
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play924011003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 924011003
		arg_10_1.duration_ = 3.73

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play924011004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 1 < arg_10_1.time_ and arg_10_1.time_ <= 1 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 41
			local var_13_1 = 2.73333333333333
			local var_13_2, var_13_3 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(924011001).content), 3)

			if 1 < arg_10_1.time_ and arg_10_1.time_ <= 1 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_4 = var_13_0 <= 0 and var_13_1 or var_13_1 * ((var_13_3 - arg_10_1.typewritterCharCountI18N) / var_13_0)

				if (var_13_0 <= 0 and var_13_1 or var_13_1 * ((var_13_3 - arg_10_1.typewritterCharCountI18N) / var_13_0)) > 0 and var_13_1 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 1 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 1
					end
				end
			end

			local var_13_5 = math.max(2.73333333333333, arg_10_1.talkMaxDuration)

			if 1 <= arg_10_1.time_ and arg_10_1.time_ < 1 + var_13_5 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_2, (arg_10_1.time_ - 1) / var_13_5)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= 1 + var_13_5 and arg_10_1.time_ < 1 + var_13_5 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_2

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_3
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play924011004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 924011004
		arg_14_1.duration_ = 1.6

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play924011005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 1 < arg_14_1.time_ and arg_14_1.time_ <= 1 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_0 = 9
			local var_17_1 = 0.6
			local var_17_2, var_17_3 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(924011001).content), 4)

			if 1 < arg_14_1.time_ and arg_14_1.time_ <= 1 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_4 = var_17_0 <= 0 and var_17_1 or var_17_1 * ((var_17_3 - arg_14_1.typewritterCharCountI18N) / var_17_0)

				if (var_17_0 <= 0 and var_17_1 or var_17_1 * ((var_17_3 - arg_14_1.typewritterCharCountI18N) / var_17_0)) > 0 and var_17_1 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 1
					end
				end
			end

			local var_17_5 = math.max(0.6, arg_14_1.talkMaxDuration)

			if 1 <= arg_14_1.time_ and arg_14_1.time_ < 1 + var_17_5 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_2, (arg_14_1.time_ - 1) / var_17_5)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= 1 + var_17_5 and arg_14_1.time_ < 1 + var_17_5 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_2

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_3
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play924011005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 924011005
		arg_18_1.duration_ = 2.8

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play924011006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_0 = 27
			local var_21_1 = 1.8
			local var_21_2, var_21_3 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(924011001).content), 5)

			if 1 < arg_18_1.time_ and arg_18_1.time_ <= 1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_4 = var_21_0 <= 0 and var_21_1 or var_21_1 * ((var_21_3 - arg_18_1.typewritterCharCountI18N) / var_21_0)

				if (var_21_0 <= 0 and var_21_1 or var_21_1 * ((var_21_3 - arg_18_1.typewritterCharCountI18N) / var_21_0)) > 0 and var_21_1 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 1
					end
				end
			end

			local var_21_5 = math.max(1.8, arg_18_1.talkMaxDuration)

			if 1 <= arg_18_1.time_ and arg_18_1.time_ < 1 + var_21_5 then
				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_2, (arg_18_1.time_ - 1) / var_21_5)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= 1 + var_21_5 and arg_18_1.time_ < 1 + var_21_5 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_2

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_3
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play924011006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 924011006
		arg_22_1.duration_ = 3.67

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play924011007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 1 < arg_22_1.time_ and arg_22_1.time_ <= 1 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_0 = 40
			local var_25_1 = 2.66666666666667
			local var_25_2, var_25_3 = arg_22_1:GetPercentByPara(arg_22_1:FormatText(arg_22_1:GetWordFromCfg(924011001).content), 6)

			if 1 < arg_22_1.time_ and arg_22_1.time_ <= 1 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_4 = var_25_0 <= 0 and var_25_1 or var_25_1 * ((var_25_3 - arg_22_1.typewritterCharCountI18N) / var_25_0)

				if (var_25_0 <= 0 and var_25_1 or var_25_1 * ((var_25_3 - arg_22_1.typewritterCharCountI18N) / var_25_0)) > 0 and var_25_1 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 1
					end
				end
			end

			local var_25_5 = math.max(2.66666666666667, arg_22_1.talkMaxDuration)

			if 1 <= arg_22_1.time_ and arg_22_1.time_ < 1 + var_25_5 then
				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_2, (arg_22_1.time_ - 1) / var_25_5)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= 1 + var_25_5 and arg_22_1.time_ < 1 + var_25_5 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_2

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_3
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play924011007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 924011007
		arg_26_1.duration_ = 1

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play924011008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0.866666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 0.866666666666667 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_0 = 2
			local var_29_1 = 0.133333333333333
			local var_29_2, var_29_3 = arg_26_1:GetPercentByPara(arg_26_1:FormatText(arg_26_1:GetWordFromCfg(924011001).content), 7)

			if 0.866666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 0.866666666666667 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_4 = var_29_0 <= 0 and var_29_1 or var_29_1 * ((var_29_3 - arg_26_1.typewritterCharCountI18N) / var_29_0)

				if (var_29_0 <= 0 and var_29_1 or var_29_1 * ((var_29_3 - arg_26_1.typewritterCharCountI18N) / var_29_0)) > 0 and var_29_1 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0.866666666666667 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0.866666666666667
					end
				end
			end

			local var_29_5 = math.max(0.133333333333333, arg_26_1.talkMaxDuration)

			if 0.866666666666667 <= arg_26_1.time_ and arg_26_1.time_ < 0.866666666666667 + var_29_5 then
				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_2, (arg_26_1.time_ - 0.866666666666667) / var_29_5)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= 0.866666666666667 + var_29_5 and arg_26_1.time_ < 0.866666666666667 + var_29_5 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_2

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_3
			end

			local var_29_6 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			if arg_26_1.time_ >= var_29_6 + 0.9 and arg_26_1.time_ < var_29_6 + 0.9 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play924011008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 924011008
		arg_30_1.duration_ = 8.7

		local var_30_0 = {
			zh = 7.566,
			ja = 8.7
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play924011009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if arg_30_1.bgs_.ST60 == nil then
				local var_33_0 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST60")
				var_33_0.name = "ST60"
				var_33_0.transform.parent = arg_30_1.stage_.transform
				var_33_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_.ST60 = var_33_0
			end

			if 2 < arg_30_1.time_ and arg_30_1.time_ <= 2 + arg_33_0 then
				local var_33_1 = arg_30_1.bgs_.ST60

				arg_30_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_33_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_2 = var_33_1:GetComponent("SpriteRenderer")

				if var_33_2 and var_33_2.sprite then
					local var_33_3 = 2 * (var_33_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_33_1.transform.localScale = Vector3.New(var_33_3 / var_33_2.sprite.bounds.size.y < var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x and var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x or var_33_3 / var_33_2.sprite.bounds.size.y, var_33_3 / var_33_2.sprite.bounds.size.y < var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x and var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x or var_33_3 / var_33_2.sprite.bounds.size.y, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "ST60" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_4 = 4

			if 4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			if arg_30_1.time_ >= var_33_4 + 0.3 and arg_30_1.time_ < var_33_4 + 0.3 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_5 = 0

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_6 = 2

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 then
				local var_33_7 = Color.New(0, 0, 0)

				var_33_7.a = Mathf.Lerp(0, 1, (arg_30_1.time_ - var_33_5) / var_33_6)
				arg_30_1.mask_.color = var_33_7
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 then
				local var_33_8 = Color.New(0, 0, 0)

				var_33_8.a = 1
				arg_30_1.mask_.color = var_33_8
			end

			local var_33_9 = 2

			if 2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_10 = 2

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_10 then
				local var_33_11 = Color.New(0, 0, 0)

				var_33_11.a = Mathf.Lerp(1, 0, (arg_30_1.time_ - var_33_9) / var_33_10)
				arg_30_1.mask_.color = var_33_11
			end

			if arg_30_1.time_ >= var_33_9 + var_33_10 and arg_30_1.time_ < var_33_9 + var_33_10 + arg_33_0 then
				local var_33_12 = Color.New(0, 0, 0)

				arg_30_1.mask_.enabled = false
				var_33_12.a = 0
				arg_30_1.mask_.color = var_33_12
			end

			local var_33_13 = "1066ui_story"

			if arg_30_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_33_14 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_30_1.stage_.transform)

				var_33_14.name = var_33_13
				var_33_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.actors_[var_33_13] = var_33_14

				local var_33_15 = var_33_14:GetComponentInChildren(typeof(CharacterEffect))

				var_33_15.enabled = true

				local var_33_16 = GameObjectTools.GetOrAddComponent(var_33_14, typeof(DynamicBoneHelper))

				if var_33_16 then
					var_33_16:EnableDynamicBone(false)
				end

				arg_30_1:ShowWeapon(var_33_15.transform, false)

				arg_30_1.var_[var_33_13 .. "Animator"] = var_33_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_30_1.var_[var_33_13 .. "Animator"].applyRootMotion = true
				arg_30_1.var_[var_33_13 .. "LipSync"] = var_33_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_33_17 = arg_30_1.actors_["1066ui_story"].transform

			if 3.8 < arg_30_1.time_ and arg_30_1.time_ <= 3.8 + arg_33_0 then
				arg_30_1.var_.moveOldPos1066ui_story = var_33_17.localPosition
			end

			local var_33_18 = 0.001

			if 3.8 <= arg_30_1.time_ and arg_30_1.time_ < 3.8 + var_33_18 then
				var_33_17.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_30_1.time_ - 3.8) / var_33_18)
				var_33_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_17.position).x, (manager.ui.mainCamera.transform.position - var_33_17.position).y, (manager.ui.mainCamera.transform.position - var_33_17.position).z)
				var_33_17.localEulerAngles.z = 0
				var_33_17.localEulerAngles.x = 0
				var_33_17.localEulerAngles = var_33_17.localEulerAngles
			end

			if arg_30_1.time_ >= 3.8 + var_33_18 and arg_30_1.time_ < 3.8 + var_33_18 + arg_33_0 then
				var_33_17.localPosition = Vector3.New(0, -0.77, -6.1)
				var_33_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_17.position).x, (manager.ui.mainCamera.transform.position - var_33_17.position).y, (manager.ui.mainCamera.transform.position - var_33_17.position).z)
				var_33_17.localEulerAngles.z = 0
				var_33_17.localEulerAngles.x = 0
				var_33_17.localEulerAngles = var_33_17.localEulerAngles
			end

			local var_33_19 = arg_30_1.actors_["1066ui_story"]

			if 3.8 < arg_30_1.time_ and arg_30_1.time_ <= 3.8 + arg_33_0 and not isNil(var_33_19) and arg_30_1.var_.characterEffect1066ui_story == nil then
				arg_30_1.var_.characterEffect1066ui_story = var_33_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_20 = 0.200000002980232

			if 3.8 <= arg_30_1.time_ and arg_30_1.time_ < 3.8 + var_33_20 and not isNil(var_33_19) then
				if arg_30_1.var_.characterEffect1066ui_story and not isNil(var_33_19) then
					arg_30_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 3.8 + var_33_20 and arg_30_1.time_ < 3.8 + var_33_20 + arg_33_0 and not isNil(var_33_19) and arg_30_1.var_.characterEffect1066ui_story then
				arg_30_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 3.8 < arg_30_1.time_ and arg_30_1.time_ <= 3.8 + arg_33_0 then
				arg_30_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 1.95 < arg_30_1.time_ and arg_30_1.time_ <= 1.95 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(false)
				arg_30_1.dialog_:SetActive(false)
				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			if 3.8 < arg_30_1.time_ and arg_30_1.time_ <= 3.8 + arg_33_0 then
				arg_30_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.7 < arg_30_1.time_ and arg_30_1.time_ <= 1.7 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_rooftop", "")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_33_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_25 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_25

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_25
						arg_30_1.bgmTxt2_.text = var_33_25
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.4 < arg_30_1.time_ and arg_30_1.time_ <= 1.4 + arg_33_0 then
				arg_30_1:AudioAction("play", "music", "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_33_28 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if "" ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_28 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_28

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_28
						arg_30_1.bgmTxt2_.text = var_33_28
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_29 = 4
			local var_33_30 = 0.375

			if 4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_29 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_31 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_31:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_30_1.dialogCg_.alpha = arg_36_0
				end))
				var_33_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_32 = arg_30_1:GetWordFromCfg(924011008)
				local var_33_33 = arg_30_1:FormatText(var_33_32.content)

				arg_30_1.text_.text = var_33_33

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_35 = 15 <= 0 and var_33_30 or var_33_30 * (utf8.len(var_33_33) / 15)

				if (15 <= 0 and var_33_30 or var_33_30 * (utf8.len(var_33_33) / 15)) > 0 and var_33_30 < var_33_35 then
					arg_30_1.talkMaxDuration = var_33_35
					var_33_29 = var_33_29 + 0.3

					if var_33_35 + var_33_29 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_35 + var_33_29
					end
				end

				arg_30_1.text_.text = var_33_33
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb") ~= 0 then
					local var_33_36 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb") / 1000

					if var_33_36 + var_33_29 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_36 + var_33_29
					end

					if var_33_32.prefab_name ~= "" and arg_30_1.actors_[var_33_32.prefab_name] ~= nil then
						local var_33_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_32.prefab_name].transform, "story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb")

						arg_30_1:RecordAudio("924011008", var_33_37)
						arg_30_1:RecordAudio("924011008", var_33_37)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011008", "story_v_side_old_924011.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_38 = var_33_29 + 0.3
			local var_33_39 = math.max(var_33_30, arg_30_1.talkMaxDuration)

			if var_33_29 + 0.3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_38 + var_33_39 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_38) / var_33_39

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_38 + var_33_39 and arg_30_1.time_ < var_33_38 + var_33_39 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play924011009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 924011009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play924011010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1066ui_story"]) and arg_38_1.var_.characterEffect1066ui_story == nil then
				arg_38_1.var_.characterEffect1066ui_story = arg_38_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1066ui_story"]) then
				if arg_38_1.var_.characterEffect1066ui_story and not isNil(arg_38_1.actors_["1066ui_story"]) then
					arg_38_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1066ui_story"]) and arg_38_1.var_.characterEffect1066ui_story then
				arg_38_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.25

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(924011009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 10 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 10)

				if (10 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 10)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play924011010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 924011010
		arg_42_1.duration_ = 3.73

		local var_42_0 = {
			zh = 3.733,
			ja = 3.566
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
				arg_42_0:Play924011011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1066ui_story"]) and arg_42_1.var_.characterEffect1066ui_story == nil then
				arg_42_1.var_.characterEffect1066ui_story = arg_42_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1066ui_story"]) then
				if arg_42_1.var_.characterEffect1066ui_story and not isNil(arg_42_1.actors_["1066ui_story"]) then
					arg_42_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1066ui_story"]) and arg_42_1.var_.characterEffect1066ui_story then
				arg_42_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action453")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_45_2 = 0
			local var_45_3 = 0.425

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:GetWordFromCfg(924011010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 17 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 17)

				if (17 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 17)) > 0 and var_45_3 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb") / 1000

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb")

						arg_42_1:RecordAudio("924011010", var_45_9)
						arg_42_1:RecordAudio("924011010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011010", "story_v_side_old_924011.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_10 and arg_42_1.time_ < var_45_2 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play924011011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 924011011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play924011012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1066ui_story"]) and arg_46_1.var_.characterEffect1066ui_story == nil then
				arg_46_1.var_.characterEffect1066ui_story = arg_46_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1066ui_story"]) then
				if arg_46_1.var_.characterEffect1066ui_story and not isNil(arg_46_1.actors_["1066ui_story"]) then
					arg_46_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1066ui_story"]) and arg_46_1.var_.characterEffect1066ui_story then
				arg_46_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_49_1 = 0
			local var_49_2 = 0.65

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(924011011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 26 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 26)

				if (26 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 26)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play924011012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 924011012
		arg_50_1.duration_ = 6.27

		local var_50_0 = {
			zh = 4.533,
			ja = 6.266
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play924011013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1066ui_story"]) and arg_50_1.var_.characterEffect1066ui_story == nil then
				arg_50_1.var_.characterEffect1066ui_story = arg_50_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1066ui_story"]) then
				if arg_50_1.var_.characterEffect1066ui_story and not isNil(arg_50_1.actors_["1066ui_story"]) then
					arg_50_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1066ui_story"]) and arg_50_1.var_.characterEffect1066ui_story then
				arg_50_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_2 = 0
			local var_53_3 = 0.525

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_4 = arg_50_1:GetWordFromCfg(924011012)
				local var_53_5 = arg_50_1:FormatText(var_53_4.content)

				arg_50_1.text_.text = var_53_5

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_7 = 21 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_5) / 21)

				if (21 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_5) / 21)) > 0 and var_53_3 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_2
					end
				end

				arg_50_1.text_.text = var_53_5
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb") / 1000

					if var_53_8 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_2
					end

					if var_53_4.prefab_name ~= "" and arg_50_1.actors_[var_53_4.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_4.prefab_name].transform, "story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb")

						arg_50_1:RecordAudio("924011012", var_53_9)
						arg_50_1:RecordAudio("924011012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011012", "story_v_side_old_924011.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_3, arg_50_1.talkMaxDuration)

			if var_53_2 <= arg_50_1.time_ and arg_50_1.time_ < var_53_2 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_2) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_2 + var_53_10 and arg_50_1.time_ < var_53_2 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play924011013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 924011013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play924011014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1066ui_story"]) and arg_54_1.var_.characterEffect1066ui_story == nil then
				arg_54_1.var_.characterEffect1066ui_story = arg_54_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1066ui_story"]) then
				if arg_54_1.var_.characterEffect1066ui_story and not isNil(arg_54_1.actors_["1066ui_story"]) then
					arg_54_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_0)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1066ui_story"]) and arg_54_1.var_.characterEffect1066ui_story then
				arg_54_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_57_1 = 0
			local var_57_2 = 1.625

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(924011013).content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 65 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 65)

				if (65 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 65)) > 0 and var_57_2 < var_57_5 then
					arg_54_1.talkMaxDuration = var_57_5

					if var_57_5 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_6 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_6 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_6

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_6 and arg_54_1.time_ < var_57_1 + var_57_6 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play924011014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 924011014
		arg_58_1.duration_ = 3.83

		local var_58_0 = {
			zh = 3.833,
			ja = 3.266
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
				arg_58_0:Play924011015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1066ui_story"]) and arg_58_1.var_.characterEffect1066ui_story == nil then
				arg_58_1.var_.characterEffect1066ui_story = arg_58_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1066ui_story"]) then
				if arg_58_1.var_.characterEffect1066ui_story and not isNil(arg_58_1.actors_["1066ui_story"]) then
					arg_58_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1066ui_story"]) and arg_58_1.var_.characterEffect1066ui_story then
				arg_58_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_61_2 = 0
			local var_61_3 = 0.45

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(924011014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 18 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 18)

				if (18 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 18)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb")

						arg_58_1:RecordAudio("924011014", var_61_9)
						arg_58_1:RecordAudio("924011014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011014", "story_v_side_old_924011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play924011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 924011015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play924011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1066ui_story"]) and arg_62_1.var_.characterEffect1066ui_story == nil then
				arg_62_1.var_.characterEffect1066ui_story = arg_62_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1066ui_story"]) then
				if arg_62_1.var_.characterEffect1066ui_story and not isNil(arg_62_1.actors_["1066ui_story"]) then
					arg_62_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1066ui_story"]) and arg_62_1.var_.characterEffect1066ui_story then
				arg_62_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 1.275

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(924011015).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 51 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 51)

				if (51 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 51)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play924011016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 924011016
		arg_66_1.duration_ = 5.07

		local var_66_0 = {
			zh = 4.3,
			ja = 5.066
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
				arg_66_0:Play924011017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1066ui_story"]) and arg_66_1.var_.characterEffect1066ui_story == nil then
				arg_66_1.var_.characterEffect1066ui_story = arg_66_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1066ui_story"]) then
				if arg_66_1.var_.characterEffect1066ui_story and not isNil(arg_66_1.actors_["1066ui_story"]) then
					arg_66_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1066ui_story"]) and arg_66_1.var_.characterEffect1066ui_story then
				arg_66_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_69_2 = 0
			local var_69_3 = 0.55

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(924011016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 22 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 22)

				if (22 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 22)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb")

						arg_66_1:RecordAudio("924011016", var_69_9)
						arg_66_1:RecordAudio("924011016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011016", "story_v_side_old_924011.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_10 and arg_66_1.time_ < var_69_2 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play924011017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 924011017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play924011018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1066ui_story"]) and arg_70_1.var_.characterEffect1066ui_story == nil then
				arg_70_1.var_.characterEffect1066ui_story = arg_70_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1066ui_story"]) then
				if arg_70_1.var_.characterEffect1066ui_story and not isNil(arg_70_1.actors_["1066ui_story"]) then
					arg_70_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1066ui_story"]) and arg_70_1.var_.characterEffect1066ui_story then
				arg_70_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 0.625

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(924011017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 25 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 25)

				if (25 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 25)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play924011018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 924011018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play924011019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.775

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(924011018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 31 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 31)

				if (31 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 31)) > 0 and var_77_0 < var_77_3 then
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
	Play924011019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 924011019
		arg_78_1.duration_ = 2

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play924011020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1066ui_story"]) and arg_78_1.var_.characterEffect1066ui_story == nil then
				arg_78_1.var_.characterEffect1066ui_story = arg_78_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1066ui_story"]) then
				if arg_78_1.var_.characterEffect1066ui_story and not isNil(arg_78_1.actors_["1066ui_story"]) then
					arg_78_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1066ui_story"]) and arg_78_1.var_.characterEffect1066ui_story then
				arg_78_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_81_2 = 0
			local var_81_3 = 0.1

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(924011019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 4 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 4)

				if (4 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 4)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb")

						arg_78_1:RecordAudio("924011019", var_81_9)
						arg_78_1:RecordAudio("924011019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011019", "story_v_side_old_924011.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play924011020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 924011020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play924011021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1066ui_story"]) and arg_82_1.var_.characterEffect1066ui_story == nil then
				arg_82_1.var_.characterEffect1066ui_story = arg_82_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1066ui_story"]) then
				if arg_82_1.var_.characterEffect1066ui_story and not isNil(arg_82_1.actors_["1066ui_story"]) then
					arg_82_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1066ui_story"]) and arg_82_1.var_.characterEffect1066ui_story then
				arg_82_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_85_1 = 0
			local var_85_2 = 1.2

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(924011020).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 48 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 48)

				if (48 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 48)) > 0 and var_85_2 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_6 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_6

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_6 and arg_82_1.time_ < var_85_1 + var_85_6 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play924011021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 924011021
		arg_86_1.duration_ = 2

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play924011022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1066ui_story"]) and arg_86_1.var_.characterEffect1066ui_story == nil then
				arg_86_1.var_.characterEffect1066ui_story = arg_86_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1066ui_story"]) then
				if arg_86_1.var_.characterEffect1066ui_story and not isNil(arg_86_1.actors_["1066ui_story"]) then
					arg_86_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1066ui_story"]) and arg_86_1.var_.characterEffect1066ui_story then
				arg_86_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action442")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_2 = 0
			local var_89_3 = 0.05

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_4 = arg_86_1:GetWordFromCfg(924011021)
				local var_89_5 = arg_86_1:FormatText(var_89_4.content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 2 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 2)

				if (2 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 2)) > 0 and var_89_3 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb") / 1000

					if var_89_8 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_2
					end

					if var_89_4.prefab_name ~= "" and arg_86_1.actors_[var_89_4.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_4.prefab_name].transform, "story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb")

						arg_86_1:RecordAudio("924011021", var_89_9)
						arg_86_1:RecordAudio("924011021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011021", "story_v_side_old_924011.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_10 and arg_86_1.time_ < var_89_2 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play924011022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 924011022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play924011023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1066ui_story"]) and arg_90_1.var_.characterEffect1066ui_story == nil then
				arg_90_1.var_.characterEffect1066ui_story = arg_90_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1066ui_story"]) then
				if arg_90_1.var_.characterEffect1066ui_story and not isNil(arg_90_1.actors_["1066ui_story"]) then
					arg_90_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1066ui_story"]) and arg_90_1.var_.characterEffect1066ui_story then
				arg_90_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.3

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(924011022).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 12 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 12)

				if (12 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 12)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play924011023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 924011023
		arg_94_1.duration_ = 5.33

		local var_94_0 = {
			zh = 5.066,
			ja = 5.333
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
				arg_94_0:Play924011024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1066ui_story"]) and arg_94_1.var_.characterEffect1066ui_story == nil then
				arg_94_1.var_.characterEffect1066ui_story = arg_94_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1066ui_story"]) then
				if arg_94_1.var_.characterEffect1066ui_story and not isNil(arg_94_1.actors_["1066ui_story"]) then
					arg_94_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1066ui_story"]) and arg_94_1.var_.characterEffect1066ui_story then
				arg_94_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_97_2 = 0
			local var_97_3 = 0.55

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:GetWordFromCfg(924011023)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 22 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 22)

				if (22 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 22)) > 0 and var_97_3 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb") / 1000

					if var_97_8 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_2
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb")

						arg_94_1:RecordAudio("924011023", var_97_9)
						arg_94_1:RecordAudio("924011023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011023", "story_v_side_old_924011.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_10 and arg_94_1.time_ < var_97_2 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play924011024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 924011024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play924011025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1066ui_story"]) and arg_98_1.var_.characterEffect1066ui_story == nil then
				arg_98_1.var_.characterEffect1066ui_story = arg_98_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1066ui_story"]) then
				if arg_98_1.var_.characterEffect1066ui_story and not isNil(arg_98_1.actors_["1066ui_story"]) then
					arg_98_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1066ui_story"]) and arg_98_1.var_.characterEffect1066ui_story then
				arg_98_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_101_1 = 0
			local var_101_2 = 0.1

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(924011024).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 4 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 4)

				if (4 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 4)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play924011025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 924011025
		arg_102_1.duration_ = 7.17

		local var_102_0 = {
			zh = 4.7,
			ja = 7.166
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
				arg_102_0:Play924011026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1066ui_story"]) and arg_102_1.var_.characterEffect1066ui_story == nil then
				arg_102_1.var_.characterEffect1066ui_story = arg_102_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1066ui_story"]) then
				if arg_102_1.var_.characterEffect1066ui_story and not isNil(arg_102_1.actors_["1066ui_story"]) then
					arg_102_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1066ui_story"]) and arg_102_1.var_.characterEffect1066ui_story then
				arg_102_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action423")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_2 = 0
			local var_105_3 = 0.525

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(924011025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 21 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 21)

				if (21 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 21)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb")

						arg_102_1:RecordAudio("924011025", var_105_9)
						arg_102_1:RecordAudio("924011025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011025", "story_v_side_old_924011.awb")
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
	Play924011026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 924011026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play924011027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1066ui_story"]) and arg_106_1.var_.characterEffect1066ui_story == nil then
				arg_106_1.var_.characterEffect1066ui_story = arg_106_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1066ui_story"]) then
				if arg_106_1.var_.characterEffect1066ui_story and not isNil(arg_106_1.actors_["1066ui_story"]) then
					arg_106_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1066ui_story"]) and arg_106_1.var_.characterEffect1066ui_story then
				arg_106_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 0.35

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(924011026).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 14 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 14)

				if (14 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 14)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play924011027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 924011027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play924011028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.9

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(924011027).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 34 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 34)

				if (34 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 34)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play924011028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 924011028
		arg_114_1.duration_ = 5.1

		local var_114_0 = {
			zh = 4.433,
			ja = 5.1
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
				arg_114_0:Play924011029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1066ui_story"]) and arg_114_1.var_.characterEffect1066ui_story == nil then
				arg_114_1.var_.characterEffect1066ui_story = arg_114_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1066ui_story"]) then
				if arg_114_1.var_.characterEffect1066ui_story and not isNil(arg_114_1.actors_["1066ui_story"]) then
					arg_114_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1066ui_story"]) and arg_114_1.var_.characterEffect1066ui_story then
				arg_114_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_117_2 = 0
			local var_117_3 = 0.5

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(924011028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 20 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 20)

				if (20 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 20)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb")

						arg_114_1:RecordAudio("924011028", var_117_9)
						arg_114_1:RecordAudio("924011028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011028", "story_v_side_old_924011.awb")
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
	Play924011029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 924011029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play924011030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1066ui_story"]) and arg_118_1.var_.characterEffect1066ui_story == nil then
				arg_118_1.var_.characterEffect1066ui_story = arg_118_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1066ui_story"]) then
				if arg_118_1.var_.characterEffect1066ui_story and not isNil(arg_118_1.actors_["1066ui_story"]) then
					arg_118_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1066ui_story"]) and arg_118_1.var_.characterEffect1066ui_story then
				arg_118_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0
			local var_121_2 = 0.725

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(924011029).content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 29 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 29)

				if (29 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 29)) > 0 and var_121_2 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_6 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_6 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_6

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_6 and arg_118_1.time_ < var_121_1 + var_121_6 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play924011030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 924011030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play924011031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0.125 < arg_122_1.time_ and arg_122_1.time_ <= 0.125 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_side_1067", "se_story_1067_ring", "")
			end

			local var_125_1 = 0
			local var_125_2 = 0.7

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(924011030).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 28 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 28)

				if (28 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 28)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play924011031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 924011031
		arg_126_1.duration_ = 10.4

		local var_126_0 = {
			zh = 7.133,
			ja = 10.4
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
				arg_126_0:Play924011032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1066ui_story"]) and arg_126_1.var_.characterEffect1066ui_story == nil then
				arg_126_1.var_.characterEffect1066ui_story = arg_126_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1066ui_story"]) then
				if arg_126_1.var_.characterEffect1066ui_story and not isNil(arg_126_1.actors_["1066ui_story"]) then
					arg_126_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1066ui_story"]) and arg_126_1.var_.characterEffect1066ui_story then
				arg_126_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_2 = 0
			local var_129_3 = 0.75

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_4 = arg_126_1:GetWordFromCfg(924011031)
				local var_129_5 = arg_126_1:FormatText(var_129_4.content)

				arg_126_1.text_.text = var_129_5

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_7 = 30 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_5) / 30)

				if (30 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_5) / 30)) > 0 and var_129_3 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_2
					end
				end

				arg_126_1.text_.text = var_129_5
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb") / 1000

					if var_129_8 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_2
					end

					if var_129_4.prefab_name ~= "" and arg_126_1.actors_[var_129_4.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_4.prefab_name].transform, "story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb")

						arg_126_1:RecordAudio("924011031", var_129_9)
						arg_126_1:RecordAudio("924011031", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011031", "story_v_side_old_924011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_3, arg_126_1.talkMaxDuration)

			if var_129_2 <= arg_126_1.time_ and arg_126_1.time_ < var_129_2 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_2) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_2 + var_129_10 and arg_126_1.time_ < var_129_2 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play924011032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 924011032
		arg_130_1.duration_ = 9

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play924011033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if arg_130_1.bgs_.ST2201 == nil then
				local var_133_0 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2201")
				var_133_0.name = "ST2201"
				var_133_0.transform.parent = arg_130_1.stage_.transform
				var_133_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_.ST2201 = var_133_0
			end

			if 2 < arg_130_1.time_ and arg_130_1.time_ <= 2 + arg_133_0 then
				local var_133_1 = arg_130_1.bgs_.ST2201

				arg_130_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_133_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_2 = var_133_1:GetComponent("SpriteRenderer")

				if var_133_2 and var_133_2.sprite then
					local var_133_3 = 2 * (var_133_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_133_1.transform.localScale = Vector3.New(var_133_3 / var_133_2.sprite.bounds.size.y < var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x and var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x or var_133_3 / var_133_2.sprite.bounds.size.y, var_133_3 / var_133_2.sprite.bounds.size.y < var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x and var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x or var_133_3 / var_133_2.sprite.bounds.size.y, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "ST2201" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_4 = 4

			if 4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			if arg_130_1.time_ >= var_133_4 + 0.3 and arg_130_1.time_ < var_133_4 + 0.3 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_5 = 0

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_6 = 2

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 then
				local var_133_7 = Color.New(0, 0, 0)

				var_133_7.a = Mathf.Lerp(0, 1, (arg_130_1.time_ - var_133_5) / var_133_6)
				arg_130_1.mask_.color = var_133_7
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 then
				local var_133_8 = Color.New(0, 0, 0)

				var_133_8.a = 1
				arg_130_1.mask_.color = var_133_8
			end

			local var_133_9 = 2

			if 2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_10 = 2

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_10 then
				local var_133_11 = Color.New(0, 0, 0)

				var_133_11.a = Mathf.Lerp(1, 0, (arg_130_1.time_ - var_133_9) / var_133_10)
				arg_130_1.mask_.color = var_133_11
			end

			if arg_130_1.time_ >= var_133_9 + var_133_10 and arg_130_1.time_ < var_133_9 + var_133_10 + arg_133_0 then
				local var_133_12 = Color.New(0, 0, 0)

				arg_130_1.mask_.enabled = false
				var_133_12.a = 0
				arg_130_1.mask_.color = var_133_12
			end

			local var_133_13 = arg_130_1.actors_["1066ui_story"].transform

			if 1.96599999815226 < arg_130_1.time_ and arg_130_1.time_ <= 1.96599999815226 + arg_133_0 then
				arg_130_1.var_.moveOldPos1066ui_story = var_133_13.localPosition
			end

			local var_133_14 = 0.001

			if 1.96599999815226 <= arg_130_1.time_ and arg_130_1.time_ < 1.96599999815226 + var_133_14 then
				var_133_13.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 1.96599999815226) / var_133_14)
				var_133_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_13.position).x, (manager.ui.mainCamera.transform.position - var_133_13.position).y, (manager.ui.mainCamera.transform.position - var_133_13.position).z)
				var_133_13.localEulerAngles.z = 0
				var_133_13.localEulerAngles.x = 0
				var_133_13.localEulerAngles = var_133_13.localEulerAngles
			end

			if arg_130_1.time_ >= 1.96599999815226 + var_133_14 and arg_130_1.time_ < 1.96599999815226 + var_133_14 + arg_133_0 then
				var_133_13.localPosition = Vector3.New(0, 100, 0)
				var_133_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_13.position).x, (manager.ui.mainCamera.transform.position - var_133_13.position).y, (manager.ui.mainCamera.transform.position - var_133_13.position).z)
				var_133_13.localEulerAngles.z = 0
				var_133_13.localEulerAngles.x = 0
				var_133_13.localEulerAngles = var_133_13.localEulerAngles
			end

			local var_133_15 = arg_130_1.actors_["1066ui_story"]

			if 1.96599999815226 < arg_130_1.time_ and arg_130_1.time_ <= 1.96599999815226 + arg_133_0 and not isNil(var_133_15) and arg_130_1.var_.characterEffect1066ui_story == nil then
				arg_130_1.var_.characterEffect1066ui_story = var_133_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_16 = 0.034000001847744

			if 1.96599999815226 <= arg_130_1.time_ and arg_130_1.time_ < 1.96599999815226 + var_133_16 and not isNil(var_133_15) then
				if arg_130_1.var_.characterEffect1066ui_story and not isNil(var_133_15) then
					arg_130_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 1.96599999815226) / var_133_16)
				end
			end

			if arg_130_1.time_ >= 1.96599999815226 + var_133_16 and arg_130_1.time_ < 1.96599999815226 + var_133_16 + arg_133_0 and not isNil(var_133_15) and arg_130_1.var_.characterEffect1066ui_story then
				arg_130_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0.4 < arg_130_1.time_ and arg_130_1.time_ <= 0.4 + arg_133_0 then
				arg_130_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_rooftop", "")
			end

			if 1.6 < arg_130_1.time_ and arg_130_1.time_ <= 1.6 + arg_133_0 then
				arg_130_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_133_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_21 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_21

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_21
						arg_130_1.bgmTxt2_.text = var_133_21
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_130_1.time_ and arg_130_1.time_ <= 0.4 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_133_24 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_24 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_24

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_24
						arg_130_1.bgmTxt2_.text = var_133_24
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.833333333333333 < arg_130_1.time_ and arg_130_1.time_ <= 0.833333333333333 + arg_133_0 then
				arg_130_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_rooftop", "")
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_26 = 4
			local var_133_27 = 0.2

			if 4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_26 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_28 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_28:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_130_1.dialogCg_.alpha = arg_136_0
				end))
				var_133_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_29 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(924011032).content)

				arg_130_1.text_.text = var_133_29

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_31 = 8 <= 0 and var_133_27 or var_133_27 * (utf8.len(var_133_29) / 8)

				if (8 <= 0 and var_133_27 or var_133_27 * (utf8.len(var_133_29) / 8)) > 0 and var_133_27 < var_133_31 then
					arg_130_1.talkMaxDuration = var_133_31
					var_133_26 = var_133_26 + 0.3

					if var_133_31 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_31 + var_133_26
					end
				end

				arg_130_1.text_.text = var_133_29
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_32 = var_133_26 + 0.3
			local var_133_33 = math.max(var_133_27, arg_130_1.talkMaxDuration)

			if var_133_26 + 0.3 <= arg_130_1.time_ and arg_130_1.time_ < var_133_32 + var_133_33 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_32) / var_133_33

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_32 + var_133_33 and arg_130_1.time_ < var_133_32 + var_133_33 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play924011033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 924011033
		arg_138_1.duration_ = 12.27

		local var_138_0 = {
			zh = 7.2,
			ja = 12.266
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
				arg_138_0:Play924011034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if arg_138_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_141_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_138_1.stage_.transform)

				var_141_0.name = "1033ui_story"
				var_141_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["1033ui_story"] = var_141_0

				local var_141_1 = var_141_0:GetComponentInChildren(typeof(CharacterEffect))

				var_141_1.enabled = true

				local var_141_2 = GameObjectTools.GetOrAddComponent(var_141_0, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(false)
				end

				arg_138_1:ShowWeapon(var_141_1.transform, false)

				arg_138_1.var_["1033ui_story" .. "Animator"] = var_141_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_138_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_138_1.var_["1033ui_story" .. "LipSync"] = var_141_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_141_3 = arg_138_1.actors_["1033ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1033ui_story = var_141_3.localPosition
			end

			local var_141_4 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				var_141_3.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_138_1.time_ - 0) / var_141_4)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				var_141_3.localPosition = Vector3.New(0, -1.01, -6.13)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles
			end

			local var_141_5 = arg_138_1.actors_["1033ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_5) and arg_138_1.var_.characterEffect1033ui_story == nil then
				arg_138_1.var_.characterEffect1033ui_story = var_141_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_6 and not isNil(var_141_5) then
				if arg_138_1.var_.characterEffect1033ui_story and not isNil(var_141_5) then
					arg_138_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_6 and arg_138_1.time_ < 0 + var_141_6 + arg_141_0 and not isNil(var_141_5) and arg_138_1.var_.characterEffect1033ui_story then
				arg_138_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_8 = 0
			local var_141_9 = 0.925

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_10 = arg_138_1:GetWordFromCfg(924011033)
				local var_141_11 = arg_138_1:FormatText(var_141_10.content)

				arg_138_1.text_.text = var_141_11

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 37 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_11) / 37)

				if (37 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_11) / 37)) > 0 and var_141_9 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_8
					end
				end

				arg_138_1.text_.text = var_141_11
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb") ~= 0 then
					local var_141_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb") / 1000

					if var_141_14 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_14 + var_141_8
					end

					if var_141_10.prefab_name ~= "" and arg_138_1.actors_[var_141_10.prefab_name] ~= nil then
						local var_141_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_10.prefab_name].transform, "story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb")

						arg_138_1:RecordAudio("924011033", var_141_15)
						arg_138_1:RecordAudio("924011033", var_141_15)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011033", "story_v_side_old_924011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_9, arg_138_1.talkMaxDuration)

			if var_141_8 <= arg_138_1.time_ and arg_138_1.time_ < var_141_8 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_8) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_8 + var_141_16 and arg_138_1.time_ < var_141_8 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play924011034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 924011034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play924011035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1033ui_story"]) and arg_142_1.var_.characterEffect1033ui_story == nil then
				arg_142_1.var_.characterEffect1033ui_story = arg_142_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1033ui_story"]) then
				if arg_142_1.var_.characterEffect1033ui_story and not isNil(arg_142_1.actors_["1033ui_story"]) then
					arg_142_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1033ui_story"]) and arg_142_1.var_.characterEffect1033ui_story then
				arg_142_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 1.1

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(924011034).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 44 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 44)

				if (44 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 44)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play924011035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 924011035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play924011036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.2

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(924011035).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 8 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 8)

				if (8 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 8)) > 0 and var_149_0 < var_149_3 then
					arg_146_1.talkMaxDuration = var_149_3

					if var_149_3 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_3 + 0
					end
				end

				arg_146_1.text_.text = var_149_1
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_4 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_4

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play924011036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 924011036
		arg_150_1.duration_ = 4.1

		local var_150_0 = {
			zh = 3.6,
			ja = 4.1
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
				arg_150_0:Play924011037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1066ui_story = arg_150_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1066ui_story"].transform.position).z)
				arg_150_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1066ui_story"].transform.localEulerAngles = arg_150_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_150_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1066ui_story"].transform.position).z)
				arg_150_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1066ui_story"].transform.localEulerAngles = arg_150_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["1033ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1033ui_story = var_153_1.localPosition
			end

			local var_153_2 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 then
				var_153_1.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_2)
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

			local var_153_3 = arg_150_1.actors_["1066ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_3) and arg_150_1.var_.characterEffect1066ui_story == nil then
				arg_150_1.var_.characterEffect1066ui_story = var_153_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_4 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 and not isNil(var_153_3) then
				if arg_150_1.var_.characterEffect1066ui_story and not isNil(var_153_3) then
					arg_150_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 and not isNil(var_153_3) and arg_150_1.var_.characterEffect1066ui_story then
				arg_150_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_153_6 = 0
			local var_153_7 = 0.4

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_8 = arg_150_1:GetWordFromCfg(924011036)
				local var_153_9 = arg_150_1:FormatText(var_153_8.content)

				arg_150_1.text_.text = var_153_9

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 16 <= 0 and var_153_7 or var_153_7 * (utf8.len(var_153_9) / 16)

				if (16 <= 0 and var_153_7 or var_153_7 * (utf8.len(var_153_9) / 16)) > 0 and var_153_7 < var_153_11 then
					arg_150_1.talkMaxDuration = var_153_11

					if var_153_11 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_6
					end
				end

				arg_150_1.text_.text = var_153_9
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb") ~= 0 then
					local var_153_12 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb") / 1000

					if var_153_12 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_12 + var_153_6
					end

					if var_153_8.prefab_name ~= "" and arg_150_1.actors_[var_153_8.prefab_name] ~= nil then
						local var_153_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_8.prefab_name].transform, "story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb")

						arg_150_1:RecordAudio("924011036", var_153_13)
						arg_150_1:RecordAudio("924011036", var_153_13)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011036", "story_v_side_old_924011.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_14 = math.max(var_153_7, arg_150_1.talkMaxDuration)

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_14 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_6) / var_153_14

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_6 + var_153_14 and arg_150_1.time_ < var_153_6 + var_153_14 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play924011037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 924011037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play924011038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1066ui_story"]) and arg_154_1.var_.characterEffect1066ui_story == nil then
				arg_154_1.var_.characterEffect1066ui_story = arg_154_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1066ui_story"]) then
				if arg_154_1.var_.characterEffect1066ui_story and not isNil(arg_154_1.actors_["1066ui_story"]) then
					arg_154_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_0)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1066ui_story"]) and arg_154_1.var_.characterEffect1066ui_story then
				arg_154_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_157_1 = 0
			local var_157_2 = 0.65

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(924011037).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 26 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 26)

				if (26 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 26)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play924011038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 924011038
		arg_158_1.duration_ = 9.17

		local var_158_0 = {
			zh = 7.5,
			ja = 9.166
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
				arg_158_0:Play924011039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1066ui_story"]) and arg_158_1.var_.characterEffect1066ui_story == nil then
				arg_158_1.var_.characterEffect1066ui_story = arg_158_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1066ui_story"]) then
				if arg_158_1.var_.characterEffect1066ui_story and not isNil(arg_158_1.actors_["1066ui_story"]) then
					arg_158_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1066ui_story"]) and arg_158_1.var_.characterEffect1066ui_story then
				arg_158_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_161_2 = 0
			local var_161_3 = 0.875

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(924011038)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_7 = 35 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 35)

				if (35 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 35)) > 0 and var_161_3 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb") / 1000

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb")

						arg_158_1:RecordAudio("924011038", var_161_9)
						arg_158_1:RecordAudio("924011038", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011038", "story_v_side_old_924011.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_10 and arg_158_1.time_ < var_161_2 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play924011039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 924011039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play924011040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1066ui_story"]) and arg_162_1.var_.characterEffect1066ui_story == nil then
				arg_162_1.var_.characterEffect1066ui_story = arg_162_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1066ui_story"]) then
				if arg_162_1.var_.characterEffect1066ui_story and not isNil(arg_162_1.actors_["1066ui_story"]) then
					arg_162_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1066ui_story"]) and arg_162_1.var_.characterEffect1066ui_story then
				arg_162_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.15

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(924011039).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 6 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 6)

				if (6 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 6)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play924011040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 924011040
		arg_166_1.duration_ = 9.9

		local var_166_0 = {
			zh = 7.3,
			ja = 9.9
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
				arg_166_0:Play924011041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1066ui_story"]) and arg_166_1.var_.characterEffect1066ui_story == nil then
				arg_166_1.var_.characterEffect1066ui_story = arg_166_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1066ui_story"]) then
				if arg_166_1.var_.characterEffect1066ui_story and not isNil(arg_166_1.actors_["1066ui_story"]) then
					arg_166_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1066ui_story"]) and arg_166_1.var_.characterEffect1066ui_story then
				arg_166_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_169_2 = 0
			local var_169_3 = 0.925

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_4 = arg_166_1:GetWordFromCfg(924011040)
				local var_169_5 = arg_166_1:FormatText(var_169_4.content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 37 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 37)

				if (37 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 37)) > 0 and var_169_3 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb") / 1000

					if var_169_8 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_2
					end

					if var_169_4.prefab_name ~= "" and arg_166_1.actors_[var_169_4.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_4.prefab_name].transform, "story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb")

						arg_166_1:RecordAudio("924011040", var_169_9)
						arg_166_1:RecordAudio("924011040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011040", "story_v_side_old_924011.awb")
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
	Play924011041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 924011041
		arg_170_1.duration_ = 11

		local var_170_0 = {
			zh = 8.1,
			ja = 11
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
				arg_170_0:Play924011042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 1.075

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:GetWordFromCfg(924011041)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 43 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 43)

				if (43 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 43)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb")

						arg_170_1:RecordAudio("924011041", var_173_6)
						arg_170_1:RecordAudio("924011041", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011041", "story_v_side_old_924011.awb")
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
	Play924011042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 924011042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play924011043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1066ui_story"]) and arg_174_1.var_.characterEffect1066ui_story == nil then
				arg_174_1.var_.characterEffect1066ui_story = arg_174_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1066ui_story"]) then
				if arg_174_1.var_.characterEffect1066ui_story and not isNil(arg_174_1.actors_["1066ui_story"]) then
					arg_174_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1066ui_story"]) and arg_174_1.var_.characterEffect1066ui_story then
				arg_174_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_177_1 = 0
			local var_177_2 = 0.6

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(924011042).content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 24 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 24)

				if (24 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 24)) > 0 and var_177_2 < var_177_5 then
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

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play924011043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 924011043
		arg_178_1.duration_ = 18.6

		local var_178_0 = {
			zh = 11.9,
			ja = 18.6
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
				arg_178_0:Play924011044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1033ui_story = arg_178_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1033ui_story"].transform.position).z)
				arg_178_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1033ui_story"].transform.localEulerAngles = arg_178_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_178_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1033ui_story"].transform.position).z)
				arg_178_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1033ui_story"].transform.localEulerAngles = arg_178_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1066ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1066ui_story = var_181_1.localPosition
			end

			local var_181_2 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 then
				var_181_1.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_2)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 then
				var_181_1.localPosition = Vector3.New(0, 100, 0)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			local var_181_3 = arg_178_1.actors_["1033ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_3) and arg_178_1.var_.characterEffect1033ui_story == nil then
				arg_178_1.var_.characterEffect1033ui_story = var_181_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_4 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 and not isNil(var_181_3) then
				if arg_178_1.var_.characterEffect1033ui_story and not isNil(var_181_3) then
					arg_178_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 and not isNil(var_181_3) and arg_178_1.var_.characterEffect1033ui_story then
				arg_178_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_181_6 = 0
			local var_181_7 = 1.475

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_8 = arg_178_1:GetWordFromCfg(924011043)
				local var_181_9 = arg_178_1:FormatText(var_181_8.content)

				arg_178_1.text_.text = var_181_9

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 59 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 59)

				if (59 <= 0 and var_181_7 or var_181_7 * (utf8.len(var_181_9) / 59)) > 0 and var_181_7 < var_181_11 then
					arg_178_1.talkMaxDuration = var_181_11

					if var_181_11 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_11 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_9
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb") ~= 0 then
					local var_181_12 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb") / 1000

					if var_181_12 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_12 + var_181_6
					end

					if var_181_8.prefab_name ~= "" and arg_178_1.actors_[var_181_8.prefab_name] ~= nil then
						local var_181_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_8.prefab_name].transform, "story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb")

						arg_178_1:RecordAudio("924011043", var_181_13)
						arg_178_1:RecordAudio("924011043", var_181_13)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011043", "story_v_side_old_924011.awb")
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
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play924011044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 924011044
		arg_182_1.duration_ = 17

		local var_182_0 = {
			zh = 10.266,
			ja = 17
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
				arg_182_0:Play924011045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 1.375

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(924011044)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 55 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 55)

				if (55 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 55)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb")

						arg_182_1:RecordAudio("924011044", var_185_6)
						arg_182_1:RecordAudio("924011044", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011044", "story_v_side_old_924011.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play924011045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 924011045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play924011046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1033ui_story"]) and arg_186_1.var_.characterEffect1033ui_story == nil then
				arg_186_1.var_.characterEffect1033ui_story = arg_186_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1033ui_story"]) then
				if arg_186_1.var_.characterEffect1033ui_story and not isNil(arg_186_1.actors_["1033ui_story"]) then
					arg_186_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1033ui_story"]) and arg_186_1.var_.characterEffect1033ui_story then
				arg_186_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.675

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(924011045).content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 27 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 27)

				if (27 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 27)) > 0 and var_189_2 < var_189_5 then
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
	Play924011046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 924011046
		arg_190_1.duration_ = 19.5

		local var_190_0 = {
			zh = 11.2,
			ja = 19.5
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
				arg_190_0:Play924011047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1033ui_story = arg_190_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1033ui_story"].transform.position).z)
				arg_190_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1033ui_story"].transform.localEulerAngles = arg_190_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_190_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1033ui_story"].transform.position).z)
				arg_190_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1033ui_story"].transform.localEulerAngles = arg_190_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1033ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1033ui_story == nil then
				arg_190_1.var_.characterEffect1033ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1033ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1033ui_story then
				arg_190_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_4 = 0
			local var_193_5 = 1.45

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(924011046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 58 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 58)

				if (58 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 58)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb")

						arg_190_1:RecordAudio("924011046", var_193_11)
						arg_190_1:RecordAudio("924011046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011046", "story_v_side_old_924011.awb")
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
				actorName = "1033ui_story",
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
	Play924011047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 924011047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play924011048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1033ui_story"]) and arg_194_1.var_.characterEffect1033ui_story == nil then
				arg_194_1.var_.characterEffect1033ui_story = arg_194_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1033ui_story"]) then
				if arg_194_1.var_.characterEffect1033ui_story and not isNil(arg_194_1.actors_["1033ui_story"]) then
					arg_194_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1033ui_story"]) and arg_194_1.var_.characterEffect1033ui_story then
				arg_194_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.25

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(924011047).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 10 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 10)

				if (10 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 10)) > 0 and var_197_2 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_6 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_6 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_6

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_6 and arg_194_1.time_ < var_197_1 + var_197_6 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play924011048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 924011048
		arg_198_1.duration_ = 9

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play924011049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_9002
			local var_201_9001
			local var_201_9000

			if 0.965999998152256 < arg_198_1.time_ and arg_198_1.time_ <= 0.965999998152256 + arg_201_0 then
				arg_198_1.var_.moveOldPos1033ui_story = arg_198_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0.965999998152256 <= arg_198_1.time_ and arg_198_1.time_ < 0.965999998152256 + var_201_0 then
				arg_198_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0.965999998152256) / var_201_0)
				arg_198_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1033ui_story"].transform.position).z)
				arg_198_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1033ui_story"].transform.localEulerAngles = arg_198_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0.965999998152256 + var_201_0 and arg_198_1.time_ < 0.965999998152256 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1033ui_story"].transform.position).z)
				arg_198_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1033ui_story"].transform.localEulerAngles = arg_198_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_201_1 = 0

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_2 = 1

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = Color.New(0, 0, 0)

				var_201_3.a = Mathf.Lerp(0, 1, (arg_198_1.time_ - var_201_1) / var_201_2)
				arg_198_1.mask_.color = var_201_3
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				local var_201_4 = Color.New(0, 0, 0)

				var_201_4.a = 1
				arg_198_1.mask_.color = var_201_4
			end

			local var_201_5 = 1

			if 1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = true

				arg_198_1:SetGaussion(false)
			end

			local var_201_6 = 1.55

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 then
				local var_201_7 = Color.New(0, 0, 0)

				var_201_7.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_5) / var_201_6)
				arg_198_1.mask_.color = var_201_7
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 then
				local var_201_8 = Color.New(0, 0, 0)

				arg_198_1.mask_.enabled = false
				var_201_8.a = 0
				arg_198_1.mask_.color = var_201_8
			end

			if 1 < arg_198_1.time_ and arg_198_1.time_ <= 1 + arg_201_0 then
				local var_201_9 = arg_198_1.var_.effectjingbao1

				if not arg_198_1.var_.effectjingbao1 then
					var_201_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao_in_keep"), manager.ui.mainCamera.transform)
					var_201_9.name = "jingbao1"
					arg_198_1.var_.effectjingbao1 = var_201_9
				else
					var_201_9.transform:SetParent(var_201_9002)
				end

				var_201_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_201_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_201_11 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_201_12 = var_201_9.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_201_0, iter_201_1 in ipairs((var_201_12:ToTable())) do
					iter_201_1.transform.localScale = Vector3.New(iter_201_1.transform.localScale.x / var_201_11 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_201_12 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_201_1.transform.localScale.y / var_201_11, iter_201_1.transform.localScale.z)
				end
			end

			if 5.499999999999 < arg_198_1.time_ and arg_198_1.time_ <= 5.499999999999 + arg_201_0 then
				local var_201_14 = arg_198_1.var_.effectjingbao2

				if not arg_198_1.var_.effectjingbao2 then
					var_201_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao_out"), manager.ui.mainCamera.transform)
					var_201_14.name = "jingbao2"
					arg_198_1.var_.effectjingbao2 = var_201_14
				else
					var_201_14.transform:SetParent(var_201_9001)
				end

				var_201_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_201_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_201_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_201_17 = var_201_14.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_201_2, iter_201_3 in ipairs((var_201_17:ToTable())) do
					iter_201_3.transform.localScale = Vector3.New(iter_201_3.transform.localScale.x / var_201_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_201_17 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_201_3.transform.localScale.y / var_201_16, iter_201_3.transform.localScale.z)
				end
			end

			if 6.499999999999 < arg_198_1.time_ and arg_198_1.time_ <= 6.499999999999 + arg_201_0 then
				if arg_198_1.var_.effectjingbao2 then
					Object.Destroy(arg_198_1.var_.effectjingbao2)

					arg_198_1.var_.effectjingbao2 = nil
				end
			end

			if 5.499999999999 < arg_198_1.time_ and arg_198_1.time_ <= 5.499999999999 + arg_201_0 then
				if arg_198_1.var_.effectjingbao1 then
					Object.Destroy(arg_198_1.var_.effectjingbao1)

					arg_198_1.var_.effectjingbao1 = nil
				end
			end

			if 1 < arg_198_1.time_ and arg_198_1.time_ <= 1 + arg_201_0 then
				local var_201_21 = arg_198_1.var_.effectjingbao3jingbao3

				if not arg_198_1.var_.effectjingbao3jingbao3 then
					var_201_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_out"), manager.ui.mainCamera.transform)
					var_201_21.name = "jingbao3"
					arg_198_1.var_.effectjingbao3jingbao3 = var_201_21
				else
					var_201_21.transform:SetParent(var_201_9000)
				end

				var_201_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_201_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_201_23 = 2.55

			if 2.55 < arg_198_1.time_ and arg_198_1.time_ <= var_201_23 + arg_201_0 then
				arg_198_1.allBtn_.enabled = false
			end

			if arg_198_1.time_ >= var_201_23 + 2.949999999999 and arg_198_1.time_ < var_201_23 + 2.949999999999 + arg_201_0 then
				arg_198_1.allBtn_.enabled = true
			end

			if 1 < arg_198_1.time_ and arg_198_1.time_ <= 1 + arg_201_0 then
				arg_198_1:AudioAction("play", "effect", "se_story_129", "se_story_129_alarm", "")
			end

			if arg_198_1.frameCnt_ <= 1 then
				arg_198_1.dialog_:SetActive(false)
			end

			local var_201_25 = 4
			local var_201_26 = 0.125

			if 4 < arg_198_1.time_ and arg_198_1.time_ <= var_201_25 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_27 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_27:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_28 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(924011048).content)

				arg_198_1.text_.text = var_201_28

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_30 = 5 <= 0 and var_201_26 or var_201_26 * (utf8.len(var_201_28) / 5)

				if (5 <= 0 and var_201_26 or var_201_26 * (utf8.len(var_201_28) / 5)) > 0 and var_201_26 < var_201_30 then
					arg_198_1.talkMaxDuration = var_201_30
					var_201_25 = var_201_25 + 0.3

					if var_201_30 + var_201_25 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_30 + var_201_25
					end
				end

				arg_198_1.text_.text = var_201_28
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_31 = var_201_25 + 0.3
			local var_201_32 = math.max(var_201_26, arg_198_1.talkMaxDuration)

			if var_201_25 + 0.3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_31 + var_201_32 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_31) / var_201_32

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_31 + var_201_32 and arg_198_1.time_ < var_201_31 + var_201_32 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play924011049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 924011049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play924011050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.925

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(924011049).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 37 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 37)

				if (37 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 37)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play924011050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 924011050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play924011051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.275

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(924011050).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 11 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 11)

				if (11 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 11)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play924011051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 924011051
		arg_212_1.duration_ = 8.17

		local var_212_0 = {
			zh = 5.533,
			ja = 8.166
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
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play924011052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1033ui_story = arg_212_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1033ui_story"].transform.position).z)
				arg_212_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1033ui_story"].transform.localEulerAngles = arg_212_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_212_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1033ui_story"].transform.position).z)
				arg_212_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1033ui_story"].transform.localEulerAngles = arg_212_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["1033ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect1033ui_story == nil then
				arg_212_1.var_.characterEffect1033ui_story = var_215_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 and not isNil(var_215_1) then
				if arg_212_1.var_.characterEffect1033ui_story and not isNil(var_215_1) then
					arg_212_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect1033ui_story then
				arg_212_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_215_4 = 0
			local var_215_5 = 0.675

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(924011051)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 27 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 27)

				if (27 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 27)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb")

						arg_212_1:RecordAudio("924011051", var_215_11)
						arg_212_1:RecordAudio("924011051", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011051", "story_v_side_old_924011.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play924011052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 924011052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play924011053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1033ui_story"]) and arg_216_1.var_.characterEffect1033ui_story == nil then
				arg_216_1.var_.characterEffect1033ui_story = arg_216_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1033ui_story"]) then
				if arg_216_1.var_.characterEffect1033ui_story and not isNil(arg_216_1.actors_["1033ui_story"]) then
					arg_216_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1033ui_story"]) and arg_216_1.var_.characterEffect1033ui_story then
				arg_216_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 0.375

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(924011052).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 15 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 15)

				if (15 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 15)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play924011053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 924011053
		arg_220_1.duration_ = 2.73

		local var_220_0 = {
			zh = 2.733,
			ja = 1.7
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play924011054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.1

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:GetWordFromCfg(924011053)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 4 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 4)

				if (4 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 4)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb")

						arg_220_1:RecordAudio("924011053", var_223_6)
						arg_220_1:RecordAudio("924011053", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011053", "story_v_side_old_924011.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play924011054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 924011054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play924011055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.65

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_1 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(924011054).content)

				arg_224_1.text_.text = var_227_1

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_3 = 26 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 26)

				if (26 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 26)) > 0 and var_227_0 < var_227_3 then
					arg_224_1.talkMaxDuration = var_227_3

					if var_227_3 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_3 + 0
					end
				end

				arg_224_1.text_.text = var_227_1
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_4 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_4

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play924011055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 924011055
		arg_228_1.duration_ = 6.2

		local var_228_0 = {
			zh = 3.9,
			ja = 6.2
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play924011056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1033ui_story"]) and arg_228_1.var_.characterEffect1033ui_story == nil then
				arg_228_1.var_.characterEffect1033ui_story = arg_228_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1033ui_story"]) then
				if arg_228_1.var_.characterEffect1033ui_story and not isNil(arg_228_1.actors_["1033ui_story"]) then
					arg_228_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1033ui_story"]) and arg_228_1.var_.characterEffect1033ui_story then
				arg_228_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_231_2 = 0
			local var_231_3 = 0.475

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_4 = arg_228_1:GetWordFromCfg(924011055)
				local var_231_5 = arg_228_1:FormatText(var_231_4.content)

				arg_228_1.text_.text = var_231_5

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_7 = 19 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 19)

				if (19 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 19)) > 0 and var_231_3 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_2
					end
				end

				arg_228_1.text_.text = var_231_5
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb") / 1000

					if var_231_8 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_2
					end

					if var_231_4.prefab_name ~= "" and arg_228_1.actors_[var_231_4.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_4.prefab_name].transform, "story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb")

						arg_228_1:RecordAudio("924011055", var_231_9)
						arg_228_1:RecordAudio("924011055", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011055", "story_v_side_old_924011.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_3, arg_228_1.talkMaxDuration)

			if var_231_2 <= arg_228_1.time_ and arg_228_1.time_ < var_231_2 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_2) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_2 + var_231_10 and arg_228_1.time_ < var_231_2 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play924011056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 924011056
		arg_232_1.duration_ = 6.73

		local var_232_0 = {
			zh = 4.333,
			ja = 6.733
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play924011057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_235_0 = 0
			local var_235_1 = 0.675

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_2 = arg_232_1:GetWordFromCfg(924011056)
				local var_235_3 = arg_232_1:FormatText(var_235_2.content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 27 <= 0 and var_235_1 or var_235_1 * (utf8.len(var_235_3) / 27)

				if (27 <= 0 and var_235_1 or var_235_1 * (utf8.len(var_235_3) / 27)) > 0 and var_235_1 < var_235_5 then
					arg_232_1.talkMaxDuration = var_235_5

					if var_235_5 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb") ~= 0 then
					local var_235_6 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb") / 1000

					if var_235_6 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_0
					end

					if var_235_2.prefab_name ~= "" and arg_232_1.actors_[var_235_2.prefab_name] ~= nil then
						local var_235_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_2.prefab_name].transform, "story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb")

						arg_232_1:RecordAudio("924011056", var_235_7)
						arg_232_1:RecordAudio("924011056", var_235_7)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011056", "story_v_side_old_924011.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_8 and arg_232_1.time_ < var_235_0 + var_235_8 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play924011057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 924011057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play924011058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1033ui_story = arg_236_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1033ui_story"].transform.position).z)
				arg_236_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1033ui_story"].transform.localEulerAngles = arg_236_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1033ui_story"].transform.position).z)
				arg_236_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1033ui_story"].transform.localEulerAngles = arg_236_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1033ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1033ui_story == nil then
				arg_236_1.var_.characterEffect1033ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1033ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_2)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1033ui_story then
				arg_236_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_239_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_236_1.bgmTxt_.text ~= var_239_5 and arg_236_1.bgmTxt_.text ~= "" then
						if arg_236_1.bgmTxt2_.text ~= "" then
							arg_236_1.bgmTxt_.text = arg_236_1.bgmTxt2_.text
						end

						arg_236_1.bgmTxt2_.text = var_239_5

						arg_236_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_236_1.bgmTxt_.text = var_239_5
						arg_236_1.bgmTxt2_.text = var_239_5
					end

					if arg_236_1.bgmTimer then
						arg_236_1.bgmTimer:Stop()

						arg_236_1.bgmTimer = nil
					end

					if arg_236_1.settingData.show_music_name == 1 then
						arg_236_1.musicController:SetSelectedState("show")
						arg_236_1.musicAnimator_:Play("open", 0, 0)

						if arg_236_1.settingData.music_time ~= 0 then
							arg_236_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_236_1.settingData.music_time), function()
								if arg_236_1 == nil or isNil(arg_236_1.bgmTxt_) then
									return
								end

								arg_236_1.musicController:SetSelectedState("hide")
								arg_236_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_239_6 = 0
			local var_239_7 = 1.325

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_8 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(924011057).content)

				arg_236_1.text_.text = var_239_8

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_10 = 53 <= 0 and var_239_7 or var_239_7 * (utf8.len(var_239_8) / 53)

				if (53 <= 0 and var_239_7 or var_239_7 * (utf8.len(var_239_8) / 53)) > 0 and var_239_7 < var_239_10 then
					arg_236_1.talkMaxDuration = var_239_10

					if var_239_10 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_8
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_11 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_11 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_11

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_11 and arg_236_1.time_ < var_239_6 + var_239_11 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play924011058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 924011058
		arg_241_1.duration_ = 9

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play924011059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if arg_241_1.bgs_.ST12 == nil then
				local var_244_0 = Object.Instantiate(arg_241_1.paintGo_)

				var_244_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_244_0.name = "ST12"
				var_244_0.transform.parent = arg_241_1.stage_.transform
				var_244_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.bgs_.ST12 = var_244_0
			end

			if 2 < arg_241_1.time_ and arg_241_1.time_ <= 2 + arg_244_0 then
				local var_244_1 = arg_241_1.bgs_.ST12

				arg_241_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_244_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_244_2 = var_244_1:GetComponent("SpriteRenderer")

				if var_244_2 and var_244_2.sprite then
					local var_244_3 = 2 * (var_244_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_244_1.transform.localScale = Vector3.New(var_244_3 / var_244_2.sprite.bounds.size.y < var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x and var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x or var_244_3 / var_244_2.sprite.bounds.size.y, var_244_3 / var_244_2.sprite.bounds.size.y < var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x and var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x or var_244_3 / var_244_2.sprite.bounds.size.y, 0)
				end

				for iter_244_0, iter_244_1 in pairs(arg_241_1.bgs_) do
					if iter_244_0 ~= "ST12" then
						iter_244_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_244_4 = 4

			if 4 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			if arg_241_1.time_ >= var_244_4 + 0.3 and arg_241_1.time_ < var_244_4 + 0.3 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_5 = 0

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_6 = 2

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 then
				local var_244_7 = Color.New(0, 0, 0)

				var_244_7.a = Mathf.Lerp(0, 1, (arg_241_1.time_ - var_244_5) / var_244_6)
				arg_241_1.mask_.color = var_244_7
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 then
				local var_244_8 = Color.New(0, 0, 0)

				var_244_8.a = 1
				arg_241_1.mask_.color = var_244_8
			end

			local var_244_9 = 2

			if 2 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_10 = 2

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_10 then
				local var_244_11 = Color.New(0, 0, 0)

				var_244_11.a = Mathf.Lerp(1, 0, (arg_241_1.time_ - var_244_9) / var_244_10)
				arg_241_1.mask_.color = var_244_11
			end

			if arg_241_1.time_ >= var_244_9 + var_244_10 and arg_241_1.time_ < var_244_9 + var_244_10 + arg_244_0 then
				local var_244_12 = Color.New(0, 0, 0)

				arg_241_1.mask_.enabled = false
				var_244_12.a = 0
				arg_241_1.mask_.color = var_244_12
			end

			if 0.125 < arg_241_1.time_ and arg_241_1.time_ <= 0.125 + arg_244_0 then
				arg_241_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.6 < arg_241_1.time_ and arg_241_1.time_ <= 1.6 + arg_244_0 then
				arg_241_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 4 < arg_241_1.time_ and arg_241_1.time_ <= 4 + arg_244_0 then
				arg_241_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_door", "")
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_16 = 4
			local var_244_17 = 0.7

			if 4 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_18 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_18:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_19 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(924011058).content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_21 = 28 <= 0 and var_244_17 or var_244_17 * (utf8.len(var_244_19) / 28)

				if (28 <= 0 and var_244_17 or var_244_17 * (utf8.len(var_244_19) / 28)) > 0 and var_244_17 < var_244_21 then
					arg_241_1.talkMaxDuration = var_244_21
					var_244_16 = var_244_16 + 0.3

					if var_244_21 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_21 + var_244_16
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_22 = var_244_16 + 0.3
			local var_244_23 = math.max(var_244_17, arg_241_1.talkMaxDuration)

			if var_244_16 + 0.3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_22 + var_244_23 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_22) / var_244_23

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_22 + var_244_23 and arg_241_1.time_ < var_244_22 + var_244_23 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play924011059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 924011059
		arg_247_1.duration_ = 1.47

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play924011060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_250_0 = 0.6

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				local var_250_1, var_250_2 = math.modf((arg_247_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_250_2 * 0.13, var_250_2 * 0.13, var_250_2 * 0.13) + arg_247_1.var_.shakeOldPos
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				manager.ui.mainCamera.transform.localPosition = arg_247_1.var_.shakeOldPos
			end

			local var_250_3 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			if arg_247_1.time_ >= var_250_3 + 0.6 and arg_247_1.time_ < var_250_3 + 0.6 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_250_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_6 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_6

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_6
						arg_247_1.bgmTxt2_.text = var_250_6
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_247_1.time_ and arg_247_1.time_ <= 0.4 + arg_250_0 then
				arg_247_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_250_9 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_9 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_9

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_9
						arg_247_1.bgmTxt2_.text = var_250_9
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_250_10 = 0
			local var_250_11 = 0.075

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_12 = arg_247_1:GetWordFromCfg(924011059)
				local var_250_13 = arg_247_1:FormatText(var_250_12.content)

				arg_247_1.text_.text = var_250_13

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_15 = 3 <= 0 and var_250_11 or var_250_11 * (utf8.len(var_250_13) / 3)

				if (3 <= 0 and var_250_11 or var_250_11 * (utf8.len(var_250_13) / 3)) > 0 and var_250_11 < var_250_15 then
					arg_247_1.talkMaxDuration = var_250_15

					if var_250_15 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_15 + var_250_10
					end
				end

				arg_247_1.text_.text = var_250_13
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb") ~= 0 then
					local var_250_16 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb") / 1000

					if var_250_16 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_16 + var_250_10
					end

					if var_250_12.prefab_name ~= "" and arg_247_1.actors_[var_250_12.prefab_name] ~= nil then
						local var_250_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_12.prefab_name].transform, "story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb")

						arg_247_1:RecordAudio("924011059", var_250_17)
						arg_247_1:RecordAudio("924011059", var_250_17)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011059", "story_v_side_old_924011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_18 = math.max(var_250_11, arg_247_1.talkMaxDuration)

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_18 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_10) / var_250_18

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_10 + var_250_18 and arg_247_1.time_ < var_250_10 + var_250_18 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play924011060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 924011060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play924011061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.075

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(924011060).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 3 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 3)

				if (3 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 3)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play924011061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 924011061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play924011062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0.2 < arg_257_1.time_ and arg_257_1.time_ <= 0.2 + arg_260_0 then
				arg_257_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_hug", "")
			end

			local var_260_1 = 0
			local var_260_2 = 1

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(924011061).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 40 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 40)

				if (40 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 40)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play924011062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 924011062
		arg_261_1.duration_ = 6

		local var_261_0 = {
			zh = 4.8,
			ja = 6
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
				arg_261_0:Play924011063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if arg_261_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_264_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_261_1.stage_.transform)

				var_264_0.name = "1020ui_story"
				var_264_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1020ui_story"] = var_264_0

				local var_264_1 = var_264_0:GetComponentInChildren(typeof(CharacterEffect))

				var_264_1.enabled = true

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_0, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end

				arg_261_1:ShowWeapon(var_264_1.transform, false)

				arg_261_1.var_["1020ui_story" .. "Animator"] = var_264_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_261_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_261_1.var_["1020ui_story" .. "LipSync"] = var_264_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_264_3 = arg_261_1.actors_["1020ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1020ui_story = var_264_3.localPosition
			end

			local var_264_4 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				var_264_3.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_261_1.time_ - 0) / var_264_4)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				var_264_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			local var_264_5 = arg_261_1.actors_["1020ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1020ui_story == nil then
				arg_261_1.var_.characterEffect1020ui_story = var_264_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.characterEffect1020ui_story and not isNil(var_264_5) then
					arg_261_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1020ui_story then
				arg_261_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_264_8 = 0
			local var_264_9 = 0.45

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_10 = arg_261_1:GetWordFromCfg(924011062)
				local var_264_11 = arg_261_1:FormatText(var_264_10.content)

				arg_261_1.text_.text = var_264_11

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 18 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 18)

				if (18 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 18)) > 0 and var_264_9 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_11
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb") / 1000

					if var_264_14 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_8
					end

					if var_264_10.prefab_name ~= "" and arg_261_1.actors_[var_264_10.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_10.prefab_name].transform, "story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb")

						arg_261_1:RecordAudio("924011062", var_264_15)
						arg_261_1:RecordAudio("924011062", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011062", "story_v_side_old_924011.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_16 and arg_261_1.time_ < var_264_8 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 924011063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play924011064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) and arg_265_1.var_.characterEffect1020ui_story == nil then
				arg_265_1.var_.characterEffect1020ui_story = arg_265_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) then
				if arg_265_1.var_.characterEffect1020ui_story and not isNil(arg_265_1.actors_["1020ui_story"]) then
					arg_265_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) and arg_265_1.var_.characterEffect1020ui_story then
				arg_265_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 0.2

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(924011063).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 8 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 8)

				if (8 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 8)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play924011064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 924011064
		arg_269_1.duration_ = 2

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play924011065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) and arg_269_1.var_.characterEffect1020ui_story == nil then
				arg_269_1.var_.characterEffect1020ui_story = arg_269_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) then
				if arg_269_1.var_.characterEffect1020ui_story and not isNil(arg_269_1.actors_["1020ui_story"]) then
					arg_269_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) and arg_269_1.var_.characterEffect1020ui_story then
				arg_269_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_272_2 = 0
			local var_272_3 = 0.1

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:GetWordFromCfg(924011064)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 4 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 4)

				if (4 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 4)) > 0 and var_272_3 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb") / 1000

					if var_272_8 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_2
					end

					if var_272_4.prefab_name ~= "" and arg_269_1.actors_[var_272_4.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_4.prefab_name].transform, "story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb")

						arg_269_1:RecordAudio("924011064", var_272_9)
						arg_269_1:RecordAudio("924011064", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011064", "story_v_side_old_924011.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_10 and arg_269_1.time_ < var_272_2 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play924011065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 924011065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play924011066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1020ui_story = arg_273_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).z)
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles = arg_273_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).z)
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles = arg_273_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 1.4

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(924011065).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 56 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 56)

				if (56 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 56)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 924011066
		arg_277_1.duration_ = 6.3

		local var_277_0 = {
			zh = 4.333,
			ja = 6.3
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play924011067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1020ui_story = arg_277_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1020ui_story"].transform.position).z)
				arg_277_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1020ui_story"].transform.localEulerAngles = arg_277_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_277_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1020ui_story"].transform.position).z)
				arg_277_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1020ui_story"].transform.localEulerAngles = arg_277_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1020ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1020ui_story == nil then
				arg_277_1.var_.characterEffect1020ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1020ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1020ui_story then
				arg_277_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_280_4 = 0
			local var_280_5 = 0.5

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(924011066)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 20 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 20)

				if (20 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 20)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb")

						arg_277_1:RecordAudio("924011066", var_280_11)
						arg_277_1:RecordAudio("924011066", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011066", "story_v_side_old_924011.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 924011067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play924011068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1020ui_story"]) and arg_281_1.var_.characterEffect1020ui_story == nil then
				arg_281_1.var_.characterEffect1020ui_story = arg_281_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1020ui_story"]) then
				if arg_281_1.var_.characterEffect1020ui_story and not isNil(arg_281_1.actors_["1020ui_story"]) then
					arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_0)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1020ui_story"]) and arg_281_1.var_.characterEffect1020ui_story then
				arg_281_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_284_1 = 0
			local var_284_2 = 0.4

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(924011067).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 16 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 16)

				if (16 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 16)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play924011068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 924011068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play924011069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.3

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(924011068).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 12 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 12)

				if (12 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 12)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play924011069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 924011069
		arg_289_1.duration_ = 6.53

		local var_289_0 = {
			zh = 3.066,
			ja = 6.533
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
				arg_289_0:Play924011070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1020ui_story = arg_289_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).z)
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles = arg_289_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_289_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).z)
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles = arg_289_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1020ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1020ui_story == nil then
				arg_289_1.var_.characterEffect1020ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1020ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1020ui_story then
				arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_292_4 = 0
			local var_292_5 = 0.35

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(924011069)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 14 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 14)

				if (14 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 14)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb")

						arg_289_1:RecordAudio("924011069", var_292_11)
						arg_289_1:RecordAudio("924011069", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011069", "story_v_side_old_924011.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play924011070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 924011070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play924011071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story == nil then
				arg_293_1.var_.characterEffect1020ui_story = arg_293_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) then
				if arg_293_1.var_.characterEffect1020ui_story and not isNil(arg_293_1.actors_["1020ui_story"]) then
					arg_293_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story then
				arg_293_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.775

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(924011070).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 31 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 31)

				if (31 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 31)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play924011071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 924011071
		arg_297_1.duration_ = 6.47

		local var_297_0 = {
			zh = 4.8,
			ja = 6.466
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play924011072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1020ui_story = arg_297_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).z)
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles = arg_297_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_297_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1020ui_story"].transform.position).z)
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1020ui_story"].transform.localEulerAngles = arg_297_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1020ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1020ui_story == nil then
				arg_297_1.var_.characterEffect1020ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1020ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1020ui_story then
				arg_297_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action10_1")
			end

			local var_300_4 = 0
			local var_300_5 = 0.325

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(924011071)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 13 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 13)

				if (13 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 13)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb")

						arg_297_1:RecordAudio("924011071", var_300_11)
						arg_297_1:RecordAudio("924011071", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011071", "story_v_side_old_924011.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play924011072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 924011072
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play924011073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1020ui_story = arg_301_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).z)
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles = arg_301_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).z)
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles = arg_301_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1020ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1020ui_story == nil then
				arg_301_1.var_.characterEffect1020ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1020ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_2)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1020ui_story then
				arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_304_3 = 0
			local var_304_4 = 0.85

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_3 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_5 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(924011072).content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 34 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_5) / 34)

				if (34 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_5) / 34)) > 0 and var_304_4 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_3 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_3
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_4, arg_301_1.talkMaxDuration)

			if var_304_3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_3 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_3) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_3 + var_304_8 and arg_301_1.time_ < var_304_3 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play924011073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 924011073
		arg_305_1.duration_ = 7.8

		local var_305_0 = {
			zh = 4.833,
			ja = 7.8
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play924011074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1020ui_story = arg_305_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1020ui_story"].transform.position).z)
				arg_305_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1020ui_story"].transform.localEulerAngles = arg_305_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_305_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1020ui_story"].transform.position).z)
				arg_305_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1020ui_story"].transform.localEulerAngles = arg_305_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1020ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1020ui_story == nil then
				arg_305_1.var_.characterEffect1020ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1020ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1020ui_story then
				arg_305_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4104")
			end

			local var_308_4 = 0
			local var_308_5 = 0.45

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(924011073)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 18 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 18)

				if (18 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 18)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb")

						arg_305_1:RecordAudio("924011073", var_308_11)
						arg_305_1:RecordAudio("924011073", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011073", "story_v_side_old_924011.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play924011074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 924011074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play924011075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1020ui_story"]) and arg_309_1.var_.characterEffect1020ui_story == nil then
				arg_309_1.var_.characterEffect1020ui_story = arg_309_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1020ui_story"]) then
				if arg_309_1.var_.characterEffect1020ui_story and not isNil(arg_309_1.actors_["1020ui_story"]) then
					arg_309_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_0)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1020ui_story"]) and arg_309_1.var_.characterEffect1020ui_story then
				arg_309_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_312_1 = 0
			local var_312_2 = 0.075

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(924011074).content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 3 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 3)

				if (3 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 3)) > 0 and var_312_2 < var_312_5 then
					arg_309_1.talkMaxDuration = var_312_5

					if var_312_5 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_6 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_6 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_6

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_6 and arg_309_1.time_ < var_312_1 + var_312_6 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play924011075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 924011075
		arg_313_1.duration_ = 8

		local var_313_0 = {
			zh = 5.3,
			ja = 8
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
				arg_313_0:Play924011076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1020ui_story = arg_313_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1020ui_story"].transform.position).z)
				arg_313_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1020ui_story"].transform.localEulerAngles = arg_313_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_313_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1020ui_story"].transform.position).z)
				arg_313_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1020ui_story"].transform.localEulerAngles = arg_313_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1020ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1020ui_story == nil then
				arg_313_1.var_.characterEffect1020ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1020ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1020ui_story then
				arg_313_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4411")
			end

			local var_316_4 = 0
			local var_316_5 = 0.5

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(924011075)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 20 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 20)

				if (20 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 20)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb")

						arg_313_1:RecordAudio("924011075", var_316_11)
						arg_313_1:RecordAudio("924011075", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011075", "story_v_side_old_924011.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play924011076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 924011076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play924011077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1020ui_story"]) and arg_317_1.var_.characterEffect1020ui_story == nil then
				arg_317_1.var_.characterEffect1020ui_story = arg_317_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1020ui_story"]) then
				if arg_317_1.var_.characterEffect1020ui_story and not isNil(arg_317_1.actors_["1020ui_story"]) then
					arg_317_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1020ui_story"]) and arg_317_1.var_.characterEffect1020ui_story then
				arg_317_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.05

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(924011076).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 2 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 2)

				if (2 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 2)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play924011077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 924011077
		arg_321_1.duration_ = 9.5

		local var_321_0 = {
			zh = 7.166,
			ja = 9.5
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play924011078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1020ui_story = arg_321_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1020ui_story"].transform.position).z)
				arg_321_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1020ui_story"].transform.localEulerAngles = arg_321_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_321_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1020ui_story"].transform.position).z)
				arg_321_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1020ui_story"].transform.localEulerAngles = arg_321_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1020ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1020ui_story == nil then
				arg_321_1.var_.characterEffect1020ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1020ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1020ui_story then
				arg_321_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action11_2")
			end

			local var_324_4 = 0
			local var_324_5 = 0.725

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(924011077)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 29 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 29)

				if (29 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 29)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb")

						arg_321_1:RecordAudio("924011077", var_324_11)
						arg_321_1:RecordAudio("924011077", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011077", "story_v_side_old_924011.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play924011078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 924011078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play924011079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1020ui_story"]) and arg_325_1.var_.characterEffect1020ui_story == nil then
				arg_325_1.var_.characterEffect1020ui_story = arg_325_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1020ui_story"]) then
				if arg_325_1.var_.characterEffect1020ui_story and not isNil(arg_325_1.actors_["1020ui_story"]) then
					arg_325_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1020ui_story"]) and arg_325_1.var_.characterEffect1020ui_story then
				arg_325_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 0.425

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(924011078).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 17 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 17)

				if (17 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 17)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play924011079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 924011079
		arg_329_1.duration_ = 7.83

		local var_329_0 = {
			zh = 5.1,
			ja = 7.833
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play924011080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1020ui_story = arg_329_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1020ui_story"].transform.position).z)
				arg_329_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1020ui_story"].transform.localEulerAngles = arg_329_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_329_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1020ui_story"].transform.position).z)
				arg_329_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1020ui_story"].transform.localEulerAngles = arg_329_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1020ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1020ui_story == nil then
				arg_329_1.var_.characterEffect1020ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1020ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1020ui_story then
				arg_329_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_332_4 = 0
			local var_332_5 = 0.725

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(924011079)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 29 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 29)

				if (29 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 29)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb")

						arg_329_1:RecordAudio("924011079", var_332_11)
						arg_329_1:RecordAudio("924011079", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011079", "story_v_side_old_924011.awb")
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
				actorName = "1020ui_story",
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
	Play924011080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 924011080
		arg_333_1.duration_ = 7.03

		local var_333_0 = {
			zh = 4.166,
			ja = 7.033
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
				arg_333_0:Play924011081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_336_0 = 0
			local var_336_1 = 0.55

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_2 = arg_333_1:GetWordFromCfg(924011080)
				local var_336_3 = arg_333_1:FormatText(var_336_2.content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 22 <= 0 and var_336_1 or var_336_1 * (utf8.len(var_336_3) / 22)

				if (22 <= 0 and var_336_1 or var_336_1 * (utf8.len(var_336_3) / 22)) > 0 and var_336_1 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb") ~= 0 then
					local var_336_6 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb") / 1000

					if var_336_6 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_0
					end

					if var_336_2.prefab_name ~= "" and arg_333_1.actors_[var_336_2.prefab_name] ~= nil then
						local var_336_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_2.prefab_name].transform, "story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb")

						arg_333_1:RecordAudio("924011080", var_336_7)
						arg_333_1:RecordAudio("924011080", var_336_7)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011080", "story_v_side_old_924011.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_8 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_8 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_8

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_8 and arg_333_1.time_ < var_336_0 + var_336_8 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play924011081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 924011081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play924011082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1020ui_story"]) and arg_337_1.var_.characterEffect1020ui_story == nil then
				arg_337_1.var_.characterEffect1020ui_story = arg_337_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1020ui_story"]) then
				if arg_337_1.var_.characterEffect1020ui_story and not isNil(arg_337_1.actors_["1020ui_story"]) then
					arg_337_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1020ui_story"]) and arg_337_1.var_.characterEffect1020ui_story then
				arg_337_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.325

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(924011081).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 13 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 13)

				if (13 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 13)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play924011082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 924011082
		arg_341_1.duration_ = 2.23

		local var_341_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_341_0:Play924011083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1020ui_story = arg_341_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1020ui_story"].transform.position).z)
				arg_341_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1020ui_story"].transform.localEulerAngles = arg_341_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_341_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1020ui_story"].transform.position).z)
				arg_341_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1020ui_story"].transform.localEulerAngles = arg_341_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1020ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1020ui_story == nil then
				arg_341_1.var_.characterEffect1020ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1020ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1020ui_story then
				arg_341_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			local var_344_4 = 0
			local var_344_5 = 0.125

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(924011082)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 5 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 5)

				if (5 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 5)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb")

						arg_341_1:RecordAudio("924011082", var_344_11)
						arg_341_1:RecordAudio("924011082", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011082", "story_v_side_old_924011.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 924011083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play924011084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1020ui_story"]) and arg_345_1.var_.characterEffect1020ui_story == nil then
				arg_345_1.var_.characterEffect1020ui_story = arg_345_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1020ui_story"]) then
				if arg_345_1.var_.characterEffect1020ui_story and not isNil(arg_345_1.actors_["1020ui_story"]) then
					arg_345_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1020ui_story"]) and arg_345_1.var_.characterEffect1020ui_story then
				arg_345_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.95

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(924011083).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 38 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 38)

				if (38 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 38)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play924011084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 924011084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play924011085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.5

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(924011084).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 20 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 20)

				if (20 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 20)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play924011085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 924011085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play924011086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1020ui_story = arg_353_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1020ui_story"].transform.position).z)
				arg_353_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1020ui_story"].transform.localEulerAngles = arg_353_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1020ui_story"].transform.position).z)
				arg_353_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1020ui_story"].transform.localEulerAngles = arg_353_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if 0.633333333333333 < arg_353_1.time_ and arg_353_1.time_ <= 0.633333333333333 + arg_356_0 then
				arg_353_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_phone", "")
			end

			local var_356_2 = 0
			local var_356_3 = 1

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_4 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(924011085).content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_6 = 40 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_4) / 40)

				if (40 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_4) / 40)) > 0 and var_356_3 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_7 and arg_353_1.time_ < var_356_2 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924011086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 924011086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play924011087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0.125 < arg_357_1.time_ and arg_357_1.time_ <= 0.125 + arg_360_0 then
				arg_357_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_run", "")
			end

			local var_360_1 = 0
			local var_360_2 = 0.9

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_3 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(924011086).content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 36 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 36)

				if (36 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 36)) > 0 and var_360_2 < var_360_5 then
					arg_357_1.talkMaxDuration = var_360_5

					if var_360_5 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + var_360_1
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_6 = math.max(var_360_2, arg_357_1.talkMaxDuration)

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_6 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_1) / var_360_6

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_1 + var_360_6 and arg_357_1.time_ < var_360_1 + var_360_6 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play924011087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 924011087
		arg_361_1.duration_ = 4.97

		local var_361_0 = {
			zh = 2.866,
			ja = 4.966
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
				arg_361_0:Play924011088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1020ui_story = arg_361_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1020ui_story"].transform.position).z)
				arg_361_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1020ui_story"].transform.localEulerAngles = arg_361_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_361_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1020ui_story"].transform.position).z)
				arg_361_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1020ui_story"].transform.localEulerAngles = arg_361_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_364_1 = arg_361_1.actors_["1020ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1020ui_story == nil then
				arg_361_1.var_.characterEffect1020ui_story = var_364_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 and not isNil(var_364_1) then
				if arg_361_1.var_.characterEffect1020ui_story and not isNil(var_364_1) then
					arg_361_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1020ui_story then
				arg_361_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_364_4 = 0
			local var_364_5 = 0.275

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_6 = arg_361_1:GetWordFromCfg(924011087)
				local var_364_7 = arg_361_1:FormatText(var_364_6.content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 11 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 11)

				if (11 <= 0 and var_364_5 or var_364_5 * (utf8.len(var_364_7) / 11)) > 0 and var_364_5 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_4
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb") ~= 0 then
					local var_364_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb") / 1000

					if var_364_10 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_4
					end

					if var_364_6.prefab_name ~= "" and arg_361_1.actors_[var_364_6.prefab_name] ~= nil then
						local var_364_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_6.prefab_name].transform, "story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb")

						arg_361_1:RecordAudio("924011087", var_364_11)
						arg_361_1:RecordAudio("924011087", var_364_11)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011087", "story_v_side_old_924011.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_12 = math.max(var_364_5, arg_361_1.talkMaxDuration)

			if var_364_4 <= arg_361_1.time_ and arg_361_1.time_ < var_364_4 + var_364_12 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_4) / var_364_12

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_4 + var_364_12 and arg_361_1.time_ < var_364_4 + var_364_12 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play924011088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 924011088
		arg_365_1.duration_ = 9.1

		local var_365_0 = {
			zh = 6.766,
			ja = 9.1
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
				arg_365_0:Play924011089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.6

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(924011088)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 24 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 24)

				if (24 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 24)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb")

						arg_365_1:RecordAudio("924011088", var_368_6)
						arg_365_1:RecordAudio("924011088", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011088", "story_v_side_old_924011.awb")
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
	Play924011089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 924011089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play924011090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1020ui_story"]) and arg_369_1.var_.characterEffect1020ui_story == nil then
				arg_369_1.var_.characterEffect1020ui_story = arg_369_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1020ui_story"]) then
				if arg_369_1.var_.characterEffect1020ui_story and not isNil(arg_369_1.actors_["1020ui_story"]) then
					arg_369_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1020ui_story"]) and arg_369_1.var_.characterEffect1020ui_story then
				arg_369_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.75

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
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

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(924011089).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 30 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 30)

				if (30 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 30)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play924011090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 924011090
		arg_373_1.duration_ = 6.9

		local var_373_0 = {
			zh = 6.9,
			ja = 6.533
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
				arg_373_0:Play924011091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1020ui_story"]) and arg_373_1.var_.characterEffect1020ui_story == nil then
				arg_373_1.var_.characterEffect1020ui_story = arg_373_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1020ui_story"]) then
				if arg_373_1.var_.characterEffect1020ui_story and not isNil(arg_373_1.actors_["1020ui_story"]) then
					arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1020ui_story"]) and arg_373_1.var_.characterEffect1020ui_story then
				arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action484")
			end

			local var_376_2 = 0
			local var_376_3 = 0.8

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(924011090)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 32 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 32)

				if (32 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 32)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb")

						arg_373_1:RecordAudio("924011090", var_376_9)
						arg_373_1:RecordAudio("924011090", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011090", "story_v_side_old_924011.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play924011091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 924011091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play924011092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) and arg_377_1.var_.characterEffect1020ui_story == nil then
				arg_377_1.var_.characterEffect1020ui_story = arg_377_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) then
				if arg_377_1.var_.characterEffect1020ui_story and not isNil(arg_377_1.actors_["1020ui_story"]) then
					arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) and arg_377_1.var_.characterEffect1020ui_story then
				arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 1.175

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(924011091).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 47 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 47)

				if (47 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 47)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play924011092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 924011092
		arg_381_1.duration_ = 3.27

		local var_381_0 = {
			zh = 2.466,
			ja = 3.266
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
				arg_381_0:Play924011093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1020ui_story"]) and arg_381_1.var_.characterEffect1020ui_story == nil then
				arg_381_1.var_.characterEffect1020ui_story = arg_381_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1020ui_story"]) then
				if arg_381_1.var_.characterEffect1020ui_story and not isNil(arg_381_1.actors_["1020ui_story"]) then
					arg_381_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1020ui_story"]) and arg_381_1.var_.characterEffect1020ui_story then
				arg_381_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			local var_384_2 = 0
			local var_384_3 = 0.175

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(924011092)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 7 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 7)

				if (7 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 7)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb")

						arg_381_1:RecordAudio("924011092", var_384_9)
						arg_381_1:RecordAudio("924011092", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011092", "story_v_side_old_924011.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_3, arg_381_1.talkMaxDuration)

			if var_384_2 <= arg_381_1.time_ and arg_381_1.time_ < var_384_2 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_2) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_2 + var_384_10 and arg_381_1.time_ < var_384_2 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play924011093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 924011093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play924011094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1020ui_story"]) and arg_385_1.var_.characterEffect1020ui_story == nil then
				arg_385_1.var_.characterEffect1020ui_story = arg_385_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1020ui_story"]) then
				if arg_385_1.var_.characterEffect1020ui_story and not isNil(arg_385_1.actors_["1020ui_story"]) then
					arg_385_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1020ui_story"]) and arg_385_1.var_.characterEffect1020ui_story then
				arg_385_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.325

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(924011093).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 13 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 13)

				if (13 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 13)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play924011094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 924011094
		arg_389_1.duration_ = 7

		local var_389_0 = {
			zh = 5,
			ja = 7
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
				arg_389_0:Play924011095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1020ui_story"]) and arg_389_1.var_.characterEffect1020ui_story == nil then
				arg_389_1.var_.characterEffect1020ui_story = arg_389_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1020ui_story"]) then
				if arg_389_1.var_.characterEffect1020ui_story and not isNil(arg_389_1.actors_["1020ui_story"]) then
					arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1020ui_story"]) and arg_389_1.var_.characterEffect1020ui_story then
				arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_392_2 = 0
			local var_392_3 = 0.5

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(924011094)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 20 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 20)

				if (20 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 20)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb")

						arg_389_1:RecordAudio("924011094", var_392_9)
						arg_389_1:RecordAudio("924011094", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011094", "story_v_side_old_924011.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_10 and arg_389_1.time_ < var_392_2 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play924011095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 924011095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play924011096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1020ui_story"]) and arg_393_1.var_.characterEffect1020ui_story == nil then
				arg_393_1.var_.characterEffect1020ui_story = arg_393_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1020ui_story"]) then
				if arg_393_1.var_.characterEffect1020ui_story and not isNil(arg_393_1.actors_["1020ui_story"]) then
					arg_393_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1020ui_story"]) and arg_393_1.var_.characterEffect1020ui_story then
				arg_393_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.2

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(924011095).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 8 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 8)

				if (8 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 8)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play924011096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 924011096
		arg_397_1.duration_ = 10.07

		local var_397_0 = {
			zh = 5.6,
			ja = 10.066
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
				arg_397_0:Play924011097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1020ui_story"]) and arg_397_1.var_.characterEffect1020ui_story == nil then
				arg_397_1.var_.characterEffect1020ui_story = arg_397_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1020ui_story"]) then
				if arg_397_1.var_.characterEffect1020ui_story and not isNil(arg_397_1.actors_["1020ui_story"]) then
					arg_397_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1020ui_story"]) and arg_397_1.var_.characterEffect1020ui_story then
				arg_397_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_400_2 = 0
			local var_400_3 = 0.7

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:GetWordFromCfg(924011096)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 28 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 28)

				if (28 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 28)) > 0 and var_400_3 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb") / 1000

					if var_400_8 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_2
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb")

						arg_397_1:RecordAudio("924011096", var_400_9)
						arg_397_1:RecordAudio("924011096", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011096", "story_v_side_old_924011.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_10 and arg_397_1.time_ < var_400_2 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play924011097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 924011097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play924011098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1020ui_story"]) and arg_401_1.var_.characterEffect1020ui_story == nil then
				arg_401_1.var_.characterEffect1020ui_story = arg_401_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1020ui_story"]) then
				if arg_401_1.var_.characterEffect1020ui_story and not isNil(arg_401_1.actors_["1020ui_story"]) then
					arg_401_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1020ui_story"]) and arg_401_1.var_.characterEffect1020ui_story then
				arg_401_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_404_1 = 0
			local var_404_2 = 0.45

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_3 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(924011097).content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 18 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 18)

				if (18 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 18)) > 0 and var_404_2 < var_404_5 then
					arg_401_1.talkMaxDuration = var_404_5

					if var_404_5 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_6 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_6 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_6

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_6 and arg_401_1.time_ < var_404_1 + var_404_6 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play924011098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 924011098
		arg_405_1.duration_ = 12.3

		local var_405_0 = {
			zh = 8.8,
			ja = 12.3
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play924011099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1020ui_story = arg_405_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1020ui_story"].transform.position).z)
				arg_405_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1020ui_story"].transform.localEulerAngles = arg_405_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_405_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1020ui_story"].transform.position).z)
				arg_405_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1020ui_story"].transform.localEulerAngles = arg_405_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1020ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1020ui_story == nil then
				arg_405_1.var_.characterEffect1020ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1020ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1020ui_story then
				arg_405_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action436")
			end

			local var_408_4 = 0
			local var_408_5 = 0.725

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(924011098)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 29 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 29)

				if (29 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 29)) > 0 and var_408_5 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb") / 1000

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end

					if var_408_6.prefab_name ~= "" and arg_405_1.actors_[var_408_6.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_6.prefab_name].transform, "story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb")

						arg_405_1:RecordAudio("924011098", var_408_11)
						arg_405_1:RecordAudio("924011098", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011098", "story_v_side_old_924011.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_12 and arg_405_1.time_ < var_408_4 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play924011099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 924011099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play924011100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1020ui_story"]) and arg_409_1.var_.characterEffect1020ui_story == nil then
				arg_409_1.var_.characterEffect1020ui_story = arg_409_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1020ui_story"]) then
				if arg_409_1.var_.characterEffect1020ui_story and not isNil(arg_409_1.actors_["1020ui_story"]) then
					arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1020ui_story"]) and arg_409_1.var_.characterEffect1020ui_story then
				arg_409_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.2

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(924011099).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 8 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 8)

				if (8 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 8)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play924011100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 924011100
		arg_413_1.duration_ = 5.2

		local var_413_0 = {
			zh = 3.733,
			ja = 5.2
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
				arg_413_0:Play924011101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1020ui_story"]) and arg_413_1.var_.characterEffect1020ui_story == nil then
				arg_413_1.var_.characterEffect1020ui_story = arg_413_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1020ui_story"]) then
				if arg_413_1.var_.characterEffect1020ui_story and not isNil(arg_413_1.actors_["1020ui_story"]) then
					arg_413_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1020ui_story"]) and arg_413_1.var_.characterEffect1020ui_story then
				arg_413_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action463")
			end

			local var_416_2 = 0
			local var_416_3 = 0.35

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_4 = arg_413_1:GetWordFromCfg(924011100)
				local var_416_5 = arg_413_1:FormatText(var_416_4.content)

				arg_413_1.text_.text = var_416_5

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_7 = 14 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 14)

				if (14 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 14)) > 0 and var_416_3 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_2
					end
				end

				arg_413_1.text_.text = var_416_5
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb") ~= 0 then
					local var_416_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb") / 1000

					if var_416_8 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_2
					end

					if var_416_4.prefab_name ~= "" and arg_413_1.actors_[var_416_4.prefab_name] ~= nil then
						local var_416_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_4.prefab_name].transform, "story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb")

						arg_413_1:RecordAudio("924011100", var_416_9)
						arg_413_1:RecordAudio("924011100", var_416_9)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011100", "story_v_side_old_924011.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_10 = math.max(var_416_3, arg_413_1.talkMaxDuration)

			if var_416_2 <= arg_413_1.time_ and arg_413_1.time_ < var_416_2 + var_416_10 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_2) / var_416_10

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_2 + var_416_10 and arg_413_1.time_ < var_416_2 + var_416_10 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play924011101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 924011101
		arg_417_1.duration_ = 1

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"

			SetActive(arg_417_1.choicesGo_, true)

			for iter_418_0, iter_418_1 in ipairs(arg_417_1.choices_) do
				SetActive(iter_418_1.go, iter_418_0 <= 1)
			end

			arg_417_1.choices_[1].txt.text = arg_417_1:FormatText(StoryChoiceCfg[1199].name)
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play924011102(arg_417_1)
			end

			arg_417_1:RecordChoiceLog(924011101, 1199)
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1020ui_story"]) and arg_417_1.var_.characterEffect1020ui_story == nil then
				arg_417_1.var_.characterEffect1020ui_story = arg_417_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1020ui_story"]) then
				if arg_417_1.var_.characterEffect1020ui_story and not isNil(arg_417_1.actors_["1020ui_story"]) then
					arg_417_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1020ui_story"]) and arg_417_1.var_.characterEffect1020ui_story then
				arg_417_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.allBtn_.enabled = false
			end

			if arg_417_1.time_ >= var_420_1 + 0.6 and arg_417_1.time_ < var_420_1 + 0.6 + arg_420_0 then
				arg_417_1.allBtn_.enabled = true
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play924011102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 924011102
		arg_421_1.duration_ = 7.3

		local var_421_0 = {
			zh = 4.533,
			ja = 7.3
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play924011103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1020ui_story = arg_421_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1020ui_story"].transform.position).z)
				arg_421_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1020ui_story"].transform.localEulerAngles = arg_421_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_421_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1020ui_story"].transform.position).z)
				arg_421_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1020ui_story"].transform.localEulerAngles = arg_421_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["1020ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1020ui_story == nil then
				arg_421_1.var_.characterEffect1020ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect1020ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1020ui_story then
				arg_421_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			local var_424_4 = 0
			local var_424_5 = 0.375

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_6 = arg_421_1:GetWordFromCfg(924011102)
				local var_424_7 = arg_421_1:FormatText(var_424_6.content)

				arg_421_1.text_.text = var_424_7

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_9 = 15 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 15)

				if (15 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 15)) > 0 and var_424_5 < var_424_9 then
					arg_421_1.talkMaxDuration = var_424_9

					if var_424_9 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_9 + var_424_4
					end
				end

				arg_421_1.text_.text = var_424_7
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb") ~= 0 then
					local var_424_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb") / 1000

					if var_424_10 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_4
					end

					if var_424_6.prefab_name ~= "" and arg_421_1.actors_[var_424_6.prefab_name] ~= nil then
						local var_424_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_6.prefab_name].transform, "story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb")

						arg_421_1:RecordAudio("924011102", var_424_11)
						arg_421_1:RecordAudio("924011102", var_424_11)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011102", "story_v_side_old_924011.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_12 = math.max(var_424_5, arg_421_1.talkMaxDuration)

			if var_424_4 <= arg_421_1.time_ and arg_421_1.time_ < var_424_4 + var_424_12 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_4) / var_424_12

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_4 + var_424_12 and arg_421_1.time_ < var_424_4 + var_424_12 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play924011103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 924011103
		arg_425_1.duration_ = 1

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"

			SetActive(arg_425_1.choicesGo_, true)

			for iter_426_0, iter_426_1 in ipairs(arg_425_1.choices_) do
				SetActive(iter_426_1.go, iter_426_0 <= 2)
			end

			arg_425_1.choices_[1].txt.text = arg_425_1:FormatText(StoryChoiceCfg[1200].name)
			arg_425_1.choices_[2].txt.text = arg_425_1:FormatText(StoryChoiceCfg[1201].name)
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play924011104(arg_425_1)
			end

			if arg_427_0 == 2 then
				arg_425_0:Play924011104(arg_425_1)
			end

			arg_425_1:RecordChoiceLog(924011103, 1200, 1201)
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1020ui_story"]) and arg_425_1.var_.characterEffect1020ui_story == nil then
				arg_425_1.var_.characterEffect1020ui_story = arg_425_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1020ui_story"]) then
				if arg_425_1.var_.characterEffect1020ui_story and not isNil(arg_425_1.actors_["1020ui_story"]) then
					arg_425_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1020ui_story"]) and arg_425_1.var_.characterEffect1020ui_story then
				arg_425_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			if arg_425_1.time_ >= var_428_1 + 0.6 and arg_425_1.time_ < var_428_1 + 0.6 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play924011104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 924011104
		arg_429_1.duration_ = 2

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play924011105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1020ui_story"]) and arg_429_1.var_.characterEffect1020ui_story == nil then
				arg_429_1.var_.characterEffect1020ui_story = arg_429_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1020ui_story"]) then
				if arg_429_1.var_.characterEffect1020ui_story and not isNil(arg_429_1.actors_["1020ui_story"]) then
					arg_429_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1020ui_story"]) and arg_429_1.var_.characterEffect1020ui_story then
				arg_429_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_432_2 = "1020ui_story"

			if arg_429_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_432_3 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_429_1.stage_.transform)

				var_432_3.name = var_432_2
				var_432_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.actors_[var_432_2] = var_432_3

				local var_432_4 = var_432_3:GetComponentInChildren(typeof(CharacterEffect))

				var_432_4.enabled = true

				local var_432_5 = GameObjectTools.GetOrAddComponent(var_432_3, typeof(DynamicBoneHelper))

				if var_432_5 then
					var_432_5:EnableDynamicBone(false)
				end

				arg_429_1:ShowWeapon(var_432_4.transform, false)

				arg_429_1.var_[var_432_2 .. "Animator"] = var_432_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_429_1.var_[var_432_2 .. "Animator"].applyRootMotion = true
				arg_429_1.var_[var_432_2 .. "LipSync"] = var_432_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_432_6 = "1020ui_story"

			if arg_429_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_432_7 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_429_1.stage_.transform)

				var_432_7.name = var_432_6
				var_432_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.actors_[var_432_6] = var_432_7

				local var_432_8 = var_432_7:GetComponentInChildren(typeof(CharacterEffect))

				var_432_8.enabled = true

				local var_432_9 = GameObjectTools.GetOrAddComponent(var_432_7, typeof(DynamicBoneHelper))

				if var_432_9 then
					var_432_9:EnableDynamicBone(false)
				end

				arg_429_1:ShowWeapon(var_432_8.transform, false)

				arg_429_1.var_[var_432_6 .. "Animator"] = var_432_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_429_1.var_[var_432_6 .. "Animator"].applyRootMotion = true
				arg_429_1.var_[var_432_6 .. "LipSync"] = var_432_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_432_10 = 0
			local var_432_11 = 0.125

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_12 = arg_429_1:GetWordFromCfg(924011104)
				local var_432_13 = arg_429_1:FormatText(var_432_12.content)

				arg_429_1.text_.text = var_432_13

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_15 = 5 <= 0 and var_432_11 or var_432_11 * (utf8.len(var_432_13) / 5)

				if (5 <= 0 and var_432_11 or var_432_11 * (utf8.len(var_432_13) / 5)) > 0 and var_432_11 < var_432_15 then
					arg_429_1.talkMaxDuration = var_432_15

					if var_432_15 + var_432_10 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_15 + var_432_10
					end
				end

				arg_429_1.text_.text = var_432_13
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb") ~= 0 then
					local var_432_16 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb") / 1000

					if var_432_16 + var_432_10 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_16 + var_432_10
					end

					if var_432_12.prefab_name ~= "" and arg_429_1.actors_[var_432_12.prefab_name] ~= nil then
						local var_432_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_12.prefab_name].transform, "story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb")

						arg_429_1:RecordAudio("924011104", var_432_17)
						arg_429_1:RecordAudio("924011104", var_432_17)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011104", "story_v_side_old_924011.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_18 = math.max(var_432_11, arg_429_1.talkMaxDuration)

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_18 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_10) / var_432_18

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_10 + var_432_18 and arg_429_1.time_ < var_432_10 + var_432_18 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play924011105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 924011105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play924011106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1020ui_story = arg_433_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1020ui_story"].transform.position).z)
				arg_433_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1020ui_story"].transform.localEulerAngles = arg_433_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_433_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1020ui_story"].transform.position).z)
				arg_433_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1020ui_story"].transform.localEulerAngles = arg_433_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1020ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1020ui_story == nil then
				arg_433_1.var_.characterEffect1020ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1020ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_2)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1020ui_story then
				arg_433_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_436_3 = 0
			local var_436_4 = 0.275

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_3 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_5 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(924011105).content)

				arg_433_1.text_.text = var_436_5

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_7 = 11 <= 0 and var_436_4 or var_436_4 * (utf8.len(var_436_5) / 11)

				if (11 <= 0 and var_436_4 or var_436_4 * (utf8.len(var_436_5) / 11)) > 0 and var_436_4 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_3 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_3
					end
				end

				arg_433_1.text_.text = var_436_5
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_8 = math.max(var_436_4, arg_433_1.talkMaxDuration)

			if var_436_3 <= arg_433_1.time_ and arg_433_1.time_ < var_436_3 + var_436_8 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_3) / var_436_8

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_3 + var_436_8 and arg_433_1.time_ < var_436_3 + var_436_8 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play924011106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 924011106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play924011107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0.9 < arg_437_1.time_ and arg_437_1.time_ <= 0.9 + arg_440_0 then
				arg_437_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_440_0 = 0.6

			if 0.9 <= arg_437_1.time_ and arg_437_1.time_ < 0.9 + var_440_0 then
				local var_440_1, var_440_2 = math.modf((arg_437_1.time_ - 0.9) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_440_2 * 0.13, var_440_2 * 0.13, var_440_2 * 0.13) + arg_437_1.var_.shakeOldPos
			end

			if arg_437_1.time_ >= 0.9 + var_440_0 and arg_437_1.time_ < 0.9 + var_440_0 + arg_440_0 then
				manager.ui.mainCamera.transform.localPosition = arg_437_1.var_.shakeOldPos
			end

			local var_440_3 = manager.ui.mainCamera.transform

			if 2 < arg_437_1.time_ and arg_437_1.time_ <= 2 + arg_440_0 then
				arg_437_1.var_.shakeOldPos = var_440_3.localPosition
			end

			local var_440_4 = 0.6

			if 2 <= arg_437_1.time_ and arg_437_1.time_ < 2 + var_440_4 then
				local var_440_5, var_440_6 = math.modf((arg_437_1.time_ - 2) / 0.066)

				var_440_3.localPosition = Vector3.New(var_440_6 * 0.13, var_440_6 * 0.13, var_440_6 * 0.13) + arg_437_1.var_.shakeOldPos
			end

			if arg_437_1.time_ >= 2 + var_440_4 and arg_437_1.time_ < 2 + var_440_4 + arg_440_0 then
				var_440_3.localPosition = arg_437_1.var_.shakeOldPos
			end

			local var_440_7 = 0

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_7 + arg_440_0 then
				arg_437_1.allBtn_.enabled = false
			end

			if arg_437_1.time_ >= var_440_7 + 2.6 and arg_437_1.time_ < var_440_7 + 2.6 + arg_440_0 then
				arg_437_1.allBtn_.enabled = true
			end

			local var_440_8 = 0
			local var_440_9 = 0.375

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_8 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_10 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(924011106).content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_12 = 15 <= 0 and var_440_9 or var_440_9 * (utf8.len(var_440_10) / 15)

				if (15 <= 0 and var_440_9 or var_440_9 * (utf8.len(var_440_10) / 15)) > 0 and var_440_9 < var_440_12 then
					arg_437_1.talkMaxDuration = var_440_12

					if var_440_12 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_12 + var_440_8
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_13 = math.max(var_440_9, arg_437_1.talkMaxDuration)

			if var_440_8 <= arg_437_1.time_ and arg_437_1.time_ < var_440_8 + var_440_13 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_8) / var_440_13

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_8 + var_440_13 and arg_437_1.time_ < var_440_8 + var_440_13 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play924011107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 924011107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play924011108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.525

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(924011107).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 21 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 21)

				if (21 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 21)) > 0 and var_444_0 < var_444_3 then
					arg_441_1.talkMaxDuration = var_444_3

					if var_444_3 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_3 + 0
					end
				end

				arg_441_1.text_.text = var_444_1
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_4 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_4

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play924011108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 924011108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play924011109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.975

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(924011108).content)

				arg_445_1.text_.text = var_448_1

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_3 = 39 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 39)

				if (39 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 39)) > 0 and var_448_0 < var_448_3 then
					arg_445_1.talkMaxDuration = var_448_3

					if var_448_3 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_3 + 0
					end
				end

				arg_445_1.text_.text = var_448_1
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_4 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_4

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play924011109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 924011109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play924011110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.625

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(924011109).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 25 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 25)

				if (25 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 25)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play924011110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 924011110
		arg_453_1.duration_ = 3.3

		local var_453_0 = {
			zh = 2.533,
			ja = 3.3
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play924011111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1020ui_story = arg_453_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1020ui_story"].transform.position).z)
				arg_453_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1020ui_story"].transform.localEulerAngles = arg_453_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_453_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1020ui_story"].transform.position).z)
				arg_453_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1020ui_story"].transform.localEulerAngles = arg_453_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1020ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1020ui_story == nil then
				arg_453_1.var_.characterEffect1020ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1020ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1020ui_story then
				arg_453_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_456_4 = 0
			local var_456_5 = 0.225

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_4 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_6 = arg_453_1:GetWordFromCfg(924011110)
				local var_456_7 = arg_453_1:FormatText(var_456_6.content)

				arg_453_1.text_.text = var_456_7

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_9 = 9 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 9)

				if (9 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 9)) > 0 and var_456_5 < var_456_9 then
					arg_453_1.talkMaxDuration = var_456_9

					if var_456_9 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_9 + var_456_4
					end
				end

				arg_453_1.text_.text = var_456_7
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb") ~= 0 then
					local var_456_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb") / 1000

					if var_456_10 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_4
					end

					if var_456_6.prefab_name ~= "" and arg_453_1.actors_[var_456_6.prefab_name] ~= nil then
						local var_456_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_6.prefab_name].transform, "story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb")

						arg_453_1:RecordAudio("924011110", var_456_11)
						arg_453_1:RecordAudio("924011110", var_456_11)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011110", "story_v_side_old_924011.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_12 = math.max(var_456_5, arg_453_1.talkMaxDuration)

			if var_456_4 <= arg_453_1.time_ and arg_453_1.time_ < var_456_4 + var_456_12 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_4) / var_456_12

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_4 + var_456_12 and arg_453_1.time_ < var_456_4 + var_456_12 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play924011111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 924011111
		arg_457_1.duration_ = 4.03

		local var_457_0 = {
			zh = 1.999999999999,
			ja = 4.033
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play924011112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_460_0 = 0
			local var_460_1 = 0.2

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_2 = arg_457_1:GetWordFromCfg(924011111)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 8 <= 0 and var_460_1 or var_460_1 * (utf8.len(var_460_3) / 8)

				if (8 <= 0 and var_460_1 or var_460_1 * (utf8.len(var_460_3) / 8)) > 0 and var_460_1 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb") ~= 0 then
					local var_460_6 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb") / 1000

					if var_460_6 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_0
					end

					if var_460_2.prefab_name ~= "" and arg_457_1.actors_[var_460_2.prefab_name] ~= nil then
						local var_460_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_2.prefab_name].transform, "story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb")

						arg_457_1:RecordAudio("924011111", var_460_7)
						arg_457_1:RecordAudio("924011111", var_460_7)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011111", "story_v_side_old_924011.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_8 and arg_457_1.time_ < var_460_0 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play924011112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 924011112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play924011113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1020ui_story"]) and arg_461_1.var_.characterEffect1020ui_story == nil then
				arg_461_1.var_.characterEffect1020ui_story = arg_461_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1020ui_story"]) then
				if arg_461_1.var_.characterEffect1020ui_story and not isNil(arg_461_1.actors_["1020ui_story"]) then
					arg_461_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1020ui_story"]) and arg_461_1.var_.characterEffect1020ui_story then
				arg_461_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.6

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(924011112).content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 24 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 24)

				if (24 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 24)) > 0 and var_464_2 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_6 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_6 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_6

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_6 and arg_461_1.time_ < var_464_1 + var_464_6 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play924011113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 924011113
		arg_465_1.duration_ = 7.83

		local var_465_0 = {
			zh = 5.5,
			ja = 7.833
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play924011114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1020ui_story = arg_465_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1020ui_story"].transform.position).z)
				arg_465_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1020ui_story"].transform.localEulerAngles = arg_465_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_465_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1020ui_story"].transform.position).z)
				arg_465_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1020ui_story"].transform.localEulerAngles = arg_465_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1020ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1020ui_story == nil then
				arg_465_1.var_.characterEffect1020ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1020ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1020ui_story then
				arg_465_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			local var_468_4 = 0
			local var_468_5 = 0.575

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:GetWordFromCfg(924011113)
				local var_468_7 = arg_465_1:FormatText(var_468_6.content)

				arg_465_1.text_.text = var_468_7

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_9 = 23 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 23)

				if (23 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 23)) > 0 and var_468_5 < var_468_9 then
					arg_465_1.talkMaxDuration = var_468_9

					if var_468_9 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_7
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb") ~= 0 then
					local var_468_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb") / 1000

					if var_468_10 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_10 + var_468_4
					end

					if var_468_6.prefab_name ~= "" and arg_465_1.actors_[var_468_6.prefab_name] ~= nil then
						local var_468_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_6.prefab_name].transform, "story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb")

						arg_465_1:RecordAudio("924011113", var_468_11)
						arg_465_1:RecordAudio("924011113", var_468_11)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011113", "story_v_side_old_924011.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_12 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_12 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_12

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_12 and arg_465_1.time_ < var_468_4 + var_468_12 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play924011114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 924011114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play924011115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1020ui_story"]) and arg_469_1.var_.characterEffect1020ui_story == nil then
				arg_469_1.var_.characterEffect1020ui_story = arg_469_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1020ui_story"]) then
				if arg_469_1.var_.characterEffect1020ui_story and not isNil(arg_469_1.actors_["1020ui_story"]) then
					arg_469_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1020ui_story"]) and arg_469_1.var_.characterEffect1020ui_story then
				arg_469_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.65

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(924011114).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 26 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 26)

				if (26 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 26)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play924011115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 924011115
		arg_473_1.duration_ = 5.27

		local var_473_0 = {
			zh = 3.033,
			ja = 5.266
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play924011116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1020ui_story = arg_473_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1020ui_story"].transform.position).z)
				arg_473_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1020ui_story"].transform.localEulerAngles = arg_473_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_473_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1020ui_story"].transform.position).z)
				arg_473_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1020ui_story"].transform.localEulerAngles = arg_473_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1020ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1020ui_story == nil then
				arg_473_1.var_.characterEffect1020ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1020ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1020ui_story then
				arg_473_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action486")
			end

			local var_476_4 = 0
			local var_476_5 = 0.3

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(924011115)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 12 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 12)

				if (12 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 12)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb")

						arg_473_1:RecordAudio("924011115", var_476_11)
						arg_473_1:RecordAudio("924011115", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011115", "story_v_side_old_924011.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play924011116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 924011116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play924011117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1020ui_story = arg_477_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1020ui_story"].transform.position).z)
				arg_477_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1020ui_story"].transform.localEulerAngles = arg_477_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_477_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1020ui_story"].transform.position).z)
				arg_477_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1020ui_story"].transform.localEulerAngles = arg_477_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1020ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1020ui_story == nil then
				arg_477_1.var_.characterEffect1020ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1020ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_2)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1020ui_story then
				arg_477_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_480_3 = 0
			local var_480_4 = 0.8

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_3 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_5 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(924011116).content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 32 <= 0 and var_480_4 or var_480_4 * (utf8.len(var_480_5) / 32)

				if (32 <= 0 and var_480_4 or var_480_4 * (utf8.len(var_480_5) / 32)) > 0 and var_480_4 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_3 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_3
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_4, arg_477_1.talkMaxDuration)

			if var_480_3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_3 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_3) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_3 + var_480_8 and arg_477_1.time_ < var_480_3 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play924011117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 924011117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play924011118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.375

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(924011117).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 15 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 15)

				if (15 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 15)) > 0 and var_484_0 < var_484_3 then
					arg_481_1.talkMaxDuration = var_484_3

					if var_484_3 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_3 + 0
					end
				end

				arg_481_1.text_.text = var_484_1
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_4 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_4

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play924011118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 924011118
		arg_485_1.duration_ = 6.5

		local var_485_0 = {
			zh = 3.033,
			ja = 6.5
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play924011119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1020ui_story = arg_485_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_485_1.time_ - 0) / var_488_0)
				arg_485_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1020ui_story"].transform.position).z)
				arg_485_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1020ui_story"].transform.localEulerAngles = arg_485_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_485_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1020ui_story"].transform.position).z)
				arg_485_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1020ui_story"].transform.localEulerAngles = arg_485_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_488_1 = arg_485_1.actors_["1020ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1020ui_story == nil then
				arg_485_1.var_.characterEffect1020ui_story = var_488_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 and not isNil(var_488_1) then
				if arg_485_1.var_.characterEffect1020ui_story and not isNil(var_488_1) then
					arg_485_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1020ui_story then
				arg_485_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_488_4 = 0
			local var_488_5 = 0.375

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_4 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_6 = arg_485_1:GetWordFromCfg(924011118)
				local var_488_7 = arg_485_1:FormatText(var_488_6.content)

				arg_485_1.text_.text = var_488_7

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_9 = 15 <= 0 and var_488_5 or var_488_5 * (utf8.len(var_488_7) / 15)

				if (15 <= 0 and var_488_5 or var_488_5 * (utf8.len(var_488_7) / 15)) > 0 and var_488_5 < var_488_9 then
					arg_485_1.talkMaxDuration = var_488_9

					if var_488_9 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_9 + var_488_4
					end
				end

				arg_485_1.text_.text = var_488_7
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb") ~= 0 then
					local var_488_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb") / 1000

					if var_488_10 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_10 + var_488_4
					end

					if var_488_6.prefab_name ~= "" and arg_485_1.actors_[var_488_6.prefab_name] ~= nil then
						local var_488_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_6.prefab_name].transform, "story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb")

						arg_485_1:RecordAudio("924011118", var_488_11)
						arg_485_1:RecordAudio("924011118", var_488_11)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011118", "story_v_side_old_924011.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_12 = math.max(var_488_5, arg_485_1.talkMaxDuration)

			if var_488_4 <= arg_485_1.time_ and arg_485_1.time_ < var_488_4 + var_488_12 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_4) / var_488_12

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_4 + var_488_12 and arg_485_1.time_ < var_488_4 + var_488_12 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play924011119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 924011119
		arg_489_1.duration_ = 9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play924011120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if arg_489_1.bgs_.ST01 == nil then
				local var_492_0 = Object.Instantiate(arg_489_1.paintGo_)

				var_492_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_492_0.name = "ST01"
				var_492_0.transform.parent = arg_489_1.stage_.transform
				var_492_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.bgs_.ST01 = var_492_0
			end

			if 1.999999999999 < arg_489_1.time_ and arg_489_1.time_ <= 1.999999999999 + arg_492_0 then
				local var_492_1 = arg_489_1.bgs_.ST01

				arg_489_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_492_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_2 = var_492_1:GetComponent("SpriteRenderer")

				if var_492_2 and var_492_2.sprite then
					local var_492_3 = 2 * (var_492_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_492_1.transform.localScale = Vector3.New(var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "ST01" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_4 = 3.999999999999

			if 3.999999999999 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			if arg_489_1.time_ >= var_492_4 + 0.3 and arg_489_1.time_ < var_492_4 + 0.3 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end

			local var_492_5 = 0

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_5 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_6 = 2

			if var_492_5 <= arg_489_1.time_ and arg_489_1.time_ < var_492_5 + var_492_6 then
				local var_492_7 = Color.New(0, 0, 0)

				var_492_7.a = Mathf.Lerp(0, 1, (arg_489_1.time_ - var_492_5) / var_492_6)
				arg_489_1.mask_.color = var_492_7
			end

			if arg_489_1.time_ >= var_492_5 + var_492_6 and arg_489_1.time_ < var_492_5 + var_492_6 + arg_492_0 then
				local var_492_8 = Color.New(0, 0, 0)

				var_492_8.a = 1
				arg_489_1.mask_.color = var_492_8
			end

			local var_492_9 = 2

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_9 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_10 = 2

			if var_492_9 <= arg_489_1.time_ and arg_489_1.time_ < var_492_9 + var_492_10 then
				local var_492_11 = Color.New(0, 0, 0)

				var_492_11.a = Mathf.Lerp(1, 0, (arg_489_1.time_ - var_492_9) / var_492_10)
				arg_489_1.mask_.color = var_492_11
			end

			if arg_489_1.time_ >= var_492_9 + var_492_10 and arg_489_1.time_ < var_492_9 + var_492_10 + arg_492_0 then
				local var_492_12 = Color.New(0, 0, 0)

				arg_489_1.mask_.enabled = false
				var_492_12.a = 0
				arg_489_1.mask_.color = var_492_12
			end

			local var_492_13 = arg_489_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_489_1.time_ and arg_489_1.time_ <= 1.96599999815226 + arg_492_0 then
				arg_489_1.var_.moveOldPos1020ui_story = var_492_13.localPosition
			end

			local var_492_14 = 0.001

			if 1.96599999815226 <= arg_489_1.time_ and arg_489_1.time_ < 1.96599999815226 + var_492_14 then
				var_492_13.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 1.96599999815226) / var_492_14)
				var_492_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_13.position).x, (manager.ui.mainCamera.transform.position - var_492_13.position).y, (manager.ui.mainCamera.transform.position - var_492_13.position).z)
				var_492_13.localEulerAngles.z = 0
				var_492_13.localEulerAngles.x = 0
				var_492_13.localEulerAngles = var_492_13.localEulerAngles
			end

			if arg_489_1.time_ >= 1.96599999815226 + var_492_14 and arg_489_1.time_ < 1.96599999815226 + var_492_14 + arg_492_0 then
				var_492_13.localPosition = Vector3.New(0, 100, 0)
				var_492_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_13.position).x, (manager.ui.mainCamera.transform.position - var_492_13.position).y, (manager.ui.mainCamera.transform.position - var_492_13.position).z)
				var_492_13.localEulerAngles.z = 0
				var_492_13.localEulerAngles.x = 0
				var_492_13.localEulerAngles = var_492_13.localEulerAngles
			end

			local var_492_15 = arg_489_1.actors_["1020ui_story"]

			if 1.96599999815226 < arg_489_1.time_ and arg_489_1.time_ <= 1.96599999815226 + arg_492_0 and not isNil(var_492_15) and arg_489_1.var_.characterEffect1020ui_story == nil then
				arg_489_1.var_.characterEffect1020ui_story = var_492_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_16 = 0.034000001847744

			if 1.96599999815226 <= arg_489_1.time_ and arg_489_1.time_ < 1.96599999815226 + var_492_16 and not isNil(var_492_15) then
				if arg_489_1.var_.characterEffect1020ui_story and not isNil(var_492_15) then
					arg_489_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 1.96599999815226) / var_492_16)
				end
			end

			if arg_489_1.time_ >= 1.96599999815226 + var_492_16 and arg_489_1.time_ < 1.96599999815226 + var_492_16 + arg_492_0 and not isNil(var_492_15) and arg_489_1.var_.characterEffect1020ui_story then
				arg_489_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_17 = 3.999999999999
			local var_492_18 = 1.25

			if 3.999999999999 < arg_489_1.time_ and arg_489_1.time_ <= var_492_17 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_19 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_19:setOnUpdate(LuaHelper.FloatAction(function(arg_493_0)
					arg_489_1.dialogCg_.alpha = arg_493_0
				end))
				var_492_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_20 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(924011119).content)

				arg_489_1.text_.text = var_492_20

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_22 = 50 <= 0 and var_492_18 or var_492_18 * (utf8.len(var_492_20) / 50)

				if (50 <= 0 and var_492_18 or var_492_18 * (utf8.len(var_492_20) / 50)) > 0 and var_492_18 < var_492_22 then
					arg_489_1.talkMaxDuration = var_492_22
					var_492_17 = var_492_17 + 0.3

					if var_492_22 + var_492_17 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_22 + var_492_17
					end
				end

				arg_489_1.text_.text = var_492_20
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_23 = var_492_17 + 0.3
			local var_492_24 = math.max(var_492_18, arg_489_1.talkMaxDuration)

			if var_492_17 + 0.3 <= arg_489_1.time_ and arg_489_1.time_ < var_492_23 + var_492_24 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_23) / var_492_24

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_23 + var_492_24 and arg_489_1.time_ < var_492_23 + var_492_24 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play924011120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 924011120
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play924011121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.95

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(924011120).content)

				arg_495_1.text_.text = var_498_1

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_3 = 38 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 38)

				if (38 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 38)) > 0 and var_498_0 < var_498_3 then
					arg_495_1.talkMaxDuration = var_498_3

					if var_498_3 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_3 + 0
					end
				end

				arg_495_1.text_.text = var_498_1
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_4 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_4

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play924011121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 924011121
		arg_499_1.duration_ = 5.7

		local var_499_0 = {
			zh = 3.5,
			ja = 5.7
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
				arg_499_0:Play924011122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1020ui_story = arg_499_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1020ui_story"].transform.position).z)
				arg_499_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1020ui_story"].transform.localEulerAngles = arg_499_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_499_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1020ui_story"].transform.position).z)
				arg_499_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1020ui_story"].transform.localEulerAngles = arg_499_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["1020ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1020ui_story == nil then
				arg_499_1.var_.characterEffect1020ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect1020ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1020ui_story then
				arg_499_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_502_4 = 0
			local var_502_5 = 0.35

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_6 = arg_499_1:GetWordFromCfg(924011121)
				local var_502_7 = arg_499_1:FormatText(var_502_6.content)

				arg_499_1.text_.text = var_502_7

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_9 = 14 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 14)

				if (14 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 14)) > 0 and var_502_5 < var_502_9 then
					arg_499_1.talkMaxDuration = var_502_9

					if var_502_9 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_9 + var_502_4
					end
				end

				arg_499_1.text_.text = var_502_7
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb") ~= 0 then
					local var_502_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb") / 1000

					if var_502_10 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_10 + var_502_4
					end

					if var_502_6.prefab_name ~= "" and arg_499_1.actors_[var_502_6.prefab_name] ~= nil then
						local var_502_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_6.prefab_name].transform, "story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb")

						arg_499_1:RecordAudio("924011121", var_502_11)
						arg_499_1:RecordAudio("924011121", var_502_11)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011121", "story_v_side_old_924011.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_12 = math.max(var_502_5, arg_499_1.talkMaxDuration)

			if var_502_4 <= arg_499_1.time_ and arg_499_1.time_ < var_502_4 + var_502_12 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_4) / var_502_12

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_4 + var_502_12 and arg_499_1.time_ < var_502_4 + var_502_12 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play924011122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 924011122
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play924011123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1020ui_story"]) and arg_503_1.var_.characterEffect1020ui_story == nil then
				arg_503_1.var_.characterEffect1020ui_story = arg_503_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1020ui_story"]) then
				if arg_503_1.var_.characterEffect1020ui_story and not isNil(arg_503_1.actors_["1020ui_story"]) then
					arg_503_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_0)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1020ui_story"]) and arg_503_1.var_.characterEffect1020ui_story then
				arg_503_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_506_1 = 0
			local var_506_2 = 0.225

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(924011122).content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 9 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 9)

				if (9 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 9)) > 0 and var_506_2 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_1
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_6 = math.max(var_506_2, arg_503_1.talkMaxDuration)

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_6 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_1) / var_506_6

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_1 + var_506_6 and arg_503_1.time_ < var_506_1 + var_506_6 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play924011123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 924011123
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play924011124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1020ui_story = arg_507_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1020ui_story"].transform.position).z)
				arg_507_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1020ui_story"].transform.localEulerAngles = arg_507_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_507_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1020ui_story"].transform.position).z)
				arg_507_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1020ui_story"].transform.localEulerAngles = arg_507_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_510_1 = 0
			local var_510_2 = 1.05

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(924011123).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 42 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 42)

				if (42 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 42)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play924011124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 924011124
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play924011125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_514_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_511_1.bgmTxt_.text ~= var_514_2 and arg_511_1.bgmTxt_.text ~= "" then
						if arg_511_1.bgmTxt2_.text ~= "" then
							arg_511_1.bgmTxt_.text = arg_511_1.bgmTxt2_.text
						end

						arg_511_1.bgmTxt2_.text = var_514_2

						arg_511_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_511_1.bgmTxt_.text = var_514_2
						arg_511_1.bgmTxt2_.text = var_514_2
					end

					if arg_511_1.bgmTimer then
						arg_511_1.bgmTimer:Stop()

						arg_511_1.bgmTimer = nil
					end

					if arg_511_1.settingData.show_music_name == 1 then
						arg_511_1.musicController:SetSelectedState("show")
						arg_511_1.musicAnimator_:Play("open", 0, 0)

						if arg_511_1.settingData.music_time ~= 0 then
							arg_511_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_511_1.settingData.music_time), function()
								if arg_511_1 == nil or isNil(arg_511_1.bgmTxt_) then
									return
								end

								arg_511_1.musicController:SetSelectedState("hide")
								arg_511_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_514_3 = 0
			local var_514_4 = 1.05

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_3 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_5 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(924011124).content)

				arg_511_1.text_.text = var_514_5

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_7 = 42 <= 0 and var_514_4 or var_514_4 * (utf8.len(var_514_5) / 42)

				if (42 <= 0 and var_514_4 or var_514_4 * (utf8.len(var_514_5) / 42)) > 0 and var_514_4 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_3 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_3
					end
				end

				arg_511_1.text_.text = var_514_5
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_8 = math.max(var_514_4, arg_511_1.talkMaxDuration)

			if var_514_3 <= arg_511_1.time_ and arg_511_1.time_ < var_514_3 + var_514_8 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_3) / var_514_8

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_3 + var_514_8 and arg_511_1.time_ < var_514_3 + var_514_8 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play924011125 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 924011125
		arg_516_1.duration_ = 6.93

		local var_516_0 = {
			zh = 6.10000000298023,
			ja = 6.93300000298023
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play924011126(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 2 < arg_516_1.time_ and arg_516_1.time_ <= 2 + arg_519_0 then
				local var_519_0 = arg_516_1.bgs_.ST01

				arg_516_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_519_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_1 = var_519_0:GetComponent("SpriteRenderer")

				if var_519_1 and var_519_1.sprite then
					local var_519_2 = 2 * (var_519_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_519_0.transform.localScale = Vector3.New(var_519_2 / var_519_1.sprite.bounds.size.y < var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x and var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x or var_519_2 / var_519_1.sprite.bounds.size.y, var_519_2 / var_519_1.sprite.bounds.size.y < var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x and var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x or var_519_2 / var_519_1.sprite.bounds.size.y, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "ST01" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_519_3 = 3.999999999999

			if 3.999999999999 < arg_516_1.time_ and arg_516_1.time_ <= var_519_3 + arg_519_0 then
				arg_516_1.allBtn_.enabled = false
			end

			if arg_516_1.time_ >= var_519_3 + 0.3 and arg_516_1.time_ < var_519_3 + 0.3 + arg_519_0 then
				arg_516_1.allBtn_.enabled = true
			end

			local var_519_4 = 0

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_4 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_5 = 2

			if var_519_4 <= arg_516_1.time_ and arg_516_1.time_ < var_519_4 + var_519_5 then
				local var_519_6 = Color.New(0, 0, 0)

				var_519_6.a = Mathf.Lerp(0, 1, (arg_516_1.time_ - var_519_4) / var_519_5)
				arg_516_1.mask_.color = var_519_6
			end

			if arg_516_1.time_ >= var_519_4 + var_519_5 and arg_516_1.time_ < var_519_4 + var_519_5 + arg_519_0 then
				local var_519_7 = Color.New(0, 0, 0)

				var_519_7.a = 1
				arg_516_1.mask_.color = var_519_7
			end

			local var_519_8 = 2

			if 2 < arg_516_1.time_ and arg_516_1.time_ <= var_519_8 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_9 = 2

			if var_519_8 <= arg_516_1.time_ and arg_516_1.time_ < var_519_8 + var_519_9 then
				local var_519_10 = Color.New(0, 0, 0)

				var_519_10.a = Mathf.Lerp(1, 0, (arg_516_1.time_ - var_519_8) / var_519_9)
				arg_516_1.mask_.color = var_519_10
			end

			if arg_516_1.time_ >= var_519_8 + var_519_9 and arg_516_1.time_ < var_519_8 + var_519_9 + arg_519_0 then
				local var_519_11 = Color.New(0, 0, 0)

				arg_516_1.mask_.enabled = false
				var_519_11.a = 0
				arg_516_1.mask_.color = var_519_11
			end

			local var_519_12 = arg_516_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_516_1.time_ and arg_516_1.time_ <= 1.96599999815226 + arg_519_0 then
				arg_516_1.var_.moveOldPos1020ui_story = var_519_12.localPosition
			end

			local var_519_13 = 0.001

			if 1.96599999815226 <= arg_516_1.time_ and arg_516_1.time_ < 1.96599999815226 + var_519_13 then
				var_519_12.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_516_1.time_ - 1.96599999815226) / var_519_13)
				var_519_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_12.position).x, (manager.ui.mainCamera.transform.position - var_519_12.position).y, (manager.ui.mainCamera.transform.position - var_519_12.position).z)
				var_519_12.localEulerAngles.z = 0
				var_519_12.localEulerAngles.x = 0
				var_519_12.localEulerAngles = var_519_12.localEulerAngles
			end

			if arg_516_1.time_ >= 1.96599999815226 + var_519_13 and arg_516_1.time_ < 1.96599999815226 + var_519_13 + arg_519_0 then
				var_519_12.localPosition = Vector3.New(0, 100, 0)
				var_519_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_12.position).x, (manager.ui.mainCamera.transform.position - var_519_12.position).y, (manager.ui.mainCamera.transform.position - var_519_12.position).z)
				var_519_12.localEulerAngles.z = 0
				var_519_12.localEulerAngles.x = 0
				var_519_12.localEulerAngles = var_519_12.localEulerAngles
			end

			local var_519_14 = arg_516_1.actors_["1020ui_story"].transform

			if 3.8 < arg_516_1.time_ and arg_516_1.time_ <= 3.8 + arg_519_0 then
				arg_516_1.var_.moveOldPos1020ui_story = var_519_14.localPosition
			end

			local var_519_15 = 0.001

			if 3.8 <= arg_516_1.time_ and arg_516_1.time_ < 3.8 + var_519_15 then
				var_519_14.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_516_1.time_ - 3.8) / var_519_15)
				var_519_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_14.position).x, (manager.ui.mainCamera.transform.position - var_519_14.position).y, (manager.ui.mainCamera.transform.position - var_519_14.position).z)
				var_519_14.localEulerAngles.z = 0
				var_519_14.localEulerAngles.x = 0
				var_519_14.localEulerAngles = var_519_14.localEulerAngles
			end

			if arg_516_1.time_ >= 3.8 + var_519_15 and arg_516_1.time_ < 3.8 + var_519_15 + arg_519_0 then
				var_519_14.localPosition = Vector3.New(0, -0.85, -6.25)
				var_519_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_14.position).x, (manager.ui.mainCamera.transform.position - var_519_14.position).y, (manager.ui.mainCamera.transform.position - var_519_14.position).z)
				var_519_14.localEulerAngles.z = 0
				var_519_14.localEulerAngles.x = 0
				var_519_14.localEulerAngles = var_519_14.localEulerAngles
			end

			local var_519_16 = arg_516_1.actors_["1020ui_story"]

			if 3.8 < arg_516_1.time_ and arg_516_1.time_ <= 3.8 + arg_519_0 and not isNil(var_519_16) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = var_519_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_17 = 0.200000002980232

			if 3.8 <= arg_516_1.time_ and arg_516_1.time_ < 3.8 + var_519_17 and not isNil(var_519_16) then
				if arg_516_1.var_.characterEffect1020ui_story and not isNil(var_519_16) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= 3.8 + var_519_17 and arg_516_1.time_ < 3.8 + var_519_17 + arg_519_0 and not isNil(var_519_16) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 3.8 < arg_516_1.time_ and arg_516_1.time_ <= 3.8 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_519_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_516_1.bgmTxt_.text ~= var_519_21 and arg_516_1.bgmTxt_.text ~= "" then
						if arg_516_1.bgmTxt2_.text ~= "" then
							arg_516_1.bgmTxt_.text = arg_516_1.bgmTxt2_.text
						end

						arg_516_1.bgmTxt2_.text = var_519_21

						arg_516_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_516_1.bgmTxt_.text = var_519_21
						arg_516_1.bgmTxt2_.text = var_519_21
					end

					if arg_516_1.bgmTimer then
						arg_516_1.bgmTimer:Stop()

						arg_516_1.bgmTimer = nil
					end

					if arg_516_1.settingData.show_music_name == 1 then
						arg_516_1.musicController:SetSelectedState("show")
						arg_516_1.musicAnimator_:Play("open", 0, 0)

						if arg_516_1.settingData.music_time ~= 0 then
							arg_516_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_516_1.settingData.music_time), function()
								if arg_516_1 == nil or isNil(arg_516_1.bgmTxt_) then
									return
								end

								arg_516_1.musicController:SetSelectedState("hide")
								arg_516_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_516_1.time_ and arg_516_1.time_ <= 0.466666666666667 + arg_519_0 then
				arg_516_1:AudioAction("play", "music", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet.awb")

				local var_519_24 = manager.audio:GetAudioName("bgm_activity_3_6_story_shashvat_quiet", "bgm_activity_3_6_story_shashvat_quiet")

				if "" ~= "" then
					if arg_516_1.bgmTxt_.text ~= var_519_24 and arg_516_1.bgmTxt_.text ~= "" then
						if arg_516_1.bgmTxt2_.text ~= "" then
							arg_516_1.bgmTxt_.text = arg_516_1.bgmTxt2_.text
						end

						arg_516_1.bgmTxt2_.text = var_519_24

						arg_516_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_516_1.bgmTxt_.text = var_519_24
						arg_516_1.bgmTxt2_.text = var_519_24
					end

					if arg_516_1.bgmTimer then
						arg_516_1.bgmTimer:Stop()

						arg_516_1.bgmTimer = nil
					end

					if arg_516_1.settingData.show_music_name == 1 then
						arg_516_1.musicController:SetSelectedState("show")
						arg_516_1.musicAnimator_:Play("open", 0, 0)

						if arg_516_1.settingData.music_time ~= 0 then
							arg_516_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_516_1.settingData.music_time), function()
								if arg_516_1 == nil or isNil(arg_516_1.bgmTxt_) then
									return
								end

								arg_516_1.musicController:SetSelectedState("hide")
								arg_516_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.8 < arg_516_1.time_ and arg_516_1.time_ <= 3.8 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action10_1")
			end

			if arg_516_1.frameCnt_ <= 1 then
				arg_516_1.dialog_:SetActive(false)
			end

			local var_519_25 = 4.00000000298023
			local var_519_26 = 0.175

			if 4.00000000298023 < arg_516_1.time_ and arg_516_1.time_ <= var_519_25 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0

				arg_516_1.dialog_:SetActive(true)

				arg_516_1.dialogCg_.alpha = 0

				local var_519_27 = LeanTween.value(arg_516_1.dialog_, 0, 1, 0.3)

				var_519_27:setOnUpdate(LuaHelper.FloatAction(function(arg_522_0)
					arg_516_1.dialogCg_.alpha = arg_522_0
				end))
				var_519_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_516_1.dialog_)
					var_519_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_516_1.duration_ = arg_516_1.duration_ + 0.3

				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_28 = arg_516_1:GetWordFromCfg(924011125)
				local var_519_29 = arg_516_1:FormatText(var_519_28.content)

				arg_516_1.text_.text = var_519_29

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_31 = 7 <= 0 and var_519_26 or var_519_26 * (utf8.len(var_519_29) / 7)

				if (7 <= 0 and var_519_26 or var_519_26 * (utf8.len(var_519_29) / 7)) > 0 and var_519_26 < var_519_31 then
					arg_516_1.talkMaxDuration = var_519_31
					var_519_25 = var_519_25 + 0.3

					if var_519_31 + var_519_25 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_31 + var_519_25
					end
				end

				arg_516_1.text_.text = var_519_29
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb") ~= 0 then
					local var_519_32 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb") / 1000

					if var_519_32 + var_519_25 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_32 + var_519_25
					end

					if var_519_28.prefab_name ~= "" and arg_516_1.actors_[var_519_28.prefab_name] ~= nil then
						local var_519_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_28.prefab_name].transform, "story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb")

						arg_516_1:RecordAudio("924011125", var_519_33)
						arg_516_1:RecordAudio("924011125", var_519_33)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011125", "story_v_side_old_924011.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_34 = var_519_25 + 0.3
			local var_519_35 = math.max(var_519_26, arg_516_1.talkMaxDuration)

			if var_519_25 + 0.3 <= arg_516_1.time_ and arg_516_1.time_ < var_519_34 + var_519_35 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_34) / var_519_35

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_34 + var_519_35 and arg_516_1.time_ < var_519_34 + var_519_35 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play924011126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 924011126
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play924011127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.moveOldPos1020ui_story = arg_524_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_527_0 = 0.001

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 then
				arg_524_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_524_1.time_ - 0) / var_527_0)
				arg_524_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1020ui_story"].transform.position).z)
				arg_524_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1020ui_story"].transform.localEulerAngles = arg_524_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 then
				arg_524_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_524_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1020ui_story"].transform.position).z)
				arg_524_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1020ui_story"].transform.localEulerAngles = arg_524_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_527_1 = arg_524_1.actors_["1020ui_story"]

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1020ui_story == nil then
				arg_524_1.var_.characterEffect1020ui_story = var_527_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_2 and not isNil(var_527_1) then
				if arg_524_1.var_.characterEffect1020ui_story and not isNil(var_527_1) then
					arg_524_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_2)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_2 and arg_524_1.time_ < 0 + var_527_2 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1020ui_story then
				arg_524_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_524_1.time_ and arg_524_1.time_ <= 0.125 + arg_527_0 then
				arg_524_1:AudioAction("play", "effect", "se_story_139", "se_story_139_bed", "")
			end

			local var_527_4 = 0
			local var_527_5 = 0.65

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_4 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_6 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(924011126).content)

				arg_524_1.text_.text = var_527_6

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_8 = 26 <= 0 and var_527_5 or var_527_5 * (utf8.len(var_527_6) / 26)

				if (26 <= 0 and var_527_5 or var_527_5 * (utf8.len(var_527_6) / 26)) > 0 and var_527_5 < var_527_8 then
					arg_524_1.talkMaxDuration = var_527_8

					if var_527_8 + var_527_4 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_8 + var_527_4
					end
				end

				arg_524_1.text_.text = var_527_6
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_9 = math.max(var_527_5, arg_524_1.talkMaxDuration)

			if var_527_4 <= arg_524_1.time_ and arg_524_1.time_ < var_527_4 + var_527_9 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_4) / var_527_9

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_4 + var_527_9 and arg_524_1.time_ < var_527_4 + var_527_9 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play924011127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 924011127
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play924011128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.25

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(924011127).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 10 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 10)

				if (10 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 10)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play924011128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 924011128
		arg_532_1.duration_ = 9.8

		local var_532_0 = {
			zh = 5.666,
			ja = 9.8
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play924011129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.var_.moveOldPos1020ui_story = arg_532_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_535_0 = 0.001

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_0 then
				arg_532_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_532_1.time_ - 0) / var_535_0)
				arg_532_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_532_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1020ui_story"].transform.position).z)
				arg_532_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_532_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_532_1.actors_["1020ui_story"].transform.localEulerAngles = arg_532_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_532_1.time_ >= 0 + var_535_0 and arg_532_1.time_ < 0 + var_535_0 + arg_535_0 then
				arg_532_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_532_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_532_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1020ui_story"].transform.position).z)
				arg_532_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_532_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_532_1.actors_["1020ui_story"].transform.localEulerAngles = arg_532_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_535_1 = arg_532_1.actors_["1020ui_story"]

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 and not isNil(var_535_1) and arg_532_1.var_.characterEffect1020ui_story == nil then
				arg_532_1.var_.characterEffect1020ui_story = var_535_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_2 = 0.200000002980232

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_2 and not isNil(var_535_1) then
				if arg_532_1.var_.characterEffect1020ui_story and not isNil(var_535_1) then
					arg_532_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_532_1.time_ >= 0 + var_535_2 and arg_532_1.time_ < 0 + var_535_2 + arg_535_0 and not isNil(var_535_1) and arg_532_1.var_.characterEffect1020ui_story then
				arg_532_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_535_4 = 0
			local var_535_5 = 0.575

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_4 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_6 = arg_532_1:GetWordFromCfg(924011128)
				local var_535_7 = arg_532_1:FormatText(var_535_6.content)

				arg_532_1.text_.text = var_535_7

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_9 = 23 <= 0 and var_535_5 or var_535_5 * (utf8.len(var_535_7) / 23)

				if (23 <= 0 and var_535_5 or var_535_5 * (utf8.len(var_535_7) / 23)) > 0 and var_535_5 < var_535_9 then
					arg_532_1.talkMaxDuration = var_535_9

					if var_535_9 + var_535_4 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_9 + var_535_4
					end
				end

				arg_532_1.text_.text = var_535_7
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb") ~= 0 then
					local var_535_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb") / 1000

					if var_535_10 + var_535_4 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_10 + var_535_4
					end

					if var_535_6.prefab_name ~= "" and arg_532_1.actors_[var_535_6.prefab_name] ~= nil then
						local var_535_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_6.prefab_name].transform, "story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb")

						arg_532_1:RecordAudio("924011128", var_535_11)
						arg_532_1:RecordAudio("924011128", var_535_11)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011128", "story_v_side_old_924011.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_12 = math.max(var_535_5, arg_532_1.talkMaxDuration)

			if var_535_4 <= arg_532_1.time_ and arg_532_1.time_ < var_535_4 + var_535_12 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_4) / var_535_12

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_4 + var_535_12 and arg_532_1.time_ < var_535_4 + var_535_12 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play924011129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 924011129
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play924011130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1020ui_story = arg_536_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_539_0 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 then
				arg_536_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_536_1.time_ - 0) / var_539_0)
				arg_536_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1020ui_story"].transform.position).z)
				arg_536_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1020ui_story"].transform.localEulerAngles = arg_536_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 then
				arg_536_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_536_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1020ui_story"].transform.position).z)
				arg_536_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1020ui_story"].transform.localEulerAngles = arg_536_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_539_1 = arg_536_1.actors_["1020ui_story"]

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1020ui_story == nil then
				arg_536_1.var_.characterEffect1020ui_story = var_539_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_2 and not isNil(var_539_1) then
				if arg_536_1.var_.characterEffect1020ui_story and not isNil(var_539_1) then
					arg_536_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_536_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_536_1.time_ - 0) / var_539_2)
				end
			end

			if arg_536_1.time_ >= 0 + var_539_2 and arg_536_1.time_ < 0 + var_539_2 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1020ui_story then
				arg_536_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_536_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_536_1.time_ and arg_536_1.time_ <= 0.125 + arg_539_0 then
				arg_536_1:AudioAction("play", "effect", "se_story_139", "se_story_139_bed", "")
			end

			local var_539_4 = 0
			local var_539_5 = 0.8

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_4 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_6 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(924011129).content)

				arg_536_1.text_.text = var_539_6

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_8 = 32 <= 0 and var_539_5 or var_539_5 * (utf8.len(var_539_6) / 32)

				if (32 <= 0 and var_539_5 or var_539_5 * (utf8.len(var_539_6) / 32)) > 0 and var_539_5 < var_539_8 then
					arg_536_1.talkMaxDuration = var_539_8

					if var_539_8 + var_539_4 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_4
					end
				end

				arg_536_1.text_.text = var_539_6
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_9 = math.max(var_539_5, arg_536_1.talkMaxDuration)

			if var_539_4 <= arg_536_1.time_ and arg_536_1.time_ < var_539_4 + var_539_9 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_4) / var_539_9

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_4 + var_539_9 and arg_536_1.time_ < var_539_4 + var_539_9 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play924011130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 924011130
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play924011131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.525

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_1 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(924011130).content)

				arg_540_1.text_.text = var_543_1

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_3 = 21 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_1) / 21)

				if (21 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_1) / 21)) > 0 and var_543_0 < var_543_3 then
					arg_540_1.talkMaxDuration = var_543_3

					if var_543_3 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_3 + 0
					end
				end

				arg_540_1.text_.text = var_543_1
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_4 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_4 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_4

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_4 and arg_540_1.time_ < 0 + var_543_4 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play924011131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 924011131
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play924011132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0.25

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_1 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(924011131).content)

				arg_544_1.text_.text = var_547_1

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_3 = 10 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_1) / 10)

				if (10 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_1) / 10)) > 0 and var_547_0 < var_547_3 then
					arg_544_1.talkMaxDuration = var_547_3

					if var_547_3 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_3 + 0
					end
				end

				arg_544_1.text_.text = var_547_1
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_4 = math.max(var_547_0, arg_544_1.talkMaxDuration)

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_4 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - 0) / var_547_4

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= 0 + var_547_4 and arg_544_1.time_ < 0 + var_547_4 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play924011132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 924011132
		arg_548_1.duration_ = 5.53

		local var_548_0 = {
			zh = 4.433,
			ja = 5.533
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play924011133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.var_.moveOldPos1020ui_story = arg_548_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_551_0 = 0.001

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 then
				arg_548_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_548_1.time_ - 0) / var_551_0)
				arg_548_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_548_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1020ui_story"].transform.position).z)
				arg_548_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_548_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_548_1.actors_["1020ui_story"].transform.localEulerAngles = arg_548_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 then
				arg_548_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_548_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_548_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1020ui_story"].transform.position).z)
				arg_548_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_548_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_548_1.actors_["1020ui_story"].transform.localEulerAngles = arg_548_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_551_1 = arg_548_1.actors_["1020ui_story"]

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(var_551_1) and arg_548_1.var_.characterEffect1020ui_story == nil then
				arg_548_1.var_.characterEffect1020ui_story = var_551_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_2 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_2 and not isNil(var_551_1) then
				if arg_548_1.var_.characterEffect1020ui_story and not isNil(var_551_1) then
					arg_548_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= 0 + var_551_2 and arg_548_1.time_ < 0 + var_551_2 + arg_551_0 and not isNil(var_551_1) and arg_548_1.var_.characterEffect1020ui_story then
				arg_548_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_551_4 = 0
			local var_551_5 = 0.475

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_4 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_6 = arg_548_1:GetWordFromCfg(924011132)
				local var_551_7 = arg_548_1:FormatText(var_551_6.content)

				arg_548_1.text_.text = var_551_7

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_9 = 19 <= 0 and var_551_5 or var_551_5 * (utf8.len(var_551_7) / 19)

				if (19 <= 0 and var_551_5 or var_551_5 * (utf8.len(var_551_7) / 19)) > 0 and var_551_5 < var_551_9 then
					arg_548_1.talkMaxDuration = var_551_9

					if var_551_9 + var_551_4 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_9 + var_551_4
					end
				end

				arg_548_1.text_.text = var_551_7
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb") ~= 0 then
					local var_551_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb") / 1000

					if var_551_10 + var_551_4 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_10 + var_551_4
					end

					if var_551_6.prefab_name ~= "" and arg_548_1.actors_[var_551_6.prefab_name] ~= nil then
						local var_551_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_6.prefab_name].transform, "story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb")

						arg_548_1:RecordAudio("924011132", var_551_11)
						arg_548_1:RecordAudio("924011132", var_551_11)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011132", "story_v_side_old_924011.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_12 = math.max(var_551_5, arg_548_1.talkMaxDuration)

			if var_551_4 <= arg_548_1.time_ and arg_548_1.time_ < var_551_4 + var_551_12 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_4) / var_551_12

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_4 + var_551_12 and arg_548_1.time_ < var_551_4 + var_551_12 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play924011133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 924011133
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play924011134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 and not isNil(arg_552_1.actors_["1020ui_story"]) and arg_552_1.var_.characterEffect1020ui_story == nil then
				arg_552_1.var_.characterEffect1020ui_story = arg_552_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_0 = 0.200000002980232

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_0 and not isNil(arg_552_1.actors_["1020ui_story"]) then
				if arg_552_1.var_.characterEffect1020ui_story and not isNil(arg_552_1.actors_["1020ui_story"]) then
					arg_552_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_552_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_552_1.time_ - 0) / var_555_0)
				end
			end

			if arg_552_1.time_ >= 0 + var_555_0 and arg_552_1.time_ < 0 + var_555_0 + arg_555_0 and not isNil(arg_552_1.actors_["1020ui_story"]) and arg_552_1.var_.characterEffect1020ui_story then
				arg_552_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_552_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_555_1 = 0
			local var_555_2 = 0.35

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(924011133).content)

				arg_552_1.text_.text = var_555_3

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 14 <= 0 and var_555_2 or var_555_2 * (utf8.len(var_555_3) / 14)

				if (14 <= 0 and var_555_2 or var_555_2 * (utf8.len(var_555_3) / 14)) > 0 and var_555_2 < var_555_5 then
					arg_552_1.talkMaxDuration = var_555_5

					if var_555_5 + var_555_1 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + var_555_1
					end
				end

				arg_552_1.text_.text = var_555_3
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_6 = math.max(var_555_2, arg_552_1.talkMaxDuration)

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_6 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_1) / var_555_6

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_1 + var_555_6 and arg_552_1.time_ < var_555_1 + var_555_6 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play924011134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 924011134
		arg_556_1.duration_ = 4.8

		local var_556_0 = {
			zh = 3.133,
			ja = 4.8
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play924011135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.var_.moveOldPos1020ui_story = arg_556_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_559_0 = 0.001

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 then
				arg_556_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_556_1.time_ - 0) / var_559_0)
				arg_556_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_556_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1020ui_story"].transform.position).z)
				arg_556_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_556_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_556_1.actors_["1020ui_story"].transform.localEulerAngles = arg_556_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 then
				arg_556_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_556_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_556_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1020ui_story"].transform.position).z)
				arg_556_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_556_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_556_1.actors_["1020ui_story"].transform.localEulerAngles = arg_556_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_559_1 = arg_556_1.actors_["1020ui_story"]

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(var_559_1) and arg_556_1.var_.characterEffect1020ui_story == nil then
				arg_556_1.var_.characterEffect1020ui_story = var_559_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_2 = 0.200000002980232

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_2 and not isNil(var_559_1) then
				if arg_556_1.var_.characterEffect1020ui_story and not isNil(var_559_1) then
					arg_556_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_556_1.time_ >= 0 + var_559_2 and arg_556_1.time_ < 0 + var_559_2 + arg_559_0 and not isNil(var_559_1) and arg_556_1.var_.characterEffect1020ui_story then
				arg_556_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			local var_559_4 = 0
			local var_559_5 = 0.375

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_4 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_6 = arg_556_1:GetWordFromCfg(924011134)
				local var_559_7 = arg_556_1:FormatText(var_559_6.content)

				arg_556_1.text_.text = var_559_7

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_9 = 15 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 15)

				if (15 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 15)) > 0 and var_559_5 < var_559_9 then
					arg_556_1.talkMaxDuration = var_559_9

					if var_559_9 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_9 + var_559_4
					end
				end

				arg_556_1.text_.text = var_559_7
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb") ~= 0 then
					local var_559_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb") / 1000

					if var_559_10 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_10 + var_559_4
					end

					if var_559_6.prefab_name ~= "" and arg_556_1.actors_[var_559_6.prefab_name] ~= nil then
						local var_559_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_6.prefab_name].transform, "story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb")

						arg_556_1:RecordAudio("924011134", var_559_11)
						arg_556_1:RecordAudio("924011134", var_559_11)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011134", "story_v_side_old_924011.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_12 = math.max(var_559_5, arg_556_1.talkMaxDuration)

			if var_559_4 <= arg_556_1.time_ and arg_556_1.time_ < var_559_4 + var_559_12 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_4) / var_559_12

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_4 + var_559_12 and arg_556_1.time_ < var_559_4 + var_559_12 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play924011135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 924011135
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play924011136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(arg_560_1.actors_["1020ui_story"]) and arg_560_1.var_.characterEffect1020ui_story == nil then
				arg_560_1.var_.characterEffect1020ui_story = arg_560_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_0 = 0.200000002980232

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_0 and not isNil(arg_560_1.actors_["1020ui_story"]) then
				if arg_560_1.var_.characterEffect1020ui_story and not isNil(arg_560_1.actors_["1020ui_story"]) then
					arg_560_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_560_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_560_1.time_ - 0) / var_563_0)
				end
			end

			if arg_560_1.time_ >= 0 + var_563_0 and arg_560_1.time_ < 0 + var_563_0 + arg_563_0 and not isNil(arg_560_1.actors_["1020ui_story"]) and arg_560_1.var_.characterEffect1020ui_story then
				arg_560_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_560_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_563_1 = 0
			local var_563_2 = 1.125

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_3 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(924011135).content)

				arg_560_1.text_.text = var_563_3

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 45 <= 0 and var_563_2 or var_563_2 * (utf8.len(var_563_3) / 45)

				if (45 <= 0 and var_563_2 or var_563_2 * (utf8.len(var_563_3) / 45)) > 0 and var_563_2 < var_563_5 then
					arg_560_1.talkMaxDuration = var_563_5

					if var_563_5 + var_563_1 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + var_563_1
					end
				end

				arg_560_1.text_.text = var_563_3
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_6 = math.max(var_563_2, arg_560_1.talkMaxDuration)

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_6 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_1) / var_563_6

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_1 + var_563_6 and arg_560_1.time_ < var_563_1 + var_563_6 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play924011136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 924011136
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play924011137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0.45

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_1 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(924011136).content)

				arg_564_1.text_.text = var_567_1

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_3 = 18 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_1) / 18)

				if (18 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_1) / 18)) > 0 and var_567_0 < var_567_3 then
					arg_564_1.talkMaxDuration = var_567_3

					if var_567_3 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_3 + 0
					end
				end

				arg_564_1.text_.text = var_567_1
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_4 = math.max(var_567_0, arg_564_1.talkMaxDuration)

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_4 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - 0) / var_567_4

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= 0 + var_567_4 and arg_564_1.time_ < 0 + var_567_4 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play924011137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 924011137
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play924011138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.var_.moveOldPos1020ui_story = arg_568_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_571_0 = 0.001

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_0 then
				arg_568_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_568_1.time_ - 0) / var_571_0)
				arg_568_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_568_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1020ui_story"].transform.position).z)
				arg_568_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_568_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_568_1.actors_["1020ui_story"].transform.localEulerAngles = arg_568_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 then
				arg_568_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_568_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_568_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1020ui_story"].transform.position).z)
				arg_568_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_568_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_568_1.actors_["1020ui_story"].transform.localEulerAngles = arg_568_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_571_1 = 0
			local var_571_2 = 0.825

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_3 = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(924011137).content)

				arg_568_1.text_.text = var_571_3

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_5 = 33 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_3) / 33)

				if (33 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_3) / 33)) > 0 and var_571_2 < var_571_5 then
					arg_568_1.talkMaxDuration = var_571_5

					if var_571_5 + var_571_1 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_5 + var_571_1
					end
				end

				arg_568_1.text_.text = var_571_3
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_6 = math.max(var_571_2, arg_568_1.talkMaxDuration)

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_6 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_1) / var_571_6

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_1 + var_571_6 and arg_568_1.time_ < var_571_1 + var_571_6 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_568_1:InitPlayNodeList()
	end,
	Play924011138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 924011138
		arg_572_1.duration_ = 4.53

		local var_572_0 = {
			zh = 2.033,
			ja = 4.533
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play924011139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.var_.moveOldPos1020ui_story = arg_572_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_575_0 = 0.001

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_0 then
				arg_572_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_572_1.time_ - 0) / var_575_0)
				arg_572_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_572_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1020ui_story"].transform.position).z)
				arg_572_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_572_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_572_1.actors_["1020ui_story"].transform.localEulerAngles = arg_572_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_572_1.time_ >= 0 + var_575_0 and arg_572_1.time_ < 0 + var_575_0 + arg_575_0 then
				arg_572_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_572_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_572_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1020ui_story"].transform.position).z)
				arg_572_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_572_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_572_1.actors_["1020ui_story"].transform.localEulerAngles = arg_572_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_575_1 = arg_572_1.actors_["1020ui_story"]

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(var_575_1) and arg_572_1.var_.characterEffect1020ui_story == nil then
				arg_572_1.var_.characterEffect1020ui_story = var_575_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_2 = 0.200000002980232

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_2 and not isNil(var_575_1) then
				if arg_572_1.var_.characterEffect1020ui_story and not isNil(var_575_1) then
					arg_572_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= 0 + var_575_2 and arg_572_1.time_ < 0 + var_575_2 + arg_575_0 and not isNil(var_575_1) and arg_572_1.var_.characterEffect1020ui_story then
				arg_572_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_575_4 = 0
			local var_575_5 = 0.2

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_4 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_6 = arg_572_1:GetWordFromCfg(924011138)
				local var_575_7 = arg_572_1:FormatText(var_575_6.content)

				arg_572_1.text_.text = var_575_7

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_9 = 8 <= 0 and var_575_5 or var_575_5 * (utf8.len(var_575_7) / 8)

				if (8 <= 0 and var_575_5 or var_575_5 * (utf8.len(var_575_7) / 8)) > 0 and var_575_5 < var_575_9 then
					arg_572_1.talkMaxDuration = var_575_9

					if var_575_9 + var_575_4 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_9 + var_575_4
					end
				end

				arg_572_1.text_.text = var_575_7
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb") ~= 0 then
					local var_575_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb") / 1000

					if var_575_10 + var_575_4 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_10 + var_575_4
					end

					if var_575_6.prefab_name ~= "" and arg_572_1.actors_[var_575_6.prefab_name] ~= nil then
						local var_575_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_6.prefab_name].transform, "story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb")

						arg_572_1:RecordAudio("924011138", var_575_11)
						arg_572_1:RecordAudio("924011138", var_575_11)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011138", "story_v_side_old_924011.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_12 = math.max(var_575_5, arg_572_1.talkMaxDuration)

			if var_575_4 <= arg_572_1.time_ and arg_572_1.time_ < var_575_4 + var_575_12 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_4) / var_575_12

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_4 + var_575_12 and arg_572_1.time_ < var_575_4 + var_575_12 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_572_1:InitPlayNodeList()
	end,
	Play924011139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 924011139
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play924011140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(arg_576_1.actors_["1020ui_story"]) and arg_576_1.var_.characterEffect1020ui_story == nil then
				arg_576_1.var_.characterEffect1020ui_story = arg_576_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_0 = 0.200000002980232

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_0 and not isNil(arg_576_1.actors_["1020ui_story"]) then
				if arg_576_1.var_.characterEffect1020ui_story and not isNil(arg_576_1.actors_["1020ui_story"]) then
					arg_576_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_576_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_576_1.time_ - 0) / var_579_0)
				end
			end

			if arg_576_1.time_ >= 0 + var_579_0 and arg_576_1.time_ < 0 + var_579_0 + arg_579_0 and not isNil(arg_576_1.actors_["1020ui_story"]) and arg_576_1.var_.characterEffect1020ui_story then
				arg_576_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_576_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_579_1 = 0
			local var_579_2 = 0.35

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, true)
				arg_576_1.iconController_:SetSelectedState("hero")

				arg_576_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_576_1.callingController_:SetSelectedState("normal")

				arg_576_1.keyicon_.color = Color.New(1, 1, 1)
				arg_576_1.icon_.color = Color.New(1, 1, 1)

				local var_579_3 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(924011139).content)

				arg_576_1.text_.text = var_579_3

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_5 = 14 <= 0 and var_579_2 or var_579_2 * (utf8.len(var_579_3) / 14)

				if (14 <= 0 and var_579_2 or var_579_2 * (utf8.len(var_579_3) / 14)) > 0 and var_579_2 < var_579_5 then
					arg_576_1.talkMaxDuration = var_579_5

					if var_579_5 + var_579_1 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_5 + var_579_1
					end
				end

				arg_576_1.text_.text = var_579_3
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_6 = math.max(var_579_2, arg_576_1.talkMaxDuration)

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_6 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_1) / var_579_6

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_1 + var_579_6 and arg_576_1.time_ < var_579_1 + var_579_6 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play924011140 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 924011140
		arg_580_1.duration_ = 9.4

		local var_580_0 = {
			zh = 7.866,
			ja = 9.4
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play924011141(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.var_.moveOldPos1020ui_story = arg_580_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_583_0 = 0.001

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_0 then
				arg_580_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_580_1.time_ - 0) / var_583_0)
				arg_580_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_580_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1020ui_story"].transform.position).z)
				arg_580_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_580_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_580_1.actors_["1020ui_story"].transform.localEulerAngles = arg_580_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_580_1.time_ >= 0 + var_583_0 and arg_580_1.time_ < 0 + var_583_0 + arg_583_0 then
				arg_580_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_580_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_580_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1020ui_story"].transform.position).z)
				arg_580_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_580_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_580_1.actors_["1020ui_story"].transform.localEulerAngles = arg_580_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_583_1 = arg_580_1.actors_["1020ui_story"]

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 and not isNil(var_583_1) and arg_580_1.var_.characterEffect1020ui_story == nil then
				arg_580_1.var_.characterEffect1020ui_story = var_583_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_2 = 0.200000002980232

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_2 and not isNil(var_583_1) then
				if arg_580_1.var_.characterEffect1020ui_story and not isNil(var_583_1) then
					arg_580_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_580_1.time_ >= 0 + var_583_2 and arg_580_1.time_ < 0 + var_583_2 + arg_583_0 and not isNil(var_583_1) and arg_580_1.var_.characterEffect1020ui_story then
				arg_580_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action468")
			end

			local var_583_4 = 0
			local var_583_5 = 0.675

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_4 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_6 = arg_580_1:GetWordFromCfg(924011140)
				local var_583_7 = arg_580_1:FormatText(var_583_6.content)

				arg_580_1.text_.text = var_583_7

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_9 = 27 <= 0 and var_583_5 or var_583_5 * (utf8.len(var_583_7) / 27)

				if (27 <= 0 and var_583_5 or var_583_5 * (utf8.len(var_583_7) / 27)) > 0 and var_583_5 < var_583_9 then
					arg_580_1.talkMaxDuration = var_583_9

					if var_583_9 + var_583_4 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_9 + var_583_4
					end
				end

				arg_580_1.text_.text = var_583_7
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb") ~= 0 then
					local var_583_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb") / 1000

					if var_583_10 + var_583_4 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_10 + var_583_4
					end

					if var_583_6.prefab_name ~= "" and arg_580_1.actors_[var_583_6.prefab_name] ~= nil then
						local var_583_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_6.prefab_name].transform, "story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb")

						arg_580_1:RecordAudio("924011140", var_583_11)
						arg_580_1:RecordAudio("924011140", var_583_11)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011140", "story_v_side_old_924011.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_12 = math.max(var_583_5, arg_580_1.talkMaxDuration)

			if var_583_4 <= arg_580_1.time_ and arg_580_1.time_ < var_583_4 + var_583_12 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_4) / var_583_12

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_4 + var_583_12 and arg_580_1.time_ < var_583_4 + var_583_12 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_580_1:InitPlayNodeList()
	end,
	Play924011141 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 924011141
		arg_584_1.duration_ = 12.73

		local var_584_0 = {
			zh = 7.2,
			ja = 12.733
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play924011142(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0.875

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_1 = arg_584_1:GetWordFromCfg(924011141)
				local var_587_2 = arg_584_1:FormatText(var_587_1.content)

				arg_584_1.text_.text = var_587_2

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_4 = 35 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 35)

				if (35 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 35)) > 0 and var_587_0 < var_587_4 then
					arg_584_1.talkMaxDuration = var_587_4

					if var_587_4 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_4 + 0
					end
				end

				arg_584_1.text_.text = var_587_2
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb") ~= 0 then
					local var_587_5 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb") / 1000

					if var_587_5 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_5 + 0
					end

					if var_587_1.prefab_name ~= "" and arg_584_1.actors_[var_587_1.prefab_name] ~= nil then
						local var_587_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_1.prefab_name].transform, "story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb")

						arg_584_1:RecordAudio("924011141", var_587_6)
						arg_584_1:RecordAudio("924011141", var_587_6)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011141", "story_v_side_old_924011.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_7 = math.max(var_587_0, arg_584_1.talkMaxDuration)

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_7 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - 0) / var_587_7

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= 0 + var_587_7 and arg_584_1.time_ < 0 + var_587_7 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play924011142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 924011142
		arg_588_1.duration_ = 3.7

		local var_588_0 = {
			zh = 3.5,
			ja = 3.7
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play924011143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_591_0 = 0
			local var_591_1 = 0.225

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_2 = arg_588_1:GetWordFromCfg(924011142)
				local var_591_3 = arg_588_1:FormatText(var_591_2.content)

				arg_588_1.text_.text = var_591_3

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 9 <= 0 and var_591_1 or var_591_1 * (utf8.len(var_591_3) / 9)

				if (9 <= 0 and var_591_1 or var_591_1 * (utf8.len(var_591_3) / 9)) > 0 and var_591_1 < var_591_5 then
					arg_588_1.talkMaxDuration = var_591_5

					if var_591_5 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_5 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_3
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb") ~= 0 then
					local var_591_6 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb") / 1000

					if var_591_6 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_6 + var_591_0
					end

					if var_591_2.prefab_name ~= "" and arg_588_1.actors_[var_591_2.prefab_name] ~= nil then
						local var_591_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_2.prefab_name].transform, "story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb")

						arg_588_1:RecordAudio("924011142", var_591_7)
						arg_588_1:RecordAudio("924011142", var_591_7)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011142", "story_v_side_old_924011.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_8 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_8 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_8

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_8 and arg_588_1.time_ < var_591_0 + var_591_8 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play924011143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 924011143
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play924011144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 and not isNil(arg_592_1.actors_["1020ui_story"]) and arg_592_1.var_.characterEffect1020ui_story == nil then
				arg_592_1.var_.characterEffect1020ui_story = arg_592_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_0 = 0.200000002980232

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_0 and not isNil(arg_592_1.actors_["1020ui_story"]) then
				if arg_592_1.var_.characterEffect1020ui_story and not isNil(arg_592_1.actors_["1020ui_story"]) then
					arg_592_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_592_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_592_1.time_ - 0) / var_595_0)
				end
			end

			if arg_592_1.time_ >= 0 + var_595_0 and arg_592_1.time_ < 0 + var_595_0 + arg_595_0 and not isNil(arg_592_1.actors_["1020ui_story"]) and arg_592_1.var_.characterEffect1020ui_story then
				arg_592_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_592_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_595_1 = 0
			local var_595_2 = 0.9

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_1 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_3 = arg_592_1:FormatText(arg_592_1:GetWordFromCfg(924011143).content)

				arg_592_1.text_.text = var_595_3

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_5 = 36 <= 0 and var_595_2 or var_595_2 * (utf8.len(var_595_3) / 36)

				if (36 <= 0 and var_595_2 or var_595_2 * (utf8.len(var_595_3) / 36)) > 0 and var_595_2 < var_595_5 then
					arg_592_1.talkMaxDuration = var_595_5

					if var_595_5 + var_595_1 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_5 + var_595_1
					end
				end

				arg_592_1.text_.text = var_595_3
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_6 = math.max(var_595_2, arg_592_1.talkMaxDuration)

			if var_595_1 <= arg_592_1.time_ and arg_592_1.time_ < var_595_1 + var_595_6 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_1) / var_595_6

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_1 + var_595_6 and arg_592_1.time_ < var_595_1 + var_595_6 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play924011144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 924011144
		arg_596_1.duration_ = 2

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play924011145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 and not isNil(arg_596_1.actors_["1020ui_story"]) and arg_596_1.var_.characterEffect1020ui_story == nil then
				arg_596_1.var_.characterEffect1020ui_story = arg_596_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_0 = 0.200000002980232

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_0 and not isNil(arg_596_1.actors_["1020ui_story"]) then
				if arg_596_1.var_.characterEffect1020ui_story and not isNil(arg_596_1.actors_["1020ui_story"]) then
					arg_596_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_596_1.time_ >= 0 + var_599_0 and arg_596_1.time_ < 0 + var_599_0 + arg_599_0 and not isNil(arg_596_1.actors_["1020ui_story"]) and arg_596_1.var_.characterEffect1020ui_story then
				arg_596_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_599_2 = 0
			local var_599_3 = 0.05

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_2 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_4 = arg_596_1:GetWordFromCfg(924011144)
				local var_599_5 = arg_596_1:FormatText(var_599_4.content)

				arg_596_1.text_.text = var_599_5

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_7 = 2 <= 0 and var_599_3 or var_599_3 * (utf8.len(var_599_5) / 2)

				if (2 <= 0 and var_599_3 or var_599_3 * (utf8.len(var_599_5) / 2)) > 0 and var_599_3 < var_599_7 then
					arg_596_1.talkMaxDuration = var_599_7

					if var_599_7 + var_599_2 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_7 + var_599_2
					end
				end

				arg_596_1.text_.text = var_599_5
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb") ~= 0 then
					local var_599_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb") / 1000

					if var_599_8 + var_599_2 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_8 + var_599_2
					end

					if var_599_4.prefab_name ~= "" and arg_596_1.actors_[var_599_4.prefab_name] ~= nil then
						local var_599_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_4.prefab_name].transform, "story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb")

						arg_596_1:RecordAudio("924011144", var_599_9)
						arg_596_1:RecordAudio("924011144", var_599_9)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011144", "story_v_side_old_924011.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_10 = math.max(var_599_3, arg_596_1.talkMaxDuration)

			if var_599_2 <= arg_596_1.time_ and arg_596_1.time_ < var_599_2 + var_599_10 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_2) / var_599_10

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_2 + var_599_10 and arg_596_1.time_ < var_599_2 + var_599_10 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play924011145 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 924011145
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play924011146(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 and not isNil(arg_600_1.actors_["1020ui_story"]) and arg_600_1.var_.characterEffect1020ui_story == nil then
				arg_600_1.var_.characterEffect1020ui_story = arg_600_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_0 = 0.200000002980232

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_0 and not isNil(arg_600_1.actors_["1020ui_story"]) then
				if arg_600_1.var_.characterEffect1020ui_story and not isNil(arg_600_1.actors_["1020ui_story"]) then
					arg_600_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_600_1.time_ - 0) / var_603_0)
				end
			end

			if arg_600_1.time_ >= 0 + var_603_0 and arg_600_1.time_ < 0 + var_603_0 + arg_603_0 and not isNil(arg_600_1.actors_["1020ui_story"]) and arg_600_1.var_.characterEffect1020ui_story then
				arg_600_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_603_1 = 0
			local var_603_2 = 1.25

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				arg_600_1.leftNameTxt_.text = arg_600_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_3 = arg_600_1:FormatText(arg_600_1:GetWordFromCfg(924011145).content)

				arg_600_1.text_.text = var_603_3

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_5 = 50 <= 0 and var_603_2 or var_603_2 * (utf8.len(var_603_3) / 50)

				if (50 <= 0 and var_603_2 or var_603_2 * (utf8.len(var_603_3) / 50)) > 0 and var_603_2 < var_603_5 then
					arg_600_1.talkMaxDuration = var_603_5

					if var_603_5 + var_603_1 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_5 + var_603_1
					end
				end

				arg_600_1.text_.text = var_603_3
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_6 = math.max(var_603_2, arg_600_1.talkMaxDuration)

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_6 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_1) / var_603_6

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_1 + var_603_6 and arg_600_1.time_ < var_603_1 + var_603_6 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play924011146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 924011146
		arg_604_1.duration_ = 1.47

		local var_604_0 = {
			zh = 1.1,
			ja = 1.466
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play924011147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(arg_604_1.actors_["1020ui_story"]) and arg_604_1.var_.characterEffect1020ui_story == nil then
				arg_604_1.var_.characterEffect1020ui_story = arg_604_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_0 = 0.200000002980232

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 and not isNil(arg_604_1.actors_["1020ui_story"]) then
				if arg_604_1.var_.characterEffect1020ui_story and not isNil(arg_604_1.actors_["1020ui_story"]) then
					arg_604_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 and not isNil(arg_604_1.actors_["1020ui_story"]) and arg_604_1.var_.characterEffect1020ui_story then
				arg_604_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_607_2 = 0
			local var_607_3 = 0.05

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_2 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_4 = arg_604_1:GetWordFromCfg(924011146)
				local var_607_5 = arg_604_1:FormatText(var_607_4.content)

				arg_604_1.text_.text = var_607_5

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_7 = 2 <= 0 and var_607_3 or var_607_3 * (utf8.len(var_607_5) / 2)

				if (2 <= 0 and var_607_3 or var_607_3 * (utf8.len(var_607_5) / 2)) > 0 and var_607_3 < var_607_7 then
					arg_604_1.talkMaxDuration = var_607_7

					if var_607_7 + var_607_2 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_7 + var_607_2
					end
				end

				arg_604_1.text_.text = var_607_5
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb") ~= 0 then
					local var_607_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb") / 1000

					if var_607_8 + var_607_2 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_8 + var_607_2
					end

					if var_607_4.prefab_name ~= "" and arg_604_1.actors_[var_607_4.prefab_name] ~= nil then
						local var_607_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_4.prefab_name].transform, "story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb")

						arg_604_1:RecordAudio("924011146", var_607_9)
						arg_604_1:RecordAudio("924011146", var_607_9)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011146", "story_v_side_old_924011.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_10 = math.max(var_607_3, arg_604_1.talkMaxDuration)

			if var_607_2 <= arg_604_1.time_ and arg_604_1.time_ < var_607_2 + var_607_10 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_2) / var_607_10

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_2 + var_607_10 and arg_604_1.time_ < var_607_2 + var_607_10 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play924011147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 924011147
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play924011148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.var_.moveOldPos1020ui_story = arg_608_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_611_0 = 0.001

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_0 then
				arg_608_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_608_1.time_ - 0) / var_611_0)
				arg_608_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1020ui_story"].transform.position).z)
				arg_608_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["1020ui_story"].transform.localEulerAngles = arg_608_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_608_1.time_ >= 0 + var_611_0 and arg_608_1.time_ < 0 + var_611_0 + arg_611_0 then
				arg_608_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_608_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1020ui_story"].transform.position).z)
				arg_608_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["1020ui_story"].transform.localEulerAngles = arg_608_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_611_1 = arg_608_1.actors_["1020ui_story"]

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 and not isNil(var_611_1) and arg_608_1.var_.characterEffect1020ui_story == nil then
				arg_608_1.var_.characterEffect1020ui_story = var_611_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_2 = 0.200000002980232

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_2 and not isNil(var_611_1) then
				if arg_608_1.var_.characterEffect1020ui_story and not isNil(var_611_1) then
					arg_608_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_608_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_608_1.time_ - 0) / var_611_2)
				end
			end

			if arg_608_1.time_ >= 0 + var_611_2 and arg_608_1.time_ < 0 + var_611_2 + arg_611_0 and not isNil(var_611_1) and arg_608_1.var_.characterEffect1020ui_story then
				arg_608_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_608_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_608_1.time_ and arg_608_1.time_ <= 0.125 + arg_611_0 then
				arg_608_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_roll", "")
			end

			local var_611_4 = 0
			local var_611_5 = 0.45

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_4 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_6 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(924011147).content)

				arg_608_1.text_.text = var_611_6

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_8 = 18 <= 0 and var_611_5 or var_611_5 * (utf8.len(var_611_6) / 18)

				if (18 <= 0 and var_611_5 or var_611_5 * (utf8.len(var_611_6) / 18)) > 0 and var_611_5 < var_611_8 then
					arg_608_1.talkMaxDuration = var_611_8

					if var_611_8 + var_611_4 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_8 + var_611_4
					end
				end

				arg_608_1.text_.text = var_611_6
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_9 = math.max(var_611_5, arg_608_1.talkMaxDuration)

			if var_611_4 <= arg_608_1.time_ and arg_608_1.time_ < var_611_4 + var_611_9 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_4) / var_611_9

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_4 + var_611_9 and arg_608_1.time_ < var_611_4 + var_611_9 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play924011148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 924011148
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play924011149(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0.125

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, true)
				arg_612_1.iconController_:SetSelectedState("hero")

				arg_612_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_612_1.callingController_:SetSelectedState("normal")

				arg_612_1.keyicon_.color = Color.New(1, 1, 1)
				arg_612_1.icon_.color = Color.New(1, 1, 1)

				local var_615_1 = arg_612_1:FormatText(arg_612_1:GetWordFromCfg(924011148).content)

				arg_612_1.text_.text = var_615_1

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_3 = 5 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 5)

				if (5 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 5)) > 0 and var_615_0 < var_615_3 then
					arg_612_1.talkMaxDuration = var_615_3

					if var_615_3 + 0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_3 + 0
					end
				end

				arg_612_1.text_.text = var_615_1
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_4 = math.max(var_615_0, arg_612_1.talkMaxDuration)

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_4 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - 0) / var_615_4

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= 0 + var_615_4 and arg_612_1.time_ < 0 + var_615_4 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play924011149 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 924011149
		arg_616_1.duration_ = 1.1

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play924011150(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0.05

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				arg_616_1.leftNameTxt_.text = arg_616_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, true)
				arg_616_1.iconController_:SetSelectedState("hero")

				arg_616_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_616_1.callingController_:SetSelectedState("normal")

				arg_616_1.keyicon_.color = Color.New(1, 1, 1)
				arg_616_1.icon_.color = Color.New(1, 1, 1)

				local var_619_1 = arg_616_1:GetWordFromCfg(924011149)
				local var_619_2 = arg_616_1:FormatText(var_619_1.content)

				arg_616_1.text_.text = var_619_2

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_4 = 2 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_2) / 2)

				if (2 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_2) / 2)) > 0 and var_619_0 < var_619_4 then
					arg_616_1.talkMaxDuration = var_619_4

					if var_619_4 + 0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_4 + 0
					end
				end

				arg_616_1.text_.text = var_619_2
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb") ~= 0 then
					local var_619_5 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb") / 1000

					if var_619_5 + 0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_5 + 0
					end

					if var_619_1.prefab_name ~= "" and arg_616_1.actors_[var_619_1.prefab_name] ~= nil then
						local var_619_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_1.prefab_name].transform, "story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb")

						arg_616_1:RecordAudio("924011149", var_619_6)
						arg_616_1:RecordAudio("924011149", var_619_6)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011149", "story_v_side_old_924011.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_7 = math.max(var_619_0, arg_616_1.talkMaxDuration)

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_7 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - 0) / var_619_7

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= 0 + var_619_7 and arg_616_1.time_ < 0 + var_619_7 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play924011150 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 924011150
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play924011151(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0.825

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, false)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_1 = arg_620_1:FormatText(arg_620_1:GetWordFromCfg(924011150).content)

				arg_620_1.text_.text = var_623_1

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_3 = 33 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 33)

				if (33 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_1) / 33)) > 0 and var_623_0 < var_623_3 then
					arg_620_1.talkMaxDuration = var_623_3

					if var_623_3 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_3 + 0
					end
				end

				arg_620_1.text_.text = var_623_1
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_4 = math.max(var_623_0, arg_620_1.talkMaxDuration)

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_4 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - 0) / var_623_4

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= 0 + var_623_4 and arg_620_1.time_ < 0 + var_623_4 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play924011151 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 924011151
		arg_624_1.duration_ = 6.93

		local var_624_0 = {
			zh = 5.6,
			ja = 6.933
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play924011152(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.var_.moveOldPos1020ui_story = arg_624_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_627_0 = 0.001

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_0 then
				arg_624_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_624_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_624_1.time_ - 0) / var_627_0)
				arg_624_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_624_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1020ui_story"].transform.position).z)
				arg_624_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_624_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_624_1.actors_["1020ui_story"].transform.localEulerAngles = arg_624_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_624_1.time_ >= 0 + var_627_0 and arg_624_1.time_ < 0 + var_627_0 + arg_627_0 then
				arg_624_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_624_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_624_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_624_1.actors_["1020ui_story"].transform.position).z)
				arg_624_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_624_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_624_1.actors_["1020ui_story"].transform.localEulerAngles = arg_624_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_627_1 = 0
			local var_627_2 = 0.475

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_1 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_3 = arg_624_1:GetWordFromCfg(924011151)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_6 = 19 <= 0 and var_627_2 or var_627_2 * (utf8.len(var_627_4) / 19)

				if (19 <= 0 and var_627_2 or var_627_2 * (utf8.len(var_627_4) / 19)) > 0 and var_627_2 < var_627_6 then
					arg_624_1.talkMaxDuration = var_627_6

					if var_627_6 + var_627_1 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_6 + var_627_1
					end
				end

				arg_624_1.text_.text = var_627_4
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb") ~= 0 then
					local var_627_7 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb") / 1000

					if var_627_7 + var_627_1 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_1
					end

					if var_627_3.prefab_name ~= "" and arg_624_1.actors_[var_627_3.prefab_name] ~= nil then
						local var_627_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_3.prefab_name].transform, "story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb")

						arg_624_1:RecordAudio("924011151", var_627_8)
						arg_624_1:RecordAudio("924011151", var_627_8)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011151", "story_v_side_old_924011.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_9 = math.max(var_627_2, arg_624_1.talkMaxDuration)

			if var_627_1 <= arg_624_1.time_ and arg_624_1.time_ < var_627_1 + var_627_9 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_1) / var_627_9

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_1 + var_627_9 and arg_624_1.time_ < var_627_1 + var_627_9 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_624_1:InitPlayNodeList()
	end,
	Play924011152 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 924011152
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play924011153(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(arg_628_1.actors_["1020ui_story"]) and arg_628_1.var_.characterEffect1020ui_story == nil then
				arg_628_1.var_.characterEffect1020ui_story = arg_628_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_0 = 0.200000002980232

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_0 and not isNil(arg_628_1.actors_["1020ui_story"]) then
				if arg_628_1.var_.characterEffect1020ui_story and not isNil(arg_628_1.actors_["1020ui_story"]) then
					arg_628_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_628_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_628_1.time_ - 0) / var_631_0)
				end
			end

			if arg_628_1.time_ >= 0 + var_631_0 and arg_628_1.time_ < 0 + var_631_0 + arg_631_0 and not isNil(arg_628_1.actors_["1020ui_story"]) and arg_628_1.var_.characterEffect1020ui_story then
				arg_628_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_628_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_631_1 = 0
			local var_631_2 = 0.45

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, true)
				arg_628_1.iconController_:SetSelectedState("hero")

				arg_628_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_628_1.callingController_:SetSelectedState("normal")

				arg_628_1.keyicon_.color = Color.New(1, 1, 1)
				arg_628_1.icon_.color = Color.New(1, 1, 1)

				local var_631_3 = arg_628_1:FormatText(arg_628_1:GetWordFromCfg(924011152).content)

				arg_628_1.text_.text = var_631_3

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_5 = 18 <= 0 and var_631_2 or var_631_2 * (utf8.len(var_631_3) / 18)

				if (18 <= 0 and var_631_2 or var_631_2 * (utf8.len(var_631_3) / 18)) > 0 and var_631_2 < var_631_5 then
					arg_628_1.talkMaxDuration = var_631_5

					if var_631_5 + var_631_1 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_5 + var_631_1
					end
				end

				arg_628_1.text_.text = var_631_3
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_6 = math.max(var_631_2, arg_628_1.talkMaxDuration)

			if var_631_1 <= arg_628_1.time_ and arg_628_1.time_ < var_631_1 + var_631_6 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_1) / var_631_6

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_1 + var_631_6 and arg_628_1.time_ < var_631_1 + var_631_6 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play924011153 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 924011153
		arg_632_1.duration_ = 2.7

		local var_632_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play924011154(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1.var_.moveOldPos1020ui_story = arg_632_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_635_0 = 0.001

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_0 then
				arg_632_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_632_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_632_1.time_ - 0) / var_635_0)
				arg_632_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_632_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1020ui_story"].transform.position).z)
				arg_632_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_632_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_632_1.actors_["1020ui_story"].transform.localEulerAngles = arg_632_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_632_1.time_ >= 0 + var_635_0 and arg_632_1.time_ < 0 + var_635_0 + arg_635_0 then
				arg_632_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_632_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_632_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1020ui_story"].transform.position).z)
				arg_632_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_632_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_632_1.actors_["1020ui_story"].transform.localEulerAngles = arg_632_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_635_1 = arg_632_1.actors_["1020ui_story"]

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 and not isNil(var_635_1) and arg_632_1.var_.characterEffect1020ui_story == nil then
				arg_632_1.var_.characterEffect1020ui_story = var_635_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_2 = 0.200000002980232

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_2 and not isNil(var_635_1) then
				if arg_632_1.var_.characterEffect1020ui_story and not isNil(var_635_1) then
					arg_632_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_632_1.time_ >= 0 + var_635_2 and arg_632_1.time_ < 0 + var_635_2 + arg_635_0 and not isNil(var_635_1) and arg_632_1.var_.characterEffect1020ui_story then
				arg_632_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_635_4 = 0
			local var_635_5 = 0.125

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_4 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				arg_632_1.leftNameTxt_.text = arg_632_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_6 = arg_632_1:GetWordFromCfg(924011153)
				local var_635_7 = arg_632_1:FormatText(var_635_6.content)

				arg_632_1.text_.text = var_635_7

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_9 = 5 <= 0 and var_635_5 or var_635_5 * (utf8.len(var_635_7) / 5)

				if (5 <= 0 and var_635_5 or var_635_5 * (utf8.len(var_635_7) / 5)) > 0 and var_635_5 < var_635_9 then
					arg_632_1.talkMaxDuration = var_635_9

					if var_635_9 + var_635_4 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_9 + var_635_4
					end
				end

				arg_632_1.text_.text = var_635_7
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb") ~= 0 then
					local var_635_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb") / 1000

					if var_635_10 + var_635_4 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_10 + var_635_4
					end

					if var_635_6.prefab_name ~= "" and arg_632_1.actors_[var_635_6.prefab_name] ~= nil then
						local var_635_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_6.prefab_name].transform, "story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb")

						arg_632_1:RecordAudio("924011153", var_635_11)
						arg_632_1:RecordAudio("924011153", var_635_11)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011153", "story_v_side_old_924011.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_12 = math.max(var_635_5, arg_632_1.talkMaxDuration)

			if var_635_4 <= arg_632_1.time_ and arg_632_1.time_ < var_635_4 + var_635_12 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_4) / var_635_12

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_4 + var_635_12 and arg_632_1.time_ < var_635_4 + var_635_12 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_632_1:InitPlayNodeList()
	end,
	Play924011154 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 924011154
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play924011155(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1.var_.moveOldPos1020ui_story = arg_636_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_639_0 = 0.001

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_0 then
				arg_636_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_636_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_636_1.time_ - 0) / var_639_0)
				arg_636_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_636_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_636_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_636_1.actors_["1020ui_story"].transform.position).z)
				arg_636_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_636_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_636_1.actors_["1020ui_story"].transform.localEulerAngles = arg_636_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_636_1.time_ >= 0 + var_639_0 and arg_636_1.time_ < 0 + var_639_0 + arg_639_0 then
				arg_636_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_636_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_636_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_636_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_636_1.actors_["1020ui_story"].transform.position).z)
				arg_636_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_636_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_636_1.actors_["1020ui_story"].transform.localEulerAngles = arg_636_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_639_1 = arg_636_1.actors_["1020ui_story"]

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 and not isNil(var_639_1) and arg_636_1.var_.characterEffect1020ui_story == nil then
				arg_636_1.var_.characterEffect1020ui_story = var_639_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_2 = 0.200000002980232

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_2 and not isNil(var_639_1) then
				if arg_636_1.var_.characterEffect1020ui_story and not isNil(var_639_1) then
					arg_636_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_636_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_636_1.time_ - 0) / var_639_2)
				end
			end

			if arg_636_1.time_ >= 0 + var_639_2 and arg_636_1.time_ < 0 + var_639_2 + arg_639_0 and not isNil(var_639_1) and arg_636_1.var_.characterEffect1020ui_story then
				arg_636_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_636_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_639_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_636_1.bgmTxt_.text ~= var_639_5 and arg_636_1.bgmTxt_.text ~= "" then
						if arg_636_1.bgmTxt2_.text ~= "" then
							arg_636_1.bgmTxt_.text = arg_636_1.bgmTxt2_.text
						end

						arg_636_1.bgmTxt2_.text = var_639_5

						arg_636_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_636_1.bgmTxt_.text = var_639_5
						arg_636_1.bgmTxt2_.text = var_639_5
					end

					if arg_636_1.bgmTimer then
						arg_636_1.bgmTimer:Stop()

						arg_636_1.bgmTimer = nil
					end

					if arg_636_1.settingData.show_music_name == 1 then
						arg_636_1.musicController:SetSelectedState("show")
						arg_636_1.musicAnimator_:Play("open", 0, 0)

						if arg_636_1.settingData.music_time ~= 0 then
							arg_636_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_636_1.settingData.music_time), function()
								if arg_636_1 == nil or isNil(arg_636_1.bgmTxt_) then
									return
								end

								arg_636_1.musicController:SetSelectedState("hide")
								arg_636_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_639_6 = 0
			local var_639_7 = 0.925

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_6 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, false)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_8 = arg_636_1:FormatText(arg_636_1:GetWordFromCfg(924011154).content)

				arg_636_1.text_.text = var_639_8

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_10 = 37 <= 0 and var_639_7 or var_639_7 * (utf8.len(var_639_8) / 37)

				if (37 <= 0 and var_639_7 or var_639_7 * (utf8.len(var_639_8) / 37)) > 0 and var_639_7 < var_639_10 then
					arg_636_1.talkMaxDuration = var_639_10

					if var_639_10 + var_639_6 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_10 + var_639_6
					end
				end

				arg_636_1.text_.text = var_639_8
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_11 = math.max(var_639_7, arg_636_1.talkMaxDuration)

			if var_639_6 <= arg_636_1.time_ and arg_636_1.time_ < var_639_6 + var_639_11 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_6) / var_639_11

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_6 + var_639_11 and arg_636_1.time_ < var_639_6 + var_639_11 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_636_1:InitPlayNodeList()
	end,
	Play924011155 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 924011155
		arg_641_1.duration_ = 12.2

		local var_641_0 = {
			zh = 9.83300000298023,
			ja = 12.2000000029802
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play924011156(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 2.00000000298023 < arg_641_1.time_ and arg_641_1.time_ <= 2.00000000298023 + arg_644_0 then
				local var_644_0 = arg_641_1.bgs_.ST01

				arg_641_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_644_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_644_1 = var_644_0:GetComponent("SpriteRenderer")

				if var_644_1 and var_644_1.sprite then
					local var_644_2 = 2 * (var_644_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_644_0.transform.localScale = Vector3.New(var_644_2 / var_644_1.sprite.bounds.size.y < var_644_2 * manager.ui.mainCameraCom_.aspect / var_644_1.sprite.bounds.size.x and var_644_2 * manager.ui.mainCameraCom_.aspect / var_644_1.sprite.bounds.size.x or var_644_2 / var_644_1.sprite.bounds.size.y, var_644_2 / var_644_1.sprite.bounds.size.y < var_644_2 * manager.ui.mainCameraCom_.aspect / var_644_1.sprite.bounds.size.x and var_644_2 * manager.ui.mainCameraCom_.aspect / var_644_1.sprite.bounds.size.x or var_644_2 / var_644_1.sprite.bounds.size.y, 0)
				end

				for iter_644_0, iter_644_1 in pairs(arg_641_1.bgs_) do
					if iter_644_0 ~= "ST01" then
						iter_644_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_644_3 = 4

			if 4 < arg_641_1.time_ and arg_641_1.time_ <= var_644_3 + arg_644_0 then
				arg_641_1.allBtn_.enabled = false
			end

			if arg_641_1.time_ >= var_644_3 + 0.3 and arg_641_1.time_ < var_644_3 + 0.3 + arg_644_0 then
				arg_641_1.allBtn_.enabled = true
			end

			local var_644_4 = 0

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_4 + arg_644_0 then
				arg_641_1.mask_.enabled = true
				arg_641_1.mask_.raycastTarget = true

				arg_641_1:SetGaussion(false)
			end

			local var_644_5 = 2

			if var_644_4 <= arg_641_1.time_ and arg_641_1.time_ < var_644_4 + var_644_5 then
				local var_644_6 = Color.New(0, 0, 0)

				var_644_6.a = Mathf.Lerp(0, 1, (arg_641_1.time_ - var_644_4) / var_644_5)
				arg_641_1.mask_.color = var_644_6
			end

			if arg_641_1.time_ >= var_644_4 + var_644_5 and arg_641_1.time_ < var_644_4 + var_644_5 + arg_644_0 then
				local var_644_7 = Color.New(0, 0, 0)

				var_644_7.a = 1
				arg_641_1.mask_.color = var_644_7
			end

			local var_644_8 = 2

			if 2 < arg_641_1.time_ and arg_641_1.time_ <= var_644_8 + arg_644_0 then
				arg_641_1.mask_.enabled = true
				arg_641_1.mask_.raycastTarget = true

				arg_641_1:SetGaussion(false)
			end

			local var_644_9 = 2

			if var_644_8 <= arg_641_1.time_ and arg_641_1.time_ < var_644_8 + var_644_9 then
				local var_644_10 = Color.New(0, 0, 0)

				var_644_10.a = Mathf.Lerp(1, 0, (arg_641_1.time_ - var_644_8) / var_644_9)
				arg_641_1.mask_.color = var_644_10
			end

			if arg_641_1.time_ >= var_644_8 + var_644_9 and arg_641_1.time_ < var_644_8 + var_644_9 + arg_644_0 then
				local var_644_11 = Color.New(0, 0, 0)

				arg_641_1.mask_.enabled = false
				var_644_11.a = 0
				arg_641_1.mask_.color = var_644_11
			end

			local var_644_12 = arg_641_1.actors_["1033ui_story"].transform

			if 3.8 < arg_641_1.time_ and arg_641_1.time_ <= 3.8 + arg_644_0 then
				arg_641_1.var_.moveOldPos1033ui_story = var_644_12.localPosition
			end

			local var_644_13 = 0.001

			if 3.8 <= arg_641_1.time_ and arg_641_1.time_ < 3.8 + var_644_13 then
				var_644_12.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_641_1.time_ - 3.8) / var_644_13)
				var_644_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_644_12.position).x, (manager.ui.mainCamera.transform.position - var_644_12.position).y, (manager.ui.mainCamera.transform.position - var_644_12.position).z)
				var_644_12.localEulerAngles.z = 0
				var_644_12.localEulerAngles.x = 0
				var_644_12.localEulerAngles = var_644_12.localEulerAngles
			end

			if arg_641_1.time_ >= 3.8 + var_644_13 and arg_641_1.time_ < 3.8 + var_644_13 + arg_644_0 then
				var_644_12.localPosition = Vector3.New(0, -1.01, -6.13)
				var_644_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_644_12.position).x, (manager.ui.mainCamera.transform.position - var_644_12.position).y, (manager.ui.mainCamera.transform.position - var_644_12.position).z)
				var_644_12.localEulerAngles.z = 0
				var_644_12.localEulerAngles.x = 0
				var_644_12.localEulerAngles = var_644_12.localEulerAngles
			end

			local var_644_14 = arg_641_1.actors_["1033ui_story"]

			if 3.8 < arg_641_1.time_ and arg_641_1.time_ <= 3.8 + arg_644_0 and not isNil(var_644_14) and arg_641_1.var_.characterEffect1033ui_story == nil then
				arg_641_1.var_.characterEffect1033ui_story = var_644_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_15 = 0.200000002980232

			if 3.8 <= arg_641_1.time_ and arg_641_1.time_ < 3.8 + var_644_15 and not isNil(var_644_14) then
				if arg_641_1.var_.characterEffect1033ui_story and not isNil(var_644_14) then
					arg_641_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= 3.8 + var_644_15 and arg_641_1.time_ < 3.8 + var_644_15 + arg_644_0 and not isNil(var_644_14) and arg_641_1.var_.characterEffect1033ui_story then
				arg_641_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 3.8 < arg_641_1.time_ and arg_641_1.time_ <= 3.8 + arg_644_0 then
				arg_641_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 3.8 < arg_641_1.time_ and arg_641_1.time_ <= 3.8 + arg_644_0 then
				arg_641_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 3.8 < arg_641_1.time_ and arg_641_1.time_ <= 3.8 + arg_644_0 then
				if arg_641_1.var_.characterEffect1033ui_story == nil then
					arg_641_1.var_.characterEffect1033ui_story = arg_641_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_644_17 = arg_641_1.var_.characterEffect1033ui_story

				arg_641_1.var_.characterEffect1033ui_story.imageEffect:turnOff()

				var_644_17.interferenceEffect.enabled = true
				var_644_17.interferenceEffect.noise = 0.001
				var_644_17.interferenceEffect.simTimeScale = 1
				var_644_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.8 < arg_641_1.time_ and arg_641_1.time_ <= 3.8 + arg_644_0 then
				if arg_641_1.var_.characterEffect1033ui_story == nil then
					arg_641_1.var_.characterEffect1033ui_story = arg_641_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_641_1.var_.characterEffect1033ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_644_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_641_1.bgmTxt_.text ~= var_644_21 and arg_641_1.bgmTxt_.text ~= "" then
						if arg_641_1.bgmTxt2_.text ~= "" then
							arg_641_1.bgmTxt_.text = arg_641_1.bgmTxt2_.text
						end

						arg_641_1.bgmTxt2_.text = var_644_21

						arg_641_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_641_1.bgmTxt_.text = var_644_21
						arg_641_1.bgmTxt2_.text = var_644_21
					end

					if arg_641_1.bgmTimer then
						arg_641_1.bgmTimer:Stop()

						arg_641_1.bgmTimer = nil
					end

					if arg_641_1.settingData.show_music_name == 1 then
						arg_641_1.musicController:SetSelectedState("show")
						arg_641_1.musicAnimator_:Play("open", 0, 0)

						if arg_641_1.settingData.music_time ~= 0 then
							arg_641_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_641_1.settingData.music_time), function()
								if arg_641_1 == nil or isNil(arg_641_1.bgmTxt_) then
									return
								end

								arg_641_1.musicController:SetSelectedState("hide")
								arg_641_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_641_1.time_ and arg_641_1.time_ <= 1 + arg_644_0 then
				arg_641_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_644_24 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_641_1.bgmTxt_.text ~= var_644_24 and arg_641_1.bgmTxt_.text ~= "" then
						if arg_641_1.bgmTxt2_.text ~= "" then
							arg_641_1.bgmTxt_.text = arg_641_1.bgmTxt2_.text
						end

						arg_641_1.bgmTxt2_.text = var_644_24

						arg_641_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_641_1.bgmTxt_.text = var_644_24
						arg_641_1.bgmTxt2_.text = var_644_24
					end

					if arg_641_1.bgmTimer then
						arg_641_1.bgmTimer:Stop()

						arg_641_1.bgmTimer = nil
					end

					if arg_641_1.settingData.show_music_name == 1 then
						arg_641_1.musicController:SetSelectedState("show")
						arg_641_1.musicAnimator_:Play("open", 0, 0)

						if arg_641_1.settingData.music_time ~= 0 then
							arg_641_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_641_1.settingData.music_time), function()
								if arg_641_1 == nil or isNil(arg_641_1.bgmTxt_) then
									return
								end

								arg_641_1.musicController:SetSelectedState("hide")
								arg_641_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_641_1.frameCnt_ <= 1 then
				arg_641_1.dialog_:SetActive(false)
			end

			local var_644_25 = 4.00000000298023
			local var_644_26 = 0.75

			if 4.00000000298023 < arg_641_1.time_ and arg_641_1.time_ <= var_644_25 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0

				arg_641_1.dialog_:SetActive(true)

				arg_641_1.dialogCg_.alpha = 0

				local var_644_27 = LeanTween.value(arg_641_1.dialog_, 0, 1, 0.3)

				var_644_27:setOnUpdate(LuaHelper.FloatAction(function(arg_647_0)
					arg_641_1.dialogCg_.alpha = arg_647_0
				end))
				var_644_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_641_1.dialog_)
					var_644_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_641_1.duration_ = arg_641_1.duration_ + 0.3

				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_28 = arg_641_1:GetWordFromCfg(924011155)
				local var_644_29 = arg_641_1:FormatText(var_644_28.content)

				arg_641_1.text_.text = var_644_29

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_31 = 30 <= 0 and var_644_26 or var_644_26 * (utf8.len(var_644_29) / 30)

				if (30 <= 0 and var_644_26 or var_644_26 * (utf8.len(var_644_29) / 30)) > 0 and var_644_26 < var_644_31 then
					arg_641_1.talkMaxDuration = var_644_31
					var_644_25 = var_644_25 + 0.3

					if var_644_31 + var_644_25 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_31 + var_644_25
					end
				end

				arg_641_1.text_.text = var_644_29
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb") ~= 0 then
					local var_644_32 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb") / 1000

					if var_644_32 + var_644_25 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_32 + var_644_25
					end

					if var_644_28.prefab_name ~= "" and arg_641_1.actors_[var_644_28.prefab_name] ~= nil then
						local var_644_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_28.prefab_name].transform, "story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb")

						arg_641_1:RecordAudio("924011155", var_644_33)
						arg_641_1:RecordAudio("924011155", var_644_33)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011155", "story_v_side_old_924011.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_34 = var_644_25 + 0.3
			local var_644_35 = math.max(var_644_26, arg_641_1.talkMaxDuration)

			if var_644_25 + 0.3 <= arg_641_1.time_ and arg_641_1.time_ < var_644_34 + var_644_35 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_34) / var_644_35

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_34 + var_644_35 and arg_641_1.time_ < var_644_34 + var_644_35 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play924011156 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 924011156
		arg_649_1.duration_ = 15.63

		local var_649_0 = {
			zh = 10.433,
			ja = 15.633
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play924011157(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_652_0 = 0
			local var_652_1 = 1.325

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_2 = arg_649_1:GetWordFromCfg(924011156)
				local var_652_3 = arg_649_1:FormatText(var_652_2.content)

				arg_649_1.text_.text = var_652_3

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_5 = 53 <= 0 and var_652_1 or var_652_1 * (utf8.len(var_652_3) / 53)

				if (53 <= 0 and var_652_1 or var_652_1 * (utf8.len(var_652_3) / 53)) > 0 and var_652_1 < var_652_5 then
					arg_649_1.talkMaxDuration = var_652_5

					if var_652_5 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_5 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_3
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb") ~= 0 then
					local var_652_6 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb") / 1000

					if var_652_6 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_6 + var_652_0
					end

					if var_652_2.prefab_name ~= "" and arg_649_1.actors_[var_652_2.prefab_name] ~= nil then
						local var_652_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_2.prefab_name].transform, "story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb")

						arg_649_1:RecordAudio("924011156", var_652_7)
						arg_649_1:RecordAudio("924011156", var_652_7)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011156", "story_v_side_old_924011.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_8 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_8 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_8

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_8 and arg_649_1.time_ < var_652_0 + var_652_8 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play924011157 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 924011157
		arg_653_1.duration_ = 2.3

		local var_653_0 = {
			zh = 2,
			ja = 2.3
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play924011158(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.var_.moveOldPos1020ui_story = arg_653_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_656_0 = 0.001

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 then
				arg_653_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_653_1.time_ - 0) / var_656_0)
				arg_653_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1020ui_story"].transform.position).z)
				arg_653_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["1020ui_story"].transform.localEulerAngles = arg_653_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 then
				arg_653_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0.7, -0.85, -6.25)
				arg_653_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1020ui_story"].transform.position).z)
				arg_653_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["1020ui_story"].transform.localEulerAngles = arg_653_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_656_1 = arg_653_1.actors_["1033ui_story"].transform

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.var_.moveOldPos1033ui_story = var_656_1.localPosition
			end

			local var_656_2 = 0.001

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_2 then
				var_656_1.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_653_1.time_ - 0) / var_656_2)
				var_656_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_656_1.position).x, (manager.ui.mainCamera.transform.position - var_656_1.position).y, (manager.ui.mainCamera.transform.position - var_656_1.position).z)
				var_656_1.localEulerAngles.z = 0
				var_656_1.localEulerAngles.x = 0
				var_656_1.localEulerAngles = var_656_1.localEulerAngles
			end

			if arg_653_1.time_ >= 0 + var_656_2 and arg_653_1.time_ < 0 + var_656_2 + arg_656_0 then
				var_656_1.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				var_656_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_656_1.position).x, (manager.ui.mainCamera.transform.position - var_656_1.position).y, (manager.ui.mainCamera.transform.position - var_656_1.position).z)
				var_656_1.localEulerAngles.z = 0
				var_656_1.localEulerAngles.x = 0
				var_656_1.localEulerAngles = var_656_1.localEulerAngles
			end

			local var_656_3 = arg_653_1.actors_["1020ui_story"]

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(var_656_3) and arg_653_1.var_.characterEffect1020ui_story == nil then
				arg_653_1.var_.characterEffect1020ui_story = var_656_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_4 = 0.200000002980232

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_4 and not isNil(var_656_3) then
				if arg_653_1.var_.characterEffect1020ui_story and not isNil(var_656_3) then
					arg_653_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= 0 + var_656_4 and arg_653_1.time_ < 0 + var_656_4 + arg_656_0 and not isNil(var_656_3) and arg_653_1.var_.characterEffect1020ui_story then
				arg_653_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_656_6 = arg_653_1.actors_["1033ui_story"]

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(var_656_6) and arg_653_1.var_.characterEffect1033ui_story == nil then
				arg_653_1.var_.characterEffect1033ui_story = var_656_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_7 = 0.200000002980232

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_7 and not isNil(var_656_6) then
				if arg_653_1.var_.characterEffect1033ui_story and not isNil(var_656_6) then
					arg_653_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_653_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_653_1.time_ - 0) / var_656_7)
				end
			end

			if arg_653_1.time_ >= 0 + var_656_7 and arg_653_1.time_ < 0 + var_656_7 + arg_656_0 and not isNil(var_656_6) and arg_653_1.var_.characterEffect1033ui_story then
				arg_653_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_653_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_656_8 = 0
			local var_656_9 = 0.3

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_8 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_10 = arg_653_1:GetWordFromCfg(924011157)
				local var_656_11 = arg_653_1:FormatText(var_656_10.content)

				arg_653_1.text_.text = var_656_11

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_13 = 12 <= 0 and var_656_9 or var_656_9 * (utf8.len(var_656_11) / 12)

				if (12 <= 0 and var_656_9 or var_656_9 * (utf8.len(var_656_11) / 12)) > 0 and var_656_9 < var_656_13 then
					arg_653_1.talkMaxDuration = var_656_13

					if var_656_13 + var_656_8 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_13 + var_656_8
					end
				end

				arg_653_1.text_.text = var_656_11
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb") ~= 0 then
					local var_656_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb") / 1000

					if var_656_14 + var_656_8 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_14 + var_656_8
					end

					if var_656_10.prefab_name ~= "" and arg_653_1.actors_[var_656_10.prefab_name] ~= nil then
						local var_656_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_10.prefab_name].transform, "story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb")

						arg_653_1:RecordAudio("924011157", var_656_15)
						arg_653_1:RecordAudio("924011157", var_656_15)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011157", "story_v_side_old_924011.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_16 = math.max(var_656_9, arg_653_1.talkMaxDuration)

			if var_656_8 <= arg_653_1.time_ and arg_653_1.time_ < var_656_8 + var_656_16 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_8) / var_656_16

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_8 + var_656_16 and arg_653_1.time_ < var_656_8 + var_656_16 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_653_1:InitPlayNodeList()
	end,
	Play924011158 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 924011158
		arg_657_1.duration_ = 5.4

		local var_657_0 = {
			zh = 2.733,
			ja = 5.4
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play924011159(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.var_.moveOldPos1033ui_story = arg_657_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_660_0 = 0.001

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 then
				arg_657_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_657_1.time_ - 0) / var_660_0)
				arg_657_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1033ui_story"].transform.position).z)
				arg_657_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1033ui_story"].transform.localEulerAngles = arg_657_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 then
				arg_657_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_657_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1033ui_story"].transform.position).z)
				arg_657_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1033ui_story"].transform.localEulerAngles = arg_657_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_660_1 = arg_657_1.actors_["1033ui_story"]

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1033ui_story == nil then
				arg_657_1.var_.characterEffect1033ui_story = var_660_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_2 and not isNil(var_660_1) then
				if arg_657_1.var_.characterEffect1033ui_story and not isNil(var_660_1) then
					arg_657_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= 0 + var_660_2 and arg_657_1.time_ < 0 + var_660_2 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1033ui_story then
				arg_657_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_660_4 = arg_657_1.actors_["1020ui_story"]

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(var_660_4) and arg_657_1.var_.characterEffect1020ui_story == nil then
				arg_657_1.var_.characterEffect1020ui_story = var_660_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_5 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_5 and not isNil(var_660_4) then
				if arg_657_1.var_.characterEffect1020ui_story and not isNil(var_660_4) then
					arg_657_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_657_1.time_ - 0) / var_660_5)
				end
			end

			if arg_657_1.time_ >= 0 + var_660_5 and arg_657_1.time_ < 0 + var_660_5 + arg_660_0 and not isNil(var_660_4) and arg_657_1.var_.characterEffect1020ui_story then
				arg_657_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action434")
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_660_6 = 0
			local var_660_7 = 0.225

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_6 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_8 = arg_657_1:GetWordFromCfg(924011158)
				local var_660_9 = arg_657_1:FormatText(var_660_8.content)

				arg_657_1.text_.text = var_660_9

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_11 = 9 <= 0 and var_660_7 or var_660_7 * (utf8.len(var_660_9) / 9)

				if (9 <= 0 and var_660_7 or var_660_7 * (utf8.len(var_660_9) / 9)) > 0 and var_660_7 < var_660_11 then
					arg_657_1.talkMaxDuration = var_660_11

					if var_660_11 + var_660_6 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_11 + var_660_6
					end
				end

				arg_657_1.text_.text = var_660_9
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb") ~= 0 then
					local var_660_12 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb") / 1000

					if var_660_12 + var_660_6 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_12 + var_660_6
					end

					if var_660_8.prefab_name ~= "" and arg_657_1.actors_[var_660_8.prefab_name] ~= nil then
						local var_660_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_8.prefab_name].transform, "story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb")

						arg_657_1:RecordAudio("924011158", var_660_13)
						arg_657_1:RecordAudio("924011158", var_660_13)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011158", "story_v_side_old_924011.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_14 = math.max(var_660_7, arg_657_1.talkMaxDuration)

			if var_660_6 <= arg_657_1.time_ and arg_657_1.time_ < var_660_6 + var_660_14 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_6) / var_660_14

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_6 + var_660_14 and arg_657_1.time_ < var_660_6 + var_660_14 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_657_1:InitPlayNodeList()
	end,
	Play924011159 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 924011159
		arg_661_1.duration_ = 9

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play924011160(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 2 < arg_661_1.time_ and arg_661_1.time_ <= 2 + arg_664_0 then
				local var_664_0 = arg_661_1.bgs_.ST2201

				arg_661_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_664_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_664_1 = var_664_0:GetComponent("SpriteRenderer")

				if var_664_1 and var_664_1.sprite then
					local var_664_2 = 2 * (var_664_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_664_0.transform.localScale = Vector3.New(var_664_2 / var_664_1.sprite.bounds.size.y < var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x and var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x or var_664_2 / var_664_1.sprite.bounds.size.y, var_664_2 / var_664_1.sprite.bounds.size.y < var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x and var_664_2 * manager.ui.mainCameraCom_.aspect / var_664_1.sprite.bounds.size.x or var_664_2 / var_664_1.sprite.bounds.size.y, 0)
				end

				for iter_664_0, iter_664_1 in pairs(arg_661_1.bgs_) do
					if iter_664_0 ~= "ST2201" then
						iter_664_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_664_3 = 3.999999999999

			if 3.999999999999 < arg_661_1.time_ and arg_661_1.time_ <= var_664_3 + arg_664_0 then
				arg_661_1.allBtn_.enabled = false
			end

			if arg_661_1.time_ >= var_664_3 + 0.3 and arg_661_1.time_ < var_664_3 + 0.3 + arg_664_0 then
				arg_661_1.allBtn_.enabled = true
			end

			local var_664_4 = 0

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_4 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_5 = 2

			if var_664_4 <= arg_661_1.time_ and arg_661_1.time_ < var_664_4 + var_664_5 then
				local var_664_6 = Color.New(0, 0, 0)

				var_664_6.a = Mathf.Lerp(0, 1, (arg_661_1.time_ - var_664_4) / var_664_5)
				arg_661_1.mask_.color = var_664_6
			end

			if arg_661_1.time_ >= var_664_4 + var_664_5 and arg_661_1.time_ < var_664_4 + var_664_5 + arg_664_0 then
				local var_664_7 = Color.New(0, 0, 0)

				var_664_7.a = 1
				arg_661_1.mask_.color = var_664_7
			end

			local var_664_8 = 2

			if 2 < arg_661_1.time_ and arg_661_1.time_ <= var_664_8 + arg_664_0 then
				arg_661_1.mask_.enabled = true
				arg_661_1.mask_.raycastTarget = true

				arg_661_1:SetGaussion(false)
			end

			local var_664_9 = 2

			if var_664_8 <= arg_661_1.time_ and arg_661_1.time_ < var_664_8 + var_664_9 then
				local var_664_10 = Color.New(0, 0, 0)

				var_664_10.a = Mathf.Lerp(1, 0, (arg_661_1.time_ - var_664_8) / var_664_9)
				arg_661_1.mask_.color = var_664_10
			end

			if arg_661_1.time_ >= var_664_8 + var_664_9 and arg_661_1.time_ < var_664_8 + var_664_9 + arg_664_0 then
				local var_664_11 = Color.New(0, 0, 0)

				arg_661_1.mask_.enabled = false
				var_664_11.a = 0
				arg_661_1.mask_.color = var_664_11
			end

			local var_664_12 = arg_661_1.actors_["1033ui_story"].transform

			if 1.96599999815226 < arg_661_1.time_ and arg_661_1.time_ <= 1.96599999815226 + arg_664_0 then
				arg_661_1.var_.moveOldPos1033ui_story = var_664_12.localPosition
			end

			local var_664_13 = 0.001

			if 1.96599999815226 <= arg_661_1.time_ and arg_661_1.time_ < 1.96599999815226 + var_664_13 then
				var_664_12.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_661_1.time_ - 1.96599999815226) / var_664_13)
				var_664_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_12.position).x, (manager.ui.mainCamera.transform.position - var_664_12.position).y, (manager.ui.mainCamera.transform.position - var_664_12.position).z)
				var_664_12.localEulerAngles.z = 0
				var_664_12.localEulerAngles.x = 0
				var_664_12.localEulerAngles = var_664_12.localEulerAngles
			end

			if arg_661_1.time_ >= 1.96599999815226 + var_664_13 and arg_661_1.time_ < 1.96599999815226 + var_664_13 + arg_664_0 then
				var_664_12.localPosition = Vector3.New(0, 100, 0)
				var_664_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_12.position).x, (manager.ui.mainCamera.transform.position - var_664_12.position).y, (manager.ui.mainCamera.transform.position - var_664_12.position).z)
				var_664_12.localEulerAngles.z = 0
				var_664_12.localEulerAngles.x = 0
				var_664_12.localEulerAngles = var_664_12.localEulerAngles
			end

			local var_664_14 = arg_661_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_661_1.time_ and arg_661_1.time_ <= 1.96599999815226 + arg_664_0 then
				arg_661_1.var_.moveOldPos1020ui_story = var_664_14.localPosition
			end

			local var_664_15 = 0.001

			if 1.96599999815226 <= arg_661_1.time_ and arg_661_1.time_ < 1.96599999815226 + var_664_15 then
				var_664_14.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_661_1.time_ - 1.96599999815226) / var_664_15)
				var_664_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_14.position).x, (manager.ui.mainCamera.transform.position - var_664_14.position).y, (manager.ui.mainCamera.transform.position - var_664_14.position).z)
				var_664_14.localEulerAngles.z = 0
				var_664_14.localEulerAngles.x = 0
				var_664_14.localEulerAngles = var_664_14.localEulerAngles
			end

			if arg_661_1.time_ >= 1.96599999815226 + var_664_15 and arg_661_1.time_ < 1.96599999815226 + var_664_15 + arg_664_0 then
				var_664_14.localPosition = Vector3.New(0, 100, 0)
				var_664_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_14.position).x, (manager.ui.mainCamera.transform.position - var_664_14.position).y, (manager.ui.mainCamera.transform.position - var_664_14.position).z)
				var_664_14.localEulerAngles.z = 0
				var_664_14.localEulerAngles.x = 0
				var_664_14.localEulerAngles = var_664_14.localEulerAngles
			end

			local var_664_16 = arg_661_1.actors_["1033ui_story"]

			if 1.96599999815226 < arg_661_1.time_ and arg_661_1.time_ <= 1.96599999815226 + arg_664_0 and not isNil(var_664_16) and arg_661_1.var_.characterEffect1033ui_story == nil then
				arg_661_1.var_.characterEffect1033ui_story = var_664_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_17 = 0.034000001847744

			if 1.96599999815226 <= arg_661_1.time_ and arg_661_1.time_ < 1.96599999815226 + var_664_17 and not isNil(var_664_16) then
				if arg_661_1.var_.characterEffect1033ui_story and not isNil(var_664_16) then
					arg_661_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_661_1.time_ - 1.96599999815226) / var_664_17)
				end
			end

			if arg_661_1.time_ >= 1.96599999815226 + var_664_17 and arg_661_1.time_ < 1.96599999815226 + var_664_17 + arg_664_0 and not isNil(var_664_16) and arg_661_1.var_.characterEffect1033ui_story then
				arg_661_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 1.96599999815226 < arg_661_1.time_ and arg_661_1.time_ <= 1.96599999815226 + arg_664_0 then
				if arg_661_1.var_.characterEffect1033ui_story == nil then
					arg_661_1.var_.characterEffect1033ui_story = arg_661_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_664_18 = arg_661_1.var_.characterEffect1033ui_story

				arg_661_1.var_.characterEffect1033ui_story.imageEffect:turnOff()

				var_664_18.interferenceEffect.enabled = false
				var_664_18.interferenceEffect.noise = 0.001
				var_664_18.interferenceEffect.simTimeScale = 1
				var_664_18.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 1.96599999815226 < arg_661_1.time_ and arg_661_1.time_ <= 1.96599999815226 + arg_664_0 then
				if arg_661_1.var_.characterEffect1033ui_story == nil then
					arg_661_1.var_.characterEffect1033ui_story = arg_661_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_661_1.var_.characterEffect1033ui_story.imageEffect:turnOff()
			end

			if 1.63333333333333 < arg_661_1.time_ and arg_661_1.time_ <= 1.63333333333333 + arg_664_0 then
				arg_661_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0.125 < arg_661_1.time_ and arg_661_1.time_ <= 0.125 + arg_664_0 then
				arg_661_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_661_1.frameCnt_ <= 1 then
				arg_661_1.dialog_:SetActive(false)
			end

			local var_664_22 = 3.999999999999
			local var_664_23 = 0.875

			if 3.999999999999 < arg_661_1.time_ and arg_661_1.time_ <= var_664_22 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0

				arg_661_1.dialog_:SetActive(true)

				arg_661_1.dialogCg_.alpha = 0

				local var_664_24 = LeanTween.value(arg_661_1.dialog_, 0, 1, 0.3)

				var_664_24:setOnUpdate(LuaHelper.FloatAction(function(arg_665_0)
					arg_661_1.dialogCg_.alpha = arg_665_0
				end))
				var_664_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_661_1.dialog_)
					var_664_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_661_1.duration_ = arg_661_1.duration_ + 0.3

				SetActive(arg_661_1.leftNameGo_, false)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_25 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(924011159).content)

				arg_661_1.text_.text = var_664_25

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_27 = 35 <= 0 and var_664_23 or var_664_23 * (utf8.len(var_664_25) / 35)

				if (35 <= 0 and var_664_23 or var_664_23 * (utf8.len(var_664_25) / 35)) > 0 and var_664_23 < var_664_27 then
					arg_661_1.talkMaxDuration = var_664_27
					var_664_22 = var_664_22 + 0.3

					if var_664_27 + var_664_22 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_27 + var_664_22
					end
				end

				arg_661_1.text_.text = var_664_25
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_28 = var_664_22 + 0.3
			local var_664_29 = math.max(var_664_23, arg_661_1.talkMaxDuration)

			if var_664_22 + 0.3 <= arg_661_1.time_ and arg_661_1.time_ < var_664_28 + var_664_29 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_28) / var_664_29

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_28 + var_664_29 and arg_661_1.time_ < var_664_28 + var_664_29 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_661_1:InitPlayNodeList()
	end,
	Play924011160 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 924011160
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play924011161(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0.4

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, true)
				arg_667_1.iconController_:SetSelectedState("hero")

				arg_667_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_667_1.callingController_:SetSelectedState("normal")

				arg_667_1.keyicon_.color = Color.New(1, 1, 1)
				arg_667_1.icon_.color = Color.New(1, 1, 1)

				local var_670_1 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(924011160).content)

				arg_667_1.text_.text = var_670_1

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_3 = 16 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_1) / 16)

				if (16 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_1) / 16)) > 0 and var_670_0 < var_670_3 then
					arg_667_1.talkMaxDuration = var_670_3

					if var_670_3 + 0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_3 + 0
					end
				end

				arg_667_1.text_.text = var_670_1
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_4 = math.max(var_670_0, arg_667_1.talkMaxDuration)

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_4 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - 0) / var_670_4

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= 0 + var_670_4 and arg_667_1.time_ < 0 + var_670_4 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play924011161 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 924011161
		arg_671_1.duration_ = 7.67

		local var_671_0 = {
			zh = 3.2,
			ja = 7.666
		}
		local var_671_1 = manager.audio:GetLocalizationFlag()

		if var_671_0[var_671_1] ~= nil then
			arg_671_1.duration_ = var_671_0[var_671_1]
		end

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play924011162(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1.var_.moveOldPos1033ui_story = arg_671_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_674_0 = 0.001

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_0 then
				arg_671_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_671_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_671_1.time_ - 0) / var_674_0)
				arg_671_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_671_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1033ui_story"].transform.position).z)
				arg_671_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_671_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_671_1.actors_["1033ui_story"].transform.localEulerAngles = arg_671_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_671_1.time_ >= 0 + var_674_0 and arg_671_1.time_ < 0 + var_674_0 + arg_674_0 then
				arg_671_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_671_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_671_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_671_1.actors_["1033ui_story"].transform.position).z)
				arg_671_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_671_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_671_1.actors_["1033ui_story"].transform.localEulerAngles = arg_671_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_674_1 = arg_671_1.actors_["1033ui_story"]

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 and not isNil(var_674_1) and arg_671_1.var_.characterEffect1033ui_story == nil then
				arg_671_1.var_.characterEffect1033ui_story = var_674_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_2 = 0.200000002980232

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_2 and not isNil(var_674_1) then
				if arg_671_1.var_.characterEffect1033ui_story and not isNil(var_674_1) then
					arg_671_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_671_1.time_ >= 0 + var_674_2 and arg_671_1.time_ < 0 + var_674_2 + arg_674_0 and not isNil(var_674_1) and arg_671_1.var_.characterEffect1033ui_story then
				arg_671_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_674_4 = 0
			local var_674_5 = 0.35

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_4 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_6 = arg_671_1:GetWordFromCfg(924011161)
				local var_674_7 = arg_671_1:FormatText(var_674_6.content)

				arg_671_1.text_.text = var_674_7

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_9 = 14 <= 0 and var_674_5 or var_674_5 * (utf8.len(var_674_7) / 14)

				if (14 <= 0 and var_674_5 or var_674_5 * (utf8.len(var_674_7) / 14)) > 0 and var_674_5 < var_674_9 then
					arg_671_1.talkMaxDuration = var_674_9

					if var_674_9 + var_674_4 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_9 + var_674_4
					end
				end

				arg_671_1.text_.text = var_674_7
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb") ~= 0 then
					local var_674_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb") / 1000

					if var_674_10 + var_674_4 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_10 + var_674_4
					end

					if var_674_6.prefab_name ~= "" and arg_671_1.actors_[var_674_6.prefab_name] ~= nil then
						local var_674_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_6.prefab_name].transform, "story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb")

						arg_671_1:RecordAudio("924011161", var_674_11)
						arg_671_1:RecordAudio("924011161", var_674_11)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011161", "story_v_side_old_924011.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_12 = math.max(var_674_5, arg_671_1.talkMaxDuration)

			if var_674_4 <= arg_671_1.time_ and arg_671_1.time_ < var_674_4 + var_674_12 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_4) / var_674_12

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_4 + var_674_12 and arg_671_1.time_ < var_674_4 + var_674_12 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_671_1:InitPlayNodeList()
	end,
	Play924011162 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 924011162
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play924011163(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(arg_675_1.actors_["1033ui_story"]) and arg_675_1.var_.characterEffect1033ui_story == nil then
				arg_675_1.var_.characterEffect1033ui_story = arg_675_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_0 = 0.200000002980232

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 and not isNil(arg_675_1.actors_["1033ui_story"]) then
				if arg_675_1.var_.characterEffect1033ui_story and not isNil(arg_675_1.actors_["1033ui_story"]) then
					arg_675_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_675_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_675_1.time_ - 0) / var_678_0)
				end
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 and not isNil(arg_675_1.actors_["1033ui_story"]) and arg_675_1.var_.characterEffect1033ui_story then
				arg_675_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_675_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_678_1 = 0
			local var_678_2 = 0.125

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, true)
				arg_675_1.iconController_:SetSelectedState("hero")

				arg_675_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_675_1.callingController_:SetSelectedState("normal")

				arg_675_1.keyicon_.color = Color.New(1, 1, 1)
				arg_675_1.icon_.color = Color.New(1, 1, 1)

				local var_678_3 = arg_675_1:FormatText(arg_675_1:GetWordFromCfg(924011162).content)

				arg_675_1.text_.text = var_678_3

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_5 = 5 <= 0 and var_678_2 or var_678_2 * (utf8.len(var_678_3) / 5)

				if (5 <= 0 and var_678_2 or var_678_2 * (utf8.len(var_678_3) / 5)) > 0 and var_678_2 < var_678_5 then
					arg_675_1.talkMaxDuration = var_678_5

					if var_678_5 + var_678_1 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_5 + var_678_1
					end
				end

				arg_675_1.text_.text = var_678_3
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_6 = math.max(var_678_2, arg_675_1.talkMaxDuration)

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_6 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_1) / var_678_6

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_1 + var_678_6 and arg_675_1.time_ < var_678_1 + var_678_6 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play924011163 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 924011163
		arg_679_1.duration_ = 4.97

		local var_679_0 = {
			zh = 3.066,
			ja = 4.966
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play924011164(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(arg_679_1.actors_["1033ui_story"]) and arg_679_1.var_.characterEffect1033ui_story == nil then
				arg_679_1.var_.characterEffect1033ui_story = arg_679_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_0 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 and not isNil(arg_679_1.actors_["1033ui_story"]) then
				if arg_679_1.var_.characterEffect1033ui_story and not isNil(arg_679_1.actors_["1033ui_story"]) then
					arg_679_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 and not isNil(arg_679_1.actors_["1033ui_story"]) and arg_679_1.var_.characterEffect1033ui_story then
				arg_679_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_682_2 = 0
			local var_682_3 = 0.375

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_2 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_4 = arg_679_1:GetWordFromCfg(924011163)
				local var_682_5 = arg_679_1:FormatText(var_682_4.content)

				arg_679_1.text_.text = var_682_5

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_7 = 15 <= 0 and var_682_3 or var_682_3 * (utf8.len(var_682_5) / 15)

				if (15 <= 0 and var_682_3 or var_682_3 * (utf8.len(var_682_5) / 15)) > 0 and var_682_3 < var_682_7 then
					arg_679_1.talkMaxDuration = var_682_7

					if var_682_7 + var_682_2 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_7 + var_682_2
					end
				end

				arg_679_1.text_.text = var_682_5
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb") ~= 0 then
					local var_682_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb") / 1000

					if var_682_8 + var_682_2 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_8 + var_682_2
					end

					if var_682_4.prefab_name ~= "" and arg_679_1.actors_[var_682_4.prefab_name] ~= nil then
						local var_682_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_4.prefab_name].transform, "story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb")

						arg_679_1:RecordAudio("924011163", var_682_9)
						arg_679_1:RecordAudio("924011163", var_682_9)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011163", "story_v_side_old_924011.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_10 = math.max(var_682_3, arg_679_1.talkMaxDuration)

			if var_682_2 <= arg_679_1.time_ and arg_679_1.time_ < var_682_2 + var_682_10 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_2) / var_682_10

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_2 + var_682_10 and arg_679_1.time_ < var_682_2 + var_682_10 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play924011164 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 924011164
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play924011165(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(arg_683_1.actors_["1033ui_story"]) and arg_683_1.var_.characterEffect1033ui_story == nil then
				arg_683_1.var_.characterEffect1033ui_story = arg_683_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_0 = 0.200000002980232

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 and not isNil(arg_683_1.actors_["1033ui_story"]) then
				if arg_683_1.var_.characterEffect1033ui_story and not isNil(arg_683_1.actors_["1033ui_story"]) then
					arg_683_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_683_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_683_1.time_ - 0) / var_686_0)
				end
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 and not isNil(arg_683_1.actors_["1033ui_story"]) and arg_683_1.var_.characterEffect1033ui_story then
				arg_683_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_683_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_686_1 = 0
			local var_686_2 = 0.25

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_3 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(924011164).content)

				arg_683_1.text_.text = var_686_3

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_5 = 10 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_3) / 10)

				if (10 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_3) / 10)) > 0 and var_686_2 < var_686_5 then
					arg_683_1.talkMaxDuration = var_686_5

					if var_686_5 + var_686_1 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_5 + var_686_1
					end
				end

				arg_683_1.text_.text = var_686_3
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_6 = math.max(var_686_2, arg_683_1.talkMaxDuration)

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_6 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_1) / var_686_6

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_1 + var_686_6 and arg_683_1.time_ < var_686_1 + var_686_6 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play924011165 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 924011165
		arg_687_1.duration_ = 17.17

		local var_687_0 = {
			zh = 8.966,
			ja = 17.166
		}
		local var_687_1 = manager.audio:GetLocalizationFlag()

		if var_687_0[var_687_1] ~= nil then
			arg_687_1.duration_ = var_687_0[var_687_1]
		end

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play924011166(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(arg_687_1.actors_["1033ui_story"]) and arg_687_1.var_.characterEffect1033ui_story == nil then
				arg_687_1.var_.characterEffect1033ui_story = arg_687_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_0 = 0.200000002980232

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 and not isNil(arg_687_1.actors_["1033ui_story"]) then
				if arg_687_1.var_.characterEffect1033ui_story and not isNil(arg_687_1.actors_["1033ui_story"]) then
					arg_687_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 and not isNil(arg_687_1.actors_["1033ui_story"]) and arg_687_1.var_.characterEffect1033ui_story then
				arg_687_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_690_2 = 0
			local var_690_3 = 1.1

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_2 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_4 = arg_687_1:GetWordFromCfg(924011165)
				local var_690_5 = arg_687_1:FormatText(var_690_4.content)

				arg_687_1.text_.text = var_690_5

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_7 = 44 <= 0 and var_690_3 or var_690_3 * (utf8.len(var_690_5) / 44)

				if (44 <= 0 and var_690_3 or var_690_3 * (utf8.len(var_690_5) / 44)) > 0 and var_690_3 < var_690_7 then
					arg_687_1.talkMaxDuration = var_690_7

					if var_690_7 + var_690_2 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_7 + var_690_2
					end
				end

				arg_687_1.text_.text = var_690_5
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb") ~= 0 then
					local var_690_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb") / 1000

					if var_690_8 + var_690_2 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_8 + var_690_2
					end

					if var_690_4.prefab_name ~= "" and arg_687_1.actors_[var_690_4.prefab_name] ~= nil then
						local var_690_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_4.prefab_name].transform, "story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb")

						arg_687_1:RecordAudio("924011165", var_690_9)
						arg_687_1:RecordAudio("924011165", var_690_9)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011165", "story_v_side_old_924011.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_10 = math.max(var_690_3, arg_687_1.talkMaxDuration)

			if var_690_2 <= arg_687_1.time_ and arg_687_1.time_ < var_690_2 + var_690_10 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_2) / var_690_10

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_2 + var_690_10 and arg_687_1.time_ < var_690_2 + var_690_10 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play924011166 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 924011166
		arg_691_1.duration_ = 12.07

		local var_691_0 = {
			zh = 9.7,
			ja = 12.066
		}
		local var_691_1 = manager.audio:GetLocalizationFlag()

		if var_691_0[var_691_1] ~= nil then
			arg_691_1.duration_ = var_691_0[var_691_1]
		end

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play924011167(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action423")
			end

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_694_0 = 0
			local var_694_1 = 1.175

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_2 = arg_691_1:GetWordFromCfg(924011166)
				local var_694_3 = arg_691_1:FormatText(var_694_2.content)

				arg_691_1.text_.text = var_694_3

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_5 = 47 <= 0 and var_694_1 or var_694_1 * (utf8.len(var_694_3) / 47)

				if (47 <= 0 and var_694_1 or var_694_1 * (utf8.len(var_694_3) / 47)) > 0 and var_694_1 < var_694_5 then
					arg_691_1.talkMaxDuration = var_694_5

					if var_694_5 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_5 + var_694_0
					end
				end

				arg_691_1.text_.text = var_694_3
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb") ~= 0 then
					local var_694_6 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb") / 1000

					if var_694_6 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_6 + var_694_0
					end

					if var_694_2.prefab_name ~= "" and arg_691_1.actors_[var_694_2.prefab_name] ~= nil then
						local var_694_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_2.prefab_name].transform, "story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb")

						arg_691_1:RecordAudio("924011166", var_694_7)
						arg_691_1:RecordAudio("924011166", var_694_7)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011166", "story_v_side_old_924011.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_8 = math.max(var_694_1, arg_691_1.talkMaxDuration)

			if var_694_0 <= arg_691_1.time_ and arg_691_1.time_ < var_694_0 + var_694_8 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_0) / var_694_8

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_0 + var_694_8 and arg_691_1.time_ < var_694_0 + var_694_8 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play924011167 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 924011167
		arg_695_1.duration_ = 8.7

		local var_695_0 = {
			zh = 7.033,
			ja = 8.7
		}
		local var_695_1 = manager.audio:GetLocalizationFlag()

		if var_695_0[var_695_1] ~= nil then
			arg_695_1.duration_ = var_695_0[var_695_1]
		end

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play924011168(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.var_.moveOldPos1020ui_story = arg_695_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_698_0 = 0.001

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_0 then
				arg_695_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_695_1.time_ - 0) / var_698_0)
				arg_695_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_695_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_695_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_695_1.actors_["1020ui_story"].transform.position).z)
				arg_695_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_695_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_695_1.actors_["1020ui_story"].transform.localEulerAngles = arg_695_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_695_1.time_ >= 0 + var_698_0 and arg_695_1.time_ < 0 + var_698_0 + arg_698_0 then
				arg_695_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0.7, -0.85, -6.25)
				arg_695_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_695_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_695_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_695_1.actors_["1020ui_story"].transform.position).z)
				arg_695_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_695_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_695_1.actors_["1020ui_story"].transform.localEulerAngles = arg_695_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_698_1 = arg_695_1.actors_["1033ui_story"].transform

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.var_.moveOldPos1033ui_story = var_698_1.localPosition
			end

			local var_698_2 = 0.001

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_2 then
				var_698_1.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_695_1.time_ - 0) / var_698_2)
				var_698_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_698_1.position).x, (manager.ui.mainCamera.transform.position - var_698_1.position).y, (manager.ui.mainCamera.transform.position - var_698_1.position).z)
				var_698_1.localEulerAngles.z = 0
				var_698_1.localEulerAngles.x = 0
				var_698_1.localEulerAngles = var_698_1.localEulerAngles
			end

			if arg_695_1.time_ >= 0 + var_698_2 and arg_695_1.time_ < 0 + var_698_2 + arg_698_0 then
				var_698_1.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				var_698_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_698_1.position).x, (manager.ui.mainCamera.transform.position - var_698_1.position).y, (manager.ui.mainCamera.transform.position - var_698_1.position).z)
				var_698_1.localEulerAngles.z = 0
				var_698_1.localEulerAngles.x = 0
				var_698_1.localEulerAngles = var_698_1.localEulerAngles
			end

			local var_698_3 = arg_695_1.actors_["1020ui_story"]

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(var_698_3) and arg_695_1.var_.characterEffect1020ui_story == nil then
				arg_695_1.var_.characterEffect1020ui_story = var_698_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_4 = 0.200000002980232

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_4 and not isNil(var_698_3) then
				if arg_695_1.var_.characterEffect1020ui_story and not isNil(var_698_3) then
					arg_695_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_695_1.time_ >= 0 + var_698_4 and arg_695_1.time_ < 0 + var_698_4 + arg_698_0 and not isNil(var_698_3) and arg_695_1.var_.characterEffect1020ui_story then
				arg_695_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_698_6 = arg_695_1.actors_["1033ui_story"]

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(var_698_6) and arg_695_1.var_.characterEffect1033ui_story == nil then
				arg_695_1.var_.characterEffect1033ui_story = var_698_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_7 = 0.200000002980232

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_7 and not isNil(var_698_6) then
				if arg_695_1.var_.characterEffect1033ui_story and not isNil(var_698_6) then
					arg_695_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_695_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_695_1.time_ - 0) / var_698_7)
				end
			end

			if arg_695_1.time_ >= 0 + var_698_7 and arg_695_1.time_ < 0 + var_698_7 + arg_698_0 and not isNil(var_698_6) and arg_695_1.var_.characterEffect1033ui_story then
				arg_695_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_695_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_698_8 = 0
			local var_698_9 = 0.9

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_8 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_10 = arg_695_1:GetWordFromCfg(924011167)
				local var_698_11 = arg_695_1:FormatText(var_698_10.content)

				arg_695_1.text_.text = var_698_11

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_13 = 36 <= 0 and var_698_9 or var_698_9 * (utf8.len(var_698_11) / 36)

				if (36 <= 0 and var_698_9 or var_698_9 * (utf8.len(var_698_11) / 36)) > 0 and var_698_9 < var_698_13 then
					arg_695_1.talkMaxDuration = var_698_13

					if var_698_13 + var_698_8 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_13 + var_698_8
					end
				end

				arg_695_1.text_.text = var_698_11
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb") ~= 0 then
					local var_698_14 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb") / 1000

					if var_698_14 + var_698_8 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_14 + var_698_8
					end

					if var_698_10.prefab_name ~= "" and arg_695_1.actors_[var_698_10.prefab_name] ~= nil then
						local var_698_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_10.prefab_name].transform, "story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb")

						arg_695_1:RecordAudio("924011167", var_698_15)
						arg_695_1:RecordAudio("924011167", var_698_15)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011167", "story_v_side_old_924011.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_16 = math.max(var_698_9, arg_695_1.talkMaxDuration)

			if var_698_8 <= arg_695_1.time_ and arg_695_1.time_ < var_698_8 + var_698_16 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_8) / var_698_16

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_8 + var_698_16 and arg_695_1.time_ < var_698_8 + var_698_16 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_695_1:InitPlayNodeList()
	end,
	Play924011168 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 924011168
		arg_699_1.duration_ = 3.7

		local var_699_0 = {
			zh = 2.633,
			ja = 3.7
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play924011169(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_702_0 = 0
			local var_702_1 = 0.25

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_0 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_2 = arg_699_1:GetWordFromCfg(924011168)
				local var_702_3 = arg_699_1:FormatText(var_702_2.content)

				arg_699_1.text_.text = var_702_3

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_5 = 10 <= 0 and var_702_1 or var_702_1 * (utf8.len(var_702_3) / 10)

				if (10 <= 0 and var_702_1 or var_702_1 * (utf8.len(var_702_3) / 10)) > 0 and var_702_1 < var_702_5 then
					arg_699_1.talkMaxDuration = var_702_5

					if var_702_5 + var_702_0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_5 + var_702_0
					end
				end

				arg_699_1.text_.text = var_702_3
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb") ~= 0 then
					local var_702_6 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb") / 1000

					if var_702_6 + var_702_0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_6 + var_702_0
					end

					if var_702_2.prefab_name ~= "" and arg_699_1.actors_[var_702_2.prefab_name] ~= nil then
						local var_702_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_2.prefab_name].transform, "story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb")

						arg_699_1:RecordAudio("924011168", var_702_7)
						arg_699_1:RecordAudio("924011168", var_702_7)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011168", "story_v_side_old_924011.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_8 = math.max(var_702_1, arg_699_1.talkMaxDuration)

			if var_702_0 <= arg_699_1.time_ and arg_699_1.time_ < var_702_0 + var_702_8 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_0) / var_702_8

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_0 + var_702_8 and arg_699_1.time_ < var_702_0 + var_702_8 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play924011169 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 924011169
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play924011170(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(arg_703_1.actors_["1020ui_story"]) and arg_703_1.var_.characterEffect1020ui_story == nil then
				arg_703_1.var_.characterEffect1020ui_story = arg_703_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_0 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 and not isNil(arg_703_1.actors_["1020ui_story"]) then
				if arg_703_1.var_.characterEffect1020ui_story and not isNil(arg_703_1.actors_["1020ui_story"]) then
					arg_703_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_703_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_703_1.time_ - 0) / var_706_0)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 and not isNil(arg_703_1.actors_["1020ui_story"]) and arg_703_1.var_.characterEffect1020ui_story then
				arg_703_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_703_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_706_1 = 0
			local var_706_2 = 0.375

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_3 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(924011169).content)

				arg_703_1.text_.text = var_706_3

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_5 = 15 <= 0 and var_706_2 or var_706_2 * (utf8.len(var_706_3) / 15)

				if (15 <= 0 and var_706_2 or var_706_2 * (utf8.len(var_706_3) / 15)) > 0 and var_706_2 < var_706_5 then
					arg_703_1.talkMaxDuration = var_706_5

					if var_706_5 + var_706_1 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_5 + var_706_1
					end
				end

				arg_703_1.text_.text = var_706_3
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_6 = math.max(var_706_2, arg_703_1.talkMaxDuration)

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_6 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_1) / var_706_6

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_1 + var_706_6 and arg_703_1.time_ < var_706_1 + var_706_6 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play924011170 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 924011170
		arg_707_1.duration_ = 14.5

		local var_707_0 = {
			zh = 10.7,
			ja = 14.5
		}
		local var_707_1 = manager.audio:GetLocalizationFlag()

		if var_707_0[var_707_1] ~= nil then
			arg_707_1.duration_ = var_707_0[var_707_1]
		end

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play924011171(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 and not isNil(arg_707_1.actors_["1033ui_story"]) and arg_707_1.var_.characterEffect1033ui_story == nil then
				arg_707_1.var_.characterEffect1033ui_story = arg_707_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_0 = 0.200000002980232

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_0 and not isNil(arg_707_1.actors_["1033ui_story"]) then
				if arg_707_1.var_.characterEffect1033ui_story and not isNil(arg_707_1.actors_["1033ui_story"]) then
					arg_707_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_707_1.time_ >= 0 + var_710_0 and arg_707_1.time_ < 0 + var_710_0 + arg_710_0 and not isNil(arg_707_1.actors_["1033ui_story"]) and arg_707_1.var_.characterEffect1033ui_story then
				arg_707_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_710_2 = 0
			local var_710_3 = 1.375

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_2 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_4 = arg_707_1:GetWordFromCfg(924011170)
				local var_710_5 = arg_707_1:FormatText(var_710_4.content)

				arg_707_1.text_.text = var_710_5

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_7 = 55 <= 0 and var_710_3 or var_710_3 * (utf8.len(var_710_5) / 55)

				if (55 <= 0 and var_710_3 or var_710_3 * (utf8.len(var_710_5) / 55)) > 0 and var_710_3 < var_710_7 then
					arg_707_1.talkMaxDuration = var_710_7

					if var_710_7 + var_710_2 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_7 + var_710_2
					end
				end

				arg_707_1.text_.text = var_710_5
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb") ~= 0 then
					local var_710_8 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb") / 1000

					if var_710_8 + var_710_2 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_8 + var_710_2
					end

					if var_710_4.prefab_name ~= "" and arg_707_1.actors_[var_710_4.prefab_name] ~= nil then
						local var_710_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_4.prefab_name].transform, "story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb")

						arg_707_1:RecordAudio("924011170", var_710_9)
						arg_707_1:RecordAudio("924011170", var_710_9)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011170", "story_v_side_old_924011.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_10 = math.max(var_710_3, arg_707_1.talkMaxDuration)

			if var_710_2 <= arg_707_1.time_ and arg_707_1.time_ < var_710_2 + var_710_10 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_2) / var_710_10

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_2 + var_710_10 and arg_707_1.time_ < var_710_2 + var_710_10 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play924011171 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 924011171
		arg_711_1.duration_ = 18.53

		local var_711_0 = {
			zh = 10.9,
			ja = 18.533
		}
		local var_711_1 = manager.audio:GetLocalizationFlag()

		if var_711_0[var_711_1] ~= nil then
			arg_711_1.duration_ = var_711_0[var_711_1]
		end

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play924011172(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 1.45

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_1 = arg_711_1:GetWordFromCfg(924011171)
				local var_714_2 = arg_711_1:FormatText(var_714_1.content)

				arg_711_1.text_.text = var_714_2

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_4 = 58 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_2) / 58)

				if (58 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_2) / 58)) > 0 and var_714_0 < var_714_4 then
					arg_711_1.talkMaxDuration = var_714_4

					if var_714_4 + 0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_4 + 0
					end
				end

				arg_711_1.text_.text = var_714_2
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb") ~= 0 then
					local var_714_5 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb") / 1000

					if var_714_5 + 0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_5 + 0
					end

					if var_714_1.prefab_name ~= "" and arg_711_1.actors_[var_714_1.prefab_name] ~= nil then
						local var_714_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_1.prefab_name].transform, "story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb")

						arg_711_1:RecordAudio("924011171", var_714_6)
						arg_711_1:RecordAudio("924011171", var_714_6)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011171", "story_v_side_old_924011.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_7 = math.max(var_714_0, arg_711_1.talkMaxDuration)

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_7 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - 0) / var_714_7

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= 0 + var_714_7 and arg_711_1.time_ < 0 + var_714_7 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play924011172 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 924011172
		arg_715_1.duration_ = 5.27

		local var_715_0 = {
			zh = 4.4,
			ja = 5.266
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play924011173(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.var_.moveOldPos1020ui_story = arg_715_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_718_0 = 0.001

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_0 then
				arg_715_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_715_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_715_1.time_ - 0) / var_718_0)
				arg_715_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_715_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["1020ui_story"].transform.position).z)
				arg_715_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_715_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_715_1.actors_["1020ui_story"].transform.localEulerAngles = arg_715_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_715_1.time_ >= 0 + var_718_0 and arg_715_1.time_ < 0 + var_718_0 + arg_718_0 then
				arg_715_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0.7, -0.85, -6.25)
				arg_715_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_715_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_715_1.actors_["1020ui_story"].transform.position).z)
				arg_715_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_715_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_715_1.actors_["1020ui_story"].transform.localEulerAngles = arg_715_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_718_1 = arg_715_1.actors_["1020ui_story"]

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(var_718_1) and arg_715_1.var_.characterEffect1020ui_story == nil then
				arg_715_1.var_.characterEffect1020ui_story = var_718_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_2 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_2 and not isNil(var_718_1) then
				if arg_715_1.var_.characterEffect1020ui_story and not isNil(var_718_1) then
					arg_715_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_715_1.time_ >= 0 + var_718_2 and arg_715_1.time_ < 0 + var_718_2 + arg_718_0 and not isNil(var_718_1) and arg_715_1.var_.characterEffect1020ui_story then
				arg_715_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_718_4 = arg_715_1.actors_["1033ui_story"]

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(var_718_4) and arg_715_1.var_.characterEffect1033ui_story == nil then
				arg_715_1.var_.characterEffect1033ui_story = var_718_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_5 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_5 and not isNil(var_718_4) then
				if arg_715_1.var_.characterEffect1033ui_story and not isNil(var_718_4) then
					arg_715_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_715_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_715_1.time_ - 0) / var_718_5)
				end
			end

			if arg_715_1.time_ >= 0 + var_718_5 and arg_715_1.time_ < 0 + var_718_5 + arg_718_0 and not isNil(var_718_4) and arg_715_1.var_.characterEffect1033ui_story then
				arg_715_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_715_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action483")
			end

			local var_718_6 = 0
			local var_718_7 = 0.325

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_6 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_8 = arg_715_1:GetWordFromCfg(924011172)
				local var_718_9 = arg_715_1:FormatText(var_718_8.content)

				arg_715_1.text_.text = var_718_9

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_11 = 13 <= 0 and var_718_7 or var_718_7 * (utf8.len(var_718_9) / 13)

				if (13 <= 0 and var_718_7 or var_718_7 * (utf8.len(var_718_9) / 13)) > 0 and var_718_7 < var_718_11 then
					arg_715_1.talkMaxDuration = var_718_11

					if var_718_11 + var_718_6 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_11 + var_718_6
					end
				end

				arg_715_1.text_.text = var_718_9
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb") ~= 0 then
					local var_718_12 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb") / 1000

					if var_718_12 + var_718_6 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_12 + var_718_6
					end

					if var_718_8.prefab_name ~= "" and arg_715_1.actors_[var_718_8.prefab_name] ~= nil then
						local var_718_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_8.prefab_name].transform, "story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb")

						arg_715_1:RecordAudio("924011172", var_718_13)
						arg_715_1:RecordAudio("924011172", var_718_13)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011172", "story_v_side_old_924011.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_14 = math.max(var_718_7, arg_715_1.talkMaxDuration)

			if var_718_6 <= arg_715_1.time_ and arg_715_1.time_ < var_718_6 + var_718_14 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_6) / var_718_14

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_6 + var_718_14 and arg_715_1.time_ < var_718_6 + var_718_14 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_715_1:InitPlayNodeList()
	end,
	Play924011173 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 924011173
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play924011174(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 and not isNil(arg_719_1.actors_["1020ui_story"]) and arg_719_1.var_.characterEffect1020ui_story == nil then
				arg_719_1.var_.characterEffect1020ui_story = arg_719_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_0 = 0.200000002980232

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_0 and not isNil(arg_719_1.actors_["1020ui_story"]) then
				if arg_719_1.var_.characterEffect1020ui_story and not isNil(arg_719_1.actors_["1020ui_story"]) then
					arg_719_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_719_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_719_1.time_ - 0) / var_722_0)
				end
			end

			if arg_719_1.time_ >= 0 + var_722_0 and arg_719_1.time_ < 0 + var_722_0 + arg_722_0 and not isNil(arg_719_1.actors_["1020ui_story"]) and arg_719_1.var_.characterEffect1020ui_story then
				arg_719_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_719_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_722_1 = 0
			local var_722_2 = 0.1

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_1 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, true)
				arg_719_1.iconController_:SetSelectedState("hero")

				arg_719_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_719_1.callingController_:SetSelectedState("normal")

				arg_719_1.keyicon_.color = Color.New(1, 1, 1)
				arg_719_1.icon_.color = Color.New(1, 1, 1)

				local var_722_3 = arg_719_1:FormatText(arg_719_1:GetWordFromCfg(924011173).content)

				arg_719_1.text_.text = var_722_3

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_5 = 4 <= 0 and var_722_2 or var_722_2 * (utf8.len(var_722_3) / 4)

				if (4 <= 0 and var_722_2 or var_722_2 * (utf8.len(var_722_3) / 4)) > 0 and var_722_2 < var_722_5 then
					arg_719_1.talkMaxDuration = var_722_5

					if var_722_5 + var_722_1 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_5 + var_722_1
					end
				end

				arg_719_1.text_.text = var_722_3
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_6 = math.max(var_722_2, arg_719_1.talkMaxDuration)

			if var_722_1 <= arg_719_1.time_ and arg_719_1.time_ < var_722_1 + var_722_6 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_1) / var_722_6

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_1 + var_722_6 and arg_719_1.time_ < var_722_1 + var_722_6 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play924011174 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 924011174
		arg_723_1.duration_ = 6.67

		local var_723_0 = {
			zh = 4.2,
			ja = 6.666
		}
		local var_723_1 = manager.audio:GetLocalizationFlag()

		if var_723_0[var_723_1] ~= nil then
			arg_723_1.duration_ = var_723_0[var_723_1]
		end

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play924011175(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1.var_.moveOldPos1020ui_story = arg_723_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_726_0 = 0.001

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_0 then
				arg_723_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_723_1.time_ - 0) / var_726_0)
				arg_723_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_723_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1020ui_story"].transform.position).z)
				arg_723_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_723_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_723_1.actors_["1020ui_story"].transform.localEulerAngles = arg_723_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_723_1.time_ >= 0 + var_726_0 and arg_723_1.time_ < 0 + var_726_0 + arg_726_0 then
				arg_723_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0.7, -0.85, -6.25)
				arg_723_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_723_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_723_1.actors_["1020ui_story"].transform.position).z)
				arg_723_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_723_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_723_1.actors_["1020ui_story"].transform.localEulerAngles = arg_723_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_726_1 = arg_723_1.actors_["1020ui_story"]

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 and not isNil(var_726_1) and arg_723_1.var_.characterEffect1020ui_story == nil then
				arg_723_1.var_.characterEffect1020ui_story = var_726_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_2 = 0.200000002980232

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_2 and not isNil(var_726_1) then
				if arg_723_1.var_.characterEffect1020ui_story and not isNil(var_726_1) then
					arg_723_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_723_1.time_ >= 0 + var_726_2 and arg_723_1.time_ < 0 + var_726_2 + arg_726_0 and not isNil(var_726_1) and arg_723_1.var_.characterEffect1020ui_story then
				arg_723_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_726_4 = 0
			local var_726_5 = 0.4

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_4 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				arg_723_1.leftNameTxt_.text = arg_723_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_6 = arg_723_1:GetWordFromCfg(924011174)
				local var_726_7 = arg_723_1:FormatText(var_726_6.content)

				arg_723_1.text_.text = var_726_7

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_9 = 16 <= 0 and var_726_5 or var_726_5 * (utf8.len(var_726_7) / 16)

				if (16 <= 0 and var_726_5 or var_726_5 * (utf8.len(var_726_7) / 16)) > 0 and var_726_5 < var_726_9 then
					arg_723_1.talkMaxDuration = var_726_9

					if var_726_9 + var_726_4 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_9 + var_726_4
					end
				end

				arg_723_1.text_.text = var_726_7
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb") ~= 0 then
					local var_726_10 = manager.audio:GetVoiceLength("story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb") / 1000

					if var_726_10 + var_726_4 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_10 + var_726_4
					end

					if var_726_6.prefab_name ~= "" and arg_723_1.actors_[var_726_6.prefab_name] ~= nil then
						local var_726_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_6.prefab_name].transform, "story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb")

						arg_723_1:RecordAudio("924011174", var_726_11)
						arg_723_1:RecordAudio("924011174", var_726_11)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_side_old_924011", "924011174", "story_v_side_old_924011.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_12 = math.max(var_726_5, arg_723_1.talkMaxDuration)

			if var_726_4 <= arg_723_1.time_ and arg_723_1.time_ < var_726_4 + var_726_12 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_4) / var_726_12

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_4 + var_726_12 and arg_723_1.time_ < var_726_4 + var_726_12 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_723_1:InitPlayNodeList()
	end,
	Play924011175 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 924011175
		arg_727_1.duration_ = 10.8

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play924011176(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			if arg_727_1.bgs_.STblack == nil then
				local var_730_0 = Object.Instantiate(arg_727_1.paintGo_)

				var_730_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_730_0.name = "STblack"
				var_730_0.transform.parent = arg_727_1.stage_.transform
				var_730_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_727_1.bgs_.STblack = var_730_0
			end

			if 3 < arg_727_1.time_ and arg_727_1.time_ <= 3 + arg_730_0 then
				local var_730_1 = arg_727_1.bgs_.STblack

				arg_727_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_730_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_730_2 = var_730_1:GetComponent("SpriteRenderer")

				if var_730_2 and var_730_2.sprite then
					local var_730_3 = 2 * (var_730_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_730_1.transform.localScale = Vector3.New(var_730_3 / var_730_2.sprite.bounds.size.y < var_730_3 * manager.ui.mainCameraCom_.aspect / var_730_2.sprite.bounds.size.x and var_730_3 * manager.ui.mainCameraCom_.aspect / var_730_2.sprite.bounds.size.x or var_730_3 / var_730_2.sprite.bounds.size.y, var_730_3 / var_730_2.sprite.bounds.size.y < var_730_3 * manager.ui.mainCameraCom_.aspect / var_730_2.sprite.bounds.size.x and var_730_3 * manager.ui.mainCameraCom_.aspect / var_730_2.sprite.bounds.size.x or var_730_3 / var_730_2.sprite.bounds.size.y, 0)
				end

				for iter_730_0, iter_730_1 in pairs(arg_727_1.bgs_) do
					if iter_730_0 ~= "STblack" then
						iter_730_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_730_4 = 5.999999999999

			if 5.999999999999 < arg_727_1.time_ and arg_727_1.time_ <= var_730_4 + arg_730_0 then
				arg_727_1.allBtn_.enabled = false
			end

			if arg_727_1.time_ >= var_730_4 + 0.3 and arg_727_1.time_ < var_730_4 + 0.3 + arg_730_0 then
				arg_727_1.allBtn_.enabled = true
			end

			local var_730_5 = 0

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_5 + arg_730_0 then
				arg_727_1.mask_.enabled = true
				arg_727_1.mask_.raycastTarget = true

				arg_727_1:SetGaussion(false)
			end

			local var_730_6 = 3

			if var_730_5 <= arg_727_1.time_ and arg_727_1.time_ < var_730_5 + var_730_6 then
				local var_730_7 = Color.New(0, 0, 0)

				var_730_7.a = Mathf.Lerp(0, 1, (arg_727_1.time_ - var_730_5) / var_730_6)
				arg_727_1.mask_.color = var_730_7
			end

			if arg_727_1.time_ >= var_730_5 + var_730_6 and arg_727_1.time_ < var_730_5 + var_730_6 + arg_730_0 then
				local var_730_8 = Color.New(0, 0, 0)

				var_730_8.a = 1
				arg_727_1.mask_.color = var_730_8
			end

			local var_730_9 = 3

			if 3 < arg_727_1.time_ and arg_727_1.time_ <= var_730_9 + arg_730_0 then
				arg_727_1.mask_.enabled = true
				arg_727_1.mask_.raycastTarget = true

				arg_727_1:SetGaussion(false)
			end

			local var_730_10 = 3

			if var_730_9 <= arg_727_1.time_ and arg_727_1.time_ < var_730_9 + var_730_10 then
				local var_730_11 = Color.New(0, 0, 0)

				var_730_11.a = Mathf.Lerp(1, 0, (arg_727_1.time_ - var_730_9) / var_730_10)
				arg_727_1.mask_.color = var_730_11
			end

			if arg_727_1.time_ >= var_730_9 + var_730_10 and arg_727_1.time_ < var_730_9 + var_730_10 + arg_730_0 then
				local var_730_12 = Color.New(0, 0, 0)

				arg_727_1.mask_.enabled = false
				var_730_12.a = 0
				arg_727_1.mask_.color = var_730_12
			end

			local var_730_13 = arg_727_1.actors_["1020ui_story"].transform

			if 2.96599999815226 < arg_727_1.time_ and arg_727_1.time_ <= 2.96599999815226 + arg_730_0 then
				arg_727_1.var_.moveOldPos1020ui_story = var_730_13.localPosition
			end

			local var_730_14 = 0.001

			if 2.96599999815226 <= arg_727_1.time_ and arg_727_1.time_ < 2.96599999815226 + var_730_14 then
				var_730_13.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_727_1.time_ - 2.96599999815226) / var_730_14)
				var_730_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_13.position).x, (manager.ui.mainCamera.transform.position - var_730_13.position).y, (manager.ui.mainCamera.transform.position - var_730_13.position).z)
				var_730_13.localEulerAngles.z = 0
				var_730_13.localEulerAngles.x = 0
				var_730_13.localEulerAngles = var_730_13.localEulerAngles
			end

			if arg_727_1.time_ >= 2.96599999815226 + var_730_14 and arg_727_1.time_ < 2.96599999815226 + var_730_14 + arg_730_0 then
				var_730_13.localPosition = Vector3.New(0, 100, 0)
				var_730_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_13.position).x, (manager.ui.mainCamera.transform.position - var_730_13.position).y, (manager.ui.mainCamera.transform.position - var_730_13.position).z)
				var_730_13.localEulerAngles.z = 0
				var_730_13.localEulerAngles.x = 0
				var_730_13.localEulerAngles = var_730_13.localEulerAngles
			end

			local var_730_15 = arg_727_1.actors_["1033ui_story"].transform

			if 2.96599999815226 < arg_727_1.time_ and arg_727_1.time_ <= 2.96599999815226 + arg_730_0 then
				arg_727_1.var_.moveOldPos1033ui_story = var_730_15.localPosition
			end

			local var_730_16 = 0.001

			if 2.96599999815226 <= arg_727_1.time_ and arg_727_1.time_ < 2.96599999815226 + var_730_16 then
				var_730_15.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_727_1.time_ - 2.96599999815226) / var_730_16)
				var_730_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_15.position).x, (manager.ui.mainCamera.transform.position - var_730_15.position).y, (manager.ui.mainCamera.transform.position - var_730_15.position).z)
				var_730_15.localEulerAngles.z = 0
				var_730_15.localEulerAngles.x = 0
				var_730_15.localEulerAngles = var_730_15.localEulerAngles
			end

			if arg_727_1.time_ >= 2.96599999815226 + var_730_16 and arg_727_1.time_ < 2.96599999815226 + var_730_16 + arg_730_0 then
				var_730_15.localPosition = Vector3.New(0, 100, 0)
				var_730_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_730_15.position).x, (manager.ui.mainCamera.transform.position - var_730_15.position).y, (manager.ui.mainCamera.transform.position - var_730_15.position).z)
				var_730_15.localEulerAngles.z = 0
				var_730_15.localEulerAngles.x = 0
				var_730_15.localEulerAngles = var_730_15.localEulerAngles
			end

			local var_730_17 = arg_727_1.actors_["1020ui_story"]

			if 2.96599999815226 < arg_727_1.time_ and arg_727_1.time_ <= 2.96599999815226 + arg_730_0 and not isNil(var_730_17) and arg_727_1.var_.characterEffect1020ui_story == nil then
				arg_727_1.var_.characterEffect1020ui_story = var_730_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_18 = 0.034000001847744

			if 2.96599999815226 <= arg_727_1.time_ and arg_727_1.time_ < 2.96599999815226 + var_730_18 and not isNil(var_730_17) then
				if arg_727_1.var_.characterEffect1020ui_story and not isNil(var_730_17) then
					arg_727_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_727_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_727_1.time_ - 2.96599999815226) / var_730_18)
				end
			end

			if arg_727_1.time_ >= 2.96599999815226 + var_730_18 and arg_727_1.time_ < 2.96599999815226 + var_730_18 + arg_730_0 and not isNil(var_730_17) and arg_727_1.var_.characterEffect1020ui_story then
				arg_727_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_727_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if arg_727_1.frameCnt_ <= 1 then
				arg_727_1.dialog_:SetActive(false)
			end

			local var_730_19 = 5.8
			local var_730_20 = 1.075

			if 5.8 < arg_727_1.time_ and arg_727_1.time_ <= var_730_19 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0

				arg_727_1.dialog_:SetActive(true)

				arg_727_1.dialogCg_.alpha = 0

				local var_730_21 = LeanTween.value(arg_727_1.dialog_, 0, 1, 0.3)

				var_730_21:setOnUpdate(LuaHelper.FloatAction(function(arg_731_0)
					arg_727_1.dialogCg_.alpha = arg_731_0
				end))
				var_730_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_727_1.dialog_)
					var_730_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_727_1.duration_ = arg_727_1.duration_ + 0.3

				SetActive(arg_727_1.leftNameGo_, false)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_22 = arg_727_1:FormatText(arg_727_1:GetWordFromCfg(924011175).content)

				arg_727_1.text_.text = var_730_22

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_24 = 43 <= 0 and var_730_20 or var_730_20 * (utf8.len(var_730_22) / 43)

				if (43 <= 0 and var_730_20 or var_730_20 * (utf8.len(var_730_22) / 43)) > 0 and var_730_20 < var_730_24 then
					arg_727_1.talkMaxDuration = var_730_24
					var_730_19 = var_730_19 + 0.3

					if var_730_24 + var_730_19 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_24 + var_730_19
					end
				end

				arg_727_1.text_.text = var_730_22
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_25 = var_730_19 + 0.3
			local var_730_26 = math.max(var_730_20, arg_727_1.talkMaxDuration)

			if var_730_19 + 0.3 <= arg_727_1.time_ and arg_727_1.time_ < var_730_25 + var_730_26 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_25) / var_730_26

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_25 + var_730_26 and arg_727_1.time_ < var_730_25 + var_730_26 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play924011176 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 924011176
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
			arg_733_1.auto_ = false
		end

		function arg_733_1.playNext_(arg_735_0)
			arg_733_1.onStoryFinished_()
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			if 5.55111512312578e-17 < arg_733_1.time_ and arg_733_1.time_ <= 5.55111512312578e-17 + arg_736_0 then
				arg_733_1:AudioAction("play", "effect", "se_story_140", "se_story_140_tinnitus", "")
			end

			if 5.55111512312578e-17 < arg_733_1.time_ and arg_733_1.time_ <= 5.55111512312578e-17 + arg_736_0 then
				arg_733_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum03", "")
			end

			local var_736_2 = 0
			local var_736_3 = 0.675

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_2 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, false)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_4 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(924011176).content)

				arg_733_1.text_.text = var_736_4

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_6 = 27 <= 0 and var_736_3 or var_736_3 * (utf8.len(var_736_4) / 27)

				if (27 <= 0 and var_736_3 or var_736_3 * (utf8.len(var_736_4) / 27)) > 0 and var_736_3 < var_736_6 then
					arg_733_1.talkMaxDuration = var_736_6

					if var_736_6 + var_736_2 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_6 + var_736_2
					end
				end

				arg_733_1.text_.text = var_736_4
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_7 = math.max(var_736_3, arg_733_1.talkMaxDuration)

			if var_736_2 <= arg_733_1.time_ and arg_733_1.time_ < var_736_2 + var_736_7 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_2) / var_736_7

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_2 + var_736_7 and arg_733_1.time_ < var_736_2 + var_736_7 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/ST2201",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_old_924011.awb"
	}
}
